Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11020102.outbound.protection.outlook.com [52.101.85.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AFC399892;
	Tue, 21 Jul 2026 02:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784601481; cv=fail; b=ozEhm7GU1mHtYhwR5uTpvV2Sfi/m04gV+p6Hzg0XHEDhtc9diA12CfQCTwGrMEGoapkyzKyYYlNwpChv1qbHRhMwLYezCx3CDyeSjPm0oIhOGvEPhqeuwMWZTUn43lz8EmmjLnzB3rQqyvWzdoMRXkRUscKi660+a/UEkkBgJak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784601481; c=relaxed/simple;
	bh=ySIXdPdhME2HlNOfC00RoONp3xUI333VTobZPsvO+RI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ig7Wx63VySE0w3y2YhyBJgxD1/OkPawXIEczsHjk4yh6JoO0Q3yuTQra16D7ofTsg5DxTrzDNqRpJYQy33atOGBiNSjb14f+rN1lKuUD/gSSmrsJLw+FROAwLHUO+abdddwRzl4yil0lLRgMONv6gQyisLsYAqJ35pQ9t+ftT2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com; spf=pass smtp.mailfrom=axiado.com; dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b=RJAe26gj; arc=fail smtp.client-ip=52.101.85.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axiado.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b="RJAe26gj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rkyvhp4aodVNbV3+1zMCeVbqgYQWo095Ddgo44f++RuaDgmLTmD4BJ++of/NEFMawrU4jTakkxd5Jgb3KiIj/MND6/VUo0atB8Y4HI1gYKY0MYRFpruz1QpI1VEYeC6UdhRvPuyVWbhkags8EsjPY/cH1tvk98yWGl/f6OhZM5m63+jsQzx2icFpK02A+lEMiF+qAzPbkuFggaNXkB8yTTnn1MC7toe9rrfGHJDgUIKlJuWbRlOmOu77H/kvn8jAuppPXyRgrI77pnR2BojilA468PxIJiQZteFZCNhyLmlluBKvzXPff5VKhcCcImPIGwX5tjDfuKKqaO98lAfdFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ySIXdPdhME2HlNOfC00RoONp3xUI333VTobZPsvO+RI=;
 b=yM1Chp0cP9QuQYb/76eejZHknp9SGHJxQUk7PM8Tjab1pOM2c4mvYLGTCuWDu+pt2aJ/gAPPJJT+XavgMRrG2wUSseRIXxz4P1WW1Eskg2V5e81mODrCC+WaRoFJy6MgjTXHbiTwyh9X5WBWaA1A1L55RzYxecratOU6oNtuInSNzo2bFttvmP3w9y7yHa5G+I6ywVRXQAHp7cnuI2KQaWqMzRZ7ISvc9Sm56QyB4liPucocA9aNpD35p99PtON5GyIYlgNBV13heHQCPalUoRxlaE08jme/hLSUgxF6TOGU5tWE/IWE+6N39iwUrKb9vqAiyyKgezTd/GAxWVD0Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axiado.com; dmarc=pass action=none header.from=axiado.com;
 dkim=pass header.d=axiado.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ySIXdPdhME2HlNOfC00RoONp3xUI333VTobZPsvO+RI=;
 b=RJAe26gjjN4s4jkJIMXSU2aqtvku44d2rFcujJ0+SiN8X5HyG3PAHgAox/W90DflB1zxK82vyimpoiYTu+bICVehmkIGFr2GJxSxXKyi4Tn/gaAqLyjiob2AP73XiHP27/pF1jcXM4bqoDTV9HvPpjpiCwFgl7JLDUVU+Vvnr8RSnkDb20jpAqDZsLpxPvzOmElimZIi1zaHvMdyc93YkmtZcFo7viMMXrfn+3kufPO31d8XjnE8u5Iq2+17YEM+gcJOIRH8d8y1Pc+y1y8cHvNqWrWOeXLmuQEqa1p3ntFJw2nFdvVOww9Ho1C38adlT8DBM5xHYXW9Engfo5Tzbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received: from BL1PPF1B62FD55C.namprd18.prod.outlook.com
 (2603:10b6:20f:fc04::d8c) by MW3PR18MB3628.namprd18.prod.outlook.com
 (2603:10b6:303:55::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 02:37:56 +0000
Received: from BL1PPF1B62FD55C.namprd18.prod.outlook.com
 ([fe80::8726:2e55:848b:39e]) by BL1PPF1B62FD55C.namprd18.prod.outlook.com
 ([fe80::8726:2e55:848b:39e%5]) with mapi id 15.21.0245.009; Tue, 21 Jul 2026
 02:37:56 +0000
Message-ID: <4f2bfd4a-e696-4a53-9380-eb225e53338a@axiado.com>
Date: Tue, 21 Jul 2026 10:37:48 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/8] dt-bindings: spi: dw-apb-ssi: add Axiado AX3005
 SPI variant
To: Mark Brown <broonie@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Harshit Shah <hshah@axiado.com>,
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
 Jan Kotas <jank@cadence.com>, Michal Simek <michal.simek@amd.com>,
 Andi Shyti <andi.shyti@kernel.org>, =?UTF-8?Q?Przemys=C5=82aw_Gaj?=
 <pgaj@cadence.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Frank Li <Frank.Li@nxp.com>, Boris Brezillon <bbrezillon@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Mathias Nyman <mathias.nyman@intel.com>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-i2c@vger.kernel.org, linux-i3c@lists.infradead.org,
 linux-serial@vger.kernel.org, linux-spi@vger.kernel.org,
 linux-usb@vger.kernel.org
References: <20260716-upstream-axiado-ax3005-upstream-v3-0-c429095143ec@axiado.com>
 <20260716-upstream-axiado-ax3005-upstream-v3-6-c429095143ec@axiado.com>
 <6d69cfd0-5f3b-4324-8d64-b4695cbb3e92@sirena.org.uk>
Content-Language: en-US
From: Swark Yang <syang@axiado.com>
In-Reply-To: <6d69cfd0-5f3b-4324-8d64-b4695cbb3e92@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TP0P295CA0047.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:3::13) To BL1PPF1B62FD55C.namprd18.prod.outlook.com
 (2603:10b6:20f:fc04::d8c)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PPF1B62FD55C:EE_|MW3PR18MB3628:EE_
X-MS-Office365-Filtering-Correlation-Id: d6a58521-ec1c-48fc-b595-08dee6d11240
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|7416014|376014|1800799024|56012099006|4143699003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	w6hRFJc0nmQSFEbeaSvFlUhhYwsraoOmit/rYZw0S1Z+OEsvg7t+/LJPjAk042vtOU4uoYeNATyORr8PseK6jvLvtAWjpaJKh3kvPNeCXS2SvvhRYU3HDABKbPSDQqkr+kpUx7O6VvDkqZ12OEe7+s6tXJdzqQbmx037TysGZUJpsl3lSij6h4WvSrqaBpNKCasayJKFMGxXtpMCn5oNXeeKDaNl+wYN/aPMw19yQYmlVfb9nhmCgb5H1AfFVZkdhV1pzFD+9WAtzVKmUlBpl25e9FFTtayj/eQAzw10QO1nM86g/Zm4FQHRmfFc9v5FYWhGQ90z3lJsF/vxk6WRdawXjsq9jUy6bx7EhZmidFccoBi4XRuF6mgzBo2QtWKY53fUlZuid7ogHZUIRmkhRk2C9YIr7MA20M8oOq/z8zlehMvXihctMWRFepQrFfn7D/PNkMLGqiSvWIoULk59j/s8DVmsm5vD6SDaV9oHk8zIvtJOAiJ30eQV+/R53DjTzR53dVWOI6o7Z4+OxNt1FWnX2891zhUqAUFwJTUHhOZLLJLZjGaKVQ5UBCvS++F9BbRjsaMvPfdTT3zeVxzNJIzz33HP+RzFjRp2c8kZItgOJuLTm6zZQsAzCXrdQA/Ygy+1IPYAG5lcmJcZPDVeNV5IpvT+gdy0F+xN8/Do/7s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PPF1B62FD55C.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(376014)(1800799024)(56012099006)(4143699003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a0xsUnp0cnUxa0llQzRZdXViTThpNThBVGpYMCsvNUltZGJvUmZZcFo5WXlW?=
 =?utf-8?B?c2I1S3Y3TWlFTUx1OGxZcHlWRG5YU05rVWRJR25NbU1HYWpBUE4vWi9tSEdl?=
 =?utf-8?B?Q1FFUDUwU2hCaEdOY0VUaS9NSkZIYnQ4Y3BoTENYd3J4OEw2UWpxazVVNkdU?=
 =?utf-8?B?Skh0V2pZdjJuWW01bFRnZmpHRFFXazZtdTFnQjdDWXVCTEdjN1RScitHdDMz?=
 =?utf-8?B?MnhTVDZkYXdWM2ptRlRueUtOWStYendMaTNhaStUNmkvbkpQQ0djL2VxbEow?=
 =?utf-8?B?ci9xUjh0RmNRRnlCYlo1djg5RVVxRWR6b1FIbkRVNllLd1c2bGdSa084ZXNz?=
 =?utf-8?B?M0xKNTN1amplUVB0bkJBaUk0Wi8wWDBzK3FKSysvVVhUbXpuNXlzR0d4Q0w5?=
 =?utf-8?B?cEZjczc2MzQySitPZWpNY2dVbzJ1M2xzeDV2aXBDZnpVenhBajVFdEM4eXZw?=
 =?utf-8?B?RlVuaGhWTmlRS3NvSzBRS2lBNS9PNU4zelNycmd4TUlZbG5VN1ExSWs5MmdB?=
 =?utf-8?B?REhSV2JPTHZjYXRQN0tGNVJ1YW40Q2luWVJmcTRqVS9NU3YzU3puQ2FtR055?=
 =?utf-8?B?S2Z2SkRaeHZRMHZkT1BlR2loY2RlQkFZZ2FLR2lTcnkvclJIRncrTGJYMVZ4?=
 =?utf-8?B?eURKK3JEYTlvRlFBbG05ekFSM0gwTll4T2kyRmc5OWlqclJlU1VKcUs3QW1V?=
 =?utf-8?B?NlRPZFlJdncxVzh5M1ZmazBGdUgvaE9DMVgrcEJTU1JvQXZibGRjamllQ3RJ?=
 =?utf-8?B?WldwRnRidG9OZWpGanQzZ0lXY1FoVFJBbGZURVdIN3JBY1hoUFcyOUtzRW13?=
 =?utf-8?B?OGZwRVVFaEFPUHF6K3NRUWFDN1NIeC9lZXY4MlpIZXdFSE1MbnloZVI1VVJv?=
 =?utf-8?B?cnRaZG1kNDZpbFBKV29HYnFrWkdFZ0xLUVNRRkUrZ2JTaFUvTzBEaWs4ay9k?=
 =?utf-8?B?WkV3bWkwYUQvamJ1R2h6eUV0VjQxUGhzejI4amh3S0N3S3BieWp1QytkV1JR?=
 =?utf-8?B?bDBRTTdCc0JTNFRicWFXNTRrd052TnRPRU1pL2EydWovRU1pdXgzWTZMcWxw?=
 =?utf-8?B?LzFFdVh5SmVpSFM5dytoeGhzRmlNZnl3cWZXSitkVys3RDNFT3NVK0pnblNX?=
 =?utf-8?B?ZlBmTXAxR1F4VDF1Vzh0Z2h3aS9Ua3h0SWZ4ZE9GZ1g3NXE4eW5lZ2FMT2xP?=
 =?utf-8?B?MGllK2lFalpQTGVvVzRrMDlEOEU5Mks5bTBiWmRlNDkwVk9PeGg5TndpSXdr?=
 =?utf-8?B?b256VHJQZDZYZ0JLUUM0NlZjSFZNT3JlRDdGS1ZxWjYvazJyUkJNckZnR1FQ?=
 =?utf-8?B?d2RHWFdVdWllTzA1dXQ5M1ExcjFhdS9yRjBiQzJPVFBOSVlNOFp0anU0bXFM?=
 =?utf-8?B?bkhYVEdPY09PZHJRbGdheERtTjRGWGt3czZZM0lKYkQyb2RjcHlKTWhhTDdz?=
 =?utf-8?B?YTdmT2dGSER6WWpibFdlUTROY2dZUk5jRDZrTUhmVkh5VUpSUGs4dUQrVERK?=
 =?utf-8?B?WTJWZjg3bFAxMlovU1o1RGZpQjRWVDFaemhtLzVQU2F5VWhxNUk2dFRkYW4r?=
 =?utf-8?B?dUF0cW1sczNONVh4Ulg3YnhuZnNmeWdTc3hwT1JyWnlHbEx5eDBZblhMN2VJ?=
 =?utf-8?B?VENOQVhTdmZqSkNsZUE3SmJaY1dUUzZHRWFtdXZaRTQ0a2k1ZFhIcWllN1hX?=
 =?utf-8?B?c0c2bC9qT1A2WjN4STR0R2t4dFpxTmlXaFJsWnBoY0JYRE5qb1pHS2tzZmFy?=
 =?utf-8?B?UFJXSGYxeTJqdDNGajR1WjFxTzFHT0tkeVo5M3E2QTJ2N3YxT0NoYVAxQmI3?=
 =?utf-8?B?L0FoclNxREh4OCtZNG1RUUM5UUd3Y3p6RXE3R3g4Sk9SMk82K3hlSGY5UCs3?=
 =?utf-8?B?Y2lzekViajlBTjZuc0p3aUVnYllTTDRTWkNlNkFKWGR6QmdOc0U0U2pzM042?=
 =?utf-8?B?OURFOCs5RXJDclUwMmxzanR4MHhtNzFhOXdOMEh5KzgxZFIzbjFTc1JTSE9P?=
 =?utf-8?B?YWNMZm45VE1NL25JQzJRMnlwYzBoZXdDSVFoWUNqL2QvQzlpR1NlQ3BaaGV4?=
 =?utf-8?B?VEF3UjlPb20zcWdjSEhkODZRRW5CMnI3TzZUNmx2VXduU3o3ZGhmR2FKNUNV?=
 =?utf-8?B?Q3RtajBXSUpUdGxEYTR1SUtWU3NHL1F0bmpPUm8wWWZEcEhNSW1zVW4rZlVZ?=
 =?utf-8?B?NkVraTFjOS9VaHBPSmtaUUpmOG5yL2JBeWYyS2RhQnVJeDlVdWxic3lWWVNV?=
 =?utf-8?B?OHVOd3dtYzMxNWxkRVRmdmF6eEdsOGJnRFRwbm1yd0NoM0ROYjlmTlpoblhl?=
 =?utf-8?B?Y2cwOGVwaWdkUzIwNjA5UldHeTgwSG50bURkY3p6M2FRTlhvT1lvQT09?=
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6a58521-ec1c-48fc-b595-08dee6d11240
X-MS-Exchange-CrossTenant-AuthSource: BL1PPF1B62FD55C.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 02:37:56.6359
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zz69a/mBd8z9UxEoYvxjkC4nSrwB5sD8VfjPFvEmr0BNX46HWYdIilMGBwGCbc1Js6tyRZpPTOQaPx2mATSCLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR18MB3628

On 7/17/2026 8:02 PM, Mark Brown wrote:
> If there is no need for things to be part of a multi-subsystem series
> (eg, dependencies) it's normally better to send each subsystem
> separately.

Hi Mark,

Got it. I will split the series and send the SPI binding separately
in the next iteration.

Quick question on the versioning: should I send the newly split SPI
patch as a fresh v1, or continue with v4 to align with the rest of
the SoC series?

Best Regards,
Swark

