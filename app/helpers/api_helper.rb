API_ENDPOINT = "http://localhost:3000/api/"

module ApiHelper
  def ApiHelper.get(path)
    Unirest.get("#{API_ENDPOINT}#{path}")
  end

  def ApiHelper.post(path, parameters)
    Unirest.post("#{API_ENDPOINT}#{path}", parameters)
  end

  def ApiHelper.put(path, parameters)
    Unirest.put("#{API_ENDPOINT}#{path}", parameters)
  end

  def ApiHelper.patch(path, parameters)
    Unirest.put("#{API_ENDPOINT}#{path}", parameters)
  end

  def ApiHelper.delete(path, parameters)
    Unirest.put("#{API_ENDPOINT}#{path}", parameters)
  end
end
