Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11022010.outbound.protection.outlook.com [52.101.51.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBAC7CF03
	for <linux-serial@vger.kernel.org>; Wed, 21 Feb 2024 21:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.51.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708550213; cv=fail; b=jhk9YiJsVKcDESSLd7Cc2v3qqfhl1pGv7Croaw/j7Z4tN0J2sfkf15BYZhkBD0k3Z8LEYoPA8jV4lxzSbRJwzO7M4BCQhoPcdp1rvT2HLNe17Yri4lqyjSBhngkeF4aKZQkNTy1iz7w8e9HirzPLw73lQW5Gyfdpg/Aw3w0H7c8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708550213; c=relaxed/simple;
	bh=RQgcbECZFwrItfisQjP83ZqiWd7iRaK5GceeHN3Z+TM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SfXkAcdP7L7O8x7QPYzGVr9bQtRCC8UoIppd7vu17Pnhqmyny6SooClyBHJ3MVUq8dznn/rv20oJZRLaJWZVGu8dgSSNyVgCqMLQNjhgYa7cGNH4C4OkC2VKKODrAnRthBGGCeLF0NvXU6gf9r/Yts0/ivVHUydqGo4R5QYKnjI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sealevel.com; spf=pass smtp.mailfrom=sealevel.com; dkim=pass (2048-bit key) header.d=sealevel.com header.i=@sealevel.com header.b=kkNhgQEF; arc=fail smtp.client-ip=52.101.51.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sealevel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sealevel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sealevel.com header.i=@sealevel.com header.b="kkNhgQEF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AVIagxgrseA/dmomk/ALYtbV9AQVrIKGMm1Z16j2cNtuDPFKKv5AsRROc2kMTIf0IMo7dSBVFzYlNKR1uOZ4hw2LZ1keu66bzQsjRHEb20QgG8rclJ4T0N8qUMP59YpnyZaI+U8ubfl2ID553nOwDHrnu0AKfJVCemaEwhfNRGjhoJFwD53txYOYgH4GqEUt5VN4Jtp1sO9veDy0F3eXr/f5MQ9hLXFhEOlQVxia70+87M77rVl7zQX6QEhvhb498Eva/+xcplgOBNYWMdfzLXIsZOK3444nZh+YlEdWKpLFDek+qFR7R/OJYKJDDxCQ8y8PX+WjJ1imMhuI2naBYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RQgcbECZFwrItfisQjP83ZqiWd7iRaK5GceeHN3Z+TM=;
 b=nW4D5r+ROBFaaP4nzt56n3y9a9dC+YPUZOdCRwTcrwle7kAS8P63nmzWmjebPNrYCaHtGCE9rkjU0oCX1mUUDyNZ6Za3f1L3cuPTj+VOOrzySqXa1a5WxcwC+CFLnu1n09j1xVQpHX4bYtWXyet9OESHI08x+2g2q8WVBZIj/Pw/GpmZ86s9R6pWMTO2mH8ED/CITBQvlrqJ7p7LmtAgmoqeljsnOExD89FcfU7JCjlqwFRmzdn0ayR+fAuAVCqbsA+3pBIjK6ZZ+nRQt2ggWQTzkzvH/2L1tcXdpzvZvHZEDfWMSkfJ46RLOj+s+sS0w8/+umI/ts4ap10H/9Gw3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sealevel.com; dmarc=pass action=none header.from=sealevel.com;
 dkim=pass header.d=sealevel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sealevel.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RQgcbECZFwrItfisQjP83ZqiWd7iRaK5GceeHN3Z+TM=;
 b=kkNhgQEFYVrw4LHU6Z+lxjwBlofb/IwWxrmYjsYHEREujQZIY2mP9Wy4EyPyHBIl8S3w0Imwwu2r8Tp3+68/2b5KS0CNDqI6hixG4XVGHMlwaeyqrMtf9SYNiz1glO3HtCOUneR0dBJ5Sn6sGQyaILd7qqP9kYlIakX/VkyeCDAjAxmgAODwlI0QdE5gQettkywTudvJPc9A/tpopHrM3Gwu44rdeFvXueQXlE37cEH0PVlwR4Wmm+A5JRnacpVzsmS8nvwCvLlhOfr7mSHoSrmLQIyEYieoCV8fEHULI9yHC86ij5KTvJKV7sx5NKUxr1wI7z19ckG5ID3yaY5LKQ==
Received: from CO1PR05MB8426.namprd05.prod.outlook.com (2603:10b6:303:e5::11)
 by MW4PR05MB7844.namprd05.prod.outlook.com (2603:10b6:303:68::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.42; Wed, 21 Feb
 2024 21:16:46 +0000
Received: from CO1PR05MB8426.namprd05.prod.outlook.com
 ([fe80::30e8:8b68:6b23:106b]) by CO1PR05MB8426.namprd05.prod.outlook.com
 ([fe80::30e8:8b68:6b23:106b%4]) with mapi id 15.20.7292.036; Wed, 21 Feb 2024
 21:16:46 +0000
From: Matthew Howell <matthew.howell@sealevel.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Darren
 Beeson <darren.beeson@sealevel.com>, Jeff Baldwin
	<jeff.baldwin@sealevel.com>, Ryan Wenglarz <ryan.wenglarz@sealevel.com>
Subject: [PATCH V2] serial: exar: Preserve FCTR[5] bit in pci_xr17v35x_setup()
Thread-Topic: [PATCH V2] serial: exar: Preserve FCTR[5] bit in
 pci_xr17v35x_setup()
Thread-Index: AQHaZQtGjPOmrNLBp0ShUL1okzQC6w==
Date: Wed, 21 Feb 2024 21:16:46 +0000
Message-ID: <a9519d301f542c921260b11b4576cd68cc929b52.camel@sealevel.com>
References: <5dd9f8b0c1dc154c73fb883cb948768ae68d1ccb.camel@sealevel.com>
In-Reply-To: <5dd9f8b0c1dc154c73fb883cb948768ae68d1ccb.camel@sealevel.com>
Reply-To: "5dd9f8b0c1dc154c73fb883cb948768ae68d1ccb.camel@sealevel.com"
	<5dd9f8b0c1dc154c73fb883cb948768ae68d1ccb.camel@sealevel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sealevel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR05MB8426:EE_|MW4PR05MB7844:EE_
x-ms-office365-filtering-correlation-id: fb54630c-99c9-4d3f-7980-08dc332268fa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 +LLeknaVU+MwcRNIRF/WpbSFEUk6vzZF8yTfswvMdsHr3/LA19DCyTznDv2wQfvSHydeLMiKdeT0qMOHLi01CJTZUkowg4UTuthzRRHdSrHbg3AARtzCxrCm3XJ/In9ak0M7PRSCHU6+xUFGtAbDCkyhp8NTTbchLrQE0fWeZ9yU9dyo1Y8ndawzGrVyzZPsFIiFm0X9pNIaEf+fEVSKuBPes1EuNRLJx1wR+re4tbvxHypjRPuCwNsfZYdGecOi5vMe3hirI5c80mtWY27MMee5OITUOtbgGy3YmaWUdm7Wxr7cQY5FfeouPO+j94CO8d2B7EyYVybpHFURAv4OM1h5KFnKIRqCEVGHExWXZsgWMJ5l05INCiPPL6W/IBrDUsbpucPJNdiRrNjLJZUxIY+MKYqtIjlEHmFTDXn/jymaStG566VnxOBdncMJVMFRDMGdKOGjrWXV6L5YtHAbySNva9meaO0FI9SblmP/mmPVRdlwA1R8E84b9ZvLcjBxBKGuo4C4018rK6i/zg/lphsw6jwDE8T2hQy9l1gA4JHZCsLPPp05rJYYZkZHh7TRRPjJz+Wu7hcKpjYDRAEg7Nf2nmmvCPN/F4sMpFXq1bV2plI8EqHwLwYc41YhsVW2
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR05MB8426.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ck1Cd3huVWcrdVRKQkIyVnpTUmpHeWlmK3FsQ1E0VE5iSlkyL01SbHNxWW10?=
 =?utf-8?B?ZHE5RXdFeFpQK1hybTZqY2wvRXZPeXBSUUFMS1BHUHRJRFpYWXpZQmVLOTlt?=
 =?utf-8?B?K01vOS9mYjZIa3I3RnQyL3hmSFRvdnNMU1E4aW1KaGZyb2dIYTRxeGFQeXVT?=
 =?utf-8?B?dEtWWFhCYVl4SGtyQWY5Sk5DUDhCbC9JR2R2S2NIK3Z3VHY0U3JLalBycm9D?=
 =?utf-8?B?SExhUUVnL0kvTml1ZDlicXZaUmZXbldJUk9DR08rbHh6WTl3bGJMcVE3dnBt?=
 =?utf-8?B?QnRSSGZ3OGJpUVdBMGVBOVFJMzVtMklJVXNwS2p0KzN1UC8rOUFnM0xQTUkv?=
 =?utf-8?B?MGluU1ZoaWxHS0lVT2VoMkZsNkxydTQyUTZ0bEFVQ3NHOFJ1TjBYVWJTbWdW?=
 =?utf-8?B?TkZRK0Q3Z0t0RmFNMnp6ZUxRMXBZcGlCcmEyeGRwR0ROdGs5QzRDVVg2QkE4?=
 =?utf-8?B?cFc3anBaY2t1eVpqNi9ZUTBXRHd1blErYTA4Ym9xTlIvMEkwYUIwOUViSTFv?=
 =?utf-8?B?MFlvaGZ0TGtJRDhZNGNMb3lGdUtYQXg3dldBeU5nMjFSY3BWcTBQSUVlTm16?=
 =?utf-8?B?aDlYRUt4OC9OTTNkR1Y5dXBGVzBibXVaZHZLcFNnampmaW1tL2ptazI5cTZ3?=
 =?utf-8?B?dkxwckd0OVFqcE1LVEhPVk9CRXNZU2RBOTJENjd2SEMrTlhiZkJwQjFidnc0?=
 =?utf-8?B?V1QrNFhlUGF2eitzS2FsVXdVcmEzRjMrK3R3eVRndzZqRjlQRE00bndtbElJ?=
 =?utf-8?B?Q2lQanJDUlg0ZmxEeTRJQk1XMjAzT2h5YkxMUlNyT2lQSm9zM3d5SlBwRklY?=
 =?utf-8?B?VDRCWExtbFZmcy9QNTg3eEd0T0FUaVErbzhzY2dKMEhYSWdVWFRqRWkwY0p1?=
 =?utf-8?B?YnRFdEo3L1ZKL2QwVnVwRWxDTlFLNm5xS0Z5TFRtR0dqTGd4RFNjVkJDNkFF?=
 =?utf-8?B?OStQU0Z4dDBWMEIvYkZMdXppZWQ2cFBOSlRWU0d2OXlGL2N2S1RZWXVuVFlx?=
 =?utf-8?B?R1lKTzYvOXFjYWZiZTltZ2d1ODE0WElPSnVGaFJyMHE1MjFnS1RHTE1Layta?=
 =?utf-8?B?aDlrSFhkczFmQ0Y1K0RNQ2s4Y200S1AzbXJhMkpadW9RckMwK1dJQTErTmZY?=
 =?utf-8?B?ZXhQenFzU0QvSEVYdWlXMDI4ZVA0NnRuRjVZeGFzU0VKN2lBUjlvcnlQRUhV?=
 =?utf-8?B?NkxFK3VuVmJSVVQxUmN2TXJKTWoyN0VYYWVVam1KcWkrbVdIUUgwdDd1anZj?=
 =?utf-8?B?M0c3S2Y4SkI1OXVRRmRUMnJkc3JjaFY5NHNFNDVNUms5SXljUHhxV012cDFx?=
 =?utf-8?B?WWo4WGFxNUZpYXR0eWVzTEQ4WnppUW1YcFE0WU9xeUFhR0NnWWxMeFFqMHhh?=
 =?utf-8?B?MlRiNm1KTzBnalF4S05UTnBLS0l6ZkhuenNhRk04K2NBa0EzdXBXNGF3MTRE?=
 =?utf-8?B?cGMwQVMvR0djRTFRbWhsdVpIT0ZTNWJkSnp1aGMrNkxFUXRlUktUaVQ3c1E3?=
 =?utf-8?B?Ylhqc2VrV1I5Q3VlL3gvazY2dUdUa0VIbGFsaUZqNG5BakFxcmhpSkJFRlo3?=
 =?utf-8?B?MDhHeGhFOFh2QTVycHp0c0RxR0h5ekgyWkRadXBIc25jRjVwZEJCb2liUWFY?=
 =?utf-8?B?SXJuQmlJdWtNQ0FIWDNncUovbjFLV1lIQWwvZ0phMFRNamtxbzRET1EwK3VL?=
 =?utf-8?B?MDNvdWh3a2RjYURXSVViQ1JmVzBRRWNDV1R1Y24vellVd09kV281UkcwVDdu?=
 =?utf-8?B?QnRFK0d4WFpHSHhUTFFsbi8rWlRlNXFVb01HUktabFFvTk1MOUgzMWJsSWVp?=
 =?utf-8?B?aUIzeGxTd2tFMVJvQjVyQnJSSExqbjJSNEw2VXhHalN0QzUrVWpVZ29EM1VC?=
 =?utf-8?B?ZDJXV3dHT0pxWHNuYVBhZnMvN3E1Slk0SUIzc1FWNmN3citvV3YvOUJUMTJR?=
 =?utf-8?B?aTFHOXB0bU4zd0hRR1dJQkZmaUNMd1RMTUVDaHIzSzlSRmI3Mm53QTN2TTVY?=
 =?utf-8?B?dFczRUx0YmRKek04WGFIVDZCc1VZTXBmd2MzN0wrQU5DTSs5ZzhqaXBrL1J4?=
 =?utf-8?B?WTFHdkVaZVkwRk9KbnVUSjV1RWNVeFBkenl2TGRtYTdOV0RkZi8vZkY2OC9t?=
 =?utf-8?B?eVI3NmN4Rjl6dkQ3VjdpVzhaTXBEa3I2MEtLakNjTXpjRUxQN25ST01aY0tQ?=
 =?utf-8?B?TUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0240CDC2BC36914480A3AFC9AEAB6925@namprd05.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fb54630c-99c9-4d3f-7980-08dc332268fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2024 21:16:46.2395
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e34c5615-b4e3-481c-abc8-602581f2e735
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zLIx1vuVduY/d7zyYfNQhJ5OXhneZv7IUsbL8kr+heQsACzkmQOGS30GLH09SXmoOibAWdFer6dNZtz3ipyrqq8fBYQPSrkEKDMKubsu0lo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR05MB7844

QWxsb3dzIHRoZSB1c2Ugb2YgdGhlIEVONDg1IGhhcmR3YXJlIHBpbiBieSBwcmVzZXJ2aW5nIHRo
ZSB2YWx1ZSBvZg0KRkNUUls1XSBpbiBwY2lfeHIxN3YzNXhfc2V0dXAoKS4NCg0KUGVyIHRoZSBY
UjE3VjM1WCBkYXRhc2hlZXQsIHRoZSBFTjQ4NSBoYXJkd2FyZSBwaW4gd29ya3MgYnkgc2V0dGlu
Zw0KRkNUUls1XSB3aGVuIHRoZSBwaW4gaXMgYWN0aXZlLiBwY2lfeHIxN3YzNXhfc2V0dXAoKSBw
cmV2ZW50ZWQgdGhlIHVzZQ0Kb2YgRU40ODUgYmVjYXVzZSBpdCBvdmVyd3JvdGUgdGhlIEZDVFIg
cmVnaXN0ZXIuDQoNClNpZ25lZC1vZmYtYnk6IE1hdHRoZXcgSG93ZWxsIDxtYXR0aGV3Lmhvd2Vs
bEBzZWFsZXZlbC5jb20+DQotLS0NClYxIC0+IFYyDQpGaXhlZCB3b3Jkd3JhcCBpbiBkaWZmDQoN
CmRpZmYgLS1naXQgYS9kcml2ZXJzL3R0eS9zZXJpYWwvODI1MC84MjUwX2V4YXIuYyBiL2RyaXZl
cnMvdHR5L3NlcmlhbC84MjUwLzgyNTBfZXhhci5jDQppbmRleCAyMzM2NmY4NjguLjk3NzExNjA2
ZiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvdHR5L3NlcmlhbC84MjUwLzgyNTBfZXhhci5jDQorKysg
Yi9kcml2ZXJzL3R0eS9zZXJpYWwvODI1MC84MjUwX2V4YXIuYw0KQEAgLTU5Niw2ICs1OTYsNyBA
QCBwY2lfeHIxN3YzNXhfc2V0dXAoc3RydWN0IGV4YXI4MjUwICpwcml2LCBzdHJ1Y3QgcGNpX2Rl
diAqcGNpZGV2LA0KIAl1bnNpZ25lZCBpbnQgYmF1ZCA9IDc4MTI1MDA7DQogCXU4IF9faW9tZW0g
KnA7DQogCWludCByZXQ7DQorCXU4IGVuNDg1bWFzazsNCiANCiAJcG9ydC0+cG9ydC51YXJ0Y2xr
ID0gYmF1ZCAqIDE2Ow0KIAlwb3J0LT5wb3J0LnJzNDg1X2NvbmZpZyA9IHBsYXRmb3JtLT5yczQ4
NV9jb25maWc7DQpAQCAtNjE4LDcgKzYxOSw4IEBAIHBjaV94cjE3djM1eF9zZXR1cChzdHJ1Y3Qg
ZXhhcjgyNTAgKnByaXYsIHN0cnVjdCBwY2lfZGV2ICpwY2lkZXYsDQogCXAgPSBwb3J0LT5wb3J0
Lm1lbWJhc2U7DQogDQogCXdyaXRlYigweDAwLCBwICsgVUFSVF9FWEFSXzhYTU9ERSk7DQotCXdy
aXRlYihVQVJUX0ZDVFJfRVhBUl9UUkdELCBwICsgVUFSVF9FWEFSX0ZDVFIpOw0KKwllbjQ4NW1h
c2sgPSByZWFkYihwICsgVUFSVF9FWEFSX0ZDVFIpICYgVUFSVF9GQ1RSX0VYQVJfNDg1Ow0KKwl3
cml0ZWIoVUFSVF9GQ1RSX0VYQVJfVFJHRCB8IGVuNDg1bWFzaywgcCArIFVBUlRfRVhBUl9GQ1RS
KTsNCiAJd3JpdGViKDEyOCwgcCArIFVBUlRfRVhBUl9UWFRSRyk7DQogCXdyaXRlYigxMjgsIHAg
KyBVQVJUX0VYQVJfUlhUUkcpOw0KIA0KDQo=
