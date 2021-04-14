Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 319B0C433B4
	for <linux-serial@archiver.kernel.org>; Wed, 14 Apr 2021 16:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09DAA61153
	for <linux-serial@archiver.kernel.org>; Wed, 14 Apr 2021 16:31:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351623AbhDNQbh (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 14 Apr 2021 12:31:37 -0400
Received: from mail-dm6nam11on2118.outbound.protection.outlook.com ([40.107.223.118]:2240
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1349092AbhDNQbe (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 14 Apr 2021 12:31:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HRA7i68QON88qL8FLDWvuYoGNiuTNruIHH/NICG1Oz4Ac6rmoGKbxuMzPDoPTPbSM2c9ACkrXKkeY7Rr9FGJfPZABLCVvCPTWK88fOj4n/X0GmE3JoO7UBLoN/0dJCSFt3TvFI1tu2Vp0JF7zqzut8wnIKvXOvorBhmwezTQ+x0hQLMoEgOtayai59Vh2uxuXig475T0qJAef3AXsL0PjBio/n7d4jxYBFLKE15DTz0rmZPS/IDgEnrAbVjhzNfoPBji7vZbaoHbemXgv+gU3h/jMUmEl8J34F6R70JbZ7F0S2KPE2azWE0nZ45SVlEVv0riiHIprAV5dq8LkxV94A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OKsF2etHDHlATDSIyr2G4KDC5Ubw52XrwT26M6Ba978=;
 b=a69M+kKZB8VmjaRaLLxdnqaHGcq0g9IKH6kr1J1L5oS3RtlTdXfOj6pk6khyD/shdqgzwIPdIrtATR4EUC9JJOHIZrcvfIb7xDtYPS6j8mnMLSYMOj+a/cNJTtpTwWCzVgov9EqfViU7ZheNEu71fsVUEOz8dA/CzWFINqXKw1fAM2t7VcGr7Wegg23euf6UazH8FjGbumg7aa9V/yUoH20w8VLn06ZU8magyHVhjW4ZW13BcEWRVgVqtPleCwpEA7b/TTm2IvCZw69YyE6dzVTFJwFDng70qy7+U/xKXUIT0tXLGYciTeVMCjAteKMKQaUGy0KbHc4Es+zpAFJo7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=purdue.edu; dmarc=pass action=none header.from=purdue.edu;
 dkim=pass header.d=purdue.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=purdue0.onmicrosoft.com; s=selector2-purdue0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OKsF2etHDHlATDSIyr2G4KDC5Ubw52XrwT26M6Ba978=;
 b=TDl2dGxxMA+eGMZKQ4Q6AkqsIw32ZB0u7s+HjnA/MlOLexDT6rU3+ejf4B5UWB3tjw706omdGBRo6ga5qmdeAxznA8OeUicVOeyx+Y0nlIsCSCSuyyP0zaxb+iJkLIj6nqhxCgoO1PqgC99xS1eJ7dvIsCHL2mIE3hbOl7R6U64=
Received: from CH2PR22MB2056.namprd22.prod.outlook.com (2603:10b6:610:5d::11)
 by CH2PR22MB2005.namprd22.prod.outlook.com (2603:10b6:610:8a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Wed, 14 Apr
 2021 16:31:10 +0000
Received: from CH2PR22MB2056.namprd22.prod.outlook.com
 ([fe80::fd2f:cbcc:563b:aa4f]) by CH2PR22MB2056.namprd22.prod.outlook.com
 ([fe80::fd2f:cbcc:563b:aa4f%5]) with mapi id 15.20.4042.016; Wed, 14 Apr 2021
 16:31:10 +0000
From:   "Gong, Sishuai" <sishuai@purdue.edu>
To:     Greg KH <greg@kroah.com>
CC:     "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "a.darwish@linutronix.de" <a.darwish@linutronix.de>,
        "aik@ozlabs.ru" <aik@ozlabs.ru>,
        "johan@kernel.org" <johan@kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: Re: A data race between tty_port_open() and uart_do_autoconfig()
Thread-Topic: A data race between tty_port_open() and uart_do_autoconfig()
Thread-Index: AQHXMMOdR4ACfD9U0U+njQGPLQhK/qqziuaAgACKXoCAAAldAIAAFvoA
Date:   Wed, 14 Apr 2021 16:31:10 +0000
Message-ID: <1B146F8B-75F6-4228-9EA1-EE4D3315F0E9@purdue.edu>
References: <1D917C80-937C-4065-81DB-3B64E89C4E7B@purdue.edu>
 <YHaJl8vwvE1FsV2T@kroah.com>
 <26D4F25A-5AED-43B0-8527-54A1C1E1F35F@purdue.edu>
 <YHcFhJ1EEs9F4As9@kroah.com>
In-Reply-To: <YHcFhJ1EEs9F4As9@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kroah.com; dkim=none (message not signed)
 header.d=none;kroah.com; dmarc=none action=none header.from=purdue.edu;
x-originating-ip: [66.253.158.155]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3aef31aa-2b87-4699-01e2-08d8ff62b68f
x-ms-traffictypediagnostic: CH2PR22MB2005:
x-microsoft-antispam-prvs: <CH2PR22MB20052E6722942702D6CB6378DF4E9@CH2PR22MB2005.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aSaclRgVwzTGw4fZalVRX1b1lMXFoRQ4JMnNwnPiJ13bdgQNOwodCJYu4AR0wvGkzr/WzMCncqFQA+vgn3QNcW/H1fQY7YI+mzSo/mkgkXiESlTrt+jh1S4xdb7M7XtvG4cs6n6vUHHmzpBNKWicFOV+mN2U0bMC7ZloPdPyyVcqjGAOWEbeqXqwac1/IxETrJvMvBO7sVPaU2zu9D4HeHB8ji4oipnHcDL8m1iiUcDidcWSjfVrOQ9Sfboq6MCQMduBgWVTVdG1x0T9YOcaXeKIAW1T7lNdmIg4myx5sLKQrKsR3y7pNuqHrwIJIDgFSQzs1wafSmMB5JOPHsmTbJpHVYkN4baBEdwuNV7sbIirRbWstuy3QZ7be+isl2Q6wW2TECNzG6MX1vZnI00XJKxRmbCbpZb9ZHwHmPg80f0hhV6H5qjoyzH4hYBQI9QSVdMUAMCX67BSPfLZpP2dlislDush8u4YUTqG//3s4HDpfAhfEncljDp7LxoCsBzSuuR0sK3Nezqe0umoqCUACxy6VB+Y/yptyvLbtikfA+pfnlXQQE+G4u3mLyA+zfSJdhFCsTKKn67knac59HP4nl1Kfx5M/Ce8Cms0aUZzQ1+NmSKdd3uXkRjqjp+4XIvvYfu+ZABGgOr4ta8MOf7ujOAdSGUexq6v+m6NhXxahtCwPHPcyTyQPC84w0mPfw8rnt57KRRkj1MZoDpRklAnEycKXCcks8fM+cSxlIB+4Zs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR22MB2056.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(396003)(39860400002)(376002)(346002)(66476007)(66446008)(66946007)(8936002)(66556008)(6916009)(2616005)(64756008)(478600001)(54906003)(53546011)(36756003)(786003)(8676002)(4326008)(76116006)(316002)(26005)(186003)(83380400001)(71200400001)(38100700002)(122000001)(19625735003)(5660300002)(6486002)(6506007)(966005)(86362001)(6512007)(75432002)(2906002)(33656002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?ZnFHQjZxOXZxTExWTkJkN3o3VU1jdWNpZ0lIRVBpWU5iUm5HWmlpNkIwaW1G?=
 =?utf-8?B?R3ZxUm44a2YyRHA0a2UwM0I2eVdqVXBxVHNDRTJsQ0Z1MHBSRkJuSmFRL0pR?=
 =?utf-8?B?Y1NlZGJ6TnpTdnRnTmY5d0dDUFBMWmhIdzMrSGl3V2RKUlhpQXZsYkVWeGM5?=
 =?utf-8?B?SUowdVpNc29CbzRzeGdYbDE3ODZqVGV6UzlJcm0vQWlQUTRRYzJKUnV6YW5P?=
 =?utf-8?B?S0xCaW90eThwVENDVHU1YjZoU3lLY04vYUNVaVpVZFljUTRqRXRBZ1h5dWNN?=
 =?utf-8?B?ZUxFbExaZzlEUmhERHJxOFY0NzFKVFh1SWNDUHVUUzU3M3BmSnl3OVE0RUMw?=
 =?utf-8?B?L002ek56OUc4WHBEckh6WW1GY0gxVktyZElXOU40TmVPaG9DL3MyS09zOGlP?=
 =?utf-8?B?bWNUSXRJejRPbUkxNEpMeWRHMXQrV2ZtNmhzaTlKSWlrRmNOTVhHRkZkVTJ1?=
 =?utf-8?B?OWlBbWpnTlNkTmppMVZZcHBMVzlTOWdKSTU5OE1wSW1XK2ptaU93QWo5dmd2?=
 =?utf-8?B?eG1pUkJSM3VaU0RPWDFmSjJpZkl5aHZDUXdWRzNQZTZYS3dHMGFxQnZRcTdG?=
 =?utf-8?B?ZmJ0ZUZZT09wbFhNM29JNEVWN0xQR3VhcTJYbWt5U25tQ3JOaXBTMXIzcGpu?=
 =?utf-8?B?T0FMaDF1VHZ4TzJITWgwNURlOXNMenM4SU9MdWZoQ05tTDVKMFBlbE13a2Z2?=
 =?utf-8?B?N0tUd1AxUVFucE9mOVlDcmlxM0hLdlQxZkxEY2ROK2EvQUQ0UjZzd1NPK0Fz?=
 =?utf-8?B?WmV5ZEtTd3BrTDBYVnIvQlBza0ZUb0hvaE83NlRPOE9kRExjNDYxSmdhdjdL?=
 =?utf-8?B?eWZhL29WY09lQTNvc2dRejV5NGcwYkJXcGkzOHNSUk5pQjdCeVlNVXptUENv?=
 =?utf-8?B?RUNvbFluMUd1eVJ4M2NoalRURjQ0MTlEQTdMMEdjL2Y1enppV2tlSjBXbDV3?=
 =?utf-8?B?bFFteWhlWWFlL0xRL21HSEgxalh1aTdjQVhYYkVJY0taQkVPUEhDb2Fld0Jl?=
 =?utf-8?B?dnhLYWJoSWJZTXgvaU1QVFNKOStHTklvRFJiR0RoNlc3MUJXUEtweVNXQjlP?=
 =?utf-8?B?ekdmR0ZiK2duUHlmWDZTNERMYXBmNzhQVnIrckE4b0dFK0t1Und2ZGc2b0Vs?=
 =?utf-8?B?K1h1ZWpiRXhNdHE5QnRmcVVLYjR4ZFovcnQyRjVyRkZqdDE1Tlg1U0x2SVE2?=
 =?utf-8?B?cnpWOFFtN2hIQVpML1NPOXVubFhpVDZrZ3c0Q1lCbnREYWRUMDkrZTNUU0p0?=
 =?utf-8?B?VVFzbnJUQXNkNno4L3J1Y1lRd01rVTFnSWplSHJ1aXFiRUloRnBlaEdzcHps?=
 =?utf-8?B?U1VXQ2hoTjY0MGthU3RpUlJSVnNDZjJqNEI5Wkl4SmxaR3JBaWRzcHBzQlpu?=
 =?utf-8?B?RldNUGg5cnFhZUNaTDJqeUJ3RUlqYVNEejY3M0s5WnVweFdpOFp3VXY4L01a?=
 =?utf-8?B?aVRmTUpjK3NldHdpSHI5OUtmZDYwTXI0Y21UdHFtUXhPUFBjMnhsSWNpS2Mw?=
 =?utf-8?B?dTZpRnFzMUdGdXlacXo1Y1JYQWNjaXliZ0VtYnZkeGpadkNveVlIcDNHUHJ4?=
 =?utf-8?B?L3B0d2dpK0pWUmhHRGZXTEJZTlk3WG15cHBzOEtBaGVvc0F4U1NGZ0xmMXpw?=
 =?utf-8?B?V0dUSlduTmhKMzk4R0dKaGpxQzA3MXBDdlc0cWhVc1FNZi92YytOVUhLWWJ1?=
 =?utf-8?B?bDZYTnJ6SFY2UEt0cnBJZDVraHZTZlJqanRYNGkxb1ZXNkh3amIxck1YUDhJ?=
 =?utf-8?Q?f6assKnlDWXYKQicKxp6l+T1pbtBolLNO91Uwtk?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <4AF0847C46E1924AAE9934920C160259@namprd22.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: purdue.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR22MB2056.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aef31aa-2b87-4699-01e2-08d8ff62b68f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2021 16:31:10.6125
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4130bd39-7c53-419c-b1e5-8758d6d63f21
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D2KRcNDyJyCWEpjR+I7AcI8bDQ4t8MMFcVGoTet9WyyZHil71O5Evm89D3WKf/rCqTmXEcpOebKGq076yajaBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR22MB2005
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

T24gQXByIDE0LCAyMDIxLCBhdCAxMTowOCBBTSwgR3JlZyBLSCA8Z3JlZ0Brcm9haC5jb20+IHdy
b3RlOg0KPiBBOiBodHRwOi8vZW4ud2lraXBlZGlhLm9yZy93aWtpL1RvcF9wb3N0DQo+IFE6IFdl
cmUgZG8gSSBmaW5kIGluZm8gYWJvdXQgdGhpcyB0aGluZyBjYWxsZWQgdG9wLXBvc3Rpbmc/DQo+
IEE6IEJlY2F1c2UgaXQgbWVzc2VzIHVwIHRoZSBvcmRlciBpbiB3aGljaCBwZW9wbGUgbm9ybWFs
bHkgcmVhZCB0ZXh0Lg0KPiBROiBXaHkgaXMgdG9wLXBvc3Rpbmcgc3VjaCBhIGJhZCB0aGluZz8N
Cj4gQTogVG9wLXBvc3RpbmcuDQo+IFE6IFdoYXQgaXMgdGhlIG1vc3QgYW5ub3lpbmcgdGhpbmcg
aW4gZS1tYWlsPw0KPiANCj4gQTogTm8uDQo+IFE6IFNob3VsZCBJIGluY2x1ZGUgcXVvdGF0aW9u
cyBhZnRlciBteSByZXBseT8NCj4gDQo+IGh0dHA6Ly9kYXJpbmdmaXJlYmFsbC5uZXQvMjAwNy8w
Ny9vbl90b3ANClRoYW5rcyBmb3IgcG9pbnRpbmcgaXQgb3V0OikNCj4gDQo+IE9uIFdlZCwgQXBy
IDE0LCAyMDIxIGF0IDAyOjM1OjI0UE0gKzAwMDAsIEdvbmcsIFNpc2h1YWkgd3JvdGU6DQo+PiBG
b3Igbm93IHdlIGFyZSBub3Qgc3VyZSBhYm91dCBpZiB0aGlzIGlzIGEgaGFybWZ1bCBkYXRhIHJh
Y2Ugb3Igbm90Lg0KPiANCj4gQ2FuIHlvdSBwbGVhc2Ugd29yayB0byBkZXRlcm1pbmUgdGhhdD8N
CkkgZm91bmQgYW4gYW5jaWVudCBjb21tZW50IGxlZnQgaW4gdWFydF9zZXRfaW5mb191c2VyKCkg
c2F5aW5nIA0KbXV0ZXhfbG9jaygmcG9ydC0+bXV0ZXgpIOKAnFRoaXMgc2VtYXBob3JlIHByb3Rl
Y3RzIHBvcnQtPmNvdW504oCdLg0KVGhpcyBpcyB1bnRydWUgc2luY2UgY2hhbmdlcyBvbiBwb3J0
LT5jb3VudCBvbmx5IGdyYWIgc3Bpbl9sb2NrKCZwb3J0LT5sb2NrKS4NClNvIGl0IGxvb2tzIGxp
a2UgdGhpcyBuZWVkcyB0byBiZSBmaXhlZC4gDQo+IA0KPj4gQSBwb3RlbnRpYWwgZml4IGNvdWxk
IGJlIHVzaW5nIHRoZSBzYW1lIG11dGV4IGxvY2sgcG9ydC0+bXV0ZXggaW5zdGVhZA0KPj4gb2Yg
cG9ydC0+bG9jaywgdG8gcHJvdGVjdCBldmVyeSB3cml0ZSBvbiBwb3J0LT5jb3VudCBzbyB0aGUg
cmVhZGVyIGNhbg0KPj4gZ2V0IGEgY29uc2lzdGVudCB2aWV3LiBIb3dldmVyLCB0aGlzIHNlZW1z
IHRvIGJlIGEgYmlnIGNoYW5nZSBzbyB3ZQ0KPj4gYXJlIHdvbmRlcmluZyBpdCBpcyB3b3J0aHkg
b2YgdGhpcyBjaGFuZ2UuDQo+IA0KPiBUcnkgaXQgb3V0IGFuZCBzZWUhDQpXZSB3aWxsIHN0YXJ0
IHRvIHRoaW5rIGFib3V0IHRoZSBwYXRjaCwgYW5kIHRyeSB0byBzdWJtaXQgaXQgYWZ0ZXIgdGVz
dGluZyBzb29uLg0KPiB0aGFua3MsDQo+IA0KPiBncmVnIGstaA0KDQpUaGFua3MsDQpTaXNodWFp
