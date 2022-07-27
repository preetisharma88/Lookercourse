view: f_lineitems {
  sql_table_name: "DATA_MART"."F_LINEITEMS"
    ;;

  dimension: l_availqty {
    type: number
    sql: ${TABLE}."L_AVAILQTY" ;;
  }

  dimension: l_clerk {
    type: string
    sql: ${TABLE}."L_CLERK" ;;
  }

  dimension: l_commitdatekey {
    type: number
    sql: ${TABLE}."L_COMMITDATEKEY" ;;
  }

  dimension: l_custkey {
    type: number
    sql: ${TABLE}."L_CUSTKEY" ;;
  }

  dimension: l_discount {
    type: number
    sql: ${TABLE}."L_DISCOUNT" ;;
  }

  dimension: l_extendedprice {
    type: number
    sql: ${TABLE}."L_EXTENDEDPRICE" ;;
  }

  dimension: l_linenumber {
    type: number
    sql: ${TABLE}."L_LINENUMBER" ;;
  }

  dimension: l_orderdatekey {
    type: number
    sql: ${TABLE}."L_ORDERDATEKEY" ;;
  }

  dimension: l_orderkey {
    type: number
    sql: ${TABLE}."L_ORDERKEY" ;;
  }

  dimension: l_orderpriority {
    type: string
    sql: ${TABLE}."L_ORDERPRIORITY" ;;
  }

  dimension: l_orderstatus {
    type: string
    sql: ${TABLE}."L_ORDERSTATUS" ;;
  }

  dimension: l_partkey {
    type: number
    sql: ${TABLE}."L_PARTKEY" ;;
  }

  dimension: l_quantity {
    type: number
    sql: ${TABLE}."L_QUANTITY" ;;
  }

  dimension: l_receiptdatekey {
    type: number
    sql: ${TABLE}."L_RECEIPTDATEKEY" ;;
  }

  dimension: l_returnflag {
    type: string
    sql: ${TABLE}."L_RETURNFLAG" ;;
  }

  dimension: l_shipdatekey {
    type: number
    sql: ${TABLE}."L_SHIPDATEKEY" ;;
  }

  dimension: l_shipinstruct {
    type: string
    sql: ${TABLE}."L_SHIPINSTRUCT" ;;
  }

  dimension: l_shipmode {
    type: string
    sql: ${TABLE}."L_SHIPMODE" ;;
  }

  dimension: l_shippriority {
    type: number
    sql: ${TABLE}."L_SHIPPRIORITY" ;;
  }

  dimension: l_suppkey {
    type: number
    sql: ${TABLE}."L_SUPPKEY" ;;
  }

  dimension: l_supplycost {
    type: number
    sql: ${TABLE}."L_SUPPLYCOST" ;;
  }

  dimension: l_tax {
    type: number
    sql: ${TABLE}."L_TAX" ;;
  }

  dimension: l_totalprice {
    type: number
    sql: ${TABLE}."L_TOTALPRICE" ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
  measure: TotalSalePrice {
    label: "Total Sale Price"
    description: "Total Sale value in USD dollar"
    type: sum
    sql: ${l_extendedprice} ;;
    value_format_name: usd
  }
  measure: Average_sales {
    label: "Average Sale Price"
    description: "Average Sale value in USD dollar"
    type: average
    sql: ${l_extendedprice} ;;
    value_format_name: usd
  }
  measure: Cummulative_sales {
    label: "Cummulative total sales"
    description: "Cummulative Sale value in USD dollar"
    type: running_total
    sql: ${l_extendedprice} ;;
    value_format_name: usd
  }
  measure: SalebyAirmode {
    label: "Sales made from Air Mode"
    description: "Sales made from Air Mode in USD dollar"
    type: sum
    sql: ${l_extendedprice} ;;
    filters: [l_shipmode: "AIR"]
    value_format_name: usd
  }
  measure: SalesbyRussia {
    label: "Sales made by Russia"
    description: "Sales value contributed by Russian cutomers in USD dollar"
    type: sum
    sql: ${l_extendedprice} ;;
    filters: [d_customer.c_nation: "RUSSIA"]
    value_format_name: usd
  }
  measure: Gross_Revenue {
    label: "Total Gross revenue"
    description: "Gross revenue in USD dollar"
    type: sum
    sql: ${l_extendedprice} ;;
    filters: [l_orderstatus: "F"]
    value_format_name: usd
  }
  measure: Total_Cost {
    label: "Total Cost"
    description: "Gross revenue in USD dollar"
    type: sum
    sql: ${l_supplycost} ;;
    value_format_name: usd
  }
  measure: Gross_Margin {
    label: "Total Gross Margin Amount"
    description: "Total Gross Margin Amount in USD dollar"
    type: number
    sql: ${Gross_Revenue}-${Total_Cost} ;;
    value_format_name: usd_0
  }
  measure: margin_percentage {
    label: "Gross Margin Percentage"
    description: "Gross Margin Percentage"
    type: number
    sql: ${Gross_Margin}/NULLIF(${Gross_Revenue},0) ;;
    value_format_name: percent_2
  }
  dimension: is_returned {
    type: yesno
    sql: ${l_returnflag}='R' ;;
  }
  measure: Items_Returned {
    label: "Number of Items Returned"
    description: "Number of Items Returned"
    type: sum
    sql: ${l_quantity} ;;
    filters: [is_returned: "yes"]
  }
  measure: Items_Sold {
    label: "Total Number of Items Sold"
    description: "Total Number of Items Sold"
    type: sum
    sql: ${l_quantity} ;;
    value_format_name: id
  }
  measure: Return_Rate {
    label: "Item Return Rate"
    description: "Item Return Rate"
    sql: ${Items_Returned}/NULLIF(${Items_Sold},0) ;;
    type: number
    value_format_name: percent_2
  }
  measure: Customer_Count {
    label: "Customers Count"
    description: "Distinct count of customers who purchased item"
    sql: ${l_custkey} ;;
    type: count_distinct
  }
  measure: Spend_by_customer {
    label: "Average Spend per Customer"
    description: "Average sales value made by each customer"
    sql: ${TotalSalePrice}/NULLIF(${Customer_Count},0) ;;
    type: number
    value_format_name: usd
  }
  measure: Orders {
    label: "Number of Orders"
    description: "Number of Orders"
    type: count_distinct
    sql: ${l_orderkey};;
  }
}
