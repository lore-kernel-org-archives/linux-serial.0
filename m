Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF67EC2B9F4
	for <linux-serial@archiver.kernel.org>; Tue, 22 Jun 2021 14:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8330761361
	for <linux-serial@archiver.kernel.org>; Tue, 22 Jun 2021 14:20:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbhFVOW2 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 22 Jun 2021 10:22:28 -0400
Received: from mail-eopbgr1310042.outbound.protection.outlook.com ([40.107.131.42]:49848
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230160AbhFVOW1 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 22 Jun 2021 10:22:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n6lLr3FqosAu8xCBJ4rTD44qesP+1omOIUfxCyn7fXX4tahQP9FIWT4ThLrxxoYqPkk9i1WfzNm/Yb46Awr5YqK7SkcDo+im4t3p9rF3lSnBHCtiYUOazpmFMwQgOpeyP+I3C4pyorByTHS9OhsUgZFiAl4Q4AM9K0YpyiAlSi6IkHPRkbAIOTdT968agC+fvdPg7cxlYwQoE4YyLZ8+/c7R4ETLX0NO4E0+9i+Qc1y9IeLIlJIaiQknuVa5UiOh2MUkdP89N2KbO5KIXGIHdemcKQqCIus4YjRfVi2kagJZFRyDN78wJY2mOzkQdnoOa7n2Q2KUik8/pzQD9/278g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HcjL+D3BrPFwKEv8305wB3Fn2jCPNdlOHYd5JrtZc2c=;
 b=A/OThlBqqN074uNnYWd6lc9Bw36Y/3zgwmO/n4SCpQ8INI0bFPlyk4TO/ZFncdBrar7P4mZcRZ1FZ5Tg/jIO4ESbo2M0GCCSgSzSsq4ldpRExW9epnGpKu+uW4Sfzk7O4Z4rhAEW+oe+Qpyw8PGYcbL+9EIFQoUjmZfaQySQadrjJUSaO1v2LGXDUX2pPUWad0afbTK6+VnOElnxSieZt6z3D+qpGzIi1fKT/yKMotFnPO/1yUnrXcseSH53TWg+50UY8R5b+lTTLrkY2MOMlKLQ0yLOBk/nwKzXmMDAyrwd9DlsAqTmKWJdFF65NFQEMGqCiM9FU5QPTquUY0c3ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cortina-access.com; dmarc=pass action=none
 header.from=cortina-access.com; dkim=pass header.d=cortina-access.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CortinaAccess.onmicrosoft.com; s=selector2-CortinaAccess-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HcjL+D3BrPFwKEv8305wB3Fn2jCPNdlOHYd5JrtZc2c=;
 b=d7Io0Jrl41jS6tFhHw2bHKbpOUsPTASpKl5RO8ScIhUOakQdrL0nV/dl9K4dKy24ifDKEcycVujDjgbeB3S/QEybzcR3ju8g7wHH9VXI8ZIKi516OvE2BAxzC9XMOxsF2ZqqzOzgPo8Fng6JpZbYnpWZFifYEuDulDDFDyfDv8c=
Received: from PS2PR01MB2504.apcprd01.prod.exchangelabs.com
 (2603:1096:300:3e::11) by PSBPR01MB3704.apcprd01.prod.exchangelabs.com
 (2603:1096:301:10::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Tue, 22 Jun
 2021 14:20:08 +0000
Received: from PS2PR01MB2504.apcprd01.prod.exchangelabs.com
 ([fe80::e9b5:6b16:ec29:6101]) by PS2PR01MB2504.apcprd01.prod.exchangelabs.com
 ([fe80::e9b5:6b16:ec29:6101%2]) with mapi id 15.20.4242.023; Tue, 22 Jun 2021
 14:20:08 +0000
From:   Alex Nemirovsky <Alex.Nemirovsky@cortina-access.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Li <jason.li@cortina-access.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v4 2/3] dt-bindings: serial: Convert Cortina-Access UART
 to json-schema
Thread-Topic: [PATCH v4 2/3] dt-bindings: serial: Convert Cortina-Access UART
 to json-schema
Thread-Index: AQHXRQOEXSJdPocm00OQib3aojINxasVL/wAgAAc6oCAAApRAIAAByaAgAASOYCAAAYzAIAAA/UAgAqukgCAADAOPA==
Date:   Tue, 22 Jun 2021 14:20:06 +0000
Message-ID: <0C4E131B-98EA-4E7E-8CA8-341A6804F03E@cortina-access.com>
References: <20210509184519.15816-1-alex.nemirovsky@cortina-access.com>
 <20210509184519.15816-2-alex.nemirovsky@cortina-access.com>
 <YMiUpK/+PjsoCU1W@kroah.com>
 <CFD14D63-4537-4A91-861C-71B74E2CFAE6@cortina-access.com>
 <YMi1jOL6y+eUK3Df@kroah.com>
 <B71C5D02-EDBE-4AAD-AF1B-2FD467BE075A@cortina-access.com>
 <CAL_JsqKDf9W-1KHUoFFCoLareLKf0CAVMU6CXR22xW3hWM_8yg@mail.gmail.com>
 <9937DB34-7757-4A54-BCC6-AF5514FD7F1D@cortina-access.com>
 <CAL_JsqLHdi29Du1F=e1N471tnsziWpH7TPO_caDF3SrjvHS-iw@mail.gmail.com>,<CAMuHMdXA9-ajoAza2JAW5879ECieMm1dbBbKHgJhDa7=3kWu3w@mail.gmail.com>
In-Reply-To: <CAMuHMdXA9-ajoAza2JAW5879ECieMm1dbBbKHgJhDa7=3kWu3w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none
 header.from=cortina-access.com;
x-originating-ip: [70.58.207.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fe845172-b000-42e7-26a8-08d93588d6ba
x-ms-traffictypediagnostic: PSBPR01MB3704:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PSBPR01MB370494FAA4F63DE01316417DCB099@PSBPR01MB3704.apcprd01.prod.exchangelabs.com>
x-ld-processed: 0694623c-6669-497c-89c3-3a32a9934313,ExtAddr
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nuJcWWvA/bfecEZaPqeZ7B4jc+/MpIenkdOdGuADWwNOf5Xdz+akxA9rB5784u3Xd1Hdmv0MwwIH7Ll1WgxIbiGzoCSooZDp+bqR3ly2S3VUCZavAgN2DleO5Q9+EC45wXKnJy/fo5XjRoPo+zRqLBH3sBcEWubaMXrFHfPQa4ey0LxaaSLnHG1KYl45dd8Kwo/32bcAdWou0ihXTnj8uou7pbnDGMwjmJRHQUFqlotqwAc7QwlkzP+dGpKUd/aNJIwRLxo34wHBd7xoE3jrNPXjN+BUgoNq8Y4LZzBQJvWTDccgopsqAZw9F29ONn5Yj22ruyT74swAZn09kDtJHnSfPzAI0i3oglUd0ZVWE+WBCB6ZG+hXWpaKW7BJLnFOad34N5tK+DRAp2hpCvezJ2xlq6DUGCLc35Q0hp60YxkMwxO8gqfEbTnQ1L/ioLPWL5yqj1eyFQVIJOb6W6BVFKq2N3FKqK0KgKojSsnXc+j+ZJRYkv2ul0TRISpLbN2pOxWOEuWOAkVIun59uqyOZ9wL/x0vVE9grqRh6oNKP7oGXzeI0YDnUX/gs/3qnrW+jdJOJ0pKZBpIovJCA2RRoncIugUoJbZ7yhHWiZSWLW75UFVg/zq0GdwP5H0XQ88hY9EZHMJHw7pbbO2pxg26JDUfPUT8v9tpfysVEAzIg9QEN9pr5LIGpkC887hJ4fIjm+4pReEw2y6K6IYL3xElZA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PS2PR01MB2504.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(39840400004)(376002)(136003)(346002)(366004)(396003)(2616005)(186003)(66476007)(66556008)(64756008)(66446008)(76116006)(66946007)(966005)(26005)(6916009)(91956017)(36756003)(6506007)(53546011)(2906002)(86362001)(6486002)(71200400001)(6512007)(8676002)(8936002)(33656002)(4326008)(478600001)(83380400001)(5660300002)(38100700002)(122000001)(316002)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Rms4aVVCTzJyNkI4UXpkN0RiWGkyNDIzeVVuYzk5dG1pWVBINkRNMldhaWlV?=
 =?utf-8?B?ck92c1pnRnUvK0kyeHhpM09WZGpDZHRrQnBYNUMyWnhxdnpOMVFpL1JpeVNW?=
 =?utf-8?B?TmowVDBzclZyU2UxQWxFaVZ1WGM0Mm5RTUZDbVNiV2NhOWl5Z240NmZ5MHdC?=
 =?utf-8?B?czVZODBBd0tpbmt5RzN3eERxNzM4NElWMVVCNXkydEU3SjlIYlhjZkxvcEls?=
 =?utf-8?B?bitXRk9JZll6enB6MURoblRqQVk0MFNVN2drYVJ2ay9YaVQrWFVaL3g1Qk1S?=
 =?utf-8?B?cWtEMDNzbXhPVU1lR2JiUkVWRyt0b2UwN1FNOXA2a2RHNG5sRmUxb09MazZ0?=
 =?utf-8?B?Tmxia1VHT09tb0MvTGZDZWxvWUhYU05EQlFzVjhaN2x5QzZQM3ZYQ3A2a3Ba?=
 =?utf-8?B?T3ZyS2IzYkZLYm1WV0JvbXJwRHhXOGdZVDIyVEF2OWwzdHRudTZOV203dzNw?=
 =?utf-8?B?alFlMVExLzkra3ArNnlXRmpuSFYwOU1TQ0RBeTRhWkE3Q2htaGpZanVhMXR4?=
 =?utf-8?B?azFUcElzcjdyc3hTei9FZ2Zmb0dVaHF3MEhqcTFtTTNBV1NtZjFXM29VTEI5?=
 =?utf-8?B?NmExMDIzOWF2VVl6WklSTUdLK3M1THV6K0Y2TlBDeEd0d243cXg5c1VtVDkr?=
 =?utf-8?B?eWNhR3BHc1ZJNk5jWG55d05sUVVKODY1eVRzQ3I3allKekduZnNwbSs0K2dk?=
 =?utf-8?B?QmRPUEFIQXBjNktqSDU1Z3dKZ05FTzBEQ0M1d2JwRERBTlQrNmdMSDRsU1ZY?=
 =?utf-8?B?YUR0YjlFQlUvbFNRMnhYMG9iV21FZlJDSWhSYmVBWktHZXZKcU9KV0F3TWhq?=
 =?utf-8?B?TTRKamtJQmZqUXg1ZmI0RklwMnlvbU03UkdRZUZ0S2lzY0ZBbi9UTkRzSVhn?=
 =?utf-8?B?WGV0V0FjbEJmcVp0Ykx2Z1R2VlVEeGlKR3lwbS93R01oN1Z6Q2J5bnRaMTJy?=
 =?utf-8?B?L0dZYVAzQUNSZU9Fd2FUU1JsYTFRYWFIL1R6b1kwdlo2Z3JPT3VrYXhhVjBy?=
 =?utf-8?B?ZjhHcFNBelJVUVRCWkx0ZXUydkZPZDhzVERsVkN5MGFXcEUrL0Qzb0FWeFNO?=
 =?utf-8?B?K1oxMXlMTC9QTng5ZFFra3dvS1NPNkkyQW4wRjc4aVF5R1hVbkNqZ1pyaVhU?=
 =?utf-8?B?aG1Bd2NCVlBFZUtZNk0ra0djZ2RVQUlQWXBNQkNpNTYybTErUm5SSmxldjF1?=
 =?utf-8?B?T1d2Si9RWUFnUGhnYXVDVFpuRXB5amtXaGR3ZmUyY3FXMTVhcE5mRFRxeVg4?=
 =?utf-8?B?V1lndDBocUxReC9ZcC9DRUJXRjdLeHNPRzhuNDlCNm41bUVtN1NHOXFwWThv?=
 =?utf-8?B?U0k5ZE9Uem04djBaSVdtMlc1UTA3QmJheTlocnVmeStsaUpTZHVCOThTL3ZR?=
 =?utf-8?B?MlpKdjg1dDhrcVRLbkp3SzM5VGt6dTRWM0tZd3BuR0VSVC9PcHV4RHA5VzNU?=
 =?utf-8?B?QWlJMGw2cEpTbHBjenZCbmlEam1qOEl6RHVlTnE3eVhKcXljRFdJYVNtRXR5?=
 =?utf-8?B?T2xWM09IY0VicHVYQUk1OVJzWGxPa0hiY1ZMTzlHSk5XUk4zYmN6N05IYW5X?=
 =?utf-8?B?NE9iVW5YSHhMeDFoSHNzQlhiRjI1OWJ3TnFNNHNpeElZcE9oUTNyQkJEL0VT?=
 =?utf-8?B?aUxZVUxTNFlkSko3MTJDMWk3NFBvYXVFeWtEbTczaFF6YUN5c3hhTXQxNTE5?=
 =?utf-8?B?bVkrWU4vcGlwVXJUcnhKaExyVjdoT3kxbXFXRzBMZERiOWV0ZWY4VThha29T?=
 =?utf-8?Q?EU+x58TXuwHCa6h2WomDye/dg7pOAxZrl9wFtN8?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: CORTINA-ACCESS.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PS2PR01MB2504.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe845172-b000-42e7-26a8-08d93588d6ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2021 14:20:07.3919
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0694623c-6669-497c-89c3-3a32a9934313
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YCxniIH/sqUM9iWsV556P+AVNdUq6JjS+l8IHdK4qlaJooVi+leoszf3QbzlZSfjdRiXG/+HLqzJSqXrMIRhHzJMgXNWY9WdyCQqzJ/YyWtdYn3S8Te0/Ha9nDzIVgv3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSBPR01MB3704
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

VGhpcyBpcyBOT1QgdGhlIHNhbWUgY29tcGFueSBhcyBDb3J0aW5hIFN5c3RlbXMgYW5kIGlzIE5P
VCBSZWFsdGVrLiAgSXTigJlzIGlzIGl04oCZcyBvd24gZW50aXR5IGFuZCBkb2VzIG5vdCBoYXZl
IHRoZSByaWdodCB0byB1c2UgdGhlIENvcnRpbmEgU3lzdGVtcyBuYW1lIHdpdGggaXMgb3duZWQg
YnkgYSBkaWZmZXJlbnQgY29tcGFueS4gDQoNCj4gT24gSnVuIDIyLCAyMDIxLCBhdCA0OjI4IEFN
LCBHZWVydCBVeXR0ZXJob2V2ZW4gPGdlZXJ0QGxpbnV4LW02OGsub3JnPiB3cm90ZToNCj4gDQo+
IO+7v09uIFR1ZSwgSnVuIDE1LCAyMDIxIGF0IDY6MjEgUE0gUm9iIEhlcnJpbmcgPHJvYmgrZHRA
a2VybmVsLm9yZz4gd3JvdGU6DQo+PiBPbiBUdWUsIEp1biAxNSwgMjAyMSBhdCAxMDowNiBBTSBB
bGV4IE5lbWlyb3Zza3kNCj4+IDxBbGV4Lk5lbWlyb3Zza3lAY29ydGluYS1hY2Nlc3MuY29tPiB3
cm90ZToNCj4+Pj4gT24gSnVuIDE1LCAyMDIxLCBhdCA4OjQ0IEFNLCBSb2IgSGVycmluZyA8cm9i
aCtkdEBrZXJuZWwub3JnPiB3cm90ZToNCj4+Pj4gT24gVHVlLCBKdW4gMTUsIDIwMjEgYXQgODoz
OSBBTSBBbGV4IE5lbWlyb3Zza3kNCj4+Pj4gPEFsZXguTmVtaXJvdnNreUBjb3J0aW5hLWFjY2Vz
cy5jb20+IHdyb3RlOg0KPj4+Pj4gDQo+Pj4+PiANCj4+Pj4+IA0KPj4+Pj4+IE9uIEp1biAxNSwg
MjAyMSwgYXQgNzoxMyBBTSwgR3JlZyBLcm9haC1IYXJ0bWFuIDxncmVna2hAbGludXhmb3VuZGF0
aW9uLm9yZz4gd3JvdGU6DQo+Pj4+Pj4gDQo+Pj4+Pj4gT24gVHVlLCBKdW4gMTUsIDIwMjEgYXQg
MDE6MzY6MzlQTSArMDAwMCwgQWxleCBOZW1pcm92c2t5IHdyb3RlOg0KPj4+Pj4+PiBNQUlOVEFJ
TkVSUyBtb2RpZmljYXRpb24gd2FzIG1hZGUgaW4gdGhlIGluaXRpYWwgdmVyc2lvbiAxLiAgV2Ug
bWFkZSBubyBjaGFuZ2VzIHRvIGl0IHNpbmNlIHRoZW4sDQo+Pj4+Pj4+IHRodXMgbm90IHN1cmUg
d2hhdCB3ZSBjb3VsZCBhdCB0byAgQ2hhbmdlbG9nIHdoaWNoIHdvdWxkIGFkZCB2YWx1ZSBvciBj
bGFyaXR5IGZvciBvdGhlcnMNCj4+Pj4+Pj4gZnJvbSB0aGUgdjEuDQo+Pj4+Pj4+IA0KPj4+Pj4+
Pj4gT24gSnVuIDE1LCAyMDIxLCBhdCA0OjUzIEFNLCBHcmVnIEtyb2FoLUhhcnRtYW4gPGdyZWdr
aEBsaW51eGZvdW5kYXRpb24ub3JnPiB3cm90ZToNCj4+Pj4+Pj4+IA0KPj4+Pj4+Pj4+IE9uIFN1
biwgTWF5IDA5LCAyMDIxIGF0IDExOjQ1OjE3QU0gLTA3MDAsIEFsZXggTmVtaXJvdnNreSB3cm90
ZToNCj4+Pj4+Pj4+Pj4gRnJvbTogSmFzb24gTGkgPGphc29uLmxpQGNvcnRpbmEtYWNjZXNzLmNv
bT4NCj4+Pj4+Pj4+Pj4gDQo+Pj4+Pj4+Pj4+IENvbnZlcnQgdGhlIENvcnRpbmEtQWNjZXNzIFVB
UlQgYmluZGluZyB0byBEVCBzY2hlbWEgZm9ybWF0Lg0KPj4+Pj4+Pj4+PiANCj4+Pj4+Pj4+Pj4g
U2lnbmVkLW9mZi1ieTogSmFzb24gTGkgPGphc29uLmxpQGNvcnRpbmEtYWNjZXNzLmNvbT4NCj4+
Pj4+Pj4+Pj4gLS0tDQo+Pj4+Pj4+Pj4+IC4uLi9zZXJpYWwvY29ydGluYS1hY2Nlc3Msc2VyaWFs
LnlhbWwgICAgICAgICB8IDQ2ICsrKysrKysrKysrKysrKysrKysNCj4+Pj4+Pj4+Pj4gLi4uL2Rl
dmljZXRyZWUvYmluZGluZ3MvdmVuZG9yLXByZWZpeGVzLnlhbWwgIHwgIDIgKw0KPj4+Pj4+Pj4+
PiBNQUlOVEFJTkVSUyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgNiArKysN
Cj4+Pj4+Pj4+PiANCj4+Pj4+Pj4+PiBZb3UgYXJlIGFsc28gYWRkaW5nIGEgTUFJTlRBSU5FUlMg
ZW50cnkgaGVyZSwgd2hpY2ggaXMgbm90IGxpc3RlZCBpbiB0aGUNCj4+Pj4+Pj4+PiBjaGFuZ2Vs
b2cgdGV4dCwgc28gSSBjb3VsZG4ndCB0YWtlIGl0IGFueXdheSA6KA0KPj4+Pj4+PiANCj4+Pj4+
Pj4gQWRkIHRoZSBtYWludGFpbmVycyBlbnRyeSBpbiB0aGUgZmlyc3QgcGF0Y2gsIHdpdGggdGhl
IGRyaXZlciBwbGVhc2UuDQo+Pj4+Pj4gDQo+Pj4+Pj4gVGhlIGNoYW5nZSB0byBNQUlOVEFJTkVS
UyBoZXJlIGFkZCBhIG5ldyBmaWxlIGludG8gdGhlIERUIGRvY3VtZW50YXRpb24uDQo+Pj4+Pj4g
U2hvdWxkIGl0IG5vdCBiZSBncm91cGVkIGludG8gdGhlIGR0LWJpbmRpbmcgcG9ydGlvbiBhbmQg
cmV2aWV3ZWQgYnkgdGhlIERUIHRpbWUgZm9yIHdoaWNoIHRoaXMgcGF0Y2gNCj4+Pj4+PiBpcyBD
Q+KAmWVkIHRvPyBXaHkgd291bGQgbW92aW5nIHRoZSBEVCBkb2N1bWVudGF0aW9uIGZpbGUgdGhh
dCBpcyBpbnRyb2R1Y2VkIGJlIGludG8gdGhlIGZpcnN0IHBhdGNoLCB3aGljaCBpcyB0aGUNCj4+
Pj4+PiBzZXJpYWwgZHJpdmVyIGl0c2VsZiBiZSB0aGUgY29ycmVjdCBhcHByb2FjaD8NCj4+Pj4+
IA0KPj4+Pj4gVGhlIGJpbmRpbmcgZG9lc24ndCBhY3R1YWxseSBuZWVkIGEgTUFJTlRBSU5FUlMg
ZW50cnkgKHRob3VnaCBoYXZpbmcNCj4+Pj4+IG9uZSBpcyBmaW5lKS4gZ2V0X21haW50YWluZXJz
LnBsIHdpbGwgYWxzbyBwdWxsIGVtYWlscyBmcm9tIHRoZQ0KPj4+Pj4gYmluZGluZyBzY2hlbWEu
DQo+Pj4+PiANCj4+Pj4+IFJvYg0KPj4+IA0KPj4+IEhpIFJvYiwNCj4+PiBJdCBzb3VuZHMgbGlr
ZSB5b3UgYXJlIGZpbmQgd2l0aCBwYXRjaCAyLzMgZnJvbSBhIERUIHBvaW50IG9mIHZpZXcuICBD
b3VsZCB3ZSByZXZpZXcgdGhlIHJlc3QgZnJvbSB0aGUgRFQgcG9pbnQgb2Ygdmlldw0KPj4+IHRv
IGdldCBlaXRoZXIgZmVlZGJhY2sgZm9yIGNoYW5nZXMgb3IgQUNLIHRoZXNlLCBzbyB3ZSBjYW4g
dW5ibG9jayB0aGlzIHNlcmllcz8NCj4+IA0KPj4gQ2FuJ3Qgc2F5IEkndmUgc2VlbiBpdCBhcyBJ
IG9ubHkgc2VlIHJlcGxpZXMgaW4gbXkgbWFpbC4gRGlkIHRoaXMNCj4+IG9yaWdpbmFsbHkgZ28g
dG8gdGhlIERUIGxpc3Q/IElmIG5vdCwgaXQncyBuZXZlciBpbiBteSBxdWV1ZVsxXS4NCj4+IA0K
Pj4gUm9iDQo+PiANCj4+IFsxXSBodHRwczovL3BhdGNod29yay5vemxhYnMub3JnL3Byb2plY3Qv
ZGV2aWNldHJlZS1iaW5kaW5ncy9saXN0Lw0KPiANCj4gTm9uZSBvZiB0aGUgcGF0Y2hlcyBpbiB0
aGlzIHNlcmllcyBlbmRlZCB1cCBvbiBhIG1haWxpbmcgbGlzdCBvciBvbg0KPiBsb3JlLCBzbyBu
byBvbmUgY291bGQgY29tbWVudCBvbiB0aGVtLCBleGNlcHQgZm9yIHBlb3BsZSBDQ2VkIGRpcmVj
dGx5Lg0KPiANCj4gVGhlIGRyaXZlciBoYXMgYmVlbiBhY2NlcHRlZCBpbiB0dHktbmV4dCwgY29t
bWl0IGI2MWM4YmY0Njk0YjUxMTUNCj4gKCJ0dHk6IHNlcmlhbDogQWRkIFVBUlQgZHJpdmVyIGZv
ciBDb3J0aW5hLUFjY2VzcyBwbGF0Zm9ybSIpLiAgRnJvbSBhDQo+IHF1aWNrIGdsYW5jZSwgaXQg
Y291bGQgaGF2ZSB1c2VkIHNvbWUgcmV2aWV3Lg0KPiANCj4gVGhlIGRyaXZlciBpcyB1c2luZyB0
aGUgY29tcGF0aWJsZSB2YWx1ZSAiY29ydGluYS1hY2Nlc3Msc2VyaWFsIiwgc28gSQ0KPiBndWVz
cyB0aGUgYmluZGluZyBwYXRjaCBhZGRlZCAiY29ydGluYS1hY2Nlc3MiIHRvIHZlbmRvci1wcmVm
aXhlcy55YW1sLg0KPiBBY2NvcmRpbmcgdG8gaHR0cHM6Ly93d3cuY29ydGluYS1hY2Nlc3MuY29t
L25ld3MtYW5kLWV2ZW50cywgdGhpcyBpcw0KPiB0aGUgc2FtZSBjb21wYW55IGFzIENvcnRpbmEg
U3lzdGVtcywgd2hpY2ggYWxyZWFkeSBoYXMgdGhlICJjb3J0aW5hIg0KPiB2ZW5kb3IgcHJlZml4
LiAgSW4gMjAxNSwgaXQgd2FzIGFjcXVpcmVkIGJ5IFJlYWx0ZWssIHNvIHBlcmhhcHMgaXQNCj4g
c2hvdWxkIHVzZSB0aGUgInJlYWx0ZWsiIHByZWZpeCBpbnN0ZWFkIGZvciBuZXcgZGV2ZWxvcG1l
bnQ/DQo+IA0KPiBUaGUgU0VSSUFMX0NPUlRJTkFfQUNDRVNTIHN5bWJvbCBkb2Vzbid0IGRlcGVu
ZCBvbiBhbnl0aGluZywgc28NCj4gaXQgd2lsbCBzaG93IHVwIG9uIGV2ZXJ5b25lJ3Mgb2xkY29u
ZmlnIHJhZGFyIHNvb24sIHJlZ2FyZGxlc3Mgb2YNCj4gYnVpbGRpbmcgYSBrZXJuZWwgZm9yIGEg
Q29ydGluYSBBY2Nlc3Mgc3lzdGVtIG9yIG5vdC4NCj4gSSB3YW50ZWQgdG8gY2hhbmdlIGl0IHRv
IHNvbWV0aGluZyBsaWtlOg0KPiANCj4gICAgIGNvbmZpZyBTRVJJQUxfQ09SVElOQV9BQ0NFU1MN
Cj4gICAgICAgICAgICB0cmlzdGF0ZSAiQ29ydGluYS1BY2Nlc3Mgc2VyaWFsIHBvcnQgc3VwcG9y
dCINCj4gICAgKyAgICAgICBkZXBlbmRzIG9uIEZJWE1FIHx8IENPTVBJTEVfVEVTVA0KPiAgICAg
ICAgICAgIHNlbGVjdCBTRVJJQUxfQ09SRQ0KPiAgICAgICAgICAgIGhlbHANCj4gICAgICAgICAg
ICAgIFRoaXMgZHJpdmVyIGlzIGZvciBDb3J0aW5hLUFjY2VzcyBTb0MncyBVQVJULiBJZiB5b3UN
Cj4gaGF2ZSBhIG1hY2hpbmUNCj4gICAgICAgICAgICAgIGJhc2VkIG9uIHRoZSBDb3J0aW5hLUFj
Y2VzcyBTb0MgYW5kIHdpc2ggdG8gdXNlIHRoZSBzZXJpYWwgcG9ydCwNCj4gICAgICAgICAgICAg
IHNheSAnWScgaGVyZS4gT3RoZXJ3aXNlLCBzYXkgJ04nLg0KPiANCj4gYnV0IGdpdmVuIHRoZXJl
IGlzIG5vIGV2aWRlbmNlIG9mIHBhdGNoZXMgdG8gYWRkIHN1cHBvcnQgZm9yIHRoZQ0KPiBDQVhY
WFggbGluZSBvZiBTb0NzLCB0aGVyZSdzIG5vIHN5bWJvbCB0byBkZXBlbmQgb24uLi4NCj4gDQo+
IEdye29ldGplLGVldGluZ31zLA0KPiANCj4gICAgICAgICAgICAgICAgICAgICAgICBHZWVydA0K
PiANCj4gLS0gDQo+IEdlZXJ0IFV5dHRlcmhvZXZlbiAtLSBUaGVyZSdzIGxvdHMgb2YgTGludXgg
YmV5b25kIGlhMzIgLS0gZ2VlcnRAbGludXgtbTY4ay5vcmcNCj4gDQo+IEluIHBlcnNvbmFsIGNv
bnZlcnNhdGlvbnMgd2l0aCB0ZWNobmljYWwgcGVvcGxlLCBJIGNhbGwgbXlzZWxmIGEgaGFja2Vy
LiBCdXQNCj4gd2hlbiBJJ20gdGFsa2luZyB0byBqb3VybmFsaXN0cyBJIGp1c3Qgc2F5ICJwcm9n
cmFtbWVyIiBvciBzb21ldGhpbmcgbGlrZSB0aGF0Lg0KPiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgLS0gTGludXMgVG9ydmFsZHMNCg==
