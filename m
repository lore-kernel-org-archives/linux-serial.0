Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ECC3C433EF
	for <linux-serial@archiver.kernel.org>; Tue, 23 Nov 2021 10:20:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232412AbhKWKYD (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 23 Nov 2021 05:24:03 -0500
Received: from mail-eopbgr00060.outbound.protection.outlook.com ([40.107.0.60]:46679
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231221AbhKWKYA (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 23 Nov 2021 05:24:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YYQcGATPJUzcoAuqSY6VZS1oLd8tJnq8ToJGIky09Fxl4TFBm3lG0Tmb3x7jur3ahMu88uK2YTE0JIgkwcfg1xhgHu2tQvT7oUUhucZowGzm3Q6u4RNm93aJIGVo1yBgx2BSCikcwfZCE8NUfp7t55NRTPqTXoy9t5E5BA9Pl11oc3uhrCy0mOjYTMjjzbl+5Rzwdo/BS5Wy2xWMb04dLVD7TO6t6kCkjGV4y/RWFV+lPZ+ccwfJTfTE7YrOY+lmHba05wWyJQhPVnGv4/ZCLBxcNKBOInw19999NMQgdEb9p1v8RWLRto2h0kk5TBVXbxu646rZLvIbn1yDvLTIqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X/TJCrT2LawiSyF9RwP0w5H+s70Pm9WzXcRG6wZ4EUg=;
 b=ny2/pHmU7nf6jX7BXA1DmyboebiZkLTcZGUvgl5n1caZ1WelOwgd9+t99Hrc7aMt3Euh6asQHYAZg3wEd81pqvz4tm2vjmueysaQXYoir8KtNJ0oLMNyB31DNR9/KUdi9wUFqnspo5VUsEAd10gRXe4vpRlXi8Tj/1KNUl2M/Sfaph7lDkCSmWHiq0gGabHNziS9036pay3wj8MiYCAVJNohd5EtIE9vfjBiQX95+Ph0cR+XIXmxiXL9yRzc1J5LHVJx9yfE/Hl9AIK4iU+vXvJ4v00WjRnpeQ82mzfMSazlQAl0vKnFASrpTvgbvkBMGjg4wKRdMUbh4dB/jQFUsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X/TJCrT2LawiSyF9RwP0w5H+s70Pm9WzXcRG6wZ4EUg=;
 b=BhSrBjYSO3IoHQ3+O3IiY1jn3Ogq+qT1tKPpIPuVGKY8uWoNFC5yvOhCGUiKYx63b2N08Lm1wAb2lo+2RVzG2y78LuJZ3a7OhD55YQuF5aZ5GI996c9PxbHhKU/2M9uYSbHbb92QIntElzlUgsWdY7E1jsxsEIaCUjUc6BMgmdI=
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by AS8PR04MB7862.eurprd04.prod.outlook.com (2603:10a6:20b:2a1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.20; Tue, 23 Nov
 2021 10:20:50 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::c9fe:7982:c657:b423]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::c9fe:7982:c657:b423%9]) with mapi id 15.20.4713.025; Tue, 23 Nov 2021
 10:20:50 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] tty: serial: imx: clear RTSD status before suspend
Thread-Topic: [PATCH] tty: serial: imx: clear RTSD status before suspend
Thread-Index: AQHX4Di5uwn240l5kk6yGHp0V2/UCKwQuteAgAAOOFCAABXEAIAAB7iA
Date:   Tue, 23 Nov 2021 10:20:50 +0000
Message-ID: <AS8PR04MB8404A8DFE92F8813F47EA5C792609@AS8PR04MB8404.eurprd04.prod.outlook.com>
References: <20211123070349.20099-1-sherry.sun@nxp.com>
 <20211123074219.wn5jfjr6ph7uutyo@pengutronix.de>
 <AS8PR04MB84047408AEC087EB16B6981F92609@AS8PR04MB8404.eurprd04.prod.outlook.com>
 <20211123095106.dobqw2wfz2o2ofwc@pengutronix.de>
In-Reply-To: <20211123095106.dobqw2wfz2o2ofwc@pengutronix.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0c9adbe9-82df-46af-097b-08d9ae6aec47
x-ms-traffictypediagnostic: AS8PR04MB7862:
x-microsoft-antispam-prvs: <AS8PR04MB78629D1F7C43D98AE32C691492609@AS8PR04MB7862.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RDWD8BI69LvpudTZF1T6wdJBGbGdS0bSFwipC5Km/HdY2yFE/GGACZgU9ji4IdZNxE6DMzjvo5deeba5yg3v5BHvnX9gUUrRVsitMe4hj4zwtmf/5RDiphZU/k/qX1i4Jmzb/p3WA7wIlWfAn64Nl99H35jYMNBkEp2e7AtXuySlEFxPtBecC6E/Oz+GBJV+uxSX7HMM7t8BzC4qlyjJxKebqGR1uwe8hoftr4H1fyGjOSd6wQnaWeN3Ia9g9u2gnZTx3oB51jUZJVCVWMm63NtJXUDXbLwhaIUXVetnh8KQQbHSOPXDmxso9eqcy22TAwmQtX8Gx0ZPsUKePWkgUWi5fh5vXD+3JdeXWk0EY96YqKnkw41RshVH3Q0/HCNuBGFH4GIkWMG5952aWmW2Y+/d0S9LYyeF5O4Y5v6eoVeM8O2vQGyhRzKDt920whOLrO1SslzrXsWYfWdvdCQXrd0U4/mudQPN/GFrdep4tGAVNCFNPnOzRqxeLvDgoH/cAsVoIL5VeMxaPu4191QwWL2Ab4qrEXXur7GVMlpSqQQNhu26uZuIpcKZyq7io0psEb9IBU+BFADPB5Av2oBTWaNI2dBXOyLVyMD6G8p+xUqnoQey27Ah+NO6aoc4MmSa82sEpHKjxs/r2MNpdw500Btsm+Jbj/ltcnGfIViTyp9fnvLGRjs3kUoA6s2sybUcX5t1IhzDDmT+H/+L0G2ymg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(76116006)(83380400001)(9686003)(122000001)(6916009)(6506007)(52536014)(4326008)(8936002)(508600001)(53546011)(316002)(186003)(66476007)(66556008)(66946007)(38070700005)(66446008)(64756008)(38100700002)(2906002)(33656002)(55016003)(26005)(66574015)(8676002)(7696005)(5660300002)(15650500001)(54906003)(86362001)(71200400001)(44832011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dVNNcDRqUlliV2NtNnZtVVk3ZGVRa1FiNTVlNGNyaGhGUTQra3Mva0RJeXAz?=
 =?utf-8?B?cjJKUFE5cU4xZHQrZWNWSHo1cUxwL3h0VUtYU29YQmxUYUtVQ0wwYmUxSlRB?=
 =?utf-8?B?c3o3YllabUdnQVo2VlJYTzdLZFRrRkgvQWlnUC9VKzZhTU9tY0NaZDlqcXZj?=
 =?utf-8?B?SjFnbnVGK3NuTzJLeGtKYXVaeWhWM2hoclE2Z1U3MDZvbjNnMDZ3Wkl4UFVU?=
 =?utf-8?B?N2YvR2V3RUYydDVXWk1BVkYwclp1d0FNZTNXUG91WHh2YlZlcjk2bUFGMjk4?=
 =?utf-8?B?aWxiN1M5UVdmQlhuSU55Vk9NYlBWYjJ0TndYTitFMEVkaFBlSTVvU1c2a0lr?=
 =?utf-8?B?eTJySVlDTHBrMmdGai9ZeVdKUlNlcDE2alhDaUg0K0FHaTFLK2pNWFpjc21q?=
 =?utf-8?B?K1JVUDd4VndPQlFIdnVOa2VOT2I4ejBiSnVoREFwS3V2Z3ZlaTNLU3pkUXNo?=
 =?utf-8?B?bVp4dUFvcW1naktGUm44cXE1WEsyYk1UMVRXbk41dzNUK0tZQkVmK29GZkg3?=
 =?utf-8?B?VVV4WEI2WnArU01Kcmo2YkFOaUkycis1OVR0QUpUQW1WWk01djg5bEVOZVd5?=
 =?utf-8?B?TzBucmhBQmlReWh5SEdBdmZhTDk2MDBBandFNHdaVE13YVJMRFVKZDU5bDB6?=
 =?utf-8?B?VTAvY3RXTDhGaEdQclZzcDJVMjluNTgxc213aHZHQWZBUDhhTGdybnlsbkw2?=
 =?utf-8?B?ejQybzA5REZYZkRyMWpvcWl6eHYwTjJmemZEZStVdkFtVVd2TzhLS3ZJZ2hG?=
 =?utf-8?B?YjhSNkpLbVZqV0hxYStBY2w2a3lvUjBzd0QyNEh1bngzNjJzbDlZaUtrU3FG?=
 =?utf-8?B?cXJpanJIQWhIZW5hcDU5ekpZWEFzY3Ivdm9iYUIwYmU2TUtmYXRiRmZrblpI?=
 =?utf-8?B?Ymlqci9RajlHQWVsWVl5Z3ZwN0k5RzZXODZkaDB2ZEd0R3BVQ1NCQ1FYZ3lH?=
 =?utf-8?B?MUJmbVN6NjNrY1BIY0VjTjJxbTBwYzg1aEZnUUJQa2c5aGw5U0xiTWhsWitR?=
 =?utf-8?B?NzBQczg2QlQ2L0RkcFZDS3pTTXZWczF1V2k2UUNnMzFRNnQ4bFp3bjBOelVR?=
 =?utf-8?B?RnVmRGFjeDFCWjdpRFZJL0F6MTdpY0RGdU1GMUxETUtQMGE4LzlRcWF2Rzcv?=
 =?utf-8?B?VS9zRVRqeUlkL3lFakM2bkZqVEdVWUFzNE90OGZVb0FmWmxGOS95b2JQQzhF?=
 =?utf-8?B?SUtPeEZrQ3kyN2FlS3ZyTE1rdGZCSlZlQWpiczRpVmhPYnhqQjVudjlPazBp?=
 =?utf-8?B?OVdXL1lXaDhKbktJdnZXN1ZmYlFzMkNFb2g1Z2JGZVRML2pZcXZzS1AwaXJ3?=
 =?utf-8?B?UjM3bDBwQkFScy9mTjIyV2F5SFdNbk8rSWlsY3BDbCt6N2k3Z1k4NUNCVnE5?=
 =?utf-8?B?WXdPQ1lvZnlQZ3hLaENBaXBvMTJaZlNjZ3RDNnQ3V2VZNGlGRVdZem1VdFNt?=
 =?utf-8?B?bkxRTzJBVnNkR1VmV25uNmlqN0oweUZDYU5Uc2x5aXZwVFo5M2hzeEk2Nnk3?=
 =?utf-8?B?Y0hTS3pkVDNsRXR0KzhibGhtdWtoT0t4dGs0MXdZVm9hQmNlaE9US3BIMnVl?=
 =?utf-8?B?UENPRjlPYmVJOFN4OFIxVGgzdWNQTXl5a3ZtRGd5RFB6VlYwdytRYTRScDNr?=
 =?utf-8?B?RUdRUmhUMW5OOVZoZHBvZDFqVTAyY1FBUFJqZzJyaTI3cWl0cEx1bG04dFZN?=
 =?utf-8?B?Vk1vTFlDVmJOYzlYdmo4eEJWelEvZ3hwMVdmR3k3SjF2OFVHTjRoQTZuamdz?=
 =?utf-8?B?MUtuQVBsQjBwL1NEZHZ4b0h4VUJHQ1krc1paRnVSTEtrR0V3TFBFRmdtdEJL?=
 =?utf-8?B?M1M3NXdZODBCL1FtQjJTTFdoRWJ5OCsrSmozOExpU09FWnhma09XZCtCZmVa?=
 =?utf-8?B?c00ybTV6WUtySDhJOUNCYTExbis2K3ZPSTZMZ3BYZGprS0NtYUtIKzdUNkdx?=
 =?utf-8?B?MGVpbDArcjlGOFppWEt3RXk5dkVzNXNhZFU3MkhtM21wcENsZFVZZkl4eW5O?=
 =?utf-8?B?MjlmUVllWmlyZ3FvMDVWUXluRkFTTjl3WnNmUm9TcUJTcXdEVURRVVE3M0NI?=
 =?utf-8?B?QWNITlp2MEFPbkRMZDdyY2s4Y2tUQjJqUjZNWllIbGJWaW9LUDMxOWlBWnB2?=
 =?utf-8?B?cG9zY09JejM4WHIvd1p5czBWRnRSa3ZvbmpRdS9VUmtWS1c2RGdLdElidnF6?=
 =?utf-8?B?OUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c9adbe9-82df-46af-097b-08d9ae6aec47
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2021 10:20:50.2305
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QGUmaW2G9nrHC+1wwIBxLNxdgGK54mnEIDuazvASx1Q6zZ59w9C6VRN9qaBJlGDmCwBtlNhhBZa7fY2ussSYRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7862
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

SGkgVXdlLA0KDQo+IA0KPiBPbiBUdWUsIE5vdiAyMywgMjAyMSBhdCAwODo0MToxOEFNICswMDAw
LCBTaGVycnkgU3VuIHdyb3RlOg0KPiA+IEhpIFV3ZSwNCj4gPg0KPiA+ID4gLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206IFV3ZSBLbGVpbmUtS8O2bmlnIDx1LmtsZWluZS1r
b2VuaWdAcGVuZ3V0cm9uaXguZGU+DQo+ID4gPiBTZW50OiAyMDIx5bm0MTHmnIgyM+aXpSAxNTo0
Mg0KPiA+ID4gVG86IFNoZXJyeSBTdW4gPHNoZXJyeS5zdW5AbnhwLmNvbT4NCj4gPiA+IENjOiBn
cmVna2hAbGludXhmb3VuZGF0aW9uLm9yZzsgamlyaXNsYWJ5QGtlcm5lbC5vcmc7IGxpbnV4LQ0K
PiA+ID4gc2VyaWFsQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9y
ZzsgZGwtbGludXgtaW14DQo+ID4gPiA8bGludXgtIGlteEBueHAuY29tPg0KPiA+ID4gU3ViamVj
dDogUmU6IFtQQVRDSF0gdHR5OiBzZXJpYWw6IGlteDogY2xlYXIgUlRTRCBzdGF0dXMgYmVmb3Jl
DQo+ID4gPiBzdXNwZW5kDQo+ID4gPg0KPiA+ID4gT24gVHVlLCBOb3YgMjMsIDIwMjEgYXQgMDM6
MDM6NDlQTSArMDgwMCwgU2hlcnJ5IFN1biB3cm90ZToNCj4gPiA+ID4gRnJvbTogRnVnYW5nIER1
YW4gPGZ1Z2FuZy5kdWFuQG54cC5jb20+DQo+ID4gPiA+DQo+ID4gPiA+IENsZWFyIFJUU0Qgc3Rh
dHVzIGJlZm9yZSBzdXNwZW5kIGR1ZSB0byB0aGUgcG9ydCBhbHNvIHVzZSBSVFMgcGluDQo+ID4g
PiA+IGFzIHdha2V1cCBzb3VyY2UsIG5lZWQgdG8gY2xlYXIgdGhlIGZsYWcgZmlyc3QuDQo+ID4g
Pg0KPiA+ID4gSSdkIHdyaXRlOg0KPiA+ID4NCj4gPiA+IAlDbGVhciBSVFNEIHN0YXR1cyBiZWZv
cmUgZW5hYmxpbmcgdGhlIGlycSBldmVudCBmb3IgUlRTRC4NCj4gPg0KPiA+IFRoYW5rcyBmb3Ig
dGhlIHN1Z2dlc3Rpb24sIEkgd2lsbCByZW9yZ2FuaXplIHRoZSBjb21taXQgbWVzc2FnZSBhbmQg
c2VuZA0KPiBWMi4NCj4gPg0KPiA+ID4NCj4gPiA+IFRoYXQgdGhpcyBoYXBwZW5zIGluIHRoZSBj
b250ZXh0IG9mIHN1c3BlbmQgaXNuJ3QgdGhhdCBpbXBvcnRhbnQuDQo+ID4NCj4gPiBTb3JyeSBJ
IGRpZG4ndCBnZXQgdGhlIHBvaW50IGhlcmUsIGNhbiB5b3UgcGxlYXNlIGV4cGxhaW4gbW9yZT8N
Cj4gPiBQZXIgbXkgdW5kZXJzdGFuZGluZywgdGhlIHdha2V1cCBzb3VyY2UgaW50ZXJydXB0IGlz
IGhhbmRsZWQgaW4gdGhlDQo+ID4gc3VzcGVuZCBjb250ZXh0LCBzbyBjbGVhciB0aGUgZmxhZyBp
biB0aGUgc3VzcGVuZCBjb250ZXh0IGlzIGFsc28NCj4gPiBuZWNlc3NhcnkuDQo+IA0KPiBCdXQg
dGhlIGFjdHVhbCBwcm9ibGVtIGlzIHRoYXQgUlRTRCBpcyBlbmFibGVkIHdpdGhvdXQgZmlyc3Qg
Y2xlYXJpbmcgaXQgYW5kDQo+IG5vdCB0aGF0IFJUU0QgaXNuJ3QgY2xlYXJlZCBpbiBzdXNwZW5k
Lg0KPiANCj4gU28gbXkgaW5pdGlhbCByZWFjdGlvbiBhZnRlciByZWFkaW5nIHRoZSBjb21taXQg
bG9nIGhlYWRlciAiY2xlYXIgUlRTRCBzdGF0dXMNCj4gYmVmb3JlIHN1c3BlbmQiIHdhczogV1RI
LCB3aHkgZG8gd2UgbmVlZCBjbGVhcmluZyBSVFNEIGJlZm9yZSBzdXNwZW5kLg0KPiBTaG91bGRu
J3QgdGhlIFJUU0Qgc3RhdGUga2VwdCBvdmVyIHN1c3BlbmQ/DQo+IA0KPiBJbiBjb250cmFzdCBj
bGVhcmluZyBhbiBldmVudCBiZWZvcmUgdGhlIHJlc3BlY2l2ZSBpcnEgaXMgZW5hYmxlZCBpcyBt
b3JlDQo+IG9idmlvdXNseSBjb3JyZWN0LiBBbmQgaWYgdGhlIGlycSBzb3VyY2UgaXMgZW5hYmxl
ZCBhcyBwYXJ0IG9mIHN1c3BlbmQgb3Igb3Blbg0KPiBpc24ndCB0aGF0IHJlbGV2YW50IGZvciB0
aGUgc3ViamVjdCBsaW5lLg0KPiANCg0KR290IHlvdXIgcG9pbnQgbm93LCB0aGFua3MgZm9yIHRo
ZSBleHBsYW5hdGlvbi4NClRoZSBwYXRjaCBzdWJqZWN0IGlzIGluZGVlZCBhbWJpZ3VvdXMsIEkg
d2lsbCBmaXggaXQgaW4gVjIuDQoNCkJlc3QgcmVnYXJkcw0KU2hlcnJ5DQo=
