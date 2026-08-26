Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010062.outbound.protection.outlook.com [52.101.193.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0D11B4223;
	Wed, 26 Aug 2026 14:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787753853; cv=fail; b=mj+A4Cs7tWWf75mVfD6WBt+7svcMhAkkwtEbQoXiPEjwv/LXd5pX6uP5iuVpVhx0hEvYesHNPFimYEJfHeEZ0Oknk+5CqCS5qEv4ikwec8xAOBDKU5LEpcI3HBPdPtHBkm+47in3OAGmgonvjb/XlrYD2TJUy6esZJB7pAC6Gkc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787753853; c=relaxed/simple;
	bh=VjeH5BaxL0cg1h1dlKTHECYrUrdhIOIfB7/+9rYmFgc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tbwlfiCS1x7NL2H/Y99XRf3ej7/0xrE2fmpj1RbhNGnafl0qItEVZoIjI/4apbD8Zy5AZxQKltyY3X5u/TqlNz24fBaOBXIZ54Gszppu9zsrA5cDDdYkFA4l7ojgPASQzq+tX1tt2pzIHc3/HJNX6yptX5xbri9noaSxnc/+Gxg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iKgX8hXg; arc=fail smtp.client-ip=52.101.193.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iKgX8hXg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gHLcaLk7ijP4etH1i/n4X+8nDuUOmJq2z/9SdW96wie57ZZKJt8jA9PHfqqODESiHIzQWtoB8Wu7OqqwD3MdzRZQAarZ0zdRkbcFnu2xULX7m+NrfuXHj2SHoEvX37A88L6xdYpGVZXAbPcx+pAD9/5wujctcU5EG2Efgr0fCax+jZ4WUJueU6PSAM/EHdxBKcYzIh/jjlmKw9pXmvY1Sjp5ELKJDh8QDdSCgaI+HfSbTQ3Zt3WlX2rB1jRmi7QeOD9guv7T19WawUfPsodPHlgzm5bTgm59kEMidmRj0LSGREPNXugZI0d/5sVGw3F3q+6TVziclQaEPsYTpQsF9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+8MoylYWOlrcXykKgBHRwF0v2rv3JasPsmu0kMy30/Q=;
 b=u1HLKWX9Tgnvil3Ktnq9dOZeLJU9cSNEfBRle4OBUbemGutrZnmwk7qkKpAIPY9tacEUsMVA3OP2MYi6SyLbvdKfTDPT3d9VTMX9TsPrHho4tk7rsLpIgm3EOvKSPk9jcExoU10iIhgj+GRtOkLPbKcAtCt5D2ERaF7dpC0ijN3oIVg8dS1AzuzDSt9nROQhYxYvTNFrsGxBrCuQeBR9tOh0tHVpG8ui9kTYXdvn3iJuCotZBnGjauBxPXVH5hjy51ejuS1tFSCvfxlJP5nnlVT8sNND7Vj+T1Hjq6pcftpyA/yTI5e1yAxvLrx0KNuTAOPp8R0hGTPcofSs9xpflA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+8MoylYWOlrcXykKgBHRwF0v2rv3JasPsmu0kMy30/Q=;
 b=iKgX8hXgNirzVQMnUwyCSmuU2VtD+al3Ebr2TGHXT9Lmt3yU+v3bzHHk4iYZYMNrmE0bP3NOCrOcktEpVmY0/Yawm80H4mmY9hpcsoxF0igD/lLmziKCTxxK0A+eSLnVRrRxg8SiQQu8ZOe/2bj21AmPaKoZy5VDofp02lC0wpO+SLK93epKuu6fhr6lxPfoHHZ3Ub2zTEJUO+LZhO4KcuCIRNIX1eYpja5FsXzlKRP0+oEXoHS/WYu8/89phWNEgi+Zy/Xr7DpYjm+Jqzg/6JQabKK8Uqt7Q+I/E79WbmBUuFsuUasTdritkNfPwXsdAaqvNJxtuQgl0T9v68xCSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6051.namprd12.prod.outlook.com (2603:10b6:a03:48a::18)
 by CYXPR12MB9427.namprd12.prod.outlook.com (2603:10b6:930:d6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.7; Wed, 26 Aug
 2026 14:17:28 +0000
Received: from SJ1PR12MB6051.namprd12.prod.outlook.com
 ([fe80::96e1:b300:7b78:d3a9]) by SJ1PR12MB6051.namprd12.prod.outlook.com
 ([fe80::96e1:b300:7b78:d3a9%6]) with mapi id 15.21.0360.008; Wed, 26 Aug 2026
 14:17:28 +0000
Message-ID: <4a5d9327-5457-421d-ab5b-05aa546dcfb3@nvidia.com>
Date: Wed, 26 Aug 2026 15:17:13 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH tty v11 1/2] serial: 8250: Switch to nbcon console, take 2
To: John Ogness <john.ogness@linutronix.de>, Petr Mladek <pmladek@suse.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Jiri Slaby <jirislaby@kernel.org>,
 Andy Shevchenko <andy.shevchenko@gmail.com>, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, Kees Cook <kees@kernel.org>,
 Stepan Ionichev <sozdayvek@gmail.com>, Xin Zhao <jackzxcui1989@163.com>,
 Osama Abdelkader <osama.abdelkader@gmail.com>,
 Fushuai Wang <wangfushuai@baidu.com>, Marco Felsch
 <m.felsch@pengutronix.de>, linux-serial@vger.kernel.org,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20260729120439.281252-1-john.ogness@linutronix.de>
 <20260729120439.281252-2-john.ogness@linutronix.de>
 <f3757a75-0ba1-4558-bf57-f19ab7e59a4c@nvidia.com>
 <aoQPFC7d8mSuNZMh@pathway.suse.cz>
 <861247ca-dfd4-40c6-a094-0fbe389f3b67@nvidia.com>
 <aoR_9g7W0qyqWbOj@pathway.suse.cz>
 <fd1802c3-4b38-4127-b988-a9ff059bcebf@nvidia.com>
 <877bll9d91.fsf@jogness.linutronix.de>
 <eb0f2c8b-2c7b-4bfd-9144-6786999c4c31@nvidia.com>
 <875x139eqr.fsf@jogness.linutronix.de>
 <6b46866f-548f-4963-bc41-48ce15ae9012@nvidia.com>
 <877ble714e.fsf@jogness.linutronix.de>
 <d058012e-2be7-4e70-9c10-5e4c00a23b05@nvidia.com>
 <87pkz56epl.fsf@jogness.linutronix.de>
Content-Language: en-US
From: Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <87pkz56epl.fsf@jogness.linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3PEPF0001DC01.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::30e) To SJ1PR12MB6051.namprd12.prod.outlook.com
 (2603:10b6:a03:48a::18)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6051:EE_|CYXPR12MB9427:EE_
X-MS-Office365-Filtering-Correlation-Id: 92c2dec3-3685-4da4-931d-08df037cc23d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|23010399003|376014|1800799024|366016|10067099003|4143699003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	LqrIRe85bFnUlZ429fj8Jj6qdLzZeEV7WieQdQ1JXomHDFB/SyOdLO0sqO4qXjOUgrqqP2afcWdkAxfGrR6CT0qwn+hyOqH2oupm5N3EdBn/AkUDJAVorJpK8eYYLXSbzeyXxQjJ4nRwEYBww9sxqQh9VadPx9vu2KDAcoVjBH2iKwkypULM08iXg5z3pe7/lMu4kTAR7bQ2kPqn+O/RDStRt72DWrDEDdIqB+Szaow1myCfWSJp8/LTO2U1k6c2L770m6KZrjZcnbEec7uqpSL2MkGwmUpYz+vSfiIhM9dNkvmgQYoUQ6Lpmrw6DwTuAON5k9PalzttQDsopTvtD7+OJin3Yl6WkwoHPR+KGbYsoiYY2WgkE8ziap7iC2a7faPkO+z51abwC9pE/YcijFoXhZJ8SqW2DsqFJDHcwyc75Zi/wYPtqy084ZBzm7aysDH4zui1SCmAsySBO4iuiRM9gEk9qvvjioe7RDwtr6xHwZ0j8A7gTybEyuko69H6E/4Yi77yku7Hl0Vgjk/l7CnK+qwUQRf8MfSzeznt+kLJvuufaVo2+Sxp0HK7g8qOngF5Q2eJbmtkJGC9k4lb2NfrEfN7WM1ctIX58U42DFQ8AIEX8EBDjl+3Y63OhqQkcjKHJDBIqMT1OG1yqW6J1K4sDM0Gdmmo5byRw4KPa3Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6051.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(23010399003)(376014)(1800799024)(366016)(10067099003)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bkZJQXVUczNjSDJGZmFhejg5QUhGdXB6UGU5Q25qWXI1TkNWUk03dVk0S2h3?=
 =?utf-8?B?bXRVRTFzdUZpN2lhNFNDNm5tY05Jd0VqWEVtejZob0NxbjJOcVFNc3VjbGx0?=
 =?utf-8?B?dDYvRXhNaXlQanZUSjJhSVYrZnRQK05rMk0rTE1yZjRENWZKRTRUcGNsVkpj?=
 =?utf-8?B?YWFqZUpPYVhRb3Nkbm8zRGhKWnV1a2FQci9EOFhac0cxcjhsMEJ6WnJaQjQw?=
 =?utf-8?B?ckdzdzd4Z1AxN2VhbTNyQm5KMnFyd0h5cnU3N2tnN0VrcGxEd0w3NmNJeHRp?=
 =?utf-8?B?azlHY0xkMDhrTmQ2ejBMRXU3ZUpCTWtGemNYS2phNXVWRUZmekVQdjViaFY5?=
 =?utf-8?B?R0FoWkxVRUZOU3BnSEYvbGY2SUhUcm54VWVBaDJncnBHQitkV0ZJRXFpZXRY?=
 =?utf-8?B?MDY3cW1ZdFZDcXBkenJYVm55NFNtL05KR3ExNkM1UW1TdXFIaGJFbWpLR0dn?=
 =?utf-8?B?Rmh3WG9PMlJySG5IVmZRL3ZkZWk0Zys1WHBJOURtSCtrSVo0YnRPSGZqZlJ2?=
 =?utf-8?B?T0RxVmtpQ09ZTUN6UXRRTWRoOWVaNHA2S0Q1cFFJbTNmMnNTaU50aEsxQlA3?=
 =?utf-8?B?SWtoVlFqVDlYc3NFMmRPb0JNaVBLWmpUWVJ4aTBIUjFrOUdNSU53RWRuWnk3?=
 =?utf-8?B?Ymp5QmNaaGR1R25jaDVEK0tOSkMxUVY3enJjVWNZdGF6ZkJlVlkyVTVGYUpm?=
 =?utf-8?B?M3prTHF2U0V5akswUCtMM0ZJQTZzaDVaZGx5YytaMlc2eCtLQ0IyZi8wUHBD?=
 =?utf-8?B?UWJpcFpjdmErWDlDSjNUZ3NCRW03a0MvVVFrTTNta3FKWGVydFo2SFpUN2VN?=
 =?utf-8?B?bWx0K0R2aTBZNm1Pa1JVY0VxZ3B6R0xRM1JxVU1EdnBRczJCL2J5T0dFTGs0?=
 =?utf-8?B?QWNuR3RuQUUzN2VZbk1QYzN4eUFVZkN4djFWS3VLd1B4ZWZwS2c0TFFESmE3?=
 =?utf-8?B?S1BLVjk4Zi9FemgwdzFCVGJlYmpUYllJMFVPME1PS0lldEt4cTY0MncyckVF?=
 =?utf-8?B?U0JKeFJUS0NuRWZLczRGdjBCekZHZDZWTkVRSnZkTHNKY3JuWEdHWjM1bXN3?=
 =?utf-8?B?RTBuRERBNk96Vm5FalZSREk3Y0dqOGdiUlNDcmFUeHdaQ1RpOC9SdGwvRjF3?=
 =?utf-8?B?SUxjMktGa1NEZ2wrM05oRlJzNDBscDVnQVBkbGh1emd4ZDJsREV3MkI2NlNx?=
 =?utf-8?B?L3FMcmdjN0xlT0xVYTg1NVYrbWtWbllSY0VUOEVVNkRZMDhlYlNNSmk3dGhq?=
 =?utf-8?B?TjN6SHkxYmZPdGFuc0NYRDlTZ21FTTJ6R09OSkhDT3BCeGQ2SFBlb3hPejFJ?=
 =?utf-8?B?MnpWRTF2TlRlRU92b0J0dHJtbm5wQlNwVmlDd3pzZ0o1UGdXTXFaMWw2V3lD?=
 =?utf-8?B?dEpNTE43d0xFU0FzNWpjcEcyTHhqOStObGRCaFhEVnVmeXU2UTU3cm1MNi9R?=
 =?utf-8?B?dVZwWmhLR2JNYkNrSThKWWlRelgxSEZVWmNmZlFRMS9aTlN3V2xxWXlPc21o?=
 =?utf-8?B?Q2xHMXh5b1dQbUlFSzVsV1Z3RGU3WHdoaEhXRmh2QloxaU9rVXJmOEU1Rjk4?=
 =?utf-8?B?RlZ2MFVNdGhsai9HVXF3SnpaUlRwK0dDNkFlOXZiU1BHZEJXUEREZEJ6b1Na?=
 =?utf-8?B?emVjaThQN0o5cmZSRlpDOVpkdzlrREpTTWhtTWMyanBpWjVycm1YS01qTGRi?=
 =?utf-8?B?bmR6MldjazFoVzFRYTdXRlNiWGJBZFVqUkhQSWp4alBZUGZEM05QYkNIV3Ex?=
 =?utf-8?B?K2FiRE4wbE8rS2pyQjl0TTNDNlRoUHpLc0xEYkhQMXo2aUJVOHhJY2NxT2Zq?=
 =?utf-8?B?c2RFRmRBM0RTSldVblF3T3EycTdsejFCdWN1bmdFVnFkK2JuSlVZR0hTdG9O?=
 =?utf-8?B?dW1rZE9jWTFsdVBENjM1WlQybVA4a282cHVkUmpOZ0dzaFBLUEEzem1RQlFz?=
 =?utf-8?B?dTdRZTcyYjlCdVVLSmxtRGNhSFVZbkxhdmxWWE9TUlBwc3lVcUtuT2hQRjRo?=
 =?utf-8?B?a3dGU2U2Uzh3ZlVWVXpETVRRMzROamxRYUJ4V3hDQUpLMmhlSXB0SC9odG8w?=
 =?utf-8?B?Z20xSlVYbkN0Smd5VXJRalJVanpJNVFRQWZlMU1mU0xhaHFzdlpqK2d1eEVm?=
 =?utf-8?B?Rzg3T05qNUxqRmY4YXZyN1ptQW1RMU43TWJzQmJBakl1WWR1RFBGMzVuL3hR?=
 =?utf-8?B?dXRHQkx1RzQvR3NRSjF5dEh6dGpUTXFOaWhPQmZjTlhIV0JJWkR5M1lTejZG?=
 =?utf-8?B?S3BHajZlamJRWFczcTBvazZ6RFRsUVY5RURwbVl2Qzh2ZWhuNXhHVDBFZXJQ?=
 =?utf-8?B?WWZoNWVTZ3NzaVZ2Zmc3NnBkdmE3NFZ3UFV2WFNjTCs0NzFXbjJrSGI2ZmUz?=
 =?utf-8?Q?AhXNvgchJzrx2yH4LMO2BA0Qy16fQnYmMtKjco8v9QhiD?=
X-MS-Exchange-AntiSpam-MessageData-1: IvNS/Wvj6o7/6w==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92c2dec3-3685-4da4-931d-08df037cc23d
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6051.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 14:17:28.1445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RSxz/IvJuvEX758u6eGmSMsjPzILdN4RIFYSC3hveCPSwzwFlbBRapLuup9dC0Y0XuPl/XCK4vQP3I2itxHwIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9427

Hi John,

On 25/08/2026 23:02, John Ogness wrote:

...

> Your results surprise me a bit because in previous attempts it seemed
> you were also getting hangs related to printk's not produced within
> cpuidle. This would lead me to believe that cpuidle is entered while
> irq_work from a directly preceeding printk (from outside cpuidle) was
> pending and caused a problem.
> 
> Does this hack really work reliably, without using keep_bootcon or any
> other patches?

I went back and started again on top of next-20260825.

Vanilla next-20260825 is failing on Tegra20 about 19 boots out of 20.
With hack 1 and hack 2 it is also pretty much 100% failure with 20
boots. However, with the latest hack it is passing 100% (20 out of
20 boots). So yes I say that this works reliably.

> Also, although this hack will avoid queuing irq_work from within
> cpuidle, it does not prevent the 8250 console driver from queuing
> irq_work for MSR handling during atomic printing. There is no generic
> console callback to deal with that (other than suspending the console).
> 
> I suspect it is a general irq_work problem on tegra regarding
> suspend/cpuidle. Really the problem should be fixed there. But I would
> need hardware to investigate the issue.

I am seeing this on Tegra20 and Tegra30 boards, which are the oldest we
test and so difficult to get hardware for these.

So there is the following code in the cpuidle-tegra.c driver ...

  if (tegra_pending_sgi()) {
         /*
          * CPU got local interrupt that will be lost after GIC's
          * shutdown because GIC driver doesn't save/restore the
          * pending SGI state across CPU cluster PM.  Abort and retry
          * next time.
          */
          atomic_set(&tegra_abort_flag, 1);
}

So may be interrupts are getting lost?
  
> As for this 8250 "switch to nbcon" series, I am uncertain how to
> proceed. Is it really printk's job (and, by extension, the console
> driver's job) to decipher when it is allowed to queue irq_work?
Yes understand. I am not sure if it is possible to opt out of this
switch for old legacy platforms like this?

Jon

-- 
nvpublic

