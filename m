Received: from FR6P281CU001.outbound.protection.outlook.com (mail-germanywestcentralazon11020136.outbound.protection.outlook.com [52.101.171.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14460370AFC;
	Fri, 22 May 2026 08:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.171.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779438246; cv=fail; b=u3BT8tiXZkwEjIINWX9OKhw5SYRvmHKojHpy0bP7VALXvncZTIP0MTQQBcyQMKS4bM2TwWMo9cWngxios8Ar6TsuSZxpG9fHgPJt3BftmlcbJ0/fdkbZK2slqXFe3tKHv/10umLpled4ZxLrySEeLLN8rhNT/s1BedX1/a6EzdA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779438246; c=relaxed/simple;
	bh=gW6BAIb2xyfc+ptclYT1nrwL+TIr6/dLyC6Q5HZo+Dk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=f7nd+ZdW9AkBGCm5CrxneI8nzOkFKh0DZpXAJ4mcgB/QDsPK5oSVUSDpUdC5tOv3z7yryABUdGyohdhQ43lj5YPPrbpdBulismtKFBpcZ11Kti5l/sD23iSq831KKB2z8mmymYjzcyuHhPZexTmAkABSAb5J4PafKg8HkS44jr4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=KBSgmbhfr.onmicrosoft.com; spf=pass smtp.mailfrom=KBSgmbhfr.onmicrosoft.com; arc=fail smtp.client-ip=52.101.171.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=KBSgmbhfr.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=KBSgmbhfr.onmicrosoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oBvTx3x4d24yxJ+kZwM+4DdjDdJUkglwTUuH66W73Nwppyo6Lzx5YH7wu0DSU29sQxQcFDvMxQJM/0ZiVwUPVFpE1yQsd/rr8CwRSmvhlZiT4b76GGHAV69iQm/1X0P7XmF3nrFzY5HONAraup3RrFYIXoX4Hmuw3/HnRfOrHpLyp0aDgIUlD/KWQE91KBARzzArZS5q9jNgCVZ7cUibWNJKg08F8AOmgVlsVbDY+jLpnb+ODStAP4TLP6DNgx4s8AoZDUyF/gxDC04aq2SLt9epYNemb90W0oNgte2uEu5rX4xYz8gjRol53FUAQ1Tm3EWIe4TSzylbYzDfuGN5Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gW6BAIb2xyfc+ptclYT1nrwL+TIr6/dLyC6Q5HZo+Dk=;
 b=MFcT0x6R8h5bzk9yGYP3O0UR+1cceFwymlTHBBJgXW2HdZ/WN5uphXi9Arxe/xLjwUj3d+sd+HvWKMF/gp/S5o3l8tTwdUbQboWCaJgr/vinHRSEK8eDIykxKoocCzQDNOjraY65oSgn6cda2lRYYMYtwyd8pRPNrN6Cefe494ZQD4Dv5MqjwsFi2iT2YXH3atzzVI8LeAE8Y+JmbImDkP+4l/Bm/InjJALKnA93kgbSmVe3P0iDFesX3UkB+Hyn5UhVHcYjCXJuDVenbh3UAPOLuwDVuoKyHERYlun0HCV9cwkkuyeoYEd5NI6kJGYHMhPaZfk/WaABGS7OUQGLzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kbsgmbhfr.onmicrosoft.com; dmarc=pass action=none
 header.from=kbsgmbhfr.onmicrosoft.com; dkim=pass
 header.d=kbsgmbhfr.onmicrosoft.com; arc=none
Received: from BE3P281MB5515.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:de::17)
 by FR4P281MB4678.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:144::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 08:24:02 +0000
Received: from BE3P281MB5515.DEUP281.PROD.OUTLOOK.COM
 ([fe80::fce2:69d7:2d84:7d9e]) by BE3P281MB5515.DEUP281.PROD.OUTLOOK.COM
 ([fe80::fce2:69d7:2d84:7d9e%3]) with mapi id 15.21.0048.016; Fri, 22 May 2026
 08:24:02 +0000
From: Matthias Feser <mfe@KBSgmbhfr.onmicrosoft.com>
To: Moteen Shah <m-shah@ti.com>, "linux-serial@vger.kernel.org"
	<linux-serial@vger.kernel.org>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "jirislaby@kernel.org" <jirislaby@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"k-willis@ti.com" <k-willis@ti.com>, "msp@baylibre.com" <msp@baylibre.com>,
	"andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2] serial: 8250_omap: clear rx_running on zero-length DMA
 completes
Thread-Topic: [PATCH v2] serial: 8250_omap: clear rx_running on zero-length
 DMA completes
Thread-Index: AQHc6cRYMQeunajME0us4KxoapzarQ==
Date: Fri, 22 May 2026 08:24:01 +0000
Message-ID:
 <BE3P281MB55153573889A8124C06291F1EE0F2@BE3P281MB5515.DEUP281.PROD.OUTLOOK.COM>
References:
 <BE3P281MB5515563BFB5DE5E093ADAD9DEE0E2@BE3P281MB5515.DEUP281.PROD.OUTLOOK.COM>
 <4b8c59fe-c6a1-47cb-ab3b-855b1edddde2@ti.com>
In-Reply-To: <4b8c59fe-c6a1-47cb-ab3b-855b1edddde2@ti.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=KBSgmbhfr.onmicrosoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BE3P281MB5515:EE_|FR4P281MB4678:EE_
x-ms-office365-filtering-correlation-id: 524a212a-8950-4fff-ac5f-08deb7db7ad6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|6133799003|4143699003|22082099003|18002099003|56012099003|38070700021;
x-microsoft-antispam-message-info:
 Gad7WJ6TeO9na5oaOzG4SG61wSRjbS5E5/RHmWCNgJoa9qHyUrlJAOhKXQJbPC8theqk+PDLWL/xkGxSZsJ1v7Di8MeHfUS3WDXaY/yyblJUh4xHvDG7rVYJ3Il9cBmlo3h8DlfQRWTULI4zC12FcapxsE//wo4qDXNC3ZvqpiHn0J2nYy9ysHH2UhL9HCVwbVDsOd6ByHrugIXvdYVJJNqZdlqatUqGbaVMmUNG+LpO1jCRZMmHInvA6tFWf90/VZIy94kz1FeoRh2MagJImXBXpdpvAd6O3KKhSyXy16ICL7LLBEAJUX8WtEdsP4LrZJ79vh8JbFbiajlVd++wh8ZAgKZBz/+OJnWnNYWsq/uY4ZxtJKXn0n8X0HWFyophgZPi3rpyiNT8pZFyM2jHo1r0iFgK7euJx9ckVhrz5+fT7cN6UBh0YDGa7eiyflhlY+NLf/HjZ77AkBuLv1bGvU/ubZRzHvDjTQSggCoKv3u7QsoV91Q7OdDXPtrhCVm3T8rGp/7YUfxE0NemKdlovJjRhIOogxl+8FDqmUbmFNkmll8Bh7KhR2T804mRsMscMBCR0L2ow/rJIBZuwOs4M32VbYYrGSW06IRI+K7iPPmQnSucLKvNhWpZfBI0DUpk6RW5uimn8AEGB/RuPaIr3eAsWQC0AQJP0jU/1aH4WicqgyXHMQ163ul3Z1XirWu+VvM5bSijI1nvyY7+aU/DKuCty5ANSHVcfO3l99f8tQg8STgU6T1md4zyMeq4eoZX
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE3P281MB5515.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(6133799003)(4143699003)(22082099003)(18002099003)(56012099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cXBxRWE2LzB1eWFTTERHMUdKb2dYcHFHVExDME9UUlpMeHFDeVlUdEtQakQv?=
 =?utf-8?B?Ri9jZ21MRzVSUnA1VUY3TjdKY1pzeGpBM2cwczBsd3FoNWVWeHFiSm1kc1dU?=
 =?utf-8?B?QUlUZVVkdHg5UkFZUzdQclpTM3NqandxczArQ3VJTS91SGlXd0RHNFhzQnRO?=
 =?utf-8?B?aVQ2ZFVvUkNxSExjN0RjZUhSTVpNaG9JZW1NbG9XVm5sTG5seVlkakFwNm5N?=
 =?utf-8?B?WGVEWmFTd0wvaEU0RGwyYUd6S0tnemY1cktQem1mVURObkZlY0NsV3FWMHFM?=
 =?utf-8?B?elI0ZUJ1T3lyZjFTUnZna0J1S0FXbENwdWdaVjFabHZjUXFORGhqemxGSWxt?=
 =?utf-8?B?ay9jZXJNVU5jMkZ3Rm5vTldoYmUzZzFCenBQWDY3QWpBUmpyQ1NyKzYxSjdk?=
 =?utf-8?B?MnFxZ1RCRmtWQnBwTmpNdkJyNW56Q1FFSDdidFBML3ZDS2VNUzRKMHhRU3Rm?=
 =?utf-8?B?UkpmUkJXUDZGNjFKbG5FbTd6R1dsbmw1dS9xcG05Qnp5dXdvMExQbXV5Y0JJ?=
 =?utf-8?B?bHRJL293eEtpSVduQ0JDOWZVSDdIVldhZEdtNVhqTTF4SStiUWtBeFYrNTZa?=
 =?utf-8?B?Y1JvM0QyazA3M0lSN3RTWGJ3WVJOUjBjLzd2REpFOTh5eFNFQ3ArWmU0dWdE?=
 =?utf-8?B?S0V5d283eHM2SEdiak1JRWIxSHFzcjgyaXVEMHVpZ0hlUm9wdmJvVjlwSm1K?=
 =?utf-8?B?REVVbEF6VUk5ZkhicjdaVGlzVld3N1JBNTZyclNJQU5LUjg2ek5vamloNU84?=
 =?utf-8?B?L1pVdlVhR0VLTDE1TENRdUpCRzQzN3hFOHNlV0NYTFU0YkdBb1BaSGZrc2Jr?=
 =?utf-8?B?S3d1UWN1WEJ4VDRZRW1DQVI1blQxbjJOK0p4UEZ3S2xTQTlJZFBLQWd2aXN6?=
 =?utf-8?B?SHovRGZyaWJZUjU5Y2JMajFjN3lGajEyci9ZTERUbWFQcWh2aGxHWWRrWEF6?=
 =?utf-8?B?WDUwWU9ueGg5VkNTaGZ0emo5dWlPWld1c0VwYlNBL3ZvcTdyWDhmbWFvTXp1?=
 =?utf-8?B?MzNySGdkcS9TTHA3Q1BKQVhmbGhMNXo2ZjNIRXJSUTRNQnMrbHBSRm1WTkVw?=
 =?utf-8?B?bnIxcU9DNXE5OFEyWWZwaktwR21XMlZrVWdkS0xJaUJGY1UzSkNpMEdBOWxX?=
 =?utf-8?B?NDlERFFDUWVsMFJBcWJ1cmxnYy91c0FPQk5KQTV3WkhHVnlQVVVMblg0cEww?=
 =?utf-8?B?ZXh6RTRaNE5aUjJkQXJQcC8vTitsNGE4YXRLcjR2MTV2QnlNbXVCNWNUYnRY?=
 =?utf-8?B?SWZqTC9aZ052NjZlUW5qY0lNUkFJeC9jaXVBeXZtTWJiRUFaY3A1ZC84eG1B?=
 =?utf-8?B?K0FST2FqWm9KV1pHb3V1NDR6RVl3M0Zua05PNGE0a3VhL0lxSkxDSGFzNDN3?=
 =?utf-8?B?RTFuckMrM2JUVFc0YWhub2piVlgzL3l1MGJ1ZFJqQ1VwNitWVXl1cC9xRHZR?=
 =?utf-8?B?Z2VWZHFsNVBtNVVYZzIrSTJoN0RDM1FDVFp0T0tmMDdJUmkyNFpaSUI5YnZW?=
 =?utf-8?B?ZFJzUUQxb3BYU2JsQy8wSldTbzRYcjgxeTM0RlI1OFBGdGd1eWEwV3VWWm5L?=
 =?utf-8?B?OW5Uay80aXhzSHV4SjZtZFVLV281MWpObzdZZTBDaVZiclBXTTUycFhoSFhs?=
 =?utf-8?B?bGpHeDhRSjJacWo1Y3NNWkdzQUVxcjNPbGF5VzhjQ0QwZUh4RGREeTNUOHZU?=
 =?utf-8?B?R1ZzL1ZwVmYyVjc4MTJTbE0xUXBscjNvZHVmWkt3UWs2SitiM0FUYVNpQndm?=
 =?utf-8?B?SXl2UUlpQlEvaHN0dzlUYWhjb1ZmWHhuUmc2S01lSldzbnhXNENrQ0dBaXhN?=
 =?utf-8?B?UnpWVWRQTXUzblk1Q0NubHZSSk53anIvZGs4SzkrYU5TdjNpdkJnblVrR1Jl?=
 =?utf-8?B?Nm9tdjhWM1Jja1p0MnpLL2RrS2ZqMHYxeVhVWUVyZnFmeE1SOFByT2NiQkZF?=
 =?utf-8?B?V0g2NUxJUG9mNXVVcGZQYTVKQ1dvdGFPUm1kSkw1UHpEeW95WVc3Ryt1S0lH?=
 =?utf-8?B?QnBMSjArakY1U3piOFlZV1dLN2pheSs0Nks3Zjd4US9LckhGNVlkbWlQUmJp?=
 =?utf-8?B?b1A3b2IzSHlVMCt3M1VjZ3ErTXB3R01GYm5TbEJYTmErT2ZQOUt5am5zR2ov?=
 =?utf-8?B?RWpOemJwQVdaRTRBRXVKUm1tWHE1L3huSHU0SlkybVArOWR1U2FoRHBneVRp?=
 =?utf-8?B?MDBPWnBtYlZFZ0ExU01jOHFLaWVNb0NNWGUwWjM3REs0emlReEtoZTNKRytk?=
 =?utf-8?B?ZytIVHMvQzdZcEpiNnFUMms1SkJZU3c3MTdYbmR4Y3k0aTB4YTM1OThHMFNF?=
 =?utf-8?B?RkFzZXJkZUpwcFFwRlBsaXhzYjZJdlZRdUsraUxkRlllS25pK0xFdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: KBSgmbhfr.onmicrosoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BE3P281MB5515.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 524a212a-8950-4fff-ac5f-08deb7db7ad6
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2026 08:24:01.9572
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f174257-ca3b-4127-8fed-91fa39cecdd6
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ukkeN0YDnl6jTUAWOyDYJO38uFVvfnmpqFVpkk1Y1KJnIvuR15iK+hDHsWFz75HsDc57mXXsC/JWY7YqgL6yDtXAgpriMW2fu9ZIyQmosPc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR4P281MB4678

VGhhbmtzIGZvciB0aGUgZmFzdCByZXNwb25zZS4gSSd2ZSB1cGRhdGVkIHRoZSBwYXRjaCBhY2Nv
cmRpbmdseS4NCg0KRnJvbTogTWF0dGhpYXMgRmVzZXIgPG1mZUBLQlNnbWJoZnIub25taWNyb3Nv
ZnQuY29tPg0KRGF0ZTogRnJpLCAyMiBNYXkgMjAyNiAxMDoxMToxNiArMDIwMA0KU3ViamVjdDog
W1BBVENIIHYyXSBzZXJpYWw6IDgyNTBfb21hcDogY2xlYXIgcnhfcnVubmluZyBvbiB6ZXJvLWxl
bmd0aCBETUEgY29tcGxldGVzDQoNCk9uIEFNMzN4eCBSWCBETUEgb25seSB0cmlnZ2VycyB3aGVu
IHRoZSBGSUZPIHJlYWNoZXMgdGhlDQpjb25maWd1cmVkIHRocmVzaG9sZCAodHlwaWNhbGx5IDQ4
IGJ5dGVzKS4gRm9yIHNtYWxsZXIgYnVyc3RzDQpubyBETUEgcmVxdWVzdCBpcyBpc3N1ZWQgYW5k
IHRoZSBGSUZPIGlzIGRyYWluZWQgYnkgUlggdGltZW91dC4NCg0KSW4gdGhpcyBjYXNlIF9fZG1h
X3J4X2RvX2NvbXBsZXRlKCkgY2FuIGxlZ2l0aW1hdGVseSBzZWUgY291bnQgPT0gMC4NCg0KVGhl
IGN1cnJlbnQgY29kZSBleGl0cyBlYXJseSBpbiB0aGlzIGNhc2UgYW5kIGRvZXMgbm90IGNsZWFy
DQpkbWEtPnJ4X3J1bm5pbmcsIGxlYXZpbmcgdGhlIERNQSBzdGF0ZSBpbmNvbnNpc3RlbnQuIFRo
aXMgY2FuDQpwcmV2ZW50IFJYIERNQSBmcm9tIHJlc3RhcnRpbmcgYW5kIG1heSBjYXVzZQ0Kb21h
cF84MjUwX3J4X2RtYV9mbHVzaCgpIHRvIGZhaWwsIG1hcmtpbmcgRE1BIGFzIGJyb2tlbi4NCg0K
Rml4IHRoaXMgYnkgY2xlYXJpbmcgZG1hLT5yeF9ydW5uaW5nIG9uY2UgdGhlIERNQSB0cmFuc2Zl
ciBoYXMNCmNvbXBsZXRlZCBvciBiZWVuIHRlcm1pbmF0ZWQsIGV2ZW4gaWYgbm8gZGF0YSB3YXMg
dHJhbnNmZXJyZWQuDQoNCkNoYW5nZXMgaW4gdjI6DQotIE1vdmUgZG1hLT5yeF9ydW5uaW5nIGNs
ZWFyIGJlZm9yZSB0aGUgY291bnQgY2hlY2sgc28gdGhlIHN0YXRlDQogIGlzIHVwZGF0ZWQgaW1t
ZWRpYXRlbHkgYWZ0ZXIgRE1BIGNvbXBsZXRpb24vdGVybWluYXRpb24NCg0KU2lnbmVkLW9mZi1i
eTogTWF0dGhpYXMgRmVzZXIgPG1mZUBLQlNnbWJoZnIub25taWNyb3NvZnQuY29tPg0KLS0tDQog
ZHJpdmVycy90dHkvc2VyaWFsLzgyNTAvODI1MF9vbWFwLmMgfCAyICstDQogMSBmaWxlIGNoYW5n
ZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJz
L3R0eS9zZXJpYWwvODI1MC84MjUwX29tYXAuYyBiL2RyaXZlcnMvdHR5L3NlcmlhbC84MjUwLzgy
NTBfb21hcC5jDQppbmRleCBjNTUyYzZiOWEwMzcuLjc2YmM4YWQzMjRjYiAxMDA2NDQNCi0tLSBh
L2RyaXZlcnMvdHR5L3NlcmlhbC84MjUwLzgyNTBfb21hcC5jDQorKysgYi9kcml2ZXJzL3R0eS9z
ZXJpYWwvODI1MC84MjUwX29tYXAuYw0KQEAgLTk0NCwxMSArOTQ0LDExIEBAIHN0YXRpYyB2b2lk
IF9fZG1hX3J4X2RvX2NvbXBsZXRlKHN0cnVjdCB1YXJ0XzgyNTBfcG9ydCAqcCkNCiAJCQkJZGV2
X2VycihwLT5wb3J0LmRldiwgInRlYXJkb3duIGluY29tcGxldGVcbiIpOw0KIAkJfQ0KIAl9DQor
CWRtYS0+cnhfcnVubmluZyA9IDA7DQogCWlmICghY291bnQpDQogCQlnb3RvIG91dDsNCiAJcmV0
ID0gdHR5X2luc2VydF9mbGlwX3N0cmluZyh0dHlfcG9ydCwgZG1hLT5yeF9idWYsIGNvdW50KTsN
CiANCi0JZG1hLT5yeF9ydW5uaW5nID0gMDsNCiAJcC0+cG9ydC5pY291bnQucnggKz0gcmV0Ow0K
IAlwLT5wb3J0Lmljb3VudC5idWZfb3ZlcnJ1biArPSBjb3VudCAtIHJldDsNCiBvdXQ6DQotLSAN
CjIuMzkuNQ0KDQo=
