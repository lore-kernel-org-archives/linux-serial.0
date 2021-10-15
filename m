Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB14C433EF
	for <linux-serial@archiver.kernel.org>; Fri, 15 Oct 2021 07:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42EF6611BD
	for <linux-serial@archiver.kernel.org>; Fri, 15 Oct 2021 07:14:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234497AbhJOHQI (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 15 Oct 2021 03:16:08 -0400
Received: from mail-eopbgr1320117.outbound.protection.outlook.com ([40.107.132.117]:24896
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232174AbhJOHQH (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 15 Oct 2021 03:16:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G3p1O7aCHYN1hOiyoj6oziDKINNWe81+CLfU6He+1dXct78T57V0McPHq1MG+jTuuoIVcuwJacB4qZ+A/tjuDEDeZNMcuJVGpKGxtRTF8MGoX06LguNLP/Tx0L/IMee/UK6prhiIJOE8KjS20NSHEL0Vd0d7cEsiRPgFCD1ktzYglGVO/pIs5rxt2ABzYQuzfyJ8LcEl8qQMJK/HgwoGr9TW3FogSA48KDP06lAfQiAs95pq9omWemxLn6xiRYx3zt7QNUm+mUT4SVDrGC+KUcPJyjyP3Qjsqws6xRJazGCDqmiBJsvAY04n5/bDiYWV6D1z4pG3WTh1wHfdLvldPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=onhTa38iZf9Ib8eaPCK3cdqwRJCrwBKzbJWmTpmz1sg=;
 b=nKWuxJNEBNDsVcSQVHBq29Ja8ECtAwWQnjeUx4E7HpiZiruLIxWPElwMITvlvT+mGOVrm9U/YgrWF5Q9VRJhNX0WAU5KupaRHtyGsTzG7hPQuidAL/IELXxQs9cIklKMFqg11YJayloim1AxFrew2HJHu0bc0Dtq9PW8sdw8GnIYODXbZGu+za+YGrKNi9IKijx2CHrPiQFSwLkRLAgzZklsNww467e0VtxfDQRvgexILG1FQOXZtDQJvyankEzV703oMaR0+OZqCf7svZHbEfLOaJd8ut/uDeTP8bdDeymSw1su7YwPZ93ZUEH5+AqFO7kJ6zbJRUV3xd7ksexwhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=onhTa38iZf9Ib8eaPCK3cdqwRJCrwBKzbJWmTpmz1sg=;
 b=d5u02pLZlo5Ng/c82CQkgMl60RsjUPe/9slFB1jilobzGehd9YcPkzvKXazXbnao/Sujf0Adlx4uOeAnuVaqItEutaSSboO+zSrL9c8srWtcdpyikMupkJAyDpc3U5XfmgLZsDjJBxTmVOSjWAfb1oLS2N7zBI/JsK+HGrEHd78=
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by SL2PR06MB3017.apcprd06.prod.outlook.com (2603:1096:100:3a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Fri, 15 Oct
 2021 07:13:58 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::4c9b:b71f:fb67:6414]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::4c9b:b71f:fb67:6414%6]) with mapi id 15.20.4608.017; Fri, 15 Oct 2021
 07:13:58 +0000
From:   =?utf-8?B?546L5pOO?= <wangqing@vivo.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Jiri Slaby <jirislaby@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?utf-8?B?5Zue5aSNOiBbUEFUQ0hdIHR0eTogODI1MDogcmVwbGFjZSBzbnByaW50ZiBp?=
 =?utf-8?Q?n_show_functions_with_sysfs=5Femit?=
Thread-Topic: [PATCH] tty: 8250: replace snprintf in show functions with
 sysfs_emit
Thread-Index: AQHXwZEVJVJmBr4nx0GWJTtwbTjYeqvToNQAgAADm8M=
Date:   Fri, 15 Oct 2021 07:13:58 +0000
Message-ID: <SL2PR06MB30828C16C885776950205E5DBDB99@SL2PR06MB3082.apcprd06.prod.outlook.com>
References: <1634280682-5002-1-git-send-email-wangqing@vivo.com>
 <AOQACwDzEi5UM3m3ezm-D4o5.9.1634281082401.Hmail.wangqing@vivo.com>
In-Reply-To: <AOQACwDzEi5UM3m3ezm-D4o5.9.1634281082401.Hmail.wangqing@vivo.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 4d1f9652-7ace-d9b8-c04f-a6948663a246
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9d73300a-f7c3-44f8-99e6-08d98fab5b98
x-ms-traffictypediagnostic: SL2PR06MB3017:
x-microsoft-antispam-prvs: <SL2PR06MB3017EBBA747C1B535F6F06BBBDB99@SL2PR06MB3017.apcprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 67fZiBvD/zGQJCbqvSRTROl0HKTKfz5JV6Zag0LCFt6nnF8zXwJ2Qztzdq8CxrKep8ORKXEDKUX9RLH+QX+oDvdd7+SiQ29Gsz7ho+JLFTIRdS2ZQb1AJb/XGSL3x35XzrmGpQnNY3rEcNXh2kTBDPXDpw7jGqdJS//zI8H/PbgLBosGzMYx4HGPdu440fbFnBsbTonNIIRl5oHsQUJt9H7Oj1SRMSWLGKNa1eAwcjvqHLGvyzhmFzb1b/x8VYywxa28xtCFUEUd2er5R/IQ2XzO5egw11HlO9Du2vNS7p79M76tp4berd2r670haDMGqZmAXsBG02zYGrB6zyET4hDphaStA2gaeOv/U07SJU6AmssVsUJ7DB/GgIBMiosAFKSi+VeRCNKM7hxRORgIDBoWP/+i0HG3lclg2BJ14HMDpfh27AvpBTDb0HxVBT8z2QoxZEQzA2xQvv/IuhOZY39WuLAi5R8+fSBE/DaSQpps0cqrqLo93PJ2PHHQnnRAyCPPrSeKAQwjxD2CLD7/mtYQzjLJa29371EYuvLBP9vx4AAJVa654uMjl+GYRXB4jSIuX9VYj/lE0P/AdPWlvp7p0HZp2Y9yLaYD7DIaTxbnGHjsXSihMSwxNXR5yr8wP9ZiVkoGOe4fnawKGzL7pRd5fv3ghn6K73Glnq/JZ/AMiQkEYeSko2LanwZTc2/NCQha6PSm4AUplIMLIhDikQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(33656002)(55016002)(186003)(6916009)(4326008)(54906003)(316002)(85182001)(38070700005)(2906002)(224303003)(26005)(76116006)(7696005)(91956017)(38100700002)(66946007)(66476007)(66556008)(64756008)(66446008)(5660300002)(83380400001)(8936002)(71200400001)(52536014)(6506007)(508600001)(9686003)(122000001)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cVpaZkhEeFd4eEFCZlp6V3JJcDJsanJDOHRrSDlFZHNWWERLZE5IV1NxdkpG?=
 =?utf-8?B?cktZOVpLZWVNeW00R095b3FoRHBibk5VZ2tIYlliSTdNS2RRbG9ESFJaM2dT?=
 =?utf-8?B?aytmZzlwQ0Jsa1FVclJTb083UzRrTFFSdU40Z0hWTW5JOHo4MDNMQTZwR055?=
 =?utf-8?B?bVBSYkdOVldDcGZVeHhEM0ZoMmFzYysvZlpWanJvdnkxUW8zc25tRmU3aVpz?=
 =?utf-8?B?ampyZmxsUlg2N2JiS0MwM2pjS2lvbFVLL2hiMjYxUXlYbmVaelBNOENNR21Q?=
 =?utf-8?B?WW5ocHdKTjZYVDFYbzk4SDRhTjNWSS9pbWtkZE9PVHlBMWdqU2lsVGxOWHpQ?=
 =?utf-8?B?QlBIU0lFZ1Q4bmprVVVVa3lKdU0zaEVyMndPZENPYjBGMnBYR3YyUmdqaVZG?=
 =?utf-8?B?Y25RdlJabFBoNmdGUGdsN3Q5S2ZXcklkSkVabUZ4eDlVcUlqbUZZQWhQdFN4?=
 =?utf-8?B?OWhlMEdsVi9XLzRsSzVaRDBSaDM1dG9BUXNZWGp2Q0Y0Ym0yMzF5ZkFyNTkv?=
 =?utf-8?B?R1pzU2FWc2UyYTdpNG13dUZ6Wjl3blZsVlZsd1RvajEvZjU5anQ5L0pZQlNB?=
 =?utf-8?B?dWh0Q0svem9odGdMSTJWbGNVZzV3dndLUGJOYUVldVUvS21ySXp0NjBWQ1Ex?=
 =?utf-8?B?MjNzQ2xFY3RMOTMwbHNPK3Mrd3FNZVdabzN2K2RCYTFqOFhuLzRsTTBuWFdv?=
 =?utf-8?B?VXhKUVZveVp4VHVFK2lQYWdQYU90TnJmb015S0xIa0JyVTJGQWtjMTZKZVJp?=
 =?utf-8?B?ZUxVdHVNQVV3UEJsNmxkYmJlSDhxUGZBdlJ0OEdKeVhNbThRWmxvdkFpSFJw?=
 =?utf-8?B?STRKM09lbHpaQVkxK00zeGlnVGRrT3lOcHgxakcrbjhCNVZzdWNHZytLbFhO?=
 =?utf-8?B?eXIyVzJUMVF2akozakd6K253dU1mQTFaLzhTeWR2cVJqc1lWbDI2MUxEdnNF?=
 =?utf-8?B?d2luVkxwRGIwVTdtV09VNERPWVpQVmNOUndtS0xFc0hUMjBRTGxtK0o4aWE2?=
 =?utf-8?B?RmVoUHZuUzJGaUFLTnNvdGVNWUF1WHYxMlZlVjJOV3dsSjJGZkRtTVJYanNq?=
 =?utf-8?B?bHZsNEdxTGVnR2d4NCtqdmVuQ0NEZjBTNFZ4TVQ2U2JHeTI3dU1iRk5MbWpH?=
 =?utf-8?B?am9TemRKaHlCQkxMeitHbEx2M25mUUx2WHZjUThKQUZtMVFqcVBxKzc5cnBz?=
 =?utf-8?B?eC9hcHJiamFRMWEzRXlYbzVvLzM2SXdJakV6emtMbEZKcWdXMXlLUHZ1Qzc0?=
 =?utf-8?B?bjhuaEx3ZzZjQTdRdGNFbEVEak1jbC82cld4T0FlMEx0ek1JY2xLbFBYNWZz?=
 =?utf-8?B?Nk5kaVZmdU5XQTJ0MUp5NWhjWitwQVhPdDg4QUVEbEdNR0lhVldNdmJTaUFU?=
 =?utf-8?B?RlpxbUZvTFZ3clFFQkg3SjcxNEIyVWpwMUI4UkRTL0N5MmQwbWJPU2FMNlZG?=
 =?utf-8?B?Q0VLSk5NZ09VZkl0OFJaYU92c1NXYVNreGlidkJZZkVsSGl0eDJzcVE2K3cy?=
 =?utf-8?B?VkxiQUd4dWZkL0lIeU5kelduMkpYRE9kN2RMNzk0UU1BbFJRbnRQK1RmT1Ay?=
 =?utf-8?B?aStPZStlTWc0QkRLTW5CWUgzd2JVcFd5eHV4OTlrLzAwd2VBS0ROZW5ndHpo?=
 =?utf-8?B?b1YxYmZ5bnhibmtKSDJOQVErVnh0WE9xNkxHbk1LckJoSWVtcGZuWXNsd1VN?=
 =?utf-8?B?b2ppRWI3K3BSNTQzK0NNc3k1LzQxYXI2cTVhRWwvMUtmc0tLVE1KbmcwYjlX?=
 =?utf-8?Q?rrv/1j5TvmaGeQa6+XHIf/r5Yff0u/yT0UKYPQB?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d73300a-f7c3-44f8-99e6-08d98fab5b98
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2021 07:13:58.6883
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Co0Q4sAymvHHBw05zDfDkBQ70sINxCHTpnDbtpaJIEYjJwkpMSSpxolw3p7AxNNfxc8qcOH/8Y2fSjKXIa1i3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SL2PR06MB3017
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Cj4+IHNob3coKSBtdXN0IG5vdCB1c2Ugc25wcmludGYoKSB3aGVuIGZvcm1hdHRpbmcgdGhlIHZh
bHVlIHRvIGJlCj4+IHJldHVybmVkIHRvIHVzZXIgc3BhY2UuCj4KPldoeSBtdXN0IGl0IG5vdD/C
oCBXaGF0IGlzIGJyb2tlbiBpbiB0aGUgZXhpc3RpbmcgY29kZT8KClJlcGx5ZWQgaW4gYW5vdGhl
ciBlbWFpbC4KCj4KPj4gCj4+IEZpeCB0aGUgY29jY2ljaGVjayB3YXJuaW5nczoKPj4gV0FSTklO
RzogdXNlIHNjbnByaW50ZiBvciBzcHJpbnRmLgo+PiAKPj4gU2lnbmVkLW9mZi1ieTogUWluZyBX
YW5nIDx3YW5ncWluZ0B2aXZvLmNvbT4KPj4gLS0tCj4+wqAgZHJpdmVycy90dHkvc2VyaWFsLzgy
NTAvODI1MF9hc3BlZWRfdnVhcnQuYyB8IDYgKysrLS0tCj4+wqAgZHJpdmVycy90dHkvc2VyaWFs
LzgyNTAvODI1MF9wb3J0LmPCoMKgwqDCoMKgwqDCoMKgIHwgMiArLQo+PsKgIDIgZmlsZXMgY2hh
bmdlZCwgNCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQo+PiAKPj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvdHR5L3NlcmlhbC84MjUwLzgyNTBfYXNwZWVkX3Z1YXJ0LmMgYi9kcml2ZXJzL3R0
eS9zZXJpYWwvODI1MC84MjUwX2FzcGVlZF92dWFydC5jCj4+IGluZGV4IDIzNTBmYjMuLjA4MmI5
YmQgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvdHR5L3NlcmlhbC84MjUwLzgyNTBfYXNwZWVkX3Z1
YXJ0LmMKPj4gKysrIGIvZHJpdmVycy90dHkvc2VyaWFsLzgyNTAvODI1MF9hc3BlZWRfdnVhcnQu
Ywo+PiBAQCAtODIsNyArODIsNyBAQCBzdGF0aWMgc3NpemVfdCBscGNfYWRkcmVzc19zaG93KHN0
cnVjdCBkZXZpY2UgKmRldiwKPj7CoMKgwqDCoMKgwqDCoCBhZGRyID0gKGFzcGVlZF92dWFydF9y
ZWFkYih2dWFydCwgQVNQRUVEX1ZVQVJUX0FERFJIKSA8PCA4KSB8Cj4+wqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIChhc3BlZWRfdnVhcnRfcmVhZGIodnVhcnQsIEFTUEVFRF9WVUFSVF9B
RERSTCkpOwo+PsKgIAo+PiAtwqDCoMKgwqAgcmV0dXJuIHNucHJpbnRmKGJ1ZiwgUEFHRV9TSVpF
IC0gMSwgIjB4JXhcbiIsIGFkZHIpOwo+PiArwqDCoMKgwqAgcmV0dXJuIHN5c2ZzX2VtaXQoYnVm
IC0gMSwgIjB4JXhcbiIsIGFkZHIpOwo+Cj53aGF0IGlzIHRoZSBidWYtMSB0aGluZyBoZXJlIGZv
cj8KPgo+RG9pbmcgYSB0cmVlLXdpZGUgY2hhbmdlIGZvciB0aGlzIHR5cGUgb2YgdGhpbmcgbWln
aHQgbm90IGJlIHdhbnRlZCBieQo+bWFueSBtYWludGFpbmVycywgZXNwZWNpYWxseSBpZiB5b3Ug
aW50cm9kdWNlIGJ1Z3MgbGlrZSB0aGlzIDooCgpTb3JyeSBmb3IgdGhpcywgbXkgdG9vbCBuZWVk
cyB0byBiZSBvcHRpbWl6ZWQuClBsZWFzZSBpZ25vcmUgdGhpcyBwYXRjaC4KClRoYW5rcywKClFp
bmcKPgo+Z3JlZyBrLWgKPgo=
