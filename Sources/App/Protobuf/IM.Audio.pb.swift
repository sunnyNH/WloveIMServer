// DO NOT EDIT.
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: IM.Audio.proto
//
// For information on using the generated types, please see the documenation:
//   https://github.com/apple/swift-protobuf/

import Foundation
import SwiftProtobuf

// If the compiler emits an error on this type, it is because this file
// was generated by a version of the `protoc` Swift plug-in that is
// incompatible with the version of SwiftProtobuf to which you are linking.
// Please ensure that your are building against the same version of the API
// that was used to generate this file.
fileprivate struct _GeneratedWithProtocGenSwiftVersion: SwiftProtobuf.ProtobufAPIVersionCheck {
  struct _2: SwiftProtobuf.ProtobufAPIVersion_2 {}
  typealias Version = _2
}

struct IM_Audio_IMAudioData: SwiftProtobuf.Message {
  static let protoMessageName: String = _protobuf_package + ".IMAudioData"

  /// 信息类型  1请求语音通话，2同意语音通话，3挂断语音通话
  var type: UInt32 = 0

  /// 房间id
  var roomID: UInt32 = 0

  /// 消息发送方
  var from: String = String()

  /// 消息接受方
  var to: String = String()

  /// 消息接受方
  var msg: String = String()

  /// 语音data
  var audioData: Data = SwiftProtobuf.Internal.emptyData

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  /// Used by the decoding initializers in the SwiftProtobuf library, not generally
  /// used directly. `init(serializedData:)`, `init(jsonUTF8Data:)`, and other decoding
  /// initializers are defined in the SwiftProtobuf library. See the Message and
  /// Message+*Additions` files.
  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeSingularUInt32Field(value: &self.type)
      case 2: try decoder.decodeSingularUInt32Field(value: &self.roomID)
      case 3: try decoder.decodeSingularStringField(value: &self.from)
      case 4: try decoder.decodeSingularStringField(value: &self.to)
      case 5: try decoder.decodeSingularStringField(value: &self.msg)
      case 6: try decoder.decodeSingularBytesField(value: &self.audioData)
      default: break
      }
    }
  }

  /// Used by the encoding methods of the SwiftProtobuf library, not generally
  /// used directly. `Message.serializedData()`, `Message.jsonUTF8Data()`, and
  /// other serializer methods are defined in the SwiftProtobuf library. See the
  /// `Message` and `Message+*Additions` files.
  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if self.type != 0 {
      try visitor.visitSingularUInt32Field(value: self.type, fieldNumber: 1)
    }
    if self.roomID != 0 {
      try visitor.visitSingularUInt32Field(value: self.roomID, fieldNumber: 2)
    }
    if !self.from.isEmpty {
      try visitor.visitSingularStringField(value: self.from, fieldNumber: 3)
    }
    if !self.to.isEmpty {
      try visitor.visitSingularStringField(value: self.to, fieldNumber: 4)
    }
    if !self.msg.isEmpty {
      try visitor.visitSingularStringField(value: self.msg, fieldNumber: 5)
    }
    if !self.audioData.isEmpty {
      try visitor.visitSingularBytesField(value: self.audioData, fieldNumber: 6)
    }
    try unknownFields.traverse(visitor: &visitor)
  }
}

struct IM_Audio_IMAudioAck: SwiftProtobuf.Message {
  static let protoMessageName: String = _protobuf_package + ".IMAudioAck"

  /// 0:发送成功，msg_id有效；1+：发送失败;
  var errCode: String = String()

  /// 错误消息
  var errMsg: String = String()

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  /// Used by the decoding initializers in the SwiftProtobuf library, not generally
  /// used directly. `init(serializedData:)`, `init(jsonUTF8Data:)`, and other decoding
  /// initializers are defined in the SwiftProtobuf library. See the Message and
  /// Message+*Additions` files.
  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeSingularStringField(value: &self.errCode)
      case 2: try decoder.decodeSingularStringField(value: &self.errMsg)
      default: break
      }
    }
  }

  /// Used by the encoding methods of the SwiftProtobuf library, not generally
  /// used directly. `Message.serializedData()`, `Message.jsonUTF8Data()`, and
  /// other serializer methods are defined in the SwiftProtobuf library. See the
  /// `Message` and `Message+*Additions` files.
  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.errCode.isEmpty {
      try visitor.visitSingularStringField(value: self.errCode, fieldNumber: 1)
    }
    if !self.errMsg.isEmpty {
      try visitor.visitSingularStringField(value: self.errMsg, fieldNumber: 2)
    }
    try unknownFields.traverse(visitor: &visitor)
  }
}

// MARK: - Code below here is support for the SwiftProtobuf runtime.

fileprivate let _protobuf_package = "IM.Audio"

extension IM_Audio_IMAudioData: SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "type"),
    2: .standard(proto: "room_id"),
    3: .same(proto: "from"),
    4: .same(proto: "to"),
    5: .same(proto: "msg"),
    6: .standard(proto: "audio_data"),
  ]

  func _protobuf_generated_isEqualTo(other: IM_Audio_IMAudioData) -> Bool {
    if self.type != other.type {return false}
    if self.roomID != other.roomID {return false}
    if self.from != other.from {return false}
    if self.to != other.to {return false}
    if self.msg != other.msg {return false}
    if self.audioData != other.audioData {return false}
    if unknownFields != other.unknownFields {return false}
    return true
  }
}

extension IM_Audio_IMAudioAck: SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .standard(proto: "err_code"),
    2: .standard(proto: "err_msg"),
  ]

  func _protobuf_generated_isEqualTo(other: IM_Audio_IMAudioAck) -> Bool {
    if self.errCode != other.errCode {return false}
    if self.errMsg != other.errMsg {return false}
    if unknownFields != other.unknownFields {return false}
    return true
  }
}
