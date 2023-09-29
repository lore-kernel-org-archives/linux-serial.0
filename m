Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD3C8E728CC
	for <linux-serial@archiver.kernel.org>; Fri, 29 Sep 2023 17:41:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233179AbjI2RlE (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 29 Sep 2023 13:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233353AbjI2RlD (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 29 Sep 2023 13:41:03 -0400
Received: from MW2PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012006.outbound.protection.outlook.com [52.101.48.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE891B5
        for <linux-serial@vger.kernel.org>; Fri, 29 Sep 2023 10:40:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XAFeuCg1OBT9rj+1CmuPu8RvICqwzC1JWe8rFSOXitmUkUusTT3Jj5VSQlMsm8L4lxtKLePvX8/oL6PdWFu1xr9ZmIyA0KXIDEsSqVLwel1NMmLPmwUbEw937N+B+Qfw19k6Fht5KjzXDCRuOUuexe8mB1bdx9U6ABicIoS/cEibI6c92gmoQjvNucPSlwyK9SA81Y4JBeLY6WzFnJgnnfAlevT/wKfnpyAuef6MKzTwLPhxaHYV5aC7w7JnwrxmFi6XaB50A6OEE/glrHbPcg7ETvs+d1LP94Xuce6Q89+1oMRLjP/Q4KkpRJjYHqTvLn1G+1GhAAbLAEyXeCuXgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uxATSpJtBHR3YciDsuMJu9i5tZBhWHUb74hec/3OVaU=;
 b=UyYPYIv1i09nkFWasTLImdM18AkSjxy6BO6gfdHrD323y6Tybsb4Bbxww96KPwT2JW8/kiC5NbASiUXKd0JwIpSMA1y2QM8+fnrB0a6hiowKLh2qa7mGpnAjyYhVj9FSG+5HT5hL+et8B3+nFUKmWx+W/C8/GjLAlqvlVEmEFZoA1wTMLzX5uATi130+7Iv75Te8vNlDmcmP6oq5JrYiBTavmxta3FydT4Zox9SuoOwRyIr/tsvxn1u01dIaaW0ZI6QRnUVYlAmSNV6eYzfqtd3WgYmyiFxiqMYkpY8d4wWe7uBB5OCUIBcS3T1EqNwXdXH/uCQplYb12hmOkC7k6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sealevel.com; dmarc=pass action=none header.from=sealevel.com;
 dkim=pass header.d=sealevel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sealevel.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uxATSpJtBHR3YciDsuMJu9i5tZBhWHUb74hec/3OVaU=;
 b=iJiI7lH1WGVEx7nIGgmbeWeV68w79Z6fW6dln/8xmI3soTmsxhKPsgoan6+W1ZVEKMPYzwQjGCr5/ysteLFePg029wsiUq1FVYOfsUHESgBkOOU1qQBfE16HXjXSQdf4JNmtltapGNIzXc9OLHH/DBsK2FZ9DQOauNGHsB9NyuSKa64aql89GOxLGJdimjSamVT9E728ZDmLKR3DCz4Ju/cTWSnvc3i5Y4f+K1u6BcAiBXDAdckY3X/QznvsJ2yyiaTaYAvhD5VBGDAaq8PH3DaKJzVNxRb4+NFyW8WBw8w26S3FRnywI8cPBZCU/8W3mEuJhN6KN4oI70qS/uShuw==
Received: from BY3PR05MB8419.namprd05.prod.outlook.com (2603:10b6:a03:3c6::10)
 by PH8PR05MB9362.namprd05.prod.outlook.com (2603:10b6:510:1c1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.24; Fri, 29 Sep
 2023 17:40:55 +0000
Received: from BY3PR05MB8419.namprd05.prod.outlook.com
 ([fe80::f4e4:1bc5:23f6:c9d4]) by BY3PR05MB8419.namprd05.prod.outlook.com
 ([fe80::f4e4:1bc5:23f6:c9d4%3]) with mapi id 15.20.6838.024; Fri, 29 Sep 2023
 17:40:55 +0000
From:   Matthew Howell <matthew.howell@sealevel.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        Darren Beeson <darren.beeson@sealevel.com>,
        "andriy.shevchenko@intel.com" <andriy.shevchenko@intel.com>,
        "ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
        "eff.baldwin@sealevel.com" <eff.baldwin@sealevel.com>,
        James Olson <james.olson@sealevel.com>,
        Ryan Wenglarz <ryan.wenglarz@sealevel.com>
Subject: [PATCH V9 2/2] serial: exar: Add RS-485 support for Sealevel XR17V35X
 based cards
Thread-Topic: [PATCH V9 2/2] serial: exar: Add RS-485 support for Sealevel
 XR17V35X based cards
Thread-Index: AQHZ8vwZPu3UINjLFE+mWTp0CWmRiw==
Date:   Fri, 29 Sep 2023 17:40:55 +0000
Message-ID: <4b8ad8ab6728742464c4e048fdeecb2b40522aef.camel@sealevel.com>
References: <8ffa2f583ff142c3b0eb6cf51a7c9cef5dbfd320.camel@sealevel.com>
In-Reply-To: <8ffa2f583ff142c3b0eb6cf51a7c9cef5dbfd320.camel@sealevel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sealevel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR05MB8419:EE_|PH8PR05MB9362:EE_
x-ms-office365-filtering-correlation-id: bb07e7d6-c13e-4606-e70e-08dbc1133c0d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9nw04dBTMsnjsKSsaTnuz+H9sSF2lLEkHQwpADp75zPK47otU+foyUAa9w1MzZep198fEm7UHymFYQqaNIZq4aeEEHoxATJtVnVLSaenXeBRtnEurtr3cWezpS2YMhY3AgEXk4AXbSTgSbqJCdJRuDTNViX+0r6oMqEhSQOXE2h8WilAO7I7coJ2B+M7YV80JVeroSFmOZfDMo+v+idgriBvJtzEFiHTqr7vr3O8UgFWMyP0Xd00XfxLh/g5zYdIRxPR5UDfJ/30mt4tP55w4mb/8u/G5OXU+yuHN+/QGwWOWm4WTbzaT7evx7i8WfTzyVEKyBfknkfRqCgFL2ABjWcnE8WWWTqchh2kmzi86FN05vf7he/AJ5IE28Pf0hcY2wrL7Te69+ggTat+/UmfbSbdFquASfSJQKfDCBklmgAMMp6dNBhmc14vorYbGjYbI50mOl+9QygvJatxQGwiEu1AjpWsij/eWthnh7bDrOCtjai7HQd7pYFnoV9Oe2ouD+wTRpfuNbkWY2r/KXgj0G7Mz7dnsLC6S2ranGT4OHoyI+GSdNScm8aR5y3WAw5jqgYhpvNz+yR6kIXwFKm4kgyC/4BXLlQWViR+4YMOooBWu57MEGHiSdmJcGqp8pbvVcK5bxKZJY1p3IOGfySaT0w7/KHNXyGJzaCM3t1VcJw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8419.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(376002)(396003)(39840400004)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(478600001)(71200400001)(38100700002)(38070700005)(2616005)(107886003)(6512007)(6486002)(36756003)(122000001)(6506007)(26005)(64756008)(66946007)(66556008)(66476007)(91956017)(76116006)(41300700001)(316002)(6916009)(54906003)(66446008)(83380400001)(8676002)(4326008)(5660300002)(44832011)(8936002)(86362001)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NE1LKy9vdkNtbm9pUURpMGZydjh4dmp3dUJiTmdmbHlwczhLeWNLcXhKOS9S?=
 =?utf-8?B?dlV3QlJVYm9IYWQ1anAyQjYweXJXc3hXdnZMbytoMDVTd0cyTENCRU5MVXJW?=
 =?utf-8?B?UE1DMHdQNXNickZrbW5JUUFkM1RWOG50Z21xOFQ2T0Nwc2V2M01rN2ZMdy9t?=
 =?utf-8?B?eFRCaUpxZkQ5TmRyeC9Dd2NPT213ZmVsWnpyNkpVOXlDUENCdjBpamxuL0hj?=
 =?utf-8?B?bWw4ZlpiVzUwNGVPU21tb2F0Sys5U0E0WlZoV2NZTXRiWG9BVjhVa2wybVky?=
 =?utf-8?B?Y01QcytwREJsc1R6eU1CY1NnVGdLZ3VzMGZQWmtraHJYNWFTaW9lRnRtOUhn?=
 =?utf-8?B?bkVKYktZZEQ5L1U2M2ZidWxMYlI3bzlWaElhVU5PWHpTMEVUSUV3cCtNQUpi?=
 =?utf-8?B?dkc0Rzlta2plNzZUcnozNS92cVJUaXllb0hkOS9TczZzQmZUa0kxSlZ0WmNr?=
 =?utf-8?B?MVNxUmJBVkVxOGhZL3A0WUFmQytrVGMyNEhQazUvTFlCSTRaS0ZicTlBUE00?=
 =?utf-8?B?REdkTTF5b0FhZkJERUdtM1ZNbENYMkFkeVp5ZUxuaURkb05nV3Z1MWhVajFm?=
 =?utf-8?B?anVST3lCaGdjSUd0bFJmUFRxU09uRTBYSWhXMFJEWVhTbXpTK0Q3bE9xOVV4?=
 =?utf-8?B?aFBhNEM3VFprYkNZK2EvMkQ1d2dhNzlocmordTZ4SDNsSTVvVUdubVJDbXov?=
 =?utf-8?B?VEp6dlF1d1hzQjF1RjZKdHN6d3ZONmVYWERWTDM3UGgzdjkyNHY2RmE5VXBZ?=
 =?utf-8?B?eFYzbldkeGdMTlBSc0EwS0hBWllITnFKdWJzdlBST2FOaXk3WDR4UE1ad3VM?=
 =?utf-8?B?cVJlMmdiWktrVEdscGRQNXRXbUpvT2c4Z04vUnZkTjBGSGN5NFd6UE5nb0Za?=
 =?utf-8?B?ZE0wbUI1bVd3bkhFa2lEM0I1QjNNVU1qTWtSUWVmVEVZU0RsUjlFWHZtMFJH?=
 =?utf-8?B?YTFJVzloNmJ1bVFnNGFMRUdScmpuQ0dlaFNOSkJJMENMWlc3dkJrTEJ6aGJn?=
 =?utf-8?B?TzR1dTlhWlpiL2pJMkMvVEZkb0w4WE1Cc2xxN2lvSnhRYWVOYTF5S2w0MjVv?=
 =?utf-8?B?TWlXcEpOQ1lJYTR0UGUydHNiMW1KYzVFZXV3Nk1zdkcwemx3Y3A4YU4xWWZa?=
 =?utf-8?B?QkdKVXZTZnFxdk44YTdqNHpDQmUydG85Uy84em1OWHZrU1M4SlE4Y0xLSjFD?=
 =?utf-8?B?ZGdmbUtpR01GNWN5NGFybjFiMVIxdGQxTDBFSnY1V2lWdUJyV1VwSGJUN3hH?=
 =?utf-8?B?YjdzQ3ZldFQxanZXM1FDMW8wWnFkbnBEb29BbXpmYURhUEtkRkJNUHJLUXRC?=
 =?utf-8?B?UnRGNUNJcnZCWDA2eVVFVGsvN1p0VFNrdElYRkJvTVg2VDQ5VjM5RVk1cHA0?=
 =?utf-8?B?NUZqcHMrRSttSnpNT08ybjZRM01RWXVpWWcrU21MVHFMSXBkTUJXTm1TMldx?=
 =?utf-8?B?aUNoUU9ONzR0cDA3ZlEzZGRQSStjelliSVJUM2hjcXg5dGxvWWRvT0MzcTM2?=
 =?utf-8?B?NU5QcjRWRnFPWFFPQUpLSU9iY2dyWGc0ZEpJbU1ZdU52R0VORUEySW83WUZJ?=
 =?utf-8?B?UUNFbGNHcWJxVk1LVUIyb1lBcXhwNXBzT0VUTXRVZFJXWmNWN1RWaCtOWjJX?=
 =?utf-8?B?ZkJndWZZMzM1S3FNc05OWjV2QVkrdEtMMnByVzJpcnU2eTI2Q0hBRDdqU1Jy?=
 =?utf-8?B?eWJVN3lGeUE3VjVSOFQ3MHUwQkk1bExZaTFwZXZNaXRzS2Y0N3M3ditsKyts?=
 =?utf-8?B?YUpCR29OemNPbzVaUGthdUppdTRVRCtTeEk0dGFpK2o5RGVxZEFyZlhVZWpa?=
 =?utf-8?B?MXlJMm9VU0x6czdrTGJBQkdmbzA3b2twbVJIS0F4TEN3NUJZQmZ6bHBTaGNH?=
 =?utf-8?B?NXFlYTR1eVFFd3d4dEZwYW85VHBHdnI3dFNBWStFK1pzd1kxekZvWkdpZHRu?=
 =?utf-8?B?T3dobW1jeEtsQVJjSFVMN0M0SkhXaFRVd0tWSkw1a2d0Wkt0emF1YndBdExa?=
 =?utf-8?B?SVdXeldJVjEyUitmWnpSTDg0RllpWncwMnVTQnpCNFJrQWkxSkIxUkx4TE15?=
 =?utf-8?B?WU5VU3Zadk9HRkhJNzVnK0R6KzRaM2J3cHBnOTlTME9mYlhpN1c3NXFTU0Y5?=
 =?utf-8?B?Wk1yQkF1b3pKeUh1c2Y5ZVMvUmtiUTFZL3luOTNwRDN1a0Y3NHIvZjR3OHJ4?=
 =?utf-8?B?dXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <753679BB444BC247B866A6429F61CF76@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sealevel.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8419.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb07e7d6-c13e-4606-e70e-08dbc1133c0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2023 17:40:55.8650
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e34c5615-b4e3-481c-abc8-602581f2e735
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XYO9CRPWqbQo2JtrH4Eu+XgEu5zvOF3pPIpfljEObC/buNgpal8N/ZduHJJtm6JKC2j89iUUYhJCivzwUsM/wCzTbnGvQTC9RDFWLTHwOqo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR05MB9362
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

RnJvbTogTWF0dGhldyBIb3dlbGwgPG1hdHRoZXcuaG93ZWxsQHNlYWxldmVsLmNvbT4NCg0KU2Vh
bGV2ZWwgWFIxN1YzNVggYmFzZWQgY2FyZHMgdXRpbGl6ZSBEVFIgdG8gY29udHJvbCBSUy00ODUg
RW5hYmxlLCBidXQNCnRoZSBjdXJyZW50IGltcGxlbWVudGF0aW9uIG9mIDgyNTBfZXhhciB1c2Vz
IFJUUyBmb3IgdGhlIGF1dG8tUlM0ODUtRW5hYmxlDQptb2RlIG9mIHRoZSBYUjE3VjM1WCBVQVJU
cy4gVGhpcyBwYXRjaCBpbXBsZW1lbnRzIERUUiBBdXRvLVJTNDg1IG9uDQpTZWFsZXZlbCBjYXJk
cy4NCg0KU2lnbmVkLW9mZi1ieTogTWF0dGhldyBIb3dlbGwgPG1hdHRoZXcuaG93ZWxsQHNlYWxl
dmVsLmNvbT4NCi0tLQ0KVjgtPlY5DQpDaGFuZ2VkIGltcGxlbWVudGF0aW9uIHRvIHVzZSBwY2lf
eHIxN3YzNXhfc2V0dXAoKSBpbnN0ZWFkIG9mIGNyZWF0aW5nDQpzZXBhcmF0ZSBzdGFydHVwIGZ1
bmN0aW9ucy4NCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvdHR5L3NlcmlhbC84MjUwLzgyNTBfZXhh
ci5jIGIvZHJpdmVycy90dHkvc2VyaWFsLzgyNTAvODI1MF9leGFyLmMNCmluZGV4IDM4ODZmNzhl
Y2JiZi4uZjRhNDY3ZDViNmFhIDEwMDY0NA0KLS0tIGEvZHJpdmVycy90dHkvc2VyaWFsLzgyNTAv
ODI1MF9leGFyLmMNCisrKyBiL2RyaXZlcnMvdHR5L3NlcmlhbC84MjUwLzgyNTBfZXhhci5jDQpA
QCAtNzgsNiArNzgsOSBAQA0KIA0KICNkZWZpbmUgVUFSVF9FWEFSX1JTNDg1X0RMWSh4KQkoKHgp
IDw8IDQpDQogDQorI2RlZmluZSBVQVJUX0VYQVJfRExECQkJMHgwMiAvKiBEaXZpc29yIEZyYWN0
aW9uYWwgKi8NCisjZGVmaW5lIFVBUlRfRVhBUl9ETERfNDg1X1BPTEFSSVRZCTB4ODAgLyogUlMt
NDg1IEVuYWJsZSBTaWduYWwgUG9sYXJpdHkgKi8NCisNCiAvKg0KICAqIElPVDIwNDAgTVBJTyB3
aXJpbmcgc2VtYW50aWNzOg0KICAqDQpAQCAtNDM5LDYgKzQ0Miw0NCBAQCBzdGF0aWMgaW50IGdl
bmVyaWNfcnM0ODVfY29uZmlnKHN0cnVjdCB1YXJ0X3BvcnQgKnBvcnQsIHN0cnVjdCBrdGVybWlv
cyAqdGVybWlvcw0KIAlyZXR1cm4gMDsNCiB9DQogDQorc3RhdGljIGludCBzZWFsZXZlbF9yczQ4
NV9jb25maWcoc3RydWN0IHVhcnRfcG9ydCAqcG9ydCwgc3RydWN0IGt0ZXJtaW9zICp0ZXJtaW9z
LA0KKwkJCQkgIHN0cnVjdCBzZXJpYWxfcnM0ODUgKnJzNDg1KQ0KK3sNCisJdTggX19pb21lbSAq
cCA9IHBvcnQtPm1lbWJhc2U7DQorCXU4IG9sZF9sY3I7DQorCXU4IGVmcjsNCisJdTggZGxkOw0K
KwlpbnQgcmV0Ow0KKw0KKwlyZXQgPSBnZW5lcmljX3JzNDg1X2NvbmZpZyhwb3J0LCB0ZXJtaW9z
LCByczQ4NSk7DQorCWlmIChyZXQpDQorCQlyZXR1cm4gcmV0Ow0KKw0KKwlpZiAocnM0ODUtPmZs
YWdzICYgU0VSX1JTNDg1X0VOQUJMRUQpIHsNCisJCW9sZF9sY3IgPSByZWFkYihwICsgVUFSVF9M
Q1IpOw0KKw0KKwkJLyogU2V0IEVGUls0XT0xIHRvIGVuYWJsZSBlbmhhbmNlZCBmZWF0dXJlIHJl
Z2lzdGVycyAqLw0KKwkJZWZyID0gcmVhZGIocCArIFVBUlRfWFJfRUZSKTsNCisJCWVmciB8PSBV
QVJUX0VGUl9FQ0I7DQorCQl3cml0ZWIoZWZyLCBwICsgVUFSVF9YUl9FRlIpOw0KKw0KKwkJLyog
U2V0IE1DUiB0byB1c2UgRFRSIGFzIEF1dG8tUlM0ODUgRW5hYmxlIHNpZ25hbCAqLw0KKwkJd3Jp
dGViKFVBUlRfTUNSX09VVDEsIHAgKyBVQVJUX01DUik7DQorDQorCQkvKiBTZXQgTENSWzddPTEg
dG8gZW5hYmxlIGFjY2VzcyB0byBETEQgcmVnaXN0ZXIgKi8NCisJCXdyaXRlYihvbGRfbGNyIHwg
VUFSVF9MQ1JfRExBQiwgcCArIFVBUlRfTENSKTsNCisNCisJCS8qIFNldCBETERbN109MSBmb3Ig
aW52ZXJ0ZWQgUlM0ODUgRW5hYmxlIGxvZ2ljICovDQorCQlkbGQgPSByZWFkYihwICsgVUFSVF9F
WEFSX0RMRCk7DQorCQlkbGQgfD0gVUFSVF9FWEFSX0RMRF80ODVfUE9MQVJJVFk7DQorCQl3cml0
ZWIoZGxkLCBwICsgVUFSVF9FWEFSX0RMRCk7DQorDQorCQl3cml0ZWIob2xkX2xjciwgcCArIFVB
UlRfTENSKTsNCisJfQ0KKw0KKwlyZXR1cm4gMDsNCit9DQorDQogc3RhdGljIGNvbnN0IHN0cnVj
dCBzZXJpYWxfcnM0ODUgZ2VuZXJpY19yczQ4NV9zdXBwb3J0ZWQgPSB7DQogCS5mbGFncyA9IFNF
Ul9SUzQ4NV9FTkFCTEVELA0KIH07DQpAQCAtNTYwLDYgKzYwMSw5IEBAIHBjaV94cjE3djM1eF9z
ZXR1cChzdHJ1Y3QgZXhhcjgyNTAgKnByaXYsIHN0cnVjdCBwY2lfZGV2ICpwY2lkZXYsDQogCXBv
cnQtPnBvcnQucnM0ODVfY29uZmlnID0gcGxhdGZvcm0tPnJzNDg1X2NvbmZpZzsNCiAJcG9ydC0+
cG9ydC5yczQ4NV9zdXBwb3J0ZWQgPSAqKHBsYXRmb3JtLT5yczQ4NV9zdXBwb3J0ZWQpOw0KIA0K
KwlpZiAocGNpZGV2LT5zdWJzeXN0ZW1fdmVuZG9yID09IFBDSV9WRU5ET1JfSURfU0VBTEVWRUwp
DQorCQlwb3J0LT5wb3J0LnJzNDg1X2NvbmZpZyA9IHNlYWxldmVsX3JzNDg1X2NvbmZpZzsNCisN
CiAJLyoNCiAJICogU2V0dXAgdGhlIFVBUlQgY2xvY2sgZm9yIHRoZSBkZXZpY2VzIG9uIGV4cGFu
c2lvbiBzbG90IHRvDQogCSAqIGhhbGYgdGhlIGNsb2NrIHNwZWVkIG9mIHRoZSBtYWluIGNoaXAg
KHdoaWNoIGlzIDEyNU1IeikNCg0K
