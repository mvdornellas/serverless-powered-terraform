import { Employee } from '#enterprise/entities/employee'

export interface IEmployeeRepository {
  get (id: string): Promise<Employee>
  create (employee: Employee): Promise<Employee>
  delete (id: string): Promise<void>
  update (employee: Employee): Promise<Employee>
}

export const IEmployeeRepositoryToken = Symbol('IEmployeeRepository')
