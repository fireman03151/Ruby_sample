require 'test_helper'
require 'docs'

class DocsResponseTest < MiniTest::Spec
  let :response do
    Typhoeus::Response.new(options).tap do |response|
      response.extend Docs::Response
      response.request = request
    end
  end

  let :request do
    OpenStruct.new
  end

  let :options do
    OpenStruct.new headers: {}
  end

  describe "#success?" do
    it "returns true when the code is 200" do
      options.code = 200
      assert response.success?
    end

    it "returns false when the code is 404" do
      options.code = 404
      refute response.success?
    end
  end

  describe "#empty?" do
    it "returns true when the body is empty" do
      options.body = ''
      assert response.empty?
    end

    it "returns false when the body isn't empty" do
      options.body = 'body'
      refute response.empty?
    end
  end

  describe "#mime_type" do
    it "returns the content type" do
      options.headers['Content-Type'] = 'type'
      assert_equal 'type', response.mime_type
    end

    it "defaults to text/plain" do
      assert_equal 'text/plain', response.mime_type
    end
  end

  describe "#html?" do
    it "returns true when the content type is 'text/html'" do
      options.headers['Content-Type'] = 'text/html'
      assert response.html?
    end

    it "returns true when the content type is 'application/xhtml'" do
      options.headers['Content-Type'] = 'application/xhtml'
      assert response.html?
    end

    it "returns false when the content type is 'text/plain'" do
      options.headers['Content-Type'] = 'text/plain'
      refute response.html?
    end
  end

  describe "#url" do
    before { request.base_url = 'http://example.com' }

    it "returns a Docs::URL" do
      assert_instance_of Docs::URL, response.url
    end

    it "returns the #request's base url" do
      assert_equal request.base_url, response.url.to_s
    end
  end

  describe "#path" do
    it "returns the #url's path" do
      request.base_url = 'http://example.com/path'
      assert_equal '/path', response.path
    end
  end

  describe "#effective_url" do
    before { options.effective_url = 'http://example.com' }

    it "returns a Docs::URL" do
      assert_instance_of Docs::URL, response.effective_url
    end

    it "returns the effective url" do
      assert_equal options.effective_url, response.effective_url.to_s
    end
  end

  describe "#effective_path" do
    it "returns the #effective_url's path" do
      options.effective_url = 'http://example.com/path'
      assert_equal '/path', response.effective_path
    end
  end
end
