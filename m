Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53267C48BDF
	for <linux-serial@archiver.kernel.org>; Tue, 15 Jun 2021 17:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CD7461413
	for <linux-serial@archiver.kernel.org>; Tue, 15 Jun 2021 17:23:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbhFORZ7 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 15 Jun 2021 13:25:59 -0400
Received: from mail-eopbgr1300042.outbound.protection.outlook.com ([40.107.130.42]:24384
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229539AbhFORZ7 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 15 Jun 2021 13:25:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F/DCBFfLngsKeEef15RiPDDjeRgWk0ZbYDLEyo9cigtHIQTRFKOrLRbcH1ldm0tDX08Q40W39twhB4QO1pj43uYAjVK10zB3NUZP1uVtGIYK+KD3DZilc/4FDpVMWmNcDQ979qhoksG/4wYXyYi2bMV7YNk2Lb5YF/vD7TULxyO66CTP1G52PHZrvap1AzqYfitD3zCGFGB80xnX6A1YFQKxOq/GWU9fSKKG4Oafqoy+rhcWZQ8pj9mJaG/xCPf/v1mXeU623g5HvvH6T05u3ILrVPtBYOKDZ4c4r6NZWHwLJSKIYOP+iB4/+61VYtjchn+7MyLN/vH+UwBwLnEGwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZJsDyeFG+raUpnWjNxD5ZYKZTL31wGUqtnPuA95sMBs=;
 b=PojAqfCvEv4c5NNImAvPmrpB9GppqwfU7OegpSTSgNmUzP06oTcvNubbItRgxyv2qjMipMQdJ8FX6ijn5TbfFhk0Bdo56SKyfcOBHgGbrdzKDvtlmut6Lj2neF2f23p43a6uplnYovXJTkaFKPP6rnFLIl65rBzqxXM9RFQZloukIspDzGcuGOMk2xdadU6q5y0/37hxEEesoBD9HAgZQVCUsTnUP2TnQCn4mYQ498HBGWFnj/yeHcCzYwd8Vs3j/tcneJzdTbvlL0oLKHnOKb6X101FQP8ZrNSFvEeGJqwT43dMgt0nWx6JOddb3WkKt5EpqDH/04QoR4imyE+tcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cortina-access.com; dmarc=pass action=none
 header.from=cortina-access.com; dkim=pass header.d=cortina-access.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CortinaAccess.onmicrosoft.com; s=selector2-CortinaAccess-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZJsDyeFG+raUpnWjNxD5ZYKZTL31wGUqtnPuA95sMBs=;
 b=b1lvxjylk8GrkDCAD5fSD+BCg/UI5ZmUMHDpBvwvv+gqVKkcTTXjz6pa20+UH9uLWptMCR9uxzi/w9wCSNVOeOdMe5iXHbpLSya9sBQVToyLJrH/GMrHi0PS9ajee/Ne/cPc8sUi9GP8DwRBI0C5IDEFFgwL+qqFRSB4lRN9TYs=
Received: from PS2PR01MB2504.apcprd01.prod.exchangelabs.com
 (2603:1096:300:3e::11) by PSAPR01MB4038.apcprd01.prod.exchangelabs.com
 (2603:1096:301:43::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Tue, 15 Jun
 2021 17:23:51 +0000
Received: from PS2PR01MB2504.apcprd01.prod.exchangelabs.com
 ([fe80::e9b5:6b16:ec29:6101]) by PS2PR01MB2504.apcprd01.prod.exchangelabs.com
 ([fe80::e9b5:6b16:ec29:6101%2]) with mapi id 15.20.4195.032; Tue, 15 Jun 2021
 17:23:51 +0000
From:   Alex Nemirovsky <Alex.Nemirovsky@cortina-access.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Jason Li <jason.li@cortina-access.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: Re: [PATCH v4 1/3] tty: serial: Add UART driver for Cortina-Access
 platform
Thread-Topic: [PATCH v4 1/3] tty: serial: Add UART driver for Cortina-Access
 platform
Thread-Index: AQHXYgehbGvZC2LIq0KTrC9ujhAduqsVT/aAgAACZAA=
Date:   Tue, 15 Jun 2021 17:23:51 +0000
Message-ID: <2870E27C-ABFF-4744-8929-54BC15D78454@cortina-access.com>
References: <20210615165750.31261-1-alex.nemirovsky@cortina-access.com>
 <YMjgJYdjmCoCER7l@kroah.com>
In-Reply-To: <YMjgJYdjmCoCER7l@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=cortina-access.com;
x-originating-ip: [70.58.207.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d9b1dbda-f8aa-4024-c15e-08d93022580a
x-ms-traffictypediagnostic: PSAPR01MB4038:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PSAPR01MB4038FB3C4A28CB099A26A676CB309@PSAPR01MB4038.apcprd01.prod.exchangelabs.com>
x-ld-processed: 0694623c-6669-497c-89c3-3a32a9934313,ExtAddr
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7ngKXSMZtAIeKgMg6r7mi5yCBgJWNo0GdRXZtqXAixA3I0PlUZrOROkajNAZW3metaf3siWDsP+bloSLyjRtOh7p79MHPtIZpRPOkaFv9uOUe+P9mT9SUkGNx5EZ3Iqf/2FLUSJcGVw/q0Bw+/OCksm1TsfeMDWphqrbhy2Gq4YhDfD71+RZGtpdZv78jHx08dAngmKD1wmvpKThYthUDXggO8TZU2zgTFeATuwzXquyhvdLQwjGsl2Sh0GpOW7PTvdBYePGxz7RN//zyipfjkAWchcOb3h8wB33u2IgWhsImT+jpt63aL6Zu580hX8XraIQI7rtDGoZ6o9m9qLj/EOegap/VdR6nkUc9YRcOqELGPoQaAIg2yUEvoDHVX6UTQx+q+98C95iEXO7QIsRr91wKQ3R8Rv9Hjo2yUapyD4ejJOvdchrKqgZKhnF7uh1uCK2sy2oyGX1kdCrp2oyipReJOsG17GcZhmnOHkfWrY7VK01S3OKMwBsY6MQfLHSuAgSWz04VM+Z2+uEFdqjXeVVfCbfPFacLD+OqV/nploUPp7Gn7mib96MwDdJvPOobofqiZJN/2hmxe6OT95qxq0Mi+JGwywgHtbonTFC9DY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PS2PR01MB2504.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(39830400003)(346002)(366004)(136003)(36756003)(8936002)(2906002)(4326008)(33656002)(2616005)(6512007)(6916009)(83380400001)(122000001)(4744005)(38100700002)(86362001)(54906003)(66946007)(91956017)(478600001)(6506007)(66556008)(64756008)(8676002)(66476007)(53546011)(186003)(76116006)(26005)(71200400001)(6486002)(316002)(5660300002)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K1crSG8yYU5OeVNkVXVFYnBRM0gxMjFjR0FMaUNYUi8vdEJQSW5nazNta1pY?=
 =?utf-8?B?SWFKNEdhTVJLU3Z5eUlCcGx6b09FSWgrZmNLNGJST1FhZGJHQ1ZLNjVJYTJu?=
 =?utf-8?B?OWNpbWo0RHptR1hvOSttbHJZdmFITDY2SXZpMDJ6K2lmb2I4amQ0bFNRY21V?=
 =?utf-8?B?NHE4S3E1dUFXdHNpRGFvbGNtcmgzWUxENTYrZ0UyTk9zSjViOTgxMC8rMHlG?=
 =?utf-8?B?ZkhDWFR5aEJlV2JqTHhMaTdmNDNVTFBMaC85Z3NkYysrVEZNNWNNSE9Mcjdq?=
 =?utf-8?B?UElpbDhXYWJKY2RhNEFMS0tueG9pdHBpa0VneWY1NmpPYVFxb1RhNnp3TXV2?=
 =?utf-8?B?T1dXQjYvOHkyMDMyaXhWTC9mMGh6RVZsNW04RVRULzJuSHcwekx3N1NVVUpt?=
 =?utf-8?B?RjRNZFRCc04xazVWdENNMEhXdDJpbHR1NWxuVVVhLzNWMmJ3YVkrNUVYcUow?=
 =?utf-8?B?VCt6by9QU3RybStMNjNIOUpjZmFvOXVPKzZxZ3gvN0F3eG5SbnNac0prWEt3?=
 =?utf-8?B?TEJhOFB0M3lwQ0hIK25JTmN3WGVxdEVzUFYzQmFSOXJrSnpPMXJkbUZoTU5t?=
 =?utf-8?B?ZXVPdnlTSVFCV1d5aVN6VW4reTJpRVVhVDUyM0xROFMxdVdXbGxoUTUydFJH?=
 =?utf-8?B?T3o2eHo5VW1RUDlvNzIwNlAwWDRvTmVrV0lqKzl1N1JzZHd4VmNYMWtwT2Jy?=
 =?utf-8?B?T1VzV1M4NjM1cXRRNEVTSCs4QWYySCtjdzR5VGt4eEJ5UUJtaGdjam9RdkU4?=
 =?utf-8?B?ekdlZ05Nc1BiNzlTdkxDeUt4YkNBUGJoQkd3dkgwWmpjelZPaWpWdDVyeXA5?=
 =?utf-8?B?eUJnZkRQcFllUVFwTHlKaGhCVGpMZmhzNWRxMnFrV2dYdzdCdEJkTG1DVHRY?=
 =?utf-8?B?ZlQ3ajZML3k0V3BZN2dWT2xsUXFJdGt2S2RGcERVSkJZRFQyUEwrVlp6Vmk5?=
 =?utf-8?B?WTlpTmpFaHdZbEx2SFAvR3BuUWtyZUxlSWM2ZXdSQVNKcmhtTU5RbCtmWWV4?=
 =?utf-8?B?MHhEcW9vWHRsdzI4T1ZVN0xmQkZEc2lQUjlDQUd1cUpHenJBa1Qva0Y0YUtG?=
 =?utf-8?B?RFBIUUhERDg3ZTFzejFINGlieEYrNzk0alAxaUJQZlhxU3JYU3FRV3k1Skdz?=
 =?utf-8?B?Z1R3cnZZTHU0RWJWYXFadkhzVEl0bk9vY3Z4NlpveS9EL0tndFRpekh3Vnlk?=
 =?utf-8?B?S2ZzMHJzb0hkUzcwYlFJQ0ZJWUZ4N1Z2Sy9rT0IzT0JSRUpyMSttY1FyM2F2?=
 =?utf-8?B?Y1FlV0VVVUtFSE5xdlFWT3F0OGZNaWRDcUVraEVjcTh5RmtVUEVhRHpETUgy?=
 =?utf-8?B?cVRDQ0Fsa2RIZEFBS1U5bHRHZmVXNUZZbVlQWUVKSUdzQllkU2k5RVkrSndK?=
 =?utf-8?B?VktxT1c5NHJmVkpPTUU2RDFiUFU3bTI3NXozOXBRcEM0WjUrM2xzNmRSYXll?=
 =?utf-8?B?cVg1V0g5RnVTY0xZaGU0RjZIVFVnYndPaEZNOGlWdTFMQXQ3bU9KRTQvbjlx?=
 =?utf-8?B?UU5BOEluZXJSRVNtSnNTY3ZpK0d5ajd5aWo4QWJjUE9hRGQ5UTUyeCtxZmhV?=
 =?utf-8?B?ZkpGVmNad1U5ZXBXdHdJYm5rZy9jdDFRMWlvcDJUWTF3U09UK29sU3JkUzBD?=
 =?utf-8?B?ZlVaWHZOVDdKSEpRVjc3WWY2VXdGVGFjYy9STTdNMG84cXltOEYwTlNySDRt?=
 =?utf-8?B?QTB2alZYNHpqVjgrYjZWMkFtajl2NkdKZWxnWC9IYjZTMmNtTGpNdm5iMWQz?=
 =?utf-8?Q?Vu1vXGrv013lT+9kzluD1xZ0JpJpTYPHbSHLLFk?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <909116F827FFD14BA13916635D06A8EA@apcprd01.prod.exchangelabs.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: CORTINA-ACCESS.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PS2PR01MB2504.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9b1dbda-f8aa-4024-c15e-08d93022580a
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2021 17:23:51.1968
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0694623c-6669-497c-89c3-3a32a9934313
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Caaew1sqEZtgnWcFdvWQnG+TSVHjiRn8v3yllcrLg39cAXeWLbm9uRBP80YD4KSIwU2GQgc4/VTN0HpZ2AmNXD8NuEOm8vmk72ek+Ddaoo/Ju3UPpIFiec5FtUpiUkKn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR01MB4038
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

DQoNCj4gT24gSnVuIDE1LCAyMDIxLCBhdCAxMDoxNSBBTSwgR3JlZyBLcm9haC1IYXJ0bWFuIDxn
cmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz4gd3JvdGU6DQo+IA0KPiBPbiBUdWUsIEp1biAxNSwg
MjAyMSBhdCAwOTo1Nzo0OEFNIC0wNzAwLCBBbGV4IE5lbWlyb3Zza3kgd3JvdGU6DQo+PiBGcm9t
OiBKYXNvbiBMaSA8amFzb24ubGlAY29ydGluYS1hY2Nlc3MuY29tPg0KPj4gDQo+PiBUaGlzIGRy
aXZlciBzdXBwb3J0cyBDb3J0aW5hIEFjY2VzcyBVQVJUIElQIGludGVncmF0ZWQNCj4+IGluIG1v
c3QgYWxsIENBWFhYWCBsaW5lIG9mIFNvQ3MuIEVhcmx5Y29tIGlzIGFsc28gc3VwcG9ydGVkDQo+
PiANCj4+IFNpZ25lZC1vZmYtYnk6IEphc29uIExpIDxqYXNvbi5saUBjb3J0aW5hLWFjY2Vzcy5j
b20+DQo+PiAtLS0NCj4gDQo+IEkgb25seSByZWNlaXZlZCAyIHBhdGNoZXMsIGhlcmUgMS8zIGFu
ZCAyLzMuICBXaGF0IGhhcHBlbmVkIHRvIDMvMz8NCj4gDQo+IEFuZCBwbGVhc2UgdXNlICdnaXQg
c2VuZC1lbWFpbCcgdG8gcHJvcGVybHkgdGhyZWFkIHlvdXIgcGF0Y2hlcyBzbyBvdXINCj4gdG9v
bHMgY2FuIGNvcnJlY3RseSBwaWNrIHVwIHRoZSB3aG9sZSBzZXJpZXMgd2hlbiB3YW50aW5nIHRv
IGRvIHRoaW5ncw0KPiB3aXRoIHRoZW0uDQoNCnl1cC4uSSB1c2VkIGdpdCBzZW5kLWVtYWlsLiAg
IEFwcGFyZW50bHkgdGhlIHRvb2wgZGlkbuKAmXQgZmluZCB5b3Ugb24gdGhlIA0KbGlzdCBmb3Ig
RFQgYW5kIEFSTSBiYXNlZCBjaGFuZ2VzLiAgIEnigJlsbCBzZW5kIHlvdSBhIGNvcHkgb2YgMy8z
Lg0KPiANCj4gQ2FuIHlvdSBmaXggdGhhdCB1cCBhbmQgcmVzZW5kPw0KPiANCj4gdGhhbmtzLA0K
PiANCj4gZ3JlZyBrLWgNCg0K
