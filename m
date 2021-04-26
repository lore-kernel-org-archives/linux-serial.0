Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F269FC433B4
	for <linux-serial@archiver.kernel.org>; Mon, 26 Apr 2021 11:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B55E761159
	for <linux-serial@archiver.kernel.org>; Mon, 26 Apr 2021 11:30:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231806AbhDZLba (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 26 Apr 2021 07:31:30 -0400
Received: from mail-db8eur05on2089.outbound.protection.outlook.com ([40.107.20.89]:32832
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229554AbhDZLba (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 26 Apr 2021 07:31:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L9yh1Y8kmsIK6D0hfbq2V8q0gX8Nqc50xba5gksnDwjSlQhtOpd9/GlnuNaLLkn1LXwOJ5yMov+Kfim0YLiuO9/VoopGlxzzNFVfIOK4MdQ/yDRsRM/akCM6+3i50tMwWDdZep0CoPJQk7849Zph67u8yEaYZi8TQHbEcwoVaEammlElcjjI4mzA4iKEl2LjpA/2jqvwd/HRWfZvhRIzR7+E6pIEO0lp1gWhUqwJiNYTgtsUl5DteRKT12arV+2j49ZHMhLzjVIgrSS0AtQc94gt7npLF1APKzlnfeqRdv0LmPXsVrL2j8PjRsl8n8KGjGJTZOGhGMxKbjNfL2yyBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CIK31Dw5PCQz/YlHH5A5xuiSSMmInu3EcHWvgpPcg8I=;
 b=g6PjQPsCfGdx5pwRso/br/izscZ/kAeLCZzh0wr/12sQB4s25vtbNztNALHZkqZdXRnhPhv1/JhyNL22zKm7gB/DSjVj9KH3T8+eJr2J/jNWffbjO5RHD01cy2xMa47klpxT33sRaeY4QcoN4BP6Yx7VnSFn+Uvny2Qc/IlxNYrZbxb6FOjMuWxZTjTtr5mc5LU867Hyfw+i5c2J1uxSKWT6V3hxufsy1GgXm6BJcuTPrjVQBtAwwscotN3cDKlgemJHPxbHEvHrFKA3k0hjQMS1WDQXwB+uqiaq2LRnU3xS1/4Wt7ibZFqfcUT2S3gy3sKVJ9ERAsdvElTU5SqbGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CIK31Dw5PCQz/YlHH5A5xuiSSMmInu3EcHWvgpPcg8I=;
 b=YoiSR29oDi5yvW7MuyxdrccMHp/DI2qt9HJtcknP6TT/5FIb3QZ1gmIxwyhVf5pVXSEoJkgyXz9tTQIHgm4kCKDhOsvbD8xEKsTkau3GaglwvcM1w3AZTEkFMpUJbH3oYt4ccmB+SJ+e1ebYPR7cRlBmVa1wmnHt8TyzkX0QuWI=
Received: from AM0PR04MB4947.eurprd04.prod.outlook.com (2603:10a6:208:c8::16)
 by AM0PR04MB3970.eurprd04.prod.outlook.com (2603:10a6:208:5b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.25; Mon, 26 Apr
 2021 11:30:47 +0000
Received: from AM0PR04MB4947.eurprd04.prod.outlook.com
 ([fe80::c9b0:c412:80f0:4645]) by AM0PR04MB4947.eurprd04.prod.outlook.com
 ([fe80::c9b0:c412:80f0:4645%6]) with mapi id 15.20.4065.027; Mon, 26 Apr 2021
 11:30:47 +0000
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
Thread-Index: AQHXOnDozEAqr+Jd7U+V+2HHvk8drarGcc0AgAAwVTA=
Date:   Mon, 26 Apr 2021 11:30:47 +0000
Message-ID: <AM0PR04MB4947A9253CE547BEBE95BE8092429@AM0PR04MB4947.eurprd04.prod.outlook.com>
References: <20210426074935.11131-1-sherry.sun@nxp.com>
 <20210426074935.11131-2-sherry.sun@nxp.com> <YIZ0/vRLASlUph6x@kroah.com>
In-Reply-To: <YIZ0/vRLASlUph6x@kroah.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c6c6287a-9860-42e8-7451-08d908a6bc9f
x-ms-traffictypediagnostic: AM0PR04MB3970:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB3970D49D07E27A539B7B808E92429@AM0PR04MB3970.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EE4un+VgxvIcci/Q4ZYCcpD0jvm9uyUPY3maK3FasVbs8csmJZKExpiYz6lPyBt6+nC9itIzBJPAo8uEBBG26sBniwqxfgwGStGU2iW1v520T1Aiuhib2cFefljxBzR7L6Lue2j3Q1aMDznZNUFy95w7u4TZKghIR+IAeScbJUptsU++JLM6PV8Dcnk33St0ESu55mB+ROIBNgmNGCDffI8e7pclfCtSOZu3WR+KkjtBodhGi6jPA9cjKlVAfC+FPK0C0DpjSvpdTHN/GrejUJruQvEQalIphNlJPNVee2lwc46mzrLdIaum8ynMjPproQCJ6n6LMVvic/ovHuPYjN1sCewLYhbGGuHnD7SF00BiTCtW+v35oKkwRBXE/WhaFlbThu1KAbO4OS8fptgbemqojNrMTN3VAkx49Fhiasw5A9lpBR/TtEzWXYPQGZ6IatS5TvSFKoCtrct9dbh+3MbQTH5AIwSJoGa3RrKqjxxkfgjAmXfUueyGA6B9sEhLgRt1KX7e5sAzLfvFOL9VXWNLUsJhYE+DIwLk3k/s4rTus8cLR4J15/yL4f0JhJ7okdkJ3Yp7VL/WTRlNQBO0jKjjR+5t2uWNVMgCnMBeVzc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB4947.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(39860400002)(396003)(136003)(366004)(66556008)(86362001)(66446008)(64756008)(66476007)(316002)(71200400001)(33656002)(4326008)(26005)(8936002)(55016002)(52536014)(38100700002)(44832011)(122000001)(66946007)(478600001)(5660300002)(6506007)(2906002)(54906003)(83380400001)(76116006)(7696005)(6916009)(53546011)(186003)(8676002)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?gb2312?B?cnZDQVdEdGtNMGQ5dGpoei9hdFlRZTR3dFVmNGt0R3prU0thQVJnU1JhRVBH?=
 =?gb2312?B?SXpoYk0xV2hJemxaQ3R0YTlCSTNsVXJ4Z2ErRFFDNUJQem9yNktVeVFGcDR0?=
 =?gb2312?B?cEpZVTlLT3F6b0h5enZsM1M0eG84aHo5bVpranUrbDVGUU5LWEtkUVJGaXA0?=
 =?gb2312?B?cThoQjBHcUJaRUZSYjVXQmNIMjM0bCtweFpUVGdMcFIwTTRvLzlLTFVueDdn?=
 =?gb2312?B?VmNrdFNoNVF4RjM0aEpaZ094dEZBNUEyOTY0SEdhdE85YUxMVjQ0YkVwYk9u?=
 =?gb2312?B?ZERiRlVHUkQ4THoyNXF5eHNEMy81a2wvaUF1V0lIL2dOM3c0blNPNEh0czAr?=
 =?gb2312?B?aThXTnZjLzY3NTFvTlBUVTNCNFpyREdURDFIQ2pNMGVJZTVURWVBU0lkZ1R4?=
 =?gb2312?B?OTl0S3g0VWFhOTZkZFpjNnhjMks0Y0hGRFJkR29Pa0ZXNlY0bUY3eHdzcUFo?=
 =?gb2312?B?U3VrSFgwVURSUFNvRmxJcDgyYVB6bU5wV2tjZXM5MGcvYWcyRFZVSGZxZEJQ?=
 =?gb2312?B?RytUR09CMTlWbXZNV3hFQTVTakVMQlMweERTdXFCRzVPRzVYaVJaNzRjTC9G?=
 =?gb2312?B?QkJEOWZWRzBJN1NoVEhaYWtRT0pRQTV4Z1lHNXg1N1ExQ0tTMWpSR2M1cTg1?=
 =?gb2312?B?QzJFbkRBYmVvSjBPTjg5NjJkaUtad1ErT3ZOTnk5MmN5WU5qQXRqOWVuU3Rn?=
 =?gb2312?B?aFRUNyt5SzRzbXZ4NytGK0JFSjZ2T0dlQjlRSDlsMnQzRHlVbm5vYm1BNHN1?=
 =?gb2312?B?Ujh6SmFGaUZrWkVNVFhESzRHS2ZjNVJ2ckxFUHkvZWJDb1RadnZ1QVIzcUpO?=
 =?gb2312?B?VFliMERtdXN6SzNueGkzZ0dWY2x5N082RzlJTzE5Qmhoa2FTVVVJSmJySHE4?=
 =?gb2312?B?WWUyQytTVStYVHJrOVphajBDMVdXL3VRQ2l0czA2U29xcmpkYlRUNE9EZ3hr?=
 =?gb2312?B?VEFDdDlIQ2FJTUE5R2VFNmRZbnBPeHJab2VUUXYyTjE1bnpvQjJURmh5NFRt?=
 =?gb2312?B?UWJLTUE4aFQ0Q1ZKeU9oaVh1UGxoek9IaU4xNkd5RmZjQ25OcytaK0pXSFgx?=
 =?gb2312?B?UjkzaC9GRzdRTjhwWjMwSGxoTU9zWkM2K3N4NzEvTGVoM0FFa082UCsvUlNv?=
 =?gb2312?B?QStOZDVvamwzcU9HUTFHbFVaUXozcmM2amFReEd2RG92T0tzb2M3bldsWkd2?=
 =?gb2312?B?RVdkYW5GQmVXbitlY3V3UnlxenUvRCtMeEJMbm85MkdLd1hFNVIrWk9xMnRG?=
 =?gb2312?B?TUxzZ1R6Tm40aWM0RS9YanJmdWZ4UlZkemxCZ3hvNDZtNm1aQWZ0dE9PaVZD?=
 =?gb2312?B?WTFVb3NEcmdoSDJjRjlRYjBwdVcrbEVmSXNSSk9UM0dRYktkQXBqLzI2MzEy?=
 =?gb2312?B?YUM2WFZNR2JpanA3Z1JsYnpWT0ZabU9hZFNYUUVjbXRiNFJsUGhkb2tnOUxF?=
 =?gb2312?B?Z1lyS1lpaTNKMWRrZm55eCtsSWxWbURoZGE2Um50NmozZGt6c0pCTUtSRElS?=
 =?gb2312?B?UWVzTStvcGF3L1ppdjJlRXBIRHM3Rmw5TmprOGVWNWNIZUlnNmlVSXRJUndY?=
 =?gb2312?B?d0JUNkRVS0dZU3dSaE1NR2FDb3cvUzU2enRubDU0bzRlMTRzZ2F3SGlnaVVz?=
 =?gb2312?B?QzEzMmdTVGFqVFBtY2pjWHF5R3AvY2RvVGtrOWszZENmS1NZNllpTUh3cDZT?=
 =?gb2312?B?d3NBaDhlZ0RjMFJidVFIamFYSm42TnBHVnJXV3FrdlpENTFvdmNEZ2EvNU5r?=
 =?gb2312?Q?J19KYsRuvpGyeFT0EUJubEOtLa2oa2e8XWOdruE?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4947.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6c6287a-9860-42e8-7451-08d908a6bc9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2021 11:30:47.1166
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IbWsfWy4xaey6O+nBQrLLS+iBNxYIFLhzFy586WPkQOdCcuyyM/wntQ18sBDpXO4r1K6MNYNx+anpnTdomZXzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB3970
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

SGkgR3JlZywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBHcmVnIEtI
IDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz4NCj4gU2VudDogMjAyMcTqNNTCMjbI1SAxNjow
OQ0KPiBUbzogU2hlcnJ5IFN1biA8c2hlcnJ5LnN1bkBueHAuY29tPg0KPiBDYzogamlyaXNsYWJ5
QGtlcm5lbC5vcmc7IGxpbnV4LXNlcmlhbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBrZXJu
ZWxAdmdlci5rZXJuZWwub3JnOyBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAuY29tPg0KPiBT
dWJqZWN0OiBSZTogW1BBVENIIDEvMl0gdHR5OiBzZXJpYWw6IGZzbF9scHVhcnQ6IGZpeCB0aGUg
cG90ZW50aWFsIGJ1ZyBvZiBkaXZpc2lvbg0KPiBvciBtb2R1bG8gYnkgemVybw0KPiANCj4gT24g
TW9uLCBBcHIgMjYsIDIwMjEgYXQgMDM6NDk6MzRQTSArMDgwMCwgU2hlcnJ5IFN1biB3cm90ZToN
Cj4gPiBUaGlzIGlzc3VlIGlzIHJlcG9ydGVkIGJ5IENvdmVyaXR5IENoZWNrLg0KPiA+IEluIGxw
dWFydDMyX2NvbnNvbGVfZ2V0X29wdGlvbnMsIGRpdmlzaW9uIG9yIG1vZHVsbyBieSB6ZXJvIG1h
eQ0KPiA+IHJlc3VsdHMgaW4gdW5kZWZpbmVkIGJlaGF2aW9yLg0KPiA+DQo+ID4gU2lnbmVkLW9m
Zi1ieTogU2hlcnJ5IFN1biA8c2hlcnJ5LnN1bkBueHAuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2
ZXJzL3R0eS9zZXJpYWwvZnNsX2xwdWFydC5jIHwgMyArKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQs
IDMgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdHR5L3Nlcmlh
bC9mc2xfbHB1YXJ0LmMNCj4gPiBiL2RyaXZlcnMvdHR5L3NlcmlhbC9mc2xfbHB1YXJ0LmMgaW5k
ZXggNzk0MDM1MDQxNzQ0Li43NzdkNTRiNTkzZjgNCj4gPiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2
ZXJzL3R0eS9zZXJpYWwvZnNsX2xwdWFydC5jDQo+ID4gKysrIGIvZHJpdmVycy90dHkvc2VyaWFs
L2ZzbF9scHVhcnQuYw0KPiA+IEBAIC0yNDE0LDYgKzI0MTQsOSBAQCBscHVhcnQzMl9jb25zb2xl
X2dldF9vcHRpb25zKHN0cnVjdCBscHVhcnRfcG9ydA0KPiA+ICpzcG9ydCwgaW50ICpiYXVkLA0K
PiA+DQo+ID4gIAliZCA9IGxwdWFydDMyX3JlYWQoJnNwb3J0LT5wb3J0LCBVQVJUQkFVRCk7DQo+
ID4gIAliZCAmPSBVQVJUQkFVRF9TQlJfTUFTSzsNCj4gPiArCWlmICghYmQpDQo+ID4gKwkJcmV0
dXJuOw0KPiANCj4gSG93IGNhbiB0aGlzIGV2ZXIgaGFwcGVuPw0KPiANCj4gTm90IHRvIHNheSB0
aGlzIGlzIGEgYmFkIGNoZWNrLCBidXQgaXQgZmVlbHMgbGlrZSB0aGlzIGNhbid0IHJlYWxseSBo
YXBwZW4gaW4gcmVhbA0KPiBsaWZlLCB3aGF0IGNvZGUgcGF0Y2ggY291bGQgY3JlYXRlIHRoaXMg
cmVzdWx0Pw0KPiANCj4gQW5kIGhhdmUgeW91IHRlc3RlZCB0aGlzIG9uIHJlYWwgaGFyZHdhcmU/
DQo+IA0KDQpUaGFua3MgZm9yIHRoZSByZXZpZXdpbmcsIHllcywgSSBoYXZlIHRlc3RlZCB0aGUg
cGF0Y2hzZXQgb24gdGhlIHJlYWwgaGFyZHdhcmUuDQoNClNlZW1zIHRoZSBjb3Zlcml0eSBjaGVj
ayBpcyBzdGF0aWMgc2Nhbiwgc28gY2Fubm90IGp1ZGdlIGlmIFVBUlRCQVVEIFJlZ2lzdGVyIHdp
bGwgYmUgemVyby4NCkkganVzdCBmb3VuZCBiZWxvdyBzdGF0ZW1lbnQgaW4gdGhlIHVhcnQgcmVm
ZXJlbmNlIG1hbnVhbDogIldoZW4gU0JSIGlzIDEgLSA4MTkxLCB0aGUgYmF1ZCByYXRlIGVxdWFs
cyAiYmF1ZCBjbG9jayAvICgoT1NSKzEpIKHBIFNCUikiLiINClNpbmNlIEkgYW0gbm90IGZhbWls
aWFyIHdpdGggdWFydCwgZG8geW91IG1lYW4gdGhhdCB0aGUgdmFsdWUgb2YgVUFSVEJBVUQgUmVn
aXN0ZXIgd2lsbCBuZXZlciBiZSB6ZXJvLCBzbyB0aGlzIGNhc2Ugd2lsbCBub3QgaGFwcGVuIGlu
IHJlYWwgd29yZD8NCklmIHllcywgSSB3aWxsIGRyb3AgdGhpcyBwYXRjaC4NCg0KQmVzdCByZWdh
cmRzDQpTaGVycnkNCg0KDQo+IHRoYW5rcywNCj4gDQo+IGdyZWcgay1oDQo=
