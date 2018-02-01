/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 * @flow
 */

import React, { Component } from 'react';
import {
  StyleSheet,
  Text,
  View,
  TouchableOpacity,
  NativeModules,
  NativeEventEmitter,
  Alert,
} from 'react-native';

const { ReactEventManager } = NativeModules;

export default class App extends Component {
  constructor(props) {
    super(props);
    this._subscription = null;
    this.state = {
      nativeEventInfo: 'waiting',
    };
  }
  componentDidMount() {
    console.log('componentDidMount');
    const ManagerEvent = new NativeEventEmitter(ReactEventManager);
    this._subscription = ManagerEvent.addListener('eventToRN', (info) => {
      this.setState({ nativeEventInfo: info });
    });
  }
  componentWillUnmount() {
    console.log('componentWillUnmount');
    this._subscription.remove();
  }
  render() {
    console.log(this.props);
    return (
      <View style={styles.container}>
        <Text style={styles.welcome}>{`From Native: ${
          this.props.message
        }`}</Text>
        <Text style={styles.welcome}>{`Native Event Info: ${
          this.state.nativeEventInfo
        }`}</Text>
        <TouchableOpacity
          onPress={() => {
            ReactEventManager.show('From React Native: Awesome!');
          }}
        >
          <Text style={styles.buttom}>Call Native Method</Text>
        </TouchableOpacity>
        <TouchableOpacity
          onPress={() => {
            Alert.alert('RN Modules', 'RCTAlertManager Alert!!');
          }}
        >
          <Text style={styles.buttom}>Alert Message</Text>
        </TouchableOpacity>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#F5FCFF',
  },
  welcome: {
    fontSize: 20,
    textAlign: 'center',
    margin: 10,
    color: '#24292e',
  },
  instructions: {
    textAlign: 'center',
    color: '#333333',
    marginBottom: 5,
  },
  buttom: {
    marginTop: 10,
    backgroundColor: '#e83e8c',
    color: '#ffffff',
    padding: 10,
  },
});
