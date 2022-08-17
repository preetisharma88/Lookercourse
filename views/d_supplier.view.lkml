view: d_supplier {
  sql_table_name: "DATA_MART"."D_SUPPLIER"
    ;;

  dimension: s_acctbal {
    type: number
    sql: ${TABLE}."S_ACCTBAL" ;;
  }

  dimension: s_address {
    type: string
    sql: ${TABLE}."S_ADDRESS" ;;
  }

  dimension: s_name {
    type: string
    sql: ${TABLE}."S_NAME" ;;
  }

  dimension: s_nation {
    type: string
    sql: ${TABLE}."S_NATION" ;;
  }

  dimension: s_phone {
    type: string
    sql: ${TABLE}."S_PHONE" ;;
  }

  dimension: s_region {
    type: string
    sql: ${TABLE}."S_REGION" ;;
  }

  dimension: s_suppkey {
    type: number
    sql: ${TABLE}."S_SUPPKEY" ;;
  }

  dimension: Supplier_Group {
    label: "Cohort of Suppliers"
    description: "Cohort of Suppliers by Account balance"
    type: tier
    style: integer
    tiers: [1,3001,5001,7001]
    sql: ${s_acctbal} ;;
  }

  dimension:Supplier_Links  {
    label: "Google Links of suppliers"
    description: "Google links which lead to supplier webpage"
    type: string
    sql: ${TABLE}."S_NAME" ;;
    link: {
      label: "Google Link"
      url: "http://www.google.com/search?q={{value}}"
      icon_url: "http://www.google.com/favicon.ico"
    }
  }
  measure: count {
    type: count
    drill_fields: [s_name]
  }
}
