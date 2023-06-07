Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA89C7EE23
	for <linux-serial@archiver.kernel.org>; Wed,  7 Jun 2023 12:41:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240687AbjFGMlE (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 7 Jun 2023 08:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240355AbjFGMlB (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 7 Jun 2023 08:41:01 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2060b.outbound.protection.outlook.com [IPv6:2a01:111:f400:7d00::60b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38A04E6B
        for <linux-serial@vger.kernel.org>; Wed,  7 Jun 2023 05:40:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CIuhiuUc7oij8qN37i8EVUwf4H+VjBUh9AIIQrtHsYiNPWoBtTYMKvjEEhDESuBiOOOGOWBhiPh0uW3rojz+GVNv3Zsv+1IjhRZaq2gWWmWdqG0rTP73BZuvZlC0JD4IFnjxk0x6HKJ2awhL52NF5DtG47PPFlMRaMp1cXjt6vBTGcv//cGdvQr9mQGSEYBaMr84YdI2IuBlhZ61QOqNXDqmeryyCAzAMFMGO4ClP5fmXocUno+R3vl8Ai+j3/9t7B0HoMqhrf8VjVDPOBwhBhJtSWleIDTx3aVTGVsyGJiy0k/FV0c6Pt9PYmZN4jWzlm0hoFtJpQ1DHisy7VDybw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/O7qEZH5tB20WabrSOTNXRQwvb9nr5o1bx4eerySnD0=;
 b=eZrPxB9mK9ZT0aRDjLMPEu8G96EqdIuXIGRob3jl6zjUc4qf43UHmZ776ZrRlM7RcucEqLiM4Pem3tUErVSQLRkVeqTUfSxFCmJgJwsBBM1O37UkbO778XWL/EwrdprI/YHWfZ0MF4Am/7jjlGWqgiqCHEs/EnI4DgMQYRfBxNer/ragy66xq8nvMuqlz1+fAJFB/96aUYghjJ57+cddaGXpXDQOr//oco81sE62V3HUjcd7sFKDOwb8zGukC1pIhJLmlY69JOJNEUzxDYqiaj3eUJiQNKFenvNk9f6SBdfKb+85WECE9+brAMnwWUyR3JfnbGTnuh4xetWZ1ogx1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/O7qEZH5tB20WabrSOTNXRQwvb9nr5o1bx4eerySnD0=;
 b=O5ZsU0WR5Ppkf3Tclu7YuF5gavQiyjGiDuVDS3hzzulF/33E9+lyVatKce8vjFDZl2hFjZxT+yqy1HXZy/x5z4mQvp2kWNP8px089mvXM/ixr+29B0CRAWlzOWzfG24fPqpoeQMsQ6yJGS7yx7mTfwwSDIUMvhoHvC1F5f5hpMw=
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by AS8PR04MB8578.eurprd04.prod.outlook.com (2603:10a6:20b:425::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 12:39:28 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::ef9f:1e01:e8a:6a4a]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::ef9f:1e01:e8a:6a4a%3]) with mapi id 15.20.6477.016; Wed, 7 Jun 2023
 12:39:28 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     Robert Hodaszi <robert.hodaszi@digi.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: RE: [PATCH] Revert "tty: serial: fsl_lpuart: Fix the wrong RXWATER
 setting for rx dma case"
Thread-Topic: [PATCH] Revert "tty: serial: fsl_lpuart: Fix the wrong RXWATER
 setting for rx dma case"
Thread-Index: AQHZmSvTxz5ihqCiWk2vZTPVoQT3dq9/Q3Mg
Date:   Wed, 7 Jun 2023 12:39:28 +0000
Message-ID: <AS8PR04MB84040A92A1FBFE8177CF08D59253A@AS8PR04MB8404.eurprd04.prod.outlook.com>
References: <20230607103459.1222426-1-robert.hodaszi@digi.com>
In-Reply-To: <20230607103459.1222426-1-robert.hodaszi@digi.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8404:EE_|AS8PR04MB8578:EE_
x-ms-office365-filtering-correlation-id: e2bf972c-9259-4bd9-e878-08db67543c33
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q4hf71Oni3BAAhuLSMBM/D0Hrn6/PHvvpEVGMmbyv+GfDnrBQ1s/5ypWi8noOCr/QsQkAKzd5yZGeYwFAX89qQaEA3yz3oV06fHzRTj7Vi7U5q3nRtEGFopkaHwG2mDNaq/C0zKbF2dqzK4ojQ0PSg4pppbGGqQ1QOG/e8rMBmyCcYT9Pf4ymFCwsiO3jI7CLs1k7SfhT4hjlXUZ0d/PmHbUSmCxBp6HRZ1OVL7sPg1d3xDEPgnB5vloq26jg7ynrBPJvrZDMoil+r+izDCJN1B37hWRsNACksFzcioljdEN8JnS3oW1wLSeUwrBU9C1tJPW7X+EPM7PzmmKtGRDZCR3Xs1BHsxhvjYfM9BpiP+o9QYZkEG4PiqWwMlALBPKMpFz+Rj+nbGOxCgu+kP9966qcbW5u+4ThWYp8TcnyXExVvWJiJagfsrln41PDtX81EAuuJ4kFm3b0hrDLFsWnLlW5gAxwvilIQUOv+JweCOWp9e5B30xk7hfG6vGE/7VM3eJMJxSBxzrl3sw877pelJo06Odn7cuPsDe+nABh7t1A+gfdQGXtnQN+/QvkFPPOG2b7UNd0xZlf21XZKV469CCBy5KUS9cOZfR/u8cr4qOjzsj88g0KwzviVt3l2ak
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(376002)(396003)(136003)(39860400002)(451199021)(38070700005)(66556008)(66476007)(66946007)(76116006)(52536014)(8676002)(8936002)(64756008)(66446008)(5660300002)(86362001)(316002)(110136005)(44832011)(41300700001)(478600001)(38100700002)(122000001)(2906002)(71200400001)(9686003)(7696005)(26005)(6506007)(53546011)(55016003)(186003)(33656002)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?dDRvZjRSU0dZcnZGRTMrWnQ0WHZTa2kzNmkwWFJjUkRIdHFDRmFUNXUzSXk1?=
 =?gb2312?B?TFYrT3FsaStuTSszeHkvM2RuVFRsVDNRZDlPZVVTdGNEVGQvbDJyOVFvRmNu?=
 =?gb2312?B?QmJaTGJNYzRMcXZKV0ZyUHVHYlpPbDM5VENKOFRKRVZ1cDdLQmZTNDVqY1h2?=
 =?gb2312?B?ZjJGdVY5U0FPYXJGZTJaeWtCTksvdGdqZG5RNmEvci94M0dFU2lGdlFPQlIz?=
 =?gb2312?B?R2lQT24zME1YM055TzdORDNObmcvUE5LNEE2KzhYUXAwN2E1ZnhldzRnY09G?=
 =?gb2312?B?YjJTZld0cXFXYUFxM0tvZTFYclowcmEzNDM5VStpSXplQTBjVW1jQ0tEankz?=
 =?gb2312?B?NjZVcytFd3FxZmgycmZmRlpnQ2dVekxYQk5KbUJGUU5YQk5aT2RxY2dCa0pu?=
 =?gb2312?B?dlpPTmFRaXVmL3RscnQvRDM3bnIray9DdTlEKzFjVDZ0d2JOZXJNb1RMZTFn?=
 =?gb2312?B?NGRMVEp5UVJ1NGRmTWZHMCtMbFQ2NWlYNkhMa1ZOY0ZZb2tuWGU2dnlwUW13?=
 =?gb2312?B?QmdadkN4K29GOEFVTXZaR0prNXRnMERvV1RrMURkYjMzdURtaFFLSWpVNUcx?=
 =?gb2312?B?UnZPclVHYjFhV3l1OGZLenBoaVlVd1QyTUZEdHZGRDU4QzBXVFBBUDB2aFND?=
 =?gb2312?B?VVJvWEY4QXpIMlBKNWRRN2IrWWRGanl6QU5WV2FqTGdDRW1jRnJCLzVlclVI?=
 =?gb2312?B?OGZKSkN0S3JGZ3VDQjkrMXNMR0FldzN6bjk5eCtmSlFmTjRheHo2S25venJP?=
 =?gb2312?B?aW5jMWZEd1c3VGFFNnNjMmJrVVhXN0dycFI5NkZMNUdtbHkxQnpON01YUzFo?=
 =?gb2312?B?M0dPVUF2T05NK3BnQkY1bmtjQzlnUzZNSEhTckptdzJRNm5EaGxRZ2hzZ1pR?=
 =?gb2312?B?ck1Tb0JLbEtCSjZjMC8xTDJsdFV4SkRuK0N6blA4UjEvRHp2UU0rOFBvNEFR?=
 =?gb2312?B?enVUR2ZNVktBWWdxMUtaK0Rzd29zM0M5L2Q1dzN0MkQ1WStmaGlqOWhDVnhD?=
 =?gb2312?B?cHFQQzlGb0I4VDY3WHkvOFpXdnVDME1vdElMNWtUOXBtakhqMkpaUERvV0xQ?=
 =?gb2312?B?T1N6S0pmS20wWklxL0FqWXduR1I0N3F0U0psN2YvY2RST05JQjVQRzYrTGhz?=
 =?gb2312?B?TXhiY3BudGZRTllXSFVGQ2N2SFhkZVErOEFUelBjVWtuOGN6RlQzS3dTbGRU?=
 =?gb2312?B?bHFteVlmWk00cVF2aXpEZ0dFby82ZDc0VVR4aGVkVmZpTWo0ci95YlNZWXRt?=
 =?gb2312?B?UWc4Qmdjb1ZEeFc1T1Rvc2NLc0RlMVRFUWxJRW5lQnFaV1l6VDkrWlpxUHhR?=
 =?gb2312?B?UjdHeTB3SW5jbmRRTlFzQlBWdm9wbjFqSWc2Y0drbXorZWxHSFlZSnl1K1hz?=
 =?gb2312?B?Y2t2a1d4UllWUXp4azgrNGZ6b2ZBN3JvYm1QSXY1UHZ1c2NGUHBWbEZkYVNl?=
 =?gb2312?B?Y2tCUUFUWFdRVEVtODZqVENNKzdSUTJJbk1yMnZxN2VXOGlVdGV2S1o4T01D?=
 =?gb2312?B?dDJjQzQrT29nYXZkOTZ2S3h3WGxVZ2JoTnBFbEEwTitORElJeVVGaTVXSTVI?=
 =?gb2312?B?eEowR0ZxUFRIdTNJRU04b0NyVkdwdUZveGpxSWZCUDRTNkQ0ZE5hS1llRzMw?=
 =?gb2312?B?NEFNbHR6K2hacWhTSG1MajlJUExjdWY0QmFPMXF4ODFrcnNzUC8xcHIxdm5i?=
 =?gb2312?B?cWtuZkZ0RGtxSWw5eHdOYnVIUEQzREFTcEs1cjdMcVV1T3ZVTGpkZDdyQlZQ?=
 =?gb2312?B?bnk1VG5Oa3JsNDUySWNXS0hNQllWZ3lqRHdFeTVkcU9WbDE1Um9lQWhqT1FR?=
 =?gb2312?B?VDhIcHpDVlR6eHVyRVIvc0I5QWhPZVhuYWVTMHNXY3dvN0FjMHR5OHJ5ZmRC?=
 =?gb2312?B?Ykl6QW9zbGZoT2hkWWVQN3pxei95cnZKbXZpcHVKbC84cmVxSWR4c1NhQm43?=
 =?gb2312?B?anJwVm1STXBxMWF0MWQ0eUN4S1JYZWhiTm1kZzU0azVXQWRZdVNodFloODVJ?=
 =?gb2312?B?L0RSVkFOWTJuQkZTSnNPUWRpclRSWXI2Qkl1bCtpWkRhLzJib2ZsVnN0ZmRI?=
 =?gb2312?B?VnlpNGdVQjJDeWszMkhqV1NRYjkrWUZ2OURJQTFtSkpBenMzMVdZZHptdmtm?=
 =?gb2312?Q?PUOHL9zAMfuerLOpjMWNwkttr?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2bf972c-9259-4bd9-e878-08db67543c33
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2023 12:39:28.7838
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z5jqNmNMzsO3zZLo7GhMdy6rLpLXbCKQz41GjnkCaSBC7pP/BbbERR7KTOtFJlD2GkFuY+QXKWKeRXPEp89acA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8578
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUm9iZXJ0IEhvZGFzemkg
PHJvYmVydC5ob2Rhc3ppQGRpZ2kuY29tPg0KPiBTZW50OiAyMDIzxOo21MI3yNUgMTg6MzUNCj4g
VG86IGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnOyBqaXJpc2xhYnlAa2VybmVsLm9yZzsgbGlu
dXgtDQo+IHNlcmlhbEB2Z2VyLmtlcm5lbC5vcmc7IFNoZXJyeSBTdW4gPHNoZXJyeS5zdW5Abnhw
LmNvbT4NCj4gQ2M6IFJvYmVydCBIb2Rhc3ppIDxyb2JlcnQuaG9kYXN6aUBkaWdpLmNvbT4NCj4g
U3ViamVjdDogW1BBVENIXSBSZXZlcnQgInR0eTogc2VyaWFsOiBmc2xfbHB1YXJ0OiBGaXggdGhl
IHdyb25nIFJYV0FURVINCj4gc2V0dGluZyBmb3IgcnggZG1hIGNhc2UiDQo+IA0KPiBUaGlzIHJl
dmVydHMgY29tbWl0IDlhZDlkZjg0NDc1NDdmZWJlOWRkMDliMDQwZjQ1MjhhMDllNDk1ZjAuDQo+
IA0KPiBMU1VBUlQncyBkYXRhc2hlZXQgaW5jb3JyZWN0bHkgc3RhdGVzIHRoYXQgUlhXQVRFUiBt
dXN0IGJlIGdyZWF0ZXIgdGhhbiAwLg0KPiBIYXZpbmcgdGhhdCBzZXQgdG8gMSBpcyBjYXVzaW5n
IGEgb25lIGNoYXJhY3RlciBkZWxheSBvbiB0aGUgcmVjZWl2ZSBwYXRoLg0KPiANCj4gU2lnbmVk
LW9mZi1ieTogUm9iZXJ0IEhvZGFzemkgPHJvYmVydC5ob2Rhc3ppQGRpZ2kuY29tPg0KPiAtLS0N
Cj4gIGRyaXZlcnMvdHR5L3NlcmlhbC9mc2xfbHB1YXJ0LmMgfCA2ICsrKysrKw0KPiAgMSBmaWxl
IGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdHR5
L3NlcmlhbC9mc2xfbHB1YXJ0LmMgYi9kcml2ZXJzL3R0eS9zZXJpYWwvZnNsX2xwdWFydC5jDQo+
IGluZGV4IDc0ODZhMmI4NTU2Yy4uOGYxYmIwYTM3OGQ0IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJz
L3R0eS9zZXJpYWwvZnNsX2xwdWFydC5jDQo+ICsrKyBiL2RyaXZlcnMvdHR5L3NlcmlhbC9mc2xf
bHB1YXJ0LmMNCj4gQEAgLTE3NjIsNiArMTc2MiwxMiBAQCBzdGF0aWMgdm9pZCBscHVhcnQzMl9j
b25maWd1cmUoc3RydWN0IGxwdWFydF9wb3J0DQo+ICpzcG9ydCkgIHsNCj4gIAl1bnNpZ25lZCBs
b25nIHRlbXA7DQo+IA0KPiArCWlmIChzcG9ydC0+bHB1YXJ0X2RtYV9yeF91c2UpIHsNCj4gKwkJ
LyogUlhXQVRFUiBtdXN0IGJlIDAgKi8NCj4gKwkJdGVtcCA9IGxwdWFydDMyX3JlYWQoJnNwb3J0
LT5wb3J0LCBVQVJUV0FURVIpOw0KPiArCQl0ZW1wICY9IH4oVUFSVFdBVEVSX1dBVEVSX01BU0sg
PDwNCj4gVUFSVFdBVEVSX1JYV0FURVJfT0ZGKTsNCj4gKwkJbHB1YXJ0MzJfd3JpdGUoJnNwb3J0
LT5wb3J0LCB0ZW1wLCBVQVJUV0FURVIpOw0KPiArCX0NCg0KSGkgUm9iZXJ0LA0KDQpObywgcGxl
YXNlIGRvbqGvdCBkbyB0aGF0Lg0KSSBhZ3JlZSB3aXRoIHlvdSB0aGF0IHRoZSBMUFVBUlQgUk0g
aGFzIGEgZmFsc2Ugc3RhdGVtZW50LCB0aGUgUmVjZWl2ZSBXYXRlcm1hcmsgYWN0dWFsbHkgY2Fu
IGJlIGdyZWF0ZXIgdGhhbiBvciBlcXVhbCB0byAwLCBidXQgdGhpcyBkb2VzbqGvdCBtZWFuIHRo
YXQgaXQgbXVzdCBiZSAwLg0KQW5kIHRoZSBmYWxzZSBzdGF0ZW1lbnQgIGhhcyBub3RoaW5nIHRv
IGRvIHdpdGggdGhlIGNvZGUgaGVyZS4gVGhlIGNvZGUgaGVyZSBhaW1zIHRvIHNldCB0aGUgZGlm
ZmVyZW50IHZhbHVlcyBmb3IgbHB1YXJ0IGludGVycnVwdCBjYXNlIGFuZCBkbWEgY2FzZSwgYW5k
IGZvcmNlIHRoZSByeCB3YXRlcm1hcmsgZm9yIGRtYSBjYXNlIHRvIDAsIHdoaWNoIGlzIHVucmVh
c29uYWJsZS4NCldlIGhhdmUgYWxyZWFkeSBzZXQgdGhlIHdhdGVybWFyayBpbiBscHVhcnQzMl9z
ZXR1cF93YXRlcm1hcmsoKSwgaXQgd29ya3MgZm9yIGJvdGggaW50ZXJydXB0IGFuZCBkbWEgY2Fz
ZSwgeW91IGNhbiBzZXQgdGhlIHJ4X3dhdGVybWFyayB2YWx1ZSBmb3IgZGlmZmVyZW50IHBsYXRm
b3JtcyBhY2NvcmRpbmcgdG8geW91ciByZXF1aXJlbWVudHMsIGZyb20gMCB+IEZJRk9bUlhGSUZP
U0laRV0tMS4NCg0KQmVzdCBSZWdhcmRzDQpTaGVycnkNCg0KPiAgCXRlbXAgPSBscHVhcnQzMl9y
ZWFkKCZzcG9ydC0+cG9ydCwgVUFSVENUUkwpOw0KPiAgCWlmICghc3BvcnQtPmxwdWFydF9kbWFf
cnhfdXNlKQ0KPiAgCQl0ZW1wIHw9IFVBUlRDVFJMX1JJRSB8IFVBUlRDVFJMX0lMSUU7DQo+IC0t
DQo+IDIuMzQuMQ0KDQo=
