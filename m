Received: from FR4P281CU032.outbound.protection.outlook.com (mail-germanywestcentralazon11022115.outbound.protection.outlook.com [40.107.149.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C70378803;
	Fri, 22 May 2026 09:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.149.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779440530; cv=fail; b=vAKCZC0Xa8Tgj4dl/xW9XZ51Kxtz7g9eaWcJzqtx69auZKThE+tbe4XyoJqZS0P5zHxHqnbtuGKIGYI41iFVtYTxjCJjInSRU7khgz/NUMUjy8uPLJ8nsCJ5Bc6VyuMNdGMpeA4DUqvIUrhjIKqZUUdBF5Wmy3vnL9hI0LtdNdI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779440530; c=relaxed/simple;
	bh=60uRcTb8XUhql/m6au+NdgBEsSjCwlTuevT4TKrbxw4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rWCefisEQMMicsFEhKyEtCemtLmcSdfYz9pDfGh8U670zcIXgu5OrvnGt56XYTHiAoR50ntQ4lpbAzMBx8J9QbWdRd50AvlhtDrA608WwKZOqs7rRMuydmoLjQtVAmKEx47QTCnvnQIMBq9FWQRvJBRP5B7sLpZbPdHYFzU3JwE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=KBSgmbhfr.onmicrosoft.com; spf=pass smtp.mailfrom=KBSgmbhfr.onmicrosoft.com; arc=fail smtp.client-ip=40.107.149.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=KBSgmbhfr.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=KBSgmbhfr.onmicrosoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wbb5PEy1+FeFddc8AZHtbDom01JK6LrcUmKEaguJEZwXh95YihjKhrehJN1C/AlEDaAnLeja+cnKTSCm5aAsxwq2Hlmwpzs6Kyagy7RTYWzQ9FqVzj9Z0vud20d00B+37lOq/d3fnHFlMzaQhdp+B9ixuuTMLxbJAKEIomR16skeuO77K5cOJD6NAfFC/BP6i8N/Vxjv9EcbZaWj50jCdi6UcogVBC2LJt9emNVRAySgsLd4yMQ+pNDggvP2EYpjdB7Ethf91zu3KIUYjquuEiEFFcrJ9tSvvL6GUsBqlCGJWayYwHoLR56avCQ6//VuJczFLHlPpKHkVw3XTy5BzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=60uRcTb8XUhql/m6au+NdgBEsSjCwlTuevT4TKrbxw4=;
 b=YiBP5BVgdvbHGz4FHa8agB5z9Wcz+ae4BFlIYkLz+PDMNy0QqbGTMZKhraT8rp4xzHIrj8nvlWVFO8Jyc4IkEeSuRoklN+J3KyjxIJYM8YJOA8x75r55o4cXCTS4CVwwuPOXaGGV6l85bdQ4pBNOC0PDmv0ojMYk5RMHN0eKU+5qKqKfwoPTMCdLnAGyOnPPgy+S8hKuiM+nAdko5LikHOMfGqboEuIWv6OArsseGJ+MheXREg6SyS4SQIuxYe5tIE59QUSgyDst8YpWhgNHU98Pt30TMcFeJy6IBzY2+8WS8O9Vsnn0v5E99nXCurhTwWKu/Jqr64pXNNMTheIb3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kbsgmbhfr.onmicrosoft.com; dmarc=pass action=none
 header.from=kbsgmbhfr.onmicrosoft.com; dkim=pass
 header.d=kbsgmbhfr.onmicrosoft.com; arc=none
Received: from BE3P281MB5515.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:de::17)
 by FR3PPFE0BD208CF.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d18:2::19e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 09:02:05 +0000
Received: from BE3P281MB5515.DEUP281.PROD.OUTLOOK.COM
 ([fe80::fce2:69d7:2d84:7d9e]) by BE3P281MB5515.DEUP281.PROD.OUTLOOK.COM
 ([fe80::fce2:69d7:2d84:7d9e%3]) with mapi id 15.21.0048.016; Fri, 22 May 2026
 09:02:04 +0000
From: Matthias Feser <mfe@KBSgmbhfr.onmicrosoft.com>
To: Moteen Shah <m-shah@ti.com>, "linux-serial@vger.kernel.org"
	<linux-serial@vger.kernel.org>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "jirislaby@kernel.org" <jirislaby@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"k-willis@ti.com" <k-willis@ti.com>, "msp@baylibre.com" <msp@baylibre.com>,
	"andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>
Subject: AW: [PATCH v3] serial: 8250_omap: clear rx_running on zero-length DMA
 completes
Thread-Topic: [PATCH v3] serial: 8250_omap: clear rx_running on zero-length
 DMA completes
Thread-Index: AQHc6cmpkWJympNL0E2Tmon8Wyktig==
Date: Fri, 22 May 2026 09:02:04 +0000
Message-ID:
 <BE3P281MB5515A937D47F610974FAEFA7EE0F2@BE3P281MB5515.DEUP281.PROD.OUTLOOK.COM>
References:
 <BE3P281MB5515563BFB5DE5E093ADAD9DEE0E2@BE3P281MB5515.DEUP281.PROD.OUTLOOK.COM>
 <4b8c59fe-c6a1-47cb-ab3b-855b1edddde2@ti.com>
 <BE3P281MB55153573889A8124C06291F1EE0F2@BE3P281MB5515.DEUP281.PROD.OUTLOOK.COM>
 <ab76b900-6d1c-4218-a14a-59541b92f2c6@ti.com>
In-Reply-To: <ab76b900-6d1c-4218-a14a-59541b92f2c6@ti.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=KBSgmbhfr.onmicrosoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BE3P281MB5515:EE_|FR3PPFE0BD208CF:EE_
x-ms-office365-filtering-correlation-id: 4fc16c3d-4f3f-4345-c0ab-08deb7e0cb8f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|38070700021|6133799003|18002099003|22082099003|56012099003|4143699003;
x-microsoft-antispam-message-info:
 jwU7mSqfMBDPnss3yhXOMo+wDiVaYebBsFak78Ev3t2r7podErUC+nFmXSBOFFTsOPtogtAFMgLBRP1dg1aB9HKDjy7Rmms4DzbbVnroXMt3pFg7D/orj9cI/zaWEx/1uYFBjT8spI9GBnEeIEBMwiX5dx+oQvu+a80Ausorbqaj3AewjgnOJ/sptzcsrnDDGs9RtxddDSg7uZIX0yZ4PdvQHZs/9xuNkUPxXeSXFcMNIKpvXm9hJ+VisbXrw3tmVZla2gL3LJZ26V409P01ZBcTjJ8cQQzmLmFKQkBlzHCV4aYqMIgtzYc0UVEpwFch0DcXX2h9ei+8/1kM+hCwWevvNB6KYF+aYBL4XEcqmquwT3M7OaHuIxxIo6gDNvjoM9ilm/yOEd1MfmVvOfGbre+ZvdfKtxSpyLvvishiwi0TqyohDvjpHaeEpUA/I6/R3AR+Sl5+uoCLjA3vL5xdhLcItePdrldfFHdXlgkfM3P0CeTmILqd6URUGIIkV1FgnWDqvk0m0xUQaLa5O3MmPqndz7xkX+XH66E6lr1KNUJ3e7sWY/66Nmq4sG+iqNXUGhZJkOJX7AlN2dIK8FaGxIk2tB6WR70ZesHFe7Haa9fpPiCHwk/FjC4suirOIHIUcQ4PNGFJ8DKltR+vEf+NSby/ZIZKLXd6KrkTYMbDFtPPV++Q5Q7jXgDXAshi7jumBbWWf6KR7E+JCrQ0zZ2sJrwHDx+aAIV1ShXw1DDlnkz25AHx4Nl/321OmZmFlLlf
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE3P281MB5515.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(6133799003)(18002099003)(22082099003)(56012099003)(4143699003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TDB0WThhT1ZYSnlyMkUyZm1oKzdQRXkrOG9KQndpc3FxcGpzR2FhN1dtekVI?=
 =?utf-8?B?ajlDaFFyL1ZEKzBBZm93STNuTk5ackRmRUplYlZPa2RTUEdIN2dLYTZvV0FV?=
 =?utf-8?B?dEFFRDVzVW90Y0R3QVRGendkeG9VQU0rNWJSWmxHMkFNbkx0UTVSTnRPQnU1?=
 =?utf-8?B?eDBIYmxSdWlxWWZiOFhUSTdtSjdKV3Jya0dXTy9IYlZHbFhpb0VENE9jWXN0?=
 =?utf-8?B?OUdaM3l4d01PVldJSi81SjdzV2ZJUTF1RzV4aWNHVHZ3YWtmM0tycEtNODhu?=
 =?utf-8?B?NUFlbHBOZ3lLTGQrK3BHY2FZOEJCRzN4dWZYckhGbnY5ck03QnRGVW5jOE04?=
 =?utf-8?B?MlJ6U09ja1NCWnlDMGdVOGczYmlRdjJOSFBXVE5BWVJHR0R1TlQyUFVTZFVq?=
 =?utf-8?B?VmM2SXNkTHpLeWpCZkhaOWRobXRzc2l1S0lZajQwWnlUVmZQODFlQXlBOUNw?=
 =?utf-8?B?MFQzaG9lNzloclRMTXNadlpzdFpyd2srRkNabzdCNWhwTkZsN2RWNEhqWEFs?=
 =?utf-8?B?ZG1qc3RYdmw5UEZtS1AxYnFYWlV3NjM0K0JlK2F5V3RKVCt6MktYclEreWI0?=
 =?utf-8?B?V1gzV0liKzQvK2wvd3AvbkZFV3E3Y1RzZU53L3hXTkY3OHcvdEZCWUoyWEEz?=
 =?utf-8?B?OE45L3hMeUpQWEp6UVZpN3dkbnFLM3g2WG0wM2g5bUJaak9GVElVWnJQd0p4?=
 =?utf-8?B?R3A2R2F5L3k2dmVIS00wTDg3QjRnbnlRdXZ3NnBtZGgwN3c2czF4UXRjSStv?=
 =?utf-8?B?V1lpUU1HYS9vSitVUTNxOGQzdDJIN0NLTWVhV21yN0U1NWJzRWpOYlozeEVs?=
 =?utf-8?B?OE9WSkVjVC9rRk9TTm5kbWNwdFllZTJaSTErdHM0TnlkeWRwSW1WL0VjOTJX?=
 =?utf-8?B?cERGbk0xOU9KRkdDdkdIb0VKdkpCY01RNjNhL2FDbFA3WVlhWjR1Ti9yUzNK?=
 =?utf-8?B?YWJoWk8vVSsxd2QxZWxYQXpySlgwenJRcEUxRnlwRC85L0tnRFFVUXNXZVNk?=
 =?utf-8?B?ZWFvOUVkNS9UNU8xUFJOcXFJT2Y2cSs5SFRBSkhlQU5Mbk9ubTI3VnRtUWdv?=
 =?utf-8?B?bUV2bW0ycFgrK3JMSUxtd1JRRllZaDA4N1lFN09lM0xwdGJyMFR2amxUZldp?=
 =?utf-8?B?ZllZSS9UM1c4Z1o3NVgxN3o5TVBXR1ZTRnNmWXR1L3VUNXMyNHAzVCtnRi9u?=
 =?utf-8?B?aXh3WXljK2grV2hmeDZ0V2NHTVh5aHhnOXpiQWkwYkNMeFNJYjlZU3V4MmFE?=
 =?utf-8?B?ekZIQ29GOE10Wkw4T1p0b05CbjcrbXdHUzVZRUcrWk44K2FneFdiL1NPZEZh?=
 =?utf-8?B?cmtYeEN6U0RZTzZ3bEcwc29xWG1JRnVZNjlXNmZITDlFaC91VXNIeCtUUFp5?=
 =?utf-8?B?U0tVUWlZU3NEdmd3a2t5U0N4ZVUrdFQyQWFkY1R6cDhCYUVZWUZ0UVU1VVVk?=
 =?utf-8?B?bnpPWlZLUEtKMzMzSFJCRXBMZzJ2c3hEeW5SWGlMNHRTbGlyTW9GV3UwL21Z?=
 =?utf-8?B?VGs4L1ErZmcyZ3UrakUxZFJFakVHWVRDRW80Zjg5dktqWXFJWm45L2pEY29H?=
 =?utf-8?B?cXJWMUVZc0I1bDZxQXd0ZEpLK2Z6OGFHemFxSDEvcnpnbitZUzFEWEI1WkVs?=
 =?utf-8?B?aVI0ZG0xTk5oZTlqdHBEZ2hzaC9tR0ZqREpmaC9tRlVpeTdlZ0pSTXhOaUJv?=
 =?utf-8?B?Q3pWK2kyekVCc1BMZTR2ZFZIUW9Ndk5rR2I3ZElSYTBMdVRKZDZkRWNFeXI4?=
 =?utf-8?B?Q2pGOVczZDJ3TkVJZ01hbEVwQTJTOWZ6NnJpK3VzSENQWWlXenlWcTRJb3pE?=
 =?utf-8?B?S3kzWWJ2WVpxdWIzRGJvY1dDV2g1RU5VbVZYMEk2eUQyd0lEWkd4NG9GK0RZ?=
 =?utf-8?B?MFJyN1dDMjk3NFh2YitIQjFvSWJWbndKQU9ITXBQWGJ0RmtBU0hBZjYzVXVm?=
 =?utf-8?B?VUxkSEx6Q2xVTU1zY08yT1VRL1hJZnZyb2phR25DMGhPZFpXcldvUkRJeE1s?=
 =?utf-8?B?WGg2SVdFRUFrM3NBdzNkVVRCa0Q4MEhUREVpZmFWQUExT1dyY3l2ell5Z1RS?=
 =?utf-8?B?V05xZ3BKWkh2MmhMZmN3SnBCY2ZOMHdUQVJZYkV4Y2h6cWl4MWFvL25IZnZv?=
 =?utf-8?B?Z0EwSG1aNVhuckM5dDVuU0YxYVpFRGI5OGN1dUdWdjhSYTgzQ0taMjlhdmVO?=
 =?utf-8?B?ZkJoZ3JrRXBYTlAzemJHMnd0bG5lc3JRazZ1R2JFZlFmYzBUT1AzWHFONjNG?=
 =?utf-8?B?OTNLRFByNDVDUnoxZ3NUU3krdXk2eEdySWt6bU5Qb05lVzgzaDJ1YWdOamlp?=
 =?utf-8?B?UVFrN01JOEZWd0dOUXNXcjMrUkxVM285bm1wZURrQnhpNHdQZ3QzKzliUkVk?=
 =?utf-8?Q?QeB1gZwwioXhXiZ0=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fc16c3d-4f3f-4345-c0ab-08deb7e0cb8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2026 09:02:04.8897
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f174257-ca3b-4127-8fed-91fa39cecdd6
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s5/RyWJgTDlGl8LsAoZS+Yxx8zhekEulbxLbZf+k2YD3+4EKXw+YcMbeU73ofyN1e3TUCk9K/uNIkAdW5mmKj3Zq3c7aDHG6QpVIGCPxqNY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR3PPFE0BD208CF

T24gQU0zM3h4IFJYIERNQSBvbmx5IHRyaWdnZXJzIHdoZW4gdGhlIEZJRk8gcmVhY2hlcyB0aGUN
CmNvbmZpZ3VyZWQgdGhyZXNob2xkICh0eXBpY2FsbHkgNDggYnl0ZXMpLiBGb3Igc21hbGxlciBi
dXJzdHMNCm5vIERNQSByZXF1ZXN0IGlzIGlzc3VlZCBhbmQgdGhlIEZJRk8gaXMgZHJhaW5lZCBi
eSBSWCB0aW1lb3V0Lg0KDQpJbiB0aGlzIGNhc2UgX19kbWFfcnhfZG9fY29tcGxldGUoKSBjYW4g
bGVnaXRpbWF0ZWx5IHNlZSBjb3VudCA9PSAwLg0KDQpUaGUgY3VycmVudCBjb2RlIGV4aXRzIGVh
cmx5IGluIHRoaXMgY2FzZSBhbmQgZG9lcyBub3QgY2xlYXINCmRtYS0+cnhfcnVubmluZywgbGVh
dmluZyB0aGUgRE1BIHN0YXRlIGluY29uc2lzdGVudC4gVGhpcyBjYW4NCnByZXZlbnQgUlggRE1B
IGZyb20gcmVzdGFydGluZyBhbmQgbWF5IGNhdXNlDQpvbWFwXzgyNTBfcnhfZG1hX2ZsdXNoKCkg
dG8gZmFpbCwgbWFya2luZyBETUEgYXMgYnJva2VuLg0KDQpGaXggdGhpcyBieSBjbGVhcmluZyBk
bWEtPnJ4X3J1bm5pbmcgb25jZSB0aGUgRE1BIHRyYW5zZmVyIGhhcw0KY29tcGxldGVkIG9yIGJl
ZW4gdGVybWluYXRlZCwgZXZlbiBpZiBubyBkYXRhIHdhcyB0cmFuc2ZlcnJlZC4NCg0KU2lnbmVk
LW9mZi1ieTogTWF0dGhpYXMgRmVzZXIgPG1mZUBLQlNnbWJoZnIub25taWNyb3NvZnQuY29tPg0K
LS0tDQpDaGFuZ2VzIGluIHYzOg0KLSBNb3ZlICJDaGFuZ2VzIGluIHYyIiBiZWxvdyB0aGUgdGVh
ciBsaW5lIGFzIHN1Z2dlc3RlZA0KDQpDaGFuZ2VzIGluIHYyOg0KLSBNb3ZlIGRtYS0+cnhfcnVu
bmluZyBjbGVhciBiZWZvcmUgdGhlIGNvdW50IGNoZWNrIHNvIHRoZSBzdGF0ZQ0KICBpcyB1cGRh
dGVkIGltbWVkaWF0ZWx5IGFmdGVyIERNQSBjb21wbGV0aW9uL3Rlcm1pbmF0aW9uDQoNCiBkcml2
ZXJzL3R0eS9zZXJpYWwvODI1MC84MjUwX29tYXAuYyB8IDIgKy0NCiAxIGZpbGUgY2hhbmdlZCwg
MSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvdHR5
L3NlcmlhbC84MjUwLzgyNTBfb21hcC5jIGIvZHJpdmVycy90dHkvc2VyaWFsLzgyNTAvODI1MF9v
bWFwLmMNCmluZGV4IGM1NTJjNmI5YTAzNy4uNzZiYzhhZDMyNGNiIDEwMDY0NA0KLS0tIGEvZHJp
dmVycy90dHkvc2VyaWFsLzgyNTAvODI1MF9vbWFwLmMNCisrKyBiL2RyaXZlcnMvdHR5L3Nlcmlh
bC84MjUwLzgyNTBfb21hcC5jDQpAQCAtOTQ0LDExICs5NDQsMTEgQEAgc3RhdGljIHZvaWQgX19k
bWFfcnhfZG9fY29tcGxldGUoc3RydWN0IHVhcnRfODI1MF9wb3J0ICpwKQ0KIAkJCQlkZXZfZXJy
KHAtPnBvcnQuZGV2LCAidGVhcmRvd24gaW5jb21wbGV0ZVxuIik7DQogCQl9DQogCX0NCisJZG1h
LT5yeF9ydW5uaW5nID0gMDsNCiAJaWYgKCFjb3VudCkNCiAJCWdvdG8gb3V0Ow0KIAlyZXQgPSB0
dHlfaW5zZXJ0X2ZsaXBfc3RyaW5nKHR0eV9wb3J0LCBkbWEtPnJ4X2J1ZiwgY291bnQpOw0KIA0K
LQlkbWEtPnJ4X3J1bm5pbmcgPSAwOw0KIAlwLT5wb3J0Lmljb3VudC5yeCArPSByZXQ7DQogCXAt
PnBvcnQuaWNvdW50LmJ1Zl9vdmVycnVuICs9IGNvdW50IC0gcmV0Ow0KIG91dDoNCi0tIA0KMi4z
OS41DQoNCg==
