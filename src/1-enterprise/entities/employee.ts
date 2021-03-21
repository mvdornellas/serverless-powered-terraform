import { Entity } from '#enterprise/entities/entity'
export class Employee extends Entity {
  name!: string
  age!: number
  role!: string
  createdAt?: string
  updatedAt?: string
}
