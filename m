Return-Path: <SRS0=TTKI=74=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED081C433DF
	for <linux-serial@archiver.kernel.org>; Mon, 15 Jun 2020 10:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABBDF2068E
	for <linux-serial@archiver.kernel.org>; Mon, 15 Jun 2020 10:55:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=infinera.com header.i=@infinera.com header.b="bl/5nAcT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728860AbgFOKzK (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 15 Jun 2020 06:55:10 -0400
Received: from mail-bn8nam11on2082.outbound.protection.outlook.com ([40.107.236.82]:50553
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728815AbgFOKzJ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 15 Jun 2020 06:55:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=btGs0/Hac3nccI4oCe4YaF1gvJXQW/RFESovzvdbLZkM7ZH8bjpde1EyrT0V+1wr9uuz2o4eWUSex/e/tDSZfnU3X9uCkgILgfOEvkS7D+kHtHYmBDoCukB4WLPR9q4lNA9g9cq7rSr3NHdlvAn1Cff9uxxSpkBqDpk9vEkFpBsz/i/4mNCOokX1XXKyiTustZiOCSIDEtj8KRHxgYi79b5Q9mKhCrIOLIntCz9s4eUKNQ5XjRf+CS7YjfkmovZkKOaGDewN5uW38FO05j1kXfpWHjNbjNr9YBGfgLXyEj2Urx8NufJUcLz0Z31OK/DnD8Y5BIeA6KSTVPtKvT9qlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=79JG69GG0tHJOgzjFqYpF78BHO8AUosAR0s2euxvyKQ=;
 b=hwI954vhgD4n3h6dz2a8+SEY6g6cVO/XY/w40ofF5jPxsVXJs82KZwDzilbJpKraPNAzxMS0rhaNSle+0ijdggfehjtxPK+Qo3opV9R8wUHl0gtSJFYSJ8xMqyt6Dtk0o9aW1xtPhTcBKLu3draWwqjN4Q2EyLGgMoqgPqYFAOutd17IdkLutKGFllBiNlcwo6BsAuDFnQVt8oaW4v4mi2ijippZOYQJny7ErL8XUW6dpDHtEhumCESFc7a2Sa0zHGxORJNzUDhvndBrtHY/iuS5GM1rXMEHad9IvrtlMn0EGxx+U6U0LASIp2x4UvU4aNu7/gtVrETqDJ2/eCWJLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=infinera.com; dmarc=pass action=none header.from=infinera.com;
 dkim=pass header.d=infinera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infinera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=79JG69GG0tHJOgzjFqYpF78BHO8AUosAR0s2euxvyKQ=;
 b=bl/5nAcT20QrSr2lrKf1yrsPQDxb0ig4msvtyPAsxsDHoPkdA7IpSsc6VOgEWP5EuOI6pNG2ECJDDlKxPpzl6FlAKBxG269TTxRUQizjyzIBPhO+CZ50bWaxag5tfvb44eseL5dVGMyz2YNZtmB4TS2dreVEf7lGaiFqAlJKl60=
Received: from MWHPR1001MB2190.namprd10.prod.outlook.com
 (2603:10b6:301:2e::20) by MWHPR10MB1534.namprd10.prod.outlook.com
 (2603:10b6:300:25::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.18; Mon, 15 Jun
 2020 10:55:05 +0000
Received: from MWHPR1001MB2190.namprd10.prod.outlook.com
 ([fe80::b439:ba0:98d6:c2d1]) by MWHPR1001MB2190.namprd10.prod.outlook.com
 ([fe80::b439:ba0:98d6:c2d1%5]) with mapi id 15.20.3088.028; Mon, 15 Jun 2020
 10:55:04 +0000
From:   Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "oneukum@suse.com" <oneukum@suse.com>
Subject: Re: Default ECHO on TTYs causes unwanted garbage chars
Thread-Topic: Default ECHO on TTYs causes unwanted garbage chars
Thread-Index: AQHWPlKKxJr0ir3sA0SM2brkyH1CUqjQLZMAgAAVM4CAABNYgIAACuAAgAESwgCAAATegIAIEZSA
Date:   Mon, 15 Jun 2020 10:55:04 +0000
Message-ID: <15432ef68356f07000739ec28e482e33a7af9656.camel@infinera.com>
References: <d6d376ceb45b5a72c2a053721eabeddfa11cc1a5.camel@infinera.com>
         <20200609115712.GD819153@kroah.com>
         <984225ab9969a18fc67244a69b71c1534174d4f9.camel@infinera.com>
         <20200609142219.GB831428@kroah.com>
         <d2428c7b828d24fe1eb9b05e2d0d1af52edef846.camel@infinera.com>
         <20200610072438.GG1923109@kroah.com>
         <5f9aaf1c6a6fae5ec33820593a79f5aea03957e9.camel@infinera.com>
In-Reply-To: <5f9aaf1c6a6fae5ec33820593a79f5aea03957e9.camel@infinera.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.3 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=infinera.com;
x-originating-ip: [88.131.87.201]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2a585dcf-1c0a-4d92-3045-08d8111a8fa1
x-ms-traffictypediagnostic: MWHPR10MB1534:
x-microsoft-antispam-prvs: <MWHPR10MB1534B556CF6222E7F397B793F49C0@MWHPR10MB1534.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 04359FAD81
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /Ar1HVcz6+S9ilN68e8NDyDWitQNX1k+JHVx60RABd8j1dqp2Pgdt0Yi/JdsNEw18aQXerbuufV2SQB414ESKTP6B/F8VjTKUQIxGl4vf37sDk/a9JMaVMbU0Ruby1mT7ALao84Vs1ot+C206uWqZcw0KBFCoxvyyUKlLnni3lvKdAw+bfJvvq4wx4Bdv3tb9kwyqYPzoPaqTIHsex+uT/UkLIAfMSVyQxBLfeswrje3WMFYFwunWbtRGMGw/jmrL358YKI1NrwTaQBQtkuSBpmRf4GtY3pLmwZlnuyqyqmaMVS2UaX2eoGFmDwWErZ9mkCR/quRRT3SyqfALLdVPtPmq/AFRPewx+8UHhLx/Z1oqm0j3xWnOVbkMCnLlAQ1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2190.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39850400004)(346002)(396003)(366004)(136003)(376002)(86362001)(66946007)(186003)(6506007)(8936002)(5660300002)(4326008)(8676002)(26005)(2616005)(66476007)(66556008)(66446008)(6916009)(36756003)(64756008)(76116006)(71200400001)(478600001)(316002)(6486002)(2906002)(91956017)(83380400001)(54906003)(6512007)(26123001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: /2mirTxOjPp/CUfB59nd5AefacCtIuUd2jpa7riFXZlP+VYxyI/eju4bapvwSZsgIMy9k/++fyp3zEFm9ybU6vRL1drARUjNz0eOONEyrOSn1L1QdI4OPQ9eaTj/GhD+Ere8lzDg1561Ee5TqEaFNVcaa4QeYJGTCl9cJ9CW/hXoQkRQSddD1QVfqukyAFvtI8zfgpYnNcgyOwWiHqh96EVhEborzdiB+E6UU6ohC915eIuddN8pFD5dhgamxC4h6LiHlrMsEktaflOj+3KKYupGLGCo1tr43vTuLFvOgMzwOX9+C+7YZTbLHqdOEkKGbkmOkt3T6IGk8xiJ4XVBnD+oj2nJOwm382A8A+kYzUYM2SzzrAv9MNBeudmoRCVLkJ3Qh++HAHKJGAPylrD+u5x0lMsysjudcuIOIySH5vqxAvf1QPs691JsZeIRT20/qfyMqTvy+AYcn3B6EkDnnzpkiAp3H5ZT+n4r3/l6H2Y=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <FB224A0E66F36640800F94A9EFC9489A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: infinera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a585dcf-1c0a-4d92-3045-08d8111a8fa1
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2020 10:55:04.7203
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 285643de-5f5b-4b03-a153-0ae2dc8aaf77
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z7B1v3oTcz2BkASTZ898aZnRdvgQFLLjy0ESaQiOUKvji7bCGPbY90F/1+Z7i22k//5Jh/fDCMldRXfbeEXvQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1534
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

T24gV2VkLCAyMDIwLTA2LTEwIGF0IDA5OjQyICswMjAwLCBKb2FraW0gVGplcm5sdW5kIHdyb3Rl
Og0KPiBPbiBXZWQsIDIwMjAtMDYtMTAgYXQgMDk6MjQgKzAyMDAsIGdyZWdraEBsaW51eGZvdW5k
YXRpb24ub3JnIHdyb3RlOg0KPiA+IENBVVRJT046IFRoaXMgZW1haWwgb3JpZ2luYXRlZCBmcm9t
IG91dHNpZGUgb2YgdGhlIG9yZ2FuaXphdGlvbi4gRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4g
YXR0YWNobWVudHMgdW5sZXNzIHlvdSByZWNvZ25pemUgdGhlIHNlbmRlciBhbmQga25vdyB0aGUg
Y29udGVudCBpcyBzYWZlLg0KPiA+IA0KPiA+IA0KPiA+IE9uIFR1ZSwgSnVuIDA5LCAyMDIwIGF0
IDAzOjAxOjE0UE0gKzAwMDAsIEpvYWtpbSBUamVybmx1bmQgd3JvdGU6DQo+ID4gPiBPbiBUdWUs
IDIwMjAtMDYtMDkgYXQgMTY6MjIgKzAyMDAsIGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnIHdy
b3RlOg0KPiA+ID4gPiBPbiBUdWUsIEp1biAwOSwgMjAyMCBhdCAwMToxMzowNlBNICswMDAwLCBK
b2FraW0gVGplcm5sdW5kIHdyb3RlOg0KPiA+ID4gPiA+IE9uIFR1ZSwgMjAyMC0wNi0wOSBhdCAx
Mzo1NyArMDIwMCwgR3JlZyBLSCB3cm90ZToNCj4gPiA+ID4gPiA+IE9uIFR1ZSwgSnVuIDA5LCAy
MDIwIGF0IDExOjM4OjQ5QU0gKzAwMDAsIEpvYWtpbSBUamVybmx1bmQgd3JvdGU6DQo+ID4gPiA+
ID4gPiA+IEhpIExpc3QNCj4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+IEkgd2FzIGFkdmlz
ZWQgdG8gY29tZSBoZXJlIHdpdGggdGhpcyBwcm9ibGVtKHN0YXJ0ZWQgb24gdGhlIFVTQiBsaXN0
KS4NCj4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+IFdlIGhhdmUgYSBVU0IgdG8gUlMyMzIg
YnJpZGdlIHdoaWNoIHByZXNlbnRzIGl0c2VsZiBhcyBhbiB0dHlBQ00gYW5kIHRoZSBmaXJzdCBj
b25uZWN0IGFmdGVyIHBvd2VyIG9uLA0KPiA+ID4gPiA+ID4gPiB3ZSBzZWUgc29tZSBnYXJiYWdl
IGNoYXJzIHRyYW5zbWl0dGVkIGJhY2sgZnJvbSBVU0IgaG9zdChQQykgdG8gb3V0IGRldmljZSB3
aGljaCBiZWNvbWVzIGlucHV0IHRvDQo+ID4gPiA+ID4gPiA+IHRoZSBkZXZpY2UuDQo+ID4gPiA+
ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiBBZnRlciBtdWNoIGRlYnVnZ2luZyBJIGZvdW5kIHRoYXQg
dGhpcyBhcmUgY2hhcnMgc2VudCBlYXJseSBpbiB0aGUgYm9vdCBwcm9jZXNzIHdoaWNoIHRoZW4N
Cj4gPiA+ID4gPiA+ID4gYXJlIGJ1ZmZlcmVkIGFuZCB0aGUgVFRZcyBkZWZhdWx0IHRvIEVDSE8g
Y2hhcnMgaXMgdGhlIGNhdXNlLg0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBTbyBzb21lIHBy
b2dyYW0gaW4gdGhlIGJvb3Qgc2VxdWVuY2UgaXMgdHJ5aW5nIHRvIHNlbmQgZGF0YSBvdXQgdGhl
DQo+ID4gPiA+ID4gPiBkZXZpY2U/ICBXaHkgbm90IGp1c3Qgbm90IGRvIHRoYXQ/DQo+ID4gPiA+
ID4gDQo+ID4gPiA+ID4gVGhpcyBpcyB0aGUgYm9vdCBjb25zb2xlLiBCb3RoIHUtYm9vdCBhbmQg
TGludXggcHJpbnRzIGEgbG90IHRoZXJlLCB0aGVuIGluaXQgcHJpbnRzIHdoaWxlIHN0YXJ0aW5n
IHNlcnZpY2VzDQo+ID4gPiA+IA0KPiA+ID4gPiBTbyB0aGUgc2FtZSBkZXZpY2UgaXMgdXNlZCBm
b3IgYm9vdCBjb25zb2xlIGFzIHdlbGwgYXMgYSB0dHlBQ00gZGV2aWNlDQo+ID4gPiA+IGxhdGVy
IG9uPw0KPiA+ID4gDQo+ID4gPiBOb3QgcXVpdGUsIHRoZSBVU0IgdG8gUlMyMzIgY2hpcCBpcyBp
bnRlZ3JhdGVkIG9uIHRoZSBkZXZpY2UgYW5kIGlzIGNvbm5lY3RlZCB0aGUgQ1BVcyBSUzIzMiwN
Cj4gPiA+IHRoZXJlIGlzIG5vIG90aGVyIHBvcnQuDQo+ID4gPiBJIHRoaW5rIHlvdSBjb3VsZCBj
b21wYXJlIHdpdGggYW4gZXh0ZXJuYWwgVVNCIHRvIFJTMjMyIHB1Y2suIFNlbmFyaW86DQo+ID4g
PiAtIENvbm5lY3QgdGhlIHB1Y2sgdG8gYm90aCBjb21wdXRlciBhbmQgeW91ciBkZXZpY2Ugd2l0
aCBhbiBSUzIzMiBwb3J0Lg0KPiA+ID4gLSBQb3dlciBvbiB0aGUgZGV2aWNlIHdpdGggdGhlIFJT
MjMyIHBvcnQuDQo+ID4gPiAtIERldmljZSAiYm9vdHMiIGFuZCBwcmludHMgc3R1ZmYgb24gaXRz
IFJTMjMyIHBvcnQsDQo+ID4gPiANCj4gPiA+IHNvbWUgdGltZSBwYXNzZXMNCj4gPiA+IA0KPiA+
ID4gLSBPcGVuIHR0eUFDTSBpbiBQQyB1c2luZyBtaW5pY29tL2N1DQo+ID4gPiBOb3cgZWFybHkg
aGlzdG9yeSBvZiB0aGUgYm9vdCBwcmludHMgYXJlIGVjaG9lZCBiYWNrIGZyb20gUEMgdG8gZGV2
aWNlIHdpdGggUlMyMzINCj4gPiANCj4gPiBBaCwgb2ssIHNvLCBhcmUgeW91IHN1cmUgdGhhdCBk
YXRhIGlzbid0IGp1c3QgInN0dWNrIiBpbiB0aGUgVVNCLXNlcmlhbA0KPiA+IGNoaXAncyBidWZm
ZXJzPyAgVGhhdCdzIG9mdGVuIHRoZSBjYXNlIHdpdGggbWFueSBkZXZpY2VzIGFzIHRoZXkgYXJl
DQo+ID4gdGlueSBhbmQgZHVtYiBhbmQgdHJ5IHRvIGRvIHRoZSByaWdodCB0aGluZyBtb3N0IG9m
IHRoZSB0aW1lIChsaWtlIG5vdA0KPiA+IGRyb3AgZGF0YSB0aGF0IHdhcyBzZW50IHRvIGl0LikN
Cj4gDQo+IG5vdCAxMDAlIG5vIGJ1dCBldmVuIGlmIGl0IHdhcywgd2h5IHdvdWxkIHRoZSBQQyBl
Y2hvIGJhY2sgY2hhcnMgYmVjYXVzZSB0aGUgVFRZIGdldHMgb3BlbmVkPw0KPiBJIGNhbiBzZWUg
dGhhdCB0aGF0IHRoZSBjaGFycyBhcmUgc2VudCBiYWNrIGJ5IHRoZSBQQywgbm90IGp1c3Qgc3Vy
ZSBpZiB0aGUgUEMgcmVjZWl2ZWQgdGhlbQ0KPiBhdCB0aGF0IHNhbWUgdGltZSBvciBpZiB0aGUg
UEMgZ290IHRoZW0gd2hlbiB0aGUgY2FibGUgd2FzIGNvbm5lY3RlZCwgc3RvcmVkIGluc2lkZSBz
b21lIGRyaXZlciBhbmQNCj4gd3JpdHRlbiBiYWNrIG9uY2UgdGhlIFRUWSBpcyBvcGVuZWQsIGJl
Zm9yZSBvbmUgaGF2ZSBoYWQgYSBjaGFuY2UgdG8gYWRqdXN0IGJhdWRyYXRlL2VjaG8gZXRjLj8N
Cj4gDQo+ICAgSm9ja2UNCg0KR2VudGxlIHJlbWluZGVyIC4uDQoNCkl0IGFsc28gb2NjdXJzIHRv
IHRvIG1lIHRoYXQgY3VycmVudCBUVFkgYmVoYXZpb3VyIHdvdWxkIGFsc28gRUNITyBhbnkgY2hh
cnMgcmVjZWl2ZWQgYmV0d2VlbiBvcGVuaW5nDQp0aGUgVFRZIGFuZCB0dXJuaW5nIEVDSE8gb2Zm
LiBUaGUgd2luZG93IGlzIHNtYWxsZXIgYnV0IGl0IGlzIHRoZXJlLg0KDQogSm9ja2UNCg==
