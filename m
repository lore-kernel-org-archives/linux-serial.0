Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7750DC433EF
	for <linux-serial@archiver.kernel.org>; Wed, 24 Nov 2021 11:35:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240966AbhKXLit (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 24 Nov 2021 06:38:49 -0500
Received: from mail-eopbgr70079.outbound.protection.outlook.com ([40.107.7.79]:9795
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233552AbhKXLis (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 24 Nov 2021 06:38:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CuA+2v2f0P2V9Jp85hlt7w/ucCKYjABaMMsGDx4qYaC1xM6NtREtcZm+tnkZBES6BkUrUCUfgww0k61w8uvE/QgR3F7Isj5jOG4tvwivhrLdZNN5nPizkTzLSAT7AawH77izTGC31cnBznKg/ylWXTYqrZ1tmooPv6pYcrBpQvF42RW/42eevFBzdIMBrJb/NOmFG826Ouh5U9MevtkgZ+txFTRfuMLtptW0Fr5wBNiit1xUGHivUFKrXneIfCZ7DJIZmF8UjyMeEXJGLMEnnKNwpMhAvgiqNVvXpeaJja9u7ksFuCIBcPghhrdGNRq0b5dhhs3XW+5ZZncwTeJ9hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jmZrK/2tvxshoawsvkyyKOQ5/jBYR0F4UffldJLY6gg=;
 b=kUCvG90V3kHBLqrylR6of9r0cqO6KXHiR9D9bwsUwG/maH10ESmsabJt5+xobBa9L7U6Nm8CWKLI3g94Ij68rn3g3DiqAAE7MlY71x9ttHFY/MXwUJ7BtckD61hpGkx6JQ4/P1q8cWxhty08DVzsT49E1P9hW4tS++Tjb3YeV3F5+7XjNBpbkygeEZ7JGzL6Irl26li7BI+tw6kdshcsEPMp0WoWSXokufB0sUpYddFfly1nyBgrg5H2hJYjqEzJs5kQEuTiFDOsTwceqckBLbSWgE1hdbbShf33uBzpRCnknuLmgJM24vJ5varp+n1Z7q+2wWAtGcl0uOdOBPWh/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jmZrK/2tvxshoawsvkyyKOQ5/jBYR0F4UffldJLY6gg=;
 b=BURjhmdXRqnwJQoDiMfIhd8zENqOffV/2UgAW2FdtJnnvq4UdW9DulKDVEcZ1F/1A7OeqdmwfyryUcDp/oi3waOsGK6eKCI5CxVRxowcfPwbzuhzl2sxqXe334NKlRT0koxpg7j/5Qxl2OESYHxBJPGsCpus/a0blBdYVp0pJks=
Received: from DB9PR04MB8411.eurprd04.prod.outlook.com (2603:10a6:10:24c::9)
 by DB3PR0402MB3817.eurprd04.prod.outlook.com (2603:10a6:8:12::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.20; Wed, 24 Nov
 2021 11:35:35 +0000
Received: from DB9PR04MB8411.eurprd04.prod.outlook.com
 ([fe80::199a:adba:b7de:cf8d]) by DB9PR04MB8411.eurprd04.prod.outlook.com
 ([fe80::199a:adba:b7de:cf8d%5]) with mapi id 15.20.4713.027; Wed, 24 Nov 2021
 11:35:35 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V2] tty: serial: imx: disable UCR4_OREN in .stop_rx()
 instead of .shutdown()
Thread-Topic: [PATCH V2] tty: serial: imx: disable UCR4_OREN in .stop_rx()
 instead of .shutdown()
Thread-Index: AQHX4FiQNZ4EhBh7xE206RassKu55awScyOAgAAEUVCAABOZgIAAAFyA
Date:   Wed, 24 Nov 2021 11:35:35 +0000
Message-ID: <DB9PR04MB8411BA914405C7EFA563A1CD92619@DB9PR04MB8411.eurprd04.prod.outlook.com>
References: <20211123105122.7913-1-sherry.sun@nxp.com>
 <YZ4M6aM6lGxTi2y7@kroah.com>
 <DB9PR04MB841142300744686983652AB992619@DB9PR04MB8411.eurprd04.prod.outlook.com>
 <YZ4g+U7PZ4bdjVjm@kroah.com>
In-Reply-To: <YZ4g+U7PZ4bdjVjm@kroah.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ed476f15-4c26-433b-303d-08d9af3e8809
x-ms-traffictypediagnostic: DB3PR0402MB3817:
x-microsoft-antispam-prvs: <DB3PR0402MB3817BD1B5FD7F94A39BD5F9A92619@DB3PR0402MB3817.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:483;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oLx1Rx2KWOu15y848y7mnqTmbpesIJ49huT/A73ljbSvTs1w+HzScKyNBMDOYp+sjlR7o68ukswBjgCjo98PMtMxYPCFwBAJsO4oR0vxSlZi3qGYgAV34LDmtRmns4jJS8QD52Pkff4UBLzBR8uIdGHnQpXvMKzxQK6g2Z8V3V0VurS3C0M5qwplVoOqfs+LyHfVKVNeH9esAQqraV3xkA/8rwihw0uBXKFDQy++LNWxWyyIUcqT14NIs5sQSvVMfYeqrhU3oWm4EuUER3fMlZAxS+Z1NiwdOTKChI6vzlKLWBbmLoNw/DU4WfQXXhb+Ao7bgd5sfZMv+cu1ghxKskDqvpau7oSi2WPNpknKaBTikMMk+UBX9l/MUBNpExTr+uVQSWaYsEdfa2BhtlEQLgSQzbXoAnofBtKcTp/n+Ht8LpGQPFeo2XRTcL26GhaRCcqQv1tDdKX0fGMJQxWlSISnx/pU6/xC1GvOY9FKuKLg8+1WbmPCEYpmGDs7gexFOxgMGw8A7L8rf7I9R88/m0rD1oeeVDwAMzNRRdP7HDaoIHBvrB/kVKodfjLvYQ7iWNao+NjLtvPyYDbPPlbxT8PIUxS/4AwSow8K5WWlCfOG9bXJgGEUFp8QiHSduUErtfJlOkZ5pkKHl2gqWzoIWeNdmHzMnEDAWTCbeMAK4eWj/2zi6eohq0Os1/V+W43Z1bWWFQJcYQD+p2x2wU1d2OtV+PgGjZC1B4BTjW2SHY0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8411.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4326008)(38070700005)(316002)(71200400001)(55016003)(66476007)(66556008)(44832011)(7696005)(6916009)(8676002)(66946007)(9686003)(38100700002)(33656002)(66446008)(52536014)(122000001)(64756008)(76116006)(26005)(86362001)(53546011)(5660300002)(8936002)(186003)(508600001)(54906003)(83380400001)(6506007)(2906002)(142923001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TEx6akdyRG14TnZycFBOeXY3ZXdpc3VNZXYzeUxHSTArem1qUWNBWjFONmhx?=
 =?utf-8?B?UW9KTjgySFBFZGJGejlBRWZEbVRiREkzSFpsRllqK0dUMnZ1aXF4SW9NWktm?=
 =?utf-8?B?aUFCSldjT0x1N3NFSjBpNUg5d1lDbVp0dVJpYkxQazFxTzh2b1M5LzZ0cWRI?=
 =?utf-8?B?cjMvNjQ0N0RHaVRHTll1Zm1rZE45T1RlYThIc3FyVWIwT3BjQ2Y1dmJ1d3l3?=
 =?utf-8?B?YzZ5WGpkVE9USWRja3dkenU4eXJjMWd1WmwyZkR4d0RSaWV2b1ZQcU5oSXkv?=
 =?utf-8?B?alhvcWo2OHJ5L3JjZmJpamhLcndvays4bjRQaUdwa2x3M2pIZTgzSXAwOWN0?=
 =?utf-8?B?M0RFVDFWYkdmTDdBU1pBVThmK28ra1BxZG5IM3pPZHp6VURSM0c4eUU0djE4?=
 =?utf-8?B?M2k1aTQrY2xCL3haUlhJMlBuMFdrcVhEc21rUHJxdTlYUURDNGFTaDBpTkQ2?=
 =?utf-8?B?SFNPNHU3UGpuUnBIRDZEVmZxK1hyaTdTZ05QWk1OaW81ZDQ2a01jNk1LU2hr?=
 =?utf-8?B?SGdLUmlrNlRMTTNsaStBR3BBS1Z0aGRURlg2cmxtRjhFRzhVR292dVlBbFlB?=
 =?utf-8?B?a0Z0WGxnb2dPRWExNFpaZGxPQi9rL0Z6K01EQUtlM0YxbUFjeVIvd2tLVVN6?=
 =?utf-8?B?WTJ4YVNhL05JTDBtM2pxZzR1dk02dzFjM0h6SDFGeUVhQVhjZXNBbElMWEdY?=
 =?utf-8?B?YlZKVjVFU1NYb2Y1Q284d3BuSnMrQjVETTJWZDlDTHVoeHFCU25ka3ZXR0RI?=
 =?utf-8?B?QzhnYjBwNjhUQnhPaUduT0V0QlRZS0lTS1pKcWxOb292SVoySzhobnZNWjVk?=
 =?utf-8?B?UWNVZ1B1eXd2NlVJdmJzVTJhQjZzbzhWekdDci9nWStmVllsK2ZzVUtodWpx?=
 =?utf-8?B?bWhWVXhIbHM5dWFKYnQ2bXlUZVNZaWRlOExOZDA2dlRBazZHbEdDUVNzSWk0?=
 =?utf-8?B?cE91YTBEOWUxRjcvVXZCbG5rZDA2enZ5Y0F2blJsMTQzZmFERVVIbHAwZEZk?=
 =?utf-8?B?WjVabm1USklkSVIzZkN2Z2dBa1FhVkZxMHhHdjRjNStjQmNqTnNKaHVZQkpY?=
 =?utf-8?B?U0VBUVZXUGliRkFzV25mWTd0RldMN0lpWU9sd3hBWThFYUNkeWNKSHB4Y09W?=
 =?utf-8?B?MXM5VkhpNGd6bStwckJodXFib0RGNmFDbDdrcWYrUkUzamtiM2hCWHZ5NFlr?=
 =?utf-8?B?UXdPQlBwYitTV1h5Q09tNHoxcTVtNzZIMWVxazNGU2lPdGVYUy9FK1QzTlMz?=
 =?utf-8?B?YjNtY3FnR2FPNEtMcjhuK3FWbng0UDg4akEzMGZNbzBHWTM1cHdiaUhpWHdS?=
 =?utf-8?B?eEQxNzJ3Y0hQNThlTFcwZ0hRZjIzaDJJZS9IR3pESGFxYnlHZWZYV3h2bEJE?=
 =?utf-8?B?eWlSSUp5VGpHWFZTNitGcWZIdUZyV3ZwV2tpTzhPRFNGc1MxYVZTdTl1QlJH?=
 =?utf-8?B?WkJHMXdUaHhvRTNMUnlETThzbzd5aDhJVmtJZzd1ZWh2MTRzUTZnMlZ0T2Q2?=
 =?utf-8?B?d1VScVBHZi8vcXVjWDljNGloYXc0TThYWUdtV1ZlTmx3Q21LL0NFVERwT0p1?=
 =?utf-8?B?aHJ1YzljNEFCRHpGSFM0RzBtM0t2TksyY0J6VVR3UmJtUWFaUW9VYzErU1lF?=
 =?utf-8?B?V2NtQ3VGYlo4WEl5eWV1ZTNNOU5HSGhJVnhGZUkwWHZvOHd0a0piSjNRbjlx?=
 =?utf-8?B?d0tYTUhUNUhnYytwdWZ4WGlycmRPSytTMjJWSHhXTmV2NnhVYjZ1YXE2d29N?=
 =?utf-8?B?WXBEZjRlSXFqYk5nSXhlajdwTXgxaHVYWGs3MVRFUFl3dThRZVVtWjhKQ3Rs?=
 =?utf-8?B?RXVrSXJGQjBrZ0ZBRE9kQWl1MHlZRFJLNTRDK2lEU3MvakwwaTJHWU5FQ2ZJ?=
 =?utf-8?B?TksyR0d2VmxPQjhOUjN4bWhQc2NCbyt3VVMwVmZqVWRJR1FoVjZ1T2k1ZTR4?=
 =?utf-8?B?eE80RmIwLzJ0WEhLN09nc0pXVGNqSDJmdkJFVXJVMEtJS2cwWitVOXVtUnFv?=
 =?utf-8?B?ZzNqMmp0Vlk4WDdiazNpNEdQK3NCTjJkZ2tVS0hWcVFDVWM2VjlpTVprV1dH?=
 =?utf-8?B?YWtwcFowTzVpZTJPVHU0bk9VUFVrMFRyWTVyMmpHeXRVdERyamI2Y2s3MHZ2?=
 =?utf-8?B?OUk4K1ZVam83SGFQcWV2Vi9jNDU0bjQ2cG0zaHJGNjdTcDNlMSsxdHpCbjVK?=
 =?utf-8?B?c1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8411.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed476f15-4c26-433b-303d-08d9af3e8809
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2021 11:35:35.4095
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2I305/2bQ3birKf/ykfwc7LfIBs//QSrRvwW2pWilbglF4Zhlq/QBk1HYKxCkFP69p7jeq1+nB8cwPVgjsuVFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3817
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

SGkgR3JlZywNCg0KPiBPbiBXZWQsIE5vdiAyNCwgMjAyMSBhdCAxMDo1Njo0M0FNICswMDAwLCBT
aGVycnkgU3VuIHdyb3RlOg0KPiA+IEhpIEdyZWcsDQo+ID4NCj4gPiA+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBHcmVnIEtIIDxncmVna2hAbGludXhmb3VuZGF0aW9u
Lm9yZz4NCj4gPiA+IFNlbnQ6IDIwMjHlubQxMeaciDI05pelIDE3OjU5DQo+ID4gPiBUbzogU2hl
cnJ5IFN1biA8c2hlcnJ5LnN1bkBueHAuY29tPg0KPiA+ID4gQ2M6IGppcmlzbGFieUBrZXJuZWwu
b3JnOyB1LmtsZWluZS1rb2VuaWdAcGVuZ3V0cm9uaXguZGU7IGxpbnV4LQ0KPiA+ID4gc2VyaWFs
QHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgZGwtbGludXgt
aW14DQo+ID4gPiA8bGludXgtIGlteEBueHAuY29tPg0KPiA+ID4gU3ViamVjdDogUmU6IFtQQVRD
SCBWMl0gdHR5OiBzZXJpYWw6IGlteDogZGlzYWJsZSBVQ1I0X09SRU4gaW4NCj4gPiA+IC5zdG9w
X3J4KCkgaW5zdGVhZCBvZiAuc2h1dGRvd24oKQ0KPiA+ID4NCj4gPiA+IE9uIFR1ZSwgTm92IDIz
LCAyMDIxIGF0IDA2OjUxOjIyUE0gKzA4MDAsIFNoZXJyeSBTdW4gd3JvdGU6DQo+ID4gPiA+IEZy
b206IEZ1Z2FuZyBEdWFuIDxmdWdhbmcuZHVhbkBueHAuY29tPg0KPiA+ID4gPg0KPiA+ID4gPiBE
aXNhYmxlIHRoZSBVQ1I0X09SRU4gYml0IGluIC5zdG9wX3J4KCkgYmVmb3JlIHRoZSB1YXJ0IHJl
Y2VpdmVyDQo+ID4gPiA+IGlzIGRpc2FibGVkIG1heWJlIGJldHRlciB0aGFuIGluIHRoZSAuc2h1
dGRvd24oKSBmdW5jdGlvbi4NCj4gPiA+DQo+ID4gPiBXaHkgaXMgaXQgYmV0dGVyPyAgV2hhdCBk
b2VzIHRoaXMgImZpeCI/DQo+ID4NCj4gPiBTaW5jZSBJIGFtIG5vdCBjbGVhciBhYm91dCB0aGUg
aGlzdG9yeSBvZiB0aGlzIHBhdGNoLCBzbyBJIGhhdmVuJ3QgZm91bmQgYW55DQo+IG9idmlvdXMg
aXNzdWVzIHdpdGhvdXQgdGhpcyBwYXRjaCBzbyBmYXIuDQo+IA0KPiBUaGVuIHdoeSBzdWJtaXQg
aXQ/DQoNCkJlY2F1c2UgZnJvbSB0aGUgY29kZSBsb2dpYywgSSB0aGluayB0aGlzIHBhdGNoIGlz
IG1vcmUgcmVhc29uYWJsZS4NCg0KPiANCj4gPiBCdXQgYWZ0ZXIgZGlzY3Vzc2luZyB3aXRoIHRo
ZSBJUCBvd25lciwgaXQgaXMgc3RpbGwgcmVjb21tZW5kZWQgdG8gZGlzYWJsZSB0aGUNCj4gcmVj
ZWl2ZXItcmVsYXRlZCBpbnRlcnJ1cHRzIGxpa2UgT1JFTiBiZWZvcmUgZGlzYWJsaW5nIHRoZSBy
ZWNlaXZlci4NCj4gDQo+IHJlY29tbWVuZGVkIGJ5IHdoYXQ/ICBUaGUgaGFyZHdhcmUgZGVzaWdu
ZXJzPw0KDQpZZXMsIHRoZSBpLk1YIFVBUlQgSVAgZGVzaWduZXIuIA0KDQo+IA0KPiA+IElmIG5v
dCwgd2hlbiB3ZSBoYXZlIHRoZSBvdmVycnVuIGVycm9yIGR1cmluZyB0aGUgcmVjZWl2ZXIgZGlz
YWJsZSBwcm9jZXNzLA0KPiB0aGUgb3ZlcnJ1biBpbnRlcnJ1cHQgd2lsbCBrZWVwIHRyaWdnaW5n
IHVudGlsIHdlIGRpc2FibGUgdGhlIE9SRU4gaW50ZXJydXB0IGluDQo+IHRoZSAuc2h1dGRvd24o
KSwgYmVjYXVzZSB0aGUgT1JFIHN0YXR1cyBjYW4gb25seSBiZSBjbGVhcmVkIHdoZW4gcmVhZCB0
aGUNCj4gcnggRklGTyBvciByZXNldCB0aGUgY29udHJvbGxlci4gIEFsdGhvdWdoIHRoZSBjYWxs
ZWQgdGltZSBiZXR3ZWVuIHRoZSByZWNlaXZlcg0KPiBkaXNhYmxlIGFuZCBPUkVOIGRpc2FibGUg
aW4gLnNodXRkb3duKCkgaXMgdmVyeSBzaG9ydCwgdGhlcmUgaXMgc3RpbGwgdGhlIHJpc2sgb2YN
Cj4gZW5kbGVzcyBpbnRlcnJ1cHQgZHVyaW5nIHRoaXMgc2hvcnQgcGVyaW9kIG9mIHRpbWUuIFNv
IGhhZCBiZXR0ZXIgdG8gZGlzYWJsZQ0KPiBPUkVOIGJlZm9yZSB0aGUgcmVjZWl2ZXIgYmVlbiBk
aXNhYmxlZCBpbiAuc3RvcF9yeCgpLg0KPiANCj4gUGxlYXNlIGRvY3VtZW50IHRoaXMgaW4gdGhl
IGNoYW5nZWxvZywgb3RoZXJ3aXNlIHdlIGhhdmUgbm8gaWRlYSB3aHkgdGhpcyBpcw0KPiBuZWVk
ZWQuDQoNClN1cmUsIEkgd2lsbCBzZW5kIFYzIGFuZCBhZGQgdGhlc2UgaW5mbyBpbnRvIHRoZSBj
b21taXQgbWVzc2FnZS4gVGhhbmtzIQ0KDQpCZXN0IHJlZ2FyZHMNClNoZXJyeQ0K
