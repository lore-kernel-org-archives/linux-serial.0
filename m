Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34713C47080
	for <linux-serial@archiver.kernel.org>; Tue,  1 Jun 2021 02:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09FBE60FEF
	for <linux-serial@archiver.kernel.org>; Tue,  1 Jun 2021 02:46:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232356AbhFACsf (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 31 May 2021 22:48:35 -0400
Received: from esa15.fujitsucc.c3s2.iphmx.com ([68.232.156.107]:60864 "EHLO
        esa15.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232268AbhFACsf (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 31 May 2021 22:48:35 -0400
X-Greylist: delayed 428 seconds by postgrey-1.27 at vger.kernel.org; Mon, 31 May 2021 22:48:34 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1622515615; x=1654051615;
  h=from:to:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=AdA03nTZvSlEyzFDHasx7BnJrl49Nlf4HBANvu2/aGg=;
  b=f7Ep6nTpmMWP7o1bG/85lj/cqwuhg62xv802PiIAJEfpJBTYbPEfHvNx
   Mqs87aC2J3LKcU2QowxFvRo2eHDG9401Q01vd2AZhSwMojCjDA0C06lBB
   3GHOItNbV2f88mT/Tcnqz8jbsjodJJXKVCAUKelRHBssRH2X7Nr9mVd6H
   kIqTI4qehbSbUzVqaBBTWdLFygbfLeg0e/e+y9r+KCnCr2lJzszs0UY3T
   bcmfKIfwbyl1/EgtceeIyQ222JsMyufV0M12+oeFxQ6SrgNAvvUnBcwSW
   Sz+0+WW7PEyvMswG1E5Kuwy4iU2i1+UeM+OHw2QT87oU9VAHXV7pHatzQ
   g==;
IronPort-SDR: uRN/dVXg8mRy29sObSzyWQAdoAQgWyUw3MkayxNYNl/rTFLb4kDN5q3D0KEBB9ssitvDJliUHr
 zo7uAFNezuBG3SDitlAR21Yzz/olIs8kYOFQOs3nitonl87nIGfrZdKlvRPwox97OAS8WjasaL
 Xr+xvIGZgg3YT17IEda+117ZBJeAssqOcwei8GjndNq2H/J4Nu6VPyfSB2Lu9lRBoG9ANrpqXg
 ZCb3UxOjUvt9Ik2jZxdpDpUFiRoC+oLHXER194GgDYk/lhYFHQLrClIThQ2KMBitb0n5BfdyV/
 yHI=
X-IronPort-AV: E=McAfee;i="6200,9189,10001"; a="32173514"
X-IronPort-AV: E=Sophos;i="5.83,239,1616425200"; 
   d="scan'208";a="32173514"
Received: from mail-ty1jpn01lp2053.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([104.47.93.53])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2021 11:39:44 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KV7cqAvzOqZQ12C4O/2QVTLoxWoR/czfices1HdPQWnRIJygYF7HrPQbcWE92FYxRu1MtxXgcsWP2ImlESK6ZucqyyHFKArPDuIFOruEjSJ9BYUBZip7p/Y0hibDk8BSIf64/FgvIcSnj/TU36dj4R0Ig5xfFTm4qcS/Re0w3etzGZF4A5P6SjCMUWh8vmOC02AItFc1XMr7qgTMrKXX3QGyfoMOt/6GM5dCwa+gW4pWevuAF1PGdyhRePONKvCEdd+xT9Tbp90BmHNN7ln5aiZ8PHUgOxVZXoaiqDZ77pyviNuIzelhvv9t+flXZn6zKmrJeTlFFse01fIOnKG9tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AdA03nTZvSlEyzFDHasx7BnJrl49Nlf4HBANvu2/aGg=;
 b=IKGcrzKe+FnZ7+wvFVVHT8JtbFILZEY7krvmampqgvJK4+fr0vZdlJC0p9rvl0gh1STaxYKTVd5JGPE4rxZM4bOpyPoktAtHQYASZss+2EgwSJtkof1PZBzsn9qNrkj+VhX3i8DOcJqPzUDcvwaeHV2jQ7rQ2WZMiPuWRcKJX4eYt/eE/thS+cprInQ6twnFQz+dsKUHBxCUVsZpXQ4Yc6Ou6EG1T9eICeMiCDtV3VC9MdY9c72lycTxou8d2FVZnOdub/EsX+aBAHNKi8WsrCh88Ba2+uPLVvGJcoiIMK6suS+hhzbAGd++TMtz0xuYbUsJ/2L6kyJDtrfyo1w9Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AdA03nTZvSlEyzFDHasx7BnJrl49Nlf4HBANvu2/aGg=;
 b=m4M3mxwWfJ2CZyqtVRwtJpw6V/wH2Zws0003QAaDK6MZpcrphbnjIsYhv1qAb8WHd7mRAzIuKosUddyJuDW7sVG+hVBVvgqN+tTx/wMRd/LIr8jIonm5ISfd9hx6cXun/cj/+RJMuhgG5JHsXZK8VCPc9l6Uou8ErehZiu6m3kc=
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com (2603:1096:400:98::6)
 by TYCPR01MB6542.jpnprd01.prod.outlook.com (2603:1096:400:99::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Tue, 1 Jun
 2021 02:39:41 +0000
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::31b3:92cf:6a2b:3531]) by TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::31b3:92cf:6a2b:3531%6]) with mapi id 15.20.4173.030; Tue, 1 Jun 2021
 02:39:41 +0000
From:   "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: the usage of hardware flow control in serial console
Thread-Topic: the usage of hardware flow control in serial console
Thread-Index: AQHXVo9fMvhXbwBeVEygHHGCKBLgUw==
Date:   Tue, 1 Jun 2021 02:39:41 +0000
Message-ID: <60B59E0F.7030609@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=fujitsu.com;
x-originating-ip: [223.111.68.150]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2ffa75e1-72bf-4362-6dba-08d924a6824f
x-ms-traffictypediagnostic: TYCPR01MB6542:
x-microsoft-antispam-prvs: <TYCPR01MB6542E8000E6C3FF727786FB4FD3E9@TYCPR01MB6542.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PXEXUa07uuu4kVqHAtPD9YqbjU9SPEHHsYyn6WxaqHFnwk0jaQo0jrkIx4h1jduBEskpEXh1wBjhqMQsFq5g2Bn3ete0Qjk5Q4ge2NY0yFSm3nxAz4Tms0R2w959/TVbMO6aOQUZEstGLZsw/o37djBlFe2s337Exai/cXjyRxM13/DyiSOV7XOk2StHYZC9bwbZaTeh2UwObhz8xRh+ycCQFX1ZiRjPg7P+ujTVhUEi7HKLRWfp4m/daqLhpiCOaGScTRu66/lezXt0RrXNghs5lzSMNN3mTs21828R6icSDR+yoISWVrTB8v77GSfmQi6PDbhs5gyckljLoKMMSN2lAgxWvgmRveXQ38nMLS//Coe6NGi+F25MpxokCY51Cs+yYaqcTRLijZfZpPmBAhng69i9VXlwXz0SnWJ2BUJQF4ecFqzDxgyGOiyPqWkpuWcpOoD7PbdeCBUJDawuJ7YsWr0ZdkiYcqtT5gS00Xg8JgMrcPkNG6NPWnZBP2maNKJkssTq4yHyOLex5uCvouz9oJWy1uMznQGzNloq4TdJn3H17yOZEJWb6D+0gMwnm8c7IU0vc16HKE0KXi7UALp66EZdxxt9adwRYXuIuz0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB6544.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(376002)(136003)(39860400002)(346002)(36756003)(478600001)(2616005)(186003)(316002)(87266011)(76116006)(64756008)(66446008)(71200400001)(91956017)(66556008)(2906002)(6486002)(6916009)(122000001)(86362001)(66476007)(33656002)(5660300002)(85182001)(26005)(4744005)(6512007)(8676002)(66946007)(38100700002)(8936002)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?gb2312?B?RG1RSkg2S1BZUjhPaEJkNFBLQXZTM0hYZk1VRmNWa0M2djJvc3h2Uk9xRWlI?=
 =?gb2312?B?SktEYTNJeG5NVnYzZDZqUzFrdkRPYXZTd2RtbSs1QTF0WUtiTUx1T0Z2eHpB?=
 =?gb2312?B?Q1IzMENQbWl0eTBWSlNrVGZMRWkxSC9BLzZTMFhaeWd6RWU3Qlc1OXBVZWNN?=
 =?gb2312?B?ek9qUFlGcEtMUlpvWkZWUWlITXB1eHZwaWR4MWxmOXBYazIvSHZvNktaa2xO?=
 =?gb2312?B?S1YwVzd0aVpEZ3NsdDhlcGd4Q2VQWTBiUGp3Z1M0Ky9vZ0d5dUdZT1IrbUEv?=
 =?gb2312?B?NGp6eERneWhKcGdEc1hVN1g0N1phbTRsa25tcnZEeVRIQW8wSXNWQjVwNlNi?=
 =?gb2312?B?QW40WDVHYkErOTZGWDQ3am5HcHA4VjdSRTZCbmJhblVlNURNSFBBek10WGQy?=
 =?gb2312?B?U2hRZDVzR1pYcTNVYmNJTkt3a1J2ZlMwTnU4M08xSXh4R1VsL0NuNUhVV3FQ?=
 =?gb2312?B?Q3gzNnZXSCtBb0lvb3VLOHVyTy9Ia2g5djdJd2w4WHFwblJtSTRHR3lKRFR2?=
 =?gb2312?B?MG9HUzI4UlZ0MndicE93cUhvMGNKYmhoR2pPMDBSS2w5RDY4d280UGNDbGUx?=
 =?gb2312?B?L2dEY09GWFZXZTFROGgwQ0p0ci8wUUhmY3FNcTNYQlNjUDZCdGx3U1pYN1BT?=
 =?gb2312?B?WXNCVTUzZnBSaWxGdm9KZFlObTlodlVVeEl1UmxFazJQUFp1YUo1VCs5NnRR?=
 =?gb2312?B?VzFiMm5MZlo5UTNQMWhVaFgvNXdzcGFjMXBNbThJT1dxZ09YTnp4YWJOYU93?=
 =?gb2312?B?djdRd1pGNHdRb1h6eWUrN3cxQ0hBUEZpeGVKdytDdFJ3WkpoeU4vSWp5dUxJ?=
 =?gb2312?B?R3dNcnBXR3I1ekg3eGo5bWNOc1VmZzM5azd3TVdIR0JMZkpsV1d3R041SWgy?=
 =?gb2312?B?RnI2ME1tendodHFkV3RjNFhlbGpDYzYvRzIrbVVvejhFSUE0eXVWWUdEdzVs?=
 =?gb2312?B?ZExULytsVUFrWENJdHhHWmRBeWdGRldOUmdFRUdYWnVLb2JDTGErYXN2Rm52?=
 =?gb2312?B?ZlpXbi9uVDNZMVdTeWtXS0w3SVZFUVBvNnhXYmFTSUFBaktaVEN3OFFHVVVC?=
 =?gb2312?B?THBjUTBxek9RQ1Zsa2ZVU081ZlNOWEVQNHdLeGhWeng4L2VuOFVzdEozdGVB?=
 =?gb2312?B?OVhMR2plMElGQUthWUtxbVVwZE9tQzhNS0JGcERNMXFUbEdjWk5GblFuNlha?=
 =?gb2312?B?bzRqSGw1VHdBZTBaa1JyK0JNT082UWI4d3k5aGlyOENTRDhRT042Q1lIS2c3?=
 =?gb2312?B?a2RJRFZJSU1QSVRXWHRsT2dQSW1RMHUweXlnaEQrTHdpTDNjK2s1bVFrL0tC?=
 =?gb2312?B?R1ludVVqZ0xXNVNvajlaekpZa3c4U3Q5Y3I3V0R1YW05emh1K3p0c016aUkz?=
 =?gb2312?B?OU5zVDA0bGMyVnhqdUtuT1lvNDltQ2N2eXlGMitIRG1qMElFSWwwM3NPa1pB?=
 =?gb2312?B?VnlZUmhMUnhYK0NMTGVraVpiMDQxQng1NDNLekJzWmVMbDRmeVN5cktLeDhY?=
 =?gb2312?B?ek41Rzl5Q0dXVGRrR3htczlHVnVYSHNSdHZraHhTa2x3YjZWTlRvMmFSem5h?=
 =?gb2312?B?RVhsdlZ2THJpc1IzR0VwNC9Banc3aTRxYzJxS29BSTB3YkdWd3EzWUUyZW5h?=
 =?gb2312?B?R1B1c2xIdDNqeVhGM1o1YVN6eHkyNXp3cGtwNy9IMGFnZm5tWi9OQTh0cmpT?=
 =?gb2312?B?SUtpNUxLL0FHTGo5SEFVZWtqbERqb2FuVlR2VlBHR3E5cytMUFRxUmJmNGtq?=
 =?gb2312?Q?hlx3WQEYd2X0cayZVbEDNNZkYrzCRlvtZibRh82?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-ID: <2E9A6628830B6B46AEF9FC551054124F@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6544.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ffa75e1-72bf-4362-6dba-08d924a6824f
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2021 02:39:41.8632
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fd73t2cbokmv49xhbNG4U4ISp5mnZ1NKBG8zhRZOhOc7BxhEZXhaBjc5rnahPqEjkMn3sXOQPGtG8JCVxsMHNk5uiCbnppl5e11J2+93rRo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6542
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

SEkgQWxsDQoNCkkgYXBwZW5kICJjb25zb2xlPXR0eVMwLDExNTIwMG44ciIgdG8gbXkga2VybmVs
IGNvbW1hbmQgbGluZSBhbmQgcmVib290DQpteSBzeXN0ZW0uDQoNCiMgY2F0IC9wcm9jL3R0eS9k
cml2ZXIvc2VyaWFsDQpzZXJpbmZvOjEuMCBkcml2ZXIgcmV2aXNpb246DQowOiB1YXJ0OjE2NTUw
QSBwb3J0OjAwMDAwM0Y4IGlycTo0IHR4OjAgcng6MCBSVFN8RFRSDQoxOiB1YXJ0OnVua25vd24g
cG9ydDowMDAwMDJGOCBpcnE6Mw0KMjogdWFydDp1bmtub3duIHBvcnQ6MDAwMDAzRTggaXJxOjQN
CjM6IHVhcnQ6dW5rbm93biBwb3J0OjAwMDAwMkU4IGlycTozDQoNCnRoZW4gSSBlY2hvIDEgPiAv
ZGV2L3R0eVMwLCBidXQgaXQgaGFuZ3MuKElmIEkgZG9uJ3QgdXNlIHIsIGl0IHdvcmtzIHdlbGwu
KQ0KRG9lcyBpdCBuZWVkIG15IGNvbnNvbGUgY29ubmVjdGVkIHdpdGggb3RoZXIgbWFjaGluZT8N
CkFsc28sIG1hbnkgc2VydmljZXMgYmVjb21lIHRpbWVvdXQgd2hlbiBJIHVzZSBzeXN0ZW1jdGwN
CnJlc3RhcnQvc3RhdHVzL3N0b3AodHgscnggZGF0YSBkb2Vzbid0IGluY3JlYXNlKS4NCg0KSSBq
dXN0IHdhbnQgdG8gY2hlY2sgd2hldGhlciBpdCBpcyBhIHVzYWdlIHByb2JsZW0obXkgc3lzdGVt
IGVudmlyb25tZXQNCmlzIGNlbnRvczgpLiBNeSBtYWNoaW5lIGlzIHBoeXNpY2FsIG1hY2hpbmUg
YW5kIHZpcnR1YWwgbWFjaGluZSBkb2Vzbid0DQpoYXZlIHRoaXMgcHJvYmxlbShpdCBoYXMgUlRT
fENUU3xEVFJ8RFNSfENEIGZsYWcpLg0KDQpCZXN0IFJlZ2FyZHMNCllhbmcgWHUNCg==
