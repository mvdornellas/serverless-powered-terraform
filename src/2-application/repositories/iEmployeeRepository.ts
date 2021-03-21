import { Employee } from '#enterprise/entities/employee'
import { Token } from 'typedi'

export interface IEmployeeRepository {
  get (id: string): Promise<Employee>
  create (employee: Employee): Promise<Employee>
  delete (id: string): Promise<void>
  update (employee: Employee): Promise<Employee>
}

export const IEmployeeRepositoryToken = new Token<IEmployeeRepository>()
