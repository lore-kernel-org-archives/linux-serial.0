Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7972A25A337;
	Fri, 25 Apr 2025 13:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745588392; cv=fail; b=CbjO0y8kAM0oy98wa5bBusV/IsuIgCXE3D2m+j/9gwk4Vx3r+k1Bx3tCnp9FQJWy6DxNZEnKkxsvvLOWtuNWWmCfEUyauJbC2wDU0HS/2Lo5AG1+WuNinOzu8mbAsNqgW0Wq/q7HWgrLGB1zc5KJUGs73CG3oyvplRwUPy7U+Is=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745588392; c=relaxed/simple;
	bh=LbacDLirXXFJfY1K0v1NO9/rrUmuDeUZLpoygng3Dn0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YQlgBBdvDFLJaesZZqBGknAs6MZxodmOGnqnCOAZ2UKrkS8QwnzGTe7FLkT66Cqpv8kKxV6we4qruibfVRC/SfGMsaJgFBD7yTsa9KuhEqhv9LJLL/GUynm2hld4mHRQEhSnYzlMG3iPqRW62hKuz912jJ9zDKD+FfGLKdpTE4g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=1ry+JCsN; arc=fail smtp.client-ip=40.107.244.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="1ry+JCsN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JsMaTSjhaaNrB03iR+Z18auwVtsw9OfmNVT+o/1U/lvFMFtm2YevuOYaEA41QyvAWCJgmyDJnKTRPfyQV1dRNxRrv13ekZAgfKiGUsg5aME2lLhVIQG+lyi5VhtKVTKaIRXBHMvywvu1rW50FNrEkicUK1hKtDfFsWMJuGH4OqABaHGh/Vhe4wcvPcOwyqpcYWqTKn8anPPb+UQmB6eQVZhycprHMhKMtAe287Y+KOmCk3N4xaMLsEhvyxNVc6UGQ5FDDJREFPnnkwu8IO7K/N/KE7VRumA5K/Bey2nf0sFAQf9IDVg2PN/mHWU3+yHRQWlhU4hRHhS2sSrtyD4v3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LbacDLirXXFJfY1K0v1NO9/rrUmuDeUZLpoygng3Dn0=;
 b=WQV+n/2Kaza9UdpVODgMiLs1v4yrbt0lYb8e+JkVe1hdLHSakOOtH6zSIbrCn0H4tQUwLZa/tjkkY1eApEeVvxHfV/A8vWXcXDor4p1+q41e8zJICxEkNixPdJm6oVfySjLrOI5e8gDXtSpUtZ+0OqzPq3Zc7q7q3yqlZZXp8EDAv3qCgphvLFbuBaDf2REGkiet+bSjAu1KSm0dRIqYp4YQGng1ebt9Cp65w1FhRHjSQMZFUaK07lKo4tyzqQOqeFNh59h3Vr4PUgvWRbf8VUl22QVr2CjSN8x3QKE8X3/1u8eBDmNlvDq0TbvhkdfnI+f/825v7LS02VY3w4nC7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LbacDLirXXFJfY1K0v1NO9/rrUmuDeUZLpoygng3Dn0=;
 b=1ry+JCsN9MsseIfuAIGjseXSgK+BxJvpPpPbiI9iyUXnxowK+BElt2oeJ3+epuEnT4mxAX1xyJc0Otu6wU5IMPdMqBGzBouvoAAJvH493HkSPhNbGTqZEQ2dcBG1SWXHxVI7/phYF9DYoXSCp0vkX6EHTpSG0ccZdw3qGFKxdhjd5+AJnBlSo74ax3QFG7rypuZqR4PPA2SIIEx+3Qp/fwM+yV2li1Dz8IIID6OFEuKyL9irhCSR7IUyFQkWAtPrW8G5aBSN3mYbFWin8tq3SzCSngLkEFVEq2lfyaiZDjNPgybNVT7CXxKSmkAbkGqqlNJ2rbHtxUOU+3MxiiWuig==
Received: from DS0PR11MB7481.namprd11.prod.outlook.com (2603:10b6:8:14b::16)
 by BY1PR11MB8032.namprd11.prod.outlook.com (2603:10b6:a03:524::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.26; Fri, 25 Apr
 2025 13:39:46 +0000
Received: from DS0PR11MB7481.namprd11.prod.outlook.com
 ([fe80::3a8a:2d38:64c0:cc4f]) by DS0PR11MB7481.namprd11.prod.outlook.com
 ([fe80::3a8a:2d38:64c0:cc4f%4]) with mapi id 15.20.8678.025; Fri, 25 Apr 2025
 13:39:46 +0000
From: <Rengarajan.S@microchip.com>
To: <gregkh@linuxfoundation.org>
CC: <jirislaby@kernel.org>, <linux-serial@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>, <Kumaravel.Thiagarajan@microchip.com>,
	<linux-kernel@vger.kernel.org>, <Tharunkumar.Pasumarthi@microchip.com>
Subject: Re: [PATCH v2 tty-next] 8250: microchip: pci1xxxx: Add PCIe Hot reset
 disable support for Rev C0 and later devices
Thread-Topic: [PATCH v2 tty-next] 8250: microchip: pci1xxxx: Add PCIe Hot
 reset disable support for Rev C0 and later devices
Thread-Index: AQHbtM3HiwuhEPp+XkeGI2hhiE1QsLO0RVwAgAAfMQA=
Date: Fri, 25 Apr 2025 13:39:46 +0000
Message-ID: <fe7b07d35ded71e71ab892909284727a57604bdb.camel@microchip.com>
References: <20250424035913.7673-1-rengarajan.s@microchip.com>
	 <2025042553-skinless-magazine-6cb9@gregkh>
In-Reply-To: <2025042553-skinless-magazine-6cb9@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7481:EE_|BY1PR11MB8032:EE_
x-ms-office365-filtering-correlation-id: 500e4c81-5654-4dd1-a37d-08dd83fea47c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VU90OXdSdjBGRCt4WlhoOVZaUU9ybEdQWTAzMmtjYzJ1NUJWa2NzV25XQXRu?=
 =?utf-8?B?Q0E4NkpqRkpseC9tQ0J2UkRjYWxtMEhJcWRic2Fia1k5K2E5ZU5LT0ppTjFV?=
 =?utf-8?B?bGNleWRtWEJQQ0R6N2xRb0NoaGNCNnRtN2VoelV2T3ZMUlE1eXh2VWIvTTd4?=
 =?utf-8?B?cDlzSW5zcjZjZG5LK29vYkcxM0dEUDlsdVNjSFE2YUcvRkVJVG1Sb09xQzJk?=
 =?utf-8?B?c2VvSTNHbUNWVStNdEtrNGViaGwyYUVEd21IR0UxMEJIbGh4ZG40SHNSTlNQ?=
 =?utf-8?B?dmUwdWdvWVgrYlZselpSR2gzdWRHSTl1a2Zua3AycVBJVFAySWozQmV1U0N1?=
 =?utf-8?B?YmNTNy9qMGx2TTM1c1lQSkhYWDdWNmladm15UzR6ZUZ4blVQQnVoYjZuVVR1?=
 =?utf-8?B?am5SZjVZaC9ZYk1UMTE5UkdNZW9WYUtyektpdTV5S3V1MEdRZitCUW9zeVlz?=
 =?utf-8?B?Tm82TTlaUGZ6N3Qvc0JQVVNJYlFzaW9Oa2RrSittSUZSSkRuNng3a3VCTDky?=
 =?utf-8?B?RUdzNmJUMUZrL3d3Z0MyVmRlVUlMbENnMjJFL3Uzd256YjdVR1lKd2w5bnVB?=
 =?utf-8?B?SHhGNU1zazJGUDk2T2lKdW0yRFI4RGVmTmlQSnVVU0N3T2tiRVYxSERhK3k4?=
 =?utf-8?B?RW5PeTF2M0hLWjVObFptZlphbzQ1dUwwNG81RTdQQWVpZUpHOEFkVWlsczh4?=
 =?utf-8?B?VE5HVWZvMW0wMHlCNUFEK2ZmY1VNRUljcmYwVFNMT1dsVlVqM1d0RytBZFFr?=
 =?utf-8?B?UjIzNjdZejNTN0NHSnZXaE1XcVdFUkNTZUhUdGlUcSs4VEdmWlNSZnVucjZq?=
 =?utf-8?B?Y2U1Nmh0eGZSU2RXZVdaamNTVzM1bjFTTUJ6bUhFSkFlblNVcVNJWXVwTDdp?=
 =?utf-8?B?eFlYYjJndlBWaFVaRkNYL3RmcitKMTIrYWlwSnJGUDBJYnhYQi9iZ3FkUzU3?=
 =?utf-8?B?czZySVlZMXJoZDVzbkZmK3RRaE5vc0h4NHJKWmhiWS9QMjl2ZWlaSlV2cWt6?=
 =?utf-8?B?VzlxT1VWNlV2VDl0NTM0TE5nWWxrWWh4ZUF5MVJCM3JGdEttRTk3ejNJaDFz?=
 =?utf-8?B?QzZHUlVObms3YmhZOTRBSzdNKzgrb0ZVeVlaVzN6WVR2LzBQUTN4VzRYVUtk?=
 =?utf-8?B?L0lQcDZ1cG5sdkM3WVM5NjZvMGZmT2dYcHpxKzhxU1krcEFDdjlvZkRlN29E?=
 =?utf-8?B?SVlCODZGVFduby91NVVQZjEybFJSNVlCcWprRW00SEo3b2htMDVUT243NnZ3?=
 =?utf-8?B?MGFWd2hGSzEyQm5Ubnc4U0NRUitsamlRRVdIaC84aHNDNEdBZnAzMEg2bkJ4?=
 =?utf-8?B?Vit6aG9sT2hYU0E4bENVS1B3OXNCMXJobDZWR3FaSFp0QWdFaDVoc3hSWjh3?=
 =?utf-8?B?UklyclYzUUx5cTR1dG1vdEZlMk50UzVzaEF4TCtyYUF5bHVZeksvV216M2VL?=
 =?utf-8?B?OVlONDlyU2Y4SGJnTDhEeVE4OHpKZWxPRkgzSXUrM3J5eU1xSzZWZ1U1N1J5?=
 =?utf-8?B?U1hYQkVyNTdPaGJnekVyOHh6S1BIc2NjZll4SWNqVU8zZk5QTk5lZFdXQzE1?=
 =?utf-8?B?Q09jR3FRL1M1WEJHYi85b3E1a2s3MStLekdOd2hhR3ZEdGdpcUtkMmpoQTMz?=
 =?utf-8?B?aC9nc0l3c1pnREMrdlRWb1Z5MklrQnRwSHpQa2s3eExWRmswTTNyM3dwNmt1?=
 =?utf-8?B?MmdRNFNjY3Z4cXArRHdLZ3E2RzgzQzR4NGN3cFAwSDVHbGJVVE1NakRGY1Rs?=
 =?utf-8?B?YWJCYVpVbjZPTGpaZVF5bEtieUxCWjVYN3NqVTErWThtZm5EODJhNEk1Y0NG?=
 =?utf-8?B?SEdkaEg4T1huRTVWVC9zWUpGbDRURDR2bWljYzhyaE9wWW9zR01TenZ0eGR4?=
 =?utf-8?B?cUFLTkk0cGs1ZVR4dmRGME9qU3B1OFJNZndQbnkyazBYZUVleXZsUm1MWTZS?=
 =?utf-8?B?eldNYTdTVjNnZnJDa0xtbUZIMTlBdkZBeUpaeDdRZldpbzVqaWhkYjduKzlC?=
 =?utf-8?Q?Sg+XzoJd44woNPvOoY2ABS/90av86A=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7481.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TkZ3VkZBcGtQaXBXUlFNazgwVUdtcG1Oa2FRV3pDVncyZDZOd2FnTm15SHQr?=
 =?utf-8?B?YnJSMnFnaTB5OW5zdWVKTEwzbXdsdHpleW1acUpKYzFsVmdOai96OThWZnFt?=
 =?utf-8?B?Z1p1dkpMQU16NHk0d3hFMmhNMXdGTW1SbXVNTEpMS1VyY2U3bXlqZDdsWStr?=
 =?utf-8?B?YUtrOTJ3Y05SZ0hRVzJWL04rVjJuek0rd1VZS00wR0FiZGE5MHM1Yzl1ZFcx?=
 =?utf-8?B?VStyT0QzRUI5eWRIQ0R6SExxa0hQVHhRYS9kcC9qOUNsaFY2SEw2NnM1TFBR?=
 =?utf-8?B?RXYrbG1ISGNhc0kyT1RQN0lHeER1eXBKVjEycndPUlczc3hKd29KQjRsaWdr?=
 =?utf-8?B?RWUzOUZwY21ENmszdWxnTVo1S1RQM09rM2hCazNWc1IyNTN3K2VJVTQwYTdx?=
 =?utf-8?B?NnFjczd5OFVXYjRzVFIvQmRSM2c0SE0wWlhPbHR6UUxYVHlocllsM1IwT0s5?=
 =?utf-8?B?Y0pxSVhHcUlpRFovZTl2Ny9HOVczaFZpTFJibUxZN3Q2dGk4SnJIUU9NeHk3?=
 =?utf-8?B?V28vOFVKdEZuS2ZRRXI3TGlyVWsxYU4xam1sQXJkNEtJMFpPY3QrcGdJa0h6?=
 =?utf-8?B?Q0RTRnFBVUxhTmpDbFd4L2ZxYzBpbDNFelp0MFZ5QzdGV2VMZVQzd2dBMkVI?=
 =?utf-8?B?NzhiWjFJcmk1RndiWW14NHMveS9kVmN1M1JvMk00UkZaRW52MW5rbVBlR0pu?=
 =?utf-8?B?ZjdLbUNaYktKdnVqejFmeEcyN0xVZFF1TkZSVklNUFZOdFljU3dVM1RiRlZx?=
 =?utf-8?B?UzJHMDBNQWZVcm5iVG80RTd0SzQ0R1F4U1k2MWR6TzhnWjNEajM5ZFY0cnlq?=
 =?utf-8?B?TWNEb1E3ZGVyVGpydmUzU1F1RWpZOWpwRy9rMnBDeHNLeVRacXRZaHM4WDU0?=
 =?utf-8?B?R3V4c0lhcVphR1BQRzkxVEhMWHR2UUxYMk56OVNlMkJhenh5aE53YWZTdTRG?=
 =?utf-8?B?Qy96cDNBRElNV2d6Y2lqTzhSelhYRUwza1NpdkpuRldDbnFhWEd1ZlZXc3Bi?=
 =?utf-8?B?aVhxYW5Gc3hPMEIrazhNbjBoQ0JTTDRXeHI0MGRFbFFqd1g0bXJJa08waW1F?=
 =?utf-8?B?L2ZWQ3lZb0k5ZzJEbnJVN1dGanRybzFNNlY4TUxLU2JZcHZjU0JGYTZiYith?=
 =?utf-8?B?bUdJcUVEVUtzdno1RnRIdlVEZkVIYXkrU05oNGFPYWJIck1MOGtnRVVRZ05D?=
 =?utf-8?B?ajFDbGo0RExLcmRNT29MdUF2UXNDRTR1L2JoRkU1Yk4vSTc0cXRmL2JlOWZu?=
 =?utf-8?B?Y1J4cURZZWpDMDdUYmhFN3B4alNJOGQwenhJMm83eW8vU0Zxam1ZdnhhRFQ1?=
 =?utf-8?B?ampUb1NwS1pnajVtbzRzNGtua0ZVMTk4bUZqNkVvSllHUFBZUnN3aFc5R1hk?=
 =?utf-8?B?SEdodWlXMXFSQlEvc2J6OWtIM0NLcm5tcHlScjJiVERHdDdFVDQ1RmFEc0JD?=
 =?utf-8?B?SW0xaEF2TkhBRG5peXV4Ylc1Q0RBTjFtQ2NFRG54WlJYWCszZ1U2dVZ0U2FM?=
 =?utf-8?B?YVVTNXFHWEhLdFZZdnBaNUx1OGdaNlJrYWJEY2llOGxGZ3Q2emFFV2l2SDVn?=
 =?utf-8?B?UTRKSHcxc0M1RUQ0MWZOUkVKRm55RkNQcnVkc2VvZFRaZjJITVdYcUZvWTlH?=
 =?utf-8?B?RHdWRFYvMlJYRy9idEJNUEtRcEQ4cE9XcndOVjBPMGxLTWpQZlRKZzhaR0I5?=
 =?utf-8?B?VDV3WHgzZDRKTGJHUHVjeU1WSUEzN3JrMnowU0JQNGZoZlNkSDZvTEtHcUFu?=
 =?utf-8?B?MldlT0NhRzVvM2g5Z3R4cEluY2w5OUFHbXlpNTZjckJ0RHUvd0JjUFYxRDR5?=
 =?utf-8?B?UVNqUERMa09sc2c0MENORm1HMldoaFdNQXh4ZzdTVWVGM3dpMm9yZndqWnlk?=
 =?utf-8?B?STdvQUJWWW5JOTdHTUora1dENU9POEJnNlZsUkhzc0tiaHlMVy9zSEhvaVB0?=
 =?utf-8?B?M1hpY2kwQ2NmVmxsbVZwWXJPaUptM21McmxrbHU0T2p3UGdSYzhhQmdCaktu?=
 =?utf-8?B?NnJqa05EeXlWVjdjb0theS81akJDbk9va1Rrc2x2Y1JuVDZoYkRRdzNwWW1X?=
 =?utf-8?B?c3JobHRBa2RYQVc4TTVBblhZcVNnZFQzWXpBUDFRR3Z2eVhEZitEdW53dmEy?=
 =?utf-8?B?MHo2WlM4OE9uRUZ5SmdzeXpsSUt6RkFGeUxPQ3JPTmp6bkRQSWdNVU8yeUUr?=
 =?utf-8?B?VGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9C6CD1250F91B140B58995C155A6C86C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7481.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 500e4c81-5654-4dd1-a37d-08dd83fea47c
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2025 13:39:46.0805
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DqRk2ct3YBLL3wXrCQVhKjZrfE8zV9nYgJwaZt8R0S763rNAiiqcyeZjyhCXUc04ynMUZsx56U6OS8iwF3zvqHRICBLKEiiZpGYzRx+WrGU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8032

SGkgR3JlZywNCg0KVGhhbmtzIGZvciByZXZpZXdpbmcgdGhlIHBhdGNoLg0KDQpPbiBGcmksIDIw
MjUtMDQtMjUgYXQgMTM6NDUgKzAyMDAsIEdyZWcgS0ggd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlM
OiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91DQo+IGtu
b3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gT24gVGh1LCBBcHIgMjQsIDIwMjUgYXQgMDk6
Mjk6MTNBTSArMDUzMCwgUmVuZ2FyYWphbiBTIHdyb3RlOg0KPiA+IFN5c3RlbXMgdGhhdCBpc3N1
ZSBQQ0llIGhvdCByZXNldCByZXF1ZXN0cyBkdXJpbmcgYSBzdXNwZW5kL3Jlc3VtZQ0KPiA+IGN5
Y2xlIGNhdXNlIFBDSTFYWFhYIGRldmljZSByZXZpc2lvbnMgcHJpb3IgdG8gQzAgdG8gZ2V0IGl0
cyBVQVJUDQo+ID4gY29uZmlndXJhdGlvbiByZWdpc3RlcnMgcmVzZXQgdG8gaGFyZHdhcmUgZGVm
YXVsdCB2YWx1ZXMuIFRoaXMNCj4gPiByZXN1bHRzDQo+ID4gaW4gZGV2aWNlIGluYWNjZXNzaWJp
bGl0eSBhbmQgZGF0YSB0cmFuc2ZlciBmYWlsdXJlcy4gU3RhcnRpbmcgd2l0aA0KPiA+IFJldmlz
aW9uIEMwLCBzdXBwb3J0IHdhcyBhZGRlZCBpbiB0aGUgZGV2aWNlIGhhcmR3YXJlICh2aWEgdGhl
IEhvdA0KPiA+IFJlc2V0IERpc2FibGUgQml0KSB0byBhbGxvdyByZXNldHRpbmcgb25seSB0aGUg
UENJZSBpbnRlcmZhY2UgYW5kDQo+ID4gaXRzDQo+ID4gYXNzb2NpYXRlZCBsb2dpYywgYnV0IHBy
ZXNlcnZpbmcgdGhlIFVBUlQgY29uZmlndXJhdGlvbiBkdXJpbmcgYQ0KPiA+IGhvdA0KPiA+IHJl
c2V0LiBUaGlzIHBhdGNoIGVuYWJsZXMgdGhlIGhvdCByZXNldCBkaXNhYmxlIGZlYXR1cmUgZHVy
aW5nDQo+ID4gc3VzcGVuZC8NCj4gPiByZXN1bWUgZm9yIEMwIGFuZCBsYXRlciByZXZpc2lvbnMg
b2YgdGhlIGRldmljZS4NCj4gPiANCj4gPiB2Mg0KPiA+IFJldGFpbmVkIHRoZSBvcmlnaW5hbCB3
cml0ZWwgYW5kIHNpbXBsaWZpZWQgdGhlIGhvdCByZXNldCBjb25kaXRpb24NCj4gPiB2MQ0KPiA+
IEluaXRpYWwgQ29tbWl0Lg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IFJlbmdhcmFqYW4gUyA8
cmVuZ2FyYWphbi5zQG1pY3JvY2hpcC5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvdHR5L3Nl
cmlhbC84MjUwLzgyNTBfcGNpMXh4eHguYyB8IDEwICsrKysrKysrKysNCj4gPiAgMSBmaWxlIGNo
YW5nZWQsIDEwIGluc2VydGlvbnMoKykNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy90
dHkvc2VyaWFsLzgyNTAvODI1MF9wY2kxeHh4eC5jDQo+ID4gYi9kcml2ZXJzL3R0eS9zZXJpYWwv
ODI1MC84MjUwX3BjaTF4eHh4LmMNCj4gPiBpbmRleCBlOWM1MWQ0ZTQ0N2QuLjYxODQ5MzEyMzkz
YiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3R0eS9zZXJpYWwvODI1MC84MjUwX3BjaTF4eHh4
LmMNCj4gPiArKysgYi9kcml2ZXJzL3R0eS9zZXJpYWwvODI1MC84MjUwX3BjaTF4eHh4LmMNCj4g
PiBAQCAtMTE1LDYgKzExNSw3IEBADQo+ID4gDQo+ID4gICNkZWZpbmUgVUFSVF9SRVNFVF9SRUcg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgMHg5NA0KPiA+ICAjZGVmaW5lIFVBUlRfUkVT
RVRfRDNfUkVTRVRfRElTQUJMRSAgICAgICAgICBCSVQoMTYpDQo+ID4gKyNkZWZpbmUgVUFSVF9S
RVNFVF9IT1RfUkVTRVRfRElTQUJMRSAgICAgICAgICAgIEJJVCgxNykNCj4gDQo+IFlvdSBmb3Jn
b3QgdG8gdXNlIHRhYnMgaGVyZSA6KA0KDQpBcG9sb2dpZXMsIHdpbGwgdXBkYXRlIGluIHRoZSBu
ZXh0IHJldmlzaW9uLg0KDQo+IA0K
