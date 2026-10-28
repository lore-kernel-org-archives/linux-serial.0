Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.7
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793178827;
	b=bUZxROI2bCmEOtPTzGB+l0RJIU3tPux7MdyajMAi4ClR4DG+4u25GUjhMft83hrH1MAT
	 nLvgmVTTniJq7emm/7HanfmPxfZX401TT+QRsdoi1HuYszsSyXbS8w8D1tyrJPrnevOHL
	 uZ3eKA0iAxwwXGOY3s7wYFyvcSzl21M+ANU6VRr9nHh52r5tgnKwy2mnKyp0p1rvVtoMr
	 X/xJDFKEvx1e/FoUvjZNd97WEWuHhJ0WTQuCClwHHftcoiWQ2Gms4l41oGTr54CCU/e7B
	 4aiMo99YGfUUhWKaUr0DHD00d3B0x0dzT5UueEaZHTJlV8Og1bb1raVX8Cj4YW/zcWQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793178827;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ld-processed:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=Yhs42nOYjKAS86cfq/S0ymBJ2RNrwHTemf2nelSZ97Q=;
	b=rKVtwZvGMyA8QaDyITOt+KdxohbPzI1bkgq18hEytvNwTBOZmUikAl9Z32RMqSejjoO0
	 0Wko1sPQ/Q4NQiLqIMPm59QiNoUhqFWyko1FwhtgfkzpZWE8SqCDExF+dqnsyCQBA1Hzi
	 t/YlgqK+UvyYtpaGjqG43JjldWSfJMLTVtTsrQi2Pkb3Su1ybVjBad+eU6tJacr8EQLvA
	 lzwIUBnZZMPbi/yd9sWA5qmWaXBOaiHrA0AxcYwwrHSx1qiOhPaAduxPLkQ5fAKKBxyfy
	 aPl4fHd7yh3uiFQAfIrSelxUytR+dsx7N9r9CqtjzLVbwmWiYuJrAPx/uyBo7BOfq8w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bp.renesas.com;
	spf=pass smtp.mailfrom=bp.renesas.com;
	dkim=pass header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=fsfWyvoN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.7
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011007.outbound.protection.outlook.com [52.101.125.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA99A606A31C;
	Wed, 28 Oct 2026 09:13:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA99A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=fsfWyvoN
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WNnO1VGNddZqh9Pu+bl00oCufjLlEO2a08BF872CkATWMZ3ZimXNhzAOQpuvwnPNCa/7l7A8ZJRcUgG8hzEhOb9XdYzHpeExavKl+2fqhFeYLe4g7TPWlm34Y/iT7BwzBwi4fkXmBe3mHknaC9f//nhoTVriUTwh193QadR5qIltY2PwdSu0VcWUESo7OZrmgXn2J5JyHRT1W3HLjPolaXKIyGVc505rmf/z7cTXaDR79dDXD+U9YhvoszLjZDWsmDi31aNTUMgl0BaOaS5aI+ljOT5R7UzWf+vNJHimnLkxL1GP1hsyfI902w4zz3ifnDg9/PnAOkJxVKA6TnRimA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yhs42nOYjKAS86cfq/S0ymBJ2RNrwHTemf2nelSZ97Q=;
 b=L+BqA9aYdXJoKf+EYmm1lYl6eD7sjmTNgiDtW/mZrag3eTwIK2bpFaRAYO/U/fR6flBji+Xrdq9+LZ2bA0/UVevux7tZRgtWbQAn18F0CD5GEG3P/OSMNFVTLJ5Uf03Pr7sHgF4HKwW20DCSvX/jFdZxe/vJn0Zogb3WmpesRRTyUlvkxwfSetrVVO/w6h09zusF0b+atIjEh7JqCFGK/dT3UYPZt717L5DAUBgO059e6yAjL2cT66xrz6yY5cAlXfa9NAIpm4FQGwYpQHv9zBKMuUXrN1irOaspKR7CTEEp6VCgrBIAzYXHM1mM1f12IUKusuL3bEkWmnwD5n/xYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yhs42nOYjKAS86cfq/S0ymBJ2RNrwHTemf2nelSZ97Q=;
 b=fsfWyvoNwIXLx3yGGQjvjDKWrVGNea7LycMoPJRayLgNNqSAWiRnUtKyzTqkxvfzzjBEcPODtuoSOtEokPyoD+m5W93mkZIKtO7YFPmyUkfEzdqhwK6u77kjpVm2oHbgQGXZz26VI3lAGuNePTw/0kZQYWRHEgFfEDDJpesZ2oM=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYRPR01MB16231.jpnprd01.prod.outlook.com (2603:1096:405:2e8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 09:13:41 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%6]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 09:13:41 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Borislav Petkov <bp@alien8.de>, Krzysztof Kozlowski <krzk@kernel.org>,
	Kiryl Shutsemau <kas@kernel.org>, Rick Edgecombe
	<rick.p.edgecombe@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>
CC: "biju.das.au" <biju.das.au@gmail.com>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri
 Slaby <jirislaby@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org"
	<linux-serial@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, Au Dang <au.dang.jx@renesas.com>
Subject: RE: [PATCH v3 0/4] Fix transmit handling on SCI/RSCI ports
Thread-Topic: [PATCH v3 0/4] Fix transmit handling on SCI/RSCI ports
Thread-Index:
 AQHdZTx0nCl6r9+vN06096idU3GgbbcQ5bkAgAAVSvCAAAKsAIAAExbwgAARdgCAAL3ugIAAzkGA
Date: Wed, 28 Oct 2026 09:13:41 +0000
Message-ID:
 <TY3PR01MB11346987E93BF871BC27E2836866F2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20261026-g2ul_sci-v3-0-b3097163edd5@bp.renesas.com>
 <20261027055750.GBauA9XlPykc1c1Xhv@fat_crate.local>
 <TY3PR01MB113468FBD8E5EFA65C4B4E5EB86602@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <072dd88c-4ca1-4c8a-98b1-7783bc43c1c5@kernel.org>
 <TY3PR01MB11346BAE55FF22F66E86A6F8B86602@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <afdf1864-4721-4177-bc18-2a5821d97559@kernel.org>
 <20261027205411.GAauEPc4AtLwvrDfFr@fat_crate.local>
In-Reply-To: <20261027205411.GAauEPc4AtLwvrDfFr@fat_crate.local>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYRPR01MB16231:EE_
x-ms-office365-filtering-correlation-id: 9e63ba76-0562-48aa-b3a3-08df34d3c240
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|23010399003|1800799024|7416014|376014|261009223027099003|261022105027099003|10067099003|56012099006|261026121527099003|22082099003|18002099003|4143699003|261026140227099003|11063799006|38070700021;
x-microsoft-antispam-message-info:
 VcDcqq+PcMFQ8KaY7DKoMxz3zTHNilBENr7V/HLEAeXj3Qc06EAhz5/xJL9+3Wx2lyJFCKemGi3Z8vvhpeo22CeOoVdQlSBwM0vePrLlDe5O0uX3PCy9K+XZTOxOcnFigoP9KlE2dEDj7Xn+Ae7y0rfqFrXqNkYsuIliDEhNHQVX/iSQ4ONJ1TyCX0AhNf+/CeNwwY5SXlA/PTXNVjTfXTs7KWgayagmfD+s7aBGEcvQp/kv9I0NsNO2wMsGNiUvJ+QxUSb/YG4NyzpH6InJdnU48Vy9y8mTiAV9f/UEVJfg6XT4lJsl/iRpkMQlubqdEmAS5o0DjxLdZFZh11+OSOJqTz65Uv5UlTFOTutJcc4Gb0iGMWVidI8rltQtI1PoD7GJXrTKapdK1i2VL1XJYhjeWMjSondq/aRx7m3Y+3RKy+RIzopWXIv6U8aEVchZrOHYkhlipI2fSjMoU9JoMS7Nk576HR+2WtifqQ/nlIoBItvq7Ws4vP+W2OVFM6tJAxGpVHcwuQMfXdpHT3wlUeSEn1VIWOCwi2HtLkAv5tsPNhqTTbnqb1883KQ96Vux859DVn0kmivPBQpWduZliRSdYPi2sET/sBOEuZ4UVmBP1PR/Gw5ubpE8Ne4opcGqWk0txQROq7QQzO0RAmoibRAog/PezYeAf36XGe5iI1Q=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(7416014)(376014)(261009223027099003)(261022105027099003)(10067099003)(56012099006)(261026121527099003)(22082099003)(18002099003)(4143699003)(261026140227099003)(11063799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?T1lVdnhvSzU5UEVkSGRXUWt2YzlWbHZlZEdBWFAvWHc0VkplR2NsQ0hZclpM?=
 =?utf-8?B?ZjA0RVA4M0N5ODFZaHVhdlVRVXpIVDhGRFE0ZnZGY0NHTkJaNElEM1ZoczN4?=
 =?utf-8?B?VDhXNk9xeTJtZ3lGRjN6NisxU1pnK2ZoTmRpTy91QUM1TzBucnB6bjJwdjJF?=
 =?utf-8?B?b0JGb1cxS1JoRForY2JyeXl2NFFxYVpFZWhpLy9OQkd1bHZaMlNKK2hJd3lH?=
 =?utf-8?B?V2UzVXNuVlduQk9PeUlTMG1iSDBTalZUSXRISHFpazhzUjBNMVduMFNVZXNs?=
 =?utf-8?B?REY5WC95ZHNPR2ZVVEUvTlQ2bkQ2SVIycUZsZHN0NjJnVWxqdE55UUtvUC9p?=
 =?utf-8?B?NmZLckh0ODJvWW9CYzZkNlVSMjBuenZ3TVJ6eHRGZCtTRWYxZnd4Vlp0YzQ3?=
 =?utf-8?B?QzJaV1RFVVFuK0JmZWRNenhubjBseDVMNUhhNElmcVU1UkVyUWV1ak9zN3Qz?=
 =?utf-8?B?Z3J2dkZWaUxaV0dFQXNONHZ6TEVYZlA3c0d1Y0JyUDJFNUpQSnlXZFg3UU5q?=
 =?utf-8?B?U3hrWFJvbW1oTjgzZHIzUDIwYkVyaUpMenIrWDBoODJ0R1VrYVROMllkYnNX?=
 =?utf-8?B?SERmb1Z2OFNzM25oUmd5VUpJMTZPb0NzbjErWnhTQVhzdmxobm94U0RwaGtH?=
 =?utf-8?B?MEdhZWZldlE4NWdPYUIzWEgzVjFySDdlY1F0R0lUOXdLak9GdGNZeVU4NW1O?=
 =?utf-8?B?V0xkQ2tUNzdQTXN2M1F4YkluWG80TVM2MEZrbzViNkVCZTRMRVBxdHNPMU5y?=
 =?utf-8?B?VFowTXdTZVpvMnlaK251UXpiL0hwQjNYdXpTL2k0elY2Zkt0bUQrZFltOFpn?=
 =?utf-8?B?LytJY01Ua3VYMkxHQjhLRDcvdjBxdEU4c1Q3TkhaZ25KYzNzV3ZqY0FwK2ho?=
 =?utf-8?B?Z2hoSXl4dmtySkYweVl2Q296ZDVoQit6N3Z1SmRlNHZIYk5rNkZHMnZ3dlJp?=
 =?utf-8?B?ZjNTU3BiYXB5Z0RKbVI5V0lIenh6QXlUNmtVUmQ2aUZ5bWsrajZ1ckN3Q3BJ?=
 =?utf-8?B?UHlaNWk0L3Vud085NjJQWFBKbVZ6b0Jvc3dBOXo1RHc4MGZ4VHNYSTR2aUZF?=
 =?utf-8?B?VWFtRkRMMWhRU1NHeTZtQUVTbjBwN0pnS0lNTnJjajZLZzRZMm4wWjFadVpk?=
 =?utf-8?B?eTB0NC9lSkxpQWI1L29RV1lFUnczTVVHSnlDR1lDemcxZmxqb3hXb2Jxd0lU?=
 =?utf-8?B?ellKVWd1SWhOUzlqdkRqQUxlZG5tY05GWkVNRCtrcDRWQ2pMRzJPS2JYZ3VT?=
 =?utf-8?B?NWxxTDJSVXhKUGM4MHUwSFNHcnJtSk4xcmRsOUNlbHkra1VmdWZqRXVXZTVt?=
 =?utf-8?B?YnVwTFQzczNDa2U3Y2lCNDc2WUs1TUhjbW1YSWI2bXpWNEo0MFoyV29wclBN?=
 =?utf-8?B?UHFsZmNXNndDWXdXeUh1OEhQOWZmcGhHWWMyODRsOTJncHFBNkNvcHRvTUU3?=
 =?utf-8?B?VXZDMVJUK1l5d2FNVndiNFdva0htZGxPamFJdDA5VE5od3V2Q2N5NTJCT2Nx?=
 =?utf-8?B?b21SMVJTMWJPS1ZlWFpRcytpQlpNS1BvOEF5b3hTMWMrT0VxdlBpWkNTcWw0?=
 =?utf-8?B?UWtqM24rdGdyelA0YVB0ZjhPc2hBZzRjbkp5UG5neGxPQlRsYmVMU2Z2azd1?=
 =?utf-8?B?bXczV3RycmJRbEo0TnJTODI5UGRFbk11ZTdrSGo0RzVlQjZ2Nzd1Zi9EWHo4?=
 =?utf-8?B?aTFUYmRpMlA2SDFhWWZDaGczWHVtMm5obkZiU2l4allaaWlmckpUa2poNk9O?=
 =?utf-8?B?SmlOaStMV3NURTdkbHhFdndIOVlKRVNTTE4rMy9DT09uMlQ2aTJsekhCVHM1?=
 =?utf-8?B?NUUxWFZabmZ1alJTZlVsSHMzb0QzMzlWSk10NG5kUU41aEUzeW9pQmZiNVBo?=
 =?utf-8?B?NUJESHFaTHVmRVNlRUFobTEzbys2UUV3NzhNTGNjN0IyNnJHSjhCNXZla0Vi?=
 =?utf-8?B?cjhUSW9IbG5sS2dJYlQ2UklDTEcvS25TWlRkR1ZUbHJwVHpEVUoxYUljTGtv?=
 =?utf-8?B?K1pOZm1hU01waWxrODZVaEorelJoQW9CY0ZHN2x4RGwyZ0tFNk1JT1F4RWRF?=
 =?utf-8?B?RkRBb21ON2hnQkl5MnUxSkZXaHpLTDJ3VE9PWjlEVU9wT2FzOTVCY1ZqWGJn?=
 =?utf-8?B?bVE5RGovaVJCVG5MWXZwS212V2o4anN5WGw3Mm5LaTJZZVNGQ1ZMSEV2d3Vh?=
 =?utf-8?B?b1hWK2F4RzZUWWFwdTliNkZSRWlYemdzT21wb004VXExamZRY3cvdUozVGdK?=
 =?utf-8?B?b3Nnd1huUjFQeTJVcWZaL2VQUW9JZkd6aGRQckZ6M041MjV5YUFRZTdvd0l1?=
 =?utf-8?B?NXlrS21RVU54andGeGxtRHJFZDB0akNOaEphMStDREdzM2FSTVFnUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e63ba76-0562-48aa-b3a3-08df34d3c240
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2026 09:13:41.1573
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k5vT0tCS87Lh9uVDid3+O1ifpNWwTmL4DByJIkuv9pLQ3zdCxSM1lRzEthFyAI0e6EJkA06zSjj9yHgZVm46MvjQFImDn1bTL8LbWTRy0OU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB16231

SGkgQm9yaXNsYXYgUGV0a292LA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZy
b206IEJvcmlzbGF2IFBldGtvdiA8YnBAYWxpZW44LmRlPg0KPiBTZW50OiAyNyBPY3RvYmVyIDIw
MjYgMjA6NTQNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MyAwLzRdIEZpeCB0cmFuc21pdCBoYW5k
bGluZyBvbiBTQ0kvUlNDSSBwb3J0cw0KPiANCj4gT24gVHVlLCBPY3QgMjcsIDIwMjYgYXQgMTA6
MzQ6MjRBTSArMDEwMCwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gPiBJbmRlZWQgdGhh
dCdzIHg4NiBmYXVsdCwgc28gSSBkb24ndCBnZXQgd2h5IEJvcmlzbGF2IGNvbXBsYWlucy4NCj4g
DQo+IFJlYWxseSwgeW91IGRvbid0PyENCj4gDQo+IExvb2tzIGxpa2UgeW91ciBtYm94IGNhbiB0
YWtlIG1vcmUgbWFpbCB0aGVuIDopDQo+IA0KPiA+IFRoZXkgYWRkZWQgc3VjaCBwYXR0ZXJuLCBz
byBnZXRfbWFpbnRhaW5lcnMgaW5kZWVkIHJlcG9ydHMgaXQgd2hlbiBydW4NCj4gPiBvbiB0aGUg
cGF0Y2hlcyAobm90IHdpdGggLWYpOg0KPiA+DQo+ID4gCUtleXdvcmQ6XGIodGR4KQ0KPiANCj4g
UHJvYmFibHkgYmVjYXVzZSBhbGwgdGhvc2UgZm9sa3MgaGVyZSBoYXZlbid0IGJlZW4gYml0dGVu
IGJ5IHRoZSBpbXByZWNpc2UgcmVnZXggaXNzdWU6DQo+IA0KPiBodHRwczovL2xvcmUua2VybmVs
Lm9yZy9hbGwvOTdlMzIyYTMtMDUyNi00MTRkLWEyODgtODM1ZDExZWUyYjFhQGludGVsLmNvbQ0K
PiANCj4gYW5kIEkgdGhpbmsgdGhleSBoYXZlIGJ1dCB0aGV5IHByb2JhYmx5IGRpZG4ndCByZWFs
aXplIHRoYXQgdGhpcyBwYXR0ZXJuIHRoaW5nIG1hdGNoZXMgY29tbWl0IG1lc3NhZ2UNCj4gdGV4
dCB0b28uDQo+IA0KPiBUaGUgYmVsb3cgZml4ZXMgdGhpcyBwYXJ0aWN1bGFyIGNhc2UgYnV0IEkg
Y2FuIGFscmVhZHkgc2VlIGl0IGlzIG5vdCBlbm91Z2ggc28gSSB0aGluayB0aGlzIHBhdHRlcm4g
bmVlZHMNCj4gdGlnaHRlbmluZyBhbmQgYWN0dWFsbHkgc3BsaXR0aW5nIGl0IGludG8gc2V2ZXJh
bCBwYXR0ZXJucyBmb3IgZWFzaWVyIG1hdGNoaW5nLg0KPiANCj4gUHJvYmFibHkgc29tZXRoaW5n
IHdpdGggYSBwYXRoIHNlcGFyYXRvciBpbiBpdDoNCj4gDQo+ICouL3RkeCgtW2EtekEtWl0rLy4q
DQo+IA0KPiBhbmQgc28gb24uDQo+IA0KPiBZYWgsIEkgd2FzIGdvaW5nIHRvIGFkZCB0aGVtIHRv
IENjIGJ1dCB0aGUgZmF1bHR5IHBhdHRlcm4gYWRkZWQgdGhlbSBhbHJlYWR5Lg0KDQpUaGFua3Mg
Zm9yIHRha2luZyBjYXJpbmcgb2YgdGhpcyBmYXVsdHkgcGF0dGVybi4NCg0KQ2hlZXJzLA0KQmlq
dQ0KDQo+IA0KPiBQZmZmLg0KPiANCj4gLS0tDQo+IGRpZmYgLS1naXQgYS9NQUlOVEFJTkVSUyBi
L01BSU5UQUlORVJTDQo+IGluZGV4IDJiMGQ5YTI4YmM4NS4uZTcyN2RiNzBhMmYyIDEwMDY0NA0K
PiAtLS0gYS9NQUlOVEFJTkVSUw0KPiArKysgYi9NQUlOVEFJTkVSUw0KPiBAQCAtMzAyMjgsNyAr
MzAyMjgsNyBAQCBMOiAgICAgIGt2bUB2Z2VyLmtlcm5lbC5vcmcNCj4gIFM6ICAgICBTdXBwb3J0
ZWQNCj4gIFQ6ICAgICBnaXQgZ2l0Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJu
ZWwvZ2l0L3RpcC90aXAuZ2l0IHg4Ni90ZHgNCj4gIE46ICAgICB0ZHgNCj4gLUs6ICAgICBcYih0
ZHgpDQo+ICtLOiAgICAgXGIodGR4KVxXDQo+IA0KPiAgWDg2IFZEU08NCj4gIE06ICAgICBBbmR5
IEx1dG9taXJza2kgPGx1dG9Aa2VybmVsLm9yZz4NCj4gDQo+IA0KPiAtLQ0KPiBSZWdhcmRzL0dy
dXNzLA0KPiAgICAgQm9yaXMuDQo+IA0KPiBodHRwczovL3Blb3BsZS5rZXJuZWwub3JnL3RnbHgv
bm90ZXMtYWJvdXQtbmV0aXF1ZXR0ZQ0K
