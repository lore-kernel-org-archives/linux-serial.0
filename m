Return-Path: <SRS0=kmSd=7A=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D1DBC433E0
	for <linux-serial@archiver.kernel.org>; Mon, 18 May 2020 03:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1101420715
	for <linux-serial@archiver.kernel.org>; Mon, 18 May 2020 03:44:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="nrAgJoCw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbgERDoE (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 17 May 2020 23:44:04 -0400
Received: from mail-vi1eur05on2059.outbound.protection.outlook.com ([40.107.21.59]:6178
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726675AbgERDoE (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sun, 17 May 2020 23:44:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N3TEE+FJFIiVca2ATVR57ec6jZMSYAqaPpNr6vgqCCv0iuVPsoiRTurPT07fyDeT9uGId879E3RIIKeApeBP8mQfcPQQjSPp6kTepuTmQlxlOjgDBn1C5LpPC6RHhfV4v0jZIuvj8GlgwuP0imOBYLwKr4RZ66sj6wNWETB/7YI89BJv83vCLjfq6hpWmb2xWr2ZNPBG/+DyGkJG6VuYbYkOK15Ww1HLAxLSIQ/250UfozADdMOA0Q9svd7sYl8a4hdVHAfToBSBRQ13/pK9k7dKdWhQxrVzdj5yny7Tv/fWv/WPKxKtto21+EkMb69pOzcMgfday1sdLuBDiOoEiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gEE4eHmFyFUp1kvUMts8+RsGIS1JN5e4wypj4yYbW+A=;
 b=kHv/0ICT+74EaNBBRzoRkNeEWWo41ZtQWO2AaqZvGA1QL1fWqLOfI/rFrGBVRm+YYgmuJuEnRRSmT156DeLZGHDdmPB8q3BUo9lMNOE7caRLu3jBoYF9S2cdFZISCxZaOId4P02q8k/9skiTgoj3R7sczysvsFIrdWy4H+Dx4RoI+MbKSAK0abPlHg+rlbDJNzX8DeSOgQc2ShREI7uRYBqgRyZO0w/3etpo1hjVziLK2Du8Cbwj71RQuU4KRyKLGiEf5VYNFnDmkGxRqHSpfxx0YQA0xdI6wfpiZW8xx1IM/rTJHWTXMHaG4Om8MpdCbkfb0Y54exAFBNLcTEQwkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gEE4eHmFyFUp1kvUMts8+RsGIS1JN5e4wypj4yYbW+A=;
 b=nrAgJoCwzbuX+94Be2MzEy4tzr2oegvRoJu/4UwdYssC+eQZHKeeR67sdOAZ/Q+zO0gmzf4qqv0IH6k49TKjIz+42HrfAfovLE87jONA82XrUT9sYKV5FzMCKkTTdFK/KLHaPlNQgTbQS/nEm32eHU6uPr3uWYCWG5J2mQeXRtk=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (20.177.32.142) by
 AM6PR04MB4471.eurprd04.prod.outlook.com (20.177.39.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.33; Mon, 18 May 2020 03:43:59 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d%7]) with mapi id 15.20.3000.033; Mon, 18 May 2020
 03:43:59 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jslaby@suse.com" <jslaby@suse.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] tty: serial: fsl_lpuart: Use __maybe_unused instead of
 #if CONFIG_PM_SLEEP
Thread-Topic: [PATCH] tty: serial: fsl_lpuart: Use __maybe_unused instead of
 #if CONFIG_PM_SLEEP
Thread-Index: AQHWKrnMSsSsHQoeNEmLOuyC1qVP1qitN4jg
Date:   Mon, 18 May 2020 03:43:59 +0000
Message-ID: <AM6PR04MB496638316A3B2F8383F59E1A80B80@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <1589547481-25932-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1589547481-25932-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e8c336f9-7998-4588-b07c-08d7faddb34a
x-ms-traffictypediagnostic: AM6PR04MB4471:|AM6PR04MB4471:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB4471C8ADC4AD16C27DDA266E80B80@AM6PR04MB4471.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-forefront-prvs: 04073E895A
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zoO7k2uNu855rtyApDzDAy31t9RUHXI19dfArc70uhZjl1XcX7bttgWkd/011onDf5DtZFpbjWQgk47dwmF+Q1+pVdXa725MvLADKl8IRDxw54Ibe6j8bUbEnXYpuzxt/RoPySOvmkcSqB/Rmejte7eXi1I+QdsFh6zwdwaxFY43TDQnI5RTiT7dvX9shWWb98WpG1L8VKtwvivFFXYsLGbnsTTCGRHxxkHdmzkZdJiOnxnX82UbmDx1l/9V6DAX8sTDh3Xoj3AatXw7yxBbEPjTi/FYNnRGcTzyvzaWIQlhblN7fFmqnfQxTKZkkXAryXyWwD74sRYJnF34WxsNyGAp2uxRVhev+4I7/kRytO+9UgCkffHBgImJM3d5MEO+Qpx6T8LsY/6294ZJgAiD5NyKoPQBUrrOtb4GyQRaV9NCGonIJB+f8bGEsOIsx3oe
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(136003)(39860400002)(396003)(366004)(346002)(66946007)(71200400001)(66476007)(66556008)(7696005)(478600001)(66446008)(316002)(2906002)(8936002)(52536014)(5660300002)(6506007)(86362001)(55016002)(110136005)(186003)(9686003)(8676002)(76116006)(64756008)(4326008)(26005)(44832011)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: YuJNAzOo8e7PNCD6Lgb7cPlQyFKKe9YMNzefyAZYeMLAKRIqEANPSclchFNVE7l8wLr1n0tDciKVGSJS9d0AQHa5omz2kC0VyzC1L5MxQ7LhQHKin1jbnr5BbGA0zRNjpd/AxJGPqr7nVQvcmi4lmxT6WLCZkbPfbt7+gf9lKqjyNH7vzo/5NOxWQzZTZjjIbFbgLPPW46Iu1M5sPBzHHQ1LwUWTGQGgCJfgY2wM6Dk16oomJPrkAsJIe8DrD/y81bZl36EHUknyMkuP/7+F+/GDYTVFnqAwWMyugYk7v0Z0WkWoEfZeYs3EYp8h+nfrBGI6F8OjZJo4/E68oi+9nQBfPiKzuLMP1pzT5i9JBl9YDLC40o/rJoR8vsM1Vj02rRbpXVRHnya8TE16kMSapD6yimYMaIU8ir08QQRir4/4DdhntqdkjZAYeg37Arb9JtiqU14J2FXvBXTwG2zw4FUP6kR2OdetG940lQSqM48=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8c336f9-7998-4588-b07c-08d7faddb34a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2020 03:43:59.7908
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uH+kWpBWVOiWmhYmDdCk6BD5+iL2Gs8RUtBbtE7u3ZwhHsi6v6nKYHcKHnleJ4c587gLAx6V6l4w56MRB4BiSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4471
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

PiBGcm9tOiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCj4gU2VudDogRnJpZGF5
LCBNYXkgMTUsIDIwMjAgODo1OCBQTQ0KPiANCj4gVXNlIF9fbWF5YmVfdW51c2VkIGZvciBwb3dl
ciBtYW5hZ2VtZW50IHJlbGF0ZWQgZnVuY3Rpb25zIHRvIHNpbXBsaWZ5IHRoZQ0KPiBjb2RlLg0K
PiANCj4gU2lnbmVkLW9mZi1ieTogQW5zb24gSHVhbmcgPEFuc29uLkh1YW5nQG54cC5jb20+DQoN
ClJldmlld2VkLWJ5OiBEb25nIEFpc2hlbmcgPGFpc2hlbmcuZG9uZ0BueHAuY29tPg0KDQpSZWdh
cmRzDQpBaXNoZW5nDQoNCj4gLS0tDQo+ICBkcml2ZXJzL3R0eS9zZXJpYWwvZnNsX2xwdWFydC5j
IHwgNiArKy0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDQgZGVsZXRp
b25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy90dHkvc2VyaWFsL2ZzbF9scHVhcnQu
YyBiL2RyaXZlcnMvdHR5L3NlcmlhbC9mc2xfbHB1YXJ0LmMgaW5kZXgNCj4gNmE5OTA5ZS4uY2Nh
NDg1ZCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy90dHkvc2VyaWFsL2ZzbF9scHVhcnQuYw0KPiAr
KysgYi9kcml2ZXJzL3R0eS9zZXJpYWwvZnNsX2xwdWFydC5jDQo+IEBAIC0yNjYyLDggKzI2NjIs
NyBAQCBzdGF0aWMgaW50IGxwdWFydF9yZW1vdmUoc3RydWN0IHBsYXRmb3JtX2RldmljZQ0KPiAq
cGRldikNCj4gIAlyZXR1cm4gMDsNCj4gIH0NCj4gDQo+IC0jaWZkZWYgQ09ORklHX1BNX1NMRUVQ
DQo+IC1zdGF0aWMgaW50IGxwdWFydF9zdXNwZW5kKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gK3N0
YXRpYyBpbnQgX19tYXliZV91bnVzZWQgbHB1YXJ0X3N1c3BlbmQoc3RydWN0IGRldmljZSAqZGV2
KQ0KPiAgew0KPiAgCXN0cnVjdCBscHVhcnRfcG9ydCAqc3BvcnQgPSBkZXZfZ2V0X2RydmRhdGEo
ZGV2KTsNCj4gIAl1bnNpZ25lZCBsb25nIHRlbXA7DQo+IEBAIC0yNzIxLDcgKzI3MjAsNyBAQCBz
dGF0aWMgaW50IGxwdWFydF9zdXNwZW5kKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gIAlyZXR1cm4g
MDsNCj4gIH0NCj4gDQo+IC1zdGF0aWMgaW50IGxwdWFydF9yZXN1bWUoc3RydWN0IGRldmljZSAq
ZGV2KQ0KPiArc3RhdGljIGludCBfX21heWJlX3VudXNlZCBscHVhcnRfcmVzdW1lKHN0cnVjdCBk
ZXZpY2UgKmRldikNCj4gIHsNCj4gIAlzdHJ1Y3QgbHB1YXJ0X3BvcnQgKnNwb3J0ID0gZGV2X2dl
dF9kcnZkYXRhKGRldik7DQo+ICAJYm9vbCBpcnFfd2FrZSA9IGlycWRfaXNfd2FrZXVwX3NldChp
cnFfZ2V0X2lycV9kYXRhKHNwb3J0LT5wb3J0LmlycSkpOw0KPiBAQCAtMjc1Miw3ICsyNzUxLDYg
QEAgc3RhdGljIGludCBscHVhcnRfcmVzdW1lKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gDQo+ICAJ
cmV0dXJuIDA7DQo+ICB9DQo+IC0jZW5kaWYNCj4gDQo+ICBzdGF0aWMgU0lNUExFX0RFVl9QTV9P
UFMobHB1YXJ0X3BtX29wcywgbHB1YXJ0X3N1c3BlbmQsIGxwdWFydF9yZXN1bWUpOw0KPiANCj4g
LS0NCj4gMi43LjQNCg0K
