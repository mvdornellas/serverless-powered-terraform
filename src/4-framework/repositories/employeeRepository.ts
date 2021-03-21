import { IEmployeeRepository } from '#application/repositories/iEmployeeRepository'
import { Employee } from '#enterprise/entities/employee'
import { EmployeeModel } from '#framework/models/employeeModel'

export class EmployeeRepository implements IEmployeeRepository {
  async get (id: string): Promise<Employee> {
    return EmployeeModel.queryOne('id').eq(id).exec()
  }
  async create (employee: Employee): Promise<Employee> {
    return EmployeeModel.create(employee)
  }
  async delete (id: string): Promise<void> {
    return EmployeeModel.delete(id)
  }
  async update ({ id, name, age, role }: Employee): Promise<Employee> {
    return EmployeeModel.update(id, {
      name,
      age,
      role,
      updatedAt: new Date().toISOString()
    })
  }

}
