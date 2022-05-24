view: intent_co_occurence {
derived_table: {
  sql:

with t1 as(
    select session_ID, intent_triggered from `qp-qai-training-1-2021-05.looker_training_ambika.dialogflow_cleaned_logs`),
t2 as (
    select session_ID, intent_triggered  from `qp-qai-training-1-2021-05.looker_training_ambika.dialogflow_cleaned_logs`)
select t1.intent_triggered as parent_intent, t2.intent_triggered as child_intent,count(distinct t2.session_ID) as frequency from t1  join t2 on t1.session_ID=t2.session_ID and t1.intent_triggered != t2.intent_triggered
Group by t1.intent_triggered, t2.intent_triggered  ;;
}


dimension:frequency {
  type: number
  sql: ${TABLE}.frequency ;;
}


dimension: parent_intent {
  type: string
  sql: ${TABLE}.parent_intent ;;
}

  dimension: child_intent {
    type: string
    sql: ${TABLE}.child_intent ;;
  }
  measure:frequency1 {
    type: max
    sql: ${TABLE}.frequency ;;
  }
}
