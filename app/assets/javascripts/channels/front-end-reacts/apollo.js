import ApolloClient from "apollo-boost";
import gql from "graphql-tag";



export  const client = new ApolloClient({
  uri: "/graphql",
})


// let's define graphql queries here, similar to what we send using rails Graphiql Engine

export const CREATE_EVENT = gql `
  mutation hostCheckIn($eventid: ID!, $hostid: ID!){
    createEvent(
      input:{
        eventid: $eventid
        hostid: $hostid
    }){
      event {
        eventid
      }
    }
  }