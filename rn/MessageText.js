import React, { Component } from 'react';
import { Text, View } from 'react-native';

export default class MessageText extends Component {
  // lots and lots of code
  render() {
    return (
      <View>
        <Text>{`From Native: ${this.props.message}`}</Text>
        <Text>{`Native Event Info: ${this.props.nativeEventInfo}`}</Text>
      </View>
    );
  }
}
