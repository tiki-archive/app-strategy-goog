/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:info_carousel/info_carousel.dart';
import 'package:tiki_style/tiki_style.dart';

class InfoRepository {
  static List<InfoCarouselCardModel> cards = [
    InfoCarouselCardModel(
        cover: InfoCarouselCardModelCover(
            header: InfoCarouselCardModelCoverHeader(
                image: ImgProvider.googleGmailRound,
                title: "Your Gmail account",
                share: InfoCarouselCardModelCoverHeaderShare(
                  message:
                  "Gmail knows where you are when you read your emails. It's your data, start taking it back on https://www.mytiki.com",
                  //image: const AssetImage("res/images/socialmedia1.png", package: "tiki_strategy_google")
                )),
            image: ImgProvider.whereYouAre,
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
                      icon: IconProvider.att_badge,
                      text: "Security monitoring to suspicious access"),
                  InfoCarouselCardModelContentIcon(
                      icon: IconProvider.magnify_chart,
                      text:
                      "Analyzing patterns to develop new features and products")
                ],
                shouldKnow: [
                  InfoCarouselCardModelContentIcon(
                      icon: IconProvider.tag_1,
                      text:
                      "Used advertisers for location-based targeting and surveillance"),
                  InfoCarouselCardModelContentIcon(
                      icon: IconProvider.badge,
                      text: "Used by law enforcement"),
                  InfoCarouselCardModelContentIcon(
                      icon: IconProvider.globe,
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
                image: ImgProvider.googleGmailRound,
                title: "Your Gmail account",
                share: InfoCarouselCardModelCoverHeaderShare(
                  message:
                  "Gmail knows what you've written to your friends. Find out more on https://www.mytiki.com",
                  //image: const AssetImage("socialmedia2.png", package: "tiki_strategy_google")
                )),
            image: ImgProvider.whatWritten,
            subtitle: "Gmail knows...",
            bigTextLight: "What you’ve written to \n",
            bigTextDark: "your friends",
            text:
            "Gmail has all emails you’ve ever written to anyone. They look at the content in the emails, so they know you better."),
        content: InfoCarouselCardModelContent(
            body: InfoCarouselCardModelContentBody(explain: [
              InfoCarouselCardModelContentText(
                  text:
                  "Gmail has access to your emails - it reads, stores and analyzes them.\n\nGoogle uses this information for targeted ads and what they call “smart features” like automatically adding your flight information to your calendar.\n\nIn their own words:\n”Google places advertising on Gmail based on key words that appear in messages transmitted through our system (it's a good example of ads helping to pay for the free services we all enjoy online) - so if you're emailing a friend about a trip to Paris, for example, ads might appear on the right hand side of the page for trains to France...”\n\nCreepy.",
                  url: null)
            ], theySay: [
              InfoCarouselCardModelContentIcon(
                  icon: IconProvider.takeoff,
                  text:
                  "Travel assistance like itineraries, updates, and maps."),
              InfoCarouselCardModelContentIcon(
                  icon: IconProvider.email,
                  text:
                  "Smart email with suggestions, nudges, prioritization, and filtering"),
              InfoCarouselCardModelContentIcon(
                  icon: IconProvider.package,
                  text:
                  "Track packages, reservations, loyalty cards, and bills")
            ], shouldKnow: [
              InfoCarouselCardModelContentIcon(
                  icon: IconProvider.tag_1,
                  text: "Used by advertisers for key word targetting"),
              InfoCarouselCardModelContentIcon(
                  icon: IconProvider.legal_hammer,
                  text: "Used by law enforcement"),
              InfoCarouselCardModelContentIcon(
                  icon: IconProvider.globe,
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
                image: ImgProvider.googleGmailRound,
                title: "Your Gmail account",
                share: InfoCarouselCardModelCoverHeaderShare(
                  message:
                  "Gmail knows what you've written to your friends. Find out more on https://www.mytiki.com",
                  //image: AssetImage("res/images/socialmedia2.png", package: "tiki_strategy_google").createStream(configuration)
                )),
            image: ImgProvider.whatYouDo,
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
                  icon: IconProvider.person_dance,
                  text: "Personalized experiences"),
              InfoCarouselCardModelContentIcon(
                  icon: IconProvider.prize,
                  text: "App and content recommendations"),
              InfoCarouselCardModelContentIcon(
                  icon: IconProvider.magnify,
                  text: "Faster Search")
            ], shouldKnow: [
              InfoCarouselCardModelContentIcon(
                  icon: IconProvider.incognito,
                  text: "Your activity is tracked even when logged out"),
              InfoCarouselCardModelContentIcon(
                  icon: IconProvider.bomb,
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
