/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/widgets.dart';
import 'package:info_carousel/info_carousel.dart';

class InfoRepository {
  static List<InfoCarouselCardModel> cards = [
    InfoCarouselCardModel(
        cover: InfoCarouselCardModelCover(
            header: InfoCarouselCardModelCoverHeader(
                image: Image.asset("res/images/gmail-circle-icon.png",
                    package: "tiki_strategy_google"),
                title: "Your Gmail account",
                share: InfoCarouselCardModelCoverHeaderShare(
                  message:
                      "Gmail knows where you are when you read your emails. It's your data, start taking it back on https://www.mytiki.com",
                  //image: const AssetImage("res/images/socialmedia1.png", package: "tiki_strategy_google")
                )),
            image: Image.asset("res/images/where-you-are.png",
                package: "tiki_strategy_google"),
            subtitle: "Gmail knows...",
            bigTextLight: "Where you are ",
            bigTextDark: "when you read your emails.",
            text:
                "Your Gmail account tracks your location when you open your emails...\nEvery single time you do it."),
        content: InfoCarouselCardModelContent(
            body: InfoCarouselCardModelContentBody(
                explain: <InfoCarouselCardModelContentText>[
                  InfoCarouselCardModelContentText(
                      text: "Gmail records your ", url: null),
                  InfoCarouselCardModelContentText(
                      text: "IP address",
                      url: "https://en.wikipedia.org/wiki/IP_address"),
                  InfoCarouselCardModelContentText(
                      text:
                          " every time you open your inbox or send an email.\n\nMost Google products and almost all email services do this. Some, like Outlook, but NOT Gmail, will even send your IP address to the person receiving your email.\n\nThe most common use approximates your location, pinpointing you within 3-5 miles anywhere in the world. In extreme cases, like criminal investigations, your IP address can be tied to your exact device and location by working with an Internet Service Provider.",
                      url: null)
                ],
                theySay: <InfoCarouselCardModelContentIcon>[
                  InfoCarouselCardModelContentIcon(
                      image: Image.asset("res/images/info-badge.png",
                          package: "tiki_strategy_google"),
                      text: "Security monitoring to suspicious access"),
                  InfoCarouselCardModelContentIcon(
                      image: Image.asset("res/images/search-graph.png",
                          package: "tiki_strategy_google"),
                      text:
                          "Analyzing patterns to develop new features and products")
                ],
                shouldKnow: [
                  InfoCarouselCardModelContentIcon(
                      image: Image.asset("res/images/np-tap.png",
                          package: "tiki_strategy_google"),
                      text:
                          "Used advertisers for location-based targeting and surveillance"),
                  InfoCarouselCardModelContentIcon(
                      image: Image.asset("res/images/badge.png",
                          package: "tiki_strategy_google"),
                      text: "Used by law enforcement"),
                  InfoCarouselCardModelContentIcon(
                      image: Image.asset("res/images/worldwide.png",
                          package: "tiki_strategy_google"),
                      text:
                          "Saved for 9 months, then obscured and kept permanently")
                ]),
            cta: InfoCarouselCardModelContentCta(
                explain: <InfoCarouselCardModelContentText>[
                  InfoCarouselCardModelContentText(
                      text: "You can use a ", url: null),
                  InfoCarouselCardModelContentText(
                      text: "VPN", url: "https://nordvpn.com"),
                  InfoCarouselCardModelContentText(
                      text:
                          " to hide your IP address or, for true anonymity, switch to an ",
                      url: null),
                  InfoCarouselCardModelContentText(
                      text: "encrypted email service",
                      url: "https://protonmail.com"),
                  InfoCarouselCardModelContentText(
                      text:
                          ".\n\nGmail does not currently use additional location services.\n\nIf you just hate the ads, you can turn off ad personalization for your entire Google account. ",
                      url: null)
                ],
                buttonText: "AD PERSONALIZATION",
                buttonUrl: "https://adssettings.google.com"))),
    InfoCarouselCardModel(
        cover: InfoCarouselCardModelCover(
            header: InfoCarouselCardModelCoverHeader(
                image: Image.asset("res/images/gmail-circle-icon.png",
                    package: "tiki_strategy_google"),
                title: "Your Gmail account",
                share: InfoCarouselCardModelCoverHeaderShare(
                  message:
                      "Gmail knows what you've written to your friends. Find out more on https://www.mytiki.com",
                  //image: const AssetImage("socialmedia2.png", package: "tiki_strategy_google")
                )),
            image: Image.asset("res/images/what-written.png",
                package: "tiki_strategy_google"),
            subtitle: "Gmail knows...",
            bigTextLight: "What you’ve written to ",
            bigTextDark: "your friends",
            text:
                "Gmail has all emails you’ve ever written to anyone. They look at the content in the emails, so they know you better."),
        content: InfoCarouselCardModelContent(
            body: InfoCarouselCardModelContentBody(explain: [
              InfoCarouselCardModelContentText(
                  text:
                      "Gmail has access to your emails - it reads, stores and analyzes them.\n\nGoogle uses this information for targeted ads and what they call “smart features” like automatically adding your flight information to your calendar.\n\nIn their own words:\n\n\nCreepy.",
                  url: null)
            ], theySay: [
              InfoCarouselCardModelContentIcon(
                  image: Image.asset("res/images/airplane.png",
                      package: "tiki_strategy_google"),
                  text:
                      "Travel assistance like itineraries, updates, and maps."),
              InfoCarouselCardModelContentIcon(
                  image: Image.asset("res/images/email.png",
                      package: "tiki_strategy_google"),
                  text:
                      "Smart email with suggestions, nudges, prioritization, and filtering"),
              InfoCarouselCardModelContentIcon(
                  image: Image.asset("res/images/package.png",
                      package: "tiki_strategy_google"),
                  text:
                      "Track packages, reservations, loyalty cards, and bills")
            ], shouldKnow: [
              InfoCarouselCardModelContentIcon(
                  image: Image.asset("res/images/np-tap.png",
                      package: "tiki_strategy_google"),
                  text: "Used by advertisers for key word targetting"),
              InfoCarouselCardModelContentIcon(
                  image: Image.asset("res/images/hammer.png",
                      package: "tiki_strategy_google"),
                  text: "Used by law enforcement"),
              InfoCarouselCardModelContentIcon(
                  image: Image.asset("res/images/worldwide.png",
                      package: "tiki_strategy_google"),
                  text: "Disabled by default in Europe")
            ]),
            cta: InfoCarouselCardModelContentCta(
                explain: [
                  InfoCarouselCardModelContentText(
                      text: "You can turn off both,", url: null),
                  InfoCarouselCardModelContentText(
                      url: "https://support.google.com/mail/answer/10079371",
                      text: " ad personalization "),
                  InfoCarouselCardModelContentText(
                      text:
                          "and “smart features” to stop Google from scanning your emails.",
                      url: null)
                ],
                buttonText: "STOP READING MY EMAILS",
                buttonUrl: "https://support.google.com/mail/answer/10079371"))),
    InfoCarouselCardModel(
        cover: InfoCarouselCardModelCover(
            header: InfoCarouselCardModelCoverHeader(
                image: Image.asset("res/images/gmail-circle-icon.png",
                    package: "tiki_strategy_google"),
                title: "Your Gmail account",
                share: InfoCarouselCardModelCoverHeaderShare(
                  message:
                      "Gmail knows what you've written to your friends. Find out more on https://www.mytiki.com",
                  //image: AssetImage("res/images/socialmedia2.png", package: "tiki_strategy_google").createStream(configuration)
                )),
            image: Image.asset("res/images/everything-you-do.png",
                package: "tiki_strategy_google"),
            subtitle: "Gmail knows...",
            bigTextLight: "Everything\n",
            bigTextDark: "you do in your Gmail app",
            text:
                "Your Gmail app has quite a lot of analytics packed in and knows quite a few things...."),
        content: InfoCarouselCardModelContent(
            body: InfoCarouselCardModelContentBody(explain: [
              InfoCarouselCardModelContentText(
                  url: null,
                  text:
                      "Gmail’s app is designed to track most of the things you do with it. It tracks each action you take, on which device, OS, and time of day.\n\nFor example, when you opened the app, what you searched for and if you saw an ad were all tracked.\n\nYour audio is recorded if you use voice search or assistant with Gmail.")
            ], theySay: [
              InfoCarouselCardModelContentIcon(
                  image: Image.asset("res/images/person-4.png",
                      package: "tiki_strategy_google"),
                  text: "Personalized experiences"),
              InfoCarouselCardModelContentIcon(
                  image: Image.asset("res/images/circle-badge.png",
                      package: "tiki_strategy_google"),
                  text: "App and content recommendations"),
              InfoCarouselCardModelContentIcon(
                  image: Image.asset("res/images/search.png",
                      package: "tiki_strategy_google"),
                  text: "Faster Search")
            ], shouldKnow: [
              InfoCarouselCardModelContentIcon(
                  image: Image.asset("res/images/hat-n-glasses.png",
                      package: "tiki_sZtrategy_google"),
                  text: "Your activity is tracked even when logged out"),
              InfoCarouselCardModelContentIcon(
                  image: Image.asset("res/images/badge.png",
                      package: "tiki_strategy_google"),
                  text: "Used by law enforcement"),
              InfoCarouselCardModelContentIcon(
                  image: Image.asset("res/images/bomb.png",
                      package: "tiki_strategy_google"),
                  text:
                      "You can set your history to auto delete after 3, 18, or 36 months")
            ]),
            cta: InfoCarouselCardModelContentCta(
                explain: [
                  InfoCarouselCardModelContentText(
                      text:
                          "You can delete all activities, individual activities, set it to auto-delete, or disable activity tracking entirely.",
                      url: null)
                ],
                buttonText: "MY ACTIVITY",
                buttonUrl: "https://myactivity.google.com")))
  ];
}
