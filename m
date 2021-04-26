Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02AC3C433B4
	for <linux-serial@archiver.kernel.org>; Mon, 26 Apr 2021 11:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2E9461027
	for <linux-serial@archiver.kernel.org>; Mon, 26 Apr 2021 11:51:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231862AbhDZLwZ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 26 Apr 2021 07:52:25 -0400
Received: from mail-vi1eur05on2058.outbound.protection.outlook.com ([40.107.21.58]:38496
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231831AbhDZLwZ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 26 Apr 2021 07:52:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rt3yIrjCFp4TNgK8Pmnu1uljAbQpK7QkD7bb3iC3Qk4Em5EtGoT/Z0gR27wE1BQ9St4GR1NRv3G/gpOjqJM6eMiy4jFuFtOZYLzAOgBLyrkZ2QjgDT4mt8sbYDcsEAa3Wq/Jb382jYShF/mvNSPwUeD6eAiZaeN+82YORcDavQ1ZcfvUYYwWtensutAJefbLBwzhHMsBrB1BmM8y8aT/nsgOyn9poEwYiTSaJG4wRPGUfASZ6pSqHZPoQQ1IfbZEN/4A+/ftzDELffCfAUs/otf6B0vOuUT/iWz2Pb9S5U5A6sNGycfdpaKRHUZ+P/Q2CCnHUzHbdmyZXKZeB+1+Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mZ0u49RxXAnBeG4D8/lIhDZaAM071Z1gLCPURnp0sWU=;
 b=jyRFLQyPafOVRHqpsopWuq8xf6ZNKDl2b4vfnftKimumtaAH0V8hY/LFpFhZAPOuqvHx4ie+35qGmEk/Xnb4oiMcYoN1KfrWU6CL/Zw8QJYxF4oo8y47DVhK+dpzLssPo9cBpQnOo1q3SfP+13GlcPgSQkQFAMZLurukuCBry8Wdb/aUvRhI0yZtRhK2xRMoh0oY/T81EUmwn/sh3J+b28TDUxY/mZIagcVe4nq0KariFwGYFd3iJ2oGtdM6uEBVcl7CDoNOjllqoXs4iYRfw/r0tJtPYi2+v/2Hby7RFWApyPIycTrcrUEmxsPneE69/llGSc46rHmdkNKl7UK8DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mZ0u49RxXAnBeG4D8/lIhDZaAM071Z1gLCPURnp0sWU=;
 b=OZpN9KDCYN98rf8ymVcnREDWLL9+SuD2l3hha810vD2va28hU+8miyqdD68yN/pa9QHsl7kSnaLxUFTwAETMhK00X3Fg1pLTZiYI2vFxJ890CX954pK6H/g5JJxeJMpvxbwD2+QyoQN/sOc0W+v5e0v3xNaPDYqAv1BUuxnP9n4=
Received: from AM0PR04MB4947.eurprd04.prod.outlook.com (2603:10a6:208:c8::16)
 by AM0PR04MB7186.eurprd04.prod.outlook.com (2603:10a6:208:193::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Mon, 26 Apr
 2021 11:51:39 +0000
Received: from AM0PR04MB4947.eurprd04.prod.outlook.com
 ([fe80::c9b0:c412:80f0:4645]) by AM0PR04MB4947.eurprd04.prod.outlook.com
 ([fe80::c9b0:c412:80f0:4645%6]) with mapi id 15.20.4065.027; Mon, 26 Apr 2021
 11:51:39 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 1/2] tty: serial: fsl_lpuart: fix the potential bug of
 division or modulo by zero
Thread-Topic: [PATCH 1/2] tty: serial: fsl_lpuart: fix the potential bug of
 division or modulo by zero
Thread-Index: AQHXOnDozEAqr+Jd7U+V+2HHvk8drarGcc0AgAAwVTCAAAkhgIAAAtsw
Date:   Mon, 26 Apr 2021 11:51:39 +0000
Message-ID: <AM0PR04MB49470E50CFAB8C36EABB241192429@AM0PR04MB4947.eurprd04.prod.outlook.com>
References: <20210426074935.11131-1-sherry.sun@nxp.com>
 <20210426074935.11131-2-sherry.sun@nxp.com> <YIZ0/vRLASlUph6x@kroah.com>
 <AM0PR04MB4947A9253CE547BEBE95BE8092429@AM0PR04MB4947.eurprd04.prod.outlook.com>
 <YIalMRdbAKZpIJWP@kroah.com>
In-Reply-To: <YIalMRdbAKZpIJWP@kroah.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d7f828ec-1e98-488b-1c03-08d908a9a6ef
x-ms-traffictypediagnostic: AM0PR04MB7186:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB7186466748A5C996AA54039492429@AM0PR04MB7186.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T2cMKwVrzdfm4bco+udOTj1okNdIcggDJ/yEFsnORdLq+zbPN8rH466zsL+1rPIBw4Jq/UEKTutN6rLE7vw+sFpKTNHEb5WeTbCQLZlwnE+nxthPrVXf9gmwIxTnP+GXBzF9HWwKl6Tqq8QiKQXqFm2uflyFoX0FYA5BtZVd10Y3m55jYGhIfLzGpBklAvEbQPYtcdcCw9tr9+iIvoQPpzVQ4eTmmbo3MUzidbM0K1PAU7w19RAUb9RKQl178jy2+9oQr3BeZacGSGk/4SY0lUWsOAt+JXBeF2anGRepeztVEfyJl0N4KZMoo8E9ZRYRkMoQIH9e3tc+ChnVocyeOQj/XPzTRGNk9DCzErc8aJYgEYHQtWNwNHjKV+/yEmLrh8Y4adV0vXOnDAAhz8Rod9UfIK5SUKlz1NGRUqWoAPhlR3Re9FkUoBrC7IlLLNQkRVRj+8FGjTUlw8vOBrLINa98N8jpXm1aIFinFzLgJATeqCuTziV97EYbbCnDaG2mx1JRb9OGsFRMyUxA2XdK+jFDCpr+nYbk+Ykaep8AWHIsJP9HrIabD1eqW84Z49SLn1T2fDySBE0aQh3Y1Dv41YNsDx/Mrgq3EKWVo41VY/E=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB4947.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(136003)(396003)(39860400002)(346002)(66946007)(6506007)(7696005)(66476007)(66556008)(64756008)(66446008)(478600001)(52536014)(76116006)(54906003)(316002)(4326008)(83380400001)(8936002)(38100700002)(9686003)(122000001)(71200400001)(2906002)(86362001)(55016002)(8676002)(186003)(26005)(5660300002)(6916009)(44832011)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?NzV0bFdYK0c1eHJPOVZFZ2g1cHdmMTNlV0F2M01tenozQVhaYUpaOEJzTElR?=
 =?utf-8?B?QURTbjlaYi8rQzFySWptMjZlQmYzWld2NDAxUVU3Mjd1c3Y1TWdsWkRJNzNW?=
 =?utf-8?B?dUVyS0RFV2xCd2hZOVgzN1R3MkhHRWdhY0pFVVhyZDZGNnJqbHhyZVgreFFs?=
 =?utf-8?B?ZVRaK0VJck50VW1mUmYySmFYVTg2dWx2aWYybFNnTGRaRC9JKzBwOW5EaDJz?=
 =?utf-8?B?S00yUFc1QlF5amhrZDJ3Q2YxU2hOdWYrVWkyT3VXZ2ZSM2N5bnl5TnZNMUVY?=
 =?utf-8?B?WWdWWEkwMVFnYk9mcEsvOVFtZ2NVaEpzQlRvN2ZhUDA2M3hMSFQwbUxNdXA3?=
 =?utf-8?B?aU95bjI1d2ZtQWcyOTlLblNwa09tMk9vWitGazY1SjduamRSL1gyODgrVFh0?=
 =?utf-8?B?eElJcXU0OVdCZzE4bDRPZWdlTFJNM20rbHNTRVJQWDNMYlFEODdRYWh6akdF?=
 =?utf-8?B?L3V0SDlLT0FpZGdTei8wandPWDRSbEZIenBRQlZ1ZmNPdE4zVDZmbEx1WTc1?=
 =?utf-8?B?RVd6UGduV2NaUzZGdDVWNTA5cWMyb0RkcXlYQmNxL2JiOXdRYktqR1g2VVpv?=
 =?utf-8?B?L2o2ZkhZS1VBL2pPQ3RWMW03VXQ0MTVxUnQyNU8xVzZLcVRpcW1uc2xTa1dJ?=
 =?utf-8?B?QytXWndQL1NTWWVsRXIxc1Q0RnVKWUhGVEZRN2NWODdoRjlxeDNhQUplRUx3?=
 =?utf-8?B?V0NyUnUranVMQ05jOTQyM3R5UmxKcHFwSGR0aUlSRlByaDZTRmhmVExEL0pp?=
 =?utf-8?B?cmNyY1pBVVovUjFLMEdLdk9sdWRoUkFSdkU0SVVvV1FsZ1JFY25FdTI2aEhP?=
 =?utf-8?B?bGhDQkRsSWUzZExUVmNPNXVqSCthM1RuczBKQmtoNHY3U2ZsVDcyWkRhYnhj?=
 =?utf-8?B?ZlJkTDVxUVRXZUdKMkNDRVVZTjUwVEZ5NCtnUWFPWUxrMGx2STg1eXYwUU5n?=
 =?utf-8?B?RzgxK3N5Rk9xbUQraEJZc3ZaQmIzd010bXhKamJuQitNV3F2ckU0V1ZYZk1V?=
 =?utf-8?B?NUFDWFYyUGpPK1dielBDb2RYY3YvTURWWjlHSEllQ3NIVE9kVFZxampjenQ4?=
 =?utf-8?B?TURwakkxU0p1U0lHeXRSMGJkdWpxZlNmU0Y3aHVyS3EybDd4aHRwcGNtSFpE?=
 =?utf-8?B?OTQyMTNzL2loRnpZQmY1RUxLclg0d2R4bld3V3NiZGxzaVNWd2t1a01vaFE4?=
 =?utf-8?B?MGZFOEhTeVZMUTNjTjRraFhHZFlpYU5WeS9nb1p3Nlp1YlprWm9pSmIwU0dT?=
 =?utf-8?B?N2xWcXRtMDZROUdCWWNaUGJHTVBDRTJyclBqRDdlaXBpK0UxcWRjWUV1WUdz?=
 =?utf-8?B?YmFtNVNGd0FtWm1HNGxWeTM5WmJSdFZTOWNRVXBPOFpicDdvL0MvNE0yVzVM?=
 =?utf-8?B?S0RKejV4VFFsSVA0ME1ydHN2b3FmMnhIeTZXOWtBQU8rWTFBYWdGb3ZpNUJV?=
 =?utf-8?B?eTdHSmRBKys0b1EwQ1dhaGY4bGo1Wm9tQXlXVnFYTFBubXI0dWhtdnpBVEV3?=
 =?utf-8?B?RFRzdkd4TFdMZmxqSEUwQ3VPVVc0SnpkYXR3bUZ1K1hPR1l4VWxMWWhMZXhi?=
 =?utf-8?B?VGJJbFpBN1h4MlFDUEN1LzYzcjFJa0swc3ZEU25CaUlNSHpBZjJEM3VmSU5U?=
 =?utf-8?B?TVZoTFFyMnpzb2tXbVJyalBFL3Fmblp4bWJOVlFyQTl5dGhqRUxYbjYwcm9s?=
 =?utf-8?B?bWFaOEZJN1hnV0dPRDZYTHVMdWYxRGVsMUZwZHZlS2hYY1BEL3pRNDNYdUdM?=
 =?utf-8?Q?G3PtVfqVHWHDwmqgoE9jJbl35X6oAYCY8tlScLl?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4947.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7f828ec-1e98-488b-1c03-08d908a9a6ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2021 11:51:39.1829
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qejQxsM05LGuqeY2+ikM/yegByQJrisj2qiqsKAxRzPCMY6TDp4GpBTo9J/ZBWNGcyeUv348BRs9iM7r068krA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7186
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

SGkgR3JlZywNCg0KPiA+ID4gPiAgZHJpdmVycy90dHkvc2VyaWFsL2ZzbF9scHVhcnQuYyB8IDMg
KysrDQo+ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspDQo+ID4gPiA+DQo+
ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3R0eS9zZXJpYWwvZnNsX2xwdWFydC5jDQo+ID4g
PiA+IGIvZHJpdmVycy90dHkvc2VyaWFsL2ZzbF9scHVhcnQuYyBpbmRleCA3OTQwMzUwNDE3NDQu
Ljc3N2Q1NGI1OTNmOA0KPiA+ID4gPiAxMDA2NDQNCj4gPiA+ID4gLS0tIGEvZHJpdmVycy90dHkv
c2VyaWFsL2ZzbF9scHVhcnQuYw0KPiA+ID4gPiArKysgYi9kcml2ZXJzL3R0eS9zZXJpYWwvZnNs
X2xwdWFydC5jDQo+ID4gPiA+IEBAIC0yNDE0LDYgKzI0MTQsOSBAQCBscHVhcnQzMl9jb25zb2xl
X2dldF9vcHRpb25zKHN0cnVjdA0KPiA+ID4gPiBscHVhcnRfcG9ydCAqc3BvcnQsIGludCAqYmF1
ZCwNCj4gPiA+ID4NCj4gPiA+ID4gIAliZCA9IGxwdWFydDMyX3JlYWQoJnNwb3J0LT5wb3J0LCBV
QVJUQkFVRCk7DQo+ID4gPiA+ICAJYmQgJj0gVUFSVEJBVURfU0JSX01BU0s7DQo+ID4gPiA+ICsJ
aWYgKCFiZCkNCj4gPiA+ID4gKwkJcmV0dXJuOw0KPiA+ID4NCj4gPiA+IEhvdyBjYW4gdGhpcyBl
dmVyIGhhcHBlbj8NCj4gPiA+DQo+ID4gPiBOb3QgdG8gc2F5IHRoaXMgaXMgYSBiYWQgY2hlY2ss
IGJ1dCBpdCBmZWVscyBsaWtlIHRoaXMgY2FuJ3QgcmVhbGx5DQo+ID4gPiBoYXBwZW4gaW4gcmVh
bCBsaWZlLCB3aGF0IGNvZGUgcGF0Y2ggY291bGQgY3JlYXRlIHRoaXMgcmVzdWx0Pw0KPiA+ID4N
Cj4gPiA+IEFuZCBoYXZlIHlvdSB0ZXN0ZWQgdGhpcyBvbiByZWFsIGhhcmR3YXJlPw0KPiA+ID4N
Cj4gPg0KPiA+IFRoYW5rcyBmb3IgdGhlIHJldmlld2luZywgeWVzLCBJIGhhdmUgdGVzdGVkIHRo
ZSBwYXRjaHNldCBvbiB0aGUgcmVhbA0KPiBoYXJkd2FyZS4NCj4gPg0KPiA+IFNlZW1zIHRoZSBj
b3Zlcml0eSBjaGVjayBpcyBzdGF0aWMgc2Nhbiwgc28gY2Fubm90IGp1ZGdlIGlmIFVBUlRCQVVE
DQo+IFJlZ2lzdGVyIHdpbGwgYmUgemVyby4NCj4gPiBJIGp1c3QgZm91bmQgYmVsb3cgc3RhdGVt
ZW50IGluIHRoZSB1YXJ0IHJlZmVyZW5jZSBtYW51YWw6ICJXaGVuIFNCUiBpcyAxDQo+IC0gODE5
MSwgdGhlIGJhdWQgcmF0ZSBlcXVhbHMgImJhdWQgY2xvY2sgLyAoKE9TUisxKSDDlyBTQlIpIi4i
DQo+ID4gU2luY2UgSSBhbSBub3QgZmFtaWxpYXIgd2l0aCB1YXJ0LCBkbyB5b3UgbWVhbiB0aGF0
IHRoZSB2YWx1ZSBvZiBVQVJUQkFVRA0KPiBSZWdpc3RlciB3aWxsIG5ldmVyIGJlIHplcm8sIHNv
IHRoaXMgY2FzZSB3aWxsIG5vdCBoYXBwZW4gaW4gcmVhbCB3b3JkPw0KPiANCj4gR2l2ZW4gdGhh
dCB0aGlzIG5ldmVyIGhhcyBoYXBwZW5lZCB3aXRoIGhhcmR3YXJlIGZvciBzdWNoIGFuIG9sZCBk
ZXZpY2UsDQo+IHBlcmhhcHMgaXQgaXMgaW1wb3NzaWJsZS4gIEJ1dCBpdCB3b3VsZCBiZSBnb29k
IHRvIGNoZWNrLg0KPiANCj4gPiBJZiB5ZXMsIEkgd2lsbCBkcm9wIHRoaXMgcGF0Y2guDQo+IA0K
PiBIYW5kbGluZyAiYmFkIGRhdGEiIGZyb20gaGFyZHdhcmUgaXMgbmV2ZXIgYSBiYWQgaWRlYSwg
c28gSSBkb24ndA0KPiBuZWNlc3NhcmlseSB3YW50IHRvIGRyb3AgdGhpcyBwYXRjaCwgSSBqdXN0
IHdhbnQgdG8gdHJ5IHRvIGZpZ3VyZSBvdXQgaWYgdGhpcyBpcyBhDQo+ICJpbmNhc2UgdGhlIGhh
cmR3YXJlIGlzIGJyb2tlbi9tYWxpY2lvdXMiIHR5cGUgb2YgY2hhbmdlLCB2cy4NCj4gYSAidGhp
cyBidWcgd2UgYXJlIHNlZWluZyBpbiByZWFsIGhhcmR3YXJlIiB0eXBlIG9mIGNoYW5nZS4NCj4g
DQoNClllcywgeW91IGFyZSByaWdodCwgdGhlIHByb2JhYmlsaXR5IG9mIGhhcmR3YXJlIGhhcHBl
biBpbiB0aGlzIGNhc2UgaXMgcmVhbGx5IGxvdy4gQnV0IHdlIGNhbm5vdCBndWFyYW50ZWUgdGhh
dCBpdCB3aWxsIG5ldmVyIGhhcHBlbi4NClNvIHdpbGwgdGhpcyBjaGVjayBoZXJlIGJlIGFjY2Vw
dGVkPyBUaGFua3MhDQoNCkJlc3QgcmVnYXJkcw0KU2hlcnJ5DQoNCj4gdGhhbmtzLA0KPiANCj4g
Z3JlZyBrLWgNCg==
