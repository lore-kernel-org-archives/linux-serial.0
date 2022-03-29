Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1908C433EF
	for <linux-serial@archiver.kernel.org>; Tue, 29 Mar 2022 12:55:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236869AbiC2M5f (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 29 Mar 2022 08:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236877AbiC2M5c (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 29 Mar 2022 08:57:32 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 554A3B6C
        for <linux-serial@vger.kernel.org>; Tue, 29 Mar 2022 05:55:47 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-306-5I-tp7LzNCi51Sa3kT1ULw-1; Tue, 29 Mar 2022 13:55:43 +0100
X-MC-Unique: 5I-tp7LzNCi51Sa3kT1ULw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.32; Tue, 29 Mar 2022 13:55:42 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.033; Tue, 29 Mar 2022 13:55:42 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Matthias Schiffer' <matthias.schiffer@ew.tq-group.com>,
        Lukas Wunner <lukas@wunner.de>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>,
        "Lino Sanfilippo" <LinoSanfilippo@gmx.de>
Subject: RE: [PATCH] serial: Revert RS485 polarity change on UART open
Thread-Topic: [PATCH] serial: Revert RS485 polarity change on UART open
Thread-Index: AQHYQ1k5q26PsxFKq0WuXVn++R8i1qzWT4pQ
Date:   Tue, 29 Mar 2022 12:55:42 +0000
Message-ID: <749eee7dd2c7464a8c4d9ea5972205fa@AcuMS.aculab.com>
References: <20220329085050.311408-1-matthias.schiffer@ew.tq-group.com>
         <20220329100328.GA2090@wunner.de>
 <b2f29129f966685105e09781620b85c8f4f1a88e.camel@ew.tq-group.com>
In-Reply-To: <b2f29129f966685105e09781620b85c8f4f1a88e.camel@ew.tq-group.com>
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

RnJvbTogTWF0dGhpYXMgU2NoaWZmZXINCj4gU2VudDogMjkgTWFyY2ggMjAyMiAxMTozOQ0KLi4u
DQo+IEkgZ3Vlc3MgdGhhdCB3b3VsZCB3b3JrLiBUaGUgZmFjdCB0aGF0IGV2ZW4gdGhlIGRpZmZl
cmVudA0KPiB2YXJpYW50cyBvZiB0aGUgODI1MCBhcmUgaW1wbGVtZW50ZWQgaW5jb25zaXN0ZW50
bHkgbWFrZXMgdGhpcw0KPiBlc3BlY2lhbGx5IHVnbHkuLi4gSXQgY2VydGFpbmx5IHB1dHMgYSBk
YW1wZXIgb24gdGhlIGVmZm9ydHMgdG8gbWFrZQ0KPiB0aGUgaGFuZGxpbmcgb2YgUlM0ODUgaW4g
c2VyaWFsIGRyaXZlcnMgbW9yZSBnZW5lcmljLg0KDQpPbmUgdGhpbmcgdG8gcmVtZW1iZXIgaXMg
dGhhdCBSUzIzMiAoSUlSQyByZWFsbHkgVi4zOCkgbGluZSBkcml2ZXINCmNoaXBzIGFyZSB0eXBp
Y2FsbHkgaW52ZXJ0aW5nLg0KDQpTbyB0aGUgbW9kZW0gc2lnbmFscyBvbiBhIFRUTCBsZXZlbCBv
dXRwdXQgd2lsbCBoYXZlIHRoZQ0Kb3Bwb3NpdGUgcG9sYXJpdHkgdG8gdGhhdCByZXF1aXJlZCBv
biB0aGUgYWN0dWFsIGNvbm5lY3Rvci4NCg0KTm9ybWFsbHkgYSBVQVJUIHdpbGwgaGF2ZSBhbiAn
YWN0aXZlIGhpZ2gnIHJlZ2lzdGVyIGJpdCBmb3INCmEgbW9kZW0gc2lnbmFsIHRoYXQgZHJpdmVz
IGFuZCAnYWN0aXZlIGxvdycgcGluIHNvIHlvdSBnZXQNCnRoZSBjb3JyZWN0IHBvbGFyaXR5IHdp
dGggYW4gaW52ZXJ0aW5nIGxpbmUgZHJpdmVyLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBB
ZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMs
IE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

