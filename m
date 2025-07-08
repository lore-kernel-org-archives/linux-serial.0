Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11022088.outbound.protection.outlook.com [40.93.200.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574802264B0;
	Tue,  8 Jul 2025 13:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.200.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751981872; cv=fail; b=AGq4L2UQwlFc+WgLlnefV+NduE+JsIRlqL2qO+s6+zyzcue3Ml4KYU+crsZUVvDRlS9fikUjQP7gUOVg+hgVaZQQBkqbzr2z7sriPJy0BKMZtAfWQgm+MN+EoCo4kHyV1cdcRc7t+eBm7Dwzl7V2164QgJKA59av+SfalPkinuY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751981872; c=relaxed/simple;
	bh=2CCVF652XUx8ruNa0qGvQo5BVxhXBPdQp2GKH/XNNsg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uExgt6hFKUeVPI/dgt8VHLMqw+yjt2oyAmInNptjmSKhhcCzVUYHloaNYo8g0R/ffXFS5lop2+GZ/+8g+nnZMI3gsuhgi9pt/czEW0Gf4tNSgLGOdSRy6Cb0JCrSeX4u+YwS4iuKX7sQ6WnVbOViHOAXYW5wdLzSgGDWf79fwwI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tektelic.com; spf=pass smtp.mailfrom=tektelic.com; dkim=pass (1024-bit key) header.d=Tektelic.onmicrosoft.com header.i=@Tektelic.onmicrosoft.com header.b=OGzCmSKb; arc=fail smtp.client-ip=40.93.200.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tektelic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tektelic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=Tektelic.onmicrosoft.com header.i=@Tektelic.onmicrosoft.com header.b="OGzCmSKb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jq21Rv70+ZAAinkaQF5BInn28cwXKNZKWQQGGnmE843NwxZGlEAoTaYPbdggOkbiBvoPgbcGvqpFnY0E9pnuqqmr0NPgOy/4zc3ldzwA49IO7jcoqcmZW03+muDOu+oi2wdnZp0w4/fICB/EbB2qTSEzpadOfl+LoYzmFwY3RXriz5W04SItcLTjH/CNP8/gYDJyhSFJgW7dCD2ri74LpVWk2rGzkRmVYEeI9ymmzthwh0Qd/6C8gPcMs5xi1AKG5j8VyxP9uqs4u4hMgaMOVdk6gPdJ+ABKwSV+hjhUjKrDqNkdvLaPRN7kMUGu0GPwQhv2N/9ApY2y+I90UfekOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2CCVF652XUx8ruNa0qGvQo5BVxhXBPdQp2GKH/XNNsg=;
 b=GwmDLPtk8zMOWnAKpnCfcy/gWPAT/G1C+zn9gQW5fROHtiBGK97swyUf8xRlQezufocs4P3zOjfRNoozf4ndBxI30z1DX7na5se244rIjQkN9U75Xy8ij2DlFVwsGD0I6/g6DWksNXowLdrvnlWkmA5yl8n2YAjQFtxr3UBig8XxHoD672lUmYEHcrq9z3qCIc0bB3OTc8jxfTQPiDgdMzJWVOMzIpuB9KAFj+OaPlKVDs8dYjprjwTTxH8lbULh0jq4kxNQILHjF2oio6qh/8bzgprVrr64dfNV0vQaXksOmUBCfxAqWyX9xDRWj4TEA5F2DO9/45gjrvsiEPm3NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tektelic.com; dmarc=pass action=none header.from=tektelic.com;
 dkim=pass header.d=tektelic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Tektelic.onmicrosoft.com; s=selector2-Tektelic-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2CCVF652XUx8ruNa0qGvQo5BVxhXBPdQp2GKH/XNNsg=;
 b=OGzCmSKbx8SxN+d0ZzkkpjB7IiSvzShQNmL5OewsxYg8lzX5CafzRiGYez01ldFTMR/AmuQKSzGcbx0ccTfUfQKL75PpBeypIKLLuuKrBfdvTm5b7Fh+JOjJUDmPnV5DEtZWECmroTnUVkfwS72yDCFxJov01u59LOj8Z9yUqMQ=
Received: from DM6PR05MB4923.namprd05.prod.outlook.com (2603:10b6:5:f9::28) by
 DS7PR05MB7446.namprd05.prod.outlook.com (2603:10b6:5:2cb::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.29; Tue, 8 Jul 2025 13:37:46 +0000
Received: from DM6PR05MB4923.namprd05.prod.outlook.com
 ([fe80::27b8:b7d6:e940:74bc]) by DM6PR05MB4923.namprd05.prod.outlook.com
 ([fe80::27b8:b7d6:e940:74bc%4]) with mapi id 15.20.8901.024; Tue, 8 Jul 2025
 13:37:46 +0000
From: Aidan Stewart <astewart@tektelic.com>
To: Johan Hovold <johan@kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
CC: Jiri Slaby <jirislaby@kernel.org>, "linux-serial@vger.kernel.org"
	<linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] serial: core: fix OF node leak
Thread-Topic: [PATCH] serial: core: fix OF node leak
Thread-Index: AQHb7+aAGDeMcNjlG0yBhZgxZzFcLbQoOyuA
Date: Tue, 8 Jul 2025 13:37:45 +0000
Message-ID: <2bd769b7f66bca4e97dba57276f5a29acdabb655.camel@tektelic.com>
References: <20250708085817.16070-1-johan@kernel.org>
In-Reply-To: <20250708085817.16070-1-johan@kernel.org>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=tektelic.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR05MB4923:EE_|DS7PR05MB7446:EE_
x-ms-office365-filtering-correlation-id: 65797420-6512-4bda-a7ee-08ddbe249f7a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZnFMbHcrZ2hFSFVKSzd6SE9KNzJ3S0RnRmxVTHl6Nk53bDRnWmhoWXBPQllz?=
 =?utf-8?B?NkpLU2JJM2V2THMrQlA3d3BPNEdlUFM4YUowaXBiNzRsYm5SWlYrTWhSK0gy?=
 =?utf-8?B?UXF3YmhjZlMrS0U3YnlEYkEwelpsbVd6UjZhT3VBZ3c4NnY4TmNNN2RFMm9x?=
 =?utf-8?B?Z1J1eWlaTURsNE8xSFNTSzN1UnNpQTJKRHEzMVo1OXVkMWQxWXUxNmtNUU51?=
 =?utf-8?B?NEE5bGtaN2hUTHJBeWZHUXJnQzUwTHFkOWV1cFVJNXZDemZybXBNQ0JodE5l?=
 =?utf-8?B?RTNaOFdzWmFPZ2pxUEQ4cDMzRXlwZWZjZ2xYQitXbTBRSElZWmVsTUxndUxB?=
 =?utf-8?B?SWFJL0ROTGt2T3Vjenh5TVNSenAxdXJZWS9xMlY0VnBySERheFVSTkZScmZI?=
 =?utf-8?B?UWUwV0VvZHdiOGVsczd0ZnZvWnZ0YTRzcXhjYkpNRVF5NGJrRFRtTGQ2eSsy?=
 =?utf-8?B?VTRvY0kwWERnV3dpMS9rMmUzakpKeFVmZG9XNDYvcTBWVGowOWkwU0tYWm1C?=
 =?utf-8?B?SWhuNGNOMjM4VjFVRXVuVk1NOEl1ZUF3dWlHOEYvTnVjeVB5UmVrUkd3alB6?=
 =?utf-8?B?MUltTjBxQVY1SkdYUWR5ZHdlektPQVJBUCtJKzFqM1doU0ZqbGU5bWs2OHRS?=
 =?utf-8?B?aTJlTDBSODcrRHlVNGFDdkc3a2dHbUJQTGtFVmN5Qi9aQ2h4UW9PaXl3MGUz?=
 =?utf-8?B?NitNRUthbFhsNFVzTEhHbVZmYThEbUFpZDRmaUtLUDJuZk1PT2Y0TkxjaCt1?=
 =?utf-8?B?d3VsK1dseWcwdHJaNHk5MzlXR1lpVVhCYUR5Q2xMRFlkS2JDQm1FK2JFSGVo?=
 =?utf-8?B?MHJyRTFEcFVydFZ2T0N1dmlPdEhNTnVrSDVUMmpOOXRoSkd5VnpFT3licGZp?=
 =?utf-8?B?L0pjWmg0cmQzZWcxbW1vV2RtYnExWjhoSngrYk1OdTJDZnhmM1NWMW1IV2dZ?=
 =?utf-8?B?VGFTZDhpa2JlRzRkclNwSHRhN0s0WUNuK2NaSGFKMElHRVRPU0UxalZMaFZx?=
 =?utf-8?B?T24wa1JadXU2eW8vazhTcVVubVoxdDliZEZzbm5WZlRDNmJCNVFVK1JLeHJl?=
 =?utf-8?B?YW9tditPM1pnMzE2NjE1czY3M1g0Qmpqenp5MjFYOGh1K1RqaSs0UnFrT1Fw?=
 =?utf-8?B?ZG1zclp5bysrOFVlQUpzSWR0Z0NBU2V6NVVodjcyQytSMzBSRzRQTHNBYmMr?=
 =?utf-8?B?UmZaT1Voc3FnWGxXa0xnMlc0ay8weExKeDFqNzVLbjZCT0pKclQ4aW1XMWZF?=
 =?utf-8?B?MXJmTkNLbUdva3ZUN0JMV1h4SzcyaDNXSnhFNWhFV3R4bHRGSE1PVzRIWmpL?=
 =?utf-8?B?cDNTNzRqN0RmUHhjVmVGN2l5RnQyaU1POGoxWFZWQW1JUE1MaFpGVHI5aXlx?=
 =?utf-8?B?cGNFU0EzeDZLZWxxZXJZVnE5QlRVNm50YjhSUVN5V2p6VE9mMFUzRUhNc1VJ?=
 =?utf-8?B?U05WT2crOFdEVHRXZ1Q0NERTRHkyemZPdmF5eTRIalFiYkY4QVJoS2Nac0ZI?=
 =?utf-8?B?TkVRaGlXcUkyK0FWblZyRUM0N1JzMDdUVG5iaG93RUx3TUE1eU9udzhidVJi?=
 =?utf-8?B?S3ZHNnppNWsvKytkZUplRXRFWDlTWGwrMHlKbW8zeURNbXFHZXdSMUx3dkRa?=
 =?utf-8?B?L0JIMkpmRms4Q3k0bXg3cW1sbmU5dVJZdFA3NlBhY1NIWWo5bXFFc0RSVWNr?=
 =?utf-8?B?RDExUWViMEZIRzRDbjdsTnozcGdhcC9EczY1M0FZNFlyN1IxeVJBbzAwMmFQ?=
 =?utf-8?B?WHFxaEt4SytXN1JQR2xzbGhqTkFYa0ovTmhOUmpaVEtmVTczTUlEc0I1M3Fr?=
 =?utf-8?B?NXdFOFpCZTdQV24zTTFJR2RnaFMxVjU2R0s3dW5ZQlFCZmNXa2VhNEVESzQ3?=
 =?utf-8?B?QXZYUFB1enVJV3ZrRlVXU1BreWgyVWtoT2pzUXNSMVNqaWVoOGMvb3RQYzdB?=
 =?utf-8?B?L1A2VUdiRFRsWE11ZDdTeVR6cldXRE1yMlp0Z21jYUw4TXU1WnoybGNDYk5T?=
 =?utf-8?B?TStaVFlOZmN3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR05MB4923.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?c0dCT2JvME8wVExJRERFVU9XNWFQNzgwdW1CL0ptcGp1Y0ppNzZJdDdXMEpk?=
 =?utf-8?B?WlN2S0EyVUxyQ1N0YVdvV2pQeWJ1MFJMZTQ1T1Q2NGluV0FvZDVMcjZpY2hV?=
 =?utf-8?B?dmtIamZjYXVsaTE3a3lsK3JSeGJDTmN6STB5c1IrMzBVMmJMWHR1ZGROek1i?=
 =?utf-8?B?ZmpYaFNUb3ZYampod2pSTEo4UFdmNXUrYk80NWhCcjZZcVZmc3ptRm9TRG9u?=
 =?utf-8?B?d1pxNG1oWGVib3JrNFlDNWxVKzFOLzZ5K1h2Z0NpdEwvSFpHUkFIMTlSb3R5?=
 =?utf-8?B?OVkwdDNMdHNzV2xKV3p6ZlR2NHZ4QkZubXBmU0EyeGlBR2czVDZISVUxL0dF?=
 =?utf-8?B?MmF2MlRtWGJRSWU0QUEySlMvTXFXMnhHeXlkUHJKYkZib2dsNTlEb0NpM0xU?=
 =?utf-8?B?amhRcWtwRTEwcFRpSkRGTGZvcnNtUEFuYXJVK0FIdkpvSk5rZ0o0SytENENz?=
 =?utf-8?B?RDliYnlWcnozVFh1ZDgveVZaaXJuSHBpN1VINkZ6ZW1XUTkxU3diNmhNRW9S?=
 =?utf-8?B?Sk85SEVEUllSSVVlNCtWUU9pQ1NyM2NWOWk3S2R6MHBHY2tHcmR5QjZwc2xM?=
 =?utf-8?B?d1dYemxNU3d5aElPOXBpV21XQWp4ZEhIcWZkNG81RWhWV0N4TmI0OVRieTM5?=
 =?utf-8?B?ekhvd3pPMkdxY2lteHFXVkdkMzB6T25WblhoeGdPdmhBcWU0elg3M0F6UkV5?=
 =?utf-8?B?d1BrcVA4MG4rR1ZhUTB3NjNzcDV5VFg1MnJtZWREUWpjQzAzOFZzL1hVM0pX?=
 =?utf-8?B?d3cvb2M5aGJ0bXZSY3NFdjRjNDRCdGlVM2FvWUF2TURMM3dlL29ES2xEWkNB?=
 =?utf-8?B?OUdncG9DLzQ5NnJjek5vUlJKM1o4Y2RHV3lJUWVwYWNwM0ZZVkFwK0JaMktG?=
 =?utf-8?B?RmdaVkIyVkJuaS9aTnJxdzllL1dwb1l1VGhnVDV4YVpaS25OazFrZVVCaFpC?=
 =?utf-8?B?WXUyYjZId2VYWXBNNzhrYUVGc1ZQN1pDd3U4UGIwWU9YNkdiTUZVMURHNTZt?=
 =?utf-8?B?ZUR5aWd3S0pzeTJWRzhYWTVkdDdVOEpDVzBpWmhUSTZtOXduY0JhWFFqY3Y4?=
 =?utf-8?B?ZHY0OFMvZVhnMklRWTVwa041S1lYYSt2bFpMaE5zT0FBRFJiTG9iZERqSGQv?=
 =?utf-8?B?bHYyT3diTHlJZXZJUDFMZHBMdWVYelVOOE1Zb3Z3Yk93L1RxLzJZdFRnZ1F3?=
 =?utf-8?B?R1lwaUV0MG95SVAyVU0yZytFS2JTWnk3Zm83cy9VYjFCUERhWDNRejU5SU5D?=
 =?utf-8?B?bWpnMjlWVlQrbFJVTmhmNXAyVDdmZ1hONnNBWkdiUE9jOW5ld0RDMTFHZzhD?=
 =?utf-8?B?UnhudWlrb0lCOC85VWFncTdKLzlGVWZtUE5QMkFJd0dINE1Lb2U4Wm90MUlD?=
 =?utf-8?B?MUV0UGZYczFXMHFoeVhmanYwakovaytVSS9WTzRlbm5Nak9TVzNjU3JJSmZn?=
 =?utf-8?B?KytLK04yU05FcGZJY1BLY2IrdU16ZEFUM1JQa2laNTB5ME9EbkdPcHBINHZG?=
 =?utf-8?B?ejR6V2kvckZBNG54MDNjRGpJcnlESEZnMVcydUE3Nm9lOXJRN0RIbG9lVEdD?=
 =?utf-8?B?TWFvZ2k4UkhLWWVNb2hwNmhsMC9ydnRzeTR1cVVSRnQvNW4vanRyM2o3S3Nu?=
 =?utf-8?B?UC9PcFJTcndmNzB1aVhJZnVpNk51L0VEalc3VGV5aGtRd2NwNXVlZ21MdXNQ?=
 =?utf-8?B?WHJKa3h0Tm15MWJxQnJJNXRNTFlDTHRzdVVoVUdUOURNRUdrdGl1RGFYcThM?=
 =?utf-8?B?eVVyTHl5OHBvaGI4cHZQaDRPcS9oTkltM21Ub3Y0RmJrTEc0K2NjWllYVmxP?=
 =?utf-8?B?bXNnUkF0TGVja0NKVUNBY3JKandKOEE2S3BJVXpnT1UvTEZMTUZJdU1Wc1Rh?=
 =?utf-8?B?L2s3dUtNTnBqSS9FYlo3NUdvMFRKdU1XTGV2N1NwdldNMG1oeG9GZWRRNkxy?=
 =?utf-8?B?NzBmNmlmR1hLOCtxMUtPWEkxZjFVbU56UHlCT1U0ODdjMlUzUjFveDlrV2hL?=
 =?utf-8?B?aFBQb1c1WUtWMzFKYncrd3I2c3pCRXNjcnFYRy9JcW1jQktzUzZJQXFnR2JC?=
 =?utf-8?B?K0Z2bTlxY2paVUg0TDRkTkZhYVFKM01pWnZubUZJU24yTkVDVFVlbE8rWmN3?=
 =?utf-8?Q?nTcNYVGgGLhQh0bv9leWpydzY?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7F922F6D8A5A2943A56FF48F673AF8A8@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: tektelic.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR05MB4923.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65797420-6512-4bda-a7ee-08ddbe249f7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2025 13:37:45.9561
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 852583a0-3638-4a6d-8abc-0bf61d273218
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BRSFIC26rNmMg3UH0hZMd7sgHPe0Ev18cB2UxuCUI75hy2ZUcgz6qTE7ZtjWk9rhs4wzOWUwB/Vc6rvsGfKhFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR05MB7446

SGkgSm9oYW4sCgpPbiBUdWUsIDIwMjUtMDctMDggYXQgMTA6NTggKzAyMDAsIEpvaGFuIEhvdm9s
ZCB3cm90ZToKPiAKPiAKPiBDQVVUSU9OOiBUaGlzIGVtYWlsIG9yaWdpbmF0ZWQgZnJvbSBvdXRz
aWRlIHRoZSBvcmdhbml6YXRpb24uIERvIG5vdAo+IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNo
bWVudHMgdW5sZXNzIHlvdSByZWNvZ25pemUgdGhlIHNlbmRlciBhbmQga25vdwo+IHRoZSBjb250
ZW50IGlzIHNhZmUuCj4gCj4gCj4gCj4gTWFrZSBzdXJlIHRvIGRyb3AgdGhlIE9GIG5vZGUgcmVm
ZXJlbmNlIHRha2VuIHdoZW4gaW5pdGlhbGlzaW5nIHRoZQo+IGNvbnRyb2wgYW5kIHBvcnQgZGV2
aWNlcyB3aGVuIHRoZSBkZXZpY2VzIGFyZSBsYXRlciByZWxlYXNlZC4KPiAKPiBGaXhlczogZDM2
ZjBlOWEwMDAyICgic2VyaWFsOiBjb3JlOiByZXN0b3JlIG9mX25vZGUgaW5mb3JtYXRpb24gaW4K
PiBzeXNmcyIpCj4gQ2M6IEFpZGFuIFN0ZXdhcnQgPGFzdGV3YXJ0QHRla3RlbGljLmNvbT4KPiBT
aWduZWQtb2ZmLWJ5OiBKb2hhbiBIb3ZvbGQgPGpvaGFuQGtlcm5lbC5vcmc+Cj4gLS0tCj4gwqBk
cml2ZXJzL3R0eS9zZXJpYWwvc2VyaWFsX2Jhc2VfYnVzLmMgfCAzICsrKwo+IMKgMSBmaWxlIGNo
YW5nZWQsIDMgaW5zZXJ0aW9ucygrKQo+IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3R0eS9zZXJp
YWwvc2VyaWFsX2Jhc2VfYnVzLmMKPiBiL2RyaXZlcnMvdHR5L3NlcmlhbC9zZXJpYWxfYmFzZV9i
dXMuYwo+IGluZGV4IGNiM2IxMjdiMDZiNi4uMjI3NDlhYjA0MjhhIDEwMDY0NAo+IC0tLSBhL2Ry
aXZlcnMvdHR5L3NlcmlhbC9zZXJpYWxfYmFzZV9idXMuYwo+ICsrKyBiL2RyaXZlcnMvdHR5L3Nl
cmlhbC9zZXJpYWxfYmFzZV9idXMuYwo+IEBAIC0xMyw2ICsxMyw3IEBACj4gwqAjaW5jbHVkZSA8
bGludXgvZGV2aWNlLmg+Cj4gwqAjaW5jbHVkZSA8bGludXgvaWRyLmg+Cj4gwqAjaW5jbHVkZSA8
bGludXgvbW9kdWxlLmg+Cj4gKyNpbmNsdWRlIDxsaW51eC9vZi5oPgo+IMKgI2luY2x1ZGUgPGxp
bnV4L3NlcmlhbF9jb3JlLmg+Cj4gwqAjaW5jbHVkZSA8bGludXgvc2xhYi5oPgo+IMKgI2luY2x1
ZGUgPGxpbnV4L3NwaW5sb2NrLmg+Cj4gQEAgLTkzLDYgKzk0LDcgQEAgc3RhdGljIHZvaWQgc2Vy
aWFsX2Jhc2VfY3RybF9yZWxlYXNlKHN0cnVjdCBkZXZpY2UKPiAqZGV2KQo+IMKgewo+IMKgwqDC
oMKgwqDCoMKgIHN0cnVjdCBzZXJpYWxfY3RybF9kZXZpY2UgKmN0cmxfZGV2ID0KPiB0b19zZXJp
YWxfYmFzZV9jdHJsX2RldmljZShkZXYpOwo+IAo+ICvCoMKgwqDCoMKgwqAgb2Zfbm9kZV9wdXQo
ZGV2LT5vZl9ub2RlKTsKPiDCoMKgwqDCoMKgwqDCoCBrZnJlZShjdHJsX2Rldik7Cj4gwqB9Cj4g
Cj4gQEAgLTE0MCw2ICsxNDIsNyBAQCBzdGF0aWMgdm9pZCBzZXJpYWxfYmFzZV9wb3J0X3JlbGVh
c2Uoc3RydWN0IGRldmljZQo+ICpkZXYpCj4gwqB7Cj4gwqDCoMKgwqDCoMKgwqAgc3RydWN0IHNl
cmlhbF9wb3J0X2RldmljZSAqcG9ydF9kZXYgPQo+IHRvX3NlcmlhbF9iYXNlX3BvcnRfZGV2aWNl
KGRldik7Cj4gCj4gK8KgwqDCoMKgwqDCoCBvZl9ub2RlX3B1dChkZXYtPm9mX25vZGUpOwo+IMKg
wqDCoMKgwqDCoMKgIGtmcmVlKHBvcnRfZGV2KTsKPiDCoH0KPiAKPiAtLQo+IDIuNDkuMApUaGFu
a3MgZm9yIHRoZSBmaXguIEkgdGhpbmsgdGhpcyBhbHNvIG5lZWRzIHRvIGdvIGludG8gLXN0YWJs
ZSwgYXMgdGhlCnByZXZpb3VzIGNoYW5nZXMgaGF2ZSBhbHJlYWR5IGxhbmRlZCB0aGVyZSAoNi4x
Mi4zNiBhbmQgNi4xNS41KS4KCkFpZGFuIAo=
