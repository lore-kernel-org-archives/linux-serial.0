Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A4F6E6FE52
	for <linux-serial@archiver.kernel.org>; Fri, 22 Sep 2023 15:33:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbjIVPdQ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 22 Sep 2023 11:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbjIVPdP (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 22 Sep 2023 11:33:15 -0400
Received: from DM4PR02CU001.outbound.protection.outlook.com (mail-centralusazon11012006.outbound.protection.outlook.com [52.101.63.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87951A3
        for <linux-serial@vger.kernel.org>; Fri, 22 Sep 2023 08:33:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HRTO+PEPtmUFZosNQTsXrOpxA7iHKoHbZlfHJrH43X7aOLuRWVNP5bHSt/vOS+EwehXDxO9r93hsauM3GZtX/mtBzWA5bWh2Up7ovAe7u5sbuU+z0+oujT0DIE5w+jcKfktA9hHQE8uIA7IhyAIWmyLe5KwcU+JCeTMhXocb/3wEmJ0cy6ELh4do0cdMm9HfG/0DE6ZuevRnrIuNqPbT1IsgiWuzn7NjlBASYlNHxVwcy2jWamqrgNwEVryQzqqV82Ub/MV3tGsMrmvsYH6HenA8o8SjIWH84L0ziu//vyA3CBTKFib8EtKW4G7Q8fcxvWTuy3MyRnhtu3tTybCx+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Yo7/1MEnBBOiCcI9PURIKWJ7cA5Jwh/o4Ir7g5ZFeA=;
 b=j5mIjwb3mjzaNzpoxuTTCVE095Yt5o/Vjypl2fu21VDgc1dll87tPkyu4UGKToNJQkhfYh7LlVykVsf4ui6yitv7a28qIi1uLGWeCLr/a06EJjfVLhBnlMi3rLc8BoT8bq1/3VbbXpR+Rjtp2ECTjw67tAbnnaCwXAYdxzJQOjpUGfL+mXYWdsN3tiwIv0fwolC2H3dVRdQcfyLtX8JXYWlCVNmXw3Woauj5Xll8TB0Obws0wkQslv3CYPsrQyWLR4UbzN1HId2y8Hz2Z+kJV0rNrvKevY7frPrF5s/pdKQNtKqCE4VeqFrzVhdo8dhj+T2OpQaRAAyBmE07uKstYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sealevel.com; dmarc=pass action=none header.from=sealevel.com;
 dkim=pass header.d=sealevel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sealevel.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Yo7/1MEnBBOiCcI9PURIKWJ7cA5Jwh/o4Ir7g5ZFeA=;
 b=l6/NvNGuE/C5T3nhT4nIJr6VxVBlu5qPrmiU7I86X5E3hzSxphJGQlFsq1tFJlbfWTJ0vfCBpHEl8FOa5NWGCWjN/UTyFPKrTVvFtBJ/twrzpawWuPQ5qM6dLJ++PTOru5Ip/PWD5pG0H35mnQtbag485C6ov4WDF7juwnFr9UlMTlZEQodhWbdpqUOIieVAYocTJh698ifVm2ZsLfzesQLSTaMe+6mPcwczsGJiXATUx35s1uOtnT1WHG98vz96krP/t/UdgjkyU0vK30NoUO6cmu293O1Fls5tGrlqLoTaA59qCVuNThug6tQZQdbjS27GmYxBGwOvH1aiwaipBQ==
Received: from BY3PR05MB8419.namprd05.prod.outlook.com (2603:10b6:a03:3c6::10)
 by PH8PR05MB9316.namprd05.prod.outlook.com (2603:10b6:510:1cf::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Fri, 22 Sep
 2023 15:33:05 +0000
Received: from BY3PR05MB8419.namprd05.prod.outlook.com
 ([fe80::f4e4:1bc5:23f6:c9d4]) by BY3PR05MB8419.namprd05.prod.outlook.com
 ([fe80::f4e4:1bc5:23f6:c9d4%3]) with mapi id 15.20.6813.017; Fri, 22 Sep 2023
 15:33:05 +0000
From:   Matthew Howell <matthew.howell@sealevel.com>
To:     "andriy.shevchenko@intel.com" <andriy.shevchenko@intel.com>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        Darren Beeson <darren.beeson@sealevel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Jeff Baldwin <jeff.baldwin@sealevel.com>,
        "ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
        Ryan Wenglarz <ryan.wenglarz@sealevel.com>,
        James Olson <james.olson@sealevel.com>
Subject: Re: [PATCH V8 2/2] serial: exar: Add RS-485 support for Sealevel
 XR17V35X based cards
Thread-Topic: [PATCH V8 2/2] serial: exar: Add RS-485 support for Sealevel
 XR17V35X based cards
Thread-Index: AQHZ7WAtWot3rpLtukS7TUxTtMVPmbAm7PeAgAAMcAA=
Date:   Fri, 22 Sep 2023 15:33:05 +0000
Message-ID: <c48ef137af419953b6752ce31e9e82c701efffa3.camel@sealevel.com>
References: <7f7016dbad5eb0770bf4653dcc87ae0f8963bf44.camel@sealevel.com>
         <4c6c4e3212a929822ec6a8ba09691b465541f648.camel@sealevel.com>
         <ZQ2pQS4q31t8aMBB@smile.fi.intel.com>
In-Reply-To: <ZQ2pQS4q31t8aMBB@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sealevel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR05MB8419:EE_|PH8PR05MB9316:EE_
x-ms-office365-filtering-correlation-id: 77b8c21d-a939-4ed4-3ab6-08dbbb813729
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5z77HWyRFNt9Tvai6cZhV4q+MqxDMo1meAinNAv86MgSlCseXjiPxmfFqTFwUAc04LfLY6EbUrrYLPnFDE0w35ALm/4HDWYEhoSyxqP98F/0HUE1S+rg+3NPx1o3NhV852fnzxlV6U2kZE19Scgp1Avz+n6gscGK76qx+6CL/rEItdZOt6k2zCoy5XDsdGCTursnyKanJRxJVIDkaf21eugpFgOPmioVAB9XWvGjo+tuOHPLn09S9AmxwMOsCLCslu4ZDOGK/3qeGKlnI/VJxNGlSZ0fF8RfxGI1Qs8YPj2iVd+po74iNUhy70IzBnHRu+j4/PVDHay+8bH/Sj7/nqqyCVVruVzEkO/loq5rZFGOpKPhRb4nz9egE3g5XJlNSBUhWGIRksLkis1eKM0wWe+r+23fWpzJrgZLImYndVNfui4WQR6aMkIvPAIXCoNIVPwPUODRwbmhQ4GS2qO9tPEG+uIqkR0fBhBn8HnPBBHm/t9XGruOjnrZMvtrGOMoa/puYOnvK9V9uroKvKT9K6xKCUenbDnCgS0iLZI8b8OhFS9Ih6Mh/ZpcT6IrCqc30lJj2u7XJI1zNKgDQA68V6c+FuHQ8aYl6CsNJN4ZHx54yvTnrEfADzxL0XtjSi2YdPXwVF8wkHPE/g1uMd7/yBtYYIYUZpA8o/cexCPKKUk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8419.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(376002)(39840400004)(136003)(1800799009)(451199024)(186009)(36756003)(83380400001)(478600001)(4326008)(8936002)(8676002)(5660300002)(2906002)(44832011)(86362001)(38100700002)(38070700005)(91956017)(66556008)(41300700001)(66476007)(6916009)(6512007)(316002)(6506007)(66446008)(107886003)(2616005)(54906003)(64756008)(6486002)(66946007)(76116006)(122000001)(26005)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T2RGVk1FdDZOTFIyTzkvT1NRL2lXdzBLN0JleVVPaTc2WU9JOElFTjN3QVJh?=
 =?utf-8?B?dUNrVW1LTnJ3OC85K1E0elhvdGVTeWUyZFFPODVuNWxlSFZTZVNUUGkydXZ0?=
 =?utf-8?B?ZTYxT09scGpwS09IdUVZRUVwbTRzbXJ3dENIQTJnZlkrWi9kZDk3VlNYR05L?=
 =?utf-8?B?eHVickFhaUJ2RW14Q3haY3pybUZ2SGVXK0dkKy80dTBHYVdFeE9nV3ZlcHQy?=
 =?utf-8?B?WEl1d3pTSThUT200Q0N6aFVlcTJsbE5yZm9DT2dXanhzQmhIam54bzlwVi9S?=
 =?utf-8?B?eGFoYTFTc0lFazIxUzJ1Uno2WnF3UE5Wdk9mYytocWJlOGZvUHhRUXhDSE1X?=
 =?utf-8?B?TC9QbzdIeWl3aFczQlJBdFBVS0NLUjlYdWs4RFYrOWY0RElGczN5ZmovWDdU?=
 =?utf-8?B?aGtvRW5uVURFcFJkeWd6Yjl0Ri91LzNPNHlBVTd2SFQ1QnNFNHR3VHJ0WCtS?=
 =?utf-8?B?VkxBYmlKc3JtTVpudlJjaW5hQTRPRW5hbzVRRE9wQmkzRlJ5ZmV3TjFwQ3dX?=
 =?utf-8?B?Sm4wbUhmUitwUXRCQ1Y0eGdielhsSnZ2U0ZjSGEwV3RWZUo0QXpVbDRLUnFo?=
 =?utf-8?B?SEJ3VnpwQlU2RzRBdys0dVJ1OWhCV3p0aTIrVjdBc0F0aGRMVEc1M2NPWmph?=
 =?utf-8?B?UTJvQ0RaZnNNSG16RE4yWWFyNHd5UkhETVhQVFhxWnpKVzBGL1pKdUJpeXkx?=
 =?utf-8?B?Q0tnN21NYktLNkp2NW1vdFhFWlBjY3IxOUthUC9mS3pRRHdJUGUvQ1drUE85?=
 =?utf-8?B?MXhaL1BTdGZ3YTRGYnJJRGIycnZzRXl2QUxTNlEweWdHZ3JoQURCTTBOVGRl?=
 =?utf-8?B?YjY5Q3JybVZJa2hyTWtXWml3MHlRbWZtODBpUnJzQy9pcGJWcUdvTVVjUVZZ?=
 =?utf-8?B?MUxob2NydlBWS001YWpjTm5BdEkwTVdsZWFVZ1FmQm1mc3k2bkppdzlRY1ly?=
 =?utf-8?B?NGVOVEZIWmRSb2pFRWFLQmNDUXJ4U01TUnpaQU5jVXhjbGVLdnFzWE1EMVlU?=
 =?utf-8?B?cUl5VG5pQVBodHJsQ0l2MlFSck5VRU5iMmpkR2hBWkVjZnB6M0U0a0pyTmlk?=
 =?utf-8?B?ekdKa0xGMnhQYitPREZ4TFdKODVDano1NmxtSVk2b08ybVhsL08wMXhpRURi?=
 =?utf-8?B?UFBRM2tkMHdaWUNXNVYrUFpMNjRta3l4UFRBQlBabU1laHZ3QXpHSkhZazZi?=
 =?utf-8?B?QkRQZU5LUlcvU1AvQ2RBNTVGME0rc2pzMnpUcGR4bjQ4bnFBYndFWEZ1OHJ3?=
 =?utf-8?B?UzVSbGowT2dlVzJ1N1FCaGZVSzZIaHVReVVEZ1luNk9xeEhRWGp5R2lIQ0kx?=
 =?utf-8?B?VzlnQmhhbU5QTFczRlF6cUhEalQydTBnN1BiNHk0T01mQUthQUNpZVVNSGVQ?=
 =?utf-8?B?VEJSRzZJYTNTa3F3RldVUDErQkRoQk45Qzl1YVBpUTFLNG4wS2RWa3BYalE4?=
 =?utf-8?B?QTlTM3dJQVp3YWt2MjZRaVlqNVpqUk5mK0J1VG84UCtDUGpabnU3UTNSQXFC?=
 =?utf-8?B?cjZqank3d0hhZnJyS2hHamI0M0tMWFpaWlNoa1UzL0lyTzhtaG1OVFJ2Q0dn?=
 =?utf-8?B?VDV1OUZEYUdEaXZ6bysxNkM1UFhURTYrMmJ4QlB1NGJ1M3RrUEk2QWtsejY0?=
 =?utf-8?B?Qy8rMnpjYzM5MDlsYXc2UTN6Q3EwOUViQi9Ic01KVDdTYndQVlNTNXZrcXZs?=
 =?utf-8?B?Tk5hYUZRSGgwc2l1aFVTZllFUXBDT2U2Nk1mNlNNWFQrM3Z0WXNabHpCRkpv?=
 =?utf-8?B?czJURks1VFJCRmN2eVhBdEVqY2EwRlR5d2J1UnFTc2JESnpGakE2R08rV251?=
 =?utf-8?B?amd5YlpBNU42UFRlQVRCVUtUT25KUWpjVGdQMTA1WWxLZjllWHprTzFhdWJl?=
 =?utf-8?B?UWpoNmhRaHBwZk9jZHFNTFora2oxb2xSYW1kbFJ5YzRSN0tWdEw5bW1MVFdZ?=
 =?utf-8?B?NGhIcnJrbkhXSkwxYllSaGU2eUpqbEY1c3AxRjJVdzVCUFNRVXBXOVo0VTRG?=
 =?utf-8?B?dXRiZktwc1dsVWY1elZVY3gxYnZqbmg1QXVKTEhsYkIvY1BiUUlRL1QzekhB?=
 =?utf-8?B?Q1RqR2tITDdJcDdkczdhekk0NGE5R2ZUKzU4UUxPMTY0M1F5YzdrRDJyMUhE?=
 =?utf-8?B?Szk5ckVjN2dvV1hxc3Z6Smd4OEJGeW9QaEc4OVNGQitmSE5RM0ZMSjVkbnV0?=
 =?utf-8?B?RHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <44E453981E9AA544BDD5365EBF59E591@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sealevel.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8419.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77b8c21d-a939-4ed4-3ab6-08dbbb813729
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2023 15:33:05.3451
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e34c5615-b4e3-481c-abc8-602581f2e735
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zsiwUAwkCij9Zq3mX4BW++3/ec3WtL/PY4uAEuOpO882vovlPtwq76c51jOgtT/YQZ5rtt2LlGbHEMTIeDtwMxc5wXOoL/Yg8nD6zH2npno=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR05MB9316
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

T24gRnJpLCAyMDIzLTA5LTIyIGF0IDE3OjQ4ICswMzAwLCBhbmRyaXkuc2hldmNoZW5rb0BpbnRl
bC5jb20gd3JvdGU6DQo+IOKaoENhdXRpb246IEV4dGVybmFsIGVtYWlsLiBFeGVyY2lzZSBleHRy
ZW1lIGNhdXRpb24gd2l0aCBsaW5rcyBvciBhdHRhY2htZW50cy7imqANCj4gDQo+IA0KPiBCaW5n
bywgeW91IGhhdmUgdGhyZWFkZWQgZW1haWxzIQ0KPiANCj4gT24gRnJpLCBTZXAgMjIsIDIwMjMg
YXQgMDI6MjI6MTFQTSArMDAwMCwgTWF0dGhldyBIb3dlbGwgd3JvdGU6DQo+ID4gRnJvbTogTWF0
dGhldyBIb3dlbGwgPG1hdHRoZXcuaG93ZWxsQHNlYWxldmVsLmNvbT4NCj4gPiANCj4gPiBTZWFs
ZXZlbCBYUjE3VjM1WCBiYXNlZCBjYXJkcyB1dGlsaXplIERUUiB0byBjb250cm9sIFJTLTQ4NSBF
bmFibGUsIGJ1dA0KPiA+IHRoZSBjdXJyZW50IGltcGxlbWVudGF0aW9uIG9mIDgyNTBfZXhhciB1
c2VzIFJUUyBmb3IgdGhlIGF1dG8tUlM0ODUtRW5hYmxlDQo+ID4gbW9kZSBvZiB0aGUgWFIxN1Yz
NVggVUFSVHMuIFRoaXMgcGF0Y2ggaW1wbGVtZW50cyBEVFIgQXV0by1SUzQ4NSBvbg0KPiA+IFNl
YWxldmVsIGNhcmRzLg0KPiANCj4gQnR3LCBmZXcgaWRlYXMgZm9yIGZ1cnRoZXIgaW1wcm92ZW1l
bnRzIC8gcXVlc3Rpb25zLg0KPiANCj4gLi4uDQo+IA0KPiA+ICtzdGF0aWMgaW50IHBjaV9zZWFs
ZXZlbF9zZXR1cChzdHJ1Y3QgZXhhcjgyNTAgKnByaXYsIHN0cnVjdCBwY2lfZGV2ICpwY2lkZXYs
DQo+ID4gKyAgICAgICAgICAgICAgICBzdHJ1Y3QgdWFydF84MjUwX3BvcnQgKnBvcnQsIGludCBp
ZHgpDQo+ID4gK3sNCj4gPiArICAgICBpbnQgcmV0Ow0KPiA+ICsNCj4gPiArICAgICByZXQgPSBw
Y2lfeHIxN3YzNXhfc2V0dXAocHJpdiwgcGNpZGV2LCBwb3J0LCBpZHgpOw0KPiA+ICsgICAgIGlm
IChyZXQpDQo+ID4gKyAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KPiA+ICsNCj4gPiArICAgICBw
b3J0LT5wb3J0LnJzNDg1X2NvbmZpZyA9IHNlYWxldmVsX3JzNDg1X2NvbmZpZzsNCj4gPiArDQo+
ID4gKyAgICAgcmV0dXJuIDA7DQo+ID4gK30NCj4gDQo+IFRoaXMgYWN0dWFsbHkgY2FuIGJlIGVt
YmVkZGVkIGludG8gb3JpZ2luYWwgcGNpX3hyMTd2MzV4X3NldHVwKCkgYXMNCj4gDQo+ICAgICAg
ICAgaWYgKHBkZXYtPnN1YnN5c3RlbV92ZW5kb3IgPT0gUENJX1ZFTkRPUl9JRF9TRUFMRVZFTCkN
Cj4gICAgICAgICAgICAgICAgIHBvcnQtPnBvcnQucnM0ODVfY29uZmlnID0gc2VhbGV2ZWxfcnM0
ODVfY29uZmlnOw0KPiANCj4gLi4uDQo+IA0KDQpUaGF0IHdhcyBteSBvcmlnaW5hbCB0aG91Z2h0
IHByaW9yIHRvIHRoZSBmaXJzdCBzdWJtaXNzaW9uLCBidXQgSSB3YXNuJ3QNCnN1cmUgYWJvdXQg
YWRkaW5nIHZlbmRvci1zcGVjaWZpYyBjaGFuZ2VzIGludG8gcGNpX3hyMTd2MzV4X3NldHVwKCkN
CnNpbmNlIGl0IGFwcGVhcnMgdGhhdCB0aGUgY29udmVudGlvbiBpbiA4MjUwX2V4YXIuYyBoYXMg
YmVlbiBmb3IgdmVuZG9ycw0KdG8gaGF2ZSB0aGVpciBvd24gc2V0dXAgZnVuY3Rpb24gd2hlbiB0
aGV5IG5lZWRlZCB0byBjaGFuZ2UgdGhlDQppbml0L3NldHVwIGJlaGF2aW91ci4NCg0KSWYgdGhh
dCBpcyBub3QgdGhlIGNhc2UgdGhvdWdoIGFuZCBoYXZpbmcgdGhpcyBpbiBwY2lfeHIxN3YzNXhf
c2V0dXAoKQ0KaXMgbW9yZSBhcHByb3ByaWF0ZSBJJ2xsIGJlIGhhcHB5IHRvIHB1dCBpdCB0aGVy
ZSBpbnN0ZWFkIG9mIGhhdmluZyB5ZXQNCmFub3RoZXIgc2V0dXAgZnVuY3Rpb24uDQoNCj4gPiAr
ICAgICBTRUFMRVZFTF9ERVZJQ0UoWFIxN1Y0MzU4LCBwYm5fc2VhbGV2ZWxfMTYpLA0KPiANCj4g
VGhpcyBpcyBraW5kYSB3b3JyaWVzIG1lLiBPcmlnaW5hbCBFeGFyIGNhcmQgaGFzMTIgcG9ydCwg
d2h5IDE2IGlzIGluIHVzZSBmb3IgdGhpcyBvbmU/DQo+IA0KDQpBaCwgZ29vZCBjYXRjaC4gSSBo
YWQgYWN0dWFsbHkgZm9yZ290dGVuIGFib3V0IHRoZSAxMiBwb3J0IHZlcnNpb24uIFdpbGwNCmVp
dGhlciBmaXggb3IgbWFrZSByZWR1bmRhbnQgd2l0aCBtb3ZlIHRvIHBjaV94cjE3djM1eF9zZXR1
cCgpIGRlcGVuZGluZw0Kb24gZmVlZGJhY2sgZnJvbSBteSBzdGF0ZW1lbnQgYWJvdmUgYWJvdXQg
d2hhdCBpcyBtb3N0IGFwcHJvcHJpYXRlLg0KDQo+ID4gKyAgICAgU0VBTEVWRUxfREVWSUNFKFhS
MTdWODM1OCwgcGJuX3NlYWxldmVsXzE2KSwNCj4gV2l0aCB0aGUgYWJvdmUgc3VnZ2VzdGlvbiB0
aGlzIHdpbGwgYmUgZml4ZWQgYXV0b21hdGljYWxseS4NCj4gDQo+IC0tDQo+IFdpdGggQmVzdCBS
ZWdhcmRzLA0KPiBBbmR5IFNoZXZjaGVua28NCj4gDQo+IA0KDQo=
