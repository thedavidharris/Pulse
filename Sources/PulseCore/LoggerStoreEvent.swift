// The MIT License (MIT)
//
// Copyright (c) 2020–2022 Alexander Grebenyuk (github.com/kean).

import Foundation

extension LoggerStore {
    /// The events used for syncing data between stores.
    public enum Event: Sendable {
        case messageStored(MessageCreated)
        case networkTaskCreated(NetworkTaskCreated)
        case networkTaskProgressUpdated(NetworkTaskProgressUpdated)
        case networkTaskCompleted(NetworkTaskCompleted)

        public final class MessageCreated: Codable, Sendable {
            public let createdAt: Date
            public let label: String
            public let level: LoggerStore.Level
            public let message: String
            public let metadata: [String: String]?
            public let session: String
            public let file: String
            public let function: String
            public let line: UInt

            public init(createdAt: Date, label: String, level: LoggerStore.Level, message: String, metadata: [String: String]?, session: String, file: String, function: String, line: UInt) {
                self.createdAt = createdAt
                self.label = label
                self.level = level
                self.message = message
                self.metadata = metadata
                self.session = session
                self.file = file
                self.function = function
                self.line = line
            }
        }

        public struct NetworkTaskCreated: Codable, Sendable {
            public let taskId: UUID
            public let taskType: NetworkLogger.TaskType
            public let createdAt: Date
            public let originalRequest: NetworkLogger.Request
            public let currentRequest: NetworkLogger.Request?
            public var requestBody: Data?
            public let session: String

            public init(taskId: UUID, taskType: NetworkLogger.TaskType, createdAt: Date, originalRequest: NetworkLogger.Request, currentRequest: NetworkLogger.Request?, requestBody: Data?, session: String) {
                self.taskId = taskId
                self.taskType = taskType
                self.createdAt = createdAt
                self.originalRequest = originalRequest
                self.currentRequest = currentRequest
                self.requestBody = requestBody
                self.session = session
            }
        }

        public struct NetworkTaskProgressUpdated: Codable, Sendable {
            public let taskId: UUID
            public let completedUnitCount: Int64
            public let totalUnitCount: Int64

            public init(taskId: UUID, completedUnitCount: Int64, totalUnitCount: Int64) {
                self.taskId = taskId
                self.completedUnitCount = completedUnitCount
                self.totalUnitCount = totalUnitCount
            }
        }

        public final class NetworkTaskCompleted: Codable, Sendable {
            public let taskId: UUID
            public let taskType: NetworkLogger.TaskType
            public let createdAt: Date
            public let originalRequest: NetworkLogger.Request
            public let currentRequest: NetworkLogger.Request?
            public let response: NetworkLogger.Response?
            public let error: NetworkLogger.ResponseError?
            public let requestBody: Data?
            public let responseBody: Data?
            public let metrics: NetworkLogger.Metrics?
            public let session: String

            public init(taskId: UUID, taskType: NetworkLogger.TaskType, createdAt: Date, originalRequest: NetworkLogger.Request, currentRequest: NetworkLogger.Request?, response: NetworkLogger.Response?, error: NetworkLogger.ResponseError?, requestBody: Data?, responseBody: Data?, metrics: NetworkLogger.Metrics?, session: String) {
                self.taskId = taskId
                self.taskType = taskType
                self.createdAt = createdAt
                self.originalRequest = originalRequest
                self.currentRequest = currentRequest
                self.response = response
                self.error = error
                self.requestBody = requestBody
                self.responseBody = responseBody
                self.metrics = metrics
                self.session = session
            }
        }
    }
}
