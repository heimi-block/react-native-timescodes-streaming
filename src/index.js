/**
 * react-native-timescodes-living
 * @author ios block-heimi lpx@times.codes
 */
import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { Text, View, ViewPropTypes, Dimensions, Platform, requireNativeComponent } from 'react-native';
const LFLiveKitView = requireNativeComponent('LFLiveKitView', null);

/**
 * Default styles
 * @type {StyleSheetPropType}
 */

const styles = {};

// missing `module.exports = exports['default'];` with babel6
// export default React.createClass({
export default class extends Component {
    /**
     * Props Validation
     * @type {Object}
     */

    static propTypes = {
        started: PropTypes.bool,
        cameraFronted: PropTypes.bool,
        beautyFace: PropTypes.bool,
        streamURL: PropTypes.string.isRequired,

        onReady: PropTypes.func,
        onPending: PropTypes.func,
        onStart: PropTypes.func,
        onError: PropTypes.func,
        onStop: PropTypes.func,
        ...View.propTypes,
    };

    /**
     * Default props
     * @return {object} props
     * @see http://facebook.github.io/react-native/docs/view.html
     */
    static defaultProps = {
        cameraFronted: true,
        beautyFace: true,
    };

    /**
     * onStart
     * @param  {object} e native event
     */
    onStart = e => {
        this.props.onStart && this.props.onStart(e.nativeEvent);
    };

    /**
     * onReady
     * @param  {object} e native event
     */
    onReady = e => {
        this.props.onReady && this.props.onReady(e.nativeEvent);
    };

    /**
     * onError
     * @param  {object} e native event
     */
    onError = e => {
        this.props.onError && this.props.onError(e.nativeEvent);
    };

    /**
     * onPending
     * @param  {object} e native event
     */
    onPending = e => {
        this.props.onPending && this.props.onPending(e.nativeEvent);
    };

    /**
     * onStop
     * @param  {object} e native event
     */
    onStop = e => {
        this.props.onStop && this.props.onStop(e.nativeEvent);
    };

    /**
     * Default render
     * @return {object} react-dom
     */
    render() {
        return <LFLiveKitView {...this.props} />;
    }
}
