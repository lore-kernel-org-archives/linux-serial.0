Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11023110.outbound.protection.outlook.com [40.107.159.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5413F483BF9;
	Mon,  5 Oct 2026 13:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791207441; cv=fail; b=DPS/ak7bW6iGmyMu28GTkj7Ohs8wBcBErGZGD8FsgTUc6Khld5naF6Y7vcSnGffRc9IeEJOO+kvnmiCdjVu7v204f0QVT95a7iYTvKRFLW7b81JnS4zXMZV8sdCMEUOg2ekNxj7RuAjJMtGhCcr008wDCKzfOe3eetLBD/V26hw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791207441; c=relaxed/simple;
	bh=ZI/Hjp071WGRUlnEWvQpedbCLv5PP0LZQ3KZiFnfaLI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hX1EBtd4kqFUruDjQyyU5Y4foMgIAMoWM2piE/a+oOY0jZSoS8+rfnf3WelkjwkZfJIoT9tDr0wWa19s/Y29juIf3De4EteaKNvLI7brwScXHtur9+URNKSz2rxw6D4/nmVCzWqEddoqvVoeS8F/Y8j2/ru+6Nrf3vRM4oRSifM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=ESSAVcGI; arc=fail smtp.client-ip=40.107.159.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="ESSAVcGI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YK2DohMKRu7MvaYR2mnkQGLbpesYiPcDSOnqltkX8iO2Lc4hDkD6n8mxw2Xwhqt27NFXTOPNVeVjk/uirxZdrBgkeww4rm9L3Uazykpr0Q0SZgV8aDSf9cJdcR6ZkfJ6+vb+/EYDOqDwkugXtLZX1IlFuZqsY4XZ8FeZEj+PAXS87EroY9ISWcxcgxmOq4As6spHAoCvK53BziXGibsnQto9KCWO3m8rhbp6jg6iNsouhLVa4fNImhhhJqzbnns4Mx9xTRe2dsN43qwmA6JpFqBlMTjfHMEyqpY6uxgy0j4P7xZFnCQOpw5Ws/u6spBaE662BLn38DfuuBOF/fiC5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mj9JL6gWWWw3iI1RaBy4ff5GRF9XfC9qVSjKj/4fRJA=;
 b=YaPFQVOUDi46xhORgJ9aEJjrEBWxQUCJMwuY05ZpBRIzaPZhD3bC8finUJU8Q9LnBxjVz5aZolgMAmA2ttanVx9rf6uaeat4SKYIMU+H3+v/Mk6Zc6Auf5HK1zfVqMQR+hTah+os0d0gUmERyD/mxfzacV+I74wMQZ0MxfTPMo/9FcroM28YluS8dZgcglwm+475sayreJCfvJjRmxs5DQk0JVqv4u4mg18t8L7sXRTIKx3dk+9l11deS7hu3l88DfStB+tF4a0sBs7Q/lAaQvW74Bb+XhtzS5Qc6aVkgzZJ/8ORpLiGxbvS9vEUxANR0ZKWEhBX97A1lYS7yi9foQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mj9JL6gWWWw3iI1RaBy4ff5GRF9XfC9qVSjKj/4fRJA=;
 b=ESSAVcGIvq2/OuKSIqcQ/yXeU8xY2ZFq7/cU/yeivZNfKhNo0rx0/q2tsskr1XRu4vS1gUvp2Xr1MNE8WS1MfBiTwu4rZfjGn/wTd/ddUeMVR214qoBLDJeEvYrgaIF2ayos7Ytzpu01lG7xC9aSDp7b8eVug3Msqyptigqri+clmwfgFpPz3IPIf2J6mId8sLKAfxYzLszANasWMtGmyM1Kh8mCPM8kG6wyQS+p8q7YZGlmSIfys1p6jxSOTSwE+T4aIT+GeIH0y1KlqAGi4lrHhj3ddKSpjPtxaCqttNDQ1WVgrZOzPrOXXbRsE7uf4fkZ6FJ3rSEfkXkETqKteA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AM9PR06MB7907.eurprd06.prod.outlook.com (2603:10a6:20b:3a6::23)
 by MI9PR06MB104049.eurprd06.prod.outlook.com (2603:10a6:290:af::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Mon, 5 Oct
 2026 13:37:15 +0000
Received: from AM9PR06MB7907.eurprd06.prod.outlook.com
 ([fe80::a597:33a7:d4e2:1b17]) by AM9PR06MB7907.eurprd06.prod.outlook.com
 ([fe80::a597:33a7:d4e2:1b17%4]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 13:37:15 +0000
Message-ID: <c888653f-9b37-4479-8f9a-503dd9cdeff1@vaisala.com>
Date: Mon, 5 Oct 2026 16:37:13 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/9] (no cover subject)
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 Tapio Reijonen <tapio.reijonen@kolumbus.fi>,
 Maarten Brock <Maarten.Brock@sttls.nl>
References: <20261005-max310x-rs485-sw-delay-v7-0-6ae392eca08c@vaisala.com>
Content-Language: en-US
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
In-Reply-To: <20261005-max310x-rs485-sw-delay-v7-0-6ae392eca08c@vaisala.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: OL1P279CA0056.NORP279.PROD.OUTLOOK.COM
 (2603:10a6:e10:15::7) To AM9PR06MB7907.eurprd06.prod.outlook.com
 (2603:10a6:20b:3a6::23)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR06MB7907:EE_|MI9PR06MB104049:EE_
X-MS-Office365-Filtering-Correlation-Id: aa74a4a8-9ee7-44c3-5c23-08df22e5c48a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|22082099003|18002099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	gUEdftz3Opo+QM9JMyaRSxEuQoo0IZsm8UOrGuOyzxPJKcuX6gjl+3nc1O8POgdwbfr5vsT8KH74hREb34NY1o6MN+x5kSs7urADmRZpfePvdrp9QvKmeEc9Ok80LQVnbkXNNbkJizq9OqceSXROc5/VrsYQRWbLWz+z8ey9wRDjTAaiDXF6Iw9WCqZojcA4K4QPD0onzHY03z25VBfNX6MlvogHy6VnqBMSF818mlc9QwIYF61mKtK3RP42OuJTTHPi97HQxor3qnKDv7x65TZ2xwu0QXnL3lNz9/qiDw6dcWRfMtSsQfFqIQxG4FHFLk+EbvT6+d1aibSOgsht0tBS4XwgtOLm5cqmcD9y3kKqCUOtkO8H5dcZGJd4edzvWkPm6iWUSGSdB9hE2OKxGoQ9lVHy88OHV4c4xEyug7g6LQ8zqYbZ1602EmjbmQD4BrnIHEctuw/mnwoJ+FtHOiQKnXT2ShLXqkmkknKeT445Xi8EOpKT7Dc+TbxSKTuw6BUYyw1Su5rFje3d+/NSgp7tmt7GA/VcW/HnjpMsXeXxXPjD0v5Zl2YXLINNQyr2imkayrTNFrVoj5zrXrXt5f60VhZ2jq+Nrw+TU7SyScCf6cLpedwLBYjd/+P6CumzGpvAMXL2BYu8Ie5MQ++1wQrpReRTgvGnQ25QpWOZNSE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR06MB7907.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SSsrVmdXdkxFcUNUUkQ4V0UzdHlrb2VuTjNySEtTWXJuclJNckR2dERqVGxa?=
 =?utf-8?B?UllHZVR0eHUrZkVWdGR1WG92Z0RodVV5WTBtbm5yQSs3UlVQcW56NVZiaHJD?=
 =?utf-8?B?MkV5T3YxaGFVTW1pcE1ELzNLV2oxQVl1N3dacThDSURDSitCZHg2TUhmMjgr?=
 =?utf-8?B?WllBS1RsUFVET3lwSmtleS9VbTFYaENScTR1M2lkUGhhQWFQcThoMWlXWEdz?=
 =?utf-8?B?YXNCM25CN1ZNbjF1UTFSd1dXNm5teU0wL0oyK2lWNkdkbkZjblA0WW1JS29O?=
 =?utf-8?B?MVQ4LzZyWnF0Yk5aQldNS2pHRG5JaXU2N0xXY1EwaEMwYjBrY1VQZmxUUlUr?=
 =?utf-8?B?WktNbkVRK0dNMlBvSDdMZEs0WVhzQ3Y5anQ5RzhoYmlGUjdEaXRKVWcwSWE1?=
 =?utf-8?B?RlE3V2NJenErdXZJMXNXb2RwTkJZeUdKaUI1Z1g0UDNJQ2h2MlBaRllrdjZ5?=
 =?utf-8?B?ZkYrQjg3UnF3aDk5ckNiVlBLRll0SENDZEdlQm91R2drbEtkdWlMQ3pIY0NN?=
 =?utf-8?B?Z2F0M2RNc1JZRFJSVmYvTkRLRGRrbjZBSDV3dHgwTUJ3ZjJ0MEQ0bDZlQnFN?=
 =?utf-8?B?QzJUZTFsTXIyM0w0QWVJTUg1aVJvaDB0cG5Mb21GYzlkN01sbnlsdGY3YmZw?=
 =?utf-8?B?YmptTUtVc2lYdUMza2FqR0lkdmlWRDE4N3FxMVRCWkNtMXlyYllaWlZoamRE?=
 =?utf-8?B?VVo0Ri9QeWcxQmtlYlYzUUlKM0QyeG1IZ3NFRkYyWjdrcjRsZkp3eWhpYUFO?=
 =?utf-8?B?dWY0RG5pcTBYUmowcUtackd4L2VYenNjR2dlNUFFZ1JlRXh1VlZXRVR1WDBX?=
 =?utf-8?B?dWI5QW9NSlQ4T0RPVHUvaFlleW1qdkRHNW91VzFNelFVNXpKSSs1VmtENEdp?=
 =?utf-8?B?bCtwTFNMU3ExOXZiZENVb0o4aWQwT00wNXVnT3YvR3U1S0p0dlRqTmNSUXRC?=
 =?utf-8?B?NGxPNC9DMjFxQm52WEVnUUk5NHl6aG03aEZDTXh0OS9ONDNJYlM4emV1VWU0?=
 =?utf-8?B?RUs3dzVFcmJycjlOdElzUDM1cHFHZTdOUzFZUUh5aXFNVVZJN3pIblV1ZThK?=
 =?utf-8?B?Zlh2TFhYQ3BwbERPR1lSWWFjVWIxNm1aSVY0cnRRVjFrSm9pWUJKWkN2cFRX?=
 =?utf-8?B?cWdCaEZhcTczQi8xODd0SlFWd3ZGU211cHo4SHl2eHdvR2g1MlBHc3FSNllr?=
 =?utf-8?B?L0VvUVprYXB6dVpIaE45TVRyQWt0bkpSc25WdTMxY0JnNzMzdkhFOFZ1aXpi?=
 =?utf-8?B?dGl5WXdwczRBMGVmZzBpbmRxV2NoT2FDeUFBbkpRRVVhSG5PdmE1SEx6aGpj?=
 =?utf-8?B?TXNWWmFQaFFUSnhyemRjamZLREI1YzR4Q2Z0S2c3NnpleWhkKzcvYUc2ZDlO?=
 =?utf-8?B?UktQZkRvd2VtSEhDS05KSVoyaTBDSG94WnJUSyt6b1dqVW4wYlQ4QXJKWjhW?=
 =?utf-8?B?MTd6RGI1cElETWNNcThNVkRaY0l5UFg1S3BqMzIrVHBkTFZ2YkZhZFRzWkpw?=
 =?utf-8?B?Y0YrQ2I3UExJRVR2U1hpZituRGJiUFVSUklSK3NDcmozaEVXTlBEV3dkckNk?=
 =?utf-8?B?d1RVT0Y0RkROdUQ2R01KbEJ5dG10ZnExbFp4cFVXWUY4VkYvTG9KZjVwaVFN?=
 =?utf-8?B?TXNLY1QrWVhUYm9UU3lGOEVzRE5nRFY5dU9CeGFtTXB0U0htN2pEdGYydXpD?=
 =?utf-8?B?UFRwUUR0VnEvdEh1dzFSYUZVc0JodXFaZHBYclFUSEQydGV4cS83NDhVT2RR?=
 =?utf-8?B?UzhCYWE1ZEZwL3JuckFMM2c4TmFtRlRQTFRSZUNMM1k4OW1HYjJBbDZCNEpT?=
 =?utf-8?B?T0REMU14cVl2ZTNvdjllS3BZSVVvNVNZcm9qZVEwV0R5dkpldFVDR3c1YXQ4?=
 =?utf-8?B?SVVMM3RjYWU3QTJWbkRoOTVia0dXb2U1QlZBZFNsOGQxK2pqT1d6TDhaeWcy?=
 =?utf-8?B?d2RqZ2x5ZWhVRm1Qd0JpZWN0dEpCRUhodzNKL0tkelZPN1I0N0JMTTk1WjZp?=
 =?utf-8?B?V3FqY0hUR0F6OU13Ujl4VGZ0L2FBTG9MSjRIQVNIekJ4V1lPZUl3ZnZ1MGEr?=
 =?utf-8?B?bWwwYnk1N0YxSUdSVUt2RHNkZjN2Nk1jVmh6K3hidUJHOStYTXZpZ2I1alRj?=
 =?utf-8?B?c3I3RHJvTFRrRVUxQkg1VFQ2bm1WVXRFV1hHOFY4WnNHSXk5N3J4UWFlRm5S?=
 =?utf-8?B?NVpIUC9pY1lZWEtoRU1wa0traDBMSzBOS3o3V3Q5SVdmRENxZmhjaE5Bd21B?=
 =?utf-8?B?RlI3QjFDajhGblA3YklLeCtWSWx6NDY5eWU1QmRqYjdjYi9vanUzSFNmLzF6?=
 =?utf-8?B?QkVLb2V4cGJzR0piV3E1K1ZIREczOXBSTGxieDV3Ti83eGZsZTlIZkk3bUR4?=
 =?utf-8?Q?Ne00OMx4xNvm2uAo=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa74a4a8-9ee7-44c3-5c23-08df22e5c48a
X-MS-Exchange-CrossTenant-AuthSource: AM9PR06MB7907.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 13:37:15.1825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6weD4QtknGSceutMhsvby4dDX9gRBcOSrXl/Sgzw5nKxdoBnilCFhjfsDapFwzCpqLNA6iSTeTY0rYSQXgSu4Hw7Ki0ROOJZUOWogZJqxhE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI9PR06MB104049

The cover subject fell victim to my cover-letter tooling; this series
is

  serial: max310x: RS485 delay and RTS fixes, software-timed delays

The cover text itself is complete - the series description and the v7
changelog are all there. Sorry for the noise.

Also +Cc Maarten Brock, who commented on patch 5 of v6: the first v7
changelog entry describes the rework that replaced the drain loop.

Tapio
