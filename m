Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E408C433EF
	for <linux-serial@archiver.kernel.org>; Tue, 16 Nov 2021 06:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4781261AD2
	for <linux-serial@archiver.kernel.org>; Tue, 16 Nov 2021 06:14:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbhKPGRg (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 16 Nov 2021 01:17:36 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:40863 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbhKPGRc (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 16 Nov 2021 01:17:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1637043280; x=1668579280;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=o5pLY5if2iCR72NNWvbL90JIKPES5qoN6JWPVBOsa3g=;
  b=ckJTc7ceQzZGGoto1uuZIAyDnaeZRN+3AY/tI7GanaCJ42edlnsU5OTa
   TmcCoZyuvurpJw0yKPKMkUkC7MuXQJa+AAhV2Tj4FEI+cTg13tFpp1fCJ
   ML2uM6HE2Ib9vZkfQOVPzkYZGR2wrlmmSNFlFditU8JH/LeoKwrLSXza9
   jVc1kGjo92CfBx2s51dCw8lv+w8UyorHGGpsAP5FAtpVfKupYYIFOt8uu
   T8Or/S3DuSqqyBGrhLHvPHxDcEKFd+uwhyoAl1o3pXKfQzlwV6aHSWXTO
   laUXcfvrtcyOvBCQirhs+cryQMk+yO9760vwGUuZAHjC/SHUlLvNkxU4M
   Q==;
IronPort-SDR: ktJj+W1OzbOAFBWcpaCra1DuJGDlfGI2WwsoYSz3g7FSTncqB5jIqJKwJWqZ1tNyv1ZS/ksXsn
 Q7iT0tPycuRjD986N2IkwNN9JVA6lPQgeKy2zKqWJTbUALjhRtb9yu1XEKupHxoKMGcFRpVvgX
 UYSZt91918sQyNMj4eIfTKdW9SRc2qpXleMk3Jzr+cMUSXNNM6HABxLxHkgjT7x3rhzEgNg6Z6
 ZF1y6rzeB7SFrI+fQ5xGlijg5kTmMrpEqkl349G+FHI2H5H6Bx8H3XrrXdJ0RQMzHRb2Crnzue
 HkUNTgQEBmuzYvfdS0n5HRu4
X-IronPort-AV: E=Sophos;i="5.87,238,1631602800"; 
   d="scan'208";a="139242564"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Nov 2021 23:14:33 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 15 Nov 2021 23:14:28 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14 via Frontend
 Transport; Mon, 15 Nov 2021 23:14:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a0DfEwqn6YtmCRieigCu1JmvuYQWSmXs1MD2NzRgVcllaXBKLM+H+LKH+Zj8rZitgOSGIkDTyKsKh2gzB5nKL6RaKbf4j2iBp0E29gATn6thoYutiRVhzcDRhXoa773LQCpB87Y5KV7KVSyz5c8XU//RfbUTnEqwO1LOipQbjfEO1dKD0pXx7Teb0pSBrVJHo8Rba9a76LuIS2YNHIL/ycpMEDZCCbSN5u0jOxXa1JgaDk0Q9YMxVtE8gpFzFg63ZfZgMAKYzwQGHt5eFLNKpEXF4GWilC2OtwY2pQh/ncZLMgaev8ZoWf8OV02ZBPf+yT+WNKATq84JXqidnWkAEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o5pLY5if2iCR72NNWvbL90JIKPES5qoN6JWPVBOsa3g=;
 b=gxH3l1p236BIj43Qu8QDYOTIjWlLRpYhmtsPyJlRNi6UxJ+ohh/31d/bmuu3fgEv48RetOdKBGmf9tXrKpkbuDBme7bYhhoky+owyNo2cUczIg2zUnXLnq/N/Sor2GWoArxg2gvg+szAr3ypczVEv1Ab998t/j+KqT3sJxCLwUXHcFLPWDW7c4QsNiOYk2jsSBNY50BGDUTbrG7ZrL56q/TkbCWPEuc0M7bX973ZJuTUQ0iBrAc+pe1Y5gRAspOu3XKBQyixi4pUdI17hGhX53iITEoNgd+DbYWcw5clykfQWdR4urO9zJk+r+Eu5cOl5lGRn/onnRLdcE3Xs91dlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o5pLY5if2iCR72NNWvbL90JIKPES5qoN6JWPVBOsa3g=;
 b=YMA+6WK/JIu4WdR3loVa9Zs39O+pKLnqE1GUpXHJMj3qDNeeieTzK2hCcDI4/zi8qWfS+d2JL0jfx379qRdHjyX59bJdd/kR4QQq33qXdyWfhwPJ2w8zP+7az9GUn2JuE+qjTlsKdwmIl4j9qHxOvyhWcJr4Xzi5yprxrKQx8ow=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by SN6PR11MB2733.namprd11.prod.outlook.com (2603:10b6:805:58::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.27; Tue, 16 Nov
 2021 06:14:23 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::38e9:ee20:d712:2fd8]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::38e9:ee20:d712:2fd8%7]) with mapi id 15.20.4690.027; Tue, 16 Nov 2021
 06:14:23 +0000
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
Date:   Tue, 16 Nov 2021 06:14:23 +0000
Message-ID: <1910ee9a-19f8-e155-9cc9-4a67412f3402@microchip.com>
References: <20211115143004.32743-1-tudor.ambarus@microchip.com>
 <YZKDmb/ZlYwtyX8j@kroah.com>
In-Reply-To: <YZKDmb/ZlYwtyX8j@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 389079ad-a8f8-4d44-52c0-08d9a8c855df
x-ms-traffictypediagnostic: SN6PR11MB2733:
x-microsoft-antispam-prvs: <SN6PR11MB273334E662AFC8BEA5FF10F4F0999@SN6PR11MB2733.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DhSSxwhjt7ZZ2Ch3j41PgWWN0/IAHCHGllkBQji/Xpv0dD6QS9oTCJJp0D53FP8dcTImf1f3Wk7U1PB3zJc6iSkO3nZvdvCNJoSf9C0LpFjp2HzGv48/U+1oXG7DsYAkBQcu+qP3ayi9hbw6qztMGWQzFRmUtmf/C0dryZyn2HGEQMJY5kKrMRKOC6QIbfJrgFPTR5ZLTRPDskMtf2If+cxvnjrh4/bTleBy76aNhhrZVe0vYscKwT/QDPfunTolABs8x9M3MdDDCkFREUMYCsqbVLAvxJHIXAperpOHHDGNKrv74x4nv6jwSvSYzAEZCNvJxh4QiLhNxh9u3GH77/NpXMNFebR04V2AqVF2zUown8yLBnO/HZNO40qZ9TEIqnvik7Z3Txd5MV9buH+UGGxbs6NykAOxDFOyITinNfKLQxmeqbub3mV8APdb/J+EF4xCbL7BNCy008UYHMiTk2AOUAP1Zknd5JRuIrLuykZewXFCdnrUVSBJqaAc64N0mUbEBGa03avUkR3cBEM1HGx3kRTjFQmRlAdQZq0wN0ds8g/1qrIOUObFZIzEToETZayoBU0dEqtrnMePTVZxLtbvFIarG91AooPV4DHUJjukMYj+XUpmSfqyp/EbvkoTJ4I827D+lbls1L9Tk7MydDMeMLtLyCE8BYJXW5YaxfszvbsE8YJT5eFTYi1tQFHRmSN6TsVHp+Nn+DyVS+oRCex9Zyj9wABh1W1tyMzZTK6NqHxMW3rOKqD5tNj2WCVIi6AVARuqKzXNyx6Xz46xDA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(36756003)(31696002)(508600001)(66476007)(6486002)(4326008)(6512007)(53546011)(8676002)(6916009)(5660300002)(8936002)(2616005)(31686004)(122000001)(38100700002)(2906002)(38070700005)(316002)(71200400001)(83380400001)(86362001)(6506007)(54906003)(186003)(66946007)(26005)(91956017)(76116006)(66446008)(64756008)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WlppMmFXS2EvRU5GY2NHWURBQWFrRSs1WlUxK0h2SW13bHlWakhOS2gxS2lM?=
 =?utf-8?B?eWFUV0xWOEVFQUg5Qzdybkxhekd4cXV1QktQcVBodmxCclNnMDJieUVickxI?=
 =?utf-8?B?bGhHRmVvcHBaR01ndG9rNDVQS21YbDErbXRNcks3Wklnc2FSNmhxSzFWejFY?=
 =?utf-8?B?eTBQb21kdGVqSGJOMnRYNXRka1Z2bmxGbXF3eG9mUndGT3lPNktkVDVxTnl1?=
 =?utf-8?B?VXg4eG5VUE1GckhMY0ZKVjJVekdxQzBQNTcvSkpvcWN5M2E3RGFjR2lvbzJI?=
 =?utf-8?B?UVNKWXl4N1VudTJTWDBLc05vNDR1eDl0RVBBaktvSHNVdFNaRHA3enBCaFA5?=
 =?utf-8?B?RDBrbVg4UTd4OEw4K1J1Y1ZUNENUTEdmVDB2MHNhWVphbnl0OSs5K01hMnl2?=
 =?utf-8?B?YUFoYUMwTDVmWGhtVUI2clR4VUdzVFU3SHRQUEp6cUNPaFNDZTNWWng1YUI2?=
 =?utf-8?B?UDlNRWtmZWlLYnNFSmNnR21OZTdYV2dNSU5UKy8rSTlQdmk0aEI0disyWDFx?=
 =?utf-8?B?Q2pMeWJBVmZDTVRYWkdaOUdoQnFFMHN2WWRyZW43NHVVOEg0VFp2TTUzU3Zo?=
 =?utf-8?B?YlkxN2VmZGNzcnczNVN0bnNncnBMSXJBV0lWbnE2bldiUjRNSHYzaXBuaVM1?=
 =?utf-8?B?QitNWFhSNnJVNFJiUnpneGpFZ0k3aWQwT3hkTTk4TXVtdnk4bnlYOHBCRkhN?=
 =?utf-8?B?d2MvQUZYakNBZ1RBbkJCemVTQ1lLNHVPaVlYdk02NnE4bHJCY1o1NVBqcXo4?=
 =?utf-8?B?WC90QWtFMTFxNlViVlcrdzhWbkJ3NXduc0RQUmxLRVBPOTVzendQZHZVZTM1?=
 =?utf-8?B?bFh0VUpSUndOYTRyT053WFAyQTBQamV4bGFJQkJrZGc2VjFqSDcybUpocTI3?=
 =?utf-8?B?ZUw2blFjODg3aFA4RnZhUnAwSldwTU1yU0lhWkNXNUFtNjU2ZGdkU2tMQWM0?=
 =?utf-8?B?L1l0N0EyeEpOLzRvUFpGUURaM1JaamFrYVpoTUlLdWMrMFlnUlNvQmZlZ1BM?=
 =?utf-8?B?SG4wbExSNlFUL2k5YzVESk5Xa0hzMTNxVHREL1EzYVBNdUtCS250Y1pzT0V4?=
 =?utf-8?B?NzZjeFZzbXJwR2p6cE53RHdXc0l5VWl3S29XSVRLMjJOOUhCUEhRejNFOU1N?=
 =?utf-8?B?NU1IcS9vMDRxckVYU1A4NG5LZ0w3RVRkRjhNdGVXVkxkTmRYcEFzbWJxRzJP?=
 =?utf-8?B?eVpEYjRJTEdVcXVoUjNndC9id0RxRzhBQS9PNDFaY1VCWFQyRHZXdENWYyt1?=
 =?utf-8?B?dDFaODBWZ3VBQXdVdVltSFZsRzVrL2ZaMGpaWG56OU54bm9nSW1EUlpMRlc4?=
 =?utf-8?B?eTNjNmVjZXBDWGlpcHFUZTZPN0ZwU1RxSlVxNEJrNXdITUdjQ243TmRua3Fk?=
 =?utf-8?B?L3JScjdNSWtLTkIyWE5UMi9KNlpFVWVma3YzSm5kWmN3blYydHdUanRXUGVE?=
 =?utf-8?B?Y083dXpvK21XdS81ODFLNi9RN1FOUGVBeFB4b294NVFoSDM0OUloa1J2ZTVS?=
 =?utf-8?B?U2xacTUxYXpSVnR0QzNyMXA3Z2UyQnFJUStUMXZ4Wi9wUVJYVFNUT241REVl?=
 =?utf-8?B?a3BJK2dPSjBZM04rZzhJajk1RzFjUkt2MlBpd3dQYjRpM2xvWDhjZlhBZTVC?=
 =?utf-8?B?RTVvZU80RzlUcWdHaHNxN0hDMFVVK0tDVUYwUStSVlpEclZwWmdYRzhycGlX?=
 =?utf-8?B?YnlWTUFDRXh5TCs2eGJEWlhnU09hY0hEbVliR0VnQmlWSTA5b3F3ZzF4ZXlq?=
 =?utf-8?B?OVVoOGFDUGhpS29QMSt5WUxXclZOM0R4UmZ6b0dlOUhXOEh6QzFYM2FzaDRn?=
 =?utf-8?B?VmhhS29IaGt0VjRkK25LVWU3V283QlEwMVk1Yy85bGF6QjRqblNjdTNGTGo2?=
 =?utf-8?B?UnlUUjJiaEdGRGZ6TVlhZ244VGt1MWxwMlBDMndLdmhkbFMzMFg5Z01JT3NU?=
 =?utf-8?B?enQwNXhnSVBYTERzTGJwR0pkUzZjOWdSaFlQVlJOeDBNVFozL3NBS3JhQi9U?=
 =?utf-8?B?UmZqWTk2UHZzelcwTTdmeTlRdHlZWFJEUVdra2Q3TmxuN2NsQTVleDVhWWRa?=
 =?utf-8?B?NTVNcVltNytob1h2Z1dTOHEwOVMyZ2RodEMxYzZQOVZTWDBPbUFMaWNhRUZx?=
 =?utf-8?B?SklmVUxXa0VveWQrVTIvR01tdDJvOXFRR09ER3lZNTl1NUlEVlAxNFhwWmUz?=
 =?utf-8?B?Uit4dUxudkN5MUdqcEtmakxhZm1kLy81ZUxGS3dZTkZSTEt5SW5FSXVpK1dP?=
 =?utf-8?B?VzBqN2hKUU9YK29RbjFFVUVhcTlBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6B9BEF8CD2066447A74431675EA3ACDF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 389079ad-a8f8-4d44-52c0-08d9a8c855df
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2021 06:14:23.5876
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w+msgzoGfh7QBHFkcpbeCjgqK1qRqmB7Ih2bt18kdW1pKnrwGEZe7GjnFg7lK10zc5F493NK7OYf6D/3si6EvqhPctql80m6Zvq0kIQbSDE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2733
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

T24gMTEvMTUvMjEgNTo1OCBQTSwgR3JlZyBLSCB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6IERv
IG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0aGUg
Y29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiBNb24sIE5vdiAxNSwgMjAyMSBhdCAwNDozMDowNFBN
ICswMjAwLCBUdWRvciBBbWJhcnVzIHdyb3RlOg0KPj4gZG1hX2Nvb2tpZV90IDwgMCBpbmRpY2F0
ZXMgYW4gZXJyb3IgY29kZSwgY2hlY2sgZm9yIGl0Lg0KPiANCj4gVmVyeSBvZGQgY2hhbmdlbG9n
IHRleHQsIHBsZWFzZSBiZSBtb3JlIGRlc2NyaXB0aXZlIGFib3V0IHdoYXQgaXMNCj4gaGFwcGVu
aW5nIGhlcmUuDQo+IA0KDQpUaGUgdHhfc3VibWl0KCkgbWV0aG9kIG9mIHN0cnVjdCBkbWFfYXN5
bmNfdHhfZGVzY3JpcHRvciBpcyBlbnRpdGxlZCB0byBkbw0Kc2FuaXR5IGNoZWNrcyBhbmQgcmV0
dXJuIGVycm9ycyBpZiBlbmNvdW50ZXJlZC4gSXQncyBub3QgdGhlIGNhc2UgZm9yIHRoZQ0KRE1B
IGNvbnRyb2xsZXIgZHJpdmVycyB0aGF0IHRoaXMgY2xpZW50IGlzIHVzaW5nIChhdF9oL3hkbWFj
KSwgYmVjYXVzZSB0aGV5DQpjdXJyZW50bHkgZG9uJ3QgZG8gc2FuaXR5IGNoZWNrcyBhbmQgYWx3
YXlzIHJldHVybiBhIHBvc2l0aXZlIGNvb2tpZSBhdA0KdHhfc3VibWl0KCkgbWV0aG9kLiBJbiBj
YXNlIHRoZSBjb250cm9sbGVyIGRyaXZlcnMgd2lsbCBpbXBsZW1lbnQgc2FuaXR5DQpjaGVja3Mg
YW5kIHJldHVybiBlcnJvcnMsIHByaW50IGEgbWVzc2FnZSBzbyB0aGF0IHRoZSBjbGllbnQgd2ls
bCBiZSBpbmZvcm1lZA0KdGhhdCBzb21ldGhpbmcgd2VudCB3cm9uZyBhdCB0eF9zdWJtaXQoKSBs
ZXZlbC4NCg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFR1ZG9yIEFtYmFydXMgPHR1ZG9yLmFtYmFy
dXNAbWljcm9jaGlwLmNvbT4NCj4+IC0tLQ0KPj4gIGRyaXZlcnMvdHR5L3NlcmlhbC9hdG1lbF9z
ZXJpYWwuYyB8IDEwICsrKysrKysrKysNCj4+ICAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9u
cygrKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3R0eS9zZXJpYWwvYXRtZWxfc2VyaWFs
LmMgYi9kcml2ZXJzL3R0eS9zZXJpYWwvYXRtZWxfc2VyaWFsLmMNCj4+IGluZGV4IDJjOTlhNDdh
MjUzNS4uMzc2ZjdhOWMyODY4IDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy90dHkvc2VyaWFsL2F0
bWVsX3NlcmlhbC5jDQo+PiArKysgYi9kcml2ZXJzL3R0eS9zZXJpYWwvYXRtZWxfc2VyaWFsLmMN
Cj4+IEBAIC0xMDA0LDYgKzEwMDQsMTEgQEAgc3RhdGljIHZvaWQgYXRtZWxfdHhfZG1hKHN0cnVj
dCB1YXJ0X3BvcnQgKnBvcnQpDQo+PiAgICAgICAgICAgICAgIGRlc2MtPmNhbGxiYWNrID0gYXRt
ZWxfY29tcGxldGVfdHhfZG1hOw0KPj4gICAgICAgICAgICAgICBkZXNjLT5jYWxsYmFja19wYXJh
bSA9IGF0bWVsX3BvcnQ7DQo+PiAgICAgICAgICAgICAgIGF0bWVsX3BvcnQtPmNvb2tpZV90eCA9
IGRtYWVuZ2luZV9zdWJtaXQoZGVzYyk7DQo+PiArICAgICAgICAgICAgIGlmIChkbWFfc3VibWl0
X2Vycm9yKGF0bWVsX3BvcnQtPmNvb2tpZV90eCkpIHsNCj4+ICsgICAgICAgICAgICAgICAgICAg
ICBkZXZfZXJyKHBvcnQtPmRldiwgImRtYV9zdWJtaXRfZXJyb3IgJWRcbiIsDQo+PiArICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBhdG1lbF9wb3J0LT5jb29raWVfdHgpOw0KPj4gKyAgICAg
ICAgICAgICAgICAgICAgIHJldHVybjsNCj4gDQo+IFdoYXQgY2FuIGEgdXNlciBkbyB3aXRoIHRo
aXMgZXJyb3IgbWVzc2FnZT8NCj4gDQp3aWxsIGJlIGluZm9ybWVkIHRoYXQgc29tZXRoaW5nIHdl
bnQgd3JvbmcgYXQgdHhfc3VibWl0KCkgbGV2ZWwuDQoNCj4gSGF2ZSB5b3Ugc2VlbiB0aGlzIGhh
cHBlbiBpbiByZWFsIGxpZmU/DQoNCk5vLiBJIGRlYnVnZ2VkIGEgbG9ja2luZyBwcm9ibGVtIGFu
ZCBJIG9ic2VydmVkIHRoYXQgZG1hX3N1Ym1pdF9lcnJvcigpIGlzIG5vdCBjYWxsZWQsDQpzbyBJ
IHRob3VnaHQgdG8gdXBkYXRlIHRoaXMuDQoNCj4gDQo+IFdoYXQgY29tbWl0IGRvZXMgdGhpcyAi
Zml4Ij8NCg0KVGhpcyBpcyByYXRoZXIgYW4gaW1wcm92ZW1lbnQsIGJ1dCBpZiB5b3UncmUgbG9v
a2luZyBmb3IgYSBmaXhlcyB0YWcsIEkgdGhpbmsNCndlIGNhbiB1c2U6DQpGaXhlczogMDhmNzM4
YmU4OGJiICgic2VyaWFsOiBhdDkxOiBhZGQgdHggZG1hIHN1cHBvcnQiKQ0KDQpJJ2xsIHNlbmQg
YSB2MiBhcyBwYXJ0IG9mIGEgYmlnZ2VyIHNlcmllcy4gSWYgeW91IGZpbmQgdGhpcyBwYXRjaCBk
b2VzIG5vdCB3b3J0aCBpdCwNCkkgY2FuIGFzIHdlbGwgZHJvcCBpdC4NCg0KQ2hlZXJzLA0KdGEN
Cg==
