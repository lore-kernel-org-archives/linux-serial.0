Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28AC4C433F5
	for <linux-serial@archiver.kernel.org>; Fri, 29 Apr 2022 05:28:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344774AbiD2FbX (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 29 Apr 2022 01:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbiD2FbW (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 29 Apr 2022 01:31:22 -0400
X-Greylist: delayed 303 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 28 Apr 2022 22:28:05 PDT
Received: from eu-smtp-delivery-197.mimecast.com (eu-smtp-delivery-197.mimecast.com [185.58.85.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A316C86E19
        for <linux-serial@vger.kernel.org>; Thu, 28 Apr 2022 22:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=camlingroup.com;
        s=mimecast20210310; t=1651210083;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U489bEd+21BxSPAUoiH7jQeOZz2cwQXUybCRjEkCng0=;
        b=W4GI3SYdwOE78YPIlDUDwMXZpTTZr7DDN6cUgyY3WetA8N5XVxa2/e7PZ74OE2XNBR+PBq
        oNn+j07h0aTtObcUxRSyjnLKaYL4AUKoemh2jFcHxzwmuDfM9JR4YITtLR14Q6pg++x8u7
        N9Mm+R8a94Igsn1Y8kphz29leLSb5Ik=
Received: from GBR01-LO2-obe.outbound.protection.outlook.com
 (mail-lo2gbr01lp2050.outbound.protection.outlook.com [104.47.21.50]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 uk-mta-287-A3VJaKepOvapRQKhhMCiVA-1; Fri, 29 Apr 2022 06:21:40 +0100
X-MC-Unique: A3VJaKepOvapRQKhhMCiVA-1
Received: from CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:16b::6)
 by CWLP123MB3811.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:91::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.12; Fri, 29 Apr
 2022 05:21:39 +0000
Received: from CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM
 ([fe80::b90c:258a:b3de:fab7]) by CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM
 ([fe80::b90c:258a:b3de:fab7%8]) with mapi id 15.20.5206.013; Fri, 29 Apr 2022
 05:21:39 +0000
From:   Tomasz Mon <tomasz.mon@camlingroup.com>
To:     "ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
        "nunojpg@gmail.com" <nunojpg@gmail.com>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        Tomasz Mon <tomasz.mon@camlingroup.com>
Subject: Re: [RFC PATCH] serial: Don't assume uart_ops .throttle is always set
Thread-Topic: [RFC PATCH] serial: Don't assume uart_ops .throttle is always
 set
Thread-Index: AQHYW4kAipVMoxcq5ECgQ2yCV0JkOA==
Date:   Fri, 29 Apr 2022 05:21:38 +0000
Message-ID: <d16634147375cbebad48b143974432e0f40f842d.camel@camlingroup.com>
References: <62859dbd-7ced-34f-55c-ce1b5f6625d@linux.intel.com>
In-Reply-To: <62859dbd-7ced-34f-55c-ce1b5f6625d@linux.intel.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 79c63db6-551b-4918-e6e2-08da29a02351
x-ms-traffictypediagnostic: CWLP123MB3811:EE_
x-microsoft-antispam-prvs: <CWLP123MB3811B0472F3B14946E84402E92FC9@CWLP123MB3811.GBRP123.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: AAQW2NG8R2TMAIbcpRn2UJz0MjvZGsGvVgOpcnAm0dp9ypGa9riYBKsb/a4uWZUn2Y9mmN2bOxqjLkz6ILDuGlY/+8J/gDtMlwVfweFsP/1Df/CHbWEGiuJcYOo/JSgnnrbjf33ekVAP8kxnUsG62zsFBfMSxrKxZWfaAoYSISiybmXePPUxodD9hkRKSHnDUgtKNBLNN2MBJ7xRLNKQPSDRCuCLTqnoOELgY3r7DfHRI66TCjWtiJfpLYDznJn3VTm5X2WBHy54l8q50C8GqX3vLEP1ktaBI8vww3dH6PwhlVr2pKN6MGOycZSp/ad3I0ktKXiA5coEaspri2S82tUWzVGDPod47nNZwnvhnFpMJkONyBhMBiPAMVH3mmIO4ezjnk/wHePKLXESJiklMc5eCTLffO6Zpjz6hoIRJlCcWCB9hhDDhG+EWTAy6Nj8SL6EFbx2XERSz7eutfzIVqPSIZNvxPSP4tB78UwShmpRanqzcuAmaV/TnIvFnW+LekCpbsR+M/J5alTjl2pGcabY4ZCd9VD94HxAm5+Ql2U4tVKQOdgQbXbv9FCxJiyRw784rYndonviXQrbidK0iS4jnQFXxWNyLXlu2FQGPqWVuD6Ix+46f4R87lIlI+QefGHcGQipXX6sqqFmL8hZWJ3BnZoOmJfPPv2kSHppQsCT7E5bbnHr5cOHG7qZqBYoQS6PAB7Zf0yasO735WVdnwxMHxBPe+mFI7y1/qsKfus=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(54906003)(110136005)(6506007)(107886003)(186003)(4326008)(66476007)(8676002)(66446008)(66556008)(64756008)(76116006)(66946007)(5660300002)(91956017)(44832011)(86362001)(38070700005)(38100700002)(36756003)(2906002)(6486002)(26005)(6512007)(316002)(71200400001)(122000001)(8936002)(508600001)(142923001);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d0pmbGRoWnNRV2xIVjJDMjEzNUJwbWpma0hORDFnVWxrM1JOZm9hWTFteU5h?=
 =?utf-8?B?b0pmT04wa24vZEJZa29zRVg1Qi9tdUkwRk92MlFwNlFHR3k0M0xZaVB4Zytu?=
 =?utf-8?B?bVZ2dGtlaVR5TkhXY3lsYWdzaXEwcnVuVGFJZlRYSkt4NmhXNjg0dXV0Rlhv?=
 =?utf-8?B?c0VvcmZoRnh6d3NyTTNDV1ZOTXZCK0I0TWI2WU8wSGdXYk5xT2NKQnJqaHd6?=
 =?utf-8?B?OFB1aHFRTm9tUDc4UXRITnRwMXRqUUVBQTR1b1BOcDc2bk5UNXFWWVNOZ2xp?=
 =?utf-8?B?SHdqYlVtb05BdXVLQjRQNHgyVW83VzgyZkxtM2ZNMko0YTVqQmdaYnJTNXFS?=
 =?utf-8?B?ZlVvQSt2VTFRa3NIdzdHbzRjRDZTMDJISXpNUWZtQjBtUi9aeDFCSGlPL0k5?=
 =?utf-8?B?bVNoZnY3cFZLQXlzTXB4Znhudk5sM3RXa1ZESHpkYWUzWUx0a3NDRkI4bUgw?=
 =?utf-8?B?bXNoN2xSQXhvYUVQZXBPWkZqRU5UNEM4UlRUbm5ESVNRM3Z5U3JWdjMyUEww?=
 =?utf-8?B?ZThHQ1lHZHE2cnN3dG10ak55OE9NRHkxR00xbDNJZThLVjljUTNYNkl6YWZE?=
 =?utf-8?B?NVhwTFJXenZwRXpMcGY1OVg4dkVxVEh4UElmcHBwQXU0TUlaTmdnUmlDbTVp?=
 =?utf-8?B?WngwUnBuSXFyRDNjYk1RRnRSNEg2TENmWEZnQzJyNWV4UFVPR2p3ZFNHdFJm?=
 =?utf-8?B?bVRDSnE3SDltNnpmbHhZVWNPZkt0Y2F4OXBqUko5TDJhVDl5b3FUK25XSnlr?=
 =?utf-8?B?dUx0OWNabVBtN3J4cDErYmhUYjdZMDNRTzRCMVZJVmpJTmdVcys0TzZralc3?=
 =?utf-8?B?Q2lXZXFuREtBUHI5eDVlcWJqWm81cFFZMjlhUitadXlzRVZab2p1NTNzd0c5?=
 =?utf-8?B?ZUR2cmY2V21SdVQyK3dCbkdUVjNWNWw5emNwQVRWa3RIUWc3M082cDVmSFpT?=
 =?utf-8?B?QjBtdXVhVDB2K2d3aGQ3eWZyTW8ySFRBYkZ2YlV6NnkzS1ovMVlYS3hyZ2gr?=
 =?utf-8?B?aXEvbVhIK2g0OE0zTnBDd0xWQ0NvUWhHamJzaW5VOXZ5eWhBNTYzMG9XRStu?=
 =?utf-8?B?dHBMM0l5TXhqeXduWmdKZllxQ0Z4SVM4THlqTms5N0FITWxseHdIVG43b2RI?=
 =?utf-8?B?clpZUm1RRTRqRHhwdVd2R3J1Mlh5M0c1NzFNTFFrN1hkZVBiaWZJSkZjSjd5?=
 =?utf-8?B?Vm5VN1BiNWptU0o1bW5LdTNQNlBJV1RVcFJVNDYyS2lPMEl5bWlka29PY1BN?=
 =?utf-8?B?NWlnMklLbGNXRm5UU09sT3ltSHJ5djY1SVhtTmpBTzBURFZmd3JuVnZVOVlY?=
 =?utf-8?B?Wko4aFJtcldxOHpzVjJqSXZVNHlwZ2pFSkluNHl1WksxeTNqbGNCdXYxUGVC?=
 =?utf-8?B?UmpVbmpVZGhDcUsvTk94bTgwd0dkbUFGT05Md1kyUFdpOFZoVkp5U3QxOCtG?=
 =?utf-8?B?U0F5TUh3TXhna1Z1MW1tckN4MXF1UldjdWZxamdyWWhLdTNab1BZWDVBekN4?=
 =?utf-8?B?bTBBRDlYcU5yc0FrdHhZODdTZTZUbG9xZG9LOFdjdWlPbjBBNnEwdXVUMUUr?=
 =?utf-8?B?MTNzTnkvMjk1NE02VXFTaUkrODZiQUN3SEJpbCtDOTY2ajIyYUljUE5RRHZG?=
 =?utf-8?B?RGVkZnVVTnc4cXNnc0p2WThrTlhVbUt6NVRnWE1LM3ZmWEtUTHljRW42d3NT?=
 =?utf-8?B?ZU0xcnFWSU5qbWhiTXpxd1VrbEJ3cVVOMEZLRVZRdnAvdWNlbC9SMDlEUGUv?=
 =?utf-8?B?ZU83b2R4RExyRG1iRHVBdWJpdjRtTTMrRTJBSm40d1VHNmc3akVZcU1waVEr?=
 =?utf-8?B?a0NMRlZrdWxEQ1B5aEg1b0g4YWtzNFdoVVU3K1p0QTE1U1NwV3c4UEN6ZjBm?=
 =?utf-8?B?WVU4YUtWTGtSMlBSTCsvajN0WTNSd0hzNGY1cWNIWkJwd01iQlRDd01WQWNp?=
 =?utf-8?B?NXdLMk8vTU5BdXlCS2ZCUk1SMFVlcDd6MGtBUWtSSzBXRHQvUXgxTC9IS211?=
 =?utf-8?B?N0FoUlZUZjBoSmk5eTVtRjhoYlcxNTIydE8vQWp2VVVNZGkxT3daSmtjTmZi?=
 =?utf-8?B?QlREbVdUUjNiM2VkRXhoYldBRmVHZjlXOHppNlFjOXZnd1piMGNNRHd6SFpK?=
 =?utf-8?B?cTBMQlhGZHJSamlNZ0tMVWsrOWhTMDZhT3l2Qjh3ZnFYdkY2K2JEanRTdDkv?=
 =?utf-8?B?Y3djMmhxUHhxblF2ZUhCbHVoK3BzdGUycWZuWWVqUnByV3NtZFN0OFlPU2h2?=
 =?utf-8?B?UmgvNEkvektRNUNMMVJobXNXREorZ29yMDJwK01RQUZ0alRqRXg0TnZkWkox?=
 =?utf-8?B?NFpPY2UrSjRVaHZuRXY1TXU3bU5QUk9XQjU2MndiNVFDNFVPV2lCOWdzTEpW?=
 =?utf-8?Q?pozMPRJ8NqKuXjD4=3D?=
MIME-Version: 1.0
X-OriginatorOrg: camlingroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 79c63db6-551b-4918-e6e2-08da29a02351
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2022 05:21:38.9797
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fd4b1729-b18d-46d2-9ba0-2717b852b252
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QieeikxHiU2HkqbpxL9xOHHw2UsChggcoCz6NGxvmARyxt5BtasVhU7Jitm1Suz7gQWRl6vaNyKuL/PjiAsrFeDlJgZIzZQBycHvRJhdlWU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB3811
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUK97A341 smtp.mailfrom=tomasz.mon@camlingroup.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: camlingroup.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-ID: <E77ACCC6D44C8F4DB1F121A028E629AA@GBRP123.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

T24gVGh1LCAyMDIyLTA0LTI4IGF0IDIwOjExICswMzAwLCBJbHBvIErDpHJ2aW5lbiB3cm90ZToN
Cj4gdWFydF90aHJvdHRsZSgpIGFzc3VtZXMgdGhhdCBhIGRyaXZlciBwcm92aWRlcyBhIHRocm90
dGxlIGZ1bmN0aW9uIGluDQo+IHVhcnRfb3BzLiBCdXQgbm90IGFsbCBkcml2ZXJzIGRvIGFuZCB0
aGVyZSBzZWVtcyB0byBub3RoaW5nIGluDQo+IHNlcmlhbF9jb3JlIHRoYXQgd291bGQgc2V0IGl0
IGVpdGhlci4gVGh1cywgY2hlY2sgaXQgYmVmb3JlIGNhbGxpbmcuDQoNCklmIHRoZSBkcml2ZXIg
ZG9lcyBub3QgcHJvdmlkZSB0aHJvdHRsZSBmdW5jdGlvbiwgaXQgc2hvdWxkIG5vdA0Kc2V0IFVQ
U1RBVF9BVVRPUlRTIG5vciBVUFNUQVRfQVVUT1hPRkYgaW4gcG9ydC0+c3RhdHVzLg0KDQo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL3R0eS9zZXJpYWwvc2VyaWFsX2NvcmUuYw0KPiBiL2RyaXZlcnMv
dHR5L3NlcmlhbC9zZXJpYWxfY29yZS5jDQo+IGluZGV4IDZhODk2M2NhZjk1NC4uMThjOWQ0NmUw
Yjg1IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3R0eS9zZXJpYWwvc2VyaWFsX2NvcmUuYw0KPiAr
KysgYi9kcml2ZXJzL3R0eS9zZXJpYWwvc2VyaWFsX2NvcmUuYw0KPiBAQCAtNjk3LDcgKzY5Nyw4
IEBAIHN0YXRpYyB2b2lkIHVhcnRfdGhyb3R0bGUoc3RydWN0IHR0eV9zdHJ1Y3QgKnR0eSkNCj4g
IAkJbWFzayB8PSBVUFNUQVRfQVVUT1JUUzsNCj4gIA0KPiAgCWlmIChwb3J0LT5zdGF0dXMgJiBt
YXNrKSB7DQoNClRoaXMgaWYgY29uZGl0aW9uIGlzIGFsd2F5cyBmYWxzZSBpZiBkcml2ZXIgZGlk
IG5vdCBzZXQgVVBTVEFUX0FVVE9SVFMNCm5vciBVUFNUQVRfQVVUT1hPRkYgaW4gcG9ydC0+c3Rh
dHVzLg0KDQo+IC0JCXBvcnQtPm9wcy0+dGhyb3R0bGUocG9ydCk7DQo+ICsJCWlmIChwb3J0LT5v
cHMtPnRocm90dGxlKQ0KPiArCQkJcG9ydC0+b3BzLT50aHJvdHRsZShwb3J0KTsNCj4gIAkJbWFz
ayAmPSB+cG9ydC0+c3RhdHVzOw0KPiAgCX0NCj4gDQoNCkkgdGhpbmsgdGhpcyBwYXRjaCBpcyBp
bmNvcnJlY3QuIFRoZSBhc3N1bXB0aW9uIGlzIG5vdCAiLnRocm90dGxlIGlzDQphbHdheXMgc2V0
IiBidXQgcmF0aGVyICIudGhyb3R0bGUgaXMgc2V0IHdoZW4gVVBTVEFUX0FVVE9SVFMgb3INClVQ
U1RBVF9BVVRPWE9GRiBpcyBzZXQiLg0KDQpCZXN0IFJlZ2FyZHMsDQpUb21hc3ogTW9uDQo=

