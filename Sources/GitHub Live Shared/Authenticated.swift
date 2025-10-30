//
//  Authenticated.swift
//  swift-github-live
//
//  Created by Coen ten Thije Boonkkamp on 22/08/2025.
//

// GitHub uses Bearer token authentication
// https://docs.github.com/en/rest/authentication/authenticating-to-the-rest-api
public typealias Authenticated<
  API: Equatable & Sendable,
  APIRouter: ParserPrinter & Sendable,
  Client: Sendable
> = Authenticating<
  BearerAuth,
  BearerAuth.Router,
  API,
  APIRouter,
  Client
> where APIRouter.Output == API, APIRouter.Input == URLRequestData
