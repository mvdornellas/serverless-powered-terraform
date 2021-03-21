import { Employee } from '#enterprise/entities/employee'
import dynamoose, { ModelConstructor, Schema, SchemaAttributes } from 'dynamoose'

export type ModelDataSchema = Employee
export type ModelKeySchema = string

export type ModelSchema = ModelConstructor<
  ModelDataSchema,
  ModelKeySchema
>

const schema = {
  id: {
    type: String,
    required: true,
    hashKey: true
  },
  name: {
    type: String,
    required: true
  },
  age: {
    type: Number,
    required: true
  },
  role: {
    type: String,
    required: true
  },
  createdAt: {
    type: String,
    default: new Date().toISOString(),
    required: true
  },
  updatedAt: {
    type: String,
    required: false
  }
} as SchemaAttributes

export const EmployeeModel: ModelSchema = dynamoose.model<
  ModelDataSchema,
  ModelKeySchema>(
    'Employees',
    new Schema(schema, {
      timestamps: true,
      saveUnknown: true,
      useDocumentTypes: false
    })
  )
