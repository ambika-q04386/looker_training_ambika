connection: "qai_de_looker_training_q04386_ambika_vishwakarma"

# include all the views
include: "/views/**/*.view"

datagroup: qp_qai_training_1_2021_05_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: qp_qai_training_1_2021_05_default_datagroup

explore: dialogflow_cleaned_logs {}
