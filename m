Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B39E9C433B4
	for <linux-serial@archiver.kernel.org>; Mon, 26 Apr 2021 12:09:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A03E6105A
	for <linux-serial@archiver.kernel.org>; Mon, 26 Apr 2021 12:09:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231983AbhDZMKa (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 26 Apr 2021 08:10:30 -0400
Received: from mail-eopbgr130048.outbound.protection.outlook.com ([40.107.13.48]:30914
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231550AbhDZMKa (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 26 Apr 2021 08:10:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TRr9pX7fNqs/wJdTjxl76v+uAIwW2vuUHX1t2Usrnk2nS5Ncw7V1F2xWUEe6Zn8Dm8uVE6prwB5vm+dpVT8FVFzPuH8ZS85aVoNAmXTzXwBQ/ZowxqywgFBAE7tdnKaIttMytZEeeLcPorvSse+11rKarqcuBwJJWJJIqZs694Vvk0YcWyweFEvJm8CgJnXz5U6NGJydmCP1gZJcV3vUZuwV8a9nCb2QibEeRYLTCTOkoNEaBuPxWzdQogDIh9SJSdoIRXCKQefghBCqDxpPgkujQ4AkJI9LTKF77R2ABkqxgbeKJEBSHPDpuEdT8EEPqmYgZLJGOiFEAspFPOSR2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Iac8AxTpTLHwSX9KoA+j8RgY8sVme8l6KNgkBrZQJg=;
 b=KsLT5Eh2pZ6etCZnfkQzWF9w0Uj862+703S8aXeI4iA69/YbouD2rs0E90KAlSW3TWnPZjA9uiVNTTLfuG+29/oVaWeUWiU70EzBKeqphLLrt6yiUase0XBHgPbx+h2T5YuUNcI02jV93FfL1l1HpuywMoydJia0YaCZfdhJiU+voltpITV67y3WzR1SYLmIoxZf44LnIMO2QZbBNszF3D4T8kEZbz+22fFfVoX+ejAYByqOz74bL8oMHhQhIfhtH4hTtH1mzURjw4wPgqXKZ+YV9BAE/VtRSC10lf94p1hJcDUK+SB7zT4NtTMsp1QmP+1dVLBJgvY8U7FZDeG9nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Iac8AxTpTLHwSX9KoA+j8RgY8sVme8l6KNgkBrZQJg=;
 b=sFmOJJt++VGyKZXlPuGuSRI7AD1yJwFJNI9svoAd4R4kj/upGSNqUX+AQHvuyqsYHUkCor+EI7m+0+LJFmm5SmpFpbUaPZDu2A1XQQo1iZ4r0o8X38JFCZw2FHADKd9y173ovpNqLsjlaGqh0N58J4nma+6CMmyyd3sxZwl8ovk=
Received: from AM0PR04MB4947.eurprd04.prod.outlook.com (2603:10a6:208:c8::16)
 by AM8PR04MB7441.eurprd04.prod.outlook.com (2603:10a6:20b:1c4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Mon, 26 Apr
 2021 12:09:46 +0000
Received: from AM0PR04MB4947.eurprd04.prod.outlook.com
 ([fe80::c9b0:c412:80f0:4645]) by AM0PR04MB4947.eurprd04.prod.outlook.com
 ([fe80::c9b0:c412:80f0:4645%6]) with mapi id 15.20.4065.027; Mon, 26 Apr 2021
 12:09:46 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     Fabio Estevam <festevam@gmail.com>
CC:     Greg KH <gregkh@linuxfoundation.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 2/2] tty: serial: fsl_lpuart: fix the potential bug of
 dereference null return value
Thread-Topic: [PATCH 2/2] tty: serial: fsl_lpuart: fix the potential bug of
 dereference null return value
Thread-Index: AQHXOnDr8/FCGWBm7kWmZDaqq+nPsqrGchAAgAA4RHCAAAd+AIAAATSA
Date:   Mon, 26 Apr 2021 12:09:46 +0000
Message-ID: <AM0PR04MB49472A690A93C06CE27FFC4692429@AM0PR04MB4947.eurprd04.prod.outlook.com>
References: <20210426074935.11131-1-sherry.sun@nxp.com>
 <20210426074935.11131-3-sherry.sun@nxp.com> <YIZ1NvISshNHtX/Z@kroah.com>
 <AM0PR04MB4947DAD4EAA84FEAA5A2B28A92429@AM0PR04MB4947.eurprd04.prod.outlook.com>
 <CAOMZO5Bmv2CVZeJbwLhZcH7pb7Tb9FhCrPSjhkbaJO8vYtRHLw@mail.gmail.com>
In-Reply-To: <CAOMZO5Bmv2CVZeJbwLhZcH7pb7Tb9FhCrPSjhkbaJO8vYtRHLw@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2673ded3-a753-4ced-38ba-08d908ac2eea
x-ms-traffictypediagnostic: AM8PR04MB7441:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM8PR04MB7441CFC247638191189991D692429@AM8PR04MB7441.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vDI3yj7hS+LWEd1GDmV4WXQPb+i31k1SX8dYq4Q7gdqUzulECp5G6NT1scrdjJMBTvBuqtPKazSl9BCVavDIBWkjk2Xe+T60xswyoIe0KQUjO1yZT/Al6nssRKFuHUoUtMtT1Ffqwq7EHuRYTCJSZzY+blQS7N2jn9h6Zm5hOqIs13OnHjZ7wFMMnwjFHvWnFvUqSsghfiwz2AIJm1MahVF6vsP2f+QkDE9XUDaHiXaYDMo6ozX3SMgsOPf7q8YjI8bTssX0C99izNfFFd036ImsXFRZ764/7CS9u1vWn0YmegbuI43y/MV6aqRdaJoXUw/GqqECxGdcdSc0GzKYol1c2RS7vKovUD7WGSna7s6vFQqVHJyN0apZHL1hMKYntTF+za9GZ4zmgyxI3/EKa749592qpynICrF1g5kU9bxkhCMpka2rd4R6J6p63r0wBrPGVYyZRE9ntRSh3UCgdKS9o+Fy+kwa7C+VcQrts/jNmEtnXpGeWcmKZZXxZza2S+LUHvg5sdX+kigRxl1bYWef6xqtPtG3+O0CokJzhGkIB/siBjm67R3xWoPy7nKgAbrM12Y41svUbYdpEsPB74044oBNCmwDfhSmZQcBeUU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB4947.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66476007)(66556008)(64756008)(66446008)(8676002)(8936002)(66946007)(71200400001)(76116006)(38100700002)(6916009)(6506007)(54906003)(52536014)(122000001)(4744005)(7696005)(498600001)(186003)(33656002)(2906002)(9686003)(55016002)(5660300002)(53546011)(26005)(86362001)(44832011)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?WDJMVmdyS3ZISm0rcGkvL25Veitzb2xxemV4RUFMbS94MDMyNDdOaVBZVVBo?=
 =?utf-8?B?UG1EMXlHWnlIOVRqSWxVVDRhd0N1M1BhMFFNMTZ4NFl3ZUxWdG44MVEzMktN?=
 =?utf-8?B?Q0tCWURVZVU4WnYyZUtjY1E2cmRhVU1UajhkRFZ4UldCemlzZmk0blZOZldy?=
 =?utf-8?B?RUN2Z2M5UWEwMjFEOXhkVXRNVCt6ZVduUVVwaEtwVUluZ1pNTWdSVnNOTVVY?=
 =?utf-8?B?RlFjamRuOU5lelJ5QnlSYTJVcnF2SmhqRGJ1RGdVeFZDdkRsaFpURWY4T0NP?=
 =?utf-8?B?MXNFR21CWmQ1TlV1VnFJOEFtYkd4VVNpY2pPTXR2OEJwNFp0eE5PMGIvWmdT?=
 =?utf-8?B?UDlEamVXUDc0b3g3NFFzNnd6UmlwcVRRZEp4b00xUER1NTlJZFJvTUxLWFc4?=
 =?utf-8?B?VjFTZ1dDTGhvNVdGZWxCZ1BYZmVIRlZwT1lCamVFZFA1ZWc2eG96WUJUaW1m?=
 =?utf-8?B?WHFSWG1ONlUva20xVnEyL2lSQW1ib2xXQk9GelRyWmtYVzNCczVoRGJvdkdJ?=
 =?utf-8?B?OFdFcFpVMnpPTDVTRnpzWXVSd0xpcFRuaGxRYXNpQ2hnU2QvL2svMmlONVRy?=
 =?utf-8?B?a21BcDU1bitwN1ZxSmZGZTVkdUQxbm1aNmFUTE9RL0V3Vk1kMXlndUNsSVpE?=
 =?utf-8?B?VU1pa0N0RmtsTHpuLzJqUEhjZ1hGOHBLc0FLdmpPTXhzbERpUWVYTDJubXR4?=
 =?utf-8?B?RFN2MlpnRWpSUXhQbGJkR2dOY1hmMVM4Z3doK2ZBdWw5OG5DTm94d3loZGJX?=
 =?utf-8?B?N0VITUFpUkFRRlVqditwOVc4QTlYSU9aRjJMSVhtMmlQVzZJNFF4N0w1d3JE?=
 =?utf-8?B?WmllYkVnUm5HL0FpM25ST0Npb3k5N2pXTzVoNm1VbjNlZlFtbFY3dVJ2dDMv?=
 =?utf-8?B?Qm5TM2s1UFBZNWxaVEdLZElrMFdwYWE2VlBQTlBzRG0wVjRvQW5ma3doR0lJ?=
 =?utf-8?B?eW5QZXE0T0FESDJId1g1TnB0dUlCVWpnaGIrZEZnUVRneWR2cWVvV2VCemFs?=
 =?utf-8?B?cWVPdTQ2THlGVStYKzBySGZrZm5vMkdDMkFYd012NG5jWUxLaG9SdGcrUWhL?=
 =?utf-8?B?OERZYUhXeWU1WnVxOUw4NFd6cWVId2hXSVpzejdtaXhZamlJSllaZWxZVUd1?=
 =?utf-8?B?b3BuRlBFeUxhWER2Y1d6UTdCenpJejQ4RmxGQzdBUUoxdHBicS9yd2x5S2Vj?=
 =?utf-8?B?TTU1VkRCRnZOeU14USs3Y2h3SStjZ3hyL2U0VkJQSGpxQTNtM0xJOE4veHp1?=
 =?utf-8?B?d3ppYjhUb1BmUXZIa3k0Rjk1ek1EZWxicFJuSWFsOS9yUExmaFFlSGs3QzJk?=
 =?utf-8?B?dE91MCtBK1N3R09uMnhwZ0htbWx5UFRGMjhIUG1Ea0E2by9nV3dmR2JkNFh1?=
 =?utf-8?B?dzJoeDU4UFAvdkJnZXVyRzh6VDVJWUkva3Azbk1ZUHVNVHBEcWs3VHlUSjlz?=
 =?utf-8?B?a09kSmY4Z0tkNlhYS0djMVpURkpvNTBldmxUamVGTlQ1TktmVU9xMm01RkJL?=
 =?utf-8?B?N0xqMzltRGluV0I0S3dHa3llMFNqejlkZC8yR2x2QlZ6c0orKzZJMldDSjJ6?=
 =?utf-8?B?dWpIcTVUNXF4azRoZ3VBRzJ3QWpJZXBFblBDc2hyaUwwTUEvdzdvT2xTaFlQ?=
 =?utf-8?B?dDRxekFuZG9zY2V5a2NOa3U5ZlJhaXRvcHRZOHowWWNqTjVrcUtDdVdGS3ha?=
 =?utf-8?B?TjNKZ016d2FCbFZMdUdwM0VuWXIwSkhRZVp0djAzUDdnVE5ITHFiNFRySHRu?=
 =?utf-8?Q?mq+mZgG2nnVgPp+/Rs0mhQzCnqnkZ/QaM1JwR8R?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4947.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2673ded3-a753-4ced-38ba-08d908ac2eea
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2021 12:09:46.3485
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jh8k/FC424NMl/MUafOeqzRG2FtKGnodZwUWFmD1Pt2P7ahPXbzvezMmdia+gAqO1IblFQX+4rbCNgHwby/IVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7441
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

SGkgRmFiaW8sDQoNCj4gSGkgU2hlcnJ5LA0KPiANCj4gT24gTW9uLCBBcHIgMjYsIDIwMjEgYXQg
ODozOSBBTSBTaGVycnkgU3VuIDxzaGVycnkuc3VuQG54cC5jb20+IHdyb3RlOg0KPiANCj4gPiA+
ID4gKyAgIGlmICghc2RhdGEpDQo+ID4gPiA+ICsgICAgICAgICAgIHJldHVybiAtRU5PREVWOw0K
PiA+ID4NCj4gPiA+IEhvdyBjYW4gc2RhdGEgYmUgTlVMTD8NCj4gPg0KPiA+IElzIGl0IHBvc3Np
YmxlIHRoYXQgYSBjYXNlIGZvcmdvdCB0byBzZXQgc2RhdGE/IFRoZW4gdGhlIHZhbHVlIHdpbGwg
YmUgTlVMTCwNCj4gc3VjaCBhcyB7IC5jb21wYXRpYmxlID0gImZzbCxpbXg4cXhwLWxwdWFydCIs
ICB9Lg0KPiA+IFNvIEkgYWRkZWQgdGhlIHBhdGNoIHRvIGF2b2lkIHRoZSBrZXJuZWwgY3Jhc2gg
d2hlbiBydW4gdG8gc2RhdGEtPnJlZ19vZmYNCj4gZGlyZWN0bHkuIEJ1dCBJIGFtIG5vdCBzdXJl
IGRvZXMgaXQgbWFrZSBzZW5zZS4NCj4gDQo+IHNkYXRhIGNvbWVzIGRpcmVjdGx5IGZyb20gb2Zf
ZGV2aWNlX2dldF9tYXRjaF9kYXRhKCkuDQo+IA0KPiBUaGlzIGRyaXZlciBvbmx5IHJ1bnMgb24g
RFQgcGxhdGZvcm1zIGFuZCB0aGUgb25seSB3YXkgb2YgYmVpbmcgcHJvYmVkIGlzDQo+IHdoZW4g
YSBjb21wYXRpYmxlIHN0cmluZyBtYXRjaGVzLCBzbyBpdCBpcyBub3QgcG9zc2libGUgdGhhdCBz
ZGF0YSBjYW4gYmUNCj4gTlVMTC4NCg0KVGhhbmtzIGZvciB5b3VyIHJlcGx5Lg0KSSBndWVzcyB5
b3UgbWVhbiB0aGUgb2ZfbWF0Y2hfdGFibGUgd2lsbCBub3QgYmUgTlVMTCBzaW5jZSBpdCBjb250
YWlucyBjb21wYXRpYmxlLCByaWdodD8NCkJ1dCBmb3IgdGhlIGxwdWFydCBkYXRhIC0tIHN0cnVj
dCBscHVhcnRfc29jX2RhdGEsIHdvbuKAmXQgaXQgbWVldCB0aGUgTlVMTCBjYXNlPyBzdWNoIGFz
IHsgLmNvbXBhdGlibGUgPSAiZnNsLGlteDhxeHAtbHB1YXJ0IiwgIH0uDQpIZXJlIG9mX2Rldmlj
ZV9pZCB3b27igJl0IGJlIE5VTEwsIGJ1dCBscHVhcnRfc29jX2RhdGEgSXMgTlVMTC4NCg0KQmVz
dCByZWdhcmRzDQpTaGVycnkNCg==
