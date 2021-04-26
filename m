Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F1B6C433B4
	for <linux-serial@archiver.kernel.org>; Mon, 26 Apr 2021 12:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DCC56101C
	for <linux-serial@archiver.kernel.org>; Mon, 26 Apr 2021 12:47:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbhDZMrm (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 26 Apr 2021 08:47:42 -0400
Received: from mail-eopbgr10086.outbound.protection.outlook.com ([40.107.1.86]:57166
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233317AbhDZMrb (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 26 Apr 2021 08:47:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CcsUOHjkamgAh2DSukVPCDqCfjnaN/qfb0QJRFneyRYrqvZzUDqjiKgcBXmlLkWb5oYXIqrYPzdpdjbTyTTXCllrFjT5ZYQ7dhOZ8qNd23qIGLHR6feEAJfIOpe4iet1KGNPY1gfdGYYxPtEyqcrDi9eTrWMvHxfAsD941TiqBQLOsqgWn/LfhODQdIB2og44SHGZA2uFjrOzqPZv6fx5cD6LVLkKg6i3YW/r3PNUovm7PqFWkhsxC+y3kvk2SgpKg8UBoob2E0Cw4QyeOYUKDiwcVpMZDCW/cj2D82mYUIVrJ7FRKHdPU+aewOO3StjAgi9CuSw7ZG0Y6KK5bkHLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zFZ+MaQx8oTriylX7eWapTTY70DY0d/N+QLL7nK8Iog=;
 b=d1/OKA2WyGh1AcgsHGQdrJdwbOkjmj9H5Q2ffXUF/R/4PJlLwFWI2JpK4vNflyY6f+N3QtTvFTmuFVyoEMOUtx3O8crac3MJq0u2HXn/2+Fp+25tf4JHJSxXrSi15PFT3EyD83KJ/ktuCJxfHHbTDxJXbMxvW+IzM5syJSyFvlnW6oo2l4CvbRK9Sg1J6L6W/dnqh2EGUpMEQv8xMgEvgcetgiV0YYURYtz4DVGm6E4WV7JdsgkmlmPxebC2ayjWIsdQWzXqBvTQ2nZhSghGU2X6Jp6859gMFcGvJaCJld62DhzBqoLoMVsvOu9cA6KEUdhNwVcLGWWGX36CxPpYFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zFZ+MaQx8oTriylX7eWapTTY70DY0d/N+QLL7nK8Iog=;
 b=Y0tbUgcRnHLX6E63mWRxZnEWFl1YxqRkmMOG1Is/Tb26wrPBLSHbehDwKhH6qZh99z5d9qAhqL8FTrhVBM5EPV7amXg0CSvwufc1YXc2TfkYZMpYYTAFXeJROKGDmPPTlm7OpX6DW6rYCUJ3UI/HvEih8xmdS/b3vEKZaLfshjA=
Received: from AM0PR04MB4947.eurprd04.prod.outlook.com (2603:10a6:208:c8::16)
 by AM8PR04MB7426.eurprd04.prod.outlook.com (2603:10a6:20b:1d7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Mon, 26 Apr
 2021 12:46:47 +0000
Received: from AM0PR04MB4947.eurprd04.prod.outlook.com
 ([fe80::c9b0:c412:80f0:4645]) by AM0PR04MB4947.eurprd04.prod.outlook.com
 ([fe80::c9b0:c412:80f0:4645%6]) with mapi id 15.20.4065.027; Mon, 26 Apr 2021
 12:46:47 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 2/2] tty: serial: fsl_lpuart: fix the potential bug of
 dereference null return value
Thread-Topic: [PATCH 2/2] tty: serial: fsl_lpuart: fix the potential bug of
 dereference null return value
Thread-Index: AQHXOnDr8/FCGWBm7kWmZDaqq+nPsqrGchAAgAA4RHCAAA52AIAAAlGg
Date:   Mon, 26 Apr 2021 12:46:47 +0000
Message-ID: <AM0PR04MB4947082ECB33A877233CA5D692429@AM0PR04MB4947.eurprd04.prod.outlook.com>
References: <20210426074935.11131-1-sherry.sun@nxp.com>
 <20210426074935.11131-3-sherry.sun@nxp.com> <YIZ1NvISshNHtX/Z@kroah.com>
 <AM0PR04MB4947DAD4EAA84FEAA5A2B28A92429@AM0PR04MB4947.eurprd04.prod.outlook.com>
 <YIawisbbnU4Us1eT@kroah.com>
In-Reply-To: <YIawisbbnU4Us1eT@kroah.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0e07e06b-11d6-422e-c105-08d908b15aa1
x-ms-traffictypediagnostic: AM8PR04MB7426:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM8PR04MB7426143E7EA5971CDA3B4CEB92429@AM8PR04MB7426.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0D8Pnj7yrQFYoOW4yWc4nYQAci8mlw+6+vs/gnlALERNz5purL6Mf+XLRtgc86dJMr2/pNUCPKZb5WPll/5XFjOXDk+1bTEcseIoWo7O574RZ55iAtbJ+sC89CJwXvJG8FdViEFzeE3Q6sQ7K+HOljZ2eLngGQBvxRD3J8R6QauesG0IlG1XHSxhVjmlnS4FLfNitPBpVSNzi7amaGIsLGYtRcr1enb6dkqUe+c3cW4nOs8Pw9h/G3t9+XogEddowJPYmxyAUUYKrD1sAy6kAyXYdSZBn5Uvci/Di6AiW9d1K3eJMSPPKZYKsTZ4btAubvwDD6qMzWCM/MUYc84tOWEH3H4/mM7CgVd0dzta1NzlVz0Z3TkSr4L5JOd5jVsz/pfB06uB8QNyREra1a9eMQ6MuDYPkFWChLVCgAhsVWDATqaLzMylweAh/kS6DmtZw28BFFa+YC6WuHhbhFB9b1whQpYCciBtOhvGg/twkq8dkBREhbxwAJVu3rhMJSTlNadiUq3hui9IW4gTMwf+RMaq2s3wAdGH1nib9pkY9fKDuOT+Q+6HUcGGOAkMdv2HzSdwWy/yHUWhXuhyL6hIrJn2Lt/pLbFbDOsUvMFXKsU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB4947.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(26005)(76116006)(498600001)(33656002)(5660300002)(186003)(54906003)(55016002)(8936002)(9686003)(83380400001)(122000001)(86362001)(7696005)(64756008)(66946007)(66446008)(66556008)(66476007)(71200400001)(38100700002)(2906002)(6506007)(6916009)(4326008)(52536014)(44832011)(53546011)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?ZkU4bVdNM0tOSERJQVE5OXAzYisrZUhMY3M3Z3A3K2tiWklRM0hPdHZQTjc1?=
 =?utf-8?B?YllHRHAzSUdqa1B6VjRUR2NXdU1SUEtsTjVzSEVSSEJNYkJNTHdSa1B4bHdD?=
 =?utf-8?B?bnZibCtIY29BKzFDUGpTOXVqcjlqeGRTU3V4VGVpcGJvTGcwTm1XaStKZjJG?=
 =?utf-8?B?NVNRcS9hVW94ejdGTEJtajMwN1VFRjhlVWgwY25aUjlSMlZRekhYdlYxa2I3?=
 =?utf-8?B?NHpaNFNWb24xS1JUNEpPcDdiMis5b3N1U1lwTnBVa2o5K2pMaTFQUUhoaW9k?=
 =?utf-8?B?RWhMRUFNLzBOWUc5cE9GZW1Ob296eUpBZTZUSGhkM1Y5MC9OejFRcG1jOW13?=
 =?utf-8?B?RFM2R2lEaWxjZFFuUmpXSkJuVjVLYTA3SmdFYjcraWYxRWY0STV6SFBIS0xm?=
 =?utf-8?B?aE1wUU5hZ041NnQrMjhHN3FQNWpNSFlRQ2krSFdBU1pWVTI3ODVyd2E2VFZD?=
 =?utf-8?B?WUoxTnlWVVVDWGNjeXpJWktrTkNJbmRWNENjekhWNHRBbVdIbC9HRFRXQzho?=
 =?utf-8?B?cmhrY1BhUVA3bWl3alBoa1RNVmJmU2gvK0lON2dNcWJ6RHJLdUVxVFpnRnkr?=
 =?utf-8?B?bzVCbTYyNy9vcW5TRnNMOFF4aVEyeXgybWlGZy9kbHIwdThLMDkyOEo2djlo?=
 =?utf-8?B?a3hKaldWb1BaR2JjQmdVaHQxWEJhVmxLSkV3MEg1YUpyaVV0MzlqczhIbzJK?=
 =?utf-8?B?NjE2bVg1b3U1c2d3Q3p3V3h1WCtpdG5MOXdZNHdaS2VYQ3hYa2lOcTJabWhx?=
 =?utf-8?B?Mk43b1ZxYkl3by9zbm1PWUpMUXNRYWFvajFGMUY3NlVQQkZqWDhGVy9BWWg0?=
 =?utf-8?B?MUl5cWtEVDR1NHExUFU3V0pqZXhPT2ZRd3RCSURsajRPZ05kTVY3V1JDYzNs?=
 =?utf-8?B?d1ErMGxjZ296ancyaXpOcWtFVFZlbUdndHNtMmN0Q011WFNUWnZRSDVYOG5L?=
 =?utf-8?B?WmpQMU1nYW1jSFJXckZGc05zOXJmcThFaUViYVROeVVwSWx1UG1kRDROU3dj?=
 =?utf-8?B?VkpqSWY5U2FDcEJucWVqcTMzTkxMd2szVWsxNTFldmRwS3ZkUlQyMTVmNmtX?=
 =?utf-8?B?cXM3SU5FRlBVWlR5WGExWlhFdExuQ2Z6VUN0MmxxL1JHQnlRSDI4NW1FdUMy?=
 =?utf-8?B?dEtzR2NyWlU1b2RHMnZsZEg1UzlpeDl2aUtidDhPK3VsZGozdStXeWhKc0c4?=
 =?utf-8?B?YkM1SkJkMFhNZmFzWm90UHd3Mlkyc0szSTRpUE9HdTUyc2ZLbktHYzZhRS9Q?=
 =?utf-8?B?aUNsckJQakE0V0JNU2IzeHBKZFJzUUtFNkpENWpvL1ZFbWZNbGI5emM1OTl5?=
 =?utf-8?B?WnJNb2ZFdmliMXpXWmFUU2c0QzI5bGdxL1U2bW0zK0gzUUVDSUh1Zzk3NGNW?=
 =?utf-8?B?TFVua2hQYnZKeEljNStBZGUyUFNlUmNiSU1NMGJyZlNpMEUvNzRodzlaZEtP?=
 =?utf-8?B?ZXYremJQeGUxZDRXZTJENVUyaVMyRkdVaTk3Tm5iWnRLQTg3eld1NHN1aGRj?=
 =?utf-8?B?eDFxRnFnTy80VjFwM21rZkNqYldJTjJwVGZnbm1EVXI3RCs0TzdRcFZZdDlI?=
 =?utf-8?B?UGJuYVFJakV2TEtNMVVrc29kdHRLcjlZNW9DMFdMek5hOWtibTIxMWkyRTB5?=
 =?utf-8?B?Nm9rcmdOandIQzcxdy94S2JjVzltbVp4ZUc2NkkrYTBVTzBuVk1hdEN5Mi9l?=
 =?utf-8?B?NUQ1eTErZmpRZHdZcTlLbU1oMzB6QUN3Nys0OVpEdExkc282UnlPTjNaRWND?=
 =?utf-8?Q?q6x+WZwhBOiXHFSphjuyPb96x85f9PZyN+YPA+5?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4947.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e07e06b-11d6-422e-c105-08d908b15aa1
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2021 12:46:47.1680
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zHGk94gBOU2rUFmNMsoroD8QpX1M0jmRUjuzNTVuJFGPSCIlXA4emny5sfdnwwTulC608w/NLiHqth8IWZIR6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7426
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

DQpIaSBHcmVnLA0KDQo+ID4gSGkgR3JlZywNCj4gPg0KPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gPiA+IEZyb206IEdyZWcgS0ggPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3Jn
Pg0KPiA+ID4gU2VudDogMjAyMeW5tDTmnIgyNuaXpSAxNjowOQ0KPiA+ID4gVG86IFNoZXJyeSBT
dW4gPHNoZXJyeS5zdW5AbnhwLmNvbT4NCj4gPiA+IENjOiBqaXJpc2xhYnlAa2VybmVsLm9yZzsg
bGludXgtc2VyaWFsQHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+ID4gPiBrZXJuZWxAdmdlci5r
ZXJuZWwub3JnOyBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAuY29tPg0KPiA+ID4gU3ViamVj
dDogUmU6IFtQQVRDSCAyLzJdIHR0eTogc2VyaWFsOiBmc2xfbHB1YXJ0OiBmaXggdGhlIHBvdGVu
dGlhbA0KPiA+ID4gYnVnIG9mIGRlcmVmZXJlbmNlIG51bGwgcmV0dXJuIHZhbHVlDQo+ID4gPg0K
PiA+ID4gT24gTW9uLCBBcHIgMjYsIDIwMjEgYXQgMDM6NDk6MzVQTSArMDgwMCwgU2hlcnJ5IFN1
biB3cm90ZToNCj4gPiA+ID4gVGhpcyBpc3N1ZSBpcyByZXBvcnRlZCBieSBDb3Zlcml0eSBDaGVj
ay4NCj4gPiA+ID4gSW4gbHB1YXJ0X3Byb2JlLCByZXR1cm4gdmFsdWUgb2YgZnVuY3Rpb24gd2hp
Y2ggcmV0dXJucyBudWxsIGlzDQo+ID4gPiA+IGRlcmVmZXJlbmNlZCB3aXRob3V0IGNoZWNraW5n
Lg0KPiA+ID4gPg0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBTaGVycnkgU3VuIDxzaGVycnkuc3Vu
QG54cC5jb20+DQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiAgZHJpdmVycy90dHkvc2VyaWFsL2ZzbF9s
cHVhcnQuYyB8IDMgKysrDQo+ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCsp
DQo+ID4gPiA+DQo+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3R0eS9zZXJpYWwvZnNsX2xw
dWFydC5jDQo+ID4gPiA+IGIvZHJpdmVycy90dHkvc2VyaWFsL2ZzbF9scHVhcnQuYyBpbmRleCA3
NzdkNTRiNTkzZjguLmM5NWU3MWZkMmNhMA0KPiA+ID4gPiAxMDA2NDQNCj4gPiA+ID4gLS0tIGEv
ZHJpdmVycy90dHkvc2VyaWFsL2ZzbF9scHVhcnQuYw0KPiA+ID4gPiArKysgYi9kcml2ZXJzL3R0
eS9zZXJpYWwvZnNsX2xwdWFydC5jDQo+ID4gPiA+IEBAIC0yNTg5LDYgKzI1ODksOSBAQCBzdGF0
aWMgaW50IGxwdWFydF9wcm9iZShzdHJ1Y3QNCj4gPiA+ID4gcGxhdGZvcm1fZGV2aWNlDQo+ID4g
PiAqcGRldikNCj4gPiA+ID4gIAlzdHJ1Y3QgcmVzb3VyY2UgKnJlczsNCj4gPiA+ID4gIAlpbnQg
cmV0Ow0KPiA+ID4gPg0KPiA+ID4gPiArCWlmICghc2RhdGEpDQo+ID4gPiA+ICsJCXJldHVybiAt
RU5PREVWOw0KPiA+ID4NCj4gPiA+IEhvdyBjYW4gc2RhdGEgYmUgTlVMTD8NCj4gPg0KPiA+IElz
IGl0IHBvc3NpYmxlIHRoYXQgYSBjYXNlIGZvcmdvdCB0byBzZXQgc2RhdGE/IFRoZW4gdGhlIHZh
bHVlIHdpbGwgYmUgTlVMTCwNCj4gc3VjaCBhcyB7IC5jb21wYXRpYmxlID0gImZzbCxpbXg4cXhw
LWxwdWFydCIsICB9Lg0KPiANCj4gSWYgYSBjYXNlIGZvcmdldHMgdG8gc2V0IHRoYXQgc29tZWhv
dywgdGhlbiB0aGUgZHJpdmVyIHdpbGwgbmV2ZXIgd29yayB3aXRoDQo+IHRoYXQga2VybmVsIGNo
YW5nZSwgc28gc29tZW9uZSBiZXR0ZXIgbm90IHN1Ym1pdCB0aGF0IHVwZGF0ZSA6KQ0KPiANCj4g
Tm8gbmVlZCB0byBjaGVjayBmb3Igc29tZXRoaW5nIHRoYXQgaXMgaW1wb3NzaWJsZSB0byBoaXQu
DQoNCk9rYXksIGdvdCBpdCwgd2lsbCBkcm9wIHRoaXMgcGF0Y2gsIHRoYW5rcyENCg0KQmVzdCBy
ZWdhcmRzDQpTaGVycnkNCj4gDQo+IHRoYW5rcywNCj4gDQo+IGdyZWcgay1oDQo=
