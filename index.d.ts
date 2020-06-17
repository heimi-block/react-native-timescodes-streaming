import { ViewStyle, StyleProp, NativeSyntheticEvent, NativeScrollEvent, ScrollViewProps, NativeEventEmitter } from 'react-native';
import { Component } from 'react';

declare module 'react-native-timescodes-straming' {
    interface StreamingProps {
        cameraFronted?: boolean;
        beautyFace?: boolean;
        started?: boolean;
        streamURL: string;

        onStart?: (e: NativeEventEmitter) => void;
        onStop?: (e: NativeEventEmitter) => void;
        onPending?: (e: NativeEventEmitter) => void;
        onError?: (e: NativeEventEmitter) => void;
        onReady?: (e: NativeEventEmitter) => void;
    }
}
