
class Parser {
  body (body: string) {
    try {
      return JSON.parse(body)
    } catch (error) {
      return undefined
    }
  }
}

export default new Parser()
