Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2106.outbound.protection.outlook.com [40.107.215.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8207BB14;
	Tue, 18 Jun 2024 07:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718696003; cv=fail; b=l2ws5rCTSGxVKmME8LOvv2kp8e/oZAuFMaXEkAuK70SdNYC4pAwY+y46nZViVq6Rsc7YzrXGae33FIIlo5uXkGp+nTZQRqTLIgDJuBSblRcfof7FsNIX3mZa+9CYr9IXbokMuqo/LfZXMYlpxQ6kHkSj2nrZfVKJHKWuAq0IF1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718696003; c=relaxed/simple;
	bh=HpsBtdxA+Z6BWqdgEf+n+lWRvFV0JZZpGlJ4AfGO6SY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lCIOiZFKiBbfKyx263SLMBNPkBmqu3CzLOBhYiEPOTSr1614CULtG/PPzMxdRL/D43OaNxcwYWlQA8JNLnCyAHUAywCtfnEWNwLo1stxH85lCdfT3JQNnRVRGfWk6G8wqRvQXG46ZJ+vsX8yGAxJTA3gPT0xSPKVkmpfIZf6ijw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=Prw6UbyR; arc=fail smtp.client-ip=40.107.215.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="Prw6UbyR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S+1WotXjn851AQEHcQMHXptisxWDYdJ5eKRN/fvWx/qqkj/2MjQBwfMG/HOMq1GdMjGGhOZLubhhVTsyVKyrPHlDtd3fgwR2LfNMmDWjl+QjKc5FvrNd7tsCBnl2E2FCMCmjbu6W/o2++UC9UwAWvDVe7nMVPO97WkfhEpY3z1+snkMUFl53qMwyp/dKU0p0tN/tbOK5WUj5+7h7SigPQUgvYL7D4YK6+IYWNJXfNN7dVN6ZVQwms5z3zd280/VXIll9Apr2mgYocXTaN+/3E3k1biyXNYfhIBeSGSlv2GUV4tJp73YpZ11Wgz2Fi0PDW9yKaBo9Fy0umgCSh0s/Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RqcbfL0b0IX9McNtdODfeYHB7Mwg+Q9MSk0krStmHXI=;
 b=cBkTVE3tei1L5nDOjL68K0J0OgDOoaj+w3LLnsLtdJHeEaAQtsc83RB/lcbs9ONqgYl/a3/7XIRsE8aS3Pq2OcsKu9bzfDLKRPpUxT679qpLoQ9B5kmiO3Rq3yz7ZUAAbWv/LF3DpgG3Q+R546V4WaL4gHc6OUGPloHNwuG4FynoSah7hwC307nmRZL/pH3O3L5DX/HARgDrw1ZIo296/BebO8nAfy9BYNudrkHrpooatSHByneARCTJoYayn7POa7wzF0YPNOIUVKjsYrccPSzrPOLBHnqLIMd3H0VMBgNlVGSauVZ8jch7Gum1gdzexgOKiPbqsva6n8AR/QutqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RqcbfL0b0IX9McNtdODfeYHB7Mwg+Q9MSk0krStmHXI=;
 b=Prw6UbyRvfoNyBqFAVQ4PTX7Wb8DQfssTtcnN1qrr0622ef/p84PcxGmGX7u/dfS9iSk82OdFWlW5OWWyndcjRzaaXHEoQnfPliXvT5aF89h78auZRxfS8sK8qALdkEvfv9yYrT0mSZVRgwK2ipV6VAto2meK/JUJM7YxdTRfRY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by TYZPR01MB4611.apcprd01.prod.exchangelabs.com
 (2603:1096:400:25f::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Tue, 18 Jun
 2024 07:33:16 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::60ab:8615:ab67:8817]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::60ab:8615:ab67:8817%5]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 07:33:16 +0000
Date: Tue, 18 Jun 2024 15:33:12 +0800
From: Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH v2] tty: serial: 8250: Fix port count mismatch with the
 device
Message-ID: <ZnE4OAl99mQdmift@localhost.localdomain>
References: <20240617063058.18866-1-crescentcy.hsieh@moxa.com>
 <CAHp75VfAOqyeMF6wbHenDSpmOL8AFQFDjjL1zRfOqLOXdUahQA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VfAOqyeMF6wbHenDSpmOL8AFQFDjjL1zRfOqLOXdUahQA@mail.gmail.com>
X-ClientProxiedBy: TYCP286CA0166.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c6::17) To PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|TYZPR01MB4611:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c60bcb6-1d44-4937-39d7-08dc8f68eb1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|376011|366013|52116011|1800799021|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R0pTbTYrSFkyQmFpZ2JUZzVqTFR2c2dWN3lMSlcxTUdvVFl0NnhNT1ZVb2Vt?=
 =?utf-8?B?djdLU24vTGJUZ2hjQkxZVkRjMVR4Ny9jMlBZOEpIU1RESnQ3UE9GSjFPSXgw?=
 =?utf-8?B?MzcyY21qdTFkeTVoLzF5SFg3WnNpK3hXcmNYamQyeWhSdzhxcjFsamZLTFc4?=
 =?utf-8?B?ZUkyU0lKY01QbVZIMjRhWGhRNjVEOVoySjBHWlQ4R1V0dGhnVTNFV2lSbHNQ?=
 =?utf-8?B?R2RFMmVTemNrR2RWZHlsQXg5aHg2TWozYWFLRWR1aXhoS21QemhPVHEwdW0y?=
 =?utf-8?B?NmtvZ3NEYkNCTFB3UjFlV2UrNHVrSzcya2ZqVW5sc094TG9uVUZsdjZ3R1dw?=
 =?utf-8?B?ZkxYR1VoOHUyRytJV1JLOVRoNUFEcFB5dDlUVnNHYmJhZkFpQnhzT3A4cS9Z?=
 =?utf-8?B?clBiMXh3SlcyYVlnT3RSUkdKWkNGQU03SGNQbGExUHU1RHJ1aTJNVmFPQXRV?=
 =?utf-8?B?UFpJYnlKbGxZdjVFSEhabUdQcmhOVWJXakt6K21GdE4waXlONXpyQlZkVUhp?=
 =?utf-8?B?MFU4RGdkNEtOZkY3SVZBc3d4ZlFlMmwwbDlwSDZXbThYdnNjU1ptZnkzZ3Rx?=
 =?utf-8?B?MU96WG5LUVFLSHdpR0F0OXVtdFJqN0lKbDY4QjMza3d5dUJDTXlLdnlIeG00?=
 =?utf-8?B?aCtXYk9JbXJpY0JGRXpPZUovQ05SdWV3UlBINXlGOTNsT0NiT3MyZ1pUVS8z?=
 =?utf-8?B?a1UvejlFcmZ0QzQrNGZpOFFFMm9hNWI1NDBxeE1XUEErYkVyTFZMZTUxeDBw?=
 =?utf-8?B?R3pnZTc1T0puOU1KSUNFVC9LNjFtME5SaGl6ckMvRVI5MHU3M0UxN3NpTmgr?=
 =?utf-8?B?NjZjRTFGdzVjRXdTWlVJQ2dBNEhjejF0eGk0R3oyY2c0bjNLNWx6Rkx1Uldx?=
 =?utf-8?B?Y202OUhMRm1kTW43R2tLQWRPcmcvaWpiNDdFQmZNdzM1MFVaeDBnM3RYalZB?=
 =?utf-8?B?dE95NE5qVlBuMjg5anN2ZzNUUnJpaWdlV1lpTE4rdHhHRjYyVUZOSm9xbFR3?=
 =?utf-8?B?VnpNbG96akErM2c5dWJTS3dkL1J4Sm1RQnZUdkVBa05Wa1lEQk1BU3JtVG1m?=
 =?utf-8?B?eWFCQ2NMWC9OOVlYQ2FZSkdXZEJaU0FsRERiOWVPWkpMZFdqNWw4ZDIwMW5O?=
 =?utf-8?B?a3c1ZlMwNC9vS3VWNFNDOUEyTXpaSjRFcGNnQ1VESVgzR1huZTNlZjBreFVB?=
 =?utf-8?B?Z3VnRVZDalk5WHY2OFVGalZ5cUFBTk91RWc2YmlEZitWSjJhcDFKWjdlSm5l?=
 =?utf-8?B?bWZXQm1MTmZIdnpoTUdhWnVXdytwSElISElIWGhPb1VmcjdvbW9CMXM5Zmtj?=
 =?utf-8?B?bUFwVk0weGUwYkhRNmdnbG1STkd2TEdhTmRMelpzKzZPKzdmNmdzOEJscXJZ?=
 =?utf-8?B?alNwZ3ZtdjQvTUEwNzhYRnBka2pqNkkvV1dzaVQwZnRocE05ZWVGdnhGUHVa?=
 =?utf-8?B?L3NPR082bUdXd282SGZJbENRV1pzT3FPbWF3cE4xcmtGemZ1ejRRZDZBVktC?=
 =?utf-8?B?OU44c2grMXRyRVhKa3M1MUZQNzlTM2tZWXZ2SjB4dUQ0ZzFUOTQ1eGFIWFRR?=
 =?utf-8?B?dzVWalF1RjJJL3Nqc2p3U1ZyVE1pKzRkbS9FNFdtdWxvemFEN3FDdW9CQis5?=
 =?utf-8?B?L201cDQ3YVYzaXVBdStVMUZvTVg3cHRQTHBLQVNaeGpIZTFPT0ZpY2EwQTBO?=
 =?utf-8?B?cmNVYUEvS0cvNTc4V0EwakFDTnJ2M1pSVGZJL2c5eVBQL1hTT09vVDV4OFVh?=
 =?utf-8?B?bnovWGNQZlphQnBIUDBCOUN4ZUFqdTBCNGkwYVdRZHFZK2JwYTc4ZWNCcnky?=
 =?utf-8?Q?tTRNGtO98psWahXQtA0O+8AVG41NdjDV+KWZg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(366013)(52116011)(1800799021)(38350700011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dUQ5dGZvaEhEZC9weFRsb3kvazdxU3BuekFPVG9wdy9jeitnejBRbmFsMG90?=
 =?utf-8?B?QU1jY2NkRnZwWmFPenc2V3JuNHZSb3lZdzFyaHRmcGRjUGFsUmxKMk1NYXJ3?=
 =?utf-8?B?ZGtYYXJtdXNnbVBDYVUyNndIY1dkZ1NUa1NLZmtSbVMxRWxwVSt2V29jMlJU?=
 =?utf-8?B?dVV6anBNSlRaVkdFcU5qRjhkMnhTMEpsUTdheDNJUER0bUVkRXAzeVZweW5O?=
 =?utf-8?B?N24wcXFWM3BoMVcwczNUb1JtTWJacWtXY2ZzVE5pZStTK1ZoUFdKS0dqVnVK?=
 =?utf-8?B?SnQzcWhGUEQwSjZMS1ZIYTJzT3FpN1BpNi9QeDlFRklvektMMTRPMDY1WlJz?=
 =?utf-8?B?OEpEZlJUOVNuZDFRbmFvdXFFY2JydnZXUmhSRi94MGYxbExZdlhoNEhsVUt1?=
 =?utf-8?B?bUwwS1E5dEo0SEtzeFNhcUZ4d0lJOVNKZVhGVktOc2FBZXVaeEtlMkU4Ykp0?=
 =?utf-8?B?b0JHVC9zQVFEakNnY0hmeGRhU1pHTEdOdFdzUlVlRzdzcmNNaUgvcFl4WDEy?=
 =?utf-8?B?UEZUMm9PZmkweGR2Z3JvbXdmVTdVTjVvWGdwTURnaFRGNVZPZXVsUWkxZkN1?=
 =?utf-8?B?SkVaTDZxMmFqMWlKcnFJSVdZc1ZycW0yVDRwTGYzZlMyaXZxYnM2V1RGNXlT?=
 =?utf-8?B?MzVFZlJ1b0NUd3VmTzJwNDFqS3BTV09rK0lEU2JVckRHdEFab2NaTWpKRnVa?=
 =?utf-8?B?OGFJc3NhVjNQdlhwZHJiUWxzYVJnWCtMejBBb2lvZUhHTy9BUFBOWnVVZ2Nu?=
 =?utf-8?B?ZlBxa1E5VG51R1pVcFBpemgxOTQrek9FT2o3R2hlRjlNQTltdlFZOExPbnFE?=
 =?utf-8?B?K1E2bG9YSkh6dlA2aGJtRU5KVzdlTkhoYmt0WlhpbmIrWk80elJsQXBlS2pP?=
 =?utf-8?B?WnJuVGlLYVpYOGszN0svclpoVTl6SFd6K29tcFRUdTNPWkpPYUE3NFk3SkRz?=
 =?utf-8?B?Z2JNdmxUSUZQdUdHZmNhcGExRVIraThNNDdSVEgrd2NZTkhQY1NZTE8xeS9Q?=
 =?utf-8?B?bUZRWG9tS214TWVnTVdhWTltemdQYlExOFQ4VmNxa042QzU1elU4OFc2MjhY?=
 =?utf-8?B?U2VxUTk4NVlENzVKc0ZOcWlBZnVzZ2ptM0hDejNZVjcyR1d1QU9hUVhRQXFO?=
 =?utf-8?B?eWJOUXY5YmJUZnFQMGhaVWlrYTNCa2t3Q3N0cmJwaDhjRSt1ZmI2d0kwWFRm?=
 =?utf-8?B?ZVY5NjNLelAydzFLZEM3YUZSMEl4TEhGQlRzUDhRY1A2QTdwVytvVkxTM1NL?=
 =?utf-8?B?OERKUmhKdGlmVHl1eFJPQUxOKytQOUYwU28xWnFFcFFYbW1yVGxXQVhTYkRn?=
 =?utf-8?B?Skx0K2xmc2xTazk4T01PNm0rVTNjckVLTnF5Y1lDSDZraERsdGJ4V3JoUWJr?=
 =?utf-8?B?Y0g3SzRPdk1DbFdocitZbkwvaVV0Rlh3SnAycFFJR2k4SW5KZmY2RGY3MTJN?=
 =?utf-8?B?aE9sVUlhMWVnTnlXME9BRmZ5eEJsaDl1OFFWcUZvNUE3dHpadTJhclRnd3ZR?=
 =?utf-8?B?WG1ld1dkRmQ2OC9Yck11ZFlZUXAxNG1KeE1QdUlia0NtTnJUMzM1TVQ2TkZ3?=
 =?utf-8?B?YUUyQS9oQmFCT1lVVlB0NkFmb2ZtZFprNnR4YnVVdlBoeG01MlFDSXlXSlYz?=
 =?utf-8?B?QTJ2QnFBQU9XRGpNOFNOQ2Z0amRMVFZ5Qmd0YlNNV0FJZ2dWaUdwZE0yN3Yz?=
 =?utf-8?B?WktKUURmaDJYZGRZZkVNNW83ZDA3RWp5U2NHeEUwM3F6NmlGdGNMVlU0KzU4?=
 =?utf-8?B?RUhwN0VJWS9YM2pWQndnNzBXRy8zbW1CVXE2RHczL0hidWdSZGVTWGNkMzQ0?=
 =?utf-8?B?cHVqTTl0ZTRrb3RRdUNIV0Zvbjg4clRibXZoWU5LaDhpMEFHbDV4c2tLZnNy?=
 =?utf-8?B?WU5jVXV5Vk5NcmpyREUxZ2xYTkdzVk5Ma1BYZ1dtTytXanpPOXRFZW9raW1w?=
 =?utf-8?B?MjdWekxRNGx5WXdxVVZRNjlQdVdUL2oyck5iUGNldTdtV2Rwd1MwK2RObk9R?=
 =?utf-8?B?dGFvWFE0ZVF0TForc09TWnUxWFV3V29NUWZla1FPK1JxUlc5MjExSnE0MFpt?=
 =?utf-8?B?VDNEajRiZzRkMWRBMzM3ZURYNmdTc3Q0UUdzdkZReFMzRUdrMVJGQmppQ0R4?=
 =?utf-8?B?RXFEbWpGaDdTNzhoUW9GbnFEMFJoNzRhTDRlQStidUprRzB4YkhCLzlxZXB0?=
 =?utf-8?B?aEE9PQ==?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c60bcb6-1d44-4937-39d7-08dc8f68eb1b
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 07:33:16.4817
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fAiJXBUEXq8K4t9/RjogYjiKW33QJLLbhCGTxDkcKgiPMKDlCpL+PMrB4vP5akjUnupT9gdNmIEhIyh3ISssQlG3zJmaB6papyGYCHY36as=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR01MB4611

On Mon, Jun 17, 2024 at 12:54:34PM +0200, Andy Shevchenko wrote:
> On Mon, Jun 17, 2024 at 8:31 AM Crescent Hsieh
> <crescentcy.hsieh@moxa.com> wrote:
> >
> > Normally, the number of ports is indicated by the third digit of the
> > device ID on Moxa PCI serial boards. For example, `0x1121` indicates a
> > device with 2 ports.
> >
> > However, `CP116E_A_A` and `CP116E_A_B` are exceptions; they have 8
> > ports, but the third digit of the device ID is `6`.
> >
> > This patch introduces a function to retrieve the number of ports on Moxa
> > PCI serial boards, addressing the issue described above.
> 
> Now it makes sense to me.
> Reviewed-by: Andy Shevchenko <andy@kernel.org>

Thanks for your review, suggestions and explanation.

---
Sincerely,
Crescent Hsieh
