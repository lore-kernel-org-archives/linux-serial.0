Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C65BE728CC
	for <linux-serial@archiver.kernel.org>; Fri, 29 Sep 2023 17:39:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233149AbjI2Rj4 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 29 Sep 2023 13:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232923AbjI2Rjz (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 29 Sep 2023 13:39:55 -0400
Received: from MW2PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012006.outbound.protection.outlook.com [52.101.48.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7FF1195
        for <linux-serial@vger.kernel.org>; Fri, 29 Sep 2023 10:39:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VNmqWMu4xhk+FWmArMmF3oBuR1qRsexD60A9adOJLvixfla3gOwye+u6uF3fpIKLifoOwZ7dnnTdRHPgD1Zii5KSXvFM/A79KchaIyUkrsnUz6e8z14pks7VA3iP6f9S5QK2qfc9aNGcXRDWmpT2LJOP46nNHA0DRpzKZDHn9QYVuXmEupQcHqXdvNPnD3tw/FKTYckDC9D8GvIzob/9wi7VZFEZHa3dyAn8E96cRafWpeFA9xgwiGbUQ7sjtZRxjFdkKVesjQwCCBkN4glyidRmDHoKAX9ceTrY7fJWWkiAAm1o7A2vlfvCz7tIiTpRZogyHUPKAmofk9b/KYOVNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vhUKqvU+rLaFcahzUbCVTm/p0D9+6Is9WjzR4yVEmuE=;
 b=ULwLLKhYU7mN0maAPdHhDo4AdMWGcf4fPwCxyhQEkDujdHr6UG0rGPfg1g9xYfG5pVu/p4BYmd1hhxDNwWjDXS1I38MRxZmoUrQIHqtA3zUXTzMuK4f5/qWS6OUxTfoXFizzJtZ0JdkClS0IAKC0cIn4ptDNOXYy6JB3OE1byJPtfil5YWwP/X5JSVTBz6mZBHIxh/rETJXRhmJ81bayUEkq720JeTtu6v4IIBi3h9n/frepckUNSxnjXbYb7KDyN/S6OYxjuSME1J8DEikdls+5PNQV3OHcc0YUcu7Pw6t7xj/0fg1Iit+1Mlu8yUCT1SKIT7b78x3IA8wlR+GHeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sealevel.com; dmarc=pass action=none header.from=sealevel.com;
 dkim=pass header.d=sealevel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sealevel.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vhUKqvU+rLaFcahzUbCVTm/p0D9+6Is9WjzR4yVEmuE=;
 b=jYpog43XE4WWIhrsJWnoH0AiYIIebpZuiZSy7sOra4wdZzAt1xiIDwd1MATsFO6Dxy8Q/G12n20AC+bQZbrM3FzUCaJntJODYHOnbPPRX6e9r7fP1VPRDcM9F5L79Kx7HjxcCRcpiAEP6NaASbR6N3BpNPZmAfELcHZDWgGYBN9Vye86Q9QUc1MRrjhUZx7DDqBWlBkTjbuoJwdo51frpf6qrNW/eo0GJA5CTVB6bo4vOegZBKj858HgQJQ9ndGHO3wNlWdToPExHx8j/72rHZKNUvixCoN094iPfBzxGNS9Avij8XaohPgNld4ZTXNZIUZglEcT68pvaET/Q8l20Q==
Received: from BY3PR05MB8419.namprd05.prod.outlook.com (2603:10b6:a03:3c6::10)
 by PH8PR05MB9362.namprd05.prod.outlook.com (2603:10b6:510:1c1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.24; Fri, 29 Sep
 2023 17:39:49 +0000
Received: from BY3PR05MB8419.namprd05.prod.outlook.com
 ([fe80::f4e4:1bc5:23f6:c9d4]) by BY3PR05MB8419.namprd05.prod.outlook.com
 ([fe80::f4e4:1bc5:23f6:c9d4%3]) with mapi id 15.20.6838.024; Fri, 29 Sep 2023
 17:39:49 +0000
From:   Matthew Howell <matthew.howell@sealevel.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     Darren Beeson <darren.beeson@sealevel.com>,
        "andriy.shevchenko@intel.com" <andriy.shevchenko@intel.com>,
        "ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
        "eff.baldwin@sealevel.com" <eff.baldwin@sealevel.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        Ryan Wenglarz <ryan.wenglarz@sealevel.com>,
        Matthew Howell <matthew.howell@sealevel.com>,
        James Olson <james.olson@sealevel.com>
Subject: [PATCH V9 1/2] serial: exar: Revert "serial: exar: Add support for
 Sealevel 7xxxC serial cards"
Thread-Topic: [PATCH V9 1/2] serial: exar: Revert "serial: exar: Add support
 for Sealevel 7xxxC serial cards"
Thread-Index: AQHZ8vvyagtiwAEjxEmBxrU0jY0e3A==
Date:   Fri, 29 Sep 2023 17:39:49 +0000
Message-ID: <8ffa2f583ff142c3b0eb6cf51a7c9cef5dbfd320.camel@sealevel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sealevel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR05MB8419:EE_|PH8PR05MB9362:EE_
x-ms-office365-filtering-correlation-id: 5b9501d8-2eec-460b-7009-08dbc11314a3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fR0oCUvMGxep4af0yRK/wf32emtg8nP9fsRf4ZQvOiNe3QDb820wv/TQKJuKn7Rda8dhE7xI0gng4Y9p6E7OO0cymPgKrXNDh09Buivn57naQaAQThPktH87tZ1JjOagRIcgTuvQzztzNC4G1+Xx8EIF1wsfQVSFY4XbZcxw5np1Chjd+VUX6pbBM+Ujlm39LvUbqojYfojNTvZY2VQy/J0qOEkjJLELN2bTJE9q3GL/nLcUM0cmLCm8dywlwy4XyI9zhbqj5mIOzFL9KRtzBJNoLm2KABrB2QoY6C2TniSaaBSObW9R1WuzgMG4nqO0ZH1FGqGCxzV3UZeB+4cICvvjzLMP8GHIsRxBSh9JXw3O6IOecuuWf3SqxGphs/sEq+a1HIA7o194a7oJYFZ3w4HSOowfjqKNwKwBFuEPvijLppRgx2u1C6VZU4DHSmUrKOhamvU/HeAtE0yLulhVv6VIWM4sPRaBXAKRG/P4EYlYY8hI+Y8wOaZcetQhA6+yqfmezJloD2NYJt0Hmf3X4AqaCb3dJULgOA8m1rVQX6aq5HwmpbI52FRi1CHgz8OnZcTD2RwsKjzvxWaednzCjQmqlGRa8b8ZN6DWObRYZj5IhgpVWpkereEn9eVdP9Op0zA8nBlut7zi7T30ryAsLWz84YzkJ1yEypL+fuQB248=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8419.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(376002)(396003)(39840400004)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(478600001)(71200400001)(38100700002)(38070700005)(2616005)(107886003)(6512007)(6486002)(36756003)(122000001)(6506007)(26005)(64756008)(66946007)(66556008)(66476007)(91956017)(76116006)(41300700001)(316002)(6916009)(54906003)(66446008)(8676002)(4326008)(5660300002)(44832011)(8936002)(86362001)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UElwZnozRVZEbGU3NUg2R3lYTTR3azE4aWcxVm02bVphMlY5RzJ3a0dnUDh5?=
 =?utf-8?B?R1NMY0U5dlJhc0ZrYWpuak4vSGlVK2dKWi9YTklnQTVia1hDMG1CK1NyelBZ?=
 =?utf-8?B?aWtRUmROUUxyeEJQa2UxZUNhU1lFZkRYTENGYU1Ha1NUMTlubld5NHc3SWgv?=
 =?utf-8?B?Zk9WdTN2MDVoLy9YTWU1UENaR2huTjZxd2JDWE9vejc2a3lva0hxMkJ2UWsy?=
 =?utf-8?B?Q1B2aEFQb2FxaThnYi81cGYwSENEeVpsSEpTRDFvWHpHQnBCWEJ0clgycUth?=
 =?utf-8?B?VnBKTHVvNjVoZ0h3UFVyY0w1R3Z5dWtYUkVqT2pmQ2hteTdzbHZZOXBJYzVm?=
 =?utf-8?B?K3QzN2EyK2taOFArZlY2aEI0MVc4WEZYWm1Gdmw1aU5PSzRSbjVBK3lva2Zo?=
 =?utf-8?B?eWEremFLQmV0bFZISnFZKzJNN3BFc1h2dG1kZStJd2ltUHdBRndpUncra0l0?=
 =?utf-8?B?SE9TUUJhcVBzT2VRMUpyTkZKcXpvMUJOZVgxWWRLZHUzSGRiSUJqSlNIZG1x?=
 =?utf-8?B?cTdyNWF2c21Xbzc3WnVJMFZGVHZYaWNkTG9HNUxBQ0laV0svdlR4THVOQ1ZS?=
 =?utf-8?B?RDVSTWVJTEJUUXZ2UTlHN01PSVFSOGlQTi9MQWpWbVkrOFRxeVV6azkrVmIv?=
 =?utf-8?B?QjhKVjRGMFNhOXBsYUZZN1ZzM2dtTkNiWXR3VDJuVnh0bW5PVjZzTVJ2a2tV?=
 =?utf-8?B?UnhnM1pINk5EeWRzR2RoSTgrbW9qN3FkN3M5NEFYaUpCQVVSQkhFVHQ3SWZs?=
 =?utf-8?B?N3Z3V3JIa2tWRld2ZHh6N0YxSmhBQisyZCtsQXhoeGY2aWUvNkQ1b0c1dXRo?=
 =?utf-8?B?MmUvOCtybSt3c3JYdDAyL0kvdUw0d0lvdjYxa1IxZ0s3Q202NksvMkY2aDNa?=
 =?utf-8?B?WkNxOXV2dDVJQkxTUFMxQm04YW1qaE5HRFMxS2lSeGpiU2cydkVGZEd3S0Zh?=
 =?utf-8?B?TGU2VE9wWjl3YmVyQTVwdW1HcDlQS0JHT0xhUDZvRUM4blRlSFppLzhKRmhG?=
 =?utf-8?B?RjYwNitCMWJDdXYwb2pmaWQ2bVdtR0k0Nk9STUNzOFNvYXpmcm5FUWN5V215?=
 =?utf-8?B?TzBIcWFqSnNkeUdEcHpZd1YrdGRCS3piUUk0WFI1czI0RmJaMmpRTUo4dlhi?=
 =?utf-8?B?ZU43RDBhNnY4bGxET3NjeXJ1NWxXQ0hGQ2NUaTA2L2pCTk40OWpxcEs4M3VY?=
 =?utf-8?B?OUQwYlBaV1czUXZsTHhQaEk3bEFuNEtoeDFMd0UvVmhYQko5cXRxTmtkM0lW?=
 =?utf-8?B?dERUMk5UM29lU0ljWU45aDcyUnNCeUV2cSs3bUcyL3NPektIZE80bzEvQ0la?=
 =?utf-8?B?aXduT0ZKZXJQbGV0alVoSmE2M2lVSHNHT21wVXR6MlZqaHhOSnJWbDhsZkRu?=
 =?utf-8?B?b21XUzJrSW54WDdlY3NoaEcwcU1KWjlsSDZlQzJUUzRYa1hkOUlvMmdYdCtI?=
 =?utf-8?B?dnF2QzgxeXlHNXBuL1ZUTnNBRDJ4clR0YjR4NXRzaUhIc0ZLYlFTYnJOcFBM?=
 =?utf-8?B?akUyazdwRnZiellqTS8zZ2VKMm1vZEJXeisvUzN2d242RHZVWHpibm9UdEhT?=
 =?utf-8?B?ckRoM202WUJRbzEwZGJ6VXp5ZGtlVjFPL05obFZZSEtzMUlyT0dERE12NlAx?=
 =?utf-8?B?R2FQY3RqSUhqUjZ5MzJUYUp0QWdsUTdpMTZMUlRTWENNMjQ1ZmdHeFRoeWZR?=
 =?utf-8?B?MTBZeWxMVGlYS3krRC9Qb3NHV2NXL0ZVUTlCVXZZeWRuVDRtVUpZSGJTVWtD?=
 =?utf-8?B?SVdXM2pyZzFWUm1VWVJDQWtSdnNqNFFURGRPem53dkNKN2hBNWhmSW9SK1pY?=
 =?utf-8?B?ZHBuaXlDRTlaNkJPRklSejA2bm9abjkzVGhoLy9iNXNTZ1dVUk1VUnFpRWJF?=
 =?utf-8?B?Qk5ldllKdUdlT2lERyt4NHd6Q0l1SEc1RlhFcTRKRnNMbVlBb3FIU3ViQlIw?=
 =?utf-8?B?VUR0QkJDRFhaVE1GVkZKSWRsQWQ2OWl5Y3dyS09CUWVvMHZzcDZOMTZWUXF0?=
 =?utf-8?B?RXJDOG4vQXllMXFzK2I5dlBFL01ZNE9tS2loQWZGN1Vhek5TemprTGtNU0po?=
 =?utf-8?B?dnRZWnB4bmQyY2NjZDZaRlRJMEgzM0hxK0JaQ1RtUFFzaDh2QmlGQUpEZWhN?=
 =?utf-8?B?STBjUDZlRi9mS2wxR0ZwUnBNdVFkT3d4eUFuNnRlYXZMVy80RUVLamJwRVcz?=
 =?utf-8?B?MWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7ABB2C330DB32544B8466C96F24577CA@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sealevel.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8419.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b9501d8-2eec-460b-7009-08dbc11314a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2023 17:39:49.7610
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e34c5615-b4e3-481c-abc8-602581f2e735
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mnM6X2L0cQF9+LL9Cd2DkKnJuedzcdYVd+nPhc5OM7QQJ24/jJE9rYp/fXglErqtvWY/YUzg/QLeRhZuugpPmMOxAVpOUReVY4So7PYGuOI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR05MB9362
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

RnJvbTogTWF0dGhldyBIb3dlbGwgPG1hdHRoZXcuaG93ZWxsQHNlYWxldmVsLmNvbT4NCg0KSGFy
ZHdhcmUgSUQgb2YgU2VhbGV2ZWwgN3h4eEMgY2FyZHMgY2hhbmdlZCBwcmlvciB0byByZWxlYXNl
Lg0KVGhpcyBoYXMgcmVuZGVyZWQgMTRlZTc4ZDU5MzJhIHJlZHVuZGFudC4NCg0KVGhpcyByZXZl
cnRzIGNvbW1pdCAxNGVlNzhkNTkzMmFmZWI3MTBjODMwNTE5NmE2NzZhNzE1YmZkZWE4Lg0KDQpG
aXhlczogMTRlZTc4ZDU5MzJhICgiQWRkIHN1cHBvcnQgZm9yIFNlYWxldmVsIDd4eHhDIHNlcmlh
bCBjYXJkcyIpDQpTaWduZWQtb2ZmLWJ5OiBNYXR0aGV3IEhvd2VsbCA8bWF0dGhldy5ob3dlbGxA
c2VhbGV2ZWwuY29tPg0KUmV2aWV3ZWQtYnk6IEFuZHkgU2hldmNoZW5rbyA8YW5kcml5LnNoZXZj
aGVua29AbGludXguaW50ZWwuY29tPg0KLS0tDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy90dHkvc2Vy
aWFsLzgyNTAvODI1MF9leGFyLmMgYi9kcml2ZXJzL3R0eS9zZXJpYWwvODI1MC84MjUwX2V4YXIu
Yw0KaW5kZXggMDc3YzNiYTM1MzllLi4zODg2Zjc4ZWNiYmYgMTAwNjQ0DQotLS0gYS9kcml2ZXJz
L3R0eS9zZXJpYWwvODI1MC84MjUwX2V4YXIuYw0KKysrIGIvZHJpdmVycy90dHkvc2VyaWFsLzgy
NTAvODI1MF9leGFyLmMNCkBAIC00NywxMiArNDcsNiBAQA0KICNkZWZpbmUgUENJX1NVQkRFVklD
RV9JRF9VU1JfMjk4MAkJMHgwMTI4DQogI2RlZmluZSBQQ0lfU1VCREVWSUNFX0lEX1VTUl8yOTgx
CQkweDAxMjkNCg0KLSNkZWZpbmUgUENJX0RFVklDRV9JRF9TRUFMRVZFTF83MTB4QwkJMHgxMDAx
DQotI2RlZmluZSBQQ0lfREVWSUNFX0lEX1NFQUxFVkVMXzcyMHhDCQkweDEwMDINCi0jZGVmaW5l
IFBDSV9ERVZJQ0VfSURfU0VBTEVWRUxfNzQweEMJCTB4MTAwNA0KLSNkZWZpbmUgUENJX0RFVklD
RV9JRF9TRUFMRVZFTF83ODB4QwkJMHgxMDA4DQotI2RlZmluZSBQQ0lfREVWSUNFX0lEX1NFQUxF
VkVMXzcxNnhDCQkweDEwMTANCi0NCiAjZGVmaW5lIFVBUlRfRVhBUl9JTlQwCQkweDgwDQogI2Rl
ZmluZSBVQVJUX0VYQVJfOFhNT0RFCTB4ODgJLyogOFggc2FtcGxpbmcgcmF0ZSBzZWxlY3QgKi8N
CiAjZGVmaW5lIFVBUlRfRVhBUl9TTEVFUAkJMHg4YgkvKiBTbGVlcCBtb2RlICovDQpAQCAtNjUy
LDggKzY0Niw2IEBAIGV4YXJfcGNpX3Byb2JlKHN0cnVjdCBwY2lfZGV2ICpwY2lkZXYsIGNvbnN0
IHN0cnVjdCBwY2lfZGV2aWNlX2lkICplbnQpDQogCQlucl9wb3J0cyA9IEJJVCgoKHBjaWRldi0+
ZGV2aWNlICYgMHgzOCkgPj4gMykgLSAxKTsNCiAJZWxzZSBpZiAoYm9hcmQtPm51bV9wb3J0cykN
CiAJCW5yX3BvcnRzID0gYm9hcmQtPm51bV9wb3J0czsNCi0JZWxzZSBpZiAocGNpZGV2LT52ZW5k
b3IgPT0gUENJX1ZFTkRPUl9JRF9TRUFMRVZFTCkNCi0JCW5yX3BvcnRzID0gcGNpZGV2LT5kZXZp
Y2UgJiAweGZmOw0KIAllbHNlDQogCQlucl9wb3J0cyA9IHBjaWRldi0+ZGV2aWNlICYgMHgwZjsN
Cg0KQEAgLTg5MywxMiArODg1LDYgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBwY2lfZGV2aWNlX2lk
IGV4YXJfcGNpX3RibFtdID0gew0KIAlFWEFSX0RFVklDRShDT01NVEVDSCwgNDIyNFBDSTMzNSwg
cGJuX2Zhc3Rjb20zMzVfNCksDQogCUVYQVJfREVWSUNFKENPTU1URUNILCAyMzI0UENJMzM1LCBw
Ym5fZmFzdGNvbTMzNV80KSwNCiAJRVhBUl9ERVZJQ0UoQ09NTVRFQ0gsIDIzMjhQQ0kzMzUsIHBi
bl9mYXN0Y29tMzM1XzgpLA0KLQ0KLQlFWEFSX0RFVklDRShTRUFMRVZFTCwgNzEweEMsIHBibl9l
eGFyX1hSMTdWMzV4KSwNCi0JRVhBUl9ERVZJQ0UoU0VBTEVWRUwsIDcyMHhDLCBwYm5fZXhhcl9Y
UjE3VjM1eCksDQotCUVYQVJfREVWSUNFKFNFQUxFVkVMLCA3NDB4QywgcGJuX2V4YXJfWFIxN1Yz
NXgpLA0KLQlFWEFSX0RFVklDRShTRUFMRVZFTCwgNzgweEMsIHBibl9leGFyX1hSMTdWMzV4KSwN
Ci0JRVhBUl9ERVZJQ0UoU0VBTEVWRUwsIDcxNnhDLCBwYm5fZXhhcl9YUjE3VjM1eCksDQogCXsg
MCwgfQ0KIH07DQogTU9EVUxFX0RFVklDRV9UQUJMRShwY2ksIGV4YXJfcGNpX3RibCk7DQoNCg==
