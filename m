Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11021116.outbound.protection.outlook.com [52.101.57.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589943A6EF0;
	Thu,  8 Oct 2026 17:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791480939; cv=fail; b=kXxoQAFCa8nsl//gBO53eI1ffywI9iUuHdybsdnZSdQToZQFa+aD8LoLKcUrcSGVDmbtymdUmFR3y1VjZzPsHLiKctrWW8tZo9wPGnxs4SmfLyofCiGKd/X7MO5JL3QjhM/FK+VJGrEvXh4yg/NIxneiWGowusBOkm5Ih+dYIdI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791480939; c=relaxed/simple;
	bh=+TB7p3b7KDry5W6F86bCuAjEjlYt3MqszKpcFVSipVw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LYNQUgHRog5J6nxlCCa4mwFUwbTJl4T7TR4ssrZjNe4PWYFepot89zQeKDxQsGxrqGNVmtratG8RCnk9Zp5528IwfJwohlaq0bY3ITaoqQZQ/aYxCfXwt2xpGrUBuQ3lt41KwGJNQKljRaxIQj7K9rCKiRSWkAX3LBdP7eVfNOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phil.gs; spf=pass smtp.mailfrom=phil.gs; dkim=pass (1024-bit key) header.d=NETORGFT5377951.onmicrosoft.com header.i=@NETORGFT5377951.onmicrosoft.com header.b=cMAv6W9P; arc=fail smtp.client-ip=52.101.57.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phil.gs
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phil.gs
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NETORGFT5377951.onmicrosoft.com header.i=@NETORGFT5377951.onmicrosoft.com header.b="cMAv6W9P"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mS5eoWypWeeRQpYYGWF0yhOZTCVcZgFO1b6Nnh7bc/QJgjFXrFwEilsG2vHyLFh1gocAAZOO/xzObDISjSnwCx/qD5NzIVaUdQcZNwDWvEaLqaJrjesl5GdVkEHcHq7mRLOGZx8iPwNw3mhiV+bzCKElH4+ob9fpp6bk7cTjv7qmQQ1u0KTyl0+n2dfszXrB+mowAb16IAu/l7ngYUdF0KSAeGP6TgN1xn9YXDKvp3Mbo0N394Lt4wndGPqC1KU6HRTp8R20gVt+mNsptB05M4d+35dymcAONK2DmPHXgKAUpsNDeHfH+89/m6lwfyGdWnZNDjSbQ+sJcq0YRRYwyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+TB7p3b7KDry5W6F86bCuAjEjlYt3MqszKpcFVSipVw=;
 b=KYHpFIx/Nz6M8yWPKvoww2jkC+e8Tj80OS1fw5Woxd32CgTfWbZ71KXrtmhiUVkMA+dM5vRoRLXIABIRzwfZyavr21CefTw0nKHyfEJRbDBuQL0PhiJFazTQqsR2mFriCFTqlZtCY9v+B8yCP3N6dS8PfyHKI5yV5ztdKL9etg86dEpaDDC9lM6oh4PPTiyFxojiOLRl0CEyiQz8LsRJKZBJUDSXaAteJgbcrkS/9xy+z5NrG9MXx3cqi941tBEAjWccS36nya8cL4AgxrK0jqcJZzPnKaaC6ZWuzZSMbDE+l/dUXibPfFy0LWyzDNCs2KedxQbxMJEAhhyOqG0gbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phil.gs; dmarc=pass action=none header.from=phil.gs; dkim=pass
 header.d=phil.gs; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORGFT5377951.onmicrosoft.com;
 s=selector1-NETORGFT5377951-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+TB7p3b7KDry5W6F86bCuAjEjlYt3MqszKpcFVSipVw=;
 b=cMAv6W9PlkpU2/p/tQL5WOFOXxtYukTwT7ZZoGUVQOQw0j/Xj1+p/1lE4nb11+Kycova3I/+xWczteNeYqJJ7ZuRpyNT27gYFHM9lnGKtLrDSpc/KtjfdnmrtTW+XWkVbQMm8hVNp8l5bv23xGe3co2e7+komlopfCgs2EJrAC8=
Received: from BY5PR04MB6472.namprd04.prod.outlook.com (2603:10b6:a03:1eb::10)
 by SJ0PR04MB8391.namprd04.prod.outlook.com (2603:10b6:a03:3e1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Thu, 8 Oct
 2026 17:35:33 +0000
Received: from BY5PR04MB6472.namprd04.prod.outlook.com
 ([fe80::3a9:9dbc:2aeb:8827]) by BY5PR04MB6472.namprd04.prod.outlook.com
 ([fe80::3a9:9dbc:2aeb:8827%6]) with mapi id 15.21.0472.016; Thu, 8 Oct 2026
 17:35:33 +0000
From: Phil Rosenthal <phil@phil.gs>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>
CC: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] serial: core: Shut down a running console port before
 removing it
Thread-Topic: [PATCH] serial: core: Shut down a running console port before
 removing it
Thread-Index: AQHdV0T9Wq7Rr24uRESY0Vox5OJA5rbz322AgAAI1IA=
Date: Thu, 8 Oct 2026 17:35:33 +0000
Message-ID: <6F70397E-B702-425E-A11B-B87839DEF083@phil.gs>
References: <20261008-serial-console-remove-v1-1-288b9c315af7@phil.gs>
 <sashiko-outbox-164404@kernel.org>
In-Reply-To: <sashiko-outbox-164404@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phil.gs;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR04MB6472:EE_|SJ0PR04MB8391:EE_
x-ms-office365-filtering-correlation-id: f4fd6921-99aa-4342-cf8b-08df25628e4f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|23010399003|19092799006|1800799024|38070700021|56012099006|4143699003|7055299009|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 QrlFsgqL7Iyy6XZQ7Hmg7hRYYv//2+P2nQyZMV9bKveqEOPrY1S9fFJB/1JQ9r8iWUVvy+cXWThIwu8ttj5jClMghUKkRL0kB0f6jGeYQjq9FgapBGNZhZw3y/iiL9YlAdgVCKUV18Iu8PTrODUTEQAazcJTMjrbdF1kpiR6s7mAqH4cf8o6ixwou+HURCEmHh2hlxGuKM90Ms6aDs0abgnXTIGFHAHWR8wyzg+FHJGzVoiPoOm+TBmxXtuHvlGH+4xYqMixMfiPle0qkBJfk4Y5CHx+1AKLa5otQXcB6vL6/mDsURvwsBu3UnodTXUwh1PtmBFQifxlItzxb7Vl2ronWFdPCK0KmJy3gtXSRacFlSSQ6KVFVk6yHMKDfT8j1CYFX4X0jVn3tE0SqVW02ldy5SfmI9urGqKbUZ//PBIJhXFfVFCfWlI1LpaVG7F2SWGo2qnTgdaCU6XQq+rqGX/vxGb9zcIUn37p1duqe7A2naat3oUCF4LU0XChjCrj1Hq+/4rX94xwXkXm7erVPTlnpEyINChP6iyJsZbPsy63SZMfaBlK1pLreqx15yWfqkTfmpxMAtj0A3WnYVvoeVx1+8lEVaVUPPBYNA5+u+WzUR46ABB8mktOtPbjIDdO1Aw8tbN/2ylOL2UA4oxUIUushExwUyyskdAUgxXENPJ8ZrgUBpuyRZYXqcU5KQ8OUmBDpfJlysGG1d5jmURSDdCcW+jfbJFAiWXcniiQAjAHQfczPD7a3Pxy3riJNeD5
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6472.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(19092799006)(1800799024)(38070700021)(56012099006)(4143699003)(7055299009)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?M3dDTFdpSmhNTnVqaXNZdUZlTUJXYjM3WXpER1piWmM3L3BoMUdUN2NJWGh3?=
 =?utf-8?B?N2pnb2U4Y1JXRWhKR2QxRzR6OEl6VVQ4ZVA0RzVQYTNLcDhBRk50QVBpb2Nt?=
 =?utf-8?B?V0RDWDlzaHM4R3R3OVVOY1JvVWJFV0RNV3BvaXpVUDVvZTNoSktuMzhuSGgx?=
 =?utf-8?B?NFRUVzluYk1zR2JEZUVDTlNac3FENitRdXdHV0FDY0FKNEtKNWlOeTg3NVBa?=
 =?utf-8?B?N2c0TGJNN1F1elkxTDhkU3Rqb1d1cllHVEpaRUN4K0c4WGNPTGNIeGllS3la?=
 =?utf-8?B?RXZyUk10TW1hTWNTN3h2a3B2Q3NDcktydVlIYjJWRHhUN0pLR2lMTDhoMUJn?=
 =?utf-8?B?ZHAxSS9rYk53S0V0a3E4cGd2bUZJVm1OY1luSHlQN3N5RVpwVm1TNXF5c1dR?=
 =?utf-8?B?Y0lGZi9UNFdjSStLbmNTWEx2N1lSZWdTVVk5THNVcGxIZ1dHY2p4Z2FZcXg2?=
 =?utf-8?B?N0JnbUpSZ3NZM3gxY29RQkRMVmN4ck1haDVFODlLY1c4T1pZZ29maHdzWHNx?=
 =?utf-8?B?OCtNOTdaUzVaODZ1Y2FQTWk3UmlRaE1hMzY4MDR3cGd2UnJwN0JRUXJ6VkVn?=
 =?utf-8?B?K1RkSUpST1JGakpuTmpLU0p3TG03YVptY1J6TjIrOFJEN2hXekxMTloxRURn?=
 =?utf-8?B?UmxnVjltQUNPcWY5cUpBLzFsN2lha2ZLaC9naC9xbWpWaHBWNWxubG9WY0tE?=
 =?utf-8?B?aE5nRHVPamxDaVlpTG5uQy9Cc3FkNnJQYlhnclhvWWhJOVMxTXdxSlFlWDhD?=
 =?utf-8?B?ZlFqMVA0TFh6RGNLUGttWlcyUGtudmJsVjlEQmRENXc0WWoveGhTMFcrSzRN?=
 =?utf-8?B?aTNSb1h0aWZlMElmdDl4ZlVpYjE1UktVWEhLdS92WWpiOUJMOTdvMldyMlhB?=
 =?utf-8?B?dXMwcmN6bVlRRXRWaStwU3RWSU41N3Q1WUdVRlRyMER5SjROT3hvMEhwTG9r?=
 =?utf-8?B?TFRSc2NrU21aN1EwWE9DT2QyOEk5QlJwdVdSTmdidlM3eTRrS0Iwd2xMeFJR?=
 =?utf-8?B?N3RzK1dLejVTZ3lFRTlTSHR3MGYxTDZvRWhRS1JQV3o5ZTdDNUF3UWd4Ulhm?=
 =?utf-8?B?RTRWbGowUTFZOGtVU293c1AvOHVBd1l4UmY1dmRoWXhSK1hCL2lVREJxWmht?=
 =?utf-8?B?WStqYWgrTFBzUFpLMWEyNTh2SUhaN21uQUZ4dHYzRnYxaGZOREV4MnZ4ZGo0?=
 =?utf-8?B?bkVYS2RYRENSNldLdWdPcFNmMkFTYjd0WlVvZlMvcFY4cGRwd2o5dlhwQWFT?=
 =?utf-8?B?YjhIVEZka1prWTdwM3NWb3BHZ1JxKzYvK3p3MWRRd1VFVzN0SEhxckk0Q1Az?=
 =?utf-8?B?UVpuemx6S0dXWTE3b1BuclpPVzNmcEZLTVk3eGlkcXZJMldqYlJUbFdXL0F5?=
 =?utf-8?B?c3RGek5zQitTcXQyMmx1UE1SbXVrYWNsT2tmUkhwTy82UG51Q3FLZmhicnJu?=
 =?utf-8?B?OHFKSi9iSzFrV1FmdkN6UHh4aWN1TEI1Z3A5OGJLMlAxUUorTkZZbWdrOGM0?=
 =?utf-8?B?c0F2QUgrbFFVYzV0MkQ4YUkzU3diditMck83VjBDSHlpOVR3NGVJUmZYbVdC?=
 =?utf-8?B?c0JlUHlGa2RvbFhmaVJoOHlPajNiV2l1bG1pREFvcE1QTnFaWEY0US9NdFI5?=
 =?utf-8?B?Nkhlcmt0M21aYVFoK0xNT3hQbVBZb3Q0VWJEeFU3QTBHRXNTdVpqaDQyOEhv?=
 =?utf-8?B?ckhubjV6RlZsTWZ5TTAyNFg0bmd6SFRkb293cG9SbStsdzMzVnRZTUhPL3or?=
 =?utf-8?B?UWxzSUo1RzVWMG9idFNoalFySUVMMDJsL09oMUlxTk16RGpMMG8wVnhGbEFT?=
 =?utf-8?B?QzQwSTlJWitZNm53OUloOFlMT3Z5ZWM1amdTM0o1ZDBEbWFsZ004WUVlRy9N?=
 =?utf-8?B?Um56WnV1Wndlb0RwU1A2RVVzcy8zakNWcjJkRGZTTDNRSjg4UUEzbDVQNU5Y?=
 =?utf-8?B?NjNwazRlVUt3SWVUYzlYM1hMSGFGRE5rRDZDMEdmNzNNMU1XbVJ0THd6bS9w?=
 =?utf-8?B?bVUvRFpTbkgrbERoSStMUUVSOFd6aGRDdkJGVXNqNEVVb2pEVEFrYTR3dktx?=
 =?utf-8?B?aGhYOG1ZYUE0dmhsNXVPY0YvbUd4NkNWcGR4dFFlUmludk9xN1Q5ZFRsSVd5?=
 =?utf-8?B?dkhsb3l4cHVBRE5QUStXQTZ0S1lUN2FQbWxMNnlBajdVTU5LVDNVbW16WWNj?=
 =?utf-8?B?M3Jsb29YbStiWCtWUTB3aHg3WldZMExIOHpmSFhrN2had211cm81aEUrQ21K?=
 =?utf-8?B?ZUVoQXFTWWFFbEE4SkZxeGp0RG5MVlB4RnZhUW5BVFZ2T1lrT21pMDRJOG12?=
 =?utf-8?Q?xdY2ZodFdnEf8pOdSt?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <721BC95A1575ED498BC06C51BCED141B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: phil.gs
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6472.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4fd6921-99aa-4342-cf8b-08df25628e4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2026 17:35:33.3997
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 47d4f979-ea6f-4fcb-aea9-39371d64bc6b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tDwQS/KlNxEF9LoCpOk3OWkWC3BBc8WdKi68BzhRtBtJeu/SKm5Ux2sujkVA5gyG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB8391

DQo+IE9uIE9jdCA4LCAyMDI2LCBhdCAxOjAz4oCvUE0sIHNhc2hpa28tYm90QGtlcm5lbC5vcmcg
d3JvdGU6DQo+IA0KPiBbU2V2ZXJpdHk6IE1lZGl1bV0NCj4gRG9lcyB0aGlzIGNvZGUgaW50cm9k
dWNlIGEgcmVncmVzc2lvbiBieSBsZWFraW5nIHBvcnQtPnhtaXRfYnVmIGlmIHRoZSBzZXJpYWwN
Cj4gZGV2aWNlIGlzIHVuYm91bmQgd2hpbGUgc3VzcGVuZGVkPw0KPiANCj4gSWYgYSBjb25zb2xl
IG9yIG5vcm1hbCBzZXJpYWwgcG9ydCBpcyBzdXNwZW5kZWQgKGUuZy4sIHZpYSBzeXN0ZW0gb3Ig
cnVudGltZQ0KPiBQTSksIHVhcnRfc3VzcGVuZF9wb3J0KCkgY2xlYXJzIHRoZSBpbml0aWFsaXpl
ZCBmbGFnIGJ1dCBsZWF2ZXMNCj4gcG9ydC0+eG1pdF9idWYgYWxsb2NhdGVkOg0KPiANCj4gZHJp
dmVycy90dHkvc2VyaWFsL3NlcmlhbF9jb3JlLmM6dWFydF9zdXNwZW5kX3BvcnQoKSB7DQo+ICAg
ICAgICAuLi4NCj4gICAgICAgIGlmICh0dHlfcG9ydF9pbml0aWFsaXplZChwb3J0KSkgew0KPiAg
ICAgICAgICAgICAgICAuLi4NCj4gICAgICAgICAgICAgICAgdHR5X3BvcnRfc2V0X3N1c3BlbmRl
ZChwb3J0LCB0cnVlKTsNCj4gICAgICAgICAgICAgICAgdHR5X3BvcnRfc2V0X2luaXRpYWxpemVk
KHBvcnQsIGZhbHNlKTsNCj4gICAgICAgICAgICAgICAgLi4uDQo+IH0NCj4gDQo+IElmIHRoZSBk
ZXZpY2UgaXMgdGhlbiByZW1vdmVkIG9yIGl0cyBkcml2ZXIgaXMgdW5ib3VuZCwNCj4gc2VyaWFs
X2NvcmVfcmVtb3ZlX29uZV9wb3J0KCkgd2lsbCBldmFsdWF0ZSB0dHlfcG9ydF9pbml0aWFsaXpl
ZChwb3J0KSBhcw0KPiBmYWxzZSBhbmQgc2tpcCBjYWxsaW5nIHVhcnRfc2h1dGRvd24oKS4NCj4g
DQo+IFNpbmNlIHVhcnRfc2h1dGRvd24oKSBpcyB0aGUgb25seSBwYXRoIGluIHNlcmlhbF9jb3Jl
IHJlc3BvbnNpYmxlIGZvcg0KPiB1bmNvbmRpdGlvbmFsbHkgY2FsbGluZyB1YXJ0X2ZyZWVfeG1p
dF9idWYocG9ydCkgYW5kDQo+IHNlcmlhbF9iYXNlX3BvcnRfc2h1dGRvd24odXBvcnQpLCBza2lw
cGluZyBpdCBhcHBlYXJzIHRvIGxlYWsgdGhlDQo+IHBhZ2Utc2l6ZWQgdHJhbnNtaXQgYnVmZmVy
Lg0KPiANCj4+ICsgbXV0ZXhfdW5sb2NrKCZwb3J0LT5tdXRleCk7DQo+PiArDQo+PiAvKg0KPj4g
KiBGcmVlIHRoZSBwb3J0IElPIGFuZCBtZW1vcnkgcmVzb3VyY2VzLCBpZiBhbnkuDQo+PiAqLw0K
PiANCg0KICBTYXNoaWtvIHBvaW50ZWQgb3V0IHRoYXQgYSBjb25zb2xlIHBvcnQgcmVtb3ZlZCB3
aGlsZSBzdXNwZW5kZWQgaXMNCiAgc2tpcHBlZCBieSB0aGUgdHR5X3BvcnRfaW5pdGlhbGl6ZWQo
KSBjaGVjaywgYmVjYXVzZQ0KICB1YXJ0X3N1c3BlbmRfcG9ydCgpIGNsZWFycyB0aGUgaW5pdGlh
bGl6ZWQgZmxhZywgc28gaXRzIHhtaXQgYnVmZmVyDQogIHN0YXlzIGFsbG9jYXRlZCBhbmQgdGhl
IHN1c3BlbmRlZCBmbGFnIHN0YXlzIHNldC4NCg0KICAgICBUaGF0IGNhc2UgaXMgbm90IG5ldzog
d2l0aG91dCB0aGlzIHBhdGNoIHRoZSByZW1vdmFsIHBhdGggbmV2ZXIgY2FsbHMNCiAgdWFydF9z
aHV0ZG93bigpIGF0IGFsbC4gIEl0IG9ubHkgYXBwbGllcyB0byBzeXN0ZW0gc2xlZXAsIGFuZCB0
aGUgYnVmZmVyDQogIGlzIHJldXNlZCBpZiB0aGUgbGluZSBpcyByZWdpc3RlcmVkIGFnYWluLiAg
QnV0IGl0IGlzIGVhc3kgdG8gY292ZXI6DQogIGNhbGxpbmcgdWFydF9zaHV0ZG93bigpIHdpdGhv
dXQgdGhlIGNoZWNrIGZyZWVzIHRoZSBidWZmZXIgYW5kIGNsZWFycw0KICB0aGUgZmxhZywgYW5k
IHVhcnRfc2h1dGRvd24oKSBhbHJlYWR5IHNraXBzIHRoZSBoYXJkd2FyZSBzaHV0ZG93biBmb3Ig
YQ0KICBwb3J0IHRoYXQgaXMgbm90IGluaXRpYWxpemVkLg0KDQogICAgIEkgaGF2ZSBhIHYyIHRo
YXQgZG9lcyB0aGF0LCB0ZXN0ZWQgb24gdGhlIHNhbWUgc2V0dXBzLiAgSSB3aWxsIHNlbmQgaXQN
CiAgYWZ0ZXIgYW55IG90aGVyIHJldmlldyBjb21tZW50cywgb3Igbm93IGlmIHlvdSBwcmVmZXIu
DQoNCkJlc3QgUmVnYXJkcywNCi1QaGlsIFJvc2VudGhhbA==
