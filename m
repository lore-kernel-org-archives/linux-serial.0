Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA84DDD2;
	Wed, 29 Jan 2025 07:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738135860; cv=fail; b=QMmVTJtQxytt3+y3o1xnz985T26Tjj4psObkK0anMg4Wm/zE8KZZR8SDBrxpgu8HBlKe/MX5FFWOOq6r77aZLWX47xH7b4zuUKQjda3KL1W/RuaM5QdmKuyGEbpnAP9aSXTELPFRUJVMX1obaxYkhLsrP3Up86/6IQ8aP7YKtLQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738135860; c=relaxed/simple;
	bh=TIYBGSawxJm8GnEjBZKIMZWjtuErEiLdj4TYfoh6vYQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SHTvwTqn3zql6UFiFAXRNTPOUeoGsWu6J5Wkm6sJ6I3pzr8Zh9YXBkkYWC+V4CR7375RLp/JS/CLxTWjPZFIiPnhhpKEDwspqLxklsgitLOfTmCZVv/l9+dmM7UUren5oDZaH0bTmdymNI7yv4SOqXM0JtjlWkR4nSEh663+6rc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=deWl824s; arc=fail smtp.client-ip=40.107.220.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="deWl824s"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aW2LmdxsiUiV8BCaOLRO7CTXfJjaK14Ba4bBC7GTXRKF4DCdUezR/ZAaSiYEic2bWySTblQw7XpxJFyr1cHz0bDf+JSazXUiDn3QKOGMJG2ijhmR4l78MyqtVnSp2cd5cbYsuVAbVajPoLunI/4Q0XN4UBPOer3baCiUW8eatQDxOIvK/TdXMFkayla417BYBLrryftKoPCGRJ1jjM4/9XLq03Mb8YM+a0uH9Djps7v+Zd44PK8u/UsOQN2CVPVAwVgtp4AhLW4o/pUYbZ9ac2m6ILXoGKwtEIA4NGcLWAhDCKWHQCLyTQdufrvuIadQ7xPH/G+qiJ5iDBV66zoZrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TIYBGSawxJm8GnEjBZKIMZWjtuErEiLdj4TYfoh6vYQ=;
 b=w9SqX7R22ITT0NYAB7imkozdQNLh23ApEQOfYoAD+meB0+dpW9T4luJqWBZRHt/8XC1OQSgFoqjytC16sYZO9lssGfpu9SnRHzIufFk7EOt2jSnVB43twKkMx+LymyPzQ1KpCTTpkfj2UnpAga2viFJBz9jU/pBslnLe/z/mZrnbNTYdNzqOxkinAdYnqviYG2D41eBge4Fpac8ZMsAwxBg46dUnBtIp2LFhG9AnqTbsavpISvKfWTVYR+gwOTfTapvRKxzMBicUSu8p8mQcBe0j43rtfeq3vX1N3eHFmImZCZPbq9hU5/PPHOO4FNgYudVfUXk4a9P8iMfdhW9tzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TIYBGSawxJm8GnEjBZKIMZWjtuErEiLdj4TYfoh6vYQ=;
 b=deWl824slKZf9XEh19zGRfKM3qMLhjfeuZ+7nZDg7oHojN8lcuj+xLecEGzWgsOVKLvOV4qNVwW5ltPXNAYD59lboNerOQxfijWAOqbBPgPi9Rd20j+R4a8eX8JTVmHs9xB8GdIoPF+Af2v+oJu+5nazaIY5KjaXGWSolHc5vU3GPy33JTTrUbYzFHI7bXaF12ZH5VUXEwWH/vNQZph7FRgvvRy3ILoJXlD2S2mXXPlI6moRWMgg013ugWHQgld/tv7B44L12pjN98b+Z9EwpRKrZ9AO/c3T++i6nYPRKo1ic223h6evNsXYyDFloz2jGeZuSjJlBjl6Nf9emqL8AA==
Received: from MN0PR12MB5716.namprd12.prod.outlook.com (2603:10b6:208:373::14)
 by SA1PR12MB6845.namprd12.prod.outlook.com (2603:10b6:806:25c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.23; Wed, 29 Jan
 2025 07:30:55 +0000
Received: from MN0PR12MB5716.namprd12.prod.outlook.com
 ([fe80::1770:161a:675f:7861]) by MN0PR12MB5716.namprd12.prod.outlook.com
 ([fe80::1770:161a:675f:7861%4]) with mapi id 15.20.8398.014; Wed, 29 Jan 2025
 07:30:55 +0000
From: Kartik Rajput <kkartik@nvidia.com>
To: "krzk@kernel.org" <krzk@kernel.org>
CC: Jon Hunter <jonathanh@nvidia.com>, "robh@kernel.org" <robh@kernel.org>,
	"robert.marko@sartura.hr" <robert.marko@sartura.hr>, "arnd@kernel.org"
	<arnd@kernel.org>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "geert+renesas@glider.be"
	<geert+renesas@glider.be>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "jirislaby@kernel.org" <jirislaby@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "hvilleneuve@dimonoff.com"
	<hvilleneuve@dimonoff.com>, "schnelle@linux.ibm.com"
	<schnelle@linux.ibm.com>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "linux-serial@vger.kernel.org"
	<linux-serial@vger.kernel.org>, "andriy.shevchenko@linux.intel.com"
	<andriy.shevchenko@linux.intel.com>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: serial: Add bindings for
 nvidia,tegra264-utc
Thread-Topic: [PATCH 1/2] dt-bindings: serial: Add bindings for
 nvidia,tegra264-utc
Thread-Index: AQHbcVmjGxaCgJtLykWDc3Z2eucvjrMtXLWA
Date: Wed, 29 Jan 2025 07:30:55 +0000
Message-ID: <ae6132b93ac30a1f7b2721066a0e0eddc01745d5.camel@nvidia.com>
References: <20250128064633.12381-1-kkartik@nvidia.com>
	 <20250128064633.12381-2-kkartik@nvidia.com>
	 <20250128-amusing-squirrel-of-gaiety-b3ba97@krzk-bin>
In-Reply-To: <20250128-amusing-squirrel-of-gaiety-b3ba97@krzk-bin>
Reply-To: Kartik Rajput <kkartik@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB5716:EE_|SA1PR12MB6845:EE_
x-ms-office365-filtering-correlation-id: a70116d9-d12a-4db9-c025-08dd4036de3f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NVRQVzV2RjU3NDY4eU96R3d5UXNTUnMwSW5vK2hqbjh0bmRNbW1HTmhIZzUr?=
 =?utf-8?B?VThiSzZ6MGFOYVFRWTY4Q2x5WVI3bURRdEpXWE40MWFZcHQxUDRzRzRRcG9H?=
 =?utf-8?B?Q1BKUld1RXdkSnVneUNmVDV2OG1kLzJRd2l0NG5OejFEQm9HVWhUbm53NXlv?=
 =?utf-8?B?dk5pZU1tb0FValhhenNEanFodHc5NUFvUkswWHppWVczeXU4dnBBSFB5NU5S?=
 =?utf-8?B?Yy8wTExrRTNSMkNkemoyd2xTVGxZenRRZ0dzdU1WUHZmTEFOcDZzMXQ1TWpZ?=
 =?utf-8?B?NFhBYzl4MmdsbVhnTE1uemtGNEo4M2xLL05Rek1GQnE2ektuODNwa1M0Vkw1?=
 =?utf-8?B?eUlVbm5YRHFTRmJscnNEUDdhajlRcG9KMDUxcVREK2p2TWVGUStvZERVbHo2?=
 =?utf-8?B?a0swdWFUOWM0ZHNBSGR5ZDgyTVBHMUhVWGlpVStwUW5meStLUFhGR2lwTUFF?=
 =?utf-8?B?eW1vaVdNa2NLKzlCbU04Z0Z0T2tHMHQwMUtqb3g1NnFVOVZTRlhWekk1b2NR?=
 =?utf-8?B?YTF6algwVmZtNG1XckVOU1g2Tnh3YTcxaW42TmZEQWNzcXVGaEhlUDVEWkk1?=
 =?utf-8?B?TW9zZzd6WjJlVVdXVjExSHMwRmk2eVZtQjI2alptdy9yTi9WVzFJckMvUWJS?=
 =?utf-8?B?TDJLTklhNFEzVVRHai8yQlFPUUpkYUdJRUMxRVMrem92VjZzT1NSRlhtaTUy?=
 =?utf-8?B?UUhsLzBsa0NJSXFxSEFITXdVTFQxZ3NnZllOdXJ5NE0yMzJXamQ1N3kxK01v?=
 =?utf-8?B?dGVRUG1NdjNHZ2cxcjkxWUMzeHh1bU9xMmxYSEl5ZjV1VHU5TTRrUHhNNTVB?=
 =?utf-8?B?dk1ETzFNb3RkcTJHVTdLMWE0dExueU0vek1SWHRZTm05UEpNNnMzb3kwYlA5?=
 =?utf-8?B?Z2JGS2xjUFl2aEJYbG1saXZYSEZQOVN0TXQrcFUwUG9Demdsdi9vVkYydDla?=
 =?utf-8?B?WHJpZkE0eDR5UlZ6TkNaTmRjTE9zcTAyaTB3M3lKeWlwMlIwY3lPbE0rMmxC?=
 =?utf-8?B?dUdCbHUrS2dSb2JQMDVlbWVEN1BKL0syenEyWGladjgxS2pzcW92Z1FPclVU?=
 =?utf-8?B?cTQ0OEVCSHgvN2MvbW9YVDRpbWVCWVdMamNOU040aVpTaWtLTDU4UWhsbFVB?=
 =?utf-8?B?Y2U3THRQaC9hblFCcmlYS2xJSW9pVEU2M1VwckI1Z0luL0J3Q2krOC85b1M3?=
 =?utf-8?B?Q0s4cEllY0JkYWJ3VDlGRk0xSHhjQk1CWlRMQWpUT0Ewa3RnSUwySkY5ZnhW?=
 =?utf-8?B?ZzRPb0JWZklnZnQrRkJhTWJnU1RGOTlESTFHOGVsMXdONXVrTGxnVHd3dU5k?=
 =?utf-8?B?M2JzSktrbE02cUI2ODFkWnZPclNvR3c3clpJYmJsNllhUlQ5REt1UCtwVmY4?=
 =?utf-8?B?enduRnJ6UGpSMjFITkttaFV5YStva1llSnRSRktRWkRBV3A5MEVTMUMvVUt0?=
 =?utf-8?B?aCt6d2VqNXNpZmYxVTFCM3QwbVJVL085SXdRcWVqelJIVmMyRFBsMXIrY3gz?=
 =?utf-8?B?L1dGdGNWZ3E4VUk3SUpKVGpGQ0I0NnRTdFluUzFzbDZJSGZFYUcrRnM5cDhr?=
 =?utf-8?B?aDgzSmx4OVJNb2xkdC9HdDhseHZsZ3lDNXA5MTl2SElacEVLUnBCZUVwQjBN?=
 =?utf-8?B?TzU5bUFVYjY0L3FtcVNwazRKb1Q1Vlk0OTYwNXFmUWMzZU5haWdEc3RuK2or?=
 =?utf-8?B?ckwvdTRLT2d1bXdzZ05udVViVHBia1EzSTcvU2szeEtXNVdCSitaeTMwUS81?=
 =?utf-8?B?akM0TVQwQ1ZBdVBWZlFiV2pHcXBBWUx1NlNVcUo0Nk9HdkFqS3Bvd1llZ3Jw?=
 =?utf-8?B?cWw2Yi9XeHNZRFlTUkJSTlkwOXMwRFJNaHU4dWd2UERvWEw0RFlFbk02TG5T?=
 =?utf-8?B?Vk5aUklQZTR5MEhoZFdsaDVIUjVHYk93N0tTcXhCUEVSZExQd1Q0YVdzak83?=
 =?utf-8?Q?ruUpdbhAvO3pnsaE5g/dEO7CS1Df1c0e?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5716.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RWZ4U0wwQ0Q2eHdGaE9MUzgxSEtvOGdBZ0lpd2tHU2JKYWt3Q1BLblc5clhw?=
 =?utf-8?B?RWxldTAwMUdoTDlXVFRQNDFKaVNoVVgwM2xIZGlWRjl0QUI4dmwyVGw4K1h6?=
 =?utf-8?B?WDBjZE9GL21FZFZ1Rm8zMk4vd1dLL2dzVVk0TkUxbmtmdFcxcklmWTNRY1Qr?=
 =?utf-8?B?ZkpGNHRaSUxWVG9LMTFGYjczQ3BMa1J0bTRCNGlCK2t4ZzJEcm50TjFFdjg0?=
 =?utf-8?B?MERpczRBWUVIWDE2QUhVaFhKd0tpK25lN2ZobytIQ25od3ZaRm5yR002ZlMr?=
 =?utf-8?B?RTVTV3IzdW9UeWlUZE1BUlNuYnVKYUU0Wm91b3BtUTkrZjRQT2pXRGpWT2Zr?=
 =?utf-8?B?aFhVbTZCeWZyK1huUGlUTUMrS3o2UEhJVzV1NzR6RjNSRHg3blpwWnFCZnJt?=
 =?utf-8?B?STN2elZTVDhUMG5KY0FCa241Um9YQWNENjBLd1VXa2FESGZ2TFJEelh3ZkdC?=
 =?utf-8?B?bkJTeTJ3UTdIbm44NHUyV0FsYkxlUlNTVG1ja0JSMnFHc3BoZ0Qxdm1KZ0hy?=
 =?utf-8?B?R0ZYZ2JUZTFDeUluc0VtZGRWVzJnYzBzTVdGdVM0VG9xMkh3QmVEUHJObVda?=
 =?utf-8?B?NngyR0d4TDB2ZVBXTENXN3ZyUys0U0hzTy9lSStUTVJDZGk2SGVnRG1jOVlh?=
 =?utf-8?B?aGozVU1TZlZLVkdwY2VDYVB4V0I3NlN0RTluOVQzQVVxNCtmaVo0c3oyQTBo?=
 =?utf-8?B?dG1CY1ZGY2hwOW9wS3pCTmc5QnFjWFh5VzJzNUxHaEwwUW5ER25ER0Zpd0Vr?=
 =?utf-8?B?T09OWVRwK002U0U3RlZEdTZsNWY0WVJYMytSSlFyNTgvdGppaHRaeVV2L29l?=
 =?utf-8?B?VE9SY25LcmZDMGxnSUNnN1hUQThkNjF4TkRNeUNwSVlkZXN0YTlpZEJLSk1t?=
 =?utf-8?B?Zi8xQnR6STJXbnVIdHVoWWNrZ3hXR09ncmVleTY4UG5UYmIrOURaOGZDbi85?=
 =?utf-8?B?VWVzeksrT3BlVXkzNmtLN1ZoTXVmVXRUK09ZR3JHQXJibTlKSTR5emllMm01?=
 =?utf-8?B?U1dJVDhxUjBWVEUxQVd6T1o4MEZMclJzazBJMFVqMFB5VFU1aWwwQTFlc2RK?=
 =?utf-8?B?YjNhampkZzladURWMjNTSWNrZEpld2dlbUg5ZVpIaUd6b1pRVXNWa1Y1b2dy?=
 =?utf-8?B?MnpYWkZKQ1dxbmFKTnZNVkUvZ0tzWWhBc3Jvb1FKYWdHUWVaai9GdytKM244?=
 =?utf-8?B?dXRxU2xTdm1EOHU4U1JyQ1lUcnZsTFJpdE1oUWJCUm9MZjhDMkRTVTF2YmJp?=
 =?utf-8?B?TUsrcUZYZGFwZi9NUUpZbWl3RWFmYlRYOXp3OVJCU0l5eC9rTE92WlZoK2Yy?=
 =?utf-8?B?dzkxUjBaS0ZtTmVQQ1hHQ1QzaXhEenRlM08rTnl2aGlsOGdzYU1PVWdScGJ1?=
 =?utf-8?B?R2ZoemlkdU9YOGFnd1hjVkdVdXg2NGJOZTQxN1ROcTBsT1UzU01KakdJRHBG?=
 =?utf-8?B?VXI1Nll3Q1g2enRoZGdjRG5Ha1JkSU1MWHpnZXM4NUNLZE9hdUpjN3E0UlB4?=
 =?utf-8?B?aTZwNDJRMjFXVXE0S0N4R3k5ang3VWFNczRrYkpCdTZGUnBIVnZJblFCRE1X?=
 =?utf-8?B?WU1NZ2Jsay9QbzF4QnF6ZDhvb0pJZ0VsZFVxaythMjFjaWppK2dOOU9WMS81?=
 =?utf-8?B?WGl5UUpVMFJIajIrMWZhaDVYeHFlYjNuRGJzUjJ3cit2N0s0SEJZWFJjdmR2?=
 =?utf-8?B?elI2SzdtR3NQT0k1R3dmZUlyK1dnZmh5MFJZMUs5UXFqQlV5dG5xTUxxNGNV?=
 =?utf-8?B?dmdybXVKOXJTN3pyZTg0cWFZZG5zNkNRN2NqTDdTb29rL3cySmlTNGhhMnBO?=
 =?utf-8?B?cEtRWDFsdlByeGowRm12VjR5TTRFMnZDS2VMUFJ2YUdYeDJ3ZFFJT2NNci9u?=
 =?utf-8?B?Vkp1UmFuZGVjMS8vWHVpSlJ0bzQwS1lQeUh2RURselZpMjEzbXlHakMrZ3Zk?=
 =?utf-8?B?QWhuUmVnbUhsajcyQmJNbXQrL205TlZjaVZ0MVNUQTUxM25tNXFzNkFqOUtM?=
 =?utf-8?B?Z2Q2cjdYMkJjbVluL3RTMHVSd2xNOFZpeFhCTlBjWFJjSnVzbERHMTc2UzNk?=
 =?utf-8?B?NUNOL0sxK1o1aEZhc1dSSTZTaFBCcldPUTNETWcwMEF2cEtlaHl1TkduaTgy?=
 =?utf-8?Q?qW9dqz5yyxnQbcPohBxri5ErG?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <77CE2D2F3FA1F644826ABF8A22C2F227@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5716.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a70116d9-d12a-4db9-c025-08dd4036de3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2025 07:30:55.7552
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0dAh+PP3sayqqeGVRMjp8v++D55xU/ZpQEvsvcDrCQMwniW2ONBiYWratrtqa4HGTAoNaLAUJEYpuiw0C4dKGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6845

VGhhbmtzIGZvciByZXZpZXdpbmcgdGhlIHBhdGNoIEtyenlzenRvZiENCg0KT24gVHVlLCAyMDI1
LTAxLTI4IGF0IDA4OjUyICswMTAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdyb3RlOg0KPiBFeHRl
cm5hbCBlbWFpbDogVXNlIGNhdXRpb24gb3BlbmluZyBsaW5rcyBvciBhdHRhY2htZW50cw0KPiAN
Cj4gDQo+IE9uIFR1ZSwgSmFuIDI4LCAyMDI1IGF0IDEyOjE2OjMyUE0gKzA1MzAsIEthcnRpayBS
YWpwdXQgd3JvdGU6DQo+ID4gVGhlIFRlZ3JhIFVUQyAoVUFSVCBUcmFjZSBDb250cm9sbGVyKSBp
cyBhIEhXIGJhc2VkIHNlcmlhbCBwb3J0DQo+ID4gdGhhdA0KPiA+IGFsbG93cyBtdWx0aXBsZXhp
bmcgbXVsdGlwbGUgZGF0YSBzdHJlYW1zIG9mIHVwIHRvIDE2IFVUQyBjbGllbnRzDQo+ID4gaW50
bw0KPiA+IGEgc2luZ2xlIGhhcmR3YXJlIHNlcmlhbCBwb3J0Lg0KPiA+IA0KPiA+IEFkZCBiaW5k
aW5ncyBmb3IgdGhlIFRlZ3JhIFVUQyBjbGllbnQgZGV2aWNlLg0KPiA+IA0KPiA+IFNpZ25lZC1v
ZmYtYnk6IEthcnRpayBSYWpwdXQgPGtrYXJ0aWtAbnZpZGlhLmNvbT4NCj4gPiAtLS0NCj4gPiDC
oC4uLi9iaW5kaW5ncy9zZXJpYWwvbnZpZGlhLHRlZ3JhMjY0LXV0Yy55YW1swqAgfCA4Mw0KPiA+
ICsrKysrKysrKysrKysrKysrKysNCj4gPiDCoDEgZmlsZSBjaGFuZ2VkLCA4MyBpbnNlcnRpb25z
KCspDQo+ID4gwqBjcmVhdGUgbW9kZSAxMDA2NDQNCj4gPiBEb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3Mvc2VyaWFsL252aWRpYSx0ZWdyYTI2NC11dGMueWFtbA0KPiA+IA0KPiA+IGRp
ZmYgLS1naXQNCj4gPiBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zZXJpYWwv
bnZpZGlhLHRlZ3JhMjY0LXV0Yy55YW1sDQo+ID4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3Mvc2VyaWFsL252aWRpYSx0ZWdyYTI2NC11dGMueWFtbA0KPiA+IG5ldyBmaWxlIG1v
ZGUgMTAwNjQ0DQo+ID4gaW5kZXggMDAwMDAwMDAwMDAwLi42M2JhMzY1NTQ1MWYNCj4gPiAtLS0g
L2Rldi9udWxsDQo+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Nl
cmlhbC9udmlkaWEsdGVncmEyNjQtDQo+ID4gdXRjLnlhbWwNCj4gPiBAQCAtMCwwICsxLDgzIEBA
DQo+ID4gKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IChHUEwtMi4wLW9ubHkgT1IgQlNELTIt
Q2xhdXNlKQ0KPiA+ICslWUFNTCAxLjINCj4gPiArLS0tDQo+ID4gKyRpZDoNCj4gPiBodHRwOi8v
ZGV2aWNldHJlZS5vcmcvc2NoZW1hcy9zZXJpYWwvbnZpZGlhLHRlZ3JhMjY0LXV0Yy55YW1sIw0K
PiA+ICskc2NoZW1hOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvbWV0YS1zY2hlbWFzL2NvcmUueWFt
bCMNCj4gPiArDQo+ID4gK3RpdGxlOiBOVklESUEgVGVncmEgVUFSVCBUcmFjZSBDb250cm9sbGVy
IChVVEMpIGNsaWVudA0KPiANCj4gQ29udHJvbGxlciBhbmQgY2xpZW50IChDbGllbnQ/KSBzb3Vu
ZCBjb25mbGljdGluZy4gV2hhdCBpcyB0aGlzDQo+IGNsaWVudA0KPiBvZj8NCj4gDQoNClRoaXMg
RFQgYmluZGluZyBkb2N1bWVudCBpcyBmb3IgdGhlIFRlZ3JhIFVUQyBjbGllbnQuDQoNClRoZSBU
ZWdyYSBVVEMgKFVBUlQgVHJhY2UgQ29udHJvbGxlcikgaXMgYSBjb250cm9sbGVyIHRoYXQgYWxs
b3dzDQpzaGFyaW5nIGEgc2luZ2xlIHBoeXNpY2FsIFVBUlQgYWNyb3NzIG11bHRpcGxlIGZpcm13
YXJlcy9PUy4gSXQNCnN1cHBvcnRzIHVwLXRvIDE2IGNsaWVudCBpbnRlcmZhY2VzLCBlYWNoIGNs
aWVudCBoYXZlIGl0cyBvd24gUlggYW5kIFRYDQpGSUZPIGFuZCBhbiBpbnRlcnJ1cHQuIFRoZSBU
ZWdyYSBVVEMgY29udHJvbGxlciBpcyBtYW5hZ2VkIGJ5IHRoZQ0KYm9vdGxvYWRlciBhbmQgaXRz
IGNsaWVudHMgYXJlIG1hbmFnZWQgYnkgZmlybXdhcmVzL09TLg0KDQpUaGUgZmlybXdhcmVzL09T
IGNhbiB1c2UgdGhlc2UgY2xpZW50IGludGVyZmFjZXMgdG8gc2VuZC9yZWNlaXZlIGRhdGENCm92
ZXIgdGhlIFVBUlQgYnkgcmVhZGluZy93cml0aW5nIGZyb20vdG8gdGhlIGNsaWVudCBGSUZPcy4g
VGhlIFRlZ3JhDQpVVEMgbXVsdGlwbGV4ZXMgYW5kIGRlLW11bHRpcGxleGVzIHRoZSBkYXRhIGZy
b20vdG8gZWFjaCBjbGllbnQgRklGT3MNCmFuZCBzZW5kcy9yZWNlaXZlIHRoYXQgb3ZlciBhIHBo
eXNpY2FsIFVBUlQuDQoNCj4gPiArDQo+ID4gK21haW50YWluZXJzOg0KPiA+ICvCoCAtIEthcnRp
ayBSYWpwdXQgPGtrYXJ0aWtAbnZpZGlhLmNvbT4NCj4gPiArwqAgLSBUaGllcnJ5IFJlZGluZyA8
dGhpZXJyeS5yZWRpbmdAZ21haWwuY29tPg0KPiA+ICvCoCAtIEpvbmF0aGFuIEh1bnRlciA8am9u
YXRoYW5oQG52aWRpYS5jb20+DQo+ID4gKw0KPiA+ICtkZXNjcmlwdGlvbjoNCj4gPiArwqAgVGhl
IFRlZ3JhIFVUQyAoVUFSVCBUcmFjZSBDb250cm9sbGVyKSBpcyBhIGhhcmR3YXJlIGNvbnRyb2xs
ZXINCj4gPiB0aGF0DQo+ID4gK8KgIGFsbG93cyBtdWx0aXBsZSBzeXN0ZW1zIHdpdGhpbiB0aGUg
VGVncmEgU29DIHRvIHNoYXJlIGEgaGFyZHdhcmUNCj4gPiBVQVJUDQo+ID4gK8KgIGludGVyZmFj
ZS4gSXQgc3VwcG9ydHMgdXAgdG8gMTYgY2xpZW50cywgd2l0aCBlYWNoIGNsaWVudCBoYXZpbmcN
Cj4gPiBpdHMgb3duDQo+ID4gK8KgIGludGVycnVwdCBhbmQgYSBGSUZPIGJ1ZmZlciBmb3IgYm90
aCBSWCAocmVjZWl2ZSkgYW5kIFRYDQo+ID4gKHRyYW5zbWl0KSwgZWFjaA0KPiA+ICvCoCBjYXBh
YmxlIG9mIGhvbGRpbmcgMTI4IGNoYXJhY3RlcnMuDQo+IA0KPiBTbyBpcyB0aGlzIGNsaWVudCBv
ciB0aGUgY29udHJvbGxlcj8NCj4gDQoNClRoaXMgaXMgZm9yIHRoZSBUaGUgVGVncmEgVVRDIGNs
aWVudCBpbnRlcmZhY2UuIFRoZSBUZWdyYSBVVEMNCmNvbnRyb2xsZXIgaXMgbWFuYWdlZCBieSB0
aGUgYm9vdGxvYWRlci4NCg0KPiA+ICsNCj4gPiArwqAgVGhlIFRlZ3JhIFVUQyB1c2VzIDgtTi0x
IGNvbmZpZ3VyYXRpb24gYW5kIG9wZXJhdGVzIG9uIGEgcHJlLQ0KPiA+IGNvbmZpZ3VyZWQNCj4g
PiArwqAgYmF1ZHJhdGUsIHdoaWNoIGlzIGNvbmZpZ3VyZWQgYnkgdGhlIGJvb3Rsb2FkZXIuDQo+
ID4gKw0KPiA+ICtwcm9wZXJ0aWVzOg0KPiA+ICvCoCAkbm9kZW5hbWU6DQo+ID4gK8KgwqDCoCBw
YXR0ZXJuOiAiXnNlcmlhbChALiopPyQiDQo+IA0KPiBEcm9wLCBub3QgbmVlZGVkLiBCdXQgeW91
IG1pc3MgcHJvcGVyICRyZWYsIHNlZSBvdGhlciBiaW5kaW5ncy4NCj4gDQo+IA0KDQpBY2suIEkn
bGwgZml4IHRoaXMgaW4gdjIuDQoNCj4gPiArDQo+ID4gK8KgIGNvbXBhdGlibGU6DQo+ID4gK8Kg
wqDCoCBjb25zdDogbnZpZGlhLHRlZ3JhMjY0LXV0Yw0KPiA+ICsNCj4gPiArwqAgcmVnOg0KPiA+
ICvCoMKgwqAgaXRlbXM6DQo+ID4gK8KgwqDCoMKgwqAgLSBkZXNjcmlwdGlvbjogUmVnaXN0ZXIg
cmVnaW9uIGZvciBUWCBjbGllbnQuDQo+IA0KPiBEcm9wIHJlZHVuZGFudCBwYXJ0cywgc28ganVz
dCAiVFggcmVnaW9uIi4NCj4gDQoNCkFjay4gSSdsbCBmaXggdGhpcyBpbiB2Mi4NCg0KPiA+ICvC
oMKgwqDCoMKgIC0gZGVzY3JpcHRpb246IFJlZ2lzdGVyIHJlZ2lvbiBmb3IgUlggY2xpZW50Lg0K
PiA+ICvCoMKgwqAgbWluSXRlbXM6IDINCj4gDQo+IERyb3ANCj4gDQoNCkFjay4gSSdsbCBmaXgg
dGhpcyBpbiB2Mi4NCg0KPiA+ICsNCj4gPiArwqAgcmVnLW5hbWVzOg0KPiA+ICvCoMKgwqAgaXRl
bXM6DQo+ID4gK8KgwqDCoMKgwqAgLSBjb25zdDogdHgNCj4gPiArwqDCoMKgwqDCoCAtIGNvbnN0
OiByeA0KPiA+ICvCoMKgwqAgbWluSXRlbXM6IDINCj4gDQo+IERyb3AuIFBsZWFzZSB0YWtlIGEg
bG9vayBhdCBvdGhlciBiaW5kaW5ncyBob3cgdGhleSBkbyB0aGluZ3MuIFRoZXJlDQo+IGlzDQo+
IG5vIHN1Y2ggY29kZSBhbnl3aGVyZSBpbiB0aGUga2VybmVsLg0KPiANCg0KQWNrLiBJJ2xsIGZp
eCB0aGlzIGluIHYyLg0KDQo+ID4gKw0KPiA+ICvCoCBpbnRlcnJ1cHRzOg0KPiA+ICvCoMKgwqAg
bWF4SXRlbXM6IDENCj4gPiArDQo+ID4gK8KgIGN1cnJlbnQtc3BlZWQ6DQo+ID4gK8KgwqDCoCAk
cmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9ucy91aW50MzINCj4gPiArwqDCoMKg
IGRlc2NyaXB0aW9uOg0KPiA+ICvCoMKgwqDCoMKgIFRoaXMgcHJvcGVydHkgc3BlY2lmaWVzIHRo
ZSBiYXVkcmF0ZSBhdCB3aGljaCB0aGUgVGVncmEgVVRDDQo+ID4gaXMNCj4gDQo+IERyb3AgIlRo
aXMgcHJvcGVydHkgc3BlY2lmaWVzIHRoZSIuIERvIG5vdCBzYXkgd2hhdCBEZXZpY2V0cmVlIHN5
bnRheA0KPiBpcy4gV2UgYWxsIGtub3cuIFRoaXMgaXMgYSBkZXNjcmlwdGlvbiBvZiBoYXJkd2Fy
ZSwgbm90IHRoZSBEVFMNCj4gbGFuZ2F1Z2UuDQo+IA0KDQpBY2suIEknbGwgZml4IHRoaXMgaW4g
djIuDQoNCj4gPiArwqDCoMKgwqDCoCBvcGVyYXRpbmcuDQo+ID4gKw0KPiA+ICvCoCBudmlkaWEs
dXRjLWZpZm8tdGhyZXNob2xkOg0KPiA+ICvCoMKgwqAgJHJlZjogL3NjaGVtYXMvdHlwZXMueWFt
bCMvZGVmaW5pdGlvbnMvdWludDMyDQo+ID4gK8KgwqDCoCBkZXNjcmlwdGlvbjoNCj4gPiArwqDC
oMKgwqDCoCBUaGlzIHByb3BlcnR5IHNwZWNpZmllcyB0aGUgVVRDIFRYIGFuZCBSWCBjbGllbnQg
RklGTw0KPiA+IHRocmVzaG9sZCBpbg0KPiA+ICvCoMKgwqDCoMKgIHRlcm1zIG9mIG9jY3VwYW5j
eS4NCj4gPiArDQo+ID4gK8KgwqDCoMKgwqAgVGhpcyBwcm9wZXJ0eSBzaG91bGQgaGF2ZSB0aGUg
c2FtZSB2YWx1ZSBhcyB0aGUgYnVyc3Qgc2l6ZQ0KPiA+IChudW1iZXINCj4gPiArwqDCoMKgwqDC
oCBvZiBjaGFyYWN0ZXJzIHJlYWQgYnkgdGhlIFRlZ3JhIFVUQyBoYXJkd2FyZSBhdCBhIHRpbWUg
ZnJvbQ0KPiA+IGVhY2gNCj4gPiArwqDCoMKgwqDCoCBjbGllbnQpIHdoaWNoIGlzIGNvbmZpZ3Vy
ZWQgYnkgdGhlIGJvb3Rsb2FkZXIuDQo+IA0KPiBUaXRsZSBzYXlzIHRoaXMgaXMgYSBjbGllbnQs
IHNvIHF1aXRlIGNvbmZ1c2luZy4gQW55d2F5LCB3aHkgaXMgdGhpcw0KPiBib2FyZCBzcGVjaWZp
Yz8NCg0KVGhlIGNsaWVudCBGSUZPIHRocmVzaG9sZCBzaG91bGQgbWF0Y2ggdGhlIGJ1cnN0IHNp
emUgY29uZmlndXJlZCBpbiB0aGUNClVUQyBjb250cm9sbGVyIGJ5IGJvb3Rsb2FkZXIuIFRoaXMg
dmFsdWUgY291bGQgY2hhbmdlIGRlcGVuZGluZyBvbiB3aGF0DQpib290bG9hZGVyIGhhcyBwcm9n
cmFtbWVkLiBIZW5jZSwgdGhpcyBpcyBtb3ZlZCB0byB0aGUgZGV2aWNlLXRyZWUuDQoNCj4gDQo+
IEFsc28sIG1pc3NpbmcgY29uc3RyYWludHMsIG1pc3NpbmcgdW5pdHMuIFdoeSBjb21tb24gc2Vy
aWFsDQo+IHByb3BlcnRpZXMNCj4gYXJlIG5vdCBhcHBsaWNhYmxlPw0KPiANCg0KSSBkbyBzZWUg
Y3VycmVudC1zcGVlZCBkZWZpbmVkIGluIHNlcmlhbC1wZXJpcGhlcmFsLXByb3BzLnlhbWwsIHRo
YXQNCmNhbiBiZSB1c2VkIGhlcmUuIEkgYWxzbyBzZWUgInJ4LXRocmVzaG9sZCIgYW5kICJ0eC10
aHJlc2hvbGQiDQpwcm9wZXJ0aWVzIGRlZmluZWQgaW4gc2VyaWFsLnlhbWwsIG1heWJlIHRob3Nl
IGNhbiBiZSB1dGlsaXplZCBoZXJlLiBJDQp3aWxsIHVwZGF0ZSB0aGlzIGluIHYyLg0KDQo+IEJl
c3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQo+IA0KDQpUaGFua3MgJiBSZWdhcmRzLA0KS2FydGlr
DQo=
