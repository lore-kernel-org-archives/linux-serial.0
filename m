Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80D05C433F5
	for <linux-serial@archiver.kernel.org>; Fri, 12 Nov 2021 11:58:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D54C60EDF
	for <linux-serial@archiver.kernel.org>; Fri, 12 Nov 2021 11:58:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbhKLMA6 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 12 Nov 2021 07:00:58 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:32941 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231147AbhKLMA6 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 12 Nov 2021 07:00:58 -0500
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-144-04oWtkXhM5Oorg69LcgY0Q-1; Fri, 12 Nov 2021 11:58:02 +0000
X-MC-Unique: 04oWtkXhM5Oorg69LcgY0Q-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.24; Fri, 12 Nov 2021 11:58:02 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.024; Fri, 12 Nov 2021 11:58:02 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Wander Costa' <wcosta@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     "wander@redhat.com" <wander@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Johan Hovold <johan@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] tty: serial: Use fifo in 8250 console driver
Thread-Topic: [PATCH] tty: serial: Use fifo in 8250 console driver
Thread-Index: AQHX1iwApPqiFiv0qkyAdEKbdICLoKv/zESA
Date:   Fri, 12 Nov 2021 11:58:02 +0000
Message-ID: <590acddcf63344cd9a3295256b118586@AcuMS.aculab.com>
References: <20211029201402.428284-1-wander@redhat.com>
 <CAHp75VeZBp4gKvGBDzaD=EpGRDZ1-wTvD8K9Ui6Q59kDjmkXmQ@mail.gmail.com>
 <CAAq0SUmzHqEzNk3aw3SEgYVWRukQeHK1WtcJ3MjXcQKJrbC1Dw@mail.gmail.com>
 <CAHp75Vf6DjNcPWpE4Dh3SuzUMJbFQjq1UNCkrCa60uw35SpqKg@mail.gmail.com>
 <CAAq0SU=wYZ9e9NJvwcLvEvxj-J7PhAPFjRAu2uFVYPprR7A_qQ@mail.gmail.com>
In-Reply-To: <CAAq0SU=wYZ9e9NJvwcLvEvxj-J7PhAPFjRAu2uFVYPprR7A_qQ@mail.gmail.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

PiA+IEhlcmUgaXMgYSB0cmFuc2xhdGlvbiBvZiBteSBjb21tZW50IHRvIGEgcm9hZG1hcC4NCj4g
Pg0KPiA+IDEuIEludHJvZHVjZSB5ZXQgYW5vdGhlciBVQVJUIHF1aXJrIG9yIGNhcGFiaWxpdHkg
KHNlZSBjb3JyZXNwb25kaW5nDQo+ID4gVUFSVF9DQVBfKiBvciBVQVJUXypfUVVJUksgZGVmaW5p
dGlvbnMpDQo+ID4gMi4gQWRkIHlvdXIgcGF0Y2ggY29uZGl0aW9uYWxseSBiYXNlZCBvbiB0aGUg
YWJvdmUNCj4gPiAzLiBFbmFibGUgaXQgb24gVUFSVChzKSB5b3UgX2hhdmUgdGVzdGVkXw0KPiA+
DQo+IFRoYW5rIHlvdSBmb3IgdGhlIGZlZWRiYWNrLCBJIHN1Ym1pdHRlZCBhIHYyIHBhdGNoIHdp
dGggeW91ciBwcm9wb3NlZCBjaGFuZ2VzLA0KDQpPciBwdXQgdGhlIFVBUlQgaW50byBsb29wYmFj
ayBhbmQgc2VlIGhvdyBtYW55IGNoYXJhY3RlcnMgd2lsbA0KYWN0dWFsbHkgZml0IGluIHRoZSBm
aWZvcy4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxl
eSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0
aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

