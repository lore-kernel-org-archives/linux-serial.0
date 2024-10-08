Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FCC17E8EA;
	Tue,  8 Oct 2024 09:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728378335; cv=fail; b=r5qggokWlptA93TTuBkB+hNTQr7/eYlqG4fwb6Ax36zvbTaD7fWAUwI3RkErpktv7MhWonTDvFOBGaQpKz43GmJcst+u5Kyr+EHPXJQaMMN0qB/PHdJx/Vc4j5UVKqVt7j1awTvFHXwkD9xVXRQc8hFJ4T5YIAglmGbSied9QvM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728378335; c=relaxed/simple;
	bh=xv9tq406tcjTEP9mVM0UsRVX21sSGhZFRnzpUYgZa3o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SLN/clanZQq03SD9rsOoIUt443b1KDBmJtVW0/4akViU0wRtUkhSA2WbxYDKLGF0V5365mMbtI0NBLutAS/s92mAGWXde7yxeL7IZxE6njsk3bsZafBOy6s3ZPYvJDa9anDAZ/lx9KVrUMD3lBlG5I9ROP4diFu0eB7b/WAyBhk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=0oJy1KNE; arc=fail smtp.client-ip=40.107.223.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="0oJy1KNE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mEGuv1boDFBPjfGrtEAaEtjGksG+nUTmlPxx2FJ8Ip7WPGAKWXG9HTFgW+7ncrRixZOOV3VUUp/tuqGXzilEaoVMMFqFbv981isSjJtBLZlpFDkDUEWhzC/65E4fcLaf1LXrx7AZLc+yl8xtNT/8q21r1wYY9j1WYdVIcQsTDPzh5cw++F5MIsAqoPuxb9sKxqhyT3PAmV1OmUxMWmPN0nX+SnVac849qFrkz5kjO60U0yfP5cL3IS5mkdoSY40WxY53Rwp46JNfAtjLkKHndXxsy888D6vOSCNIFucHhs3BmH3kNi9bbEDoSk2oXogwNyXeuQcz4syQi1AR2J+MLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xv9tq406tcjTEP9mVM0UsRVX21sSGhZFRnzpUYgZa3o=;
 b=c9rRjtX7U+/309DacJlHyPK2jMKDiJG/PkpylB2Pfs56xyTZnhz+znlqgZ6c5wzlHz5+3LlH0sFBHGt6ebAYEQ4eoiBtbS7igEE9WddeZ+w+eMhQXKWXKzazrFSIKRzjzADITt8XolEdjYN0m+XdteavmEchOWq1fcILIe6Sz84zwmyvoun9TaiUX4KHijdksoRNOCgHzR6sY4+otm28aFAznIzC/CugOB7r55cjvC8R7WG+TEsoq8Qnd1vrfUzNaGWWraayShTpKg07RUbhzVaWYHCcvK9XnDiQp6LYg3ibwRmk19W3O2L3hsav89GzmFE7NYVk9f/Lj3pMYrBBOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xv9tq406tcjTEP9mVM0UsRVX21sSGhZFRnzpUYgZa3o=;
 b=0oJy1KNEul8JG91/7IiMcQahVm/slsF6J9fGgeSrAvPNPu9T6Duwad9bYyhS9pCFfiaM27155b00wL2MbBuhOq2UB3N3O9FTPRTJ5SlUDiPtbanXIUEj7mF2oyQ9V3UmkvBvDdg2My4hqemWrPz8kA1kkB6Dc/v6+OYj1aFxSpdMzRUqjOI6gypeu0XIWNPS7SuRhckSHLDTOPEsPc3ACGE9kZgFEuf4D631lPeerGSjN7Koky08u+nrz5QICnvD6zeB6zrbXdVGmQQvlxqqvwneu/gFQqQOO43cerOdh4k3scgmCMdq7TeyY8wRvxT+wFgiPNFv/hcz/eiDqA9pug==
Received: from PH8PR11MB6804.namprd11.prod.outlook.com (2603:10b6:510:1bc::6)
 by DM4PR11MB6285.namprd11.prod.outlook.com (2603:10b6:8:a8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Tue, 8 Oct
 2024 09:05:25 +0000
Received: from PH8PR11MB6804.namprd11.prod.outlook.com
 ([fe80::6f39:a4f:9001:ea75]) by PH8PR11MB6804.namprd11.prod.outlook.com
 ([fe80::6f39:a4f:9001:ea75%5]) with mapi id 15.20.8026.019; Tue, 8 Oct 2024
 09:05:25 +0000
From: <Mihai.Sain@microchip.com>
To: <gregkh@linuxfoundation.org>
CC: <richard.genoud@bootlin.com>, <jirislaby@kernel.org>,
	<Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <linux-kernel@vger.kernel.org>,
	<linux-serial@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH 1/2] tty: atmel_serial: print the controller version
Thread-Topic: [PATCH 1/2] tty: atmel_serial: print the controller version
Thread-Index: AQHbGV0Sw8+hLIY4SUaHEGKRHUG6XrJ8iAYAgAAGxkA=
Date: Tue, 8 Oct 2024 09:05:24 +0000
Message-ID:
 <PH8PR11MB6804E661B89912C18703AC6A827E2@PH8PR11MB6804.namprd11.prod.outlook.com>
References: <20241008083459.51249-1-mihai.sain@microchip.com>
 <2024100842-luncheon-severity-afc0@gregkh>
In-Reply-To: <2024100842-luncheon-severity-afc0@gregkh>
Accept-Language: en-GB, en-US, ro-RO
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB6804:EE_|DM4PR11MB6285:EE_
x-ms-office365-filtering-correlation-id: 656d7343-28dd-45f4-9084-08dce77858ac
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6804.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?elFiRnVWMmFNMHd0RDhHeEM3NmNLcERUMk5zQlJEZThkVjIxdVhYenVyU1lK?=
 =?utf-8?B?K2ZZd0k0MVVaQjJlQkxOVk1OTlRqa3pqbldTSEZXZXcrRGlUN0ZVRElEQXMy?=
 =?utf-8?B?ZXR6Nzd3aEFaaldNLzgrN3EvWk9PNjBlNmNwa1ROZHI4S1BxcmNsRkdIMWhL?=
 =?utf-8?B?dWtweGo5V21nNmZRT1J2K1JHRElhbkRIUE5UbmtQNXFsN3FNWi82YkRFR1Fa?=
 =?utf-8?B?RkVHaXd1UTVaU0EyZWpJVjdPNjh2QllrL3JCTXlnNVlacGwzZXJ6T3RmR01N?=
 =?utf-8?B?V3RFT2JzYkZEd0JaMWtKZ0dUWklxdzN5NExRdkQrYmRwZGNIRjljZURYeE53?=
 =?utf-8?B?amNGWFQyQVRZdDdBRkJxaW9WWlUwTk9wc1U1VFQ5VGxpNE1pRTRId0tXRFdN?=
 =?utf-8?B?L0tRY2dOd2d4eDNvdHJ2VStpQ2FjMWZGL0F0TmNVWldBVjlpUjJyV1Y4L29w?=
 =?utf-8?B?eHhTZ21NV1FaUkVOL2VQTlVMa0lPck9PRkZWbmk5S2E2azlYWi9VU3UwR2pt?=
 =?utf-8?B?QjNiZHVjekZVK3p5L2tMd2d5eHcwczNZWnpSWUNxVjZwMTJSTHNPSklWVUdB?=
 =?utf-8?B?blBoTlVkUGcvNnovK29UcElacHNORDF4ZGhnaktBb3FoRHl3TDY0NFNKb3ZS?=
 =?utf-8?B?bTJhakVQS000d2g3K3N4d0lISEViK1RUZEZHa2FiSHdDdDJBaWMzVGdvU09m?=
 =?utf-8?B?SFNCKzNxNGFBVDRob013ODdCQUZBK2VCZXJuM3MzeHNLNXR5Y1Jkck9EWU9V?=
 =?utf-8?B?dTNieVVYUm1zYzVMYytIazJyT1J2blVxckNlZjFFNUpSYURXaFZSTjVFTEcy?=
 =?utf-8?B?MENZVkdtY1M3Um1hLzRuSXNpUW9yeW9VbVBhbUkveVc3bUFIZjdhbDVnS3lH?=
 =?utf-8?B?MUxhY3p1K1RwWVA1M3BPRjZrZU9aS3RWYncvYnlJanBOYi9xeHQ2WEoxdWxq?=
 =?utf-8?B?dndKMldzZkZCZE1EWlJzLzFIT3hVQ1FZeXlQYUd0RTdKcWZKWGdjZFpZZUlh?=
 =?utf-8?B?a2RXMjlMcVBZMzJrT2xTb05ZbmpSQ1l4M0hDUVQ5TWtBSkVFVVd4MzJheTJx?=
 =?utf-8?B?ck1MUnl1Rm1hTzdKNEY1dnFpdERBQllGK0xIREFuTll0NGxhU21lY0kzVEp6?=
 =?utf-8?B?SGZDOHdQWTk2RGZlRHJaUXVCRW9pUmRoeVpjL3VkYWQwNVFLTDdheEZsZm55?=
 =?utf-8?B?akdXWXNhZXR0dW9tejBHai8wb1NhOUk3SWhrZm8xaitheW1mZXAzK0pvK2FF?=
 =?utf-8?B?K0UyZ09ZT3FlWW5TRkx6dTdDYTFRM0czemhJeWZiRzg4MjVLUjA4MEY5Q2py?=
 =?utf-8?B?UVc4Q296RjZqcU9BeE9ieGtCM3hYYjZhNDEyVEpuVUI5b0EwaTFZODhMQk83?=
 =?utf-8?B?dHhxK1JqV2h3ck1ZdzFBSEJKN3VUVDU1UXhKNHpZOE05NXhQTEJuZWRSa2Jz?=
 =?utf-8?B?MmNVaHVPQmR1NTZlWjdRVVo0cXJ5VytySjBzVlVSZDVvcEh5M09QUWhTZTVW?=
 =?utf-8?B?NXBIYTN6ZUUvbEFBUklLZ3VqWFFmRjA3eThwM2tZbkZVcHhFMUh3T3Q1OGI1?=
 =?utf-8?B?RjJteUxEUzVhUW8zTS9NM1lqYzNMZjVFVnpsK0lGOVJzc0xNb0tRemJucjRl?=
 =?utf-8?B?TG5XUDFIRkU3Nk8vMDFwSGg2K0dTdjJQT2JwQ1dlZFVGSEp1ZzJBOGtkQjRD?=
 =?utf-8?B?cWlDUjNCcCtjVGR4VVVvTkROSnVFQnh4SUpqM1gzUGxQdkM4OWtQb0hRTlRR?=
 =?utf-8?B?QUZVbmZBdUVNUXhSaUhiZEdPNmFwQ2QrSmJBbHp1ODEzenNoZXlTWXlvMmVu?=
 =?utf-8?B?eEhhMU5ndWpoMEhVaXVaZz09?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VkQ0UzQxc1RiQVF2ZlNMRS9ibTFtU3ZLZzkvTTlKbUlybnhMYXVCb0s2RFJr?=
 =?utf-8?B?aUJhdHJ6Um5CQ0dqU0RKSXFLRFhmZTJQT1AyMWFUbkNVVXBxNHRzcHZlY1F3?=
 =?utf-8?B?N2NSUW9ieXV2eExpdGVqS2lwT3d1NnFOcG9TcW42NnY1ZWE3TktqeUZ3M2lv?=
 =?utf-8?B?clBXKzVnUzNJTFVhR05sdGpxSUdyN2hsR05GMzJKNUFPQ1ZqOElEM2dZSksr?=
 =?utf-8?B?dzBvbFBZV09qZFRvbXQySyt6Y0ppZCtDa3FKaXFGOFhoUjhxT0lNZUpzQm02?=
 =?utf-8?B?T3p0N2haY3hUa0ZoZUJYTXNzR2xmU3RNUEdMTWxGRW9aNmM2b1luSERtNHNm?=
 =?utf-8?B?UFhJck9tckxHMW1xYmxpMTZWRHVoQU45cGNMUmQzRWltQ2JuY21NeHlnL1JQ?=
 =?utf-8?B?UG5SRGlwdEZQNTBHM1dlZ1cyWnhQUXNSSU9nUVlrODFCSm5yTHN2RGFKVCtm?=
 =?utf-8?B?WmhNUThVVkF3bUdadm9wcmhKMTB4V3E4TVUwaFZSQWczQ2NYd2NvSnV5aTcr?=
 =?utf-8?B?UmoySG9DVHVDb0ZjOEwwRHI1UVBoZE1tcWkxeE5PRFdjT2VGRVQydWVGc1ho?=
 =?utf-8?B?WFAweXZVa0psbnlUS1JZMTdCTXE5eHNEeTIrMzhpaG0vV2ttbHk4Y3FyQWtZ?=
 =?utf-8?B?V2pjQU8zcm9COUc5a2tTVUd5Wm54bEg5ZjJrQzE4bHBpdFM5UklpUDV2Rklq?=
 =?utf-8?B?YzYvaGVITnlTbHBWV29IZ2JWbWtQaEUweWZBVW9qckFJaHVOYkVZSlk5eWxZ?=
 =?utf-8?B?ekRaN21mM1MvQ0x0SU95cDBtci9tVE5OQ0dtWm0ramRaV0hCTG03OGZKYjlK?=
 =?utf-8?B?RUxBbWl6M1BIQ1F3WUt6dGJzeCtLOXZEbkJZMUN0Z3lLV09ycFhlblZPVWVm?=
 =?utf-8?B?NFR6QkZVMXd0WU9FRGFldWt4U1ZEWXN1Z0dPRU02MlhKRk9SZGMvMlY5Sk93?=
 =?utf-8?B?SVgyaE1CdWRqZ0piWEhVdzJhUjVxZ0NBTkMvczQzMTZmSVp1R0txMExsQXJi?=
 =?utf-8?B?bmZaWmthU2tzbmFNeENZdXE5ZTJJM2M0T1djU1BPd2t3dnRiL045ekJWMjJh?=
 =?utf-8?B?VmhQbXdsY1hJQWNBdFJBcTdFUmVVdmwyRUlDY252Z3pEZGptY092R3ZvcFR6?=
 =?utf-8?B?ZU42WnplQm5RNmRuLzZuOGRhUzRXakp2cXhvcjFVWWM2WlJaKzZtbEFkRXdG?=
 =?utf-8?B?d0hMV0t4aUk5Y1hQcEhmSUZrZWxZRFV1Z2QvTVROT0RpZGU2UlJzaFlrV05E?=
 =?utf-8?B?REpCOFRzaFBDd3RFN0cxLzE4OGR1aFNsVTM0MnBHYjhkMHdNbnVrR1BzS25i?=
 =?utf-8?B?TnRSRElNbi9tUlk4R3ppMUpQQjE4amhuNXZKc0lEdVRIR0w5QlNlV0V4YlNk?=
 =?utf-8?B?YlcxR2tzT3YwY2gzVHBQK1pNK0hha2xpVGxYdHdSMkZxUEtOU3NKaFBDV3NV?=
 =?utf-8?B?S3RVdEx6MHlSYXV2K3grOFIwTEE3RWRvMFVvMjBsaEh6bkFmcVk3ak1QQloz?=
 =?utf-8?B?Y0E4UVlzYVNqUmJtZTFOT0plK1V6cm11a1hBVEE3dFlOeXBjVCtCTU5sV1hl?=
 =?utf-8?B?MkVOVGQ3UmZTclZzeW9yT1BXeU43RzV4NDc3bm13RktyUGk4aW84TlJDdisw?=
 =?utf-8?B?cDhTbmlWeWp6VmxlN2NWN2hoUGRtWTFaMmQwVWt4QTJ3RzFycGpZTlNhaTUv?=
 =?utf-8?B?N3FyQm5zK0ZVSWdSUmlNckkrNDFuYzc4VkhGM2twSnVwWVNoa0d3QW9haHNj?=
 =?utf-8?B?Y1F2b1l6dnlXM0UzRHA5YmNNN1grb0llWm5KZWJ0YzYyUWtBZjV5N0M0ZFFK?=
 =?utf-8?B?azB5ZGVlRE4wY1pMYXZzdUl1bHcyZlJNb1pnUmFOYktaYXJDV3lOYzlSd0g5?=
 =?utf-8?B?dzFEZkVhMlE5NFcxb3o4L3FSVWMrM1MvYzYxWTlqdlJTUnRVelRVYy9IUEwr?=
 =?utf-8?B?cGRQcjJoQnl6UmRjdCtId3BLcEcxS3VxNjlGM2lkMk54N2kyZjk1M2tVUmdL?=
 =?utf-8?B?anNvZnZuVit2NU5qV2wrZUdOa2xBN1M1c1ZCVzc3L05YMndmMFRpTGVMQXRk?=
 =?utf-8?B?c3ZOMkNJS0lOSnkxbnlZdUlxLy8rRDVVNDhzbHNES0lLbEdOU3RKOTZ3Sk9a?=
 =?utf-8?Q?7lROfnSktCl0NyMWqITI6k7Yn?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6804.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 656d7343-28dd-45f4-9084-08dce77858ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2024 09:05:24.9083
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6pqCnb4EwWj+M43bkyHja/+xfsVk1pggfWTJJudlfqtpd1C09tE/qnZxwjaa+k9ih/1vgzu1g3xcGle6u6xLFJ+FZsAOyH68QiyXw3EQUwI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6285

PiBPbiBUdWUsIE9jdCAwOCwgMjAyNCBhdCAxMTozNDo1OUFNICswMzAwLCBNaWhhaSBTYWluIHdy
b3RlOg0KPiA+IEFkZCBzdXBwb3J0IHRvIHByaW50IHRoZSBjb250cm9sbGVyIHZlcnNpb24gc2lt
aWxhciB0byBvdGhlciBhdDkxDQo+ID4gZHJpdmVycyBsaWtlIHNwaSBhbmQgdHdpLg0KPiA+DQo+
ID4gU2lnbmVkLW9mZi1ieTogTWloYWkgU2FpbiA8bWloYWkuc2FpbkBtaWNyb2NoaXAuY29tPg0K
PiA+IC0tLQ0KPiA+ICBkcml2ZXJzL3R0eS9zZXJpYWwvYXRtZWxfc2VyaWFsLmMgfCAyICsrDQo+
ID4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL3R0eS9zZXJpYWwvYXRtZWxfc2VyaWFsLmMNCj4gPiBiL2RyaXZlcnMvdHR5L3Nl
cmlhbC9hdG1lbF9zZXJpYWwuYw0KPiA+IGluZGV4IDA5YjI0NmM5ZTM4OS4uNWY5Mzk3NDkxOGMw
IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvdHR5L3NlcmlhbC9hdG1lbF9zZXJpYWwuYw0KPiA+
ICsrKyBiL2RyaXZlcnMvdHR5L3NlcmlhbC9hdG1lbF9zZXJpYWwuYw0KPiA+IEBAIC0yOTcwLDYg
KzI5NzAsOCBAQCBzdGF0aWMgaW50IGF0bWVsX3NlcmlhbF9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1f
ZGV2aWNlDQo+ICpwZGV2KQ0KPiA+ICAgICAgICAqLw0KPiA+ICAgICAgIGNsa19kaXNhYmxlX3Vu
cHJlcGFyZShhdG1lbF9wb3J0LT5jbGspOw0KPiA+DQo+ID4gKyAgICAgZGV2X2luZm8oJnBkZXYt
PmRldiwgIkFUOTEgVVNBUlQgQ29udHJvbGxlciB2ZXJzaW9uICUjeCIsDQo+ID4gKyAgICAgICAg
ICAgICAgYXRtZWxfdWFydF9yZWFkbCgmYXRtZWxfcG9ydC0+dWFydCwgQVRNRUxfVVNfVkVSU0lP
TikpOw0KPiANCj4gTm8sIHRoZSBvdGhlciBkcml2ZXJzIG5lZWQgdG8gYmUgZml4ZWQgdXAsIHdo
ZW4gZHJpdmVycyBhcmUgd29ya2luZyBwcm9wZXJseSwNCj4gdGhleSBhcmUgcXVpZXQuICBUaGlz
IGRyaXZlciBpcyBjb3JyZWN0IGJ5IGJlaW5nIHF1aWV0LCBwbGVhc2Ugc2VuZCBwYXRjaGVzIGZv
cg0KPiB0aGUgb3RoZXIgb25lcyB0byByZW1vdmUgdGhlc2UgdHlwZXMgb2YgbGluZXMuDQoNCklz
IGl0IGFjY2VwdGFibGUgdG8gdXNlIGRldl9kYmcgaW5zdGVhZCBvZiBkZXZfaW5mbyA/DQpUaGFu
a3MuDQoNCj4gDQo+IHRoYW5rcywNCj4gDQo+IGdyZWcgay1oDQo=
