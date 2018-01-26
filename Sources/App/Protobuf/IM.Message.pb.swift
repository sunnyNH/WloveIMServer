// DO NOT EDIT.
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: IM.Message.proto
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

///service id  0x0003
struct IM_Message_IMMsgData: SwiftProtobuf.Message {
  static let protoMessageName: String = _protobuf_package + ".IMMsgData"

  ///cmd id:		0x0301
  var type: String = String()

  /// 消息子类型  m_txt,m_image,m_audio,m_video,m_location等
  var subtype: String = String()

  /// 消息发送方
  var from: String = String()

  /// 消息接受方,个人的id，或者群组的id
  var to: String = String()

  /// 服务端维护
  var msgID: String = String()

  /// 消息数据，json格式
  var msgData: String = String()

  /// 服务端时间戳
  var createTime: UInt32 = 0

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  /// Used by the decoding initializers in the SwiftProtobuf library, not generally
  /// used directly. `init(serializedData:)`, `init(jsonUTF8Data:)`, and other decoding
  /// initializers are defined in the SwiftProtobuf library. See the Message and
  /// Message+*Additions` files.
  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeSingularStringField(value: &self.type)
      case 2: try decoder.decodeSingularStringField(value: &self.subtype)
      case 3: try decoder.decodeSingularStringField(value: &self.from)
      case 4: try decoder.decodeSingularStringField(value: &self.to)
      case 5: try decoder.decodeSingularStringField(value: &self.msgID)
      case 6: try decoder.decodeSingularStringField(value: &self.msgData)
      case 7: try decoder.decodeSingularUInt32Field(value: &self.createTime)
      default: break
      }
    }
  }

  /// Used by the encoding methods of the SwiftProtobuf library, not generally
  /// used directly. `Message.serializedData()`, `Message.jsonUTF8Data()`, and
  /// other serializer methods are defined in the SwiftProtobuf library. See the
  /// `Message` and `Message+*Additions` files.
  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.type.isEmpty {
      try visitor.visitSingularStringField(value: self.type, fieldNumber: 1)
    }
    if !self.subtype.isEmpty {
      try visitor.visitSingularStringField(value: self.subtype, fieldNumber: 2)
    }
    if !self.from.isEmpty {
      try visitor.visitSingularStringField(value: self.from, fieldNumber: 3)
    }
    if !self.to.isEmpty {
      try visitor.visitSingularStringField(value: self.to, fieldNumber: 4)
    }
    if !self.msgID.isEmpty {
      try visitor.visitSingularStringField(value: self.msgID, fieldNumber: 5)
    }
    if !self.msgData.isEmpty {
      try visitor.visitSingularStringField(value: self.msgData, fieldNumber: 6)
    }
    if self.createTime != 0 {
      try visitor.visitSingularUInt32Field(value: self.createTime, fieldNumber: 7)
    }
    try unknownFields.traverse(visitor: &visitor)
  }
}

struct IM_Message_IMMsgDataAck: SwiftProtobuf.Message {
  static let protoMessageName: String = _protobuf_package + ".IMMsgDataAck"

  ///cmd id:		0x0302
  var errCode: String = String()

  /// 错误消息
  var errMsg: String = String()

  /// 发送成功后server会改写为实际的消息ID
  var msgID: String = String()

  /// 消息对应服务器时间戳
  var createTime: String = String()

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
      case 3: try decoder.decodeSingularStringField(value: &self.msgID)
      case 4: try decoder.decodeSingularStringField(value: &self.createTime)
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
    if !self.msgID.isEmpty {
      try visitor.visitSingularStringField(value: self.msgID, fieldNumber: 3)
    }
    if !self.createTime.isEmpty {
      try visitor.visitSingularStringField(value: self.createTime, fieldNumber: 4)
    }
    try unknownFields.traverse(visitor: &visitor)
  }
}

struct IM_Message_IMGroupChange: SwiftProtobuf.Message {
  static let protoMessageName: String = _protobuf_package + ".IMGroupChange"

  var uid: String = String()

  var changeType: String = String()

  var gid: String = String()

  ///现有的成员id
  var curUidList: [String] = []

  ///add: 表示添加成功的id,   del: 表示删除的id
  var chgUidList: [String] = []

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  /// Used by the decoding initializers in the SwiftProtobuf library, not generally
  /// used directly. `init(serializedData:)`, `init(jsonUTF8Data:)`, and other decoding
  /// initializers are defined in the SwiftProtobuf library. See the Message and
  /// Message+*Additions` files.
  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeSingularStringField(value: &self.uid)
      case 2: try decoder.decodeSingularStringField(value: &self.changeType)
      case 3: try decoder.decodeSingularStringField(value: &self.gid)
      case 4: try decoder.decodeRepeatedStringField(value: &self.curUidList)
      case 5: try decoder.decodeRepeatedStringField(value: &self.chgUidList)
      default: break
      }
    }
  }

  /// Used by the encoding methods of the SwiftProtobuf library, not generally
  /// used directly. `Message.serializedData()`, `Message.jsonUTF8Data()`, and
  /// other serializer methods are defined in the SwiftProtobuf library. See the
  /// `Message` and `Message+*Additions` files.
  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.uid.isEmpty {
      try visitor.visitSingularStringField(value: self.uid, fieldNumber: 1)
    }
    if !self.changeType.isEmpty {
      try visitor.visitSingularStringField(value: self.changeType, fieldNumber: 2)
    }
    if !self.gid.isEmpty {
      try visitor.visitSingularStringField(value: self.gid, fieldNumber: 3)
    }
    if !self.curUidList.isEmpty {
      try visitor.visitRepeatedStringField(value: self.curUidList, fieldNumber: 4)
    }
    if !self.chgUidList.isEmpty {
      try visitor.visitRepeatedStringField(value: self.chgUidList, fieldNumber: 5)
    }
    try unknownFields.traverse(visitor: &visitor)
  }
}

// MARK: - Code below here is support for the SwiftProtobuf runtime.

fileprivate let _protobuf_package = "IM.Message"

extension IM_Message_IMMsgData: SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "type"),
    2: .same(proto: "subtype"),
    3: .same(proto: "from"),
    4: .same(proto: "to"),
    5: .standard(proto: "msg_id"),
    6: .standard(proto: "msg_data"),
    7: .standard(proto: "create_time"),
  ]

  func _protobuf_generated_isEqualTo(other: IM_Message_IMMsgData) -> Bool {
    if self.type != other.type {return false}
    if self.subtype != other.subtype {return false}
    if self.from != other.from {return false}
    if self.to != other.to {return false}
    if self.msgID != other.msgID {return false}
    if self.msgData != other.msgData {return false}
    if self.createTime != other.createTime {return false}
    if unknownFields != other.unknownFields {return false}
    return true
  }
}

extension IM_Message_IMMsgDataAck: SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .standard(proto: "err_code"),
    2: .standard(proto: "err_msg"),
    3: .standard(proto: "msg_id"),
    4: .standard(proto: "create_time"),
  ]

  func _protobuf_generated_isEqualTo(other: IM_Message_IMMsgDataAck) -> Bool {
    if self.errCode != other.errCode {return false}
    if self.errMsg != other.errMsg {return false}
    if self.msgID != other.msgID {return false}
    if self.createTime != other.createTime {return false}
    if unknownFields != other.unknownFields {return false}
    return true
  }
}

extension IM_Message_IMGroupChange: SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "uid"),
    2: .standard(proto: "change_type"),
    3: .same(proto: "gid"),
    4: .standard(proto: "cur_uid_list"),
    5: .standard(proto: "chg_uid_list"),
  ]

  func _protobuf_generated_isEqualTo(other: IM_Message_IMGroupChange) -> Bool {
    if self.uid != other.uid {return false}
    if self.changeType != other.changeType {return false}
    if self.gid != other.gid {return false}
    if self.curUidList != other.curUidList {return false}
    if self.chgUidList != other.chgUidList {return false}
    if unknownFields != other.unknownFields {return false}
    return true
  }
}