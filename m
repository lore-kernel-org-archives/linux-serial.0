Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11021007.outbound.protection.outlook.com [52.101.85.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFB376058
	for <linux-serial@vger.kernel.org>; Mon,  8 Apr 2024 13:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712581908; cv=fail; b=Era2vZhAAJcANTial/XBfpAK8aQlx3TVFUcoUWBDgR1nkbvyXkVWiyUAeYIdE0HvWiAHAi5V9PoCr0JuTMHxOn7hgzQfLusPOMlqYtKaiZfRr3L7eEp+tkgDWyY9tN5eWPp7qPQ+JhVCY7eBDpZohLJTaPUABDTWsioWZm2SF04=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712581908; c=relaxed/simple;
	bh=NoSxO/6nXH6X+PVO/wwU2VEpBoQDex2cszR9xkIt/YE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ky94nzmi6DkI4PVzjVuHtt5mdgsgCu1KgokfsyvCv4iFiBrKbUZDd+8NY95uxenKQTrhIntHuuWjYVlSrkRh2iI6sbShf7+JyeqWWEgaATkRs/uHMaEXmALQGSNY8kcJ/y0ISIZ5deuqRbyFvuxzcGAAx2EAYcHQ06ghPzEm8Fo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sealevel.com; spf=pass smtp.mailfrom=sealevel.com; dkim=pass (2048-bit key) header.d=sealevel.com header.i=@sealevel.com header.b=U/wkvFp7; arc=fail smtp.client-ip=52.101.85.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sealevel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sealevel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sealevel.com header.i=@sealevel.com header.b="U/wkvFp7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YCmc02SiNmlahomwmTcI8sX8u3XRfYEQl08sB5UQHvLBiF1TOYCwRhTWTXH2dosTJs2n0FGH0YbWWMMD2/DbY9HJjLOrYSamOulxRkX9GhetSpX5ffvRnua3U4505y7uFNVMxSxmc9cJ/LVSSBAOFjIFor1KB4BiozR699BDWsxlixbWSmFa4Nbt0ERzKD1KVqZim5d2RmAOPkVCfDP1/ZVPjhLKFXY70P+KovB/YpGmWPfdhj+UrhPjlEMSHtHNTFTEBrdf1UZ5n14HKdgefVEoOFRmVcIOWC9uwKKhxDZsjoP1MtOGC2scuid3uBCCJlVrG31fk3Vj8h7xRHX9tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NoSxO/6nXH6X+PVO/wwU2VEpBoQDex2cszR9xkIt/YE=;
 b=O1Hk+/VaGatzb5s/YHRh6xCbV+GzA7m/0hD4vSjTN6dffjaAvutK82nrbubQ0MpN6Art1Qu7fSHkXtoxnRhM8eIl2mnG35O5cpcUOAa8OZmVnua0DUNuOdy0zpai/NAybZL3ESRU5wQyrPT7XPfShbiWYDL3L8+iKZoUINIBi/fqlOk9TNXCH0qzFCpdViwVRYZEhgcSpOAdHOSiKmTYWr0Cm7PP4tNIqQEzg8kHahW90kc9fUeT5sgCJvbeymHWWaUw0V8zXab9cWgPuW3q+LghT7d7tVqvDyMpSwvcb/jDWPM9vlYIPrmRqVPfTM2Ct8aahLd6ubn53yDobYIUsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sealevel.com; dmarc=pass action=none header.from=sealevel.com;
 dkim=pass header.d=sealevel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sealevel.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NoSxO/6nXH6X+PVO/wwU2VEpBoQDex2cszR9xkIt/YE=;
 b=U/wkvFp7N3kvMncsBFnonXChscoW57d3bCbdZ8XADx01JIP8nK8Z1xtsKOo5HtsqElnnKMqCkqwq/MQIvGKc/jqvxFs0wWKwMkacjewa7L8HMws92cBdN/MJOr3wshtP4ZqkJ6ANavJOjYEBp7Ww0QIut2j2VqJhKF9iRNxmLDuBFnegwGqcF+0Oe69KoZEA+UbP3H1+f9SyPNYCTYq1qdrI22Nwe9tw6IXr2Zf066UDA40cJV9mii5CYhlRy+rt6eyQurkvpjidN2oOtelJQIXNYEhf1PEzc0wiU7H21rgs/uUjvftXkdwfWeqgiFtxAiWGG9wxfKvU720Kh2D8jw==
Received: from CO1PR05MB8426.namprd05.prod.outlook.com (2603:10b6:303:e5::11)
 by SN7PR05MB7678.namprd05.prod.outlook.com (2603:10b6:806:104::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.53; Mon, 8 Apr
 2024 13:11:42 +0000
Received: from CO1PR05MB8426.namprd05.prod.outlook.com
 ([fe80::6231:d3c9:8cd3:4169]) by CO1PR05MB8426.namprd05.prod.outlook.com
 ([fe80::6231:d3c9:8cd3:4169%7]) with mapi id 15.20.7409.049; Mon, 8 Apr 2024
 13:11:42 +0000
From: Matthew Howell <matthew.howell@sealevel.com>
To: "5dd9f8b0c1dc154c73fb883cb948768ae68d1ccb.camel@sealevel.com"
	<5dd9f8b0c1dc154c73fb883cb948768ae68d1ccb.camel@sealevel.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Darren
 Beeson <darren.beeson@sealevel.com>, Jeff Baldwin
	<jeff.baldwin@sealevel.com>, Ryan Wenglarz <ryan.wenglarz@sealevel.com>
Subject: Re: [PATCH V2] serial: exar: Preserve FCTR[5] bit in
 pci_xr17v35x_setup()
Thread-Topic: [PATCH V2] serial: exar: Preserve FCTR[5] bit in
 pci_xr17v35x_setup()
Thread-Index: AQHaZQtGjPOmrNLBp0ShUL1okzQC67FeooGA
Date: Mon, 8 Apr 2024 13:11:42 +0000
Message-ID: <937e10172eaf46cbb6e355666e15ba33344f2c51.camel@sealevel.com>
References: <5dd9f8b0c1dc154c73fb883cb948768ae68d1ccb.camel@sealevel.com>
	 <a9519d301f542c921260b11b4576cd68cc929b52.camel@sealevel.com>
In-Reply-To: <a9519d301f542c921260b11b4576cd68cc929b52.camel@sealevel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR05MB8426:EE_|SN7PR05MB7678:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 XDFpsbs9Ev7gUWqsOKsFw2ADhY10853Y94KnL84x7gZxCRNL39BsGRoeXzqv0+uWPxt4uFQjjTQgMRsRfS3I2Ep1AGj6ysgIWKgby6Av5j0zr3zTfI62ea3VHbCHSFDvB5me7G3gOwUxSBqRnCezun/xLhHyPS0IiN9wpU82a1KxGQpP5UD6ezXc0nC1XXqF3ck27W9huNPeVuizmnC9kLcozTlhltUQSP8iDtM7fTkoAechMhKGrDGksBftBmHgYYNEacg+ZLmzIklHB6x7zk4aI5UFBDC+1pZ8ceREWErBGcd+oLWu/2ue5dk9N2Vg/JxYwj6739ypT4HHqdzAAq7YKxX33r88xYKbj8yT1e4h8SF8YjVm2kFfbfi1obuHcjDVM4MkauRavMsVNizd9Jh0HDlKOXg1qRBPAiturTlfjdP/B1cW2Rqmbg208S4dke0P3TiVn6T6wFFkusPNli4z8h+YRR8mL0K+Rmt5SOw7nT/d8cMCyx+r7xugYruks7VtyywmdseelL/f76hJDUq/ZuKYMYqbizpvZkByPnvMg8rl3Nt5Lk/QaLgIdis/EdaSsaYO0GlNUGE8/ZxYaJwxtIvDpOj1fHYV+UNu9VgTl+IdGUyriqkf1ZFL5BL8G7y0Oszmw/WWEJCNXHHfApHSNtshl9pOENHoDDCjJdw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR05MB8426.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eHVXcVJ1S0thVEpFcm9leWxEYzQ2VUNsb2JMdGIxSVNQd2piK0pvblRSUUlR?=
 =?utf-8?B?eW5saTVKWHJFMWZSNDk2MEpFME1lOEdPS0VWdEhTaURsYnUvK043cDNQRUVl?=
 =?utf-8?B?c3FBMjVkTk9odG1kUlBxVklINW5ES01VeGliTjVjODB3R2NWSzZNUCtTNTcw?=
 =?utf-8?B?Y25lWEgxZ0NrUmhkV2RNSnIrUFVvV3NGaFRzKzFPOUtmS0NISy9mMVpBbEdU?=
 =?utf-8?B?YzZRbnFaVmZ5TXF6VlF2MVpTWk8xeDBnaUk1VHA2NEtXZUdNd0dHSGZ1VzYz?=
 =?utf-8?B?WWFuc2ZrUG5vYUpmbkZraGhKYU9PMzMzR3V1S0lIeEhQYi9BemNpd1cwb1BS?=
 =?utf-8?B?N0wycGlERi84YjZHc3dPMXVVbHh6Q0RFTW5yRXZpcWR6aXlJMDEvWm9Xdkc3?=
 =?utf-8?B?ZExLRk5IZ25jRlhycEFhV1AvT1pnZEZpK0p2V1F5c1RvZldKRlp6dGx4bXZk?=
 =?utf-8?B?M1NjZ0lHaVVuS1JNcDE4QWsrK3ZQRHdhS2RHeThLcmhBaVlTYzVDU2h1b252?=
 =?utf-8?B?RG1SajBpYmUzSWJGKzNUQi9rRHNRdW84cStwczdKaXNXS2F4am5yNndQTWV6?=
 =?utf-8?B?MW5yVTIrZHczM1RJT0ZkMER1em5oQ3RLMS9FYjRFU1d5aG5SdTl2ejVpMlZG?=
 =?utf-8?B?ZkpnMnp3QUVOK2FON0JwODQzQmdySjBBOXg5T2RNbG1zRWVBLzN2bVk2amxs?=
 =?utf-8?B?RzRBTmNTeHc4V2lMQ0wyOENTWU1TbzBKY1dxcDZmamdQSWg5NWZvejB0RzFz?=
 =?utf-8?B?VkZIUFRTeWgxd2VrTWlnR0ZQdFNrVjNYSU13VTJkRS9XVHFtOVlidHZRNTJq?=
 =?utf-8?B?bUlFaGxPV0VWTXBNUmRDa2NFRFc2ZWxzVG5SbTh5dVpFc2M1bUE5Q2ZlS1NQ?=
 =?utf-8?B?b1ZwUStuVS9kMHZ2Tm1Rc1RpcytkVWRjUFB6bHMvbmdMcVJSN0dIcTFqdDZI?=
 =?utf-8?B?OU9Sd1J5KzVhd21KVFpYWlN4czNrTS9iNFVWWlVyK3RCUFJ0UjdINjA1MVBw?=
 =?utf-8?B?Vm9Pc0JJQXg3QmQ3c0RxdnNQREdoOElFOG1OSVM0Y1o0dVpDRDlCR05yQ3NE?=
 =?utf-8?B?YnJTREs2YmVyTzNieHNCOC9LK3hFVUJmTmRRUmdld0J4RGhiS1lZd0FBZnlz?=
 =?utf-8?B?bkJ4YmpvaEduK3VmTWFUdVpUQXl3RkZrcjRsbmlCQ0s1MGQ5MmtCeVFBdThV?=
 =?utf-8?B?VzJQNjRKOEc4NVZqS2xkbk0yQko0RmlIU1FXU1puaHcrMS9ZS0I3cnljdGdI?=
 =?utf-8?B?TXpXRFRDUzdsUTNGTU5FL0hscVcwU1QrOHdaRmJkakY0NGZpVnRpV3VuVm5Y?=
 =?utf-8?B?V1Y3S1BWZHN1ajJWZlNwUHFjY3dZUXY0ZTdyQUdqZEVreGQ1aVBsd0RWSDRV?=
 =?utf-8?B?clNlWGlzUG5IRi9zam5IcGpHeGZTN2NNOFNtY3I2YWE2R2ZwcURTbVo0RnVy?=
 =?utf-8?B?R0Z6TmcxUUxsVXdXS1pTMXdSZ1dmOTM0RjVFUFBnWGZkbE9sb3VpQ2pqRHN6?=
 =?utf-8?B?NUQrM0duOHBLZ3dIdFJ4V1ZkK3cyMmZ1TDU4dS9UaW5MNFNSVkxxU1dGYVc5?=
 =?utf-8?B?Nm56K2hNQjdqcWJxMllHTlhVVGUxZ3k5aVRvTEoyN0ZiUWVYZ1FZMWxwcU8z?=
 =?utf-8?B?cTk4OE5pelNQeWp3VldZekhSVjVFVHpOemU4a3FDWDVEbi9hMEEzWW1OL204?=
 =?utf-8?B?RDlZQXlIMFdLaHgyVHpMT3VCcnA2TEJ2QzEzVEcyek0vNjZTVWt3VkhHdDNy?=
 =?utf-8?B?bThGOVRpVmhTbjRMUzRCdU1qK3lEK0pCK05UUFpEdzUvQUx6WFRKNzVsRG8y?=
 =?utf-8?B?SThqMzFkdUxDcFNwQURSazdTaERmZks4MVlpV0k2OFRqYkZxeEErVXY0MDN6?=
 =?utf-8?B?c004ZU4yczhNL0ZUZm16a0Y0T0JOWDI5elpUa2dPdGZVYzAxei9iSzhVVHQ0?=
 =?utf-8?B?bVFseDUzaTlxMDM4NktHTTdHNG03TlRLRVgzYWNaSlZHbWJ4UVRKd2YvTUdR?=
 =?utf-8?B?Um9iNTlFK3VCYitNVGRGeloyNVNVaHRIK05tcjRWKzlNRjl6S2ZxeXhjemF5?=
 =?utf-8?B?SDNLY3QrU2tlRVpUSXhrVUc1ZnhMZDdONUt5dXJBS2pDWEpWbWVIa3o1SWMz?=
 =?utf-8?B?UkR2MjhyQ3U0TndWTzVKKzdHam56S2Q2aUYxb0k5N3NsTDhCTDdPU3k2eXFT?=
 =?utf-8?B?QUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4250B3E192335041958F1775E4396BB3@namprd05.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e5a23880-8d1a-4bd3-890d-08dc57cd6f25
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2024 13:11:42.3987
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e34c5615-b4e3-481c-abc8-602581f2e735
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BHT2OFE3lmxB+B77TD8soSx8eNSlEqU98yeY227c6HKwr9eI1pnq+bFFQ3Nn0feL3aOzg8hD7HZZcGqHNq8NQvWMBVJ3dxodMZvIyWgPQqY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR05MB7678

T24gV2VkLCAyMDI0LTAyLTIxIGF0IDE2OjE2IC0wNTAwLCBNYXR0aGV3IEhvd2VsbCB3cm90ZToN
Cj4gQWxsb3dzIHRoZSB1c2Ugb2YgdGhlIEVONDg1IGhhcmR3YXJlIHBpbiBieSBwcmVzZXJ2aW5n
IHRoZSB2YWx1ZSBvZg0KPiBGQ1RSWzVdIGluIHBjaV94cjE3djM1eF9zZXR1cCgpLg0KPiANCj4g
UGVyIHRoZSBYUjE3VjM1WCBkYXRhc2hlZXQsIHRoZSBFTjQ4NSBoYXJkd2FyZSBwaW4gd29ya3Mg
Ynkgc2V0dGluZw0KPiBGQ1RSWzVdIHdoZW4gdGhlIHBpbiBpcyBhY3RpdmUuIHBjaV94cjE3djM1
eF9zZXR1cCgpIHByZXZlbnRlZCB0aGUgdXNlDQo+IG9mIEVONDg1IGJlY2F1c2UgaXQgb3Zlcndy
b3RlIHRoZSBGQ1RSIHJlZ2lzdGVyLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTWF0dGhldyBIb3dl
bGwgPG1hdHRoZXcuaG93ZWxsQHNlYWxldmVsLmNvbT4NCj4gLS0tDQo+IFYxIC0+IFYyDQo+IEZp
eGVkIHdvcmR3cmFwIGluIGRpZmYNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3R0eS9zZXJp
YWwvODI1MC84MjUwX2V4YXIuYyBiL2RyaXZlcnMvdHR5L3NlcmlhbC84MjUwLzgyNTBfZXhhci5j
DQo+IGluZGV4IDIzMzY2Zjg2OC4uOTc3MTE2MDZmIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3R0
eS9zZXJpYWwvODI1MC84MjUwX2V4YXIuYw0KPiArKysgYi9kcml2ZXJzL3R0eS9zZXJpYWwvODI1
MC84MjUwX2V4YXIuYw0KPiBAQCAtNTk2LDYgKzU5Niw3IEBAIHBjaV94cjE3djM1eF9zZXR1cChz
dHJ1Y3QgZXhhcjgyNTAgKnByaXYsIHN0cnVjdCBwY2lfZGV2ICpwY2lkZXYsDQo+ICAJdW5zaWdu
ZWQgaW50IGJhdWQgPSA3ODEyNTAwOw0KPiAgCXU4IF9faW9tZW0gKnA7DQo+ICAJaW50IHJldDsN
Cj4gKwl1OCBlbjQ4NW1hc2s7DQo+ICANCj4gIAlwb3J0LT5wb3J0LnVhcnRjbGsgPSBiYXVkICog
MTY7DQo+ICAJcG9ydC0+cG9ydC5yczQ4NV9jb25maWcgPSBwbGF0Zm9ybS0+cnM0ODVfY29uZmln
Ow0KPiBAQCAtNjE4LDcgKzYxOSw4IEBAIHBjaV94cjE3djM1eF9zZXR1cChzdHJ1Y3QgZXhhcjgy
NTAgKnByaXYsIHN0cnVjdCBwY2lfZGV2ICpwY2lkZXYsDQo+ICAJcCA9IHBvcnQtPnBvcnQubWVt
YmFzZTsNCj4gIA0KPiAgCXdyaXRlYigweDAwLCBwICsgVUFSVF9FWEFSXzhYTU9ERSk7DQo+IC0J
d3JpdGViKFVBUlRfRkNUUl9FWEFSX1RSR0QsIHAgKyBVQVJUX0VYQVJfRkNUUik7DQo+ICsJZW40
ODVtYXNrID0gcmVhZGIocCArIFVBUlRfRVhBUl9GQ1RSKSAmIFVBUlRfRkNUUl9FWEFSXzQ4NTsN
Cj4gKwl3cml0ZWIoVUFSVF9GQ1RSX0VYQVJfVFJHRCB8IGVuNDg1bWFzaywgcCArIFVBUlRfRVhB
Ul9GQ1RSKTsNCj4gIAl3cml0ZWIoMTI4LCBwICsgVUFSVF9FWEFSX1RYVFJHKTsNCj4gIAl3cml0
ZWIoMTI4LCBwICsgVUFSVF9FWEFSX1JYVFJHKTsNCj4gIA0KPiANCg0KSGksDQoNCkp1c3Qgd2Fu
dGVkIHRvIGZvbGxvdy11cCBvbiB0aGlzIHRvIHNlZSBpZiBhbnlvbmUgaGFzIGhhZCBhIHRpbWUg
dG8NCnJldmlldyB0aGUgYWJvdmUgc3VibWlzc2lvbj8gUGxlYXNlIGxldCBtZSBrbm93IGlmIHRo
ZXJlIGFyZSBhbnkgaXNzdWVzDQovIGFueXRoaW5nIEkgbmVlZCB0byBkby4NCg0KVGhhbmtzLA0K
TWF0dGhldyBIb3dlbGwNCg0K
