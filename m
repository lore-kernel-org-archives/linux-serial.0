Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4D01C3025;
	Tue,  5 Nov 2024 12:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730809102; cv=fail; b=cuSnXkBuopc4FnyNRFlW6b0dcJvFDigXnJjHxoH/yB8yfilqDW1ih/w5la8sI/su2E+XjtStvKq5NmGMD68ScDYYfY5WqzkIiw/RXt/BRg/8hMx3UiThb6RYSMAUNORAIOWArsJ8BwPgRoj5lRyefQ6Yq4/YwF7zGe1vMy/C05Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730809102; c=relaxed/simple;
	bh=bh53bN5DXCfRWw4RTJBj+ZIJYRqxHlRbTaMi2ZWWi08=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rulC7VtDyYVnaUzKLBP5xVPGJQwelGjabDhNsDB5Cr5Yj9duhhQy1phauZIwvfReQYtrV2oH9xPhlR1QRydKPVMgiaick7BmJJbaYRx+FobsTQevGzXIF4EONoFguk4ivJDEualz6fKe0bID/47C0o+V9lVE8C/I+C14b+hFGl4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=7D/vzAZC; arc=fail smtp.client-ip=40.107.243.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="7D/vzAZC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hKgmZJs8FZFhJLCOUQ7+djwXuMg4qphphYbp20PXaPrYRIzE09th7oW30IFKU6Tl0nmW22RF/lMrS/XRcYHtXBc3GU0FfdGdyy0V6meXsIwITTe7vxso8dRIYapUX+ePf9Me109rW5Ou6mQcHw2Y9S08DAkZYnluwta3OiXhl2a6kPVVuSrjfuqzI5XcPVYNup3RengKd7TExzCSh+yf5T2Dl20/lCr0u7Y0wc69KhgWFi3sLivTa9LRLN0lWlNnz6GrltMrKC2FCoTmBTDBYg6kyFb1V+0xVfgCwcLNBylpAoW0UBU8oCxGUYHqJenq8srFtYTIZ5WcTV46UlYN1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bh53bN5DXCfRWw4RTJBj+ZIJYRqxHlRbTaMi2ZWWi08=;
 b=SxNQxxqwP/4u093O9pLY97oNcPHpFV+2ToylceHyUEdHPAH9xojXICqSrwnAQYcvtwAqc7X8OsqEenkPKTg+jhwYKdT/DV7axMFWIEG2n/R4Pj5ZkdBSydrP6otRceC4IGkyUmtmuqn3HKFNEgzd8kdhA0vpEQYgBviJGwey5vWLAaEGyKLDA13cr9SmK7V2WOG1/a5US7YcTTk/wxKuxWwviHgl+4QEFLqACZYbj7gQLRZ5pYKZPK4fMPWPMU5NH2LNYUlUlC34OK7pz+Qfx3TkUeRNOhuTm4izm6O0f+R7wM4WZgcu+1aXwAt5iJqJ6rrOIDCy543EflHDqYElcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bh53bN5DXCfRWw4RTJBj+ZIJYRqxHlRbTaMi2ZWWi08=;
 b=7D/vzAZCVlXCkBo5joodeMhufrqTJ/XTsrCc6Znf56gAnWcaylfMa0uwNkT+SB6L5OWkD2a2ZUcYHcz0hCV9IChXoB/DsdnLq8D9EG4Hmncfxy5L74v5N5utewu0qSlQjEPY8STWmeXHK/2FJ+DCoIYt7l/+DUZ5RFir5VZ6RQpEaVsVGWj7GM7rnQcGy8cHwI+qvHLjof32Ua9YYbVRgWHjBVNweb3T5koRf0FEDhXbb4685RhUB3zDFsEAsBjDDJyuw/UMOtcdZ4NejjLTAg6sk/Wmec9uirsY7rgRd+hga+hNDv7E8mkQ4lNURiHK/5OvnqSKWhvXYPC/qlHcNg==
Received: from DM6PR11MB4185.namprd11.prod.outlook.com (2603:10b6:5:195::29)
 by SA0PR11MB4718.namprd11.prod.outlook.com (2603:10b6:806:98::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18; Tue, 5 Nov
 2024 12:18:17 +0000
Received: from DM6PR11MB4185.namprd11.prod.outlook.com
 ([fe80::1692:c829:d50b:8c30]) by DM6PR11MB4185.namprd11.prod.outlook.com
 ([fe80::1692:c829:d50b:8c30%5]) with mapi id 15.20.8137.018; Tue, 5 Nov 2024
 12:18:17 +0000
From: <Hari.PrasathGE@microchip.com>
To: <cvam0000@gmail.com>, <richard.genoud@bootlin.com>
CC: <alexandre.belloni@bootlin.com>, <gregkh@linuxfoundation.org>,
	<linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
	<claudiu.beznea@tuxon.dev>, <jirislaby@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] Typo: Fix typo in atmel_serial.c
Thread-Topic: [PATCH] Typo: Fix typo in atmel_serial.c
Thread-Index: AQHbJjxoSJKxQy0ah0ic49B+qkdJ3bKorRwA
Date: Tue, 5 Nov 2024 12:18:17 +0000
Message-ID: <5933bb3c-3b1e-4579-88c6-b9bbbed93a4f@microchip.com>
References: <20241024172300.968015-1-cvam0000@gmail.com>
In-Reply-To: <20241024172300.968015-1-cvam0000@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4185:EE_|SA0PR11MB4718:EE_
x-ms-office365-filtering-correlation-id: 74135a02-61d3-4e2d-7b38-08dcfd93ede3
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4185.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Z3pkQ3B3NmxzT25WMy8wcHpiZ1B1dUp4UVpISlM5ZzRReXRuZzlNVXB1d0Zu?=
 =?utf-8?B?dTB0MWZqU05wMjFNSG1sUHdPT2hoa1F2a1R3c0d5emJkSmkwcWs5STNTVlFT?=
 =?utf-8?B?bTVTWXpMQ0Z2MUdLa1diS3AydDNGbkNhb3BuUXB5WG4wTEdyS1g4TERvZW5G?=
 =?utf-8?B?VGRuYm45L2pBZDIrOFpYakFaVUdLSWROek1mYlJ2UFk5eEJYQXlWaVFjQ25E?=
 =?utf-8?B?TUtWWkdralRFc3dCSjI2TjZOcmpCWE1ReHgxU2tHbFJkMmFRSGJzTU5FN3Ra?=
 =?utf-8?B?c1lTa2w4VU9pUUx6d1Z6RGFNaUw1WkVESXRoYWNDVkhra3VneTdJQ3V0aDQv?=
 =?utf-8?B?VVdieC9IMXR6c2dQTnpUNFRrSnpuVWw2Sk9vcGQ4V3hZOTZBUkJYWkFFRm5E?=
 =?utf-8?B?UW8zWXhLcFZ1SnIyZnU3blRjajI5OG4za1VWMll0VFBiNU0xelF1VkljZjdu?=
 =?utf-8?B?RUVaQzJiMElRUFJuNUVORnBZMHZGMlNJWU5YT1hVdzdpSENZa1VIaXJ6SjlV?=
 =?utf-8?B?Zk5jaEUxK0ZDTVFrUFRBeWtVYTM0cjhVTTNQYjcwREQ1WWg2NnlWV1NDVkEw?=
 =?utf-8?B?eW9ZbVI0N1V3dWVLN3JRMlA5OHhPRGNFRHN6VVBYOE03U2hOczJISHRBWlRy?=
 =?utf-8?B?NEhMZ3VGaFU1c1dPV3VhVFNDRVc0ajZFazRacWFyQzZOcVBSR1ZCYmJZVkl5?=
 =?utf-8?B?WG9DeGovd2tDc25mOE5mVWx2Z3ByVm1kbHZweHpYR0tlR1BjMWNqMUo3Z01z?=
 =?utf-8?B?VEkzeWhnV1lEaDJLbkk4MGozOTQzS0h5ZFJ0aTRlMm5RencrWTA0dEdDWEVz?=
 =?utf-8?B?YXR2V3grbGUrZkNCUFpzYmdieTd5L3FIa0FQM2VsRWVhMnNjd1JyYnFaaEQz?=
 =?utf-8?B?MDZTR1V1bjVPc0RMaG9ySnRrcU8zd2RSNURHU0p0cW9kdk9yUEZyckpkVmN0?=
 =?utf-8?B?RWhLMjBnRXJpRTRzeVgwZVhLVGRPclRTY0hkcVJVL045dmgxV0lZTkFUSjEx?=
 =?utf-8?B?ZUtrdnVEaWV5RU5PcVdyZmJqQVJyOUdJc2hhUmtINDlhTWVZdUlXUU9Hb0cz?=
 =?utf-8?B?NDFTaGxuWURLaC9JRmJSSExjYXFxUGdOWDNLSWVxM2RlZVRrK1JHSVVGMk9W?=
 =?utf-8?B?d3Z3YW9tdUt6b084WDhWYVZsWk4wQVpPUXZuMUIvYWVsSWNMYVdTSWdrTmxa?=
 =?utf-8?B?bEthKzZtMW8wdW9OZmNydXE4cUs4OGdxenFmdXkxRGRKOGc4dzhMZzVtYjhr?=
 =?utf-8?B?aExRZlcvZEZDb3J2UjF2V0JNTFpPajNYaHNGQW5qZmhBRythRmZtRldLQWhN?=
 =?utf-8?B?c05RcU8wNkE1azdJVjFjTjUwNmVDN1RUR0xuMVozS010cFBVL0liK25jQmF0?=
 =?utf-8?B?UkFZbGlFaEFpUFRLWVAzL1JnSnNWcDkzNEJKQnk0NFE4N2I0dzg4QnFKZEZp?=
 =?utf-8?B?cTNXdzQ1YlM5OW8ycmNBckZ2UzVtWEZTMmppK09jcHZRRmpzSVdndmpvMlli?=
 =?utf-8?B?aVJ1d3JyVWJlUUxsRUg4V21xeTU4RytQMkdieUZ6b3pKdWhDUDJPYXdQODVu?=
 =?utf-8?B?b1ZCTlpjS202c0hWTFlud3VybXJFRWhEMW96MENVOWxGSjl1dkxJTWUvcW9Y?=
 =?utf-8?B?bWg4eGp3aE5Zb3ZkZTA1OFEvMEdYM21Sb00zY1B0eGxuQ3ZmNU5RaGNZaHNi?=
 =?utf-8?B?bEEwc2dYUWdXUGxzTndFZm43SVhKcGJBUWNxbUJzMHdicTEvdjhXVHlOSEp5?=
 =?utf-8?B?Wk9zZFNiUGZkZ2tSazYxT3hvZWI0NFdCOVJ1eFF5SlBwZlIvZCs1Yk53ZS9C?=
 =?utf-8?B?TmZBUzhucTRTbnpLOE9hL2RqdWRyWHZNQjNQZ3NjMG92SHRxMlB2RmxBL3Z4?=
 =?utf-8?Q?sMXZlRHLA7Jr7?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?T2N0UjZZcWMwVHp4OHlVSEFRdGZkRWZqTDY2dmtpOU8xT3ora080bGpBTjJ1?=
 =?utf-8?B?V0NMNWo4R0xEaTUyM3JvMHFsL3F1Tkw2dWtOd0duZEtUaGp3enJyVHp2cmJk?=
 =?utf-8?B?STkrRGF2VTF2aFphenY2QTdEVDJLSlpsMWw1OEtncG11aXhoT1dRRGhETjky?=
 =?utf-8?B?SmtkZlo0OWdRTXJBNjd3dEcxK3dEUm1qaktzck9vdkIyOXpOdEtnSDNDRXhx?=
 =?utf-8?B?Rmdkb2MrZnJrLy8xRG0yUjQ2RFE4S0JCSU9sRnZLSWFxL3A3ODdqSjJzak5U?=
 =?utf-8?B?dEdaQzRkNHNjZWh2SURmcndIc3l2UFFva0xJWkh2K1NVdmhOMG5ZcXBHWjFv?=
 =?utf-8?B?K2xBOUYrSVM1ZHBYMDVzcW9LV0NSTUN0TldsYmFVVG5wU09QUjgzc2NYdUdL?=
 =?utf-8?B?TVNxRkhOUkhqY3plWmhqdURlM1VqTTlrV3hvc1VXN1cvVXEya3VEQ0I0RTl4?=
 =?utf-8?B?R2wvejNlRDdWRjhFR2MxTVg4OXlhRGtmTTVydUY5SzhCYmRKY21wWWorRXRk?=
 =?utf-8?B?eFVINDBIZmNjOFl6cllKc0ZYME5pbndoVEtJUExJTVNQaFgvdldjRWIvRFMr?=
 =?utf-8?B?bmp3dmRGVTNCK2dXSzB4R3FySGJuVVIvRW8zSkRsNUxPSkoxMHpIQzJ2eDAx?=
 =?utf-8?B?R0lhK2V2djJvWnpyaGVUYUVsQ0RPZUJqa2R6UktORlo2Y3JpSlFSQll0eEVB?=
 =?utf-8?B?T3IyQ2U1MEM3NFB2VmhIYWtUUlRCWXRQT29DT1hTTk4zWFFOWHhMbDVCZEl0?=
 =?utf-8?B?WWVaMHRpVVJvUDcxSTU0Z2dnSzE0U0d1cnhzbXQzTDJPeWNHZUVqOVNhdzZr?=
 =?utf-8?B?UEt2L3JhWWdqSUdybEtNUTJxK3pFQWpPd05WcnBCZnNqa0ZEOXdIcjlzTTVr?=
 =?utf-8?B?NEYvSm5sNkVKSVFZWHJPUWY1Z0FrUGpwOUtzM0xmSW80b2ZEemJXTElGbWx4?=
 =?utf-8?B?SFF3UnZvMWI0MXpvcVJjUTlWN0NGa1FkdHdUbzR1b28yQkxzb0lqZWJuNS9O?=
 =?utf-8?B?NEhqemN5MFlzanVndlpFejdVRVY0aVhzdXEzZWgvLzM2bkFDSmJycUNYMmpM?=
 =?utf-8?B?K2tYN05VWHJzajRsNk5uWVhwY1hpeVVmaGZveVl5UzlyYi90MnVTOE5YQjhU?=
 =?utf-8?B?S1RGUnprLzZkYkdibHNCUnJ0VXd3b2xKU1NzMWF2T2pnNnplblUzeTU3b3hJ?=
 =?utf-8?B?WWlVUS9iV1Y5LytvRXVaWkswdUFrVkUzSUlEcys1V2RLVnFQUFhPcHozdWFl?=
 =?utf-8?B?Kyt3Y1RkdGVmVFdhaHQvalZqcUlkYVV3MS85K0FuR3puZnNZdm9ycmlvOWc5?=
 =?utf-8?B?TjJIZ3VuRVNkeURHZSt4Q1BkU3JoenZsbnJQUWRWaFZkUDJwUmNLaUkyN0Yr?=
 =?utf-8?B?OVh1NkxyWUNYNmRBUldpaWpnT2pYZFVScEFVT1ZQZEhTWnFkbXJFSWVCNjhD?=
 =?utf-8?B?TXErZ1duR05lTng2c0V6N29IWmpiM1VVWk41QVBLZEpYenZRb0dTaUlsNUZ5?=
 =?utf-8?B?aG5kYytrcTBYODhBZjV1bk5FWnNLV2Zkdkg2NEVPcUZsS0NPV0toM1I0OUZZ?=
 =?utf-8?B?UHhZMHNhdy9NRi9HL2ppSGhsVnlmU2JpclpSRUtnYnhna252NThhb2JZQWkz?=
 =?utf-8?B?cCt3akpESWN4UGpZd3BHbzhMakRWMlM4YUl0YUFJMGt5TjA3RHVpQlhzWmtP?=
 =?utf-8?B?NnZZbXlmTlhsbTBJT3duOTNNZkdBVkZiOVJES1M3azdmZjBoV3hzaFVrbVRO?=
 =?utf-8?B?UHVTaDJYNnY5QWlkcy9xRklKTTJ6ZFRyOEE0R2RvUDNXVXAvWUZQK3hxYzdw?=
 =?utf-8?B?aUgySU9UdXJ0elhyak9Kenk4OEFMSlU1NUFkQmNyYkpJSGVVOFl1U25wSXlH?=
 =?utf-8?B?THN4c0Y3MGE5ZWRpV0FnZGpPcHlJb1RzbW1qdEhocE5YcFFUOGIzcE5NQ2pP?=
 =?utf-8?B?V0NrT3B2R1JxT3B0eUprZlpWaGtZWXRkU3NXRHpDKzlQWGVKbjIzU1M1MXIv?=
 =?utf-8?B?MEd4QmwwbW96WjVpKzAzT0NtTUQ1dTdpcmlVSWhWREw4WjMwUDk5KzJEanpD?=
 =?utf-8?B?RGpxNldQUlFoWnppRVpZdXpOY1MxZTdIZ3IyT1QvM3R0b0VkQktMek53Ujgz?=
 =?utf-8?B?M0paYnNqV2wyK1pVVmNPcDR3Q1NhM3A4S2pVSnhud29WallRdUFZS3ZvSm10?=
 =?utf-8?B?aGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4EAFA847D4F9B74A936716AC61007220@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74135a02-61d3-4e2d-7b38-08dcfd93ede3
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2024 12:18:17.2380
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7V/Cz6GHm4dMoFbShlDIV4eHq3+q8Zq/RaKW4AO0oX9jxWRchn+ce3o3jiM5GMJteg7Yc5aiDs/5emTLWOCM5nUdltt4Do76JOfXc4l2djw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4718

SGksDQoNCk9uIDEwLzI0LzI0IDEwOjUzIFBNLCBTaGl2YW0gQ2hhdWRoYXJ5IHdyb3RlOg0KPiBb
WW91IGRvbid0IG9mdGVuIGdldCBlbWFpbCBmcm9tIGN2YW0wMDAwQGdtYWlsLmNvbS4gTGVhcm4g
d2h5IHRoaXMgaXMgaW1wb3J0YW50IGF0IGh0dHBzOi8vYWthLm1zL0xlYXJuQWJvdXRTZW5kZXJJ
ZGVudGlmaWNhdGlvbiBdDQo+IA0KPiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUN
Cj4gDQo+IENvcnJlY3RlZCBtaW5vciB0eXBvIGluIGF0bWVsX3NlcmlhbC5jDQo+IC0gRml4ZWQg
InJldHJlaXZlcyIgdG8gInJldHJpZXZlcyINCj4gDQoNClBscyBmaXggdGhlIHN1YmplY3QgbGlu
ZS4gUmVmZXIgdG8gdGhlIHByZXZpb3VzIGNvbW1pdHMgZnJvbSB0aGUgZ2l0IGxvZyANCm9mIHRo
ZSBzYW1lIGZpbGUuIEFsc28sdGhlIGNvbW1pdCBtZXNzYWdlIHNob3VsZCBiZSBpbiBpbXBlcmF0
aXZlIG1vb2QuIA0KU2VuZCBhIHYyIHdpdGggdGhlIGFib3ZlIGNvbW1lbnRzIGFkZHJlc3NlZC4g
U29tZSB1c2VmdWwgbGlua3MgYmVsb3c6DQoNCmh0dHBzOi8va2VybmVsbmV3Ymllcy5vcmcvRmly
c3RLZXJuZWxQYXRjaA0KaHR0cHM6Ly9rZXJuZWxuZXdiaWVzLm9yZy9QYXRjaFBoaWxvc29waHkN
Cg0KUmVnYXJkcywNCkhhcmkNCg0KPiBTaWduZWQtb2ZmLWJ5OiBTaGl2YW0gQ2hhdWRoYXJ5IDxj
dmFtMDAwMEBnbWFpbC5jb20+DQo+IC0tLQ0KPiAgIGRyaXZlcnMvdHR5L3NlcmlhbC9hdG1lbF9z
ZXJpYWwuYyB8IDIgKy0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVs
ZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3R0eS9zZXJpYWwvYXRtZWxfc2Vy
aWFsLmMgYi9kcml2ZXJzL3R0eS9zZXJpYWwvYXRtZWxfc2VyaWFsLmMNCj4gaW5kZXggMDliMjQ2
YzllMzg5Li5iYjE5NzhkYjY5MzkgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdHR5L3NlcmlhbC9h
dG1lbF9zZXJpYWwuYw0KPiArKysgYi9kcml2ZXJzL3R0eS9zZXJpYWwvYXRtZWxfc2VyaWFsLmMN
Cj4gQEAgLTExNjYsNyArMTE2Niw3IEBAIHN0YXRpYyB2b2lkIGF0bWVsX3J4X2Zyb21fZG1hKHN0
cnVjdCB1YXJ0X3BvcnQgKnBvcnQpDQo+ICAgICAgICAgICAgICAgICAgcG9ydC0+aWNvdW50LnJ4
ICs9IGNvdW50Ow0KPiAgICAgICAgICB9DQo+IA0KPiAtICAgICAgIC8qIFVTQVJUIHJldHJlaXZl
cyBvd25lcnNoaXAgb2YgUlggRE1BIGJ1ZmZlciAqLw0KPiArICAgICAgIC8qIFVTQVJUIHJldHJp
ZXZlcyBvd25lcnNoaXAgb2YgUlggRE1BIGJ1ZmZlciAqLw0KPiAgICAgICAgICBkbWFfc3luY19z
aW5nbGVfZm9yX2RldmljZShwb3J0LT5kZXYsIGF0bWVsX3BvcnQtPnJ4X3BoeXMsDQo+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEFUTUVMX1NFUklBTF9SWF9TSVpFLCBETUFf
RlJPTV9ERVZJQ0UpOw0KPiANCj4gLS0NCj4gMi4zNC4xDQo+IA0KPiANCg==
