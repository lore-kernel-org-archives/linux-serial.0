Return-Path: <SRS0=uqjK=7X=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 245CDC433E0
	for <linux-serial@archiver.kernel.org>; Wed, 10 Jun 2020 07:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED45D20825
	for <linux-serial@archiver.kernel.org>; Wed, 10 Jun 2020 07:42:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=infinera.com header.i=@infinera.com header.b="cxMEyYaV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbgFJHmJ (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 10 Jun 2020 03:42:09 -0400
Received: from mail-bn8nam11on2043.outbound.protection.outlook.com ([40.107.236.43]:64097
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726278AbgFJHmI (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 10 Jun 2020 03:42:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kgluBiLj5v0AWjty3cDwrx4XNvsr85W6cOembXQ3jr7+W2gIPyTSK6H5Uk58Nl//XowFbyUPaA7WR1peJJjnyYpcJnsq8CI/nch8dwt7tIXYHkzWuL+m1ca+5+HGHth8+IThzb3R4lXLYObF36e3u982O/kqYJ+7oKAOB+8a9HgPB04hmUMJnlnPGHNq/zMqM8fCGBpUv/VG9Os2QzIiAOr+k+ylC1DJ4iUG8XiV24yH9ntHgDS3I1tygjb3xjztMmelYWCcN5gSXU+GQD17HKT+WQVRA0Hydo01BYaVK2QLdmzq7eMZ4fPoBfzxXWtodpTfts5Ixuk8+Qx/MldZmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GTdl0kPwh24FAoU6Q88i7vzctd9bfdhaxUGEfOmfSM8=;
 b=Rt4SbOwN5YDk+0p+ycWq4HbdR2qTR9qE7O6iRZTDeL+wCWD4wwvrZ7t5ZHgZ0DXoVjaqjxVVcBWiujXG+lbr/v+ekLEYjcBVuKpBAzYJl9Ml7yni2Grp1+Sl8R5R6i5YpyYM7pAElCIXfiXLXxGHuUfRyHcaPO2zTN5cPwzLg9xmfN9cX9GMo7MFT8KRj4yg1edGYBY9/F7PuQU4SJzAVn9UGdtIP5ZU9rSPkM9REuLJmOyzeqFb35R2C1goInzOQRLIml54YXOdpUEpcT94MwKcVh95CXMmJhnnAEltR+j66l2xWZ0R6l3kYGhHzVHBzcV8OGK7aFL9bdHbfXYl6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=infinera.com; dmarc=pass action=none header.from=infinera.com;
 dkim=pass header.d=infinera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infinera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GTdl0kPwh24FAoU6Q88i7vzctd9bfdhaxUGEfOmfSM8=;
 b=cxMEyYaVQ58jd9BKevJClTcKOeP/6oPjgcrD0RQLiX7oJeKhQq6xlLeLMuUBrH3iVYrqUU392DHx6AS4SPlnm79ktgvMTFaS06oWvd6SQM65Bu45J+arlNXLSEHNikdlR7VUSPDDlcA4L7sZFjA2MIKQLLMeAEk2ASjMLQ5mGl0=
Received: from BN8PR10MB3540.namprd10.prod.outlook.com (2603:10b6:408:ae::24)
 by BN8PR10MB4084.namprd10.prod.outlook.com (2603:10b6:408:b0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.19; Wed, 10 Jun
 2020 07:42:04 +0000
Received: from BN8PR10MB3540.namprd10.prod.outlook.com
 ([fe80::c158:d59f:e3bc:1941]) by BN8PR10MB3540.namprd10.prod.outlook.com
 ([fe80::c158:d59f:e3bc:1941%2]) with mapi id 15.20.3066.023; Wed, 10 Jun 2020
 07:42:04 +0000
From:   Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "oneukum@suse.com" <oneukum@suse.com>
Subject: Re: Default ECHO on TTYs causes unwanted garbage chars
Thread-Topic: Default ECHO on TTYs causes unwanted garbage chars
Thread-Index: AQHWPlKKxJr0ir3sA0SM2brkyH1CUqjQLZMAgAAVM4CAABNYgIAACuAAgAESwgCAAATegA==
Date:   Wed, 10 Jun 2020 07:42:04 +0000
Message-ID: <5f9aaf1c6a6fae5ec33820593a79f5aea03957e9.camel@infinera.com>
References: <d6d376ceb45b5a72c2a053721eabeddfa11cc1a5.camel@infinera.com>
         <20200609115712.GD819153@kroah.com>
         <984225ab9969a18fc67244a69b71c1534174d4f9.camel@infinera.com>
         <20200609142219.GB831428@kroah.com>
         <d2428c7b828d24fe1eb9b05e2d0d1af52edef846.camel@infinera.com>
         <20200610072438.GG1923109@kroah.com>
In-Reply-To: <20200610072438.GG1923109@kroah.com>
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
x-ms-office365-filtering-correlation-id: 2e4c531b-0df5-4c83-2941-08d80d11c516
x-ms-traffictypediagnostic: BN8PR10MB4084:
x-microsoft-antispam-prvs: <BN8PR10MB4084B77A012B8BA92A3136B1F4830@BN8PR10MB4084.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0430FA5CB7
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MCZfE/T30Ba6UL2r1Bx1IuZFbJd6Abp3IFJdVAbrffiDi3CH5z7CG3jYM7mF5vdXFN+CsWxYVbSMbq2Cgc7VTs3oqgORyoJk3NZt/w74z473n2vLFrIQ01BDN4NJhvoytD8XeIeZcUbL/cvKklIre12kWU9CRraG3tYx8SRE2GPAmPaj97wxPtCpTanWPkLElSdylaIXfc6rMFsCtr+uLUMBtUVsBar9uh8ZhiT6/71GMtLkCACu5pV8ostStSO1bq2IvkBRV4bARZcw9dmvvpQaIQI5n810vKlxBr7EV/FFFrZspx6QRU+KRLyaNzJ3jno+2TVBMl1TSL4a5VF4g+kKYIfeMalCo54iXsvIC8/j6M2P01c3hJF1u7220p+X
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR10MB3540.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(39860400002)(376002)(346002)(396003)(136003)(478600001)(54906003)(316002)(26005)(186003)(6506007)(2616005)(4326008)(71200400001)(5660300002)(86362001)(6512007)(66556008)(66946007)(91956017)(8676002)(8936002)(2906002)(36756003)(6916009)(76116006)(6486002)(66446008)(64756008)(66476007)(26123001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 5iiSPhpGWkZBTHXiXQEaUBsPlvQg3x8Vxgq6hlNgSdoQ86eU5/U/zHFyECiKk/x3pwAQwj2YiKe3njRgFXZ210jkxpeL8LXXS6uwt3LHQNT+3lClZgQkcrnzcgN7da2QLmkh6Ay8/J3tmD/Tcb21+azmp8rkCMg+CVWvr9aJ/uIlhkFl4n0QKM1gi+eGqQDjjYa2Q28OJs6aR+PcBHhoxR2/nizi4nW/3ZZloa05ikJrHUAgp5bT6ivIbfkzkC/lXcDiKNLxMFs+BEmnKTB3sAMTBZifOujIRMQ+BfA9zvaT7NR1q2EpbD5M4OGnCC8/nJD8vG6dglrfvciHaPIsoMztvvUBsW+RvaKM9i9+OVqEzwtPQ8HPY8A8nUrH4/JDfZoe0ik4knhjJeMPgHA/3xflLIIubaXlzXdPbYvBIysxpaGpmYX3GdlbsKNMg0IOp21MkM3nUu7cStcMhgci2hkPTA9cmeAS4L+hjv7W5Fg=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <C1B503E081260942B3C34188B84EB47A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: infinera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e4c531b-0df5-4c83-2941-08d80d11c516
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2020 07:42:04.3085
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 285643de-5f5b-4b03-a153-0ae2dc8aaf77
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2507oJoXzKM6/KuxZjN8VGMrRboxpP1prPOC1JND9gtbU5kCNx+hAUmy/TkJ2IXqlXp1iKVPToXXvb3dPuU6zA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB4084
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

T24gV2VkLCAyMDIwLTA2LTEwIGF0IDA5OjI0ICswMjAwLCBncmVna2hAbGludXhmb3VuZGF0aW9u
Lm9yZyB3cm90ZToNCj4gQ0FVVElPTjogVGhpcyBlbWFpbCBvcmlnaW5hdGVkIGZyb20gb3V0c2lk
ZSBvZiB0aGUgb3JnYW5pemF0aW9uLiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2ht
ZW50cyB1bmxlc3MgeW91IHJlY29nbml6ZSB0aGUgc2VuZGVyIGFuZCBrbm93IHRoZSBjb250ZW50
IGlzIHNhZmUuDQo+IA0KPiANCj4gT24gVHVlLCBKdW4gMDksIDIwMjAgYXQgMDM6MDE6MTRQTSAr
MDAwMCwgSm9ha2ltIFRqZXJubHVuZCB3cm90ZToNCj4gPiBPbiBUdWUsIDIwMjAtMDYtMDkgYXQg
MTY6MjIgKzAyMDAsIGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnIHdyb3RlOg0KPiA+ID4gT24g
VHVlLCBKdW4gMDksIDIwMjAgYXQgMDE6MTM6MDZQTSArMDAwMCwgSm9ha2ltIFRqZXJubHVuZCB3
cm90ZToNCj4gPiA+ID4gT24gVHVlLCAyMDIwLTA2LTA5IGF0IDEzOjU3ICswMjAwLCBHcmVnIEtI
IHdyb3RlOg0KPiA+ID4gPiA+IE9uIFR1ZSwgSnVuIDA5LCAyMDIwIGF0IDExOjM4OjQ5QU0gKzAw
MDAsIEpvYWtpbSBUamVybmx1bmQgd3JvdGU6DQo+ID4gPiA+ID4gPiBIaSBMaXN0DQo+ID4gPiA+
ID4gPiANCj4gPiA+ID4gPiA+IEkgd2FzIGFkdmlzZWQgdG8gY29tZSBoZXJlIHdpdGggdGhpcyBw
cm9ibGVtKHN0YXJ0ZWQgb24gdGhlIFVTQiBsaXN0KS4NCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+
ID4gV2UgaGF2ZSBhIFVTQiB0byBSUzIzMiBicmlkZ2Ugd2hpY2ggcHJlc2VudHMgaXRzZWxmIGFz
IGFuIHR0eUFDTSBhbmQgdGhlIGZpcnN0IGNvbm5lY3QgYWZ0ZXIgcG93ZXIgb24sDQo+ID4gPiA+
ID4gPiB3ZSBzZWUgc29tZSBnYXJiYWdlIGNoYXJzIHRyYW5zbWl0dGVkIGJhY2sgZnJvbSBVU0Ig
aG9zdChQQykgdG8gb3V0IGRldmljZSB3aGljaCBiZWNvbWVzIGlucHV0IHRvDQo+ID4gPiA+ID4g
PiB0aGUgZGV2aWNlLg0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBBZnRlciBtdWNoIGRlYnVn
Z2luZyBJIGZvdW5kIHRoYXQgdGhpcyBhcmUgY2hhcnMgc2VudCBlYXJseSBpbiB0aGUgYm9vdCBw
cm9jZXNzIHdoaWNoIHRoZW4NCj4gPiA+ID4gPiA+IGFyZSBidWZmZXJlZCBhbmQgdGhlIFRUWXMg
ZGVmYXVsdCB0byBFQ0hPIGNoYXJzIGlzIHRoZSBjYXVzZS4NCj4gPiA+ID4gPiANCj4gPiA+ID4g
PiBTbyBzb21lIHByb2dyYW0gaW4gdGhlIGJvb3Qgc2VxdWVuY2UgaXMgdHJ5aW5nIHRvIHNlbmQg
ZGF0YSBvdXQgdGhlDQo+ID4gPiA+ID4gZGV2aWNlPyAgV2h5IG5vdCBqdXN0IG5vdCBkbyB0aGF0
Pw0KPiA+ID4gPiANCj4gPiA+ID4gVGhpcyBpcyB0aGUgYm9vdCBjb25zb2xlLiBCb3RoIHUtYm9v
dCBhbmQgTGludXggcHJpbnRzIGEgbG90IHRoZXJlLCB0aGVuIGluaXQgcHJpbnRzIHdoaWxlIHN0
YXJ0aW5nIHNlcnZpY2VzDQo+ID4gPiANCj4gPiA+IFNvIHRoZSBzYW1lIGRldmljZSBpcyB1c2Vk
IGZvciBib290IGNvbnNvbGUgYXMgd2VsbCBhcyBhIHR0eUFDTSBkZXZpY2UNCj4gPiA+IGxhdGVy
IG9uPw0KPiA+IA0KPiA+IE5vdCBxdWl0ZSwgdGhlIFVTQiB0byBSUzIzMiBjaGlwIGlzIGludGVn
cmF0ZWQgb24gdGhlIGRldmljZSBhbmQgaXMgY29ubmVjdGVkIHRoZSBDUFVzIFJTMjMyLA0KPiA+
IHRoZXJlIGlzIG5vIG90aGVyIHBvcnQuDQo+ID4gSSB0aGluayB5b3UgY291bGQgY29tcGFyZSB3
aXRoIGFuIGV4dGVybmFsIFVTQiB0byBSUzIzMiBwdWNrLiBTZW5hcmlvOg0KPiA+IC0gQ29ubmVj
dCB0aGUgcHVjayB0byBib3RoIGNvbXB1dGVyIGFuZCB5b3VyIGRldmljZSB3aXRoIGFuIFJTMjMy
IHBvcnQuDQo+ID4gLSBQb3dlciBvbiB0aGUgZGV2aWNlIHdpdGggdGhlIFJTMjMyIHBvcnQuDQo+
ID4gLSBEZXZpY2UgImJvb3RzIiBhbmQgcHJpbnRzIHN0dWZmIG9uIGl0cyBSUzIzMiBwb3J0LA0K
PiA+IA0KPiA+IHNvbWUgdGltZSBwYXNzZXMNCj4gPiANCj4gPiAtIE9wZW4gdHR5QUNNIGluIFBD
IHVzaW5nIG1pbmljb20vY3UNCj4gPiBOb3cgZWFybHkgaGlzdG9yeSBvZiB0aGUgYm9vdCBwcmlu
dHMgYXJlIGVjaG9lZCBiYWNrIGZyb20gUEMgdG8gZGV2aWNlIHdpdGggUlMyMzINCj4gDQo+IEFo
LCBvaywgc28sIGFyZSB5b3Ugc3VyZSB0aGF0IGRhdGEgaXNuJ3QganVzdCAic3R1Y2siIGluIHRo
ZSBVU0Itc2VyaWFsDQo+IGNoaXAncyBidWZmZXJzPyAgVGhhdCdzIG9mdGVuIHRoZSBjYXNlIHdp
dGggbWFueSBkZXZpY2VzIGFzIHRoZXkgYXJlDQo+IHRpbnkgYW5kIGR1bWIgYW5kIHRyeSB0byBk
byB0aGUgcmlnaHQgdGhpbmcgbW9zdCBvZiB0aGUgdGltZSAobGlrZSBub3QNCj4gZHJvcCBkYXRh
IHRoYXQgd2FzIHNlbnQgdG8gaXQuKQ0KDQpub3QgMTAwJSBubyBidXQgZXZlbiBpZiBpdCB3YXMs
IHdoeSB3b3VsZCB0aGUgUEMgZWNobyBiYWNrIGNoYXJzIGJlY2F1c2UgdGhlIFRUWSBnZXRzIG9w
ZW5lZD8NCkkgY2FuIHNlZSB0aGF0IHRoYXQgdGhlIGNoYXJzIGFyZSBzZW50IGJhY2sgYnkgdGhl
IFBDLCBub3QganVzdCBzdXJlIGlmIHRoZSBQQyByZWNlaXZlZCB0aGVtDQphdCB0aGF0IHNhbWUg
dGltZSBvciBpZiB0aGUgUEMgZ290IHRoZW0gd2hlbiB0aGUgY2FibGUgd2FzIGNvbm5lY3RlZCwg
c3RvcmVkIGluc2lkZSBzb21lIGRyaXZlciBhbmQNCndyaXR0ZW4gYmFjayBvbmNlIHRoZSBUVFkg
aXMgb3BlbmVkLCBiZWZvcmUgb25lIGhhdmUgaGFkIGEgY2hhbmNlIHRvIGFkanVzdCBiYXVkcmF0
ZS9lY2hvIGV0Yy4/DQoNCiAgSm9ja2UNCg==
