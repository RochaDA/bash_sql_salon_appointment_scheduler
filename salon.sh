#! /bin/bash
PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"
echo -e "\n~~~~~ PYLOON'S SALON ~~~~~\n"
echo -e "Welcome to Pyloon's Salon, how can I help you?\n"

SERVICE_BOOKING(){
  if [[ $1 ]]
  then
    echo -e "\n$1\n"
  fi
  # get available services
  AVAILABLE_SERVICES=$($PSQL "SELECT service_id, name FROM services ORDER BY service_id")
  # display the list of available services
  echo "$AVAILABLE_SERVICES" | while read SERVICE_ID BAR NAME
      do
        echo "$SERVICE_ID) $NAME"
      done
  # request the selected service
  read SERVICE_ID_SELECTED
  # check if it exists in the available services
  RESULT_SERVICE_ID_SELECTED=$($PSQL "SELECT service_id FROM services WHERE service_id = $SERVICE_ID_SELECTED")
  if [[ -z $RESULT_SERVICE_ID_SELECTED ]]
    then
      # if it does not exist
      SERVICE_BOOKING "I could not find that service. What would you like today?"
    else
      # request the customer's phone number
      echo -e "\nWhat's your phone number?"
      read CUSTOMER_PHONE
      # check if the client has been registered before
      CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone = '$CUSTOMER_PHONE'")
      if [[ -z $CUSTOMER_NAME ]]
        then
        # get new customer name
        echo -e "\nI don't have a record for that phone number, what's your name?"
        read CUSTOMER_NAME
        # insert new customer
        INSERT_CUSTOMER_RESULT=$($PSQL "INSERT INTO customers(phone, name) VALUES('$CUSTOMER_PHONE', '$CUSTOMER_NAME')")
      fi
      # retrieve the service's name
      SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id = $RESULT_SERVICE_ID_SELECTED")
      # request appointment time
      echo -e "\nWhat time would you like your $(echo $SERVICE_NAME | sed -r 's/^ *| *$//g'), $(echo $CUSTOMER_NAME | sed -r 's/^ *| *$//g')?"
      read SERVICE_TIME
      # retrieve the customer_id
      CUSTOMER_ID=$($PSQL "SELECT customer_ID FROM customers WHERE phone = '$CUSTOMER_PHONE'")
      # update appointments table
      INSERT_CUSTOMER_RESULT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES('$CUSTOMER_ID', '$RESULT_SERVICE_ID_SELECTED', '$SERVICE_TIME')")
      # confirm the booked service, time and customer's name
      echo -e "\nI have put you down for a $(echo $SERVICE_NAME | sed -r 's/^ *| *$//g') at $(echo $SERVICE_TIME | sed -r 's/^ *| *$//g'), $(echo $CUSTOMER_NAME | sed -r 's/^ *| *$//g')."
  fi
}
SERVICE_BOOKING
