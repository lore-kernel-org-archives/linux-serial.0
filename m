Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023082.outbound.protection.outlook.com [40.107.162.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C5B4BA9FB;
	Thu,  1 Oct 2026 09:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790845859; cv=fail; b=ly88XWfLw6fugs5k470qW94J5klNlJDSNwy84ZISq79K712S6diVXlOZHTzwbAxpxH0MyBCI4z19fMaHGm3bwLpiGDy/nmgz4nYCZ6CO4XYqnjB84q2dxLLerRQsSGyDb59INNbCFkLVkYkArVUPK+HDtcef25EJfJ3aEYN2hC0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790845859; c=relaxed/simple;
	bh=9gJM+UbwzdlOZPVd01MQ1LA82350fDcDXdhHarxBvFM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=R1ECeldJhO16WAJY4M4l9LppX2VHULhpPkUaLoX8NcKlubFdtpyvlCSgiX3/xMDwsr0N/M8wO53Tn2b/87axxnUey8mBXEM/PFu52vv6ys6TQwJfqM0nPvORwClY0CfjYm+BtV1PD59F64F2DoB5Qt+cC4urM0SL4tJft9FhJTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=Ebbn8tfj; arc=fail smtp.client-ip=40.107.162.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="Ebbn8tfj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v/xy3Ydx9zoCnuUch1ZPHgF8dXzJJLnYfVG+J8UWQMmaQOlG4LgaQdoOOGhX2vcLOcQpp1UFIXc0QrE64y3FxoPfRCTl8lDQUH++cjiMH1y6A9GGfaJi+CSx55RwXlWjxQQDBrIc3oCmKDAwuRnntRu7L35oBy3XBi22Mk6DyrSFuxpfE0hDwsaO6vk1417xPAsZSVlyRhJDskvopIVgF9u0P+sYK/cZJecyGy/Uj9ZEaLE1Xx7sZLC6LI23zayaZujgfP9qUnDwEIurekFS62cjh6C9Qnlg3/5CppQWxYpgMf485cTahbnh92ANVqgO+OzTz6BY2jheHlZr7SELAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HKayoB8RTzR8qeN2k7JQ7zpDHCdXHDqEhybRGqM8TJ0=;
 b=j4DB3w0AiSgAvyXSpX239v24igpiLBSGhveb3HKBp13cHZi6/GHPE94PhqAIlzkBSf6PW1OlEfd1zw/nvy0llgsbMDW+CRHgCYCZrIi2/5rKOlj7cq9ZsWD6W2i3+X32wM7ReyjophTj3K92i7JlgHXF8tM9FDPvTntuShusQ0RxEAzue0MyRMMTJUCh3sOxaQVZDpTvPKlolOkYNBfgavpZ5FkyoLOZ9DO/JpncbjAPZoNo7dlsut3qJa7f9sW18Ac25EAu46zM0AjEQtf03ZRuVdBGLHe4KiEf9w0iB1np4ARS6TqDewXvFMkrPiRX+tWKvy5XxJDbyf108YbcbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HKayoB8RTzR8qeN2k7JQ7zpDHCdXHDqEhybRGqM8TJ0=;
 b=Ebbn8tfjvhKbCNGGwIH83LD2D7T8LD2g21yupOEx5gqhkKaSBVEVOSrmi/zmU96HdmmGtMMCGpztSosHAHyMkN9XwshYT5eQKtWQyg+Ac/Q4Cv90sON517pF82Q5KSouuk8HZUxUDBniL6Wut5x8nZyDViCQ/6d8+6QluteMmKxkGzWHaFpwxthWBJwtIK7c1i3buZpQ0vQ7/zgFiXMmKLncVHJ3K8HAhBmWpB2Fjg1wbpMQglTK3sRXZceyImx4q7wI8pJ+vUZhQR56oieTorwQt2e+4NM+1mPu5qLkOmT7Qi5263DBdlU9Mb2HG8naX2k/Civv0YWeFrl6+RUxdA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AS8PR06MB7909.eurprd06.prod.outlook.com (2603:10a6:20b:3c7::20)
 by AS8PR06MB8166.eurprd06.prod.outlook.com (2603:10a6:20b:3d0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Thu, 1 Oct
 2026 09:10:50 +0000
Received: from AS8PR06MB7909.eurprd06.prod.outlook.com
 ([fe80::1c58:5665:1e5e:92ad]) by AS8PR06MB7909.eurprd06.prod.outlook.com
 ([fe80::1c58:5665:1e5e:92ad%4]) with mapi id 15.21.0472.015; Thu, 1 Oct 2026
 09:10:48 +0000
Message-ID: <3e534741-37af-453d-b51f-9a8b42a5c4b0@vaisala.com>
Date: Thu, 1 Oct 2026 12:10:47 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/8] serial: max310x: RS485 delay and RTS fixes,
 software-timed delays
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 Tapio Reijonen <tapio.reijonen@kolumbus.fi>
References: <20260929-max310x-rs485-sw-delay-v5-0-ae46afa583f2@vaisala.com>
 <2026100116-saint-idealize-32cf@gregkh>
Content-Language: en-US
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
In-Reply-To: <2026100116-saint-idealize-32cf@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3PEPF0001DBAE.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::6ee) To AS8PR06MB7909.eurprd06.prod.outlook.com
 (2603:10a6:20b:3c7::20)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR06MB7909:EE_|AS8PR06MB8166:EE_
X-MS-Office365-Filtering-Correlation-Id: 43982ffe-e889-4e72-3ac9-08df1f9be20b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|18002099003|22082099003|4143699003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	J1g0JhCm5oA/EdRg9hONa0UyuNpB3Lwc1CCvfK9E3gofZctJCkpkdnb/Ay9NBQoR7hsEDixumyYNfA5DqKzAtBlCrvnUCLA1luB5ZIRopYZXlytFipOhwIm+7sD15ob9saovitlGAUwQuUdYqsUtlnWVfwZMrBx8xqwv+W4elxZp06GggvpsOcPAJ+HtSM5OZTLhGEWDOnvdRbJGE1VuYKi04bdTAXliYDllchzmTJylY5texcAcx5inWs3j4j9TBw3nPs7KLSE9YGpwK7ifhyTIIlHFcdlp9NwLPuAQ28B7VwrtCLd67L4ufswh6CG3Fw3PiFn3BY0kXAVK5AQVmswBVQuu/1r4Bwq7J3IYGHy5f3+oG2EMP9B9hqtLfb6HznYyZ8XNNQ+TbD+Py9bjbi3bQZozNIxgN30ETCP5yk9HpxSXa+5kc/kuZb7Jy0X8Q7n/o1GGW4Y1e4MK0+buebrQywH0W/nU7rh9WDudjSlEUF7y+vHF1nO22mLcklliGy/U/PZdLVLqaHRAo6dFTNwW1ploauzETsQp2TqIvvLN+M+2hHWtUOEjnzvH53Cv8vJnMvKBu7UeNE/PzQPq4Hpopt8mUxEFp00tlyRy8u3OJgO5POOXLH0Ywg4xEzLi60sTBwkoO3G4kZiy9EHYKx8OfmH6tDkJKiJuwQOg2+o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR06MB7909.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(18002099003)(22082099003)(4143699003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TW1kcEhtTXZKK0MvcFZWTllBcS82NTVTdnRMSEVOZGpDamlUWG81Vm1haFdi?=
 =?utf-8?B?cWNQMUZYZzJvcWdsSXZZbzZLMTJJSmZzVWRRQUpwcUVZUUpaS0ZEbUNmaTJE?=
 =?utf-8?B?dU9OSk9sVFh6MU8ydUdNb0pHaXBCaGlRU1dFa2ZNL2d4TDZZckhjSlBwWFp0?=
 =?utf-8?B?OTRSeHcvams4UlFpZFBBUW1qMGxENFFlVUtDc3N1bENGam5RVVM2MFNlUnZz?=
 =?utf-8?B?VDBONmlDTENwSStseGk0WEJQSkg3M3BYNDkyaDk5eDZpbFhCVldxRVJ2ZU5I?=
 =?utf-8?B?ZHVZTHB2L3E5cjBOM25SbiticFVRWEp2Qk9VOG92TWh4ZllhMG95VU9xSStO?=
 =?utf-8?B?MUp6aGt1K0YvWXF3RlB0M3ptZTROV3ZvT1M0WUZmVXVKZ3duYVJ3SG91MGUy?=
 =?utf-8?B?ODZSZ2FXRDR0anpmbmFIYUJCMlloQUtja0JBTk9VQ2Jxd0treVFMa0FYaXBl?=
 =?utf-8?B?cHRoYzcyNnI2aWlONERNeExwSnlnUkJYZE5sRXNnYkwrY0dTM1ppY0hxSmJ4?=
 =?utf-8?B?ZGJrR3l6RXRrZ05QMFNUYVNRcVo5cjlwZThnMzZGaHB2Rk01VVFtK0E5Q053?=
 =?utf-8?B?TnBTRkpyM1NGSzNHWHZ2dW50QUZhVWkrbXZjc0V0S2hJNmUvZG5PRnVvai9E?=
 =?utf-8?B?UTdiMEQ5VUdselhQT2tkdXdKU3ZlQWxLN2lNdWJlZk9wNVBTQzdpQ2VyQzhJ?=
 =?utf-8?B?K0tUZDNkb01sM1cyeW9HdjAzSlkvS3F6eVBvWmZjVmRhbGRjSEp4eDZMMEkr?=
 =?utf-8?B?RWd0OHJTUjdRKzJHUFVjelpnWUk1d2Q5Q01VR0NOS0x4RnhsSGlMS3dQSGVq?=
 =?utf-8?B?UzVocG5VbGtwQmw5K1NNZnlXTjJwOTdKSWRCUjVHQ3lKdHEwdlNHbXY0Z3dn?=
 =?utf-8?B?VkxJZkRPUU9BU3oyeU5vakdKVnNpallOVGlsQk8wOWx3djV4K29pbFJFRGlX?=
 =?utf-8?B?ZmlFTzNMSEl5ZUFmY2ZsM211VkRhZElRaDNwb3hvN04wOTdSRjBBTjlxQVM1?=
 =?utf-8?B?dGVLMHpGUFRmeWEyVG9kcm1zU3U2NzlXMW5lVWZzVTNLTERWdFJETnZ1cG93?=
 =?utf-8?B?OUVzciszUTQ0cFo5UVo5Q0pwd3IrWWN3L1FzenRZOXNpWVdUODZpNTZXZXFZ?=
 =?utf-8?B?aEJ3RjBiekl3Zk5CaWt6RnhiWG9pWG1vTVhydjNxdFk0bWZtWUJpZDkwRDZC?=
 =?utf-8?B?SEFYejNacmFqSjF0K2w2ZHRXS2hVbkU3amJzSXh3ajlRUC9uZ0cxSFh5Mk9V?=
 =?utf-8?B?ajZ0UGRYeHM1TDdac0ZONnpxY2h1NkRYUkNBWXJZejdzeHdLbXpiMi9MNS9o?=
 =?utf-8?B?bEdVVGNOSTRXTk1hL1grSk5OZU45MkZkOWZDSFh6Y3lLNXVCeXloTGpCODgx?=
 =?utf-8?B?N2ZwUnFSM2hJMHpLNGo1OTFwYkJVRmtNNVZjQloxelNzM1ErS2FsMmIzWEsr?=
 =?utf-8?B?VW9IT3lrQjh1cDN3NEZwOWJhV2lheFNsTHQvaVdEUXZNQW9QVHV3cjIySkJI?=
 =?utf-8?B?alVURHU5YzBpdHFIOUc5RWFUS3hUWXB0Vkdncjl3TUpSNFNaUm53eU1IeHZy?=
 =?utf-8?B?cGFFZHlJZ1VudjlncTEzbEwxQW1US3laTkJkME05MmJzdzBoeTVPNVE3c2xM?=
 =?utf-8?B?cDlkZGszZ1N4QTBvZFprUmJrNzg4bDFtRFdrYXRxUEVOWE1LVC9QK3FjL1pD?=
 =?utf-8?B?djlvYmF3NnlaNkRZMHh5UVJ0amFrZlk3eTdZdHp2M0x1V21IYXFPc3RBVTI0?=
 =?utf-8?B?ZVMrbnV3ODRvWFE0YUxEYk5KMkNHVnRMUXQzMUdQOFVlelhidWRtSkNZbWZW?=
 =?utf-8?B?NUpyemhSY3JYbElTQXZvTHlQL09tQ2FndmYzSE41eXBCaEh5VWFhSDFMZDd2?=
 =?utf-8?B?dzkxczJYN0hkNGpWNGwvdmVEWjFaNW5DVGRaajdtMWdKajNHWm1Oc1lnUHZU?=
 =?utf-8?B?eHdwY2NBOW52Q2NEWms5WnBxVVZxajExcjRCRFVrMDU2UkovaS9FdjFwWmwx?=
 =?utf-8?B?UmNoaGcwdWMxOVhyeWltbmxJWUlCYlphUXBYb2QyZFc0SW85YnhCOVJZWGw1?=
 =?utf-8?B?K0xnbVpYNVpMSlNKbEhUSkFuNk9hcDlBTFg0ZDJCcnZNcTZ2cngrRGtxSFAw?=
 =?utf-8?B?M3o1VDBLTVZLdzhDUDRSWWNtcHA2ODRpUGZPSlEvbWk4TDRTZGx5TGJjUGhw?=
 =?utf-8?B?ODh3OUNkeXNTb00rNEpTT1Y4blU5ZFEwYTV1QkYwVHJZRXNpYmRHNXB2dFd6?=
 =?utf-8?B?ckVHSlpKbjF0UlVHZnAzTlMrTDhwRzFranlyZHBwZlRhRFg3RDFHL09EUDJS?=
 =?utf-8?B?MWhFaG1yQ0JPRHdmMm1MOVgwM1Ird2pBeEdVeUx2UDJPaHJnb3djQTJCaWxS?=
 =?utf-8?Q?PRzc6e3rfN7dmcWo=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43982ffe-e889-4e72-3ac9-08df1f9be20b
X-MS-Exchange-CrossTenant-AuthSource: AS8PR06MB7909.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 09:10:48.4619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RgonW9ZZl7EIkR4ZJpQ9k40j2Uu+3rPyWI1WdqRcc+ioulGET/ONC01HiZ2PBnkbJxRnDaTEIRCFMy7+jtl8441CzGwcWBtGccRQlAIdh60=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR06MB8166



On 10/1/26 11:35, Greg Kroah-Hartman wrote:
> Did you forget the Assisted-by: tag for this series?

Indeed I did, sorry about that. The series was developed with AI
assistance (Anthropic's Claude), with the review and the per-patch
hardware verification described in the cover letter done on my side.

I'll add the tag to every patch in v6:

  Assisted-by: Claude:claude-fable-5

v6 will also address Hugo's review comments; I was planning to wait
for his review of the remaining patches before posting it.

Thanks,
Tapio

