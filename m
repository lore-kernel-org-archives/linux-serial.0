Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ACEAC433B4
	for <linux-serial@archiver.kernel.org>; Wed, 14 Apr 2021 14:35:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCBD461155
	for <linux-serial@archiver.kernel.org>; Wed, 14 Apr 2021 14:35:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349161AbhDNOft (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 14 Apr 2021 10:35:49 -0400
Received: from mail-co1nam11on2129.outbound.protection.outlook.com ([40.107.220.129]:1121
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231918AbhDNOfs (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 14 Apr 2021 10:35:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NW84+FknCHJG1AvJCKGecVxBR8DnwKdTJYxr1z1tYQrJ1Yvt6p5ENbgSuCGLygC5dgGzsIcetdiLKaaDXFfcaAI0KtyynnTkZHromhvCyhoyUhqgtFfBKov4E4z4kLYzBP8wZmOYVe3gRpURppVw4e65h+ngufNdEw5KYL4OISIPRcjg8Zst84tOb4PmSuzuWniKsEy/09KTJAb5COetkursI3RRUdFVAFUbyBUiR5mCM2vXr4Oe7KQS4auVpnv0hHfEi/ew5IQOPxmo5StSl7g/0gqVngY/cf7dmJn+UTRBYumYEJd7fYtRDLQG0LjhhEPxWZpHTK/Y+viCIZRLAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RGf9Lz4vobmvg+Huul6JS+4Odphq5OibVI/r01Iy31s=;
 b=mp865cHOvy+NtKmZccHX/mDpUsBJXpeNeLzhj2+9APye0HyoRR1etoSWyVnKq1mJel9x8zpxsAIJAuSMYvrklY2ZijZSUoM4ly5cjP/rIvrsRnGz2RHTvlYZfYSv1lPvmW3Qfx9lXqPY4lEyFip8O/lTVt9E+dyxUyD2+d+PN3YXU9hP5udyx5HDqN4fS7uMGcIjxeJWnBnLMheJSq5/Yua+KRq18T0vM1jNpa120UNQq/GJupTJNNo18jRzOyyvTruxDavD8lnAPNMg6WGx15dTfpu2qCgA16B9qQ43+rFepdBwqQ7wdl3Tr+rwnHzutfgFQvTtAQk4pRi6d7ej7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=purdue.edu; dmarc=pass action=none header.from=purdue.edu;
 dkim=pass header.d=purdue.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=purdue0.onmicrosoft.com; s=selector2-purdue0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RGf9Lz4vobmvg+Huul6JS+4Odphq5OibVI/r01Iy31s=;
 b=e/sGG0N0c2jLVP2QFVl6HOR0CTW/lQpnzp6HCQqHTIRdyazVNwM6ptHFuWUeEXsatPi+V4eWlW0d1j2T80tFCX1UJ4XsU3U73CsDxJVdnRFgHzMVDQjX1FlJtJ9yZ0KytKS5UGafyuvtlAGacTXw03EboqvP1Rm9mw5QEz1fWLA=
Received: from CH2PR22MB2056.namprd22.prod.outlook.com (2603:10b6:610:5d::11)
 by CH2PR22MB1847.namprd22.prod.outlook.com (2603:10b6:610:8e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Wed, 14 Apr
 2021 14:35:24 +0000
Received: from CH2PR22MB2056.namprd22.prod.outlook.com
 ([fe80::fd2f:cbcc:563b:aa4f]) by CH2PR22MB2056.namprd22.prod.outlook.com
 ([fe80::fd2f:cbcc:563b:aa4f%5]) with mapi id 15.20.4042.016; Wed, 14 Apr 2021
 14:35:24 +0000
From:   "Gong, Sishuai" <sishuai@purdue.edu>
To:     Greg KH <greg@kroah.com>
CC:     "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "a.darwish@linutronix.de" <a.darwish@linutronix.de>,
        "aik@ozlabs.ru" <aik@ozlabs.ru>,
        "johan@kernel.org" <johan@kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: Re: A data race between tty_port_open() and uart_do_autoconfig()
Thread-Topic: A data race between tty_port_open() and uart_do_autoconfig()
Thread-Index: AQHXMMOdR4ACfD9U0U+njQGPLQhK/qqziuaAgACKXoA=
Date:   Wed, 14 Apr 2021 14:35:24 +0000
Message-ID: <26D4F25A-5AED-43B0-8527-54A1C1E1F35F@purdue.edu>
References: <1D917C80-937C-4065-81DB-3B64E89C4E7B@purdue.edu>
 <YHaJl8vwvE1FsV2T@kroah.com>
In-Reply-To: <YHaJl8vwvE1FsV2T@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kroah.com; dkim=none (message not signed)
 header.d=none;kroah.com; dmarc=none action=none header.from=purdue.edu;
x-originating-ip: [66.253.158.155]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1c7591f8-9043-41fe-da11-08d8ff528a81
x-ms-traffictypediagnostic: CH2PR22MB1847:
x-microsoft-antispam-prvs: <CH2PR22MB18479186CB3D140278A56C50DF4E9@CH2PR22MB1847.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5fwJgbIn0yj4GGTeJbzUHhYLXeS/yYS3zGwCh8g293pK1W9Thst59rrsGCYaybuDc4P0UMsqFS+if0EdwD7gQ5RGh5BOyqHmxQc7s19ogjJhkUWURxhkS0RLnNylmlmm8Cg+ri9PQ7wUuJ1jte9hMhGUiKcsPEj6Vice/24s8vHz3kVoAKXTySDG6LrAlebwIk+s1oSU0EzocC0o5lJIGD/6PzZ4VsxlxnNyVqAD+n2REAsdEj1K3CnxqKdI9nf5+C/cD7UyOkqvbdX0DLgRDHRxg/EaS8/M21LOdd9ERNrAmlHByjnOiNh8s3d+nkAoXtTcU4+SGatL5FRL+AM/ZeBIC1Yqa6a8aEBaaCBW6Js2lPsORk+4XgHXgWWJiUTZoe1DX1KVTWGp9VCu1Z/Fu6toGgszVzV2yn+ac7lAQWpLejYKU2gB4m99RWOcSeoJjtwwNvO3MwkQDknGXaOGknTubBSOYO69byCy9KPOdigGc1zqeCQg5J4HfDMgdPCf4k/w7VCUsCsyDwJQrwRFw4+VB3woWGeduJDkRnuYUlzD6uQ3ND5dMX4ys4HK+bLVSe5yo8niVk6Dt0KYeiLDN/R57pNtDHLN5Yd5ZLxIN7b97kkFcTrpGtixee81+wzaWGkkEaCQT5eFT/k88xxkGbkdE9N/pc7dCvsqodJlidE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR22MB2056.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(346002)(136003)(376002)(396003)(53546011)(86362001)(6506007)(2906002)(6486002)(33656002)(122000001)(75432002)(38100700002)(6512007)(6916009)(83380400001)(71200400001)(8676002)(8936002)(5660300002)(36756003)(4326008)(478600001)(186003)(786003)(316002)(26005)(54906003)(2616005)(66556008)(66446008)(64756008)(66946007)(76116006)(66476007)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?SHA4UUREaDFoS1JoTjBTZUVQbDMwbnp5K2xlZDNnTXQveC9IU3JDeDl0b05s?=
 =?utf-8?B?WityOTMyQjQyek8wTlFNRXlmSitGemx2VVFmSVVJNzhVZ2FNTldROWlwSWp1?=
 =?utf-8?B?N1BOOTliNUlUK014d2hDOXJKZW5NcGFxbmFaUWlVVXFOTFNwMU5HMmpzdEcw?=
 =?utf-8?B?WDdIdERRakx5VDRJeW1Xa3hDYTYvMlk5QlRyMWQzYXJiZldKNlkxUWcwNXBT?=
 =?utf-8?B?d2drczFmYUFDd2RwU3N4aTdhTFJFR3ZDdkkvTVNJVkVWT2FXa3ZvZXlJZW9P?=
 =?utf-8?B?WUtDN2g0UXduWkRKL0FTWmpudk1nWlhtclI5N2FWSDcxTm9QK0xCZ09uUkQv?=
 =?utf-8?B?ZFVuQm9MSitseFdza1Z1eEVicHF2QlF6Z0lCcExoTHR6c2tuVzFTblB0aTV4?=
 =?utf-8?B?UlQ1bVprR3dUVWE1U0lWVUZkSkV0b3lTeHNEYnVHMkMwOVdaYjRYWitJRzNl?=
 =?utf-8?B?Rm9UWUdQUTdFYldqbS80OVpkUUFPS1FQSFRQNHNoTDVuMHlUT0xYSGdBT0ZK?=
 =?utf-8?B?ajFCR0pXYW9qQ0dlZ0l1OUg4Y1hRWm11cXVqakQvTUVMVjJsaVdhelZlRTNF?=
 =?utf-8?B?ZmQwR1U3ZUxsblE1SDc3SWRGeUJpN3ZzaTFjRy9LZVRZTmRsWTlxamdBakNS?=
 =?utf-8?B?WHBNcjRkTGljTkQyRTNwSEZLeVNFdzRjSFV6M1VnRjZvanRHUm1tZThuL0tp?=
 =?utf-8?B?dHpnUHRZenJ4QmZrNjdUNXZqUXgxRUMxalU2enNxcnZnSjRDNHRqeVRKUlVv?=
 =?utf-8?B?bEc4RFk0K25HdlZ3TXVxYWJpL2xCNGZ5bkhnSCtISTMrQVo2c0tkblpGTmxJ?=
 =?utf-8?B?ZS9ZNHFzZWlYV1A1UFhqNGNTVnREQjIzbHhPUzluQkZUNnZKejZjSjZKaU8w?=
 =?utf-8?B?dzN0N3ZjUDhqR2tpQ2NjK0JYQkdJczh0S25pUC9nSXRuSXF3N1Y1RnNnS3lk?=
 =?utf-8?B?L0Fuc3JIYXlKaWtQYnlNOTE2MzNXenhTRHBzbm1teVVFVERVTWlEZXdxdkdI?=
 =?utf-8?B?RmFiMnVyMXhIZHRORG4vUm5PS3M5Z0liOVVEK1VGRlZBRVo4WnlMTzRreGh1?=
 =?utf-8?B?MG5GNzY0UGplaGFsT1VqWEVkTVN3S2N2aE03cERDelluMXFKQnR0TDVkYmNj?=
 =?utf-8?B?MGx6ME4vMWNnWk96U016ZmcyYmtkNXQ2VTloejRwTlliYlZyY0taUktBNElJ?=
 =?utf-8?B?d2xkeTdIL3FwOXVpMFUzY2FhWW05YUFkZ2h2VU9tTG5aTU9OOVVvWmx6eUFG?=
 =?utf-8?B?NHB2UVhQL0VUWitqaEFhRlF0Z0l5NU9FRkJjZ2dTbE5oRDViTDJYL2F5eFhT?=
 =?utf-8?B?em04TG9lRDZsNGV4bi9paC9jK1FZMWpiWHUzcGQvdVRCdnRTdW1WQ1NFUGFY?=
 =?utf-8?B?cGtVVUxxdTBoenJxNzlST1RyWmpUQVl5bGVUc3VaVmVlTWJkcUpjWUhCbDdy?=
 =?utf-8?B?WWkwbXliUlRsaGxFb2lHTVo3M0o5a2RxeENYV08xU09MKzNMd01qR3pESUtH?=
 =?utf-8?B?RTc5bzVSelJpUW1DZHBvSkVMdUxGM0pYdzdYeW10cXBsTzlLQVU0K2YwbVl2?=
 =?utf-8?B?SlNveUNIL0R4RUJZMm1NcTR6UnhIdEtjSElubS9VZzV3VTY1KzhxS3RBQ29I?=
 =?utf-8?B?VjA1NEhDOWU4SFZ1NjdzcTZoQXpYYW5IYTdRWVNWN1MrZ2tWdE5wek5yb05B?=
 =?utf-8?B?MTQ1UkVsRExlWlU1enpxcnNXS2JVbWZiOE0zT0Ria3lWWnc3elQwdTk5Z2VQ?=
 =?utf-8?Q?YCkfB2QyIHYDxfGUQ1x6ZdB9ujAAHg4Fu5ofs5v?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <E89734EE6C1A3E4FB56302D342748E71@namprd22.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: purdue.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR22MB2056.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c7591f8-9043-41fe-da11-08d8ff528a81
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2021 14:35:24.7777
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4130bd39-7c53-419c-b1e5-8758d6d63f21
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hwcm6xA2uKgSyZjg2GzdXIlMe98yJusXtQ4GAItlEZz63uYFR1mAAATe9w5xTXk0z8bSpxwEFN0aTEgkXUMK7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR22MB1847
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Rm9yIG5vdyB3ZSBhcmUgbm90IHN1cmUgYWJvdXQgaWYgdGhpcyBpcyBhIGhhcm1mdWwgZGF0YSBy
YWNlIG9yIG5vdC4gQSBwb3RlbnRpYWwgZml4IGNvdWxkIGJlIHVzaW5nIHRoZSBzYW1lIG11dGV4
IGxvY2sgcG9ydC0+bXV0ZXggaW5zdGVhZCBvZiBwb3J0LT5sb2NrLCB0byBwcm90ZWN0IGV2ZXJ5
IHdyaXRlIG9uIHBvcnQtPmNvdW50IHNvIHRoZSByZWFkZXIgY2FuIGdldCBhIGNvbnNpc3RlbnQg
dmlldy4gSG93ZXZlciwgdGhpcyBzZWVtcyB0byBiZSBhIGJpZyBjaGFuZ2Ugc28gd2UgYXJlIHdv
bmRlcmluZyBpdCBpcyB3b3J0aHkgb2YgdGhpcyBjaGFuZ2UuDQoNClRoYW5rcywNClNpc2h1YWkN
Cg0KPiBPbiBBcHIgMTQsIDIwMjEsIGF0IDI6MjAgQU0sIEdyZWcgS0ggPGdyZWdAa3JvYWguY29t
PiB3cm90ZToNCj4gDQo+IE9uIFdlZCwgQXByIDE0LCAyMDIxIGF0IDEyOjE3OjU0QU0gKzAwMDAs
IEdvbmcsIFNpc2h1YWkgd3JvdGU6DQo+PiBIaSwNCj4+IA0KPj4gV2UgZm91bmQgYSBkYXRhIHJh
Y2UgYmV0d2VlbiB0d28gdHR5IGZ1bmN0aW9ucyB0dHlfcG9ydF9vcGVuKCkgYW5kIHVhcnRfZG9f
YXV0b2NvbmZpZygpIGluIGxpbnV4LTUuMTItcmMzIGFuZCB3ZSBhcmUgYWJsZSB0byByZXByb2R1
Y2UgaXQgdW5kZXIgeDg2LiBJbiBnZW5lcmFsLCB3aGVuIHR0eV9wb3J0X29wZW4oKSBhbmQgdWFy
dF9kb19hdXRvY29uZmlnKCkgYXJlIHJ1bm5pbmcgaW4gcGFyYWxsZWwsIHVhcnRfZG9fYXV0b2Nv
bmZpZygpIG1heSBmZXRjaCBhbiBvdXQtb2YtZGF0ZSB2YWx1ZSBvZiBwb3J0LT5jb3VudCBhbmQg
ZW50ZXIgaW50byBhIGRpZmZlcmVudCBleGVjdXRpb24gcGF0aCwgYXMgc2hvd24gYmVsb3cuDQo+
PiANCj4+IEN1cnJlbnRseSwgd2UgaGF2ZW7igJl0IGZvdW5kIGFueSBleHBsaWNpdCBlcnJvcnMg
ZHVlIHRvIHRoaXMgZGF0YSByYWNlIGJ1dCB3ZSBub3RpY2VkIHRoZSBkZXZlbG9wZXIgaGFzIHVz
ZWQgbG9jayB0byByZWFkIHBvcnQtPmNvdW50LCBzbyB3ZSB3YW50IHRvIHBvaW50IG91dCB0aGlz
IGRhdGEgcmFjZSBpbiBjYXNlIHRoaXMgaXMgdW5leHBlY3RlZC4NCj4+IA0KPj4gLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+PiBFeGVjdXRpb24gaW50ZXJsZWF2
aW5nDQo+PiANCj4+IFRocmVhZCAxCQkJCQlUaHJlYWQgMg0KPj4gdHR5X3BvcnRfb3BlbigpCQkJ
dWFydF9kb19hdXRvY29uZmlnKCkNCj4+IA0KPj4gc3Bpbl9sb2NrX2lycSgmcG9ydC0+bG9jayk7
DQo+PiAJCQkJCQlpZiAobXV0ZXhfbG9ja19pbnRlcnJ1cHRpYmxlKCZwb3J0LT5tdXRleCkpDQo+
PiAJCQkJCQnigKYNCj4+IAkJCQkJCWlmICh0dHlfcG9ydF91c2Vycyhwb3J0KSA9PSAxKSB7DQo+
PiAJCQkJCQkJdWFydF9zaHV0ZG93bih0dHksIHN0YXRlKTsNCj4+IA0KPj4gKytwb3J0LT5jb3Vu
dDsNCj4+IHNwaW5fdW5sb2NrX2lycSgmcG9ydC0+bG9jayk7DQo+PiANCj4+IA0KPj4gDQo+IA0K
PiBDYW4geW91IHNlbmQgYSBwcm9wb3NlZCBwYXRjaCBmb3IgdGhpcyB0byBmaXggdGhlIGlzc3Vl
IGFzIHlvdSBzZW0gdG8NCj4gaGF2ZSBhIHJlcHJvZHVjZXIgZm9yIHRoaXMgdGhhdCB5b3UgY2Fu
IHRlc3QgaWYgdGhlIGNoYW5nZSByZXNvbHZlcyB0aGUNCj4gaXNzdWUgb3Igbm90Pw0KPiANCj4g
dGhhbmtzLA0KPiANCj4gZ3JlZyBrLWgNCg0K
