Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F27C433F5
	for <linux-serial@archiver.kernel.org>; Tue, 16 Nov 2021 11:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1A9E61AA2
	for <linux-serial@archiver.kernel.org>; Tue, 16 Nov 2021 11:36:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235133AbhKPLjI (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 16 Nov 2021 06:39:08 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:41892 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234851AbhKPLgx (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 16 Nov 2021 06:36:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1637062437; x=1668598437;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=l+v+0SGlUbHzRYog/42GY/p3r3DpyIPMZ8puGy8OCjM=;
  b=pzkmVJ4BOQ9ZkDREyljBoPItXMPSfxmQHbPosS/mSmIyy4Ze8wPd/7U8
   WAi41B8vZQdwMMLQO+KOZzh5g8qk3X5r7HJbZSHxnMQqUxLbsP51U23eN
   9BnB2tb+6wAp6TN7bWl9jTwvrWo2JUbLso/n/CYPckUKJUvKra3R1vxN6
   W6/Is5+mTPGcVYcgwQUramt3hVvUw1UubS6w/WrwtwgGJdVyn8cfXVWpR
   5bygJ3HoaEsZ9Yj1v0LyumTa6wgr3acAye4G9QuPxxxHYTK8pd2KM9eG7
   EU29O9rxMc/FZ+CTZdLP+AElVKJr2xF8uMDtZaDr+fouVDMuikMjD3qxW
   Q==;
IronPort-SDR: ne52BqjqMzPGJAIgdH29h1uGfKnXmrBQ1RJmjB+U+scIvou3qWiiYkN++0llSojk+XNmGl62oF
 PitCPUwT1G2dtHI/8C0M1bUfBIcCU9KrLKQ2OsaEo6Uk7203lKbiWDDWdeUE/omldyRb3MQ2hv
 A9HXdYspCXbSH19hCPIsfXRzogoHLiJXVn1j7dY/w69hIoE0gzdH9UKTgalpCI1/XFirJ7Dslr
 rTRsAl7J9UWiWioiBBvDvSVh57EgQsl+T0GtgGdJMAFf9mts2/xYSh1HHfOsDxlWHjOlf5Ohuy
 GQkvTtDIrLQFnAZa90HwFxLA
X-IronPort-AV: E=Sophos;i="5.87,239,1631602800"; 
   d="scan'208";a="152086289"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Nov 2021 04:33:56 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 16 Nov 2021 04:33:56 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14 via Frontend Transport; Tue, 16 Nov 2021 04:33:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kU63huE+xxZdB9FKBVWUOzj0gGyyFm2UNC2yWRylICcC5sqomiOmkhDfFpF4JizkjIGBAYD6Q5rqx5kpxoSRWAJT8JnOL/NaB/MBA6896yA5TAq1W3SZRi9AaP4S0kHvE6R0xPeQeAZ5LBJwEqtqVg1YRw6rymXQkMWZgSiCiJUKfOtzPjzF90vXJU41VvBSrTXoNCJRauIE2ien8bAuZ9Sd02npywoQh5nX7f3z2J+kRUDACSLC+VsIs5nIQp/7wFTpCSeEavcjrj1kvnFroajLpTzCHPjsa1dOgm0o7UvfrObPXFU/zpyfoRPGEJFDIhpuUlRYI+CN0fxEqL3eBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l+v+0SGlUbHzRYog/42GY/p3r3DpyIPMZ8puGy8OCjM=;
 b=A82qKcMf09Ca/bRk+YwtWFmsAjn5rUiq/UMxiSsy4zE8DuCiawdYQ6p1ZESNC3kEZTVk0r2zHNHhluld9qK2+2EIHiwr3nQejezie8TcHD/bYYX6MVSpvqWDAj/qnoHyDIp9Vokbh71t8iL3SFLa+YgZmgVJGy27uNRmKcNXvcfIVeM9JhLZVtTzOEG2LdsXheuX/lWJQupTglWtK3vSHZa0qVtSutrdpaEtxQX7+hgFLKSR/ofJe57Shx07cgAvUwlFG8hYtkP7Ww7L0nblWiFPIKiRQKEWjSojhb3cqcrpwEHBzllr9ytdQkr9HGgInq4gdWXF4D3UHiXnmfoLOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l+v+0SGlUbHzRYog/42GY/p3r3DpyIPMZ8puGy8OCjM=;
 b=XTD7thAip8Vq6NqopfFhXWcFKm7rLpjMHiNIOZFlU6CWCDmg7pE5Uh6Ta/u6aW6YUEQ8rp4MOgcBcZATZ4zYUZ8UZPamd+3Mw9j6FKuqM0WBYgrZOQLPHUIiBlhSv18sYLpA0ew7NeSvJupDNBid8TkEt+CfhObNTihQIscc2rs=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by SN6PR11MB3198.namprd11.prod.outlook.com (2603:10b6:805:c3::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26; Tue, 16 Nov
 2021 11:33:44 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::38e9:ee20:d712:2fd8]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::38e9:ee20:d712:2fd8%7]) with mapi id 15.20.4713.019; Tue, 16 Nov 2021
 11:33:44 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <gregkh@linuxfoundation.org>
CC:     <richard.genoud@gmail.com>, <jirislaby@kernel.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tty: serial: atmel: Check return code of
 dmaengine_submit()
Thread-Topic: [PATCH] tty: serial: atmel: Check return code of
 dmaengine_submit()
Thread-Index: AQHX2rEyQV/6aVtYKkWgqd+RBd+7/w==
Date:   Tue, 16 Nov 2021 11:33:44 +0000
Message-ID: <039b8f2f-7a8d-56a1-d429-d78317012919@microchip.com>
References: <20211115143004.32743-1-tudor.ambarus@microchip.com>
 <YZKDmb/ZlYwtyX8j@kroah.com>
 <1910ee9a-19f8-e155-9cc9-4a67412f3402@microchip.com>
 <YZNrU8au8SX3en+z@kroah.com>
In-Reply-To: <YZNrU8au8SX3en+z@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1555a60e-0439-49fd-f5cf-08d9a8f4f286
x-ms-traffictypediagnostic: SN6PR11MB3198:
x-microsoft-antispam-prvs: <SN6PR11MB31988D97042BDD5F1AF618A5F0999@SN6PR11MB3198.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: erMqnVL2UvLyPTJ6YuMAvXpb3gAAjSysGnkt5fPebyM7xBQRO8nONuyIIGx96AeIt+vkdixxAZJeDCvbwvMJ2yb8cN0C3QeQk8/pZZxLprgJNRjW0PY2BWjawkxVLl8ArQR8G+x7ssmhhjObM8qWzMiKco1lDU08axNF+VpurA3qXi91STwCVdKtRKTvRm7zv0gb+beYVrHCOBXK+1HEkjDmrxTJcH+RjTjUk6Cpb45X9KeIsnjhdhrd1UNHRvaC/MHjinsokK6Yf/hCq8NzoJlJ4AExxckhn6ooDuDh5qT7IyNfutsUkerfUWzcDtP1k/YpautNcN/Nqf5ORXKHOE33Z2Z4XZX+apT2lUGHCKhxHw3Jojx6qF1d4oUIXyk4mzObtVvTlwt9zjn0mhGY4httmA4LSubvE2WRH2M8VXPHFoaPWtkUX070GxoLdZ0rb/05giVJ/MMpc/pS67bYIyH6EQ6Zwf4DurojiKXBdRMfulgPOJQU3pArj/4nsRufOCuxREhKmt+XdRlxLr0++zyNXonsIc1uohoeiJha1LaIuqE+Zhs56Pdx6c0JD1FkRITVX+g/0BkQZ+BgzJoyQ+YUKOLEHjxfpPG6JlVuBkPJ7tL+vwf5aWmf1AWZBsFkv63rw1xgbZ9U13eDvYPOb2Dswd4octX6LBkKXl1oxM7FkP9se2IwVWQdTtKj+6ZMY5vOZWt8jErKG9Zjn+8SoqHLhmxCpk4OZqB2RPISCE7pXgqvdtb8EQ8Cn9kDCLmg0a1OAwcNjFmMm8hE5rJYd/JIgzNDqSd2iCe8H2V8mJEJhTJQhsVFUxc7KwPTpXVr5G/v40e1h5K0OaOir+SAgf8m3EoX7zQz0nLoyQ0+ugY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(186003)(26005)(6512007)(8676002)(83380400001)(5660300002)(76116006)(316002)(91956017)(508600001)(36756003)(31696002)(6916009)(66946007)(66476007)(66446008)(6506007)(66556008)(2616005)(86362001)(122000001)(53546011)(38070700005)(31686004)(64756008)(966005)(54906003)(38100700002)(4326008)(8936002)(2906002)(71200400001)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NHdIek95VXpqVWpMWnJRcDJXWkhtYnB5OVdCNk0rdkZmNHVGZy9iQjFodVZm?=
 =?utf-8?B?d3FkL1NvNWpqWUcvZ1ByVjA5UmxOSUFqWnY5aXh3eGRmck5acG9kajV5UTlM?=
 =?utf-8?B?Tm96eU94Vkg1VU1GOU5qWFg2T0QzUlB5ZG01VnZYaTZ1MjVCRU03Q1gydW51?=
 =?utf-8?B?Z2dsbDRqQkZuSUFESy9zTW13ZW9JaUJzSGJQZ0R6dEx5WVpOb3k2U2tCNWJz?=
 =?utf-8?B?dEtsUmw1S0E4ZmJQWWppNDZCOW5zQjNlSU8yeHNPeStlRnJtcHl5NU9WZEdv?=
 =?utf-8?B?R2FYdDMwcjhzR1pMbURmenBYSGxWeUw2QTIrdk94R213OGlTY0xjczc0b2Fs?=
 =?utf-8?B?aWg4TlpseXEzUllDcG9va09iNlRLWlZzclZkbTg3OHpYRHRCcVNUK1luWGxH?=
 =?utf-8?B?M29xNDhvVENBbmd4UU1iRVFubFVIbUlkbGhhNUJTdExIMDhTdjlpTlltWkE0?=
 =?utf-8?B?ZjlZUERCNFhIblZFaVJnODY0aGJFeFlsRWZld1JFcStGQk81WEFLTU9QcGxB?=
 =?utf-8?B?dnkrU2V3Y3M5cXo5dm10Qmp3c1N5Qy90WGQvUlc2eFFGK29Kbyt2NlhnTUUr?=
 =?utf-8?B?YWRZU1E2cVNjcjFFb0ZmcmhyQjJ6NWVJemYzcEFUYjNuOUpWblMrYno1SEVY?=
 =?utf-8?B?OSsvMytiRzJSNGE0L0R3bXJUMmZNc0RJa0p3SE5JSUFEVjJlMzUzenNFT2ZZ?=
 =?utf-8?B?V1dmKzdidEZhaWpJVXZ0T2QreDdHbFJacW5ER3JQOEVjK2huSXdzZmVBb083?=
 =?utf-8?B?NlBZcEhaQ25jRDZVUEdpUjR0WVh2MHlaOEVCcEo2NmIxNEl2bGh5UXU3alNN?=
 =?utf-8?B?OTVGL2dZdXFTek13dDlMRnhXcmtYclVYWlhGTkZoa3A2b0Z0aWRzM054MXZ1?=
 =?utf-8?B?OXNTYzZCR3QzOStzVEVHQk9qMFQ5TWZWRTRWdldodVJJQVFtQi9YRGRWSXhW?=
 =?utf-8?B?MFl1L0JjVFNlRWlIcER4c1NMTGNwcTVXclZVM3hiNEt3ZDgvWVowZlprb0p2?=
 =?utf-8?B?VDMza05HUlp1WXBmSkFwZVhrSUt4c3NnRUlad3pxT2hPY2dTbG9GNGJhVzJR?=
 =?utf-8?B?Q2NEdk83VC9FZldEZjlxQWtiM2p0UHFZRTRBby9hTVF6K2h5NmVIN0dLb3lJ?=
 =?utf-8?B?M1hyZ1Q2SENLcHFkSVZVTEE2TUU3LzBVMS95NWFJSHQvYUVJSUFkcVlmaW1y?=
 =?utf-8?B?YzI0K2JxSFRKemdQMEErZzJtU3pIb1lpYTRHQWoxR2FHNi9ya0ZUdW02TkNE?=
 =?utf-8?B?MzJSSlM0S2dOb1FxM25waWpVeHN5NUZHbi9NcUQ5MC9JOERkV2J3Z2dPOFV5?=
 =?utf-8?B?YmFmYlc4TVNoODFMdEo4ektsbmVtbjlxYklnVDBpUkZja3Mxb2dmWDRid1Vq?=
 =?utf-8?B?OFp4clZ1eHlCdU1BbGlrMkdZRU9EcmNORWU4UjRPb09ZNHU2b2twWkxkR0dM?=
 =?utf-8?B?ZFpKQTFteTcyaHZUSk1zZS91TlNRQXZIelEyaXhpUDNOQWJQcHEvS2h4cFFt?=
 =?utf-8?B?TzZ2UDZ5WUpjckFLYTVMUnEzcENnRjlCMnFUL1lpNlRiRzBqYm4vMFJYV0FO?=
 =?utf-8?B?K3VlL25sSGs3azBrRHpZWVoySGVrV0twVDQ4U3NWdTczS2plbklKMlNIV1lN?=
 =?utf-8?B?WVZvRjZocG1CUXpqeURLaHJlcEE4YjZHUEJyT0JXUjNhYk5zSUhjTjVSWXNx?=
 =?utf-8?B?akRMaEQ3cmdQNDdyWWYzZXVrYUlwRnpIRTRPRm1pNTg0dk9GNDZ4bFg4QXc1?=
 =?utf-8?B?aUVpUHhFRUkxeWNERm1nTkNEKzJodm1jdmtqSkxJWmFSSjF1WEZZb0RVU2I4?=
 =?utf-8?B?RFJmSTRyeTV5YlNRU1BDeWY1N3ZoT1BsZmxwd0E0bEJhbTRKNHloQk5JSzV4?=
 =?utf-8?B?SnpCTzNpamhDclNzRFlmWUVla0JMM01JMm9zZHF6NjhEL0cxOXh3ZDg4RDQz?=
 =?utf-8?B?aFR3T1hxdjlwS2Urb3VDSWlabzBKaGJzL2pneEpFTHZlQ0IyTnQ1R015alNS?=
 =?utf-8?B?UitiUHNhM3BBUGV4dm1KaVNpbmFTcjZSd21HOUNPR21OcHVINkhzM3h2Y2R0?=
 =?utf-8?B?RE9qYTBCSTY5SWlIaEtPdDV4TURLOFhJRlZaOXdWVndlRWxZNnRHQmpGUDB3?=
 =?utf-8?B?VWFuVEpZQUF1UXZBb1dFT3NnTHl0WDNSVnkyYTgycTIrbTljZEVXZzkvcERk?=
 =?utf-8?B?T3A1bDZpeDJUY1FGU05VRWUzeTdheGJSaHA4SnpnMlpGbUhiYWJXZGc0WHAw?=
 =?utf-8?B?eWNaVFVnckhidE40VWV4bndrUkt3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <31860ECDA6445E4781D000FF7F819513@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1555a60e-0439-49fd-f5cf-08d9a8f4f286
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2021 11:33:44.2918
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cKoKPygpqtpo0eW4Yp5wMGZCs13jNVrZC+vGUGm4w1OBqDKlTPVr7l2mDRlb09rLMHT6tLg82yg9dcj5sd+0WT9K4SRprojVc7d3nWrLWps=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3198
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

T24gMTEvMTYvMjEgMTA6MjYgQU0sIEdyZWcgS0ggd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlMOiBE
byBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cgdGhl
IGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gT24gVHVlLCBOb3YgMTYsIDIwMjEgYXQgMDY6MTQ6MjNB
TSArMDAwMCwgVHVkb3IuQW1iYXJ1c0BtaWNyb2NoaXAuY29tIHdyb3RlOg0KPj4gT24gMTEvMTUv
MjEgNTo1OCBQTSwgR3JlZyBLSCB3cm90ZToNCj4+PiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNs
aWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRoZSBjb250ZW50
IGlzIHNhZmUNCj4+Pg0KPj4+IE9uIE1vbiwgTm92IDE1LCAyMDIxIGF0IDA0OjMwOjA0UE0gKzAy
MDAsIFR1ZG9yIEFtYmFydXMgd3JvdGU6DQo+Pj4+IGRtYV9jb29raWVfdCA8IDAgaW5kaWNhdGVz
IGFuIGVycm9yIGNvZGUsIGNoZWNrIGZvciBpdC4NCj4+Pg0KPj4+IFZlcnkgb2RkIGNoYW5nZWxv
ZyB0ZXh0LCBwbGVhc2UgYmUgbW9yZSBkZXNjcmlwdGl2ZSBhYm91dCB3aGF0IGlzDQo+Pj4gaGFw
cGVuaW5nIGhlcmUuDQo+Pj4NCj4+DQo+PiBUaGUgdHhfc3VibWl0KCkgbWV0aG9kIG9mIHN0cnVj
dCBkbWFfYXN5bmNfdHhfZGVzY3JpcHRvciBpcyBlbnRpdGxlZCB0byBkbw0KPj4gc2FuaXR5IGNo
ZWNrcyBhbmQgcmV0dXJuIGVycm9ycyBpZiBlbmNvdW50ZXJlZC4gSXQncyBub3QgdGhlIGNhc2Ug
Zm9yIHRoZQ0KPj4gRE1BIGNvbnRyb2xsZXIgZHJpdmVycyB0aGF0IHRoaXMgY2xpZW50IGlzIHVz
aW5nIChhdF9oL3hkbWFjKSwgYmVjYXVzZSB0aGV5DQo+PiBjdXJyZW50bHkgZG9uJ3QgZG8gc2Fu
aXR5IGNoZWNrcyBhbmQgYWx3YXlzIHJldHVybiBhIHBvc2l0aXZlIGNvb2tpZSBhdA0KPj4gdHhf
c3VibWl0KCkgbWV0aG9kLiBJbiBjYXNlIHRoZSBjb250cm9sbGVyIGRyaXZlcnMgd2lsbCBpbXBs
ZW1lbnQgc2FuaXR5DQo+PiBjaGVja3MgYW5kIHJldHVybiBlcnJvcnMsIHByaW50IGEgbWVzc2Fn
ZSBzbyB0aGF0IHRoZSBjbGllbnQgd2lsbCBiZSBpbmZvcm1lZA0KPj4gdGhhdCBzb21ldGhpbmcg
d2VudCB3cm9uZyBhdCB0eF9zdWJtaXQoKSBsZXZlbC4NCj4+DQo+Pj4+DQo+Pj4+IFNpZ25lZC1v
ZmYtYnk6IFR1ZG9yIEFtYmFydXMgPHR1ZG9yLmFtYmFydXNAbWljcm9jaGlwLmNvbT4NCj4+Pj4g
LS0tDQo+Pj4+ICBkcml2ZXJzL3R0eS9zZXJpYWwvYXRtZWxfc2VyaWFsLmMgfCAxMCArKysrKysr
KysrDQo+Pj4+ICAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKQ0KPj4+Pg0KPj4+PiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy90dHkvc2VyaWFsL2F0bWVsX3NlcmlhbC5jIGIvZHJpdmVycy90
dHkvc2VyaWFsL2F0bWVsX3NlcmlhbC5jDQo+Pj4+IGluZGV4IDJjOTlhNDdhMjUzNS4uMzc2Zjdh
OWMyODY4IDEwMDY0NA0KPj4+PiAtLS0gYS9kcml2ZXJzL3R0eS9zZXJpYWwvYXRtZWxfc2VyaWFs
LmMNCj4+Pj4gKysrIGIvZHJpdmVycy90dHkvc2VyaWFsL2F0bWVsX3NlcmlhbC5jDQo+Pj4+IEBA
IC0xMDA0LDYgKzEwMDQsMTEgQEAgc3RhdGljIHZvaWQgYXRtZWxfdHhfZG1hKHN0cnVjdCB1YXJ0
X3BvcnQgKnBvcnQpDQo+Pj4+ICAgICAgICAgICAgICAgZGVzYy0+Y2FsbGJhY2sgPSBhdG1lbF9j
b21wbGV0ZV90eF9kbWE7DQo+Pj4+ICAgICAgICAgICAgICAgZGVzYy0+Y2FsbGJhY2tfcGFyYW0g
PSBhdG1lbF9wb3J0Ow0KPj4+PiAgICAgICAgICAgICAgIGF0bWVsX3BvcnQtPmNvb2tpZV90eCA9
IGRtYWVuZ2luZV9zdWJtaXQoZGVzYyk7DQo+Pj4+ICsgICAgICAgICAgICAgaWYgKGRtYV9zdWJt
aXRfZXJyb3IoYXRtZWxfcG9ydC0+Y29va2llX3R4KSkgew0KPj4+PiArICAgICAgICAgICAgICAg
ICAgICAgZGV2X2Vycihwb3J0LT5kZXYsICJkbWFfc3VibWl0X2Vycm9yICVkXG4iLA0KPj4+PiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBhdG1lbF9wb3J0LT5jb29raWVfdHgpOw0KPj4+
PiArICAgICAgICAgICAgICAgICAgICAgcmV0dXJuOw0KPj4+DQo+Pj4gV2hhdCBjYW4gYSB1c2Vy
IGRvIHdpdGggdGhpcyBlcnJvciBtZXNzYWdlPw0KPj4+DQo+PiB3aWxsIGJlIGluZm9ybWVkIHRo
YXQgc29tZXRoaW5nIHdlbnQgd3JvbmcgYXQgdHhfc3VibWl0KCkgbGV2ZWwuDQo+Pg0KPj4+IEhh
dmUgeW91IHNlZW4gdGhpcyBoYXBwZW4gaW4gcmVhbCBsaWZlPw0KPj4NCj4+IE5vLiBJIGRlYnVn
Z2VkIGEgbG9ja2luZyBwcm9ibGVtIGFuZCBJIG9ic2VydmVkIHRoYXQgZG1hX3N1Ym1pdF9lcnJv
cigpIGlzIG5vdCBjYWxsZWQsDQo+PiBzbyBJIHRob3VnaHQgdG8gdXBkYXRlIHRoaXMuDQo+Pg0K
Pj4+DQo+Pj4gV2hhdCBjb21taXQgZG9lcyB0aGlzICJmaXgiPw0KPj4NCj4+IFRoaXMgaXMgcmF0
aGVyIGFuIGltcHJvdmVtZW50LCBidXQgaWYgeW91J3JlIGxvb2tpbmcgZm9yIGEgZml4ZXMgdGFn
LCBJIHRoaW5rDQo+PiB3ZSBjYW4gdXNlOg0KPj4gRml4ZXM6IDA4ZjczOGJlODhiYiAoInNlcmlh
bDogYXQ5MTogYWRkIHR4IGRtYSBzdXBwb3J0IikNCj4+DQo+PiBJJ2xsIHNlbmQgYSB2MiBhcyBw
YXJ0IG9mIGEgYmlnZ2VyIHNlcmllcy4gSWYgeW91IGZpbmQgdGhpcyBwYXRjaCBkb2VzIG5vdCB3
b3J0aCBpdCwNCj4+IEkgY2FuIGFzIHdlbGwgZHJvcCBpdC4NCj4gDQo+IFBsZWFzZSByZXNlbmQg
aXQgYmVjYXVzZSBhcy1pcywgSSBjYW4gbm90IHRha2UgaXQuDQo+IA0KDQpJJ3ZlIHNlbnQgYSB2
MiBvZiB0aGlzIHBhdGNoIGFzIGEgcGFydCBvZiBhIGxhcmdlciBzZXJpZXM6DQpodHRwczovL2xv
cmUua2VybmVsLm9yZy9hbGwvMjAyMTExMTYxMTIwMzYuOTYzNDktMS10dWRvci5hbWJhcnVzQG1p
Y3JvY2hpcC5jb20vDQoNClRoZSBzbGF2ZSBETUEgdXNhZ2Ugd2FzIHdyb25nIGluIGJvdGggdGhl
IERNQSBjb250cm9sbGVyIGRyaXZlciBhbmQgdGhlDQpzZXJpYWwgZHJpdmVyIGFuZCBwYXRjaCAx
LzEzIGFuZCAzLzEzIGFyZSB0cnlpbmcgdG8gYWRkcmVzcyB0aGF0Lg0KdjIgb2YgdGhpcyBwYXRj
aCBpcyAyLzEzLiBJIGd1ZXNzIGFsbCBzaG91bGQgYmUgY29uc2lkZXJlZCBmb3IgYW4gaW1tdXRh
YmxlDQpicmFuY2ggb24gdGhlIERNQSB0cmVlLg0KDQpDaGVlcnMsDQp0YQ0K
