Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11020003.outbound.protection.outlook.com [40.93.193.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B4112EBE9
	for <linux-serial@vger.kernel.org>; Tue,  9 Apr 2024 13:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.193.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712667666; cv=fail; b=qD0pGQi0fCFNFdNI2ZFvtcXJKrg/Lvg1FywchAeMalkXidT3l9PYfF0idqBLAponJQ1pHqhyVjsI5GPS68pdYNcC+x7z1BoUFcg7BFQf6mnEWosMV3GnRCnqwSGkU459QShcW2fYRM2q227XjFD+uB23Dyhrm+le4s79SOgHjWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712667666; c=relaxed/simple;
	bh=Gw7Fm5vYbIEeEJc2UhCDn4m0DsxpBFQzBgaA00SW0LM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Z8iZPTDZEtisJxG4Hpw49DVL3bP9myIf8lQIrEHuylGSsfuZvRA/zPs5aeV+H7hDwAcexuRsJJyIOqXhGVFMFQPxmL6j9Mi3zFf7WBPBdyP4h/E8LYlnfxvHG0ZkbOJQntMCmN/Rf91GB0DxF6TSncRNy/SSXpcRh9TQNhmw0IE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sealevel.com; spf=pass smtp.mailfrom=sealevel.com; dkim=pass (2048-bit key) header.d=sealevel.com header.i=@sealevel.com header.b=Xxjj4ZR9; arc=fail smtp.client-ip=40.93.193.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sealevel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sealevel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sealevel.com header.i=@sealevel.com header.b="Xxjj4ZR9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lIFJ8Ev19y2V28rPr+CScM6d5SHfRTM4LXIe4Q65Twh948pTBkSqdiO/Mut0aSF+v11obVd+brbyWH2JfNYlNjH0ZosMTizgYpKZlTBwEdbBiWfnBhUZuMM9VHxreakWlCij+hxC9ak3G0cqAwqvUDJxX5EtRttwdvTPA8/957kNYlGP7WKghi252EKzJ73pzVbX+t6SNf29KrlWATUJZgkGh1n3Y2V7IeNhWdEZUlNDBGOajnBr8kcSD9P+NO0VDEJestnX+gw+z0VOOi7PkY6uFFqz8jaYnd8wKKaSiIPtPe3T/nmmLEXXg82wCrAEUS+AJWxpg5BS6lIL4ZFgPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gw7Fm5vYbIEeEJc2UhCDn4m0DsxpBFQzBgaA00SW0LM=;
 b=hek+t+P4+Mp2hm8OPeXamu8NJQfKUtuNd8QG2Ai2Bf3E2Z6zyWEkZsjr5LLl5+8q/uWMs3BDxEgvcOVwsW6C+p6kwMKiN/SLgRuf+DOC4pUagqsmH9mWr+RL+eOKteXLfcYSrA6x9D7n9hmKETXJitGPX4hX4joNJtCweml0PYnmJJjFQ5I7gJ0uGd1YcCKX74funnGLzWdDycp/SGqiAH6ZNfSNWa8jv7Jby0BT7TX3CkNoVhmovLD1AXuD2PH4u+YBTCS6MmvStuPwPaXyTdZNlFpQCjoh0WglikUH7jpKfDDeh/lGunyH5J7jfZXslM0C6bcVvx7i9oR2pPSaIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sealevel.com; dmarc=pass action=none header.from=sealevel.com;
 dkim=pass header.d=sealevel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sealevel.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gw7Fm5vYbIEeEJc2UhCDn4m0DsxpBFQzBgaA00SW0LM=;
 b=Xxjj4ZR9DxnZ1OYC6MC0QOfbed/XU9oZd/48nJmT2owTcOJFhjCcqt9i0V4807FdYM4PAvPmGnZ7Mx0lENSGkHfPz3hoEHaEZJXElu14960/yMrCk8vJ5UpRXy/3pM4sCXjTzUs2/gKYuN+GrYAQaAjmdhjVvdzr9REF8+2yDXMA7NCSy+O+3qUpUdgyXsHYFFIfGYpdozVnHuYlqDxo9EsO2qtu9kESvT4dnTCtddB5Ep49t0vxOz6uthIQrbWj2IQhDrTA53A55pth+meXghqmi75jWAG38+fHGQi4MIhSnQrXYoDGrFl9pUCOMIxwnJVAdUda4izTCS3d4o6a5Q==
Received: from CO1PR05MB8426.namprd05.prod.outlook.com (2603:10b6:303:e5::11)
 by PH0PR05MB8901.namprd05.prod.outlook.com (2603:10b6:510:d8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.54; Tue, 9 Apr
 2024 13:01:00 +0000
Received: from CO1PR05MB8426.namprd05.prod.outlook.com
 ([fe80::6231:d3c9:8cd3:4169]) by CO1PR05MB8426.namprd05.prod.outlook.com
 ([fe80::6231:d3c9:8cd3:4169%7]) with mapi id 15.20.7409.049; Tue, 9 Apr 2024
 13:01:00 +0000
From: Matthew Howell <matthew.howell@sealevel.com>
To: "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>
CC: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Darren
 Beeson <darren.beeson@sealevel.com>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, Jeff Baldwin <jeff.baldwin@sealevel.com>, Ryan
 Wenglarz <ryan.wenglarz@sealevel.com>,
	"5dd9f8b0c1dc154c73fb883cb948768ae68d1ccb.camel@sealevel.com"
	<5dd9f8b0c1dc154c73fb883cb948768ae68d1ccb.camel@sealevel.com>
Subject: Re: [PATCH V2] serial: exar: Preserve FCTR[5] bit in
 pci_xr17v35x_setup()
Thread-Topic: [PATCH V2] serial: exar: Preserve FCTR[5] bit in
 pci_xr17v35x_setup()
Thread-Index: AQHaZQtGjPOmrNLBp0ShUL1okzQC6w==
Date: Tue, 9 Apr 2024 13:01:00 +0000
Message-ID: <ddd5d277dad10667bf47d01141b667f320e8ce78.camel@sealevel.com>
References: <5dd9f8b0c1dc154c73fb883cb948768ae68d1ccb.camel@sealevel.com>
	 <a9519d301f542c921260b11b4576cd68cc929b52.camel@sealevel.com>
	 <ZdaAI4uZ1Byx2cWs@surfacebook.localdomain>
In-Reply-To: <ZdaAI4uZ1Byx2cWs@surfacebook.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR05MB8426:EE_|PH0PR05MB8901:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 XF0Bqqf/B6qXLZVwXWXhrLmP1rDKGST/mwbOg4azyx01P1TDBWauv5ToMFfYo1BmedH6Z21JMspSl16wXurUrDnDqZ03tMwS+dOIDfV5kc5JpkKsw8dLIOzcoC2DBVp+uopp/i4txCY+Yj2Vth2BZFPLLrMccgtlv/O4qjjWD2Dx3YEsiWujMlS1GIFRwris+GUxKkZ/935QqoAIq7kEY2oRrunC9MizuFnpw+N5PToO94QvUXawqMAbVYyF0g6+oGeSLLg+jA+ncUHRVR/I3cC3zkXwuEMUb0ndpdxnDOovJvc+8AlfInENfu/UIH0OgpkFkVrFNhWPbMo5aOzEYH+IKXOVb5lZXCvD3bW9yVSKG1wBIWAsy4sVpEALi9TFq/2yG3ctVYFJ0Atb2+FWI6a+Qt/FGtn93wigY0P+YmC8wej387M+78i448FeAFA3g5lMhWjMKVM5AfmK0/O/GCayO0+T+25oDaTGUxLh0OXd8fc96GS8mncCQnsTD3u92JYHIzlJEj6FGw/FUQ0iTQifX8SSuWn3AmzfzF5YakBgEQBAH5UL0bxPcIQvN/EpPXyz4Vc1XbGZicO/Qne1KSKcXzZvwe2PxvAVcDudbM9Ff6TUv6bQfWxqohAzPGbSti6TgBfKtzN11SBsjqQe2q7u2Yxij7zFoQocA4BgZUg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR05MB8426.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OGtqU0QrcTRnTk10OC91QkpsRTRCN2lYdE5XbXNYU1g0QVlPSE44VmNscmtt?=
 =?utf-8?B?cHk5clNmR2JzaW1TZ21iYjdaaTVlR1dOT0NITDN3cWpSQjVoOFErYmQxZTFi?=
 =?utf-8?B?WTJRc1JZbUxyYkRMcnJDVmVwVzZWOW1KOHk3VVA0dDlJSm02VFh0U1NZMVNm?=
 =?utf-8?B?L2tsY1A5VDRaMEdiS09BdXhsNTBPdngrTjFFNCtXamJKMGZUZzFJSFZ0U0Js?=
 =?utf-8?B?cDIwQmdVMDBBbDhkY1JHTXBJWTlxOFNjcEtxdlEyRkc5Z1Y1Unk5b3REaklF?=
 =?utf-8?B?UFJ4QURsSFJIcVRRcEFHSmJuSDNEdVZDenllelZVSGtwUE5LTTU2dHdIbGFM?=
 =?utf-8?B?RkROM29lY2xkaVUzdzhxK0xJV0VidWNsMFR1NHNmbmp3VUNKSFJ5a2lQR3NY?=
 =?utf-8?B?d25kUTJPN1IrSnoyeTM5VC9raWFFUElkYjExVVhLOG4zRDR5UTR4RENic0c2?=
 =?utf-8?B?SmthUnI2ZXdSV3diTE9TMGphSG80Tk9BSnU5K1UwcnkzWlR5dGJLeWpxUzJv?=
 =?utf-8?B?SDMwL2FFY1hMMEUwVEVwRWp2YXhuY0dhUW02SzJnMjNQYTc5MXM4Sm01UUlr?=
 =?utf-8?B?N2Q4SUFGYnZ0dzdsd0JRdW53Nm9pbjFsbjN2ZkY5Zjl4NE4rWGRtVGI4R2hN?=
 =?utf-8?B?cm9yc1o1Z2daTzJKTEQzd0FtRklJYTExZlNWaFZ1VlIzYmVYeldBSVlneTNB?=
 =?utf-8?B?NzZCdklET1lxM2g5NGJJdmQ1Tk1mSDg0VmRiWTNIODNrdDhNRVgzRXA1cnUy?=
 =?utf-8?B?MDl0czBtdmFLWHZETENsQUJxUHF4U29uUC9NNXI1bVhtdEU1dGNQcStabkJi?=
 =?utf-8?B?YVVtUWFIQmdWS2dDUFNZcGtFRjNvOUxDOFZPQjhpNTF0UFdjOUZ2bmF2bkg3?=
 =?utf-8?B?UWFES1I4RTNVTWFpQjUvZ0cwNUFuc0l3NlA5NVR1SzhzOFdZWFo3dUwydndZ?=
 =?utf-8?B?TWhiNEtQa2hsckpKcXY5R3U0SzFLeHZHT001eFNnSHpBd0wyWklpOUxpVGZW?=
 =?utf-8?B?Ri9EZHY3ZGoxdzA5ZGRaS0VvTHU0RmxoZTZsbVBUWllVTVlnMlIxeHFVK2kz?=
 =?utf-8?B?dnJ1bFdxdytWTjNsYzNkbnlXcDhOeVNSZG9KUXpIcE5aM2F4ZE85SVpXWVJU?=
 =?utf-8?B?ZnVJT1BuZk10YThOd3RDbjNZNHFEZWNrU3pyZjI2alB5MUwvbDlCeFpORkEv?=
 =?utf-8?B?QzZFT1dIM2tRSUVyOGtpS21RdHZ3ZGdWTWZKdHJDOXJ5aTVSWGVWRVRDcmpH?=
 =?utf-8?B?eUpyRGw1aU5GMTRoWkhYM21wRXArOVVTUHpZSE1pZGxaNHl0aGROQkVIdENY?=
 =?utf-8?B?TUlUNzhQOGxlRFBTUXptYnhPYndEeld2QnhGbmc3L1RQbkNReldMUnU0dU1F?=
 =?utf-8?B?eURIRyttTHRVUHB3SE4vamZSRkR5cGZkNjZ5clFIa01vQnI5UFltc1F2MDJk?=
 =?utf-8?B?OHdQZGVlSEJYN2EzdG0rWmpxYzJ6U0RLaTlaV1Aya1dReXRzcElKeTl0Tlo5?=
 =?utf-8?B?ZU1WRHQzc0pJb09Gb1ZCTXBoVkgzeHdJY3dLMUE5c2Zra2o1cm8weUFVL3J1?=
 =?utf-8?B?UDRhMnlSS0pVYmZ2czVhSVpKekZvOGwzb1AzWTB1K04zWHJjeWRjdTB3OUdj?=
 =?utf-8?B?N1NDNEtIbmdtZFNEVE9ISlBDWjE3Y1JlRytPZkZyb0hKU09udVZZRDhhVnJl?=
 =?utf-8?B?dlNrdk5nTmIvZ3JpZyt4bDNUQVI5eXJkSHJXT2d4VVRVWW4zUDZlVGlIaW9k?=
 =?utf-8?B?cnNIYTlxVmlHOGY1OHM0OUhTV3QzNTYvRkx3bUd2REt3TTVtRW0xT0dWMGhP?=
 =?utf-8?B?RFNuVW9TcVgyUnVGekl4ZS94b3RYekt1Yk5ObXhWRmh1eVVsUkJhOWZuZlRI?=
 =?utf-8?B?K282YkQ0eVBrNER5ZUZ6WFZabkRkeVQxUC9xd0x3eTZFVmw0NXNCK1YvWHZU?=
 =?utf-8?B?QzNZd3cvakFkVUlyYTFXYVl2aURneGZDL0pnN05uZjBFa2ZxTTJHWW45RHo0?=
 =?utf-8?B?ZGpuUlFOb2hNY1FnczRuMHJlUC80Sk52ZVU2aTN4ajI1UGtvck5wNVk5UVZM?=
 =?utf-8?B?ZElFVWFMai8wdUtkYWVNdjlXL1JBY2p0Q3ZYT3UyK0pCd0NWQmNQbWNaeTdL?=
 =?utf-8?B?dGRwOWtSWXBrTFdqYkEzVFlPOG8rbDhxVmtlZmNmdytzb1NrdUs1TFdNMTE2?=
 =?utf-8?B?Vmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <84E7100A7CD5B5489A751A253E6D011F@namprd05.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bb71cb35-b467-44ef-cae7-08dc58951b26
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2024 13:01:00.8258
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e34c5615-b4e3-481c-abc8-602581f2e735
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GfqAFbRTr2kbfRLR1ngqymkSfvqxxSjT52cYKNATzUT84z1mwMnB/6IIKNVf31GlkJAVFcy3mWv5Iav7IfkEx5vy6qzP7nIg1ZL3iqI4Zz4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR05MB8901

T24gVGh1LCAyMDI0LTAyLTIyIGF0IDAwOjU4ICswMjAwLCBhbmR5LnNoZXZjaGVua29AZ21haWwu
Y29tIHdyb3RlOg0KPiBXZWQsIEZlYiAyMSwgMjAyNCBhdCAwOToxNjo0NlBNICswMDAwLCBNYXR0
aGV3IEhvd2VsbCBraXJqb2l0dGk6DQo+ID4gQWxsb3dzIHRoZSB1c2Ugb2YgdGhlIEVONDg1IGhh
cmR3YXJlIHBpbiBieSBwcmVzZXJ2aW5nIHRoZSB2YWx1ZSBvZg0KPiA+IEZDVFJbNV0gaW4gcGNp
X3hyMTd2MzV4X3NldHVwKCkuDQo+ID4gDQo+ID4gUGVyIHRoZSBYUjE3VjM1WCBkYXRhc2hlZXQs
IHRoZSBFTjQ4NSBoYXJkd2FyZSBwaW4gd29ya3MgYnkgc2V0dGluZw0KPiA+IEZDVFJbNV0gd2hl
biB0aGUgcGluIGlzIGFjdGl2ZS4gcGNpX3hyMTd2MzV4X3NldHVwKCkgcHJldmVudGVkIHRoZSB1
c2UNCj4gPiBvZiBFTjQ4NSBiZWNhdXNlIGl0IG92ZXJ3cm90ZSB0aGUgRkNUUiByZWdpc3Rlci4N
Cj4gDQo+IEZpcnN0IG9mIGFsbCwgcGxlYXNlIGF2b2lkIEluLVJlcGx5LXRvOiBmb3IgdGhlIG5l
dyB2ZXJzaW9ucyBvZiB0aGUgY2hhbmdlLA0KPiBpLm8udy4gbmV3IHZlcnNpb24g4oCUIG5ldyBl
bWFpbCB0aHJlYWQuDQo+IA0KDQpBcG9sb2dpZXMsIEkgZGlkbid0IG1lYW4gdG8gZG8gc28uIEkg
aGFkIGNyZWF0ZWQgdGhlIHJlc3BvbnNlIGZyb20gYQ0KInJlcGx5LWFsbCIgaW4gbXkgZW1haWwg
Y2xpZW50IGFuZCB0aG91Z2h0IG1hbnVhbGx5IHJlbW92aW5nIHRoZSBpbi0NCnJlcGx5LXRvIHdv
dWxkIGJlIHN1ZmZpY2llbnQgdG8gY3JlYXRlIGEgbmV3IGVtYWlsIGluc3RlYWQsIGJ1dCBpdCBz
ZWVtcw0KdGhlIGVtYWlsIGNsaWVudCB0cmllZCB0byBiZSAic21hcnQiIGFuZCBrZXB0IHRoZSBp
bi1yZXBseS10byBhbnl3YXkuDQoNCj4gU2Vjb25kLCB0aGUgYWJvdmUgY29tbWl0IG1lc3NhZ2Ug
c291bmRzIGxpa2UgYSBmaXguIERvZXMgaXQgZGVzZXJ2ZSBGaXhlcyB0YWc/DQo+IA0KDQpZZXMs
IEkgYmVsaWV2ZSBzby4gSSBoYWQgY29uc2lkZXJlZCBhZGRpbmcgdGhhdCBhbmQgZG9uJ3QgcmVj
YWxsIHdoeSBJDQpkZWNpZGVkIHRvIGxlYXZlIGl0IG9mZi4NCg0KPiAuLi4NCj4gDQo+ID4gIAl1
bnNpZ25lZCBpbnQgYmF1ZCA9IDc4MTI1MDA7DQo+ID4gIAl1OCBfX2lvbWVtICpwOw0KPiA+ICAJ
aW50IHJldDsNCj4gPiArCXU4IGVuNDg1bWFzazsNCj4gDQo+IFBsZWFzZSwgcHJlc2VydmUgcmV2
ZXJzZWQgeG1hcyB0cmVlIG9yZGVyLg0KPiANCj4gCXVuc2lnbmVkIGludCBiYXVkID0gNzgxMjUw
MDsNCj4gCXU4IF9faW9tZW0gKnA7DQo+IAl1OCBlbjQ4NW1hc2s7DQo+IAlpbnQgcmV0Ow0KPiAN
Cg0KSSB3aWxsIHJlc3VibWl0IHdpdGggdGhlc2Ugc3VnZ2VzdGlvbnMgaW4gbWluZC4NCg0KUC5T
OiBTb3JyeSBmb3IgdGhlIGxhdGUgcmVzcG9uc2UsIGZvciBzb21lIHJlYXNvbiB0aGlzIGRpZG4n
dCBtYWtlIGl0IHRvDQpteSBtYWlsYm94IGFuZCBJIHdhcyBvbmx5IGp1c3QgbWFkZSBhd2FyZSBv
ZiB5b3VyIHJlc3BvbnNlLiANCg==
