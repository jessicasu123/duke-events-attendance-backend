import React, { Component } from 'react';
import { Mutation } from "react-apollo";
import { CREATE_EVENT } from "../apollo"


class Host extends Component {
  constructor(props) {
    super(props);
    this.state = { 
      eventid: null,
      hostid: null,
      errors: []
    }
  }

  handleFormSubmit = ( props ) => {
    let { createEvent } = props;
    let {
      eventid,
      hostid
    } = this.state;

    console.log(eventid, hostid)
    createEvent({
      variables: {
        eventid: eventid,
        hostid: hostid
      }
    })
    .then((response) =>{
      alert('Event Details Updated successfully')
      const { data } = response;
      console.log(data)
    })
    .catch((e) => {
      let messages = JSON.parse(e.graphQLErrors[0].message)
      this.setState({
        errors : messages.errors
      })

    })

  }

  handleChange = (event) =>{
    this.setState({
      [event.target.id]: event.target.value
    })

  }

  showErrors = () =>{
    let { errors } = this.state;
    const errorsList = errors.map((error, index)=>(
      <li key={index}>{error}</li>
    ))

    return (
      <ul>
        {errorsList}
      </ul>
    )
  }
  render() { 
    return (
      <Mutation
        mutation={CREATE_EVENT}
      >
      {(createEvent) =>(
        <div>
          <h2>Create Event Form</h2>
          <this.showErrors/>
          <form onSubmit={ e =>{
            e.preventDefault()
            this.handleFormSubmit({ createEvent })
          }}>
            <div>
              <label>Event ID</label>
              <input type="text" id="eventid" onChange={this.handleChange} required/>
            </div>

            <div>
              <label>Host ID</label>
              <input type="text" id="hostid" onChange={this.handleChange} required/>
            </div>
            <button type="submit">SUBMIT</button>
          </form>
        </div>
      )}
      </Mutation>
    );
  }
}
 
export default Event;