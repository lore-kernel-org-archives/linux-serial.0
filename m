Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E773C433B4
	for <linux-serial@archiver.kernel.org>; Mon, 26 Apr 2021 11:39:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D30161029
	for <linux-serial@archiver.kernel.org>; Mon, 26 Apr 2021 11:39:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231831AbhDZLjs (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 26 Apr 2021 07:39:48 -0400
Received: from mail-db8eur05on2082.outbound.protection.outlook.com ([40.107.20.82]:15211
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231806AbhDZLjr (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 26 Apr 2021 07:39:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lz3IozjVP1VrbTFnGU3Z8ZyFgFcdqW0YSH8FYVT47y7X1SU5iF3IbuWyhSaloPpaugTnqDv0zdsegVv3DhiVua6MLdsIBQc5EWXl3KXTwh/KpWcJh2gK/GJB0GC1alBoEgw+lz7+ZBNwgwlIa6/cTL3LAf/OaX6CvyY9k9NKK4wxht+o22k3DB2dgUCjj5TVuD8LiwygY9HO5R6pI5efLSqJaUULHPwszRdXxzXnE5fKwmzAca64dVruHVm3m7ePiRFutrRd134BDbQb4cSjzVX6jarLlJidqy/AtLYYKxKdnHj8tAh6tNNjy2NQS/iKCaa90Z/xvgUdmchg/dN5Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Qw4d1GnqZYm61pEtf3O/wwcmYKV+hlpKiAuIERvTv8=;
 b=kWy4ljIBKkzSWDjA6+PVJiGDSq2ZeDtHMnH+geURWxYe/fXQDWWj5adAfcPOarezgG85pQBCDu1Zf/HehNx1f5ZiseZhU0rtRNYz4ntcUNvlsJcGXPepIg83CPRkEB88GsffvfoD9NJKubW6d9AXVi5TpMXZf0PAB1GBKsr9tPGbdkVI/AOUUKIKlBegB3eaTZ/hzhAPSJO44ZLYP0ak7BWkVB9JLNELbYTn4fDm3cmVISaKM5L/tCQEXeZr9lBxbX4JRSAPwnozZE+RzT9QhOzEAqel88MJuFw53W4Q0HHE5BjFHA6Wa4x7Zo9h+4PhO8NBQ//T6psg2Rhd9uKhcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Qw4d1GnqZYm61pEtf3O/wwcmYKV+hlpKiAuIERvTv8=;
 b=f6rpDfDSjLGLcrVdS+BfXEGMhuH//5NzOyH9Cxuf/wJDJeWfP4dcX8ld1IyCk+69kTq9+Lhhr9W7tLrZRoMQu3k86uPEEp8LZsYFQu3WDjdZT7ySn7OnG2wOc8hHLrFOc5wR81f4845IIskBBuAnIedpYyqRD6SIynnk8z/3kOU=
Received: from AM0PR04MB4947.eurprd04.prod.outlook.com (2603:10a6:208:c8::16)
 by AM0PR04MB6339.eurprd04.prod.outlook.com (2603:10a6:208:178::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.25; Mon, 26 Apr
 2021 11:39:03 +0000
Received: from AM0PR04MB4947.eurprd04.prod.outlook.com
 ([fe80::c9b0:c412:80f0:4645]) by AM0PR04MB4947.eurprd04.prod.outlook.com
 ([fe80::c9b0:c412:80f0:4645%6]) with mapi id 15.20.4065.027; Mon, 26 Apr 2021
 11:39:03 +0000
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
Thread-Index: AQHXOnDr8/FCGWBm7kWmZDaqq+nPsqrGchAAgAA4RHA=
Date:   Mon, 26 Apr 2021 11:39:03 +0000
Message-ID: <AM0PR04MB4947DAD4EAA84FEAA5A2B28A92429@AM0PR04MB4947.eurprd04.prod.outlook.com>
References: <20210426074935.11131-1-sherry.sun@nxp.com>
 <20210426074935.11131-3-sherry.sun@nxp.com> <YIZ1NvISshNHtX/Z@kroah.com>
In-Reply-To: <YIZ1NvISshNHtX/Z@kroah.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 33b331c6-848d-466c-95f3-08d908a7e469
x-ms-traffictypediagnostic: AM0PR04MB6339:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB63393419C56575E3E33D8B5692429@AM0PR04MB6339.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XVamc5IuijzIOCPlUQxAv1XGDiIncU01ohPj+gziLRX67SKzKCXFA+OVt/jDvw/NgytKe6Om6I07mN7f49s6Gf8u7P+Gc7Q12ojpvknkgucn7UC7gpgvGWS4NQbpW3EaNjzFHl3ybL9PJetZZxOT5PJxH543fk5U05BMRKkOEQ6p1FaWnaJqtyWrTRs9+FU1uqcxLjoirbBfOzIub8H1bhtZB5K1NO8xPmzZSIa1URKwes2zEE/aZ359Fiya6Beuf58xRHEV5r1UIWNBJlfF4RRyCM72NfOV01ESwfly0VWqUqiQlZRdGrGZ2Ut6KqTHLEJELc6bsn/6Txv5Zr49kDwqkTSHNEfth4WliZF993uckAEevoWTtkM5+jcbtJUPn5seHjJqyosazPmZQapW/osxC3gjUU4HoXCMBsA7KhcgyDqURDA/DFz7KgKQuN9LrqIjb/zSKWzuQaUlKrUV7fkDwz0xIgdOsGQ9x4IOT4YlGJEZh/qmuWjKozIizh8I5GqH2P16QPxESpoFCQw/iFUIQMVTpzH2PAursDh8FhsV+8KddMeiw84H9Gv0XWO78R6oDHEvzShaSXnJmhmomWYGAsktBv8GhkP7pl+LlU4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB4947.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(366004)(396003)(136003)(39860400002)(8676002)(71200400001)(5660300002)(66476007)(2906002)(66556008)(66446008)(76116006)(86362001)(4326008)(478600001)(122000001)(38100700002)(26005)(52536014)(64756008)(66946007)(8936002)(44832011)(83380400001)(9686003)(7696005)(54906003)(53546011)(55016002)(316002)(33656002)(6916009)(6506007)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?gb2312?B?RjgveUxHSkVVOVVjREdBaTl6S1JoZDdTTUxWa0lFTVgrZEhZZ283TDBoeXg1?=
 =?gb2312?B?cERZU2lVb0dCM3BmRmpEeWhxSFJ5azdqemhhOS9ucTExVHVuWk9Bc1hCeVJG?=
 =?gb2312?B?WndoK3BOZ05ISlI2NjZvS0lPVXduaFlqQWNVa0hIWnREVDBFYTVTYnljekl4?=
 =?gb2312?B?MWNKU055TjI2TjdXOENwanV2WG4vQ3JOLy9yazlMMUQ2TU9pVFJvUDdNVWo2?=
 =?gb2312?B?ckNJRVRITkp6djNvKzdtbm9tMFZHSjlyaUpjLzdKWHlRejNZMmJsb3VzR1dN?=
 =?gb2312?B?TS9HT0Q0OVVXeU1mTFVhamR0NkxQSWk3cVFyVDNNNTNEQmFnZXRuTDg2VnI1?=
 =?gb2312?B?bWMzSXV2RTAweWNnQmF5Tyt2MERKbHFlN0VQNk9iZk5iR1AvcVQ5UXplMzcx?=
 =?gb2312?B?U0ViYUhHcnhrTXZlQnFzOHgvUm1kelVQcncxQ2NJMVJtMms4V2E0cGVYRkMr?=
 =?gb2312?B?eXVrS3R3T3FSaHVpWlQ2TStkNG1LdS9KUm5icGJFeENFYWd0cjJoSlpZSDcz?=
 =?gb2312?B?MGRWY3NRU2JOMm9KeHgzcFpsYXVtRzBZcytqU0s5ekVyQnU5U0FYSWVRZkMr?=
 =?gb2312?B?R243TkVYN3pUeTRZbkNVSGUyZEkxTWR4WUdicGpTYUhCSWt0UktoMTdBMVRz?=
 =?gb2312?B?L1hZb1M4OU0zblRTVE1qMVpkeXlsVzNCRllPNHFuNWVEUXUzMnFlQXBDT0gv?=
 =?gb2312?B?ZUFUVTl5cmlmSTJyaGtGYjF6NzB3ZUxGZnFqWFYzNWpoRzB0cjNCdkx2aXF1?=
 =?gb2312?B?ZEZOZDZ6WnMzQmdrN3Rhd2YxTW9mNDRBS1NzT2RtNGozYkV3QXNWTDlGcHgv?=
 =?gb2312?B?UkZSNDkrampTc3FRM01oNmY3eVpQVnBBVVZKVXZnY1V3VXBWTC9vTTZkcmxm?=
 =?gb2312?B?dklOamlnSHpreU82QlYvRUlYSWVRckliaUd6Qi93VDlja2hJaTh0eTVGamx3?=
 =?gb2312?B?eThGN3poRTJ4YUhzMHEyOEQ3VVlYOHlsc0dJQ2tNSENmZHdLOGtMZ3NBaVBQ?=
 =?gb2312?B?UW9JdnloTHRDQ1ZRNEJuQVRpekdMOFVqUDhpTnNEcmRLZFFxUGg1bUJKQXpP?=
 =?gb2312?B?b1h4TjV4b0V2MjNxTUo2LzBVb244UldETHpTOEdVdEZidnphMkNGVWo5eitT?=
 =?gb2312?B?V2Q2blNnNEVLVDlCTDN1VUdyK0RyN1ZjeXliTkNSWWxqaDkzamNSOEhjSmRp?=
 =?gb2312?B?TW5VTnBVdktvNFhTZ09VUDBXZXZxWnZUdnVIUEo2Y1grNzZLcGZIUUk3aXNE?=
 =?gb2312?B?c1hpWlBudzY1ZGtuRDJZRGJrQ21YRUdwRDh0cytuSER2bGJqQjhNU0xpRlJp?=
 =?gb2312?B?ZEpuVWVvVU5GQUxlZWI5eFRFSGJxQjlKUmRYY2ZiOXErR3NEYng3MUVoNllQ?=
 =?gb2312?B?bUFJeU9OblBSNW5KeXc5YVp2NXIrWXIyd3JiWW1KYVA1TC9uMmxCa1VxZ0pD?=
 =?gb2312?B?RmtpQ2NCYU1IT0I5WUlKRTBMSi9UR0VCd2t4WFpHRExuQjRRT2dYWVFKUHph?=
 =?gb2312?B?NmxGV29oaDZQZGxmQ2JDbzAwcWUvS0Z1d2s3dE9XTDBWYWZvSzBOMklXWFBM?=
 =?gb2312?B?d0dIU1Fkb21lTkNxWUprVkN6QlJsOXNnMmV0dHlVaWxicnhzc1dLci9jbHRF?=
 =?gb2312?B?V2kwOEk5WXpPcEJRd1FVQ0lmbUNOZnZKUDg3SzBBaDFJSnRkUmp4dlgwYThS?=
 =?gb2312?B?cjJtTkthMzJnUmFzZEhTQ1ZwbmZzYVNrZzkrUmF1b2RvTUtaN01PVjUxU3Ro?=
 =?gb2312?Q?XuNhWjfdV+65//hWuPWT64frw3EjiWZ6PEY1Pr0?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4947.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33b331c6-848d-466c-95f3-08d908a7e469
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2021 11:39:03.3022
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G0kD3rHoniYbqpQ5+FthptibX9Tv6MrlnpY6MdpOaLOkl1/yQUl8qtvqgBobCQF/jR6HyzGoUBhPO+d9cz0F7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6339
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

SGkgR3JlZywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBHcmVnIEtI
IDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz4NCj4gU2VudDogMjAyMcTqNNTCMjbI1SAxNjow
OQ0KPiBUbzogU2hlcnJ5IFN1biA8c2hlcnJ5LnN1bkBueHAuY29tPg0KPiBDYzogamlyaXNsYWJ5
QGtlcm5lbC5vcmc7IGxpbnV4LXNlcmlhbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBrZXJu
ZWxAdmdlci5rZXJuZWwub3JnOyBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAuY29tPg0KPiBT
dWJqZWN0OiBSZTogW1BBVENIIDIvMl0gdHR5OiBzZXJpYWw6IGZzbF9scHVhcnQ6IGZpeCB0aGUg
cG90ZW50aWFsIGJ1ZyBvZg0KPiBkZXJlZmVyZW5jZSBudWxsIHJldHVybiB2YWx1ZQ0KPiANCj4g
T24gTW9uLCBBcHIgMjYsIDIwMjEgYXQgMDM6NDk6MzVQTSArMDgwMCwgU2hlcnJ5IFN1biB3cm90
ZToNCj4gPiBUaGlzIGlzc3VlIGlzIHJlcG9ydGVkIGJ5IENvdmVyaXR5IENoZWNrLg0KPiA+IElu
IGxwdWFydF9wcm9iZSwgcmV0dXJuIHZhbHVlIG9mIGZ1bmN0aW9uIHdoaWNoIHJldHVybnMgbnVs
bCBpcw0KPiA+IGRlcmVmZXJlbmNlZCB3aXRob3V0IGNoZWNraW5nLg0KPiA+DQo+ID4gU2lnbmVk
LW9mZi1ieTogU2hlcnJ5IFN1biA8c2hlcnJ5LnN1bkBueHAuY29tPg0KPiA+IC0tLQ0KPiA+ICBk
cml2ZXJzL3R0eS9zZXJpYWwvZnNsX2xwdWFydC5jIHwgMyArKysNCj4gPiAgMSBmaWxlIGNoYW5n
ZWQsIDMgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdHR5L3Nl
cmlhbC9mc2xfbHB1YXJ0LmMNCj4gPiBiL2RyaXZlcnMvdHR5L3NlcmlhbC9mc2xfbHB1YXJ0LmMg
aW5kZXggNzc3ZDU0YjU5M2Y4Li5jOTVlNzFmZDJjYTANCj4gPiAxMDA2NDQNCj4gPiAtLS0gYS9k
cml2ZXJzL3R0eS9zZXJpYWwvZnNsX2xwdWFydC5jDQo+ID4gKysrIGIvZHJpdmVycy90dHkvc2Vy
aWFsL2ZzbF9scHVhcnQuYw0KPiA+IEBAIC0yNTg5LDYgKzI1ODksOSBAQCBzdGF0aWMgaW50IGxw
dWFydF9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlDQo+ICpwZGV2KQ0KPiA+ICAJc3RydWN0
IHJlc291cmNlICpyZXM7DQo+ID4gIAlpbnQgcmV0Ow0KPiA+DQo+ID4gKwlpZiAoIXNkYXRhKQ0K
PiA+ICsJCXJldHVybiAtRU5PREVWOw0KPiANCj4gSG93IGNhbiBzZGF0YSBiZSBOVUxMPw0KDQpJ
cyBpdCBwb3NzaWJsZSB0aGF0IGEgY2FzZSBmb3Jnb3QgdG8gc2V0IHNkYXRhPyBUaGVuIHRoZSB2
YWx1ZSB3aWxsIGJlIE5VTEwsIHN1Y2ggYXMgeyAuY29tcGF0aWJsZSA9ICJmc2wsaW14OHF4cC1s
cHVhcnQiLCAgfS4NClNvIEkgYWRkZWQgdGhlIHBhdGNoIHRvIGF2b2lkIHRoZSBrZXJuZWwgY3Jh
c2ggd2hlbiBydW4gdG8gc2RhdGEtPnJlZ19vZmYgZGlyZWN0bHkuIEJ1dCBJIGFtIG5vdCBzdXJl
IGRvZXMgaXQgbWFrZSBzZW5zZS4NCg0KVGhhbmtzIGFnYWluIGZvciB5b3VyIHRpbWUuDQoNCkJl
c3QgcmVnYXJkcw0KU2hlcnJ5DQoNCj4gDQo+IHRoYW5rcywNCj4gDQo+IGdyZWcgay1oDQo=
