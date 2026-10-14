Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023073.outbound.protection.outlook.com [40.107.162.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6693E474262;
	Wed, 14 Oct 2026 07:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791962284; cv=fail; b=GbRUyGRF6VHDQacwUN5kumA9itN7xsOqvph6HjP50zvQmnZLwT0pPTHFskyW9Azq4jviux1ennjnQgeiNKe29O/kY33zScg/i3tDmwslnH1Z8r8ykOjdmKyOTllatKPkiulivewz3CYUVef9uoTszMfwAw/x3Dj/8fco+yQhVxA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791962284; c=relaxed/simple;
	bh=CODzgFVed4/MwlLUN2xRcklEdm1OHlah/yRVxx3BNIo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oWWA7H07Q4t5pY1ragU1G62FZTlAdkdKTC0MwYcpKw4g7FTZCqwNSYbmVUlHMyWsNU7OBojzg7VElElz6EjMgDnIUitDb8mzX+G2dkIYo7jBnyrkU6vHhtve/rWfy1eFMFZc1AWEIPHlUK3aveiIIeJraTm5K9+g2Kwf5NIbs+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=ZCxfqEbW; arc=fail smtp.client-ip=40.107.162.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="ZCxfqEbW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gDMWcpGm4+MFiZzLwyd56y2++B0ZRWHMBhHyTNY01oZSoMEQlfBnIAAR1tBUneIIbDzskFXT72cvq2xQZN3FYAa/0IXEQ62Knm1PnUYopKJpqUXX4d4skRlpTzgTfylqG+IQ4tP4zsm4ljmAnlKJoK2qq9eRa1UD5x7+XGoJeaqoSBurTXGqT7UZTFpXYrhcA4Feu+hzO7WDfygM5uujbhTFJX+oi/HjltY7aIomaLJeuB9mGg3reCq4wRYKtgw0zliQXvn0qp3GXUGF8hc3tAXoRVtNTCEaNEgPwDEUiWO6LKbLMEm1vGs8LL8GEJ5/sZHMHxehuQLKeC+lkiurWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aGYwwKxQGOf80jEcwH5l5UNDmoBajClUYu2jAfCW9tU=;
 b=PE6kZj+1DqkXx2jGwzQrwOWSeZ6WmcaLwV582I4em6qxy4NKrFnWCq+ee/mfsNpk468EV0K8GxcT9LBCEqBjx+9gVMd6+0pqJjEdIYLELJOF4C52COZgfIRbgUDJHnb7rmsr/8m5oGunaHWVFjBGAbbMGodH17hm9tNWnaMz//B1R/VAP+RAJfK5WJxBG87i0ijbCjVbAjopkhCY0jpqozRRzakI4A/wSylIMBFMuQ4lYfXRyoC26zjlek/XuiLsPdra+WHUuZREY31yd7Mj83NYSoB/MHukIafZgXFpvaa8rroV6ieFOtPhVj/gm7HMZgXumbMJf2j/2Sex6FD/Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aGYwwKxQGOf80jEcwH5l5UNDmoBajClUYu2jAfCW9tU=;
 b=ZCxfqEbWk3i5UyPyVa2qqw3lzFCZCLQhFHyM4GDoug5kI6EJ0iLh+bKwDvyYrjwckG1dBr5ekFCIr3imFGT++4GEgRHY67d7guJ2aRC6xEYnToLnlnjKXpHmDIKUsrjipPaPShiz8XNHTBBPp7N1LmQ7YL7KL71nM43sDL03TiVGESiT7/AtxM/WN08Fkue6ovMlIqnLEnzCFoUONED4nzwTSuXWu8eGZmBD2LvPS6EC8cK8ZOhB2tPL9+4xsaG9o20mcn3F+6u6LPyyycVEsyzJ5mkKRTwvYIyOqor+VwtMtiTJSuZEog41WzyKmQDl2S9H+kARzVZonkVH3Q086A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AM9PR06MB7907.eurprd06.prod.outlook.com (2603:10a6:20b:3a6::23)
 by DU4PR06MB10410.eurprd06.prod.outlook.com (2603:10a6:10:61d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 07:17:54 +0000
Received: from AM9PR06MB7907.eurprd06.prod.outlook.com
 ([fe80::a597:33a7:d4e2:1b17]) by AM9PR06MB7907.eurprd06.prod.outlook.com
 ([fe80::a597:33a7:d4e2:1b17%4]) with mapi id 15.21.0522.011; Wed, 14 Oct 2026
 07:17:54 +0000
Message-ID: <6bed8bd2-0104-4803-869f-3d3aa8aee697@vaisala.com>
Date: Wed, 14 Oct 2026 10:17:52 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 9/9] serial: max310x: don't transmit while an RS485
 reconfigure is pending
To: sashiko-reviews@lists.linux.dev
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 Maarten Brock <Maarten.Brock@sttls.nl>,
 Tapio Reijonen <tapio.reijonen@kolumbus.fi>, linux-serial@vger.kernel.org
References: <20261008-max310x-rs485-sw-delay-v8-0-6ba881f81e1f@vaisala.com>
 <20261008-max310x-rs485-sw-delay-v8-9-6ba881f81e1f@vaisala.com>
 <sashiko-outbox-163985@kernel.org>
Content-Language: en-US
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
In-Reply-To: <sashiko-outbox-163985@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0386.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:80::28) To AM9PR06MB7907.eurprd06.prod.outlook.com
 (2603:10a6:20b:3a6::23)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR06MB7907:EE_|DU4PR06MB10410:EE_
X-MS-Office365-Filtering-Correlation-Id: beb61996-fdb5-41d6-b84a-08df29c343b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|22082099003|18002099003|10067099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	5Qd/3BOmSDV6DDFeJwnzFTICE5K0W8JDRr0C++rJidHpLxK34yXVhcjHrB1iLLcDKO8k+o5SeBhRoOIMBChuJaRA/IQqiIVaP0eEAZ5UOsdV+jazF6OvE5z9lVoxP+SbrDfw/G7xD5Y8Np7VPK5bjYUT0KWzJv+nlQWEyPSjNWiy8DwHdFcjPQME2cWLQ/ztjpB04ns6lNjILQo8Kg3bgMOaAQyBnoIkwiWcO0R1r4pSfmUMExjk1fVXh6/rRhABqCB/Tnth4W9+N7O9h1QyAtJzM8MLpetOwjgLIHTw2vuhY/MPTgrM+8BzkcXMnrAsM3oXp8lhkfs8lbeOhQjE/+oxoTcIOs6KeOGWqK963AaXDePqdbaUOFNV2Der57G/G3X3KZys2Y2Tppe22+xFswXGUult0pks/aiBKAtCgWJREytiMHTUSg/zhAGfljfWHPsesfKeTctRE1pESlGj+Vq9kePVORTTyCXlWTI7QbdrvkGb0p3S4H7dTE2YVqG052T39edtUhiuz1a/JWhabCBolBJu+8HenMSQwfSN6nnrrg0IHyPNvzf2iLNFjepK5qMxRxZgpiUzK7dj4dxpaVE2LBmwNICPOoHxtJ4XChbFHuevkui0oHzhC45GCkZDgll0c9gmjNRtFOLkAWY8Eh5KJmfsUGUX9igY4t0Yf18=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR06MB7907.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(22082099003)(18002099003)(10067099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aDZtQWxRZmxIbVBuS2hlRmFEV1g4OFZHcFFkdko3Q1VOa3dGREk4c2t2VWFD?=
 =?utf-8?B?QzFEUTc0UzNsZkFCT3pFaFB6QU13dlp0Tnp3WU01WWxqSkxRT21JRDRzMEpr?=
 =?utf-8?B?N1E2UTZ0MldWUG5PQkhUbmJoUWdnV0FudzQyc1huaDZnb0x2Mkg5R0FONDZy?=
 =?utf-8?B?NGJsYXlPcEFTdklQR1M2QmtKUHRBRGFPMllnd0tyUHNmYnQrandVY08vV3Ni?=
 =?utf-8?B?UHJwWjdlOEM5WkdjekVpWVhuUG9EWlpDYks4bmo2V3o2N0duRHRvc1BpblJm?=
 =?utf-8?B?RDdRZVUrNFk1TGVXSUN4SHZMeVBHSTgwSWppeTR1aTZVSGZLcmJSa3pQWDlQ?=
 =?utf-8?B?bnRhUnBaOE9NZDNrdVhaME1lU1I4Z1RaWVJMOE5LakJYKzhQc01ERXVtSEFN?=
 =?utf-8?B?Z3RsUnBtdnl5dXIyMHBMN25lU2NUNXpMOUJLRzVvNmJKdjdDWnlRVFY0dUt6?=
 =?utf-8?B?cUV5YnIxRnAvOG5NTGYzaDAvNlZvSlhJd2had01KS1dFdWJxMGVmcm9ZdjlX?=
 =?utf-8?B?MkV4TGRSdGp3dHVJYi9OM2NvMFdjV2I5L3NIY1Bvam5xZGNGajZCUlRCWkV4?=
 =?utf-8?B?UEtCQ00xRFg3ZkZCRTJrVnBXQ3A4NFpUQkZmL3RldHNoRUg2N2FzcS9FVXc0?=
 =?utf-8?B?WUxaeGJxemhRYnVuNTc0ZE5uODhLYzhpamgwTjdRU2JrV09EaXNBcVpLL3lz?=
 =?utf-8?B?eG9MVlcraHdxMndTbzluN25VMG9LNHp1bHZ2Qi9PRGprY0tNc3JQVVZjZTMw?=
 =?utf-8?B?T3N0RGo3OUttWS92ZUx6R1JRbVQweGVkcHFuZGMvTmJxQ1ZKT3RRdFh0NUE4?=
 =?utf-8?B?YUpHbXBGbFlqTG1qdWFEZXFkcFZNU0RhdUVhbzl5VVZKM1dGZ2J5TnE4N25B?=
 =?utf-8?B?bDhmTlJPOER6Q3RIeWdBejFsVUx4YXBjOHJrQnZPWks5cXpURHlxZ05ZcTJr?=
 =?utf-8?B?dEo0S1NVNTZSL0prS3BuM0gwR1BpYkZiZmFVNnE5cGkyREVrUFZpcDNxTEVU?=
 =?utf-8?B?bHlQWXY0enYySE0rZDVpTXk3U00veDRoUHh0bnZPSHNPMk5aQUNCaFBZM1Jw?=
 =?utf-8?B?REFaREVlckhMbkN3YjFIQVF3NW1aU1ZRdVh6UW41RnZBcDNMKzNubFpVZnBz?=
 =?utf-8?B?eGpGUzltZGl3bnFRR0czTk9DQ1Y1SVNaM09aN1VJSjN3TzFReTVwYlhGNEZQ?=
 =?utf-8?B?L3M3S0RGRWNrSXFEeDdHeFdEN2hWRm4yQjlXbnZIZ09mbWMxbVl1WEdlNTQ4?=
 =?utf-8?B?UWE5ZW1MVGVsOWIxaWM5d0JBTmtYVm4zNm0rWmhFbTE5dnNDQ3NnSW1BdGpy?=
 =?utf-8?B?M0QwU3BxMnoxUEo0aXovd0UySjNXeUlxK0pEMkY0NWRrY2V4NVVDYWlEV0xy?=
 =?utf-8?B?dnVkcnFhVDJlOEhadDl5dHd5MGFnWHJhMGJ0UGpWZ2pSbXlRdFVPeWU5UDNz?=
 =?utf-8?B?bndDUjJPSWRzU0Q0bVJkalA5QXEzcGh3V21DOWhpcFRjRXE3Q3cwNWpReEpz?=
 =?utf-8?B?UkNOS3dYWHN2WmFEcFczR0ZBclZoL2xFY2x1VkpsQnpNYi9VMC9XaXJ3dHhl?=
 =?utf-8?B?WGJBSVNUTmdreXFCVHJxUUVLVitEcmpzbG1JODJPN1JOZlZIRzJOeVpUZlcz?=
 =?utf-8?B?M0phamRGcTdGZ1FQOU5TNHVVZG5WeDJaQUFaWFlhVnJXVEx3VloyTUw2OHBM?=
 =?utf-8?B?NGE0YVNlRDU5ZS90Qk16aG91TUxVNGR0N3dhYWFEV3RyMHBEajl5bDRoTkdr?=
 =?utf-8?B?dnhzeTNtOXMxQjB3eStWY3hIL1ZRRklmQjVxb1FuVFhlSFRieCswZ2JzbU9W?=
 =?utf-8?B?QUM1bStZOXhzNFlHTlF6cXE1VW9QQWRCVE1PWE5WaCs2ckZYTy9DWnFBbldY?=
 =?utf-8?B?WDFBeWtqNThLSmxjTkhNL3VFUy9NeTlKVFNlSE1UbXZqaUIxVnpXTVplaXVl?=
 =?utf-8?B?WDA0WS92MTRYc0t4Tzl6WGt3RjN5c0pwZVVjd0hVeEJ1VWNNTWpHcHo2VVdB?=
 =?utf-8?B?cGNPZ0V5VnRISi9CajNwWTNVbDYweVk5VXl2VFFCejY1aFRtd2t1S3NIUlV0?=
 =?utf-8?B?Y1N5eUtXaDlmQVF6ckRaak9iQ3h2NEFxVWRua2RwdE5HdFdOamgrdkZibU5E?=
 =?utf-8?B?QnUzZW9NcVRGeXh1cHB4L2ExVk84SDlwWkZwREJ3Mk14V1J2d05wdmt6RGFX?=
 =?utf-8?B?WWhRejJpbUNUTmdycU5pam1neitTUmQvRUd1RjhSVk1pRlNlOW5aTGExd0c3?=
 =?utf-8?B?bjJCNnd3RmJsa1ZyMERONWp2TGxGN01RVFM1cW1STlloMmVNcHJlSlRVSUZy?=
 =?utf-8?B?Vys4TGVpeXFzcm9wcDhrWXpaZmNTWno1TVV2WnlDY0tQR0ZaMis1ejZsYW9C?=
 =?utf-8?Q?L3yjLIAqKYUF+/h0=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: beb61996-fdb5-41d6-b84a-08df29c343b5
X-MS-Exchange-CrossTenant-AuthSource: AM9PR06MB7907.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 07:17:54.3665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GE9DDMh17zX0Z/YtwfEVOPis8k8LP0Gx5iCWttNPedstYIMo57fmNj128FLlxqaOLIXaLPs0i+AOfQAr1OZhiCks1YAw5GGK8oycH9GOmZ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR06MB10410



On 10/8/26 13:03, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:

- tx_work continuing through a pending reconfigure is an in-flight
  transfer, which the reconfigure helper adopts with RTS held - the
  gate's documented scope is transmissions that have not started;
- max310x_handle_tx() has exactly one consumer, tx_work, so the kfifo
  single-consumer contract holds;
- rs_work not being cancelled in shutdown() predates this series
  (2016); it belongs to the same teardown-ordering follow-up as the
  patch-7 note.

Tapio
