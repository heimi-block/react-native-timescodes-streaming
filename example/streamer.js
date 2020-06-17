import React, { Component, Fragment } from 'react';
import { UIManager, findNodeHandle, requireNativeComponent, NativeModules, StyleSheet, ScrollView, Platform, AsyncStorage, Image, StatusBar, TextInput, Text, View, TouchableOpacity, Dimensions } from 'react-native';
import { SafeAreaView, NavigationEvents } from 'react-navigation';
import { factory, redux, netWork } from '../../../frame';
const { width: screen_width, height: screen_height } = Dimensions.get('window');
import { colors, globalStyles } from '../../../common/styles';
import Streaming from '../react-native-timescodes-straming';

class LiveStreamer extends factory.Widget {
    store = factory.store(this, 'LiveStreamer', 'App');

    componentDidMount() {
        this._navListener = this.props.navigation.addListener('didFocus', () => {
            StatusBar.setBarStyle('dark-content');
            Platform.OS === 'android' && StatusBar.setBackgroundColor('#FFFFFF');
        });
    }

    constructor(props) {
        super(props);
        this.property.init({
            id: 'LiveStreamer',
            cameraFronted: true,
            beautyFace: true,
            started: false,
        });
    }

    updateCameraFronted = () => {
        this.setState({
            cameraFronted: !this.state.cameraFronted,
        });
    };

    updateBeautyFace = () => {
        this.setState({
            beautyFace: !this.state.beautyFace,
        });
    };

    updateStarted = () => {
        this.setState({
            started: !this.state.started,
        });
    };

    onStart = e => {
        const { state, text } = e.nativeEvent;
        console.log('onStart>>>>>>>>');
        this.toast(`state: ${state} , text: ${text}`);
    };

    onStop = e => {
        const { state, text } = e.nativeEvent;
        console.log('onStop>>>>>>>>');
        this.toast(`state: ${state} , text: ${text}`);
    };

    render() {
        return (
            <SafeAreaView style={styles.container}>
                <Streaming
                    onStart={this.onStart}
                    onStop={this.onStop}
                    started={this.state.started}
                    beautyFace={this.state.beautyFace}
                    cameraFronted={this.state.cameraFronted}
                    streamURL='rtmp://192.168.31.55/live/Test2'
                    style={{ width: screen_width, height: screen_height, position: 'absolute', top: 0, left: 0 }}
                />

                <View style={{ position: 'absolute', bottom: 20, paddingHorizontal: 15, paddingLeft: 0, width: screen_width }}>
                    <View style={{ flexDirection: 'row', alignItems: 'center' }}>
                        <TouchableOpacity onPress={this.updateCameraFronted}>
                            <View style={styles.operationBtnWrapper}>
                                <Text allowFontScaling={false} style={styles.operationBtnText}>
                                    摄像头旋转
                                </Text>
                            </View>
                        </TouchableOpacity>
                        <TouchableOpacity onPress={this.updateBeautyFace}>
                            <View style={styles.operationBtnWrapper}>
                                <Text allowFontScaling={false} style={styles.operationBtnText}>
                                    美颜滤镜
                                </Text>
                            </View>
                        </TouchableOpacity>
                        <TouchableOpacity onPress={this.updateStarted}>
                            <View style={styles.operationBtnWrapper}>
                                <Text allowFontScaling={false} style={styles.operationBtnText}>
                                    直播推流
                                </Text>
                            </View>
                        </TouchableOpacity>
                    </View>
                </View>
            </SafeAreaView>
        );
    }
}

const styles = StyleSheet.create({
    container: { flex: 1, backgroundColor: '#FFFFFF' },
    normal_text: {
        fontSize: 16,
        lineHeight: 20,
        color: '#333',
        includeFontPadding: false,
    },
    operationBtnWrapper: {
        backgroundColor: colors.primary,
        height: 22,
        justifyContent: 'center',
        borderRadius: 4,
        paddingHorizontal: 3,
        paddingVertical: 3,
        marginLeft: 15,
    },
    operationBtnText: {
        includeFontPadding: false,
        fontSize: 10,
        lineHeight: 15,
        color: '#FFFFFF',
        textAlign: 'center',
    },
});

export default factory.create(LiveStreamer);
