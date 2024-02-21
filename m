Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11022010.outbound.protection.outlook.com [52.101.51.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F221E485
	for <linux-serial@vger.kernel.org>; Wed, 21 Feb 2024 21:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.51.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708549618; cv=fail; b=l/bTRZulcIfLImloN7nae3Ifi8FXxPOuZ/sj+NZMfuws81OM42vM6j57iAlMed4KmSD4LcExkFJ/WxDRbKY+VEiRpacLBOLpGrcVOlb5ao3R2ma7BUqJlZ6WXtS50dTizZa/MHHhBh2L87bFKq5JzR+bIiTgDpZq3/M+aH56ogM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708549618; c=relaxed/simple;
	bh=QXWQTqSQL2LG+7R7PbY8j6A76xB1LEjXFFQ+1FjHE0c=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=lFZouVguHDGdXNVzJx1V5+siW4/1sd6/2mQ1ar7dwfMcwp3kmWeDdrDfqc+1hpWiawfUqYqmU5491Mp9uhAy9BkQysQ5mPG/m5K1oZ/8V+CC3H1Bz7xZ3XEJn6vytGm/2QC8UGmEUhPhhVTYsEVXODU5Un712gq67epIHWzDeUo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sealevel.com; spf=pass smtp.mailfrom=sealevel.com; dkim=pass (2048-bit key) header.d=sealevel.com header.i=@sealevel.com header.b=kROu4wTB; arc=fail smtp.client-ip=52.101.51.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sealevel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sealevel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sealevel.com header.i=@sealevel.com header.b="kROu4wTB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DrFYjpIKWDjZydR+uJ7blSVfAoMUz9ZhX0FF9r23pTPW5aufIf8n8Wlm/HbGUujKTe7b4D+d74ml0mLer+cWkdJD7dwzMW0nN3oRHOJLD4Glc7dZ2QhQMC9IeGFaBugSjlWh+Rvcam927M47PuuLmsOci1WCj1XwuveAnpa2YkS+EbGCKBvvE+bdHeei5QDMEprfJ7cx36HnDGoX3OJl2+UwCFZzoFbQaz0L21qqnwHur8S6RW+Hqp2Y7lP78k5XYJRGicstJqHQpguNk0uPIiBLqKSQX0+fQu+UiwZzkb/lPavLHORkNULkQYDEYYen6uebR8vBaPDOyYfrOFUreQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QXWQTqSQL2LG+7R7PbY8j6A76xB1LEjXFFQ+1FjHE0c=;
 b=WHynvKCuUKRtQAJv6E3JVtQ7iKHYQhQB7TPhaanwugZD6v/e8twVXi0OhCra80JthAitPCEtonRB37Dpdtl3sLNbunGyrHyE3+suIcyLZREFOQlOlsIYzSzONmFdYUZ0imkcUB95S+msfyZ1NdsY8pJbXhNe8Cn4TYCq7jlioZPgj66jBZMfq1OnDm5lpC1NwtgtyscrkMQtI/6Ni8o7gbCs+CBp5hB4SoHDF4K7lcBgQNTdH/Hw9XFxYRyDJuMtu8lGhhW3F/bMxEq2KRS2kTzlfmceSIC6kGl85he0SqgXpLy73ORjF2MBCubcFwl+23840KFPMrzn4nF43Xjcxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sealevel.com; dmarc=pass action=none header.from=sealevel.com;
 dkim=pass header.d=sealevel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sealevel.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QXWQTqSQL2LG+7R7PbY8j6A76xB1LEjXFFQ+1FjHE0c=;
 b=kROu4wTBnS61zRDXFkjk2fjk2BuwfmOmL9m3oe7OEAS9UK5i/92zLRw1w2C2jexsozPg3HJdzyyAkA0XWXF48pcIrRTcyYGaMY5MVoBJyOkxgGduC3L6zXf3bZTZkTf3DoAzJVd06+pMGiQJ3+dTIpyoIGifFfDP6/3yvpJT7OF4WKkyOK5bqtaEbN6ThDLcJVAAowOiMhMpFz01iMFkZ9TMF8sc4z7QO/FLAMTR5IUU4yLbujg3iT3BjFMgXNZCvuxD3QkDqhqjqlnYw+gOnPmDhcbQL6YIsZGNtR2E1GzaBTp+0iCqKW6m79QsAx+z8Ho8U9aCIIKTsDOfYFcdvA==
Received: from CO1PR05MB8426.namprd05.prod.outlook.com (2603:10b6:303:e5::11)
 by MN6PR05MB10284.namprd05.prod.outlook.com (2603:10b6:208:472::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Wed, 21 Feb
 2024 21:06:49 +0000
Received: from CO1PR05MB8426.namprd05.prod.outlook.com
 ([fe80::30e8:8b68:6b23:106b]) by CO1PR05MB8426.namprd05.prod.outlook.com
 ([fe80::30e8:8b68:6b23:106b%4]) with mapi id 15.20.7292.036; Wed, 21 Feb 2024
 21:06:49 +0000
From: Matthew Howell <matthew.howell@sealevel.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Darren
 Beeson <darren.beeson@sealevel.com>, Jeff Baldwin
	<jeff.baldwin@sealevel.com>, Ryan Wenglarz <ryan.wenglarz@sealevel.com>
Subject: [PATCH V1] serial: exar: Preserve FCTR[5] bit in pci_xr17v35x_setup()
Thread-Topic: [PATCH V1] serial: exar: Preserve FCTR[5] bit in
 pci_xr17v35x_setup()
Thread-Index: AQHaZQni6YLKSBv0XEusKKVSEBlyog==
Date: Wed, 21 Feb 2024 21:06:49 +0000
Message-ID: <5dd9f8b0c1dc154c73fb883cb948768ae68d1ccb.camel@sealevel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sealevel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR05MB8426:EE_|MN6PR05MB10284:EE_
x-ms-office365-filtering-correlation-id: b76fda0e-8acb-4d46-c81a-08dc33210549
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 OjDmxUMJvlpCmUv+5gmRZhQFTjCPaYOmxI59AzFXCAY3jK12jlqbYrxxpSxRIoM5T7QHPWtSis321q/sOxb8BR7eoyDnsjhwdDgVIYeBvBpTnfJXVJA4r90kSDbCn0wLW/tCd1lnwKFHHWonyJ9UFsKKfS51okEJwVXHADZGnO3zeVst60qM87pUNC8ZAO7p7Yc5Ej4PaZi9PLobM+eNllDaDVX5F0rzs5DxmF5Djqe4vroHuCkx/jKWr/dWaGhUyyyXVmp1T4bfhtU9qFX/tCCMpMU7Bp3sqxBV/jgwfgf06fMh2Um4jIVysnJxScfcbH7UxZ2xDaZYTuTBgTfD6J4aGSDJTo2joQcpgX3RPE45aJdAqJR1ZNE1Nf3Gg7YepuLSnbJ3uV6LzuTULQm3u+BjuMtkmxGUYLwUn6jRKZ8QcOhVscrNthE1Ckqd4+ntcWTRxXA85/HAHn4srwIYpV1zMBsxfEux2pV9o54gRnYvIff5ODrNYgKZBTiV6V8wIU/8BMCjOK/Jk3touAQoAhd1HpU7+6SmDXxgcE+YHm7WocuJB5F89IF1k10ZHE4GJR6A49Efnr51VLtRaACFcJdb2Hjsmvt2FIY8iSa+g4ZtG7LWGC3GhZE8I7ENimps
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR05MB8426.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RTNiZ25DV2dhR29FK0lzbDdBQnV3UDRTZDJ2cmJDcG96TkpFUld2REd3NTN2?=
 =?utf-8?B?T24rL1BzeTlKb2NzYUZjNmtJM3hDeDZycm0yNGYrQ1RDb2hCNlhJSXkwN2pq?=
 =?utf-8?B?bVBsTENyWng0cHdyQ2lQR1pDMHRsU2hGbCs4RWI4SStwTDN2cFV3d2FFbTRk?=
 =?utf-8?B?SFFJVnZWV1JwTXA1SjZvVmREalVnakc2NDBzMEwyaUpTSW9HZ2ozRVIrVHF6?=
 =?utf-8?B?QjcxRzVDRW9FV1ZTd2ZTZU43amxiZWc2V3BGeHVENVFsRzU5N1NDNGRVSHRW?=
 =?utf-8?B?SzlNYXFhMXAvOFRzb0t1UDNZWVdtK2c1OE5TT1JyWDUyVkNzL1RNT0RtUGxF?=
 =?utf-8?B?Uy94bWhDdzhLRVBpTDdiQWxwWkt2OUUwNyszS1FGcVNmYThrNnlkNDZrRUNJ?=
 =?utf-8?B?WTNlRS9uL05hNUJteDJrTWRWU2dueTYzNHpJaG1BeWMySjAzZGp2T0s4Q080?=
 =?utf-8?B?MmZLSC9PVVF4Um54M0NUS0hUVVEvbGEwRjRrSWF2eHZiY2c4NzI5K04vMkhV?=
 =?utf-8?B?L1B1MFhLRm12ZktoUFhaY3UrcGw4aW9sMnB2RGJXVTYyOWs4ejcxczRtK2dV?=
 =?utf-8?B?Y25jVVh6dkJ0cll2YzV0UEVQTkx0WldndlhuRDdNaDcrdkFUdllOVEZjZmR0?=
 =?utf-8?B?M21yTkhYcVp6aDJsSE90ME5uZGNjWkMyK282Ujc1cHB1YTVybjNnKzVaeUhY?=
 =?utf-8?B?UXFldTBCRW5jRHVOWVhmRUFCb2tPSmlpOGs2RWl6aUZFYVhiNnhrZklCNFZS?=
 =?utf-8?B?anlITWg2dWI3Rk9hRFBRSzg4YVRXanNMalg5eDhwZUxwZVVMQjhoTm4wc3l2?=
 =?utf-8?B?eE4ydThOK0swN2prUmdlRzVxRUIwNWwzZkZSUVh1YVJCVC81QjhRYktWOXZT?=
 =?utf-8?B?MENkOENNcTBJdUlXeE4vSDQxckptT0t3SDBtSFBSN1RiTWVDaXVkNlJ5NjhT?=
 =?utf-8?B?NW9uZmhzQU56NWlPSGpwek1QNStFSGhONUk3Z0t6VjY4bHlvS2JncUFiQkZ1?=
 =?utf-8?B?WTNlWlByWlk1RDM0U2I0TElOWitDMEtXVWJnZnlxak1OS1p4eEd3ZExBemU5?=
 =?utf-8?B?bXpQL3V5alJpNi94d0g4R2pKRStlT0JaVC9jZ0FpUjMxdkhjMmxnMG14ampw?=
 =?utf-8?B?eS80aXMwbFJESzBsSXk5dUhMR1c1bzZLVzcxRGd5azdIbi84eFppcE1ickE4?=
 =?utf-8?B?NzJRVzM3RWo2K1dOWk5uYzhrdTBHUTJza25OUndUQitFSmZXZnBQUGtKT3dE?=
 =?utf-8?B?cVhPL2xCTjhBSFBmYXR4V0FRVUhiaVJCL0JsSjhuWk9jN1dTaDcvTE9xK0hP?=
 =?utf-8?B?eVlnQXd2c3ZubW1NZkgyM1lwQk1MZ0NsU3hwNmtBODVxUkxYMzBvdExNeERo?=
 =?utf-8?B?eG83N2U3YXBqVnBUWHFCWStPbG1BNHdlZ2pwajUyV3BWdDdkNy91TkZwYWVZ?=
 =?utf-8?B?bTlyZ2Vrc2VTL2JoMFpYUEJleU1pemN5NWRwVzhnMmRYc2dQT2l3dTNJRHZp?=
 =?utf-8?B?YXVheWxrUUN4Q3k0SGdXZ2lyVmFRQ3MycS9DcTBndUFwOVRFUTZiNnlic2ZD?=
 =?utf-8?B?K20xVFdjZTFEalYwRUNxWTkweHFmNW5QTU9qSUV6eUU0M2s1S05yQklwRzVh?=
 =?utf-8?B?ZDBJcU12QjU5eDROSXBMS3JNMEJYdGNMSm5BRDdjVFFWSi8yRjJpeDNYbjQ0?=
 =?utf-8?B?R0ROYzlKUjlOYzhrcXdjYVZjSW9aaThCaXN5dmU5NmdGc082eFBJSkphZmpO?=
 =?utf-8?B?ZFA5UWVsQUFyUWUyL3EyM29JUk9rQmtrdy83QkJaVldETm13eFQxQmJaOUND?=
 =?utf-8?B?MU5oRlFXaUp4NlJhbkxoWnZ6OXQxaGw2OFIvMzlDL01ONVhlUXdUQ2V6S3pB?=
 =?utf-8?B?eXNqTENjNHowc1A0WjVzQTlzT0RKSHRJZlJNVEJONUZmOHE2Wm9Nd0FhWGRG?=
 =?utf-8?B?a2F6T1UySVZPeDY0Y3VGME52OEViSkpodnNnRkYxck81OFdPZ1RaekNYdTVO?=
 =?utf-8?B?SkZtRlVPRWd4bHl5Qm9HUFM1RlRxaEZURWZTVk4zOFVPbHFiN2hCRkpZZGZP?=
 =?utf-8?B?eHpZeEdRaC91ZkRGckVvTC80U0hHRjFMMytLWFErZkFpQmFNS3ZDR3JhOXlR?=
 =?utf-8?B?OFVYRnNYQmkrUlJtQ1NGdDRLZzYzT2U4RHh6V1k2M2pLQ1o2ZjFzNnpjT3V2?=
 =?utf-8?B?NVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3698828D2319964EBBAFD37A8A45396A@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sealevel.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR05MB8426.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b76fda0e-8acb-4d46-c81a-08dc33210549
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2024 21:06:49.5005
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e34c5615-b4e3-481c-abc8-602581f2e735
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u/6J0kHZicPsYGXl2tu2TkLDd9eRr8hR4AG/eV7WIoPoEGQlzKc3vH7xmUtkHSWrinnme4yTCOsmFtvC5ktK8hh+sRyaZo0nehMLSOuCm2s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR05MB10284

QWxsb3dzIHRoZSB1c2Ugb2YgdGhlIEVONDg1IGhhcmR3YXJlIHBpbiBieSBwcmVzZXJ2aW5nIHRo
ZSB2YWx1ZSBvZg0KRkNUUls1XSBpbiBwY2lfeHIxN3YzNXhfc2V0dXAoKS4NCg0KUGVyIHRoZSBY
UjE3VjM1WCBkYXRhc2hlZXQsIHRoZSBFTjQ4NSBoYXJkd2FyZSBwaW4gd29ya3MgYnkgc2V0dGlu
Zw0KRkNUUls1XSB3aGVuIHRoZSBwaW4gaXMgYWN0aXZlLiBwY2lfeHIxN3YzNXhfc2V0dXAoKSBw
cmV2ZW50ZWQgdGhlIHVzZQ0Kb2YgRU40ODUgYmVjYXVzZSBpdCBvdmVyd3JvdGUgdGhlIEZDVFIg
cmVnaXN0ZXIuDQoNClNpZ25lZC1vZmYtYnk6IE1hdHRoZXcgSG93ZWxsIDxtYXR0aGV3Lmhvd2Vs
bEBzZWFsZXZlbC5jb20+DQotLS0NCmRpZmYgLS1naXQgYS9kcml2ZXJzL3R0eS9zZXJpYWwvODI1
MC84MjUwX2V4YXIuYyBiL2RyaXZlcnMvdHR5L3NlcmlhbC84MjUwLzgyNTBfZXhhci5jDQppbmRl
eCAyMzM2NmY4NjguLjk3NzExNjA2ZiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvdHR5L3NlcmlhbC84
MjUwLzgyNTBfZXhhci5jDQorKysgYi9kcml2ZXJzL3R0eS9zZXJpYWwvODI1MC84MjUwX2V4YXIu
Yw0KQEAgLTU5Niw2ICs1OTYsNyBAQCBwY2lfeHIxN3YzNXhfc2V0dXAoc3RydWN0IGV4YXI4MjUw
ICpwcml2LCBzdHJ1Y3QgcGNpX2RldiAqcGNpZGV2LA0KIAl1bnNpZ25lZCBpbnQgYmF1ZCA9IDc4
MTI1MDA7DQogCXU4IF9faW9tZW0gKnA7DQogCWludCByZXQ7DQorCXU4IGVuNDg1bWFzazsNCiAN
CiAJcG9ydC0+cG9ydC51YXJ0Y2xrID0gYmF1ZCAqIDE2Ow0KIAlwb3J0LT5wb3J0LnJzNDg1X2Nv
bmZpZyA9IHBsYXRmb3JtLT5yczQ4NV9jb25maWc7DQpAQCAtNjE4LDcgKzYxOSw4IEBAIHBjaV94
cjE3djM1eF9zZXR1cChzdHJ1Y3QgZXhhcjgyNTAgKnByaXYsIHN0cnVjdCBwY2lfZGV2ICpwY2lk
ZXYsDQogCXAgPSBwb3J0LT5wb3J0Lm1lbWJhc2U7DQogDQogCXdyaXRlYigweDAwLCBwICsgVUFS
VF9FWEFSXzhYTU9ERSk7DQotCXdyaXRlYihVQVJUX0ZDVFJfRVhBUl9UUkdELCBwICsgVUFSVF9F
WEFSX0ZDVFIpOw0KKwllbjQ4NW1hc2sgPSByZWFkYihwICsgVUFSVF9FWEFSX0ZDVFIpICYgVUFS
VF9GQ1RSX0VYQVJfNDg1Ow0KKwl3cml0ZWIoVUFSVF9GQ1RSX0VYQVJfVFJHRCB8IGVuNDg1bWFz
aywgcCArIFVBUlRfRVhBUl9GQ1RSKTsNCiAJd3JpdGViKDEyOCwgcCArIFVBUlRfRVhBUl9UWFRS
Ryk7DQogCXdyaXRlYigxMjgsIHAgKyBVQVJUX0VYQVJfUlhUUkcpOw0KIA0KDQo=
