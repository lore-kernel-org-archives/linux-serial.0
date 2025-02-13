Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD56227E90;
	Thu, 13 Feb 2025 12:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739450164; cv=fail; b=a6367O5t8e71mGUniubSW4JP7XJefcVBGQz8qwGwNpUa5Sv6Syuddjot2F7GajFJAANBrnq8d9dGq/2lOqMiaNaoeL3FYxSRKd3ja9T2HUb6iv4IT61LsOw+9DJY3N+21DRa1xCanqj9isqOTZeqxP2f9KPZE7qyR6v+pOlmtJs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739450164; c=relaxed/simple;
	bh=7EwSUJ2rAP32QZEpY84ec90ouDmkQuHzPGXtw+Eqp9Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UUuWUCDox1dVfZNAIALRYJqA5gUF+/nhvpSvAoTXTHVOxYyZBGiSwjc8M3hDUMa0e0xOGLejJJRv0rExEpLicpwO+p4Ayx1Y/cpXke1D2GlU7VnTTBndMwtX85NMc02T+ocpEKVhLsRGn6FOItX1lXgk0F1YRnc/gsBxdxmG/ag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NJj9BVwP; arc=fail smtp.client-ip=40.107.223.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NJj9BVwP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M/a8rHLD+/h2F7KFrvxbLhr01s0Xv3i8R3sJDxzITAheEq7h0jnHbzyvNdpM/W1hukrQGUVUz+a04wiNAKOafT9lFMrI6OLRVIrqkn984fa4ipI6Y+zrvLydx8eN4SsR6JI/i57QKPZhAd5ryw5jTzy8+mbw3yHnH9aTx4UhUWUbkkIOSkDLjkZqcFBLNzVYGXrOZO2OsJbUxBltBvR/tg3/05zXS8EDbU5x5NQug2mRjeNy6VIdd6D+8FdobMYnIY4UnQZuJorLu6L2fpDouveVIMXvnenLudbxEKbUbCSsEkfmD1mfgnSTGh5jfqXASmTQZqKHKRq9bvCpjf7t2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7EwSUJ2rAP32QZEpY84ec90ouDmkQuHzPGXtw+Eqp9Y=;
 b=A+w8MSeIioNZxK7AfnX1YuurucioMTD7wrHMQUIrCQ/a7qh5j6yNsBdiFZT72dUDTStdkPK+4nqCjpHBkm3K34xnCNKlwo34UzNmZex9RNYeR6M03xR9M37X6UPQ2ekxk9m6hHlrlhrNYqmfYzcB3klnlBjgbz2ERv6D3toO3O4/X3VByq/HcUD/wmBQSvGah7Ax9owHfS8fQLO11Elf3QiZhZb4J/qrWTlzDRHIDjMTTo3H2iQksuBfDOMUuNq/lynh8+p/LTn4/caLuIidTVXlkVEI2c4J/Z0XUaltABTJha/8/mcYwiVaWEZr9TzFnyHs2wi+YEj126iBlxJeHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7EwSUJ2rAP32QZEpY84ec90ouDmkQuHzPGXtw+Eqp9Y=;
 b=NJj9BVwPf+pz/kNq4nyAhUDKLutNIdPsLMdBKhKVvWgEtT20jH8tukD28JmY9ELC2M5WfscHACsxLGxGF/jzwz7dxixc/LijJde0F8kH5tDehOY6zp9lXdrbwdXteVWRV5NgmkJtA3rLJ4d0eTsWNc4uZza+DGfZ4C9Lk7EmPhXnuOvDgRW4bQSQ072Esw8RGnGn/0YXZRdi9Zp4HnA3hXI+OXcUsmCNgPie5EhW5FDLs/kiqnUmYeoKUw/Mx4b556kYtoc/oTKbXFy2RNrnRhLGqB1IOxjnznUy/cAgj/GAJvWO4hZOvU/4i7TmCVe9EgAXsakAsjkGUuUihnjuig==
Received: from MN0PR12MB5716.namprd12.prod.outlook.com (2603:10b6:208:373::14)
 by DS0PR12MB9059.namprd12.prod.outlook.com (2603:10b6:8:c5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Thu, 13 Feb
 2025 12:35:59 +0000
Received: from MN0PR12MB5716.namprd12.prod.outlook.com
 ([fe80::1770:161a:675f:7861]) by MN0PR12MB5716.namprd12.prod.outlook.com
 ([fe80::1770:161a:675f:7861%4]) with mapi id 15.20.8445.013; Thu, 13 Feb 2025
 12:35:59 +0000
From: Kartik Rajput <kkartik@nvidia.com>
To: "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>
CC: Jon Hunter <jonathanh@nvidia.com>, "robh@kernel.org" <robh@kernel.org>,
	"robert.marko@sartura.hr" <robert.marko@sartura.hr>, "arnd@kernel.org"
	<arnd@kernel.org>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "geert+renesas@glider.be"
	<geert+renesas@glider.be>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "jirislaby@kernel.org" <jirislaby@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "hvilleneuve@dimonoff.com"
	<hvilleneuve@dimonoff.com>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "schnelle@linux.ibm.com"
	<schnelle@linux.ibm.com>, "linux-serial@vger.kernel.org"
	<linux-serial@vger.kernel.org>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] serial: tegra-utc: Add driver for Tegra UART Trace
 Controller (UTC)
Thread-Topic: [PATCH v4 2/2] serial: tegra-utc: Add driver for Tegra UART
 Trace Controller (UTC)
Thread-Index: AQHbfgc9ouGFIJvl6UOQeoaxqnNceLNFK5sA
Date: Thu, 13 Feb 2025 12:35:59 +0000
Message-ID: <a167c98a02e8020c81f377d2aea0878a53965581.camel@nvidia.com>
References: <20250213100442.45773-1-kkartik@nvidia.com>
	 <20250213100442.45773-3-kkartik@nvidia.com>
	 <Z63SAPtHXR6KN9qa@smile.fi.intel.com>
In-Reply-To: <Z63SAPtHXR6KN9qa@smile.fi.intel.com>
Reply-To: Kartik Rajput <kkartik@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB5716:EE_|DS0PR12MB9059:EE_
x-ms-office365-filtering-correlation-id: 4141dfb5-1fdf-48f1-1830-08dd4c2af83e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?S1pvVjBmV1g0S1hod3Z4SkNMeEU3eHVCcVMrOXZYQUFSOEUrS2hCMnhLWFUr?=
 =?utf-8?B?a2N6dGlQNnM0dUc3Zy83OFRPUVRFSVRzZDIrS0dXVEZmTXVqTkprMUczOWNk?=
 =?utf-8?B?UGJnMVBDRm9aTE5pdHR5R1ptZ3RqaGpvdGRlZ1hudHV3anNvUXRya2x6ZjVI?=
 =?utf-8?B?ZGg2ME9TZU5GMjJJaE5YOTBFUGRWOG1rdU4rWmVnUkdpdUZRVlFuc0VKd0Zs?=
 =?utf-8?B?OVNxNysrSVlXdkRVTldPaEt6b3R1UGlqZHpmL1ZTLzJaTGd4bVhXYitiN0J5?=
 =?utf-8?B?c3Vwdyt4cXBMbFBzVmM3SHJ0WjdHcWdVMDlvSmUyZFBEODQwZGFXZnJYM1oz?=
 =?utf-8?B?UEFnMVlWbE9QcEo5dncxWUliQmxKYW9jREhZVVBsdTNTSVNCQWNIUmQ3Mi9q?=
 =?utf-8?B?NTlHSzFLV01hWDJab1NobC9nWmNoRHE4V3pDVjZDWjduRitmbHMvYVNhQ29a?=
 =?utf-8?B?S0dzc2o3QmJjc0ErR1VyeWR6TWt3V0hMT2RRUHFYbHFtVWkxeG1KNlNRL0hj?=
 =?utf-8?B?VHJFS010WHl3K3pia0RnY3BKYUJjQ3FMQXdmRVMzdk1uOS9RanpMYXVISEY0?=
 =?utf-8?B?UDRRNG0reGVnWkw5K0M3LzBSUm9uV3NFRDkrKzBLcE5ETUs2bmJrenZscW9S?=
 =?utf-8?B?ZHZRU2JUUW1Fd1pOMFRvTnJYU0dHQ0kyYnUxdFZwaGo2U2NUOTNFK2huS3Fz?=
 =?utf-8?B?eUNVdmtWckZYZVoxL1Q0OEpUNzNXNTFhUllONmpIUG5nNEpIRk1GMTFwMnNJ?=
 =?utf-8?B?ZkxFWXdidEVQaU5iMzJOaDV0ekpONTh3WHJWd1RnNHVBbmxyVFlYM0dPeTA5?=
 =?utf-8?B?M1lqRm02c3BScmVnNkVBU1BheUdWVFZSVHRmQzJQbGhMTzBPd3NPRW9sUWdH?=
 =?utf-8?B?SU5kc3N4N2JhMEt3a3NycEJpeS9aQjNBdnNmMjFNZzNmQXhTVXhtWW9ja0Vw?=
 =?utf-8?B?Q3hNVXFaeDJLWnNHTWlBenhpbUlwYmpPNmMzQkFuVE1VTDNCSGkvb01LeGJP?=
 =?utf-8?B?NUVIeGtCUFBHV1NDS014cUEwV2xjVVJVL2ZWYXFzTE5sQXN5ZGNnTzJYZlND?=
 =?utf-8?B?MEFKNCtUWUhMbjl1YkEySWI2ZUk3TEFCVlJKbUtJK2hsays4cFEwdGttZlkr?=
 =?utf-8?B?cENZQjZQYmtuRi9BcUFTSndTdERBWjc3ZnBlakFvRzduN2lOWjNZdjRkVThk?=
 =?utf-8?B?RmgvQ2ViQVpzSnZ1Vk9yZDY3VTJhYUc3QVhLazZ6cVRMRy9oRWZheHRxTE5v?=
 =?utf-8?B?cWhlaHpERDdEbW1YVjNVUTZLaGRxYmNaekZFbzNZNFlvWVBBSVR0ZXY5UjY3?=
 =?utf-8?B?cFI2NGl3ZlJ6MFd4ZG9pRzZQWUNpRlppSGc1RlIrUUNHa2JQWi9JTWdWcXBL?=
 =?utf-8?B?QkJhaDAreW9ZRWc3QStZL1FlR1ZFcEFwNGVtTVJ4cVVMOEE4amgyUkZiN24y?=
 =?utf-8?B?alM0V0o3eWtDK2QyS0tCWmgxYUoxTFRiVUFBcG40b0hZd29MemlXaE8zaklF?=
 =?utf-8?B?S2ZCMmxLNjhXd1Z5Tk9KY3czUk9uWU14aEpLdnZ6UVBrL0FCMHIzaFExMDdw?=
 =?utf-8?B?VlMvV2tFUjR5c1pzRHZGTXcxZGd3SFVNUkhUN2g0TjFJSmpMaFhrWE15Zmtn?=
 =?utf-8?B?SVZRL25kdGFRYVZpMlNJc2ZrQVZJRk9Wd012OXU2TTFrQnVBelErRnhVdWlo?=
 =?utf-8?B?QmNhUnhheWJ3WWdTSmU4UjFheDV4YVlYQ2lBeDVCRStRTkl6MG0waGFWR3g3?=
 =?utf-8?B?Wjl6OEZ0amh6SmNTaDhTU3duTkNkbGZHc1ZBMGVFYWRhL29Db2xmYlJpSGVv?=
 =?utf-8?B?cXptcDZJZnQ2UUVHOExDUTh6MlNDRUFXZGVxMWRNaitUa2ZPNjZzbVJFdEtn?=
 =?utf-8?B?Zyt3RTNxZWxrNGQwMzFCQyttWjVOang1ajhFY3ByNVowRm9MYmkzNk5CeFBa?=
 =?utf-8?Q?zUKjZcqgFITgV6HbfGLxs1+OKX9jw3VW?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5716.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MU9EbnMzQUl4aWtSNGt2THpCd2tuU0wrV20zOC83N0NiLzc5VEtpVXAyRktU?=
 =?utf-8?B?TnZwMTZhTncvbDc3c2VLdmhaOVRxRGIvNC83THk0ZnMrWXEvUFRDcU9BSUdm?=
 =?utf-8?B?N0VVUG9MQ09sUi9ZSnY2Z1JpenVTWUdYT3J5NlFzV2xBOTNhbndqU2pKckYw?=
 =?utf-8?B?dmdWNUNzdUl6b1AyWXArYUdNeUhUYW94cTN2NjlhRm1pd2puQlZwYjFxQUcw?=
 =?utf-8?B?K09WMHdPMzRDc1U1Tnpsd3FNcE5QRlhFdkYyU0pyUzZUVUJRTEFWNG9RRjNu?=
 =?utf-8?B?UExianJPWWhkeEEyNmF4T0NKZG0ramhTUHdCdkFubDdjaGgyV1BMOTVFMTUr?=
 =?utf-8?B?bW9mN1daNjdkOWpIbS91djhETm52em8zMDdTSk83N3lETFI2cms2TVpHTGQ0?=
 =?utf-8?B?c0tZTE14QmdVM0lLcHBEV1lPN3BGWG5keXFoczlRbE43MTRkRng3SzhkanVS?=
 =?utf-8?B?WWdzTXQxbzNnRG9vdFNXODc1cUNHV2t4K09pa0pYL2tneC9KUjcwZTZjVGpX?=
 =?utf-8?B?ZUh5M1lveEJCVXNhSHVHUmFIZDIvSXhTZG1GZkFpaE5Yc29pN1NEK29KRmZU?=
 =?utf-8?B?akJRYk1QVlgrMGlKdktQTktHMHA1OSszdDJQSlIrV0F4cU1YOWRvQm94b1RC?=
 =?utf-8?B?cVR4UmxCb3M4RTllc0NzRml6OEJCTi9jeXdHRU9uTTk1d1FoV2ZZOUdIMEp4?=
 =?utf-8?B?dkt5Nk9sRGhnUVhmY3ZQU0lVejh5QzhmQzBXZXVocTJnY3E1cDhBOTg3dll3?=
 =?utf-8?B?dEhIOHF2VUdPOStpSGU0NlJyenFKeUhhbmJBdkxCT0FsL3RWSDQxWHdKeG1B?=
 =?utf-8?B?MFpvd1d4TFFCNHhjYy9TUTY5RjEzVWVncGVLUnM2dTNQYzFXdTFUWWlkY09M?=
 =?utf-8?B?NXR2UjhQNWRyWGZHS2lsVzhaTElUUzJQOXFaRldHbURyUUcvaVNoVEtYL0Js?=
 =?utf-8?B?bnRSMHFaZWJJbWRjcjZONnRwSzlUWFMxQU43bUhhT2tnekxxOW1vM3BWSDVO?=
 =?utf-8?B?T2I2bzlFM3djUS8wNnd4ZDJqcHhnK085LzN4bHozL2tjUjFsMFNLM3RXQ0tX?=
 =?utf-8?B?d2NjcGRXV2ZxQTNDV2QvcVJMbHhtbVNLbjdaRTJKaGRTaURwYkV0UEJLcHRx?=
 =?utf-8?B?L3JUQUNBR1c5ajQ4dW8wNThnQ3QwM0ZITXhzU3Y3dWl1a3Rlb1RucFJiWG9y?=
 =?utf-8?B?U2xwK0FYMTdvbmlIcElsWkNYSkNCM1VnY29pdDcwbzQyTCs1a0h2bUQ1S0xV?=
 =?utf-8?B?eHFlSW1iZXE2VE11QTkvNWFrZGZUL3ZjVmFpVWFpQ2Q2cUhnLys0TDlxWjNW?=
 =?utf-8?B?VDhuaFZBQUR6aVFZaXgrOTJtL2pGQUM0QXVoWTc4MzhPYitQOTNHeVhNY1hR?=
 =?utf-8?B?TFl0MFBTdHZ2Z08wVThPSmw5bDdxUWF5WnR2WHBGNkkxajAzcnFkNjQ5U2la?=
 =?utf-8?B?YzhweWN6bnRvZnpvakVobTBvZmJlUGhjT0FxaFlIYmlPWjhkS0lKM08rYjZz?=
 =?utf-8?B?UWkzUDRlbFhzYlNweE9MMDhqcXVGSjZJTEdya1QzMDhiQnBRaEJHQ3BpWUIv?=
 =?utf-8?B?SElWbEsxWkZQMHdLcmszemgrMElCRSs1VXdTVitpNytkeWhGWkpxY2RIN0g2?=
 =?utf-8?B?VUZFNVVBUFJLTHhyUWMyVnhmbEM5ZkQvWTNXODk1L0Vna3puanVTMTVxWTdF?=
 =?utf-8?B?ZWNXNDRUSmFvdHNBdWJlaDZYOVZoV3ZOa3pqekxKRUlFVUs0enJSeXp1Y3Q0?=
 =?utf-8?B?ZS9iOWZjODdHQ21kWHJFUHU3ZFM4aWFvZEdHMlpoNmo1eFUxY2YxQ0JyWC9V?=
 =?utf-8?B?NWFaZ3hwVXEwc3oyNGlZZHlXclk2STFQQ1huMnpySjJrTEZRNDl0OUc0bm9V?=
 =?utf-8?B?MUk5ckQzdDhEZjJxaXFlT1hqZmFYSS9BNWRXalA2NEtFV2FEQS8ydjRqcVZU?=
 =?utf-8?B?MjBVMEM5VjFJN1lQK0l0TEg2SlhRWFppSDRSYVhBOWRPK0toa25Md0ZQWlYr?=
 =?utf-8?B?bC8ybSt4MEVJem5KSVhpazJnblVwQkZKZkhsbU5JS0VIbnRRQTMzTTYzaHhJ?=
 =?utf-8?B?NktSRDBqYnFaTU9MQUViTytLb2tFL3poZWxPRjVCV0lpK3JuWjErRllBTkhM?=
 =?utf-8?B?MGNnSVRvMTRUcjRvc0hLY2kwelRMcGNlbDNaOFJWOVphVVdYdWI1VDl0YXRp?=
 =?utf-8?B?aUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D1C8A0CD967C6F488D26678EB949606C@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4141dfb5-1fdf-48f1-1830-08dd4c2af83e
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2025 12:35:59.3495
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Sp1x07tyhobOZvAU8k6ARqTH96plcDGDZa7muqMRscvPaFT5/WQSynyoRKQoM36e1tq1PW+cAvTaAX3GyboYKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9059

T24gVGh1LCAyMDI1LTAyLTEzIGF0IDEzOjA1ICswMjAwLCBBbmR5IFNoZXZjaGVua28gd3JvdGU6
Cj4gRXh0ZXJuYWwgZW1haWw6IFVzZSBjYXV0aW9uIG9wZW5pbmcgbGlua3Mgb3IgYXR0YWNobWVu
dHMKPiAKPiAKPiBPbiBUaHUsIEZlYiAxMywgMjAyNSBhdCAwMzozNDo0MlBNICswNTMwLCBLYXJ0
aWsgUmFqcHV0IHdyb3RlOgo+ID4gVGhlIFRlZ3JhMjY0IFNvQyBzdXBwb3J0cyB0aGUgVUFSVCBU
cmFjZSBDb250cm9sbGVyIChVVEMpLCB3aGljaAo+ID4gYWxsb3dzCj4gPiBtdWx0aXBsZSBmaXJt
d2FyZSBjbGllbnRzICh1cCB0byAxNikgdG8gc2hhcmUgYSBzaW5nbGUgcGh5c2ljYWwKPiA+IFVB
UlQuCj4gPiBFYWNoIGNsaWVudCBpcyBwcm92aWRlZCB3aXRoIGl0cyBvd24gaW50ZXJydXB0IGFu
ZCBoYXMgYWNjZXNzIHRvIGEKPiA+IDEyOC1jaGFyYWN0ZXIgd2lkZSBGSUZPIGZvciBib3RoIHRy
YW5zbWl0IChUWCkgYW5kIHJlY2VpdmUgKFJYKQo+ID4gb3BlcmF0aW9ucy4KPiA+IAo+ID4gQWRk
IHRlZ3JhLXV0YyBkcml2ZXIgdG8gc3VwcG9ydCBUZWdyYSBVQVJUIFRyYWNlIENvbnRyb2xsZXIg
KFVUQykKPiA+IGNsaWVudC4KPiAKPiBCdHcsIG5laXRoZXIgdGhlIGNvbW1pdCBtZXNzYWdlIG5v
ciBjb3ZlciBsZXR0ZXIgZXhwbGFpbiB3aHkgdGhlIG5ldwo+IGRyaXZlcgo+IGlzIG5lZWRlZC4g
VGhlcmUgYXJlIHNvbWUgc2VyaWFsIFRlZ3JhIGRyaXZlcnMgYWxyZWFkeS4gSXMgdGhpcyBvbmUK
PiBjb21wbGV0ZWx5Cj4gZGlmZmVyZW50IGZyb20gdGhlIGV4aXN0aW5nIGRyaXZlcnM/Cj4gCgpU
ZWdyYTI2NCBwbGF0Zm9ybXMgaGF2ZSBhIHNpbmdsZSBkZWJ1ZyBVQVJUIHdoaWNoIGlzIHNoYXJl
ZCBhY3Jvc3MKbXVsdGlwbGUgZmlybXdhcmVzIGFuZCB0aGUgT1MuIFRoZSBUZWdyYSBVVEMgaXMg
YWRkZWQgdG8gYWRkcmVzcyB0aGlzCmlzc3VlLgoKSXQgaXMgYSBjb21wbGV0ZWx5IGRpZmZlcmVu
dCBkcml2ZXIuCgo+IC4uLgo+IAo+ID4gKyNkZWZpbmUgVEVHUkFfVVRDX0VOQUJMRcKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgMHgwCj4gCj4gSXQgd291bGQgYmUgbmlj
ZSB0byB1c2UgZml4ZWQgd2lkdGggdmFsdWVzIGZvciB0aGUgcmVnaXN0ZXIgb2Zmc2V0cywKPiBl
LmcuLCAweDAwMCBoZXJlLgo+IAoKQWNrLgoKPiA+ICsjZGVmaW5lIFRFR1JBX1VUQ19FTkFCTEVf
Q0xJRU5UX0VOQUJMRcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgQklUKDApCj4gPiArCj4g
PiArI2RlZmluZSBURUdSQV9VVENfRklGT19USFJFU0hPTETCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgMHg4Cj4gPiArCj4gPiArI2RlZmluZSBURUdSQV9VVENfQ09NTUFORMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDB4Ywo+IAo+IERpdHRvLgo+IAoKQWNrLgoKPiA+ICsj
ZGVmaW5lIFRFR1JBX1VUQ19DT01NQU5EX1JFU0VUwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIEJJVCgwKQo+ID4gKyNkZWZpbmUgVEVHUkFfVVRDX0NPTU1BTkRfRkxV
U0jCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgQklUKDEpCj4gCj4g
PiArI2RlZmluZSBURUdSQV9VVENfREFUQcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAweDIwCj4gCj4gRGl0dG8uCj4gCgpBY2suCgo+
ID4gKyNkZWZpbmUgVEVHUkFfVVRDX0ZJRk9fU1RBVFVTwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAweDEwMAo+ID4gKyNkZWZpbmUgVEVHUkFfVVRDX0ZJRk9f
RU1QVFnCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBCSVQoMCkKPiA+ICsjZGVmaW5l
IFRFR1JBX1VUQ19GSUZPX0ZVTEzCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEJJ
VCgxKQo+ID4gKyNkZWZpbmUgVEVHUkFfVVRDX0ZJRk9fUkVRwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIEJJVCgyKQo+ID4gKyNkZWZpbmUgVEVHUkFfVVRDX0ZJRk9fT1ZFUkZM
T1fCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgQklUKDMpCj4gPiAr
I2RlZmluZSBURUdSQV9VVENfRklGT19USU1FT1VUwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgQklUKDQpCj4gPiArCj4gPiArI2RlZmluZSBURUdSQV9VVENfRklG
T19PQ0NVUEFOQ1nCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgMHgxMDQKPiA+ICsKPiA+ICsjZGVm
aW5lIFRFR1JBX1VUQ19JTlRSX1NUQVRVU8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgMHgxMDgKPiA+ICsjZGVmaW5lIFRFR1JBX1VUQ19JTlRSX1NFVMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAweDEwYwo+ID4gKyNkZWZpbmUgVEVHUkFf
VVRDX0lOVFJfTUFTS8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgMHgxMTAKPiA+
ICsjZGVmaW5lIFRFR1JBX1VUQ19JTlRSX0NMRUFSwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgMHgxMTQKPiA+ICsjZGVmaW5lIFRFR1JBX1VUQ19JTlRSX0VNUFRZwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgQklUKDApCj4gPiArI2RlZmluZSBURUdSQV9VVENfSU5UUl9G
VUxMwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBCSVQoMSkKPiA+ICsjZGVmaW5l
IFRFR1JBX1VUQ19JTlRSX1JFUcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBC
SVQoMikKPiA+ICsjZGVmaW5lIFRFR1JBX1VUQ19JTlRSX09WRVJGTE9XwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEJJVCgzKQo+ID4gKyNkZWZpbmUgVEVHUkFfVVRD
X0lOVFJfVElNRU9VVMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IEJJVCg0KQo+IAo+IC4uLgo+IAo+ID4gKyNpZiBJU19FTkFCTEVEKENPTkZJR19TRVJJQUxfVEVH
UkFfVVRDX0NPTlNPTEUpCj4gPiArI2RlZmluZSBURUdSQV9VVENfREVGQVVMVF9GSUZPX1RIUkVT
SE9MRMKgwqDCoMKgIDB4NAo+IAo+IEhtbS4uLiBJcyB0aGlzIGEgcmVnaXN0ZXIgb2Zmc2V0PyBJ
ZiBub3QsIHdoeSBpdCdzIGluIGEgaGV4YWRlY2ltYWwKPiBmb3JtYXQ/Cj4gCgpUaGlzIGlzIG5v
dCBhIHJlZ2lzdGVyIG9mZnNldC4gSSB3aWxsIHVzZSBhIGRlY2ltYWwgdmFsdWUgaGVyZS4KCj4g
PiArI2RlZmluZSBURUdSQV9VVENfRUFSTFlDT05fTUFYX0JVUlNUX1NJWkXCoMKgwqAgMTI4Cj4g
Cj4gLi4uCj4gCj4gPiArc3RhdGljIGludCB0ZWdyYV91dGNfcHJvYmUoc3RydWN0IHBsYXRmb3Jt
X2RldmljZSAqcGRldikKPiA+ICt7Cj4gPiArwqDCoMKgwqAgY29uc3QgdW5zaWduZWQgaW50ICpz
b2NfZmlmb3NpemU7Cj4gPiArwqDCoMKgwqAgc3RydWN0IGRldmljZSAqZGV2ID0gJnBkZXYtPmRl
djsKPiA+ICvCoMKgwqDCoCBzdHJ1Y3QgdGVncmFfdXRjX3BvcnQgKnR1cDsKPiA+ICvCoMKgwqDC
oCBpbnQgcmV0Owo+ID4gKwo+ID4gK8KgwqDCoMKgIHR1cCA9IGRldm1fa3phbGxvYygmcGRldi0+
ZGV2LCBzaXplb2YoKnR1cCksIEdGUF9LRVJORUwpOwo+IAo+IFVzZSBkZXY/CgpUaGFua3MgZm9y
IGNhdGNoaW5nIHRoaXMsIHRoaXMgc2hvdWxkJ3ZlIGJlZW4gZG9uZSBiZWZvcmUuIEkgd2lsbAp1
cGRhdGUgdGhpcy4KCj4gCj4gPiArwqDCoMKgwqAgaWYgKCF0dXApCj4gPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHJldHVybiAtRU5PTUVNOwo+ID4gKwo+ID4gK8KgwqDCoMKgIHJldCA9IGRl
dmljZV9wcm9wZXJ0eV9yZWFkX3UzMihkZXYsICJ0eC10aHJlc2hvbGQiLCAmdHVwLQo+ID4gPnR4
X3RocmVzaG9sZCk7Cj4gPiArwqDCoMKgwqAgaWYgKHJldCkKPiA+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgcmV0dXJuIGRldl9lcnJfcHJvYmUoZGV2LCByZXQsICJtaXNzaW5nICVzCj4gPiBw
cm9wZXJ0eVxuIiwgInR4LXRocmVzaG9sZCIpOwo+ID4gKwo+ID4gK8KgwqDCoMKgIHJldCA9IGRl
dmljZV9wcm9wZXJ0eV9yZWFkX3UzMihkZXYsICJyeC10aHJlc2hvbGQiLCAmdHVwLQo+ID4gPnJ4
X3RocmVzaG9sZCk7Cj4gPiArwqDCoMKgwqAgaWYgKHJldCkKPiA+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgcmV0dXJuIGRldl9lcnJfcHJvYmUoZGV2LCByZXQsICJtaXNzaW5nICVzCj4gPiBw
cm9wZXJ0eVxuIiwgInJ4LXRocmVzaG9sZCIpOwo+ID4gKwo+ID4gK8KgwqDCoMKgIHNvY19maWZv
c2l6ZSA9IGRldmljZV9nZXRfbWF0Y2hfZGF0YSgmcGRldi0+ZGV2KTsKPiA+ICvCoMKgwqDCoMKg
CgpUaGlzIG5lZWRzIHVwZGF0ZSBhcyB3ZWxsLgoKPiA+IHR1cC0+Zmlmb3NpemUgPSAqc29jX2Zp
Zm9zaXplOwo+ID4gKwo+ID4gK8KgwqDCoMKgIHR1cC0+dHhfYmFzZSA9IGRldm1fcGxhdGZvcm1f
aW9yZW1hcF9yZXNvdXJjZV9ieW5hbWUocGRldiwKPiA+ICJ0eCIpOwo+ID4gK8KgwqDCoMKgIGlm
IChJU19FUlIodHVwLT50eF9iYXNlKSkKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0
dXJuIFBUUl9FUlIodHVwLT50eF9iYXNlKTsKPiA+ICsKPiA+ICvCoMKgwqDCoCB0dXAtPnJ4X2Jh
c2UgPSBkZXZtX3BsYXRmb3JtX2lvcmVtYXBfcmVzb3VyY2VfYnluYW1lKHBkZXYsCj4gPiAicngi
KTsKPiA+ICvCoMKgwqDCoCBpZiAoSVNfRVJSKHR1cC0+cnhfYmFzZSkpCj4gPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHJldHVybiBQVFJfRVJSKHR1cC0+cnhfYmFzZSk7Cj4gCj4gPiArwqDC
oMKgwqAgcmV0ID0gdGVncmFfdXRjX3NldHVwX3BvcnQoJnBkZXYtPmRldiwgdHVwKTsKPiAKPiBE
aXR0by4KCkFjay4KCj4gCj4gPiArwqDCoMKgwqAgaWYgKHJldCkKPiA+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgZGV2X2Vycl9wcm9iZShkZXYsIHJldCwgImZhaWxlZCB0byBzZXR1cCB1YXJ0
Cj4gPiBwb3J0XG4iKTsKPiA+ICsKPiA+ICvCoMKgwqDCoCBwbGF0Zm9ybV9zZXRfZHJ2ZGF0YShw
ZGV2LCB0dXApOwo+ID4gKwo+ID4gK8KgwqDCoMKgIHJldHVybiB0ZWdyYV91dGNfcmVnaXN0ZXJf
cG9ydCh0dXApOwo+ID4gK30KPiAKPiAuLi4KPiAKPiBXaXRoIHRoZSBhYm92ZSBiZWluZyBhZGRy
ZXNzZWQsIEZXSVcsCj4gUmV2aWV3ZWQtYnk6IEFuZHkgU2hldmNoZW5rbyA8YW5kcml5LnNoZXZj
aGVua29AbGludXguaW50ZWwuY29tPgo+IAo+IC0tCj4gV2l0aCBCZXN0IFJlZ2FyZHMsCj4gQW5k
eSBTaGV2Y2hlbmtvCj4gCj4gCgpUaGFua3MgJiBSZWdhcmRzLApLYXJ0aWsK
