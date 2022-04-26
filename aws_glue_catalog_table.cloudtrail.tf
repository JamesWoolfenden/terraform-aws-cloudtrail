
resource "aws_glue_catalog_table" "cloudtrail" {
  name          = "cloudtrail_logs_trails_${data.aws_caller_identity.current.account_id}_${var.trail["s3_key_prefix"]}"
  database_name = aws_glue_catalog_database.cloudtrail.name
  owner         = "hadoop"
  parameters = {
    "EXTERNAL"              = "TRUE"
    "classification"        = "cloudtrail"
    "comment"               = "CloudTrail table for ${local.trails_bucket} bucket"
    "transient_lastDdlTime" = "1595852255"
  }

  table_type = "EXTERNAL_TABLE"
  storage_descriptor {
    bucket_columns            = []
    compressed                = false
    input_format              = "com.amazon.emr.cloudtrail.CloudTrailInputFormat"
    location                  = "s3://${local.trails_bucket}/${var.trail["s3_key_prefix"]}/AWSLogs/${data.aws_caller_identity.current.account_id}/CloudTrail"
    number_of_buckets         = -1
    output_format             = "org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat"
    parameters                = {}
    stored_as_sub_directories = false

    columns {
      name = "eventversion"
      type = "string"
    }
    columns {
      name = "useridentity"
      type = "struct<type:string,principalId:string,arn:string,accountId:string,invokedBy:string,accessKeyId:string,userName:string,sessionContext:struct<attributes:struct<mfaAuthenticated:string,creationDate:string>,sessionIssuer:struct<type:string,principalId:string,arn:string,accountId:string,userName:string>>>"
    }
    columns {
      name = "eventtime"
      type = "string"
    }
    columns {
      name = "eventsource"
      type = "string"
    }
    columns {
      name = "eventname"
      type = "string"
    }
    columns {
      name = "awsregion"
      type = "string"
    }
    columns {
      name = "sourceipaddress"
      type = "string"
    }
    columns {
      name = "useragent"
      type = "string"
    }
    columns {
      name = "errorcode"
      type = "string"
    }
    columns {
      name = "errormessage"
      type = "string"
    }
    columns {
      name = "requestparameters"
      type = "string"
    }
    columns {
      name = "responseelements"
      type = "string"
    }
    columns {
      name = "additionaleventdata"
      type = "string"
    }
    columns {
      name = "requestid"
      type = "string"
    }
    columns {
      name = "eventid"
      type = "string"
    }
    columns {
      name = "resources"
      type = "array<struct<arn:string,accountId:string,type:string>>"
    }
    columns {
      name = "eventtype"
      type = "string"
    }
    columns {
      name = "apiversion"
      type = "string"
    }
    columns {
      name = "readonly"
      type = "string"
    }
    columns {
      name = "recipientaccountid"
      type = "string"
    }
    columns {
      name = "serviceeventdetails"
      type = "string"
    }
    columns {
      name = "sharedeventid"
      type = "string"
    }
    columns {
      name = "vpcendpointid"
      type = "string"
    }

    ser_de_info {
      parameters = {
        "serialization.format" = "1"
      }
      serialization_library = "com.amazon.emr.hive.serde.CloudTrailSerde"
    }

    skewed_info {
      skewed_column_names               = []
      skewed_column_value_location_maps = {}
      skewed_column_values              = []
    }
  }
}
