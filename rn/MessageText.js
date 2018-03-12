import React, { Component } from 'react';
import { StyleSheet, Text, View } from 'react-native';

export default class MessageText extends Component {
  // lots and lots of code
  render() {
    return (
      <View>
        <Text>{`From Native: ${this.props.message}`}</Text>
        <Text style={styles.info}>{`Native Event Info: ${
          this.props.nativeEventInfo
        }`}</Text>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  info: {
    fontSize: 20,
    color: '#C15E21',
  },
});
