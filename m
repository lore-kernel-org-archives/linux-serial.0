Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A9EDC433F5
	for <linux-serial@archiver.kernel.org>; Tue, 23 Nov 2021 09:05:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233340AbhKWJIT (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 23 Nov 2021 04:08:19 -0500
Received: from mail-vi1eur05on2086.outbound.protection.outlook.com ([40.107.21.86]:25280
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232331AbhKWJIS (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 23 Nov 2021 04:08:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FKwLXjq0vIxn+bhFK168oRwYvqgRlAARlC8by4DeSpv5tjjJuypb8O0u5E3Fuv2wPFbRc/liDitE7npMJK25R7Di42/CXKLoNT4AE0PxZ3NH7LSpJ68atK8YlG/F74d3fIrGgTtOYUOdgNYU83rZ1KZ/Okv4H3VsA69WXyDRckJvDDxfc1hEtgPCTYdYxt4CieV8kMDUORhlg21HgAIFNxh+w/xXWAc7CVQ57w7sNaInk8yAyy5EJbbV9Sc6beMiADEYVaUB3zhWDEPsNWfAnmDBlQxAPObSIVpqVgfqsGLWqW3+UIsNDS5aYLaLJTirDKXOOsejIHC7eD/4QarpCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Au8hAf0dWvfACupWz31ng2f55owR/8d3HbELYOC2n6M=;
 b=cq160vVLYpgY33aDFnVT8h+7NWRiZ7wOuGMZVFFPLSIJ6x7p/VjzgN5w/FxZ+r+oIwMBdtFyI4LO1liMAAixfeOTyLtJDkii4FYBqCBFLOLMQkO5S+HJ6pOcpHwgYxqRvPFXQsB55ISdC3fkSWJZDg0B/8tODsoD4bEdhQL6IOAvdVB5TDlR58/2iLAyYO+LjBxvbCyUsgCrlmujCp65Xkndx2cIdxw0D1JBmb67MmZ+QCEmSH5MdsSLMfBnEhgcn+zGGrbmAf0Da+ZgxCYBoPOrWaObmmbTLch+v0RzacIJ0tPvaiGuR2GLqQq4I9rUKpGjIQ5PvFUcOAC3CMGy6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Au8hAf0dWvfACupWz31ng2f55owR/8d3HbELYOC2n6M=;
 b=MhVCXaYML28xwrcWTbRBR2g0KOTGpsb0voXL6IQleCrx/3+g7hhlTeXd2GXUjveMFCVyqUeky24WL295151g1iwKhGpbG7JTYw4w5TdqxcJZ7p2nseTractktf0v30rmP5LwbkgKb4nhvIgSJJ9Nnz7zsrc5l9lPoPVZWYqMuVk=
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by AS8PR04MB8403.eurprd04.prod.outlook.com (2603:10a6:20b:3f7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10; Tue, 23 Nov
 2021 09:05:07 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::c9fe:7982:c657:b423]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::c9fe:7982:c657:b423%9]) with mapi id 15.20.4713.025; Tue, 23 Nov 2021
 09:05:07 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] tty: serial: imx: disable UCR4_OREN in .stop_rx()
Thread-Topic: [PATCH] tty: serial: imx: disable UCR4_OREN in .stop_rx()
Thread-Index: AQHX4Djp3qNgtiPJqkqh5UY7YaqyhawQvV4AgAAOhoCAAAOYAA==
Date:   Tue, 23 Nov 2021 09:05:07 +0000
Message-ID: <AS8PR04MB8404219D85CCB5B743EA378492609@AS8PR04MB8404.eurprd04.prod.outlook.com>
References: <20211123070437.20153-1-sherry.sun@nxp.com>
 <20211123075122.2cwhrdwrsyjgebnk@pengutronix.de>
 <20211123084321.gpblxmqddn3kl44y@pengutronix.de>
In-Reply-To: <20211123084321.gpblxmqddn3kl44y@pengutronix.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 479189c0-fae9-4516-0646-08d9ae6058bc
x-ms-traffictypediagnostic: AS8PR04MB8403:
x-microsoft-antispam-prvs: <AS8PR04MB8403A10C29F1751B3B6D3D8392609@AS8PR04MB8403.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1227;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LwzJnubSbvbT/pEx6BPzo3Xq862Y+ejykK2MyWRG4ZqPbMRF/X+IVRR4ohNdYNs1wdyZeFusgiG/bX516pJfpYuFX66z4YhzwtNqknf0MRzlAFggoXWRrlfX5LJLewfXMvkVSrDWsygpL2lOP/e0ZTqULrOZJarEvHAc+T4IfLcCGgH/c7DA8lEMbbi7LMcmcKhP8kcw8BfK66PFQxkqhOZlVkiyXIovees1NG+gKVihAvQ/TWX0aXKXY59MFpQrTKWQfa4xuhpbxHu1yWBCJ9zDH4DTcdrks/XsxoW6mVHMw1J0q17GeLQPf3Dts42yXj9TfVISclxLl8PqLdHMv8XeZIwloEnqzFWjDPJz3ckTxrd5u15e70QiBsvofAMsrC1UwnoxSvVnEl4TKWUkp5RGONdSFnndvc2dXF3zydCBvPBXT/xeMQohJZZvuezvA2XLvB5I+yFAf+zAi5EVO5LR+7HX0OV9+tbpbrF8Z2GH0QIwZf21SQ1jlUolXvhLkUoE2OgAuumMJxW4WDq+Fv9INrueKDCRcuywxtV+dRz3+ZtqW69N0m14WJ90vSEzFEzqWX2jm4CpdYHzld5IeDE4zwBxJLXIT4xFZ3vnE2PfaSnMPHTn/An8jQ1vpyvPmCsxS4tQE+RfHo9ZNzJFlQVjRxd+YVdSnunYex7qiusWxPSDMvIbq9vF12wymUSqZXa8/zSmG31ClodIYs1A34RUTCC4/khoACwaStCrcUoqsLpDFthZqtbdk/ex+pbGf628mZ7DHfX8l/WLsoMoXF5nzqS2wNSh5cBoZB9J5rdHtzDAktEhrlE5Io++7TfZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(26005)(38070700005)(66946007)(4326008)(6506007)(186003)(5660300002)(54906003)(316002)(6916009)(7696005)(53546011)(508600001)(52536014)(44832011)(8676002)(64756008)(38100700002)(71200400001)(8936002)(966005)(122000001)(66476007)(76116006)(66574015)(2906002)(66556008)(9686003)(55016003)(33656002)(83380400001)(86362001)(66446008)(142923001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dHZQUmpDc1V4Y1BtSjYzRWIxaHRSdDJyQmhJc1l1NzNEVUFMUjUxMXlJb3ZU?=
 =?utf-8?B?bnp2TkwwMlhwbWgvbG95bGNzSUc0N1Fnd0MvRTBaUStPdzkrcHV3eHRIU1hq?=
 =?utf-8?B?NzZKNUttclBzUUhLNnRoNmdyT3lwZ3NOV2UzMkxXRDRwcHpMc2JMU1Y1N1Yx?=
 =?utf-8?B?b3RjNnEvM1FSU3lwdUZvbEJJTmdkclozRVhiZmZjS0VBVDZnNk10VzNYNDcv?=
 =?utf-8?B?S0Q5QXZjakN4T09BcWh2TFhNZHVGZU5UbVBnRHRtWW9GMnRna25pZEZ2Ui9s?=
 =?utf-8?B?VXVzejh3eTQzNnFsb3ovc1k2WmpuM3lORWlDZC8zTXpsaEdIYm1CM2N2Mlov?=
 =?utf-8?B?MXdLZDNqN3k4Y3kxYkRtY01TaE0xVmZYS0ZaaWlLemNBUmlWYUJNNXFadUhO?=
 =?utf-8?B?YkNubm5iU2hXRE5YNDlnL3ZjNk9DRFVFbnRlcEY2Mk5tbFMwQkYra25laGdL?=
 =?utf-8?B?SXdmbGxzam5zL0puaVBIZGpRVUYrMUFjZDFqQ3BGNnVoTXEwanlHS2dGaXM1?=
 =?utf-8?B?NWNsenZRN0dxOGd6VUVWOUpOM3NjOXdZeG1Bc2NGUmRlTEl0eWMzU25NSXBO?=
 =?utf-8?B?Vm5WellueWhvMUgvY2xDYTB2UWxvSkUwMndKbC9NeHR0VVI1WEVwd1lKdjlu?=
 =?utf-8?B?WlhMS2p1MTVRU1QxdmJLVG0wdjhEenlrNDd6Q0wvQUovRjlvaGU4RExNMnhx?=
 =?utf-8?B?djZxSExEL2hZeloySnhaMnExajNoaUl5R04yNW9DTzVRM1dTN002UU9zQlVQ?=
 =?utf-8?B?aHpWZy9RNmdQSEt4SXU0L2I0RXJSMG5XVWxhNG5ES2N1d0t5OGsyVnl5Zk1Z?=
 =?utf-8?B?THJVdmUzUktTRkFYUXE3d09NYy9YVU8vYkx2MW5QQUhMME5zK01WQjI5S0pB?=
 =?utf-8?B?UkhRdlRiZDhFM25mU24xQXJ1Tm14SWR2QlVVbk40MjNsRzFmc1FFT1d3dXZY?=
 =?utf-8?B?WFVkV0pLaFJDRlQ5R3BTdGlncmpYcXNzeHVwUElKcW9UNFkxOEVHdzBBcXkr?=
 =?utf-8?B?YVMrcFBQd0lYMVljeGhzWFI2MStVZE5LYnE1OE9TZUI1TmR4RWo3QlFYVDNM?=
 =?utf-8?B?Z1dEYVVZVG53b1d4b2xhS0F3dmVnRUJGZWxEcDZKVjlXSHRQbUdLNSsxM0cy?=
 =?utf-8?B?SDhlQ0tKQ0k2K01OWmRqa0hCdlVmM0tLMlhuTzlyVFM3QW9Na1Vkc3JxRnpr?=
 =?utf-8?B?aGx0aHBIdVlCMjdUOG5UeXIzak5BR0FYdkpTaTBsTXRzS3M4T0F5MHp0MEpw?=
 =?utf-8?B?a0l5QXNod3hSSS9QVzA2a05hdW5TZ2tUL1NMNm9GazBKSDV5algxTEl5UExX?=
 =?utf-8?B?aVJkUDhEM0haeEx2eWwzUHA4azlwVXgrNDZNZXdMMURvUllzYUtRTEpHOE13?=
 =?utf-8?B?Tlo2RE1IUVdyMVBsUW9aU0FadEp1RmZubzBya3RHbG9pZTRHUUF2Q0NBMk45?=
 =?utf-8?B?czRZWnVja3doZ2ZvdEpuU2xpSThnRGJNYS8wcmJEaTZSNzF4c21rOXZxN2I0?=
 =?utf-8?B?SHh3M3hhS211THBFTEhkQkxqZTRLZDUxN0pZVkpyZHlmL3hBQ1hpcy9tV2lp?=
 =?utf-8?B?ZTJpMHZYbGQrdjRvN0hYTzJ1RGlTZld2NVo2VmVzdHg3OEsxU1h2RmFwN0ZN?=
 =?utf-8?B?T1pzeEozRjYzaU8xbFEyOWdmcXhIMWRaWUEzSnhRNS9CMTU4TVFpT3hNNmww?=
 =?utf-8?B?RFBLcmxQQ040Y010MGIwMVJGSkNQRGFoWlhiYWRISEpRSUd6SE9tWk03Umk2?=
 =?utf-8?B?R1RSbnpQUkJqV3g5U25xVVVYOURPNDBNTWdvWnB5QzhlTXR0bDFOeUUwOWRa?=
 =?utf-8?B?MHVjSFVoUnN3ZUViN3BBM0V4TGFqR2pIWDBrcDVINFYraEFGK1UzSysrWE5s?=
 =?utf-8?B?WHVPWW56bFlWNFoxU2tnQjNZVWdINnB1MkNDam54LzJRbU1ONUhXQXJUSVpH?=
 =?utf-8?B?WXhEbG9Ld1ZFOE5RNTgzNVcyTjN5Z3JhZGU1Y0tKQk52ZUlHWXJPRnMwNmNX?=
 =?utf-8?B?RytNQklBbDkrKzh6THdGNXgyTmorZ216RHhuTmNNdzNQNVJyazlPTUNDRG5m?=
 =?utf-8?B?NWc5Uytpd2FnbDAvNXI3L3hzYlhIanlWbGU0UEhsTHprZTZqRnRSSmFWbHVM?=
 =?utf-8?B?enJZb1Q1UkphSjB0bFlURWg3ZjNXQ3E0K0ZDVFVybWkxek1EVGVTZmd0V1pt?=
 =?utf-8?B?TEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 479189c0-fae9-4516-0646-08d9ae6058bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2021 09:05:07.7072
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oVqGO7/Y/Z5mt21m3ll0ZiAhQJWPKfM1RiqXKtLzmXPLBawfD4dgxhP4+VxR/1QqZhq8ytk3YkjmstyDV2ugSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8403
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

SGkgVXdlLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFV3ZSBLbGVp
bmUtS8O2bmlnIDx1LmtsZWluZS1rb2VuaWdAcGVuZ3V0cm9uaXguZGU+DQo+IFNlbnQ6IDIwMjHl
ubQxMeaciDIz5pelIDE2OjQzDQo+IFRvOiBTaGVycnkgU3VuIDxzaGVycnkuc3VuQG54cC5jb20+
DQo+IENjOiBncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZzsgamlyaXNsYWJ5QGtlcm5lbC5vcmc7
IGxpbnV4LQ0KPiBzZXJpYWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJu
ZWwub3JnOyBkbC1saW51eC1pbXggPGxpbnV4LQ0KPiBpbXhAbnhwLmNvbT4NCj4gU3ViamVjdDog
UmU6IFtQQVRDSF0gdHR5OiBzZXJpYWw6IGlteDogZGlzYWJsZSBVQ1I0X09SRU4gaW4gLnN0b3Bf
cngoKQ0KPiANCj4gSGVsbG8gYWdhaW4sDQo+IA0KPiBPbiBUdWUsIE5vdiAyMywgMjAyMSBhdCAw
ODo1MToyMkFNICswMTAwLCBVd2UgS2xlaW5lLUvDtm5pZyB3cm90ZToNCj4gPiBPbiBUdWUsIE5v
diAyMywgMjAyMSBhdCAwMzowNDozN1BNICswODAwLCBTaGVycnkgU3VuIHdyb3RlOg0KPiA+ID4g
RnJvbTogRnVnYW5nIER1YW4gPGZ1Z2FuZy5kdWFuQG54cC5jb20+DQo+ID4gPg0KPiA+ID4gRGlz
YWJsZSBVQ1I0X09SRU4gYml0IGluIC5zdG9wX3J4KCkgdG8gYXZvaWQgZW5kbGVzcyBpbnRlcnJ1
cHQNCj4gPiA+IGhhcHBlbiB3aGlsZSB0dHkgcG9ydCBpcyBjbG9zaW5nLg0KPiA+ID4NCj4gPiA+
IFNpZ25lZC1vZmYtYnk6IEZ1Z2FuZyBEdWFuIDxmdWdhbmcuZHVhbkBueHAuY29tPg0KPiA+ID4g
U2lnbmVkLW9mZi1ieTogU2hlcnJ5IFN1biA8c2hlcnJ5LnN1bkBueHAuY29tPg0KPiA+ID4gLS0t
DQo+ID4gPiAgZHJpdmVycy90dHkvc2VyaWFsL2lteC5jIHwgNSArKysrLQ0KPiA+ID4gIDEgZmls
ZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPiA+DQo+ID4gPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy90dHkvc2VyaWFsL2lteC5jIGIvZHJpdmVycy90dHkvc2VyaWFs
L2lteC5jDQo+ID4gPiBpbmRleCBmYjc1ZTNlMGQ4MjguLjllY2FmMDUxMjQ5ZCAxMDA2NDQNCj4g
PiA+IC0tLSBhL2RyaXZlcnMvdHR5L3NlcmlhbC9pbXguYw0KPiA+ID4gKysrIGIvZHJpdmVycy90
dHkvc2VyaWFsL2lteC5jDQo+ID4gPiBAQCAtNDg2LDE4ICs0ODYsMjEgQEAgc3RhdGljIHZvaWQg
aW14X3VhcnRfc3RvcF90eChzdHJ1Y3QgdWFydF9wb3J0DQo+ID4gPiAqcG9ydCkgIHN0YXRpYyB2
b2lkIGlteF91YXJ0X3N0b3Bfcngoc3RydWN0IHVhcnRfcG9ydCAqcG9ydCkgIHsNCj4gPiA+ICAJ
c3RydWN0IGlteF9wb3J0ICpzcG9ydCA9IChzdHJ1Y3QgaW14X3BvcnQgKilwb3J0Ow0KPiA+ID4g
LQl1MzIgdWNyMSwgdWNyMjsNCj4gPiA+ICsJdTMyIHVjcjEsIHVjcjIsIHVjcjQ7DQo+ID4gPg0K
PiA+ID4gIAl1Y3IxID0gaW14X3VhcnRfcmVhZGwoc3BvcnQsIFVDUjEpOw0KPiA+ID4gIAl1Y3Iy
ID0gaW14X3VhcnRfcmVhZGwoc3BvcnQsIFVDUjIpOw0KPiA+ID4gKwl1Y3I0ID0gaW14X3VhcnRf
cmVhZGwoc3BvcnQsIFVDUjQpOw0KPiA+ID4NCj4gPiA+ICAJaWYgKHNwb3J0LT5kbWFfaXNfZW5h
YmxlZCkgew0KPiA+ID4gIAkJdWNyMSAmPSB+KFVDUjFfUlhETUFFTiB8IFVDUjFfQVRETUFFTik7
DQo+ID4gPiAgCX0gZWxzZSB7DQo+ID4gPiAgCQl1Y3IxICY9IH5VQ1IxX1JSRFlFTjsNCj4gPiA+
ICAJCXVjcjIgJj0gflVDUjJfQVRFTjsNCj4gPiA+ICsJCXVjcjQgJj0gflVDUjRfT1JFTjsNCj4g
PiA+ICAJfQ0KPiA+ID4gIAlpbXhfdWFydF93cml0ZWwoc3BvcnQsIHVjcjEsIFVDUjEpOw0KPiA+
ID4gKwlpbXhfdWFydF93cml0ZWwoc3BvcnQsIHVjcjQsIFVDUjQpOw0KPiA+DQo+ID4gSSBkb24n
dCB1bmRlcnN0YW5kIHRoaXMgeWV0LCBidXQgSSBndWVzcyB0aGlzIGlzIGp1c3QgYSBtYXR0ZXIg
b2YNCj4gPiBpbXByb3ZpbmcgdGhlIGNvbW1pdCBsb2cuIEhvdyBkb2VzIHRoZSBlbmRsZXNzIGly
cSBoYXBwZW4/DQoNClRvIGJlIGZyYW5rbHksIHRoaXMgcGF0Y2ggaXMgYW4gb2xkIGxvY2FsIHBh
dGNoLCBJIGFsc28gZG9uJ3Qga25vdyB0aGUgaGlzdG9yeSBhYm91dCBpdC4NCkJ1dCBJIGNoZWNr
ZWQgdGhlIGNvZGUgbG9naWMgaXMgZmluZSwgdGhlIFVDUjRfT1JFTiBzaG91bGQgYmUgZGlzYWJs
ZWQgd2hlbiBzdG9wIHJ4Lg0KDQo+ID4NCj4gPiAuLi4gc29tZSB0aW1lIGxhdGVyIGFmdGVyIHRo
aW5raW5nIGFuZCByZWFkaW5nIHRoZSBkcml2ZXIgc291cmNlIC4uLg0KPiA+DQo+ID4gSG1tLCB3
aGVuIHRoZSBPUiBldmVudCBpcyB0cmlnZ2VyZWQgdGhlIGhhbmRsZXIgZG9lcw0KPiA+DQo+ID4g
CWlteF91YXJ0X3dyaXRlbChzcG9ydCwgVVNSMl9PUkUsIFVTUjIpOw0KPiA+DQo+ID4gYW5kIHNv
IGNsZWFycyB0aGUgZXZlbnQuIEkgd291bGQgZXhwZWN0IHRoYXQgdGhpcyBzaG91bGQgYmUgZ29v
ZA0KPiA+IGVub3VnaCB0byBwcmV2ZW50IGFuIGlycSBzdG9ybSBldmVuIGlmIHRoZSByZWNlaXZl
ciBpcyBkaXNhYmxlZC4NCj4gPiBEb2Vzbid0IGFja2luZyB3b3JrIHdpdGggdGhlIHJlY2VpdmVy
IGRpc2FibGVkPw0KPiANCj4gT25lIHRoaW5nIEkgZm9yZ290IHRvIG1lbnRpb246DQo+IA0KPiBJ
ZiBpbXhfdWFydF9zdG9wX3J4KCkgbm93IGNsZWFycyBVQ1I0X09SRU4sIGNsZWFyaW5nIGluDQo+
IGlteF91YXJ0X3NodXRkb3duKCkgc2hvdWxkIHByb2JhYmx5IGJlIGRyb3BwZWQuDQoNCllvdSBh
cmUgcmlnaHQsIHdpdGggdGhpcyBwYXRjaCwgY2xlYXIgdGhlIFVDUjRfT1JFTiBpbiBpbXhfdWFy
dF9zaHV0ZG93biBpcyBub3QgbmVjZXNzYXJ5IGFueSBtb3JlLCBJIHdpbGwgcmVtb3ZlIGl0IGFu
ZCBzZW5kIFYyLiBUaGFuayENCg0KQmVzdCByZWdhcmRzDQpTaGVycnkNCg0KPiANCj4gQmVzdCBy
ZWdhcmRzDQo+IFV3ZQ0KPiANCj4gLS0NCj4gUGVuZ3V0cm9uaXggZS5LLiAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHwgVXdlIEtsZWluZS1Lw7ZuaWcgICAgICAgICAgICB8DQo+IEluZHVzdHJp
YWwgTGludXggU29sdXRpb25zICAgICAgICAgICAgICAgICB8IGh0dHBzOi8vd3d3LnBlbmd1dHJv
bml4LmRlLyB8DQo=
