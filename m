Return-Path: <SRS0=2Hcl=7W=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0578C433E0
	for <linux-serial@archiver.kernel.org>; Tue,  9 Jun 2020 15:01:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65275207ED
	for <linux-serial@archiver.kernel.org>; Tue,  9 Jun 2020 15:01:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=infinera.com header.i=@infinera.com header.b="YXjqkbae"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730495AbgFIPBY (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 9 Jun 2020 11:01:24 -0400
Received: from mail-bn8nam12on2067.outbound.protection.outlook.com ([40.107.237.67]:37825
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730539AbgFIPBV (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 9 Jun 2020 11:01:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bw6TTxvD1xsXsutlgvg44m2MKJQYpYIEzDHoK+E5lohB1gm5En6imw9DP5ZBgv0klGx7UCOaHJv14m7119NAnHFLiKFMqunUZO7kWYz4bdz/mZWlCNcaIo4G5EUtSzSFYHpqHm93sghjC2mVQjs0DBWhYJJ5oQAl3TFG/0ZP215aokbFuPE6UZspJl5zXjkkN0ILNJIaM51NzybyLfeaH6tiZKQwTEif3aRwt7cU9uIVhculv+qSzgxdCP5tRX15MFuprusP4dkFYbBSh7NBSEOq028cqhwpsbsWOEoT6adPble14k1MTExCa9iLulZRuCN5x4bgj7WrA7sEOkuApA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8rPaICoRo7UtfIkTIbefgJjLZSBmy6Eabr9cPkbelKQ=;
 b=mICHv92qyIY61OfG5FheGJdSrFEtpWyhl++nP9Uupnkw0/CMCnYbnf9iC9vuUroYzZsR/BLE9rGwG1quy0IzH2rhDFHwJFazcJaDHd6gI9tgLm2vxIS+0IBXSdc7VGnkYir8WAS1PKaqIsbqh6ywsbd05sDibc0R9OF9viUbmN8L8VeNpgJuJTGfUwKFDyzKVW3rxhddqYRerCpMiST2no+Gik43TEht9Q+KemFgAA29b0S6po6JP+DXmruK426TpC21vniN8Mx3sLu5YywPTGzMFeLALdiOQpVU0j48vOBb0vbqM6JDyOz475xyVLreH3ZuEQREwur+NcXKcrdkgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=infinera.com; dmarc=pass action=none header.from=infinera.com;
 dkim=pass header.d=infinera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infinera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8rPaICoRo7UtfIkTIbefgJjLZSBmy6Eabr9cPkbelKQ=;
 b=YXjqkbaeEmlV/FIEwaNFM3BBXrCSGc5Is2+iEvpAVUEuB0WuDqbArKrugtR+gQGf6EcLlnVFRxpXabsC8jaK36SoUU4d++/MUcZZB6Mvqq9tkTp3vz/aXLJ3kv/NKHD+YkqJLFT66V2krg1hVCPRGCsMLSCj/+UNJ4OcY6JxGaQ=
Received: from BN8PR10MB3540.namprd10.prod.outlook.com (2603:10b6:408:ae::24)
 by BN8PR10MB3537.namprd10.prod.outlook.com (2603:10b6:408:b5::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.22; Tue, 9 Jun
 2020 15:01:15 +0000
Received: from BN8PR10MB3540.namprd10.prod.outlook.com
 ([fe80::c158:d59f:e3bc:1941]) by BN8PR10MB3540.namprd10.prod.outlook.com
 ([fe80::c158:d59f:e3bc:1941%2]) with mapi id 15.20.3066.023; Tue, 9 Jun 2020
 15:01:15 +0000
From:   Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "oneukum@suse.com" <oneukum@suse.com>
Subject: Re: Default ECHO on TTYs causes unwanted garbage chars
Thread-Topic: Default ECHO on TTYs causes unwanted garbage chars
Thread-Index: AQHWPlKKxJr0ir3sA0SM2brkyH1CUqjQLZMAgAAVM4CAABNYgIAACuAA
Date:   Tue, 9 Jun 2020 15:01:14 +0000
Message-ID: <d2428c7b828d24fe1eb9b05e2d0d1af52edef846.camel@infinera.com>
References: <d6d376ceb45b5a72c2a053721eabeddfa11cc1a5.camel@infinera.com>
         <20200609115712.GD819153@kroah.com>
         <984225ab9969a18fc67244a69b71c1534174d4f9.camel@infinera.com>
         <20200609142219.GB831428@kroah.com>
In-Reply-To: <20200609142219.GB831428@kroah.com>
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
x-ms-office365-filtering-correlation-id: c6c9840e-d313-455b-dcc0-08d80c85f4d5
x-ms-traffictypediagnostic: BN8PR10MB3537:
x-microsoft-antispam-prvs: <BN8PR10MB3537F87C3B689DAC78BDF213F4820@BN8PR10MB3537.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 042957ACD7
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gYNo/dJVbgboQACx/rR3AQ96z+CKTSOvdbF8I9up14xint7IqYpHWD77MvAY3I5TBwBSLYgauIRJn+RzwE3ER5B2Pgt+Bi5EV1/TDxVmfMr1dqTPAd0iCaDc0/R03c+XQMO5z3+hnnSOMs2NZjwyJ59Agug4TWp1fPgs8QEKZ9ytlpaZw9El4L5taOzh1ziPbQgMRHlfmcxmLHzciQuN5dbXlXuKi1S5YN6mAmrsLB6iAxYln/R6CMa56mNnirH42YNi+B3F31k3LD71/d8R/hDUHe+6rzlISuzDmvyPhUyffr+iy3pIgLQnZop+UD98hklMPstav9VGgYm1F6dGOxVWKFjjpZhET4YTMLPaj+kvVV+DoskZXd3gSZuEjGas
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR10MB3540.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(396003)(366004)(376002)(39860400002)(346002)(66476007)(6916009)(83380400001)(36756003)(5660300002)(8936002)(316002)(478600001)(2616005)(2906002)(54906003)(6486002)(66446008)(6506007)(4326008)(6512007)(91956017)(66946007)(86362001)(186003)(66556008)(64756008)(26005)(76116006)(8676002)(71200400001)(26123001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: C4iS61gGIs3bNSrS/1ttzZnX70wMnvFrkGKo2xorQIqRSt7RxSRDsy5TFPbuwoVb5ZJLH3N5Ajl/C/QCwNeVOo7dEFNfI0aPSCRjWIf61Xwo5q7qGleDGwCa/lYOipUWHWAKSPcjuN/o+mFJ8pOK+uOubQFf1fyqCHvR2mVoYn2C9yrzagfWAV2Rso8naT0/XABPNuDWnR6j2ap/rT7OHDgvyYswejRJ5yUlLmTTOhBCvnz0davEQYotCtKALFVjm3QJtDJiFVBqMRdBwGrqfTMdsnao62WeTIJpG9QgSKzq8PwEzXkq7T2GTRiT2af1TUMzPv5pjzQbK07yORfPaKpyNDeN03bfy42kb018Zpu3UjsXjUB9H1ohR4Wsh/X2LyXXtenuJRZfrU09YuYg171NKyvbZw3rmZHcIo75zSsk/3AuWA0dPDh4pOeiGx42OeU1QKP2Fxw7L/Gtkea3tPPNTHY8fVfReaOjQYPzWWQ=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <DF2044E783737B4FB19467B0C024F0D8@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: infinera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6c9840e-d313-455b-dcc0-08d80c85f4d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2020 15:01:14.9525
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 285643de-5f5b-4b03-a153-0ae2dc8aaf77
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TQfLjJiICc8erFWCpIc+oL3LwT4/n66CMF6xdMOGpEvw+AtoXAXT5b25AE/4+poPo+ZZFr6ma1ClAqjLMC0lSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3537
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

T24gVHVlLCAyMDIwLTA2LTA5IGF0IDE2OjIyICswMjAwLCBncmVna2hAbGludXhmb3VuZGF0aW9u
Lm9yZyB3cm90ZToNCj4gDQo+IE9uIFR1ZSwgSnVuIDA5LCAyMDIwIGF0IDAxOjEzOjA2UE0gKzAw
MDAsIEpvYWtpbSBUamVybmx1bmQgd3JvdGU6DQo+ID4gT24gVHVlLCAyMDIwLTA2LTA5IGF0IDEz
OjU3ICswMjAwLCBHcmVnIEtIIHdyb3RlOg0KPiA+ID4gT24gVHVlLCBKdW4gMDksIDIwMjAgYXQg
MTE6Mzg6NDlBTSArMDAwMCwgSm9ha2ltIFRqZXJubHVuZCB3cm90ZToNCj4gPiA+ID4gSGkgTGlz
dA0KPiA+ID4gPiANCj4gPiA+ID4gSSB3YXMgYWR2aXNlZCB0byBjb21lIGhlcmUgd2l0aCB0aGlz
IHByb2JsZW0oc3RhcnRlZCBvbiB0aGUgVVNCIGxpc3QpLg0KPiA+ID4gPiANCj4gPiA+ID4gV2Ug
aGF2ZSBhIFVTQiB0byBSUzIzMiBicmlkZ2Ugd2hpY2ggcHJlc2VudHMgaXRzZWxmIGFzIGFuIHR0
eUFDTSBhbmQgdGhlIGZpcnN0IGNvbm5lY3QgYWZ0ZXIgcG93ZXIgb24sDQo+ID4gPiA+IHdlIHNl
ZSBzb21lIGdhcmJhZ2UgY2hhcnMgdHJhbnNtaXR0ZWQgYmFjayBmcm9tIFVTQiBob3N0KFBDKSB0
byBvdXQgZGV2aWNlIHdoaWNoIGJlY29tZXMgaW5wdXQgdG8NCj4gPiA+ID4gdGhlIGRldmljZS4N
Cj4gPiA+ID4gDQo+ID4gPiA+IEFmdGVyIG11Y2ggZGVidWdnaW5nIEkgZm91bmQgdGhhdCB0aGlz
IGFyZSBjaGFycyBzZW50IGVhcmx5IGluIHRoZSBib290IHByb2Nlc3Mgd2hpY2ggdGhlbg0KPiA+
ID4gPiBhcmUgYnVmZmVyZWQgYW5kIHRoZSBUVFlzIGRlZmF1bHQgdG8gRUNITyBjaGFycyBpcyB0
aGUgY2F1c2UuDQo+ID4gPiANCj4gPiA+IFNvIHNvbWUgcHJvZ3JhbSBpbiB0aGUgYm9vdCBzZXF1
ZW5jZSBpcyB0cnlpbmcgdG8gc2VuZCBkYXRhIG91dCB0aGUNCj4gPiA+IGRldmljZT8gIFdoeSBu
b3QganVzdCBub3QgZG8gdGhhdD8NCj4gPiANCj4gPiBUaGlzIGlzIHRoZSBib290IGNvbnNvbGUu
IEJvdGggdS1ib290IGFuZCBMaW51eCBwcmludHMgYSBsb3QgdGhlcmUsIHRoZW4gaW5pdCBwcmlu
dHMgd2hpbGUgc3RhcnRpbmcgc2VydmljZXMNCj4gDQo+IFNvIHRoZSBzYW1lIGRldmljZSBpcyB1
c2VkIGZvciBib290IGNvbnNvbGUgYXMgd2VsbCBhcyBhIHR0eUFDTSBkZXZpY2UNCj4gbGF0ZXIg
b24/DQoNCk5vdCBxdWl0ZSwgdGhlIFVTQiB0byBSUzIzMiBjaGlwIGlzIGludGVncmF0ZWQgb24g
dGhlIGRldmljZSBhbmQgaXMgY29ubmVjdGVkIHRoZSBDUFVzIFJTMjMyLA0KdGhlcmUgaXMgbm8g
b3RoZXIgcG9ydC4NCkkgdGhpbmsgeW91IGNvdWxkIGNvbXBhcmUgd2l0aCBhbiBleHRlcm5hbCBV
U0IgdG8gUlMyMzIgcHVjay4gU2VuYXJpbzoNCi0gQ29ubmVjdCB0aGUgcHVjayB0byBib3RoIGNv
bXB1dGVyIGFuZCB5b3VyIGRldmljZSB3aXRoIGFuIFJTMjMyIHBvcnQuDQotIFBvd2VyIG9uIHRo
ZSBkZXZpY2Ugd2l0aCB0aGUgUlMyMzIgcG9ydC4NCi0gRGV2aWNlICJib290cyIgYW5kIHByaW50
cyBzdHVmZiBvbiBpdHMgUlMyMzIgcG9ydCwNCg0Kc29tZSB0aW1lIHBhc3Nlcw0KDQotIE9wZW4g
dHR5QUNNIGluIFBDIHVzaW5nIG1pbmljb20vY3UNCk5vdyBlYXJseSBoaXN0b3J5IG9mIHRoZSBi
b290IHByaW50cyBhcmUgZWNob2VkIGJhY2sgZnJvbSBQQyB0byBkZXZpY2Ugd2l0aCBSUzIzMg0K
DQpQUzoNCiAgICBPbGl2ZXIsIHBsZWFzZSBoZWxwIG1lIG1ha2UgdGhpcyBjbGVhci4gWW91IHNl
bnQgbWUgaGVyZSA6KQ0KDQo+IA0KPiA+ID4gPiBXaGVuIHRoZSBUVFkgaXMgb3BlbmVkLCBhbnkg
Y2hhcnMgaW4gdGhlIHRoaXMgYnVmZmVyIGlzIEVDSE9lZCBiYWNrIG92ZXIgVVNCIHRvIHRoZSBk
ZXZpY2UsDQo+ID4gPiA+IGJlZm9yZSBvbmUgaGFzIGEgY2hhbmNlIHRvIGRpc2FibGUgRUNITy4g
VGhlIGRldmljZSB0aGVuIHRoaW5rcyB0aGVzZSBjaGFycyBhcmUgcmVndWxhciBpbnB1dC4NCj4g
PiA+IA0KPiA+ID4gV2FpdCwgeW91IHNhaWQgc29tZXRoaW5nIGluIHRoZSBib290IHByb2Nlc3Mg
ZGlkIHdyaXRlIHRvIHRoZSBkZXZpY2UsDQo+ID4gPiB3aGljaCB3b3VsZCBoYXZlIGNhdXNlZCB0
aGUgdHR5IHRvIGJlIG9wZW5lZCB0aGVuLCByaWdodD8NCj4gPiANCj4gPiB3ZWxsLCBib290IHBy
b2Nlc3Mgb2YgdGhlIGRldmljZSBwcmludHMgYW5kIGl0IGlzIGVub3VnaCBmb3IgdGhlIFVTQiBj
YWJsZSB0byBiZSBhdHRhY2hlZCBidXQgbm90IG9wZW5lZCBieSBhbnkgYXBwLg0KPiA+IFRoZSBk
ZXZpY2UganVzdCBzZWUgYW4gVUFSVCBhbmQgcHJpbnRzIHdoZW4gVUFSVCBpcyBpbml0aWFsaXpl
ZC4NCj4gDQo+IFdoYXQgdG9vbCBkb2VzIHRoYXQ/ICBXaHkgbm90IGZpeCB0aGF0Pw0KPiANCj4g
PiA+ID4gU2VlbXMgdG8gbWUgdGhhdCB0aGlzIGJlaGF2aW91ciBpcyB1bndhbnRlZCBpbiBnZW5l
cmFsIGFuZCBhbmQgYXBwLiBzaG91bGQgZ2V0IGEgY2hhbmNlIHRvIGZsdXNoL2Rpc2NhcmQNCj4g
PiA+ID4gYW55IGNoYXJzIHNvIHRoaXMgZG9lcyBub3QgaGFwcGVuLg0KPiA+ID4gDQo+ID4gPiBX
aGVyZSBhcmUgdGhlIGNoYXJhY3RlcnMgY29taW5nIGZyb20gdGhhdCB3b3VsZCBuZWVkIHRvIGJl
IGZsdXNoZWQ/DQo+ID4gDQo+ID4gRWFybHkgb3V0cHV0IGZyb20gYm9vdCwgYmFzaWNhbGx5IHdo
YXRldmVyIHByaW50cyBqdXN0IGFmdGVyIGNvbm5lY3RpbmcgdGhlIFVTQiBjYWJsZS4NCj4gDQo+
IFRoZW4gZG9uJ3QgaGF2ZSBib290IHByaW50IHRvIHRoYXQgZGV2aWNlIDopDQo+IA0KPiA+ID4g
V2hlbiBzaG91bGQgY2hhcmFjdGVycyBiZSBmbHVzaGVkIGV4YWN0bHk/DQo+ID4gDQo+ID4gV2hh
dGV2ZXIgaXMgaW4gdGhlIGJ1ZmZlcnMgYmVmb3JlIG9wZW5pbmcgdGhlIHR0eS4NCj4gDQo+IEJ1
dCB3aGF0IGlzIHN1cHBvc2VkIHRvIGhhcHBlbiB0byB0aGUgZGF0YSB0aGF0IHdhcyBzZW50IHRv
IGl0IHdoaWxlIGl0DQo+IHdhcyAiY2xvc2VkIj8NCj4gDQo+ID4gVGhlIHRlcm1pbmFsIGFwcChs
aWtlIGN1KSB0cmllcyB0byBmbHVzaCBhbnkgaW5wdXQgd2hlbiBpdCBzdGFydHMsIGp1c3QgdG8g
YXZvaWQgYW55IG9sZCBjaGFycyBpbiB0aGUNCj4gPiBxdWV1ZSBidXQgaXQgaXMgdG8gbGF0ZSB0
aGVuLg0KPiANCj4gSSBzdHJvbmdseSBqdXN0IHN1Z2dlc3QgaGF2aW5nIHVzZXJzcGFjZSBub3Qg
d3JpdGUgdG8gdGhlIGRldmljZSB0bw0KPiBzdGFydCB3aXRoLCB0aGF0IHdvdWxkIHNvbHZlIHRo
aXMsIHJpZ2h0Pw0KDQpJdCBpcyBub3QgdXNlciBzcGFjZSwgaXQgaXMgdGhlIHNlcmlhbCBkcml2
ZXIgaW4ga2VybmVsIHdyaXRpbmcgdGhpcyBiYWNrIGF1dG9tYXRpY2FsbHkuDQoNCiBKb2NrZQ0K
DQo+IA0KPiB0aGFua3MsDQo+IA0KPiBncmVnIGstaA0KDQo=
