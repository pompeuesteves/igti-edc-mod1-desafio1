import sys
from awsglue.transforms import *
from awsglue.utils import getResolvedOptions
from awsglue.context import GlueContext
from awsglue.job import Job
from pyspark.context import SparkContext
from pyspark.sql.types import *
from pyspark.sql.functions import *
from unicodedata import normalize

## @params: [JOB_NAME]
args = getResolvedOptions(sys.argv, ['JOB_NAME'])

sc = SparkContext()
glueContext = GlueContext(sc)
spark = glueContext.spark_session
job = Job(glueContext)
job.init(args['JOB_NAME'], args)


#Ler dados do rais 2020
path = "s3://datalake-igti-edc-raw-zone-713051429766-tf/raw-zone"
rais = (
    spark.read
    .format("csv")
    .option("header", True)
    .option("inferSchema",True)
    .option("encoding", "ISO-8859-1")
    .option("delimiter",";")
    .load(path)
    )

# modificando os nomes das colunas:
for col in rais.dtypes:
    rais = rais.withColumnRenamed(col[0], normalize('NFKD', col[0]).encode('ASCII','ignore').decode('ASCII').replace(" ","_").replace("(","").replace(")","").replace(".","_").replace("/","_").lower() )

# construindo a coluna uf:
rais = rais.withColumn("uf", rais["municipio"][1:2].cast(IntegerType()))

# modificando as colunas de remuneração para tipo double
for col in rais.dtypes:    
    if col[0][0:3] == 'vl_':
        rais = rais.withColumn(col[0], regexp_replace(col[0], ',', '.'))
        rais = rais.withColumn(col[0], rais[col[0]].cast(DoubleType()))

#Salvar dados do rais 2020 formato parquet
path = "s3://datalake-igti-edc-staging-zone-713051429766-tf/consumer-zone"
rais_parquet = (
    rais.write.mode("overwrite").partitionBy("uf").format("parquet").save(path)
    )
    
job.commit()