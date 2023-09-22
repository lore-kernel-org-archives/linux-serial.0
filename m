Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6355E6FE36
	for <linux-serial@archiver.kernel.org>; Fri, 22 Sep 2023 14:22:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234195AbjIVOWY (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 22 Sep 2023 10:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233368AbjIVOWX (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 22 Sep 2023 10:22:23 -0400
Received: from CY4PR02CU008.outbound.protection.outlook.com (mail-westcentralusazon11012008.outbound.protection.outlook.com [40.93.200.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA594AB
        for <linux-serial@vger.kernel.org>; Fri, 22 Sep 2023 07:22:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fT0Fmg1rdq/viz6XdmKmgODboZx4RxbKDhbUlRmBlT2DBUREU+MYaLnwWdShe/qBQJFq99K/6W7Pk4bv9l/MwrFpSg5AFt7Oqvq35+DWJcOmuDR6Oy7IuhRRrZQwzF3I46GKbvIm+RsDZwW9MDQr/7F5l/Jni1hrNnW92+MkHO2R4VuKjf5IV8E7EYGnsMODLqAQOtq8yt1PGWyvNXiwZcfXMzXwrpZb9R0kaOJjU2DHTyNiQ1JixIdYr2atHfj7DyLELFWpT/7sSqDnMy/SeWwFC3TDg8SDQZfbmcEiGZDk23jEhHbEde6vXpyyZujHhQr+p+zNHW2oJATxlZdNog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cfzMNb1Zroy+Y+aS/m2yi3bww5l6csoQDSoguqiXWR0=;
 b=YFAxkhN0eOlz+TjjmW5EzBmSiSlxh/rKxutHFuZGh9UYopccc9LQ+A1VFEAxhlWyf5z068aEuoBOxJVlo7qJKLYcq3eBzsFRltx6rtGMYs33cXvaO7Jo7hX+dhLAW3uH6xrxjPg+VE5y9wVLWDFEEzeQLiKrslihc48tVYoZVvRxp8JUrKIO0VhO+AThy0/VufSqIWsJDxhtMWm855cV9UR02yhAaHkozS0I6nIIJtUK+wrYNHljm5TbqmQ7I4zMDbdDV4keC34ya5V8aC1MZGaq6MrHYDAxyIHMVNpBXx1KOoX8wA1Axz95meH91n4ztRFPKGVAf19Vm3hANnRVJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sealevel.com; dmarc=pass action=none header.from=sealevel.com;
 dkim=pass header.d=sealevel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sealevel.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cfzMNb1Zroy+Y+aS/m2yi3bww5l6csoQDSoguqiXWR0=;
 b=JLPG7QTUWVYD4YxDgVFcGKEAZf+UmTIT/g7m5uKEuV77BwDie7urdwojprxAwsYFgqNUwE7mSGggEGHzZDUVaw+eTOq4IVw6ddGnPLkSsdofSTiBe4wABVcXcqcElKpoU9PSwaoqU0pXXpWaaStQkOcFvIBAWGrPc2tdG90/WVfLOUavIm4aV4r8g9OvJaHQCyHGHS9FPF0F5ztLharTl4I6KqxqlyGjHznDrIXpupTysP4m2uQOWFGj3UMCmyWxqO3JN2hc6Q5yzmXiARTyq6KqRzprqYlvCnqn8jGyjvNujEjstAdaRHpuAKz0J6M4xs3j0uKGCJVem/YfL05BVQ==
Received: from BY3PR05MB8419.namprd05.prod.outlook.com (2603:10b6:a03:3c6::10)
 by BL3PR05MB9236.namprd05.prod.outlook.com (2603:10b6:208:38c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Fri, 22 Sep
 2023 14:22:13 +0000
Received: from BY3PR05MB8419.namprd05.prod.outlook.com
 ([fe80::f4e4:1bc5:23f6:c9d4]) by BY3PR05MB8419.namprd05.prod.outlook.com
 ([fe80::f4e4:1bc5:23f6:c9d4%3]) with mapi id 15.20.6813.017; Fri, 22 Sep 2023
 14:22:11 +0000
From:   Matthew Howell <matthew.howell@sealevel.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        Darren Beeson <darren.beeson@sealevel.com>,
        "andriy.shevchenko@intel.com" <andriy.shevchenko@intel.com>,
        Jeff Baldwin <jeff.baldwin@sealevel.com>,
        "ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
        Ryan Wenglarz <ryan.wenglarz@sealevel.com>,
        James Olson <james.olson@sealevel.com>
Subject: [PATCH V8 2/2] serial: exar: Add RS-485 support for Sealevel XR17V35X
 based cards
Thread-Topic: [PATCH V8 2/2] serial: exar: Add RS-485 support for Sealevel
 XR17V35X based cards
Thread-Index: AQHZ7WAtWot3rpLtukS7TUxTtMVPmQ==
Date:   Fri, 22 Sep 2023 14:22:11 +0000
Message-ID: <4c6c4e3212a929822ec6a8ba09691b465541f648.camel@sealevel.com>
References: <7f7016dbad5eb0770bf4653dcc87ae0f8963bf44.camel@sealevel.com>
In-Reply-To: <7f7016dbad5eb0770bf4653dcc87ae0f8963bf44.camel@sealevel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sealevel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR05MB8419:EE_|BL3PR05MB9236:EE_
x-ms-office365-filtering-correlation-id: c56ed071-3996-44a7-ff9f-08dbbb774fe1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Vp+sdaHFgl6lAl8GwWYuAxpMupFTS/edu5k6KALrIT2wODGueGmmNHRHn5xP6gTOe6cttdQjHQE0HlNN7J9t9MsKg7rVugXP61DL04L50fsZaF872cVx8WOxM/fH7QPZJxB8kxfOaE9s1w5HDyvBd49U8W/1p6Hwg3/VaLQ66gwS/iwLlQBlSIXCPe4bSb9D0Qr5m8Xth/w4V2b1GMTsY2k/6TS3Lp4m3wF+Ot9jycIVsG0FoC2seiao8JlIK6fq8E/4i6gQjLsvQUURaydQqeADUSH6dmaFQHKwK478t8OkS8X9s8+zzDA8iNFPvzCbdsMM1RhfcVRPvshvFcZ7+hZr3xm0WAv7WJSEvlXrnTbUdcAG21raNlnVPfP4XpBGvO1muYQKxoxzbuNrCTl9feVDAcgX44Ch4YA8I3KRJAd2PHsFLco81veLTmG40+tB5qwmMRunn/l21vhO3IdRZUNFdEz6XcFBEDmAZlkw3xtnyxOY42gE3LAjJfTLrWnxxPp2FjzWw/FZFON17eeIYNoQh3A3JjXU0Ju62PmQgA0P4FkYNU7wWUDpzlW8yo3omUdydb5PrAUdzKfSD+8iZCIfm8AHeOZ5qdEGwqi5gseWX0bio5UHKGWCI5/kPNmE85hxnFkACVUXysElLEEThE8P45T9LyVJ0AxC3F8kp6U=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8419.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(376002)(366004)(396003)(346002)(136003)(1800799009)(186009)(451199024)(2906002)(38100700002)(83380400001)(38070700005)(6512007)(107886003)(6486002)(36756003)(86362001)(2616005)(71200400001)(478600001)(26005)(6506007)(8936002)(4326008)(8676002)(41300700001)(5660300002)(44832011)(66476007)(316002)(122000001)(6916009)(76116006)(66946007)(66556008)(54906003)(66446008)(64756008)(91956017);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UWtNRlVhZUxNWUthQWZTdGN1Um9XQ3dmZW0xSVlYWEl4UnE2cU1QUUxjWHJu?=
 =?utf-8?B?Z1V4NG5TdGtCVmJtWTVoVHJqdzlSRldmQ1NzMjlIODdtNDIwem4wUWJXeXFC?=
 =?utf-8?B?dzBVS0duMzhPd2h5NDZ5YW9oRFh2T3J0amtwWEpNQTJsenBjRXFiMmdhYlp4?=
 =?utf-8?B?MzFaWUZOY2lKNXdlNnRkZnRWN3N1QTQ2OHJSZS9Zb3BLbXF1WkY5VkJHN0E1?=
 =?utf-8?B?QzdWVlpDajEyK2kwc1RkeURlamRheTZ1cDJiaUE0a0U0S3h1b1RGc09ITlBS?=
 =?utf-8?B?eks2dVJSdEFKYkpzbGxEVE5XVkFPRk16eUZXbFU0YUNDakVkRFdtNmJVYkdy?=
 =?utf-8?B?VTdNRjJvQWZzSElRVUZwR1QvTE4wN2xBdGUvMXZGRHU1SmxHYmRqRXhudTlx?=
 =?utf-8?B?RnRZMEp5aHpTNlJydXhMS3lSaDc5NXhhNEJPNkh2Q1d3dHZFNjN6allVTlY4?=
 =?utf-8?B?WExtQXl2S3ZZN2puaUpaQk54cCtsQkxmYWRUVlpHMDkzQmwxdUNWSkNhdzh6?=
 =?utf-8?B?QkdnbDNobWRhVzhySXFZZnhJZzZadFhTUWpHd2djTzBhSkJCK0xPRFYydHhH?=
 =?utf-8?B?K3FsdjNydVRWMkxKcVZ6QnA5M0hTN0pUZzJRQ2laVWJUWDNwZkRaUSs0UjdI?=
 =?utf-8?B?cGdxQXdxcE13Q3FvdWJKd0xXQ3ZNNkJIRUpTWWdTV2ZYek9xbG81cUp4KzFw?=
 =?utf-8?B?Nlg4a0VKVEpIUWV0TGRnYTIrMThFMVNOMm9VdkhPOWczSWoyd2NCZkk0MXY0?=
 =?utf-8?B?MjdONk1hbC9Ob2NiT3BKZmhOYjQwM09LYXl3dEhabTVtaVgzQmhaS0xFTmpQ?=
 =?utf-8?B?Um5CaDNzRHFGak5rWWdRQzhrdFF4eTBIajJoVEFqMTVSVGVpU2Rnd1h4Sm5i?=
 =?utf-8?B?VU01TGdMV1ZYbGVSTHdjbXdaZFhVcmFuREJ2bXZLRlBqdjF3V2g4SW53OUVN?=
 =?utf-8?B?RHJuVTF6RU1TRUo2TWtTd0FpNFA4MGhxcHd6OHdFSDQzYVFJSUhFVjlUUE11?=
 =?utf-8?B?em5sNGgzQTNZQVNDejZ0R2Z6MEg3M0VKVlBJS3RiYWtHWDd0bjU4TGNGdEs0?=
 =?utf-8?B?Y0dORWFpTmpFL0lOUHdqdGpUelgrNzc2Y0ErVnFUaDVSbVRJVDdKNGtENXBB?=
 =?utf-8?B?VXBnQU5KeFpsU0ZJQ1NUcWhyc241b2NSWEFDVy80WHZESGltaFNHUFpNWWpw?=
 =?utf-8?B?bXJaamJTMGtzVjNtRUcyZjJlYWl1UFBEVHlaM0tnZllBMm9iWFRDeXJrU2hV?=
 =?utf-8?B?RU0yOWpFTitLbE04YjJEcmQ2cmVvM1FyL25va1hBeDhNekczRHN5ODFscm54?=
 =?utf-8?B?bjJrZkN3NnlTb01XYk9LeXc5d3VEN0JNRFBMVXZVZ2tNUnJVdUdHellUSXhW?=
 =?utf-8?B?ODJQZjhaREdnazJ4QWZaUXdLc2orenBkTWhKWllYZzhrRW9CaUZVSW1lZUZ5?=
 =?utf-8?B?bCtZR05OYW02Q0lpQVRGQ01LQVp2L0ZncEhKVFBLTjIwd0FkcjZ0ZmoyQVhl?=
 =?utf-8?B?M1FNOWN1cXo2MS9ZSkJ6SzBBdlJTTnMxLzV3ZllSOFVzWnovL1ViRkNZTU9T?=
 =?utf-8?B?MUxVS3lLWTlESExZUXBGbUJNS0h6QTVSZnlPb2lkMWlzNFQrYVJWeGJwdHp3?=
 =?utf-8?B?VEFUbnBhNGhzQUR0alZ4OTlLSU1aZXZHMUJYQzZmMUE1QytOMmxFMXNVN0Iz?=
 =?utf-8?B?YnM1c3FLYktEbjdBaVlqNHhETFdKeEhhYUxiY3Z1Z2hLN3dBSFc4ZVNDWkxP?=
 =?utf-8?B?RjBuNzlwOFdoWWZ5ZXoxT1BuYXhPeS9DdGZ0NmlTV0ttbE9VZ09HeVZyT0hv?=
 =?utf-8?B?RWduY1hQZTk1V012WDEremxyc1pUT0d3NmdyVEFqd0Q4SFlSbFN1emtNNkNX?=
 =?utf-8?B?clJHTWNPRU01RzdrcXpSaURrUFFOSjIyc0twaWMwS2p5bGFRTS9nY0RKSDNP?=
 =?utf-8?B?aG12Z1BmaFlBNjdnZlZ4YXBDSFBFQS90ekNOQjlzSis5dUk0MC9UMlg1RGxn?=
 =?utf-8?B?V2FlNE9XcXE0QmQvUE13WFl1ZXhYaTNrZWdWd1RNbVE5RmFudDFDc2pqUXFu?=
 =?utf-8?B?RGtiZytzVGpCaEROWDl3NzVRd1dtK2tHYnZxZzA1MEpKTVBGbWNveGVLZ3Rj?=
 =?utf-8?B?aktQRTdieHJleU9GVXcyOS9lR0VGYVhydkM0Mm9oUkdEdzB0UlV2bTBSclpq?=
 =?utf-8?B?QXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2491154DCFFF0943B68811CE3589D8F0@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sealevel.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8419.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c56ed071-3996-44a7-ff9f-08dbbb774fe1
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2023 14:22:11.8662
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e34c5615-b4e3-481c-abc8-602581f2e735
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vluasZKFcMmuisWSB5JWlqq7qfzDjGN2LM0JdJu+eRRvCRRZDjMtSKLApGSqrXSP00NFcxQKVWqdWngUVIqtBu07XwJ8Vu/2xzkGwUjyuJ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR05MB9236
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

RnJvbTogTWF0dGhldyBIb3dlbGwgPG1hdHRoZXcuaG93ZWxsQHNlYWxldmVsLmNvbT4NCg0KU2Vh
bGV2ZWwgWFIxN1YzNVggYmFzZWQgY2FyZHMgdXRpbGl6ZSBEVFIgdG8gY29udHJvbCBSUy00ODUg
RW5hYmxlLCBidXQNCnRoZSBjdXJyZW50IGltcGxlbWVudGF0aW9uIG9mIDgyNTBfZXhhciB1c2Vz
IFJUUyBmb3IgdGhlIGF1dG8tUlM0ODUtRW5hYmxlDQptb2RlIG9mIHRoZSBYUjE3VjM1WCBVQVJU
cy4gVGhpcyBwYXRjaCBpbXBsZW1lbnRzIERUUiBBdXRvLVJTNDg1IG9uDQpTZWFsZXZlbCBjYXJk
cy4NCg0KU2lnbmVkLW9mZi1ieTogTWF0dGhldyBIb3dlbGwgPG1hdHRoZXcuaG93ZWxsQHNlYWxl
dmVsLmNvbT4NClJldmlld2VkLWJ5OiBBbmR5IFNoZXZjaGVua28gPGFuZHJpeS5zaGV2Y2hlbmtv
QGxpbnV4LmludGVsLmNvbT4NCi0tLQ0KVjctPlY4DQpBZGRlZCBzcGFjZSB0byBhbGlnbiB0ZXh0
IGluIHNlYWxldmVsX3JzNDg1X2NvbmZpZygpDQpSZW1vdmVkIHVubmVlZGVkIGVtcHR5IGxpbmUu
DQpTd2l0Y2hlZCBlbWFpbCBjbGllbnRzLiBOZXcgY2xpZW50IHdhcyBhZGRpbmcgdGhlIGluLXJl
cGx5LXRvIA0KaGVhZGVyIGluIHRlc3Rpbmcgc28gaG9wZWZ1bGx5IHRocmVhZGluZyBhY3R1YWxs
eSB3b3JrcyB0aGlzIHRpbWUuDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3R0eS9zZXJpYWwvODI1
MC84MjUwX2V4YXIuYyBiL2RyaXZlcnMvdHR5L3NlcmlhbC84MjUwLzgyNTBfZXhhci5jDQppbmRl
eCAzODg2Zjc4ZWNiYmYuLjhhYjgwNDQ3ZmU4YyAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvdHR5L3Nl
cmlhbC84MjUwLzgyNTBfZXhhci5jDQorKysgYi9kcml2ZXJzL3R0eS9zZXJpYWwvODI1MC84MjUw
X2V4YXIuYw0KQEAgLTc4LDYgKzc4LDkgQEANCg0KICNkZWZpbmUgVUFSVF9FWEFSX1JTNDg1X0RM
WSh4KQkoKHgpIDw8IDQpDQoNCisjZGVmaW5lIFVBUlRfRVhBUl9ETEQJCQkweDAyIC8qIERpdmlz
b3IgRnJhY3Rpb25hbCAqLw0KKyNkZWZpbmUgVUFSVF9FWEFSX0RMRF80ODVfUE9MQVJJVFkJMHg4
MCAvKiBSUy00ODUgRW5hYmxlIFNpZ25hbCBQb2xhcml0eSAqLw0KKw0KIC8qDQogICogSU9UMjA0
MCBNUElPIHdpcmluZyBzZW1hbnRpY3M6DQogICoNCkBAIC00MzksNiArNDQyLDQ0IEBAIHN0YXRp
YyBpbnQgZ2VuZXJpY19yczQ4NV9jb25maWcoc3RydWN0IHVhcnRfcG9ydCAqcG9ydCwgc3RydWN0
IGt0ZXJtaW9zICp0ZXJtaW9zDQogCXJldHVybiAwOw0KIH0NCg0KK3N0YXRpYyBpbnQgc2VhbGV2
ZWxfcnM0ODVfY29uZmlnKHN0cnVjdCB1YXJ0X3BvcnQgKnBvcnQsIHN0cnVjdCBrdGVybWlvcyAq
dGVybWlvcywNCisJCQkJIHN0cnVjdCBzZXJpYWxfcnM0ODUgKnJzNDg1KQ0KK3sNCisJdTggX19p
b21lbSAqcCA9IHBvcnQtPm1lbWJhc2U7DQorCXU4IG9sZF9sY3I7DQorCXU4IGVmcjsNCisJdTgg
ZGxkOw0KKwlpbnQgcmV0Ow0KKw0KKwlyZXQgPSBnZW5lcmljX3JzNDg1X2NvbmZpZyhwb3J0LCB0
ZXJtaW9zLCByczQ4NSk7DQorCWlmIChyZXQpDQorCQlyZXR1cm4gcmV0Ow0KKw0KKwlpZiAocnM0
ODUtPmZsYWdzICYgU0VSX1JTNDg1X0VOQUJMRUQpIHsNCisJCW9sZF9sY3IgPSByZWFkYihwICsg
VUFSVF9MQ1IpOw0KKw0KKwkJLyogU2V0IEVGUls0XT0xIHRvIGVuYWJsZSBlbmhhbmNlZCBmZWF0
dXJlIHJlZ2lzdGVycyAqLw0KKwkJZWZyID0gcmVhZGIocCArIFVBUlRfWFJfRUZSKTsNCisJCWVm
ciB8PSBVQVJUX0VGUl9FQ0I7DQorCQl3cml0ZWIoZWZyLCBwICsgVUFSVF9YUl9FRlIpOw0KKw0K
KwkJLyogU2V0IE1DUiB0byB1c2UgRFRSIGFzIEF1dG8tUlM0ODUgRW5hYmxlIHNpZ25hbCAqLw0K
KwkJd3JpdGViKFVBUlRfTUNSX09VVDEsIHAgKyBVQVJUX01DUik7DQorDQorCQkvKiBTZXQgTENS
WzddPTEgdG8gZW5hYmxlIGFjY2VzcyB0byBETEQgcmVnaXN0ZXIgKi8NCisJCXdyaXRlYihvbGRf
bGNyIHwgVUFSVF9MQ1JfRExBQiwgcCArIFVBUlRfTENSKTsNCisNCisJCS8qIFNldCBETERbN109
MSBmb3IgaW52ZXJ0ZWQgUlM0ODUgRW5hYmxlIGxvZ2ljICovDQorCQlkbGQgPSByZWFkYihwICsg
VUFSVF9FWEFSX0RMRCk7DQorCQlkbGQgfD0gVUFSVF9FWEFSX0RMRF80ODVfUE9MQVJJVFk7DQor
CQl3cml0ZWIoZGxkLCBwICsgVUFSVF9FWEFSX0RMRCk7DQorDQorCQl3cml0ZWIob2xkX2xjciwg
cCArIFVBUlRfTENSKTsNCisJfQ0KKw0KKwlyZXR1cm4gMDsNCit9DQorDQogc3RhdGljIGNvbnN0
IHN0cnVjdCBzZXJpYWxfcnM0ODUgZ2VuZXJpY19yczQ4NV9zdXBwb3J0ZWQgPSB7DQogCS5mbGFn
cyA9IFNFUl9SUzQ4NV9FTkFCTEVELA0KIH07DQpAQCAtNzQ0LDYgKzc4NSwyMCBAQCBzdGF0aWMg
aW50IF9fbWF5YmVfdW51c2VkIGV4YXJfcmVzdW1lKHN0cnVjdCBkZXZpY2UgKmRldikNCiAJcmV0
dXJuIDA7DQogfQ0KDQorc3RhdGljIGludCBwY2lfc2VhbGV2ZWxfc2V0dXAoc3RydWN0IGV4YXI4
MjUwICpwcml2LCBzdHJ1Y3QgcGNpX2RldiAqcGNpZGV2LA0KKwkJICAgc3RydWN0IHVhcnRfODI1
MF9wb3J0ICpwb3J0LCBpbnQgaWR4KQ0KK3sNCisJaW50IHJldDsNCisNCisJcmV0ID0gcGNpX3hy
MTd2MzV4X3NldHVwKHByaXYsIHBjaWRldiwgcG9ydCwgaWR4KTsNCisJaWYgKHJldCkNCisJCXJl
dHVybiByZXQ7DQorDQorCXBvcnQtPnBvcnQucnM0ODVfY29uZmlnID0gc2VhbGV2ZWxfcnM0ODVf
Y29uZmlnOw0KKw0KKwlyZXR1cm4gMDsNCit9DQorDQogc3RhdGljIFNJTVBMRV9ERVZfUE1fT1BT
KGV4YXJfcGNpX3BtLCBleGFyX3N1c3BlbmQsIGV4YXJfcmVzdW1lKTsNCg0KIHN0YXRpYyBjb25z
dCBzdHJ1Y3QgZXhhcjgyNTBfYm9hcmQgcGJuX2Zhc3Rjb20zMzVfMiA9IHsNCkBAIC04MDksNiAr
ODY0LDE3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZXhhcjgyNTBfYm9hcmQgcGJuX2V4YXJfWFIx
N1Y4MzU4ID0gew0KIAkuZXhpdAkJPSBwY2lfeHIxN3YzNXhfZXhpdCwNCiB9Ow0KDQorc3RhdGlj
IGNvbnN0IHN0cnVjdCBleGFyODI1MF9ib2FyZCBwYm5fc2VhbGV2ZWwgPSB7DQorCS5zZXR1cAkJ
PSBwY2lfc2VhbGV2ZWxfc2V0dXAsDQorCS5leGl0CQk9IHBjaV94cjE3djM1eF9leGl0LA0KK307
DQorDQorc3RhdGljIGNvbnN0IHN0cnVjdCBleGFyODI1MF9ib2FyZCBwYm5fc2VhbGV2ZWxfMTYg
PSB7DQorCS5udW1fcG9ydHMJPSAxNiwNCisJLnNldHVwCQk9IHBjaV9zZWFsZXZlbF9zZXR1cCwN
CisJLmV4aXQJCT0gcGNpX3hyMTd2MzV4X2V4aXQsDQorfTsNCisNCiAjZGVmaW5lIENPTk5FQ1Rf
REVWSUNFKGRldmlkLCBzZGV2aWQsIGJkKSB7CQkJCVwNCiAJUENJX0RFVklDRV9TVUIoCQkJCQkJ
CVwNCiAJCVBDSV9WRU5ET1JfSURfRVhBUiwJCQkJCVwNCkBAIC04MzgsNiArOTA0LDE1IEBAIHN0
YXRpYyBjb25zdCBzdHJ1Y3QgZXhhcjgyNTBfYm9hcmQgcGJuX2V4YXJfWFIxN1Y4MzU4ID0gew0K
IAkJKGtlcm5lbF91bG9uZ190KSZiZAkJCVwNCiAJfQ0KDQorI2RlZmluZSBTRUFMRVZFTF9ERVZJ
Q0UoZGV2aWQsIGJkKSB7CQkJXA0KKwlQQ0lfREVWSUNFX1NVQigJCQkJCVwNCisJCVBDSV9WRU5E
T1JfSURfRVhBUiwJCQlcDQorCQlQQ0lfREVWSUNFX0lEX0VYQVJfIyNkZXZpZCwJCVwNCisJCVBD
SV9WRU5ET1JfSURfU0VBTEVWRUwsCQkJXA0KKwkJUENJX0FOWV9JRCksIDAsIDAsCQkJXA0KKwkJ
KGtlcm5lbF91bG9uZ190KSZiZAkJCVwNCisJfQ0KKw0KIHN0YXRpYyBjb25zdCBzdHJ1Y3QgcGNp
X2RldmljZV9pZCBleGFyX3BjaV90YmxbXSA9IHsNCiAJRVhBUl9ERVZJQ0UoQUNDRVNTSU8sIENP
TV8yUywgcGJuX2V4YXJfWFIxN0MxNXgpLA0KIAlFWEFSX0RFVklDRShBQ0NFU1NJTywgQ09NXzRT
LCBwYm5fZXhhcl9YUjE3QzE1eCksDQpAQCAtODYwLDYgKzkzNSwxMiBAQCBzdGF0aWMgY29uc3Qg
c3RydWN0IHBjaV9kZXZpY2VfaWQgZXhhcl9wY2lfdGJsW10gPSB7DQogCUNPTk5FQ1RfREVWSUNF
KFhSMTdDMTU0LCBVQVJUXzRfNDg1LCBwYm5fY29ubmVjdCksDQogCUNPTk5FQ1RfREVWSUNFKFhS
MTdDMTU4LCBVQVJUXzhfNDg1LCBwYm5fY29ubmVjdCksDQoNCisJU0VBTEVWRUxfREVWSUNFKFhS
MTdWMzUyLCBwYm5fc2VhbGV2ZWwpLA0KKwlTRUFMRVZFTF9ERVZJQ0UoWFIxN1YzNTQsIHBibl9z
ZWFsZXZlbCksDQorCVNFQUxFVkVMX0RFVklDRShYUjE3VjM1OCwgcGJuX3NlYWxldmVsKSwNCisJ
U0VBTEVWRUxfREVWSUNFKFhSMTdWNDM1OCwgcGJuX3NlYWxldmVsXzE2KSwNCisJU0VBTEVWRUxf
REVWSUNFKFhSMTdWODM1OCwgcGJuX3NlYWxldmVsXzE2KSwNCisNCiAJSUJNX0RFVklDRShYUjE3
QzE1MiwgU0FUVVJOX1NFUklBTF9PTkVfUE9SVCwgcGJuX2V4YXJfaWJtX3NhdHVybiksDQoNCiAJ
LyogVVNSb2JvdGljcyBVU1IyOTh4LU9FTSBQQ0kgTW9kZW1zICovDQoNCg==
