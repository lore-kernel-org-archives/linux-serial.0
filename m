Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34704C433EF
	for <linux-serial@archiver.kernel.org>; Fri, 26 Nov 2021 21:15:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239971AbhKZVSk (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 26 Nov 2021 16:18:40 -0500
Received: from mail.djicorp.com ([14.21.64.4]:34095 "EHLO mail.djicorp.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S241052AbhKZVQk (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 26 Nov 2021 16:16:40 -0500
IronPort-SDR: Ko89vYmAnkPW+Ptudaf0+kcEQzPgmpgNZLVfvaIvDj9JhZEBU0m47UjlBO8HDv1yY7Brh7q1EV
 11SEntg3nSvA==
X-IronPort-AV: E=Sophos;i="5.87,266,1631548800"; 
   d="scan'208";a="11109430"
From:   wigin zeng <wigin.zeng@dji.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "jslaby@suse.com" <jslaby@suse.com>
Subject: Re: Serial_DMA issue discussion
Thread-Topic: Serial_DMA issue discussion
Thread-Index: AdfilDeun9v41n66R6iv69G0Lzg0TQADS0kAABpDX6Q=
Date:   Fri, 26 Nov 2021 21:13:23 +0000
Message-ID: <31CE3298-6ACD-43A2-8511-F6D9129B71FE@dji.com>
References: <0e1b6299f9a247e4801cb47d64fd0710@MAIL-MBX-cwP11.dji.com>,<YaEONCTJStvkg5KS@kroah.com>
In-Reply-To: <YaEONCTJStvkg5KS@kroah.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

RG8geW91IG1lYW4gcnhfcnVubmluZyBmbGFnIGRlbGV0ZWQgaW4gbGF0ZXN0IHZlcnNpb24ga2Vy
bmVsIO+8nw0KDQpCUnMNCldlaWp1bg0KDQo+IOWcqCAyMDIx5bm0MTHmnIgyN+aXpe+8jDAwOjQx
77yMZ3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmcg5YaZ6YGT77yaDQo+IA0KPiDvu7/jgJBFWFRF
Uk5BTCBFTUFJTOOAkSBETyBOT1QgQ0xJQ0sgYW55IGxpbmtzIG9yIGF0dGFjaG1lbnRzIHVubGVz
cyB5b3UgY2FuIG1ha2Ugc3VyZSBib3RoIHRoZSBzZW5kZXIgYW5kIHRoZSBjb250ZW50IGFyZSB0
cnVzdHdvcnRoeS4NCj4gDQo+IA0KPiDjgJDlpJbpg6jpgq7ku7bmj5DphpLjgJHku6XkuIvpgq7k
u7bmnaXmupDkuo7lhazlj7jlpJbpg6jvvIzor7fli7/ngrnlh7vpk77mjqXmiJbpmYTku7bvvIzp
maTpnZ7mgqjnoa7orqTpgq7ku7blj5Hku7bkurrlkozlhoXlrrnlj6/kv6HjgIINCj4gDQo+IA0K
PiANCj4+IE9uIEZyaSwgTm92IDI2LCAyMDIxIGF0IDA3OjQyOjEwQU0gKzAwMDAsIHdpZ2luIHpl
bmcgd3JvdGU6DQo+PiBUaGlzIGVtYWlsIGFuZCBhbnkgYXR0YWNobWVudHMgdGhlcmV0byBtYXkg
Y29udGFpbiBwcml2YXRlLCBjb25maWRlbnRpYWwsIGFuZCBwcml2aWxlZ2VkIG1hdGVyaWFsIGZv
ciB0aGUgc29sZSB1c2Ugb2YgdGhlIGludGVuZGVkIHJlY2lwaWVudC4gQW55IHJldmlldywgY29w
eWluZywgb3IgZGlzdHJpYnV0aW9uIG9mIHRoaXMgZW1haWwgKG9yIGFueSBhdHRhY2htZW50cyB0
aGVyZXRvKSBieSBvdGhlcnMgaXMgc3RyaWN0bHkgcHJvaGliaXRlZC4gSWYgeW91IGFyZSBub3Qg
dGhlIGludGVuZGVkIHJlY2lwaWVudCwgcGxlYXNlIGNvbnRhY3QgdGhlIHNlbmRlciBpbW1lZGlh
dGVseSBhbmQgcGVybWFuZW50bHkgZGVsZXRlIHRoZSBvcmlnaW5hbCBhbmQgYW55IGNvcGllcyBv
ZiB0aGlzIGVtYWlsIGFuZCBhbnkgYXR0YWNobWVudHMgdGhlcmV0by4NCj4gDQo+IE5vdyBkZWxl
dGVkLg0KPiANCg==
