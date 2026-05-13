Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA49B3D47AC
	for <linux-serial@vger.kernel.org>; Wed, 13 May 2026 06:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778655077; cv=fail; b=pUuq8HUCJMMQOA+DD5WoPaZ+S9tj18ngASDBV8nd7cK6Dm3IHyz4z8SxpHCN5wnJWYgyDRFAfPXSO7fbnDqu34WjzH6xmiPkBto8NCHrJ15YbQdEkujOveelSprUctgxcdYqW0orwmuw9Clw7QvfmtpGk6FKdeDHiEHyBwZIpx8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778655077; c=relaxed/simple;
	bh=ywD5FSX9k2p6PFnFn+KZdqm581yt8NsnV0by4OCr/P0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BAPK++vaQN4s311lCWwMXkZ0yMx8BrXhAM6duBw5a+qHjWxGBrCY2uS5LlDraaqdssYOtbKbpH/FfO3YELsraqGRnwg0YPgYG9ABfOxUPkWHcHNGAadpvn/9BL/5lThzO31ZZfCrahF614xDjVa281srqvQFDm90GMs+v7yi5oA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=ibaxDjCl; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="ibaxDjCl"
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64D3LcAw147001;
	Tue, 12 May 2026 23:51:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=ABashjLTXn/QhjRzbRq0gR1qkKlcBNeILQokE+w6PUY=; b=
	ibaxDjClG23iBWMnNJgaR3ZG7d2yPGdQwAHp6m2j0os84ZCFfdVsxU/u8JiQHiRD
	Gyw5b9PGUcN24TlOVRwLHmJKoQPPrcYeEejiES2mneUkB5sDRVsoP71f/txQ9JIn
	7iPjdEiYPtp/OrpJSU8kL1oOXaR90vAV+S4mC8OD8gMWpoWwCtZH3J7igt++WRGC
	1q/+I/xFHO9//1Qh1RN5gNh1mZRQGsBSOWr1rFq7khv2j2Npl5bvIQiuaPGBukSS
	ur3z2dz9HPTj6w4yRI6SYdtKwWo4djo36ROBWhXBgc2n9q2aViMMNck3jAdMfPZS
	ipij/tnIBeeWNqkxO8G7uA==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010013.outbound.protection.outlook.com [52.101.201.13])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4e4g7g88y5-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 12 May 2026 23:51:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mLgsdZvV7m0kfmrqFuVDWX05s6FhIYzI7TBGEJ9W/nVrxBbOQRy+QYV+9PPP06Pwe8DP+uc+aIoBr3KIuU7MPNqmspJICAi2ntknpaew256cn0IqbXOK94ZzZvpBpwRiJIJ11r1ntEZCXP2dp7QdZpAH+zgzUXtn8o29SZmjL3IDaY/GHk658NrcVy6S0h98SCQQgX/OTa5YshHi5p6huhYWH2pxIj1NVFvttsbvtt6vp+387RQy/xobWXvGHTqmovpu525N9V7f2frcud2FMsI+hFIMj53HHSrAiySu7ke65HpoGCKWZtfRFC378xLt+QYWsnkJlJJMtbSJ5DOV8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ABashjLTXn/QhjRzbRq0gR1qkKlcBNeILQokE+w6PUY=;
 b=I+SJQKR8KxzM8ZW6M5q7izXofC11p+AmK6/WUdd7+fq/UF/9q1Q0z9if64Ynle4lpBiWOUxYdDPZ4CuKP8xqANvcPE3uxJS6pVHyFJ7+f4veYno86Og4hde47367Px2vpbWsRW5pbIq9bJkjQTerMhItwelPMKwqlJLKDAAbSqK7kPoaNopFd25o65supM3X3h7h/CUQePFfoytDI8JZ1VxOghzfuIWbhNOeKRKo/2FKwGV0bB+aninPRd8IS4NEiBU0rpaCalzV8gFQ6mIlfxLwmPbeW7XqaSRiSlJ+QfthnTP9qIoxVNsgsh9WB3I7fVoj5gF0P4vbgqKpTR2GEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by BN9PR11MB5289.namprd11.prod.outlook.com (2603:10b6:408:136::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Wed, 13 May
 2026 06:51:08 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%4]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 06:51:08 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: ilpo.jarvinen@linux.intel.com, gregkh@linuxfoundation.org
Cc: stable@kernel.org, andriy.shevchenko@linux.intel.com, wander@redhat.com,
        chris.friesen@windriver.com, linux-serial@vger.kernel.org,
        "Bandal, Shankar" <shankar.bandal@intel.com>,
        "Murthy, Shanth" <shanth.murthy@intel.com>,
        Ionut Nechita <ionut.nechita@windriver.com>
Subject: [PATCH v2 6.12.y 09/10] serial: 8250_dw: Rework IIR_NO_INT handling to stop interrupt storm
Date: Wed, 13 May 2026 09:50:27 +0300
Message-ID: <20260513065028.112468-10-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260513065028.112468-1-ionut.nechita@windriver.com>
References: <20260513065028.112468-1-ionut.nechita@windriver.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR06CA0105.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::34) To SJ2PR11MB7546.namprd11.prod.outlook.com
 (2603:10b6:a03:4cc::8)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|BN9PR11MB5289:EE_
X-MS-Office365-Filtering-Correlation-Id: 26d21633-b85e-495b-f1ef-08deb0bc02e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|52116014|10070799003|11063799003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	O48roJwbJrIi6tYHXnH5M098vmiKefFDPyTv8HJrqQHtLI6z7GyoderhdXx5IDAOFq0vbQvYizRh5joNy0FEAKxWShKOEI1gBLJ+vEZpE6WLUQuS0a8qTQQpia3+3AgveIT794nyfjtWFbjYuyJbd+0esJQuloNxvt9msYGwiXq7SL2AKgUxAucso653bjcL5g6jL0S4W8ukMnPRa0o6L6q7RHdc381n/SZyzVBL+rHlT6ILNEfWUOOOLzELR5FG++8jURv/TRdKJ2P8NtVOF3wvLU0dlLyl9QjrTGFxgeih8GrCnI+0c+YuZr4XWVsOklaWNfnptwPgSPm9SKIlM+X0tk6ozCEBniM9dTJLKD6H2OFpL3GpemZuuDcK8A8a+A8a9JSFyzADQ1mJdumuC4l1Vr+ZthfGoSJEQFHUMTMTgDtFozYTIp+rCbBrOp943K+tbwewuYOpUgWDcu9QmMAIVaz3dUd0yLdeXSwvxArvKJxxhRs3+eVjh/LILH0k1bccHBi/fqFyu1vR1zVe1pu25goNusONdwAXZAcMrOV2FkSbi/F/X6qbMVdBdOiTCU9sFRHXVm5GhR8iYyzRSbu9X0a/8ISBEev6pftjTmgYZmPAQs2bNY4pPUjgrgYafvbS8fg1JZd/seq8dPF7/Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(52116014)(10070799003)(11063799003)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R0lRR0t2SjZFbEE0VW9nV1FUSVhUcmUwMDh2QThhbXBtcnA5aXJwcldpU25z?=
 =?utf-8?B?aENiOEovZlByYnp6VlJ0VzRvVUVPUGp4em5ZR1NTeUJ1ZFNWRWZVdWxzTkN6?=
 =?utf-8?B?UDRGOTRxTWZrc242SHE5bGsxN09tMjlSNEkybUMyNTV1cmxrVmFXTXY3djg2?=
 =?utf-8?B?NkM4VEwxMER1QzNCRnFoZG40RDkxOER3YSs3dndyOTZOQjZoNGhDbmVDWWwx?=
 =?utf-8?B?OXpyOFo4elZBa1BnZnNKSnBvK2lTdjU3bUNCdXdScDFOa2JwVHAwYVhLeW8v?=
 =?utf-8?B?cjhDL040SVF6ek1MSGRjRXJQV1p5Zys1MjVzbEZrWm5vRHZDSGNiakRpbzAz?=
 =?utf-8?B?UWpWOWhIV0EyMzVqWEVLVDdUWnVxWXBEczgwczBldzZ6N01Vd0FHNUh2Zjlr?=
 =?utf-8?B?bjFWY3BLa0ozbjBRQW1qcTZJNkpaYUxZTzJBczlySVc2dCtyNkc3Ym9xb3ZY?=
 =?utf-8?B?aFU2TWFzRkhQWHR6YmQ0V0dYb0dFaHY3R0gxRUlWVEw2ZzdTWWUwN3BhY1k0?=
 =?utf-8?B?YWpIbmFLSXRwTElVc1VzOEJieTMyMURtdmhTQU5ZbjhieTRQSWxJOHF3cDQz?=
 =?utf-8?B?czhXN0E3aXFqcmVwMGtDbURaWDZsY2Z1WHI4OUh5UW11WkhaTnA2VVZPN0Qv?=
 =?utf-8?B?L2NxZ0J1alV0MVBYMmQzblNhTkVuTERwWE01MncyNnVzcDErdHFJRm5FQ3pU?=
 =?utf-8?B?a1BId1AzSlBPVmtEY2FhNzJEQ1cvZlVRVW5waHk1N0ZkdjlMK2dpY1Y4TUJB?=
 =?utf-8?B?YlZPT2pzY2IyOSs0S21zdFF3SnZXS0tuVHJDeGhWSHBUbEZUVFBtMmFyUEEy?=
 =?utf-8?B?QVBqN0pZTlJINzkveVZpM2dkK0E1am9mRE9lWnJacXA2Slp0UnBoSnVzSG52?=
 =?utf-8?B?MmFDWXI0NW9UdGk3cXhzdGtLZUN4NkJsNldCS3dTVExSbWtXbjlsMHYyTmF3?=
 =?utf-8?B?TmZpVTFyZmtMQnNOZVB4N01TcUdpMmdrNndUMUxYRFpYYWViUlY3QytncEJF?=
 =?utf-8?B?dWZRQmJMK1I0eEozUDBCQ0J6YVFFTmxiVXE1bFU5bUo3M1ZhZkFHSWVlV3pu?=
 =?utf-8?B?RUNKYm5URzNjM1hYN0ROdTFmVElXL3UrRnNENDB1YW9vZkZRYmVFc3ptR0lw?=
 =?utf-8?B?YXp0YXI2ZGtjaFkybjdaU1BLQnlLSVRpYWtacHJIUGhUTzVXNENtbGFPdWRi?=
 =?utf-8?B?SGJYem8rS3VaVVQ4VFZaZ3grd0RrNXdJVzhuUFUyNlFRTEl2YlBPV3ZPdE5r?=
 =?utf-8?B?cW5WKy94QkdBNy9Gc1MxYnQ5L1FzZUE2a0RnVElKaWJHZmF3YXhlenJjRUs2?=
 =?utf-8?B?MUQwNkpPZ1l1eWJsc1p5RGhsQWR6UEREZEszSmZGV2tSdm51V21waWp0VFJK?=
 =?utf-8?B?ZmpXNVhIcXdwL1IvTllTc0cvOUlhaEV2TjJuVnRZSEdra0lMQUJIVjBmdDl0?=
 =?utf-8?B?UTFGYjY0aitpM3JqUUphWVJNUmk5QXcwUlRkYkt3elZFcHloUlgxWStHQldT?=
 =?utf-8?B?U0NyN1lnRGU3c2ZjeVJNSWtEQUVYOXorNGNlcDB2b25EVXVGTWpraC81Smlj?=
 =?utf-8?B?NVZRNUgwZDVFRWFtcHNwN1NXQnJKTFlHSzFtWEJJbWFxRWltaFJJNlJXR3Zq?=
 =?utf-8?B?NmdWcU54bFdtZEZuaGVLVUtMcHM4TlQyK3plNzBncG1CeFZQQ1A2V0J2UXI0?=
 =?utf-8?B?NHg4U1A0REJ4aTFSMmhabkZjajBhWGMvS0NFSFBoVlAxVStJcU1sUkErcWZW?=
 =?utf-8?B?cVRGeVFTeHdyWTcrOGdnZmhXMGdZY2FmazZOZ3RmVkVIaktUQlNJTzR5UU1i?=
 =?utf-8?B?cGpVYm9wWjRDbVhwUXJrbjFYRVJkNmFqWG0zVjhtTGROMXBnd3d5TTd3aUFh?=
 =?utf-8?B?dnU1cTE1NW9wbzBrRHc2L3RYdHdwZnJvb2F1Rnh2U04xT0RRa3Q2b0J2RUlW?=
 =?utf-8?B?WGdjWU5HdkIvTHdOekxDbkRJamZFS3JPWDFoSERRaDU0SkFWSWdlYStRdlVL?=
 =?utf-8?B?ellyYzBnZ2ZDUmgzWnZzVmZrdENpbDBKcGs4dnJqMHlkM3ZJQmdVLzBsT1g3?=
 =?utf-8?B?My9VekhoRHVCNTZVKzQvd2orUjhxMmhMeC8wLzhGdVJpbVNDQTZnYmpiRlln?=
 =?utf-8?B?TG11TG5SR1lUUGd4SEJXZER0M1lLNStXZDZlOTNPL0FnRW5UOEE2MU1DQ1JV?=
 =?utf-8?B?U2x3eDcwd3ZwSEVpQldpdktnRm1IVDlJYUxtRzVWTXZ0RHp5SmJucjNTc3M5?=
 =?utf-8?B?V2FFS0sxMjl5TmFybnRoTXNvTUJhY0JWNHBaRmt6L29pbFdObmZmSjlKRmhu?=
 =?utf-8?B?Qnh4VG5QOVFlWlhwU2JTYzdNWi9sa21wRElZdWRjRmREdnpLdGhCMld0TWtj?=
 =?utf-8?Q?Y42lCQYQ9baU9AEbZ9eBcvSMHcP6MevCNXwwsiJzUU1MU?=
X-MS-Exchange-AntiSpam-MessageData-1: Q4b6idaaY7P4tiORUHVo4ZMW4c/2B1xc+X0=
X-Exchange-RoutingPolicyChecked:
	EQ20cfAlaZBjMwXjK5dOXGS6VntmqUeUJhOFvbQpVGVsblpJLeFSiG7OTWkV+qC6wuZgdJVSMSzwiijnHxejCM9CBwR7n6LDbDCk11p1fU/rXj/mr6+LkfPJKNkiMjQ2r0usuASA/XcHyjPu3eKkYtdG8JIr6E5ggXC1mcI+KdjaryoML+LargiV6/LP/j6GyNqmj+j3Tm6jUXsSWyIKcWruViQmcQgkghVvxpL562Mci9ajEcCyFQDvMiquUgeuI/mUOIHTBAR6rmxxO90sZT+NzR68PZjl0yZkWdw3czNk8fa1mM05OXi2s/XD6Q19EabnA9dEY2bRUW8V5xrgsw==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26d21633-b85e-495b-f1ef-08deb0bc02e5
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 06:51:08.4536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YcMt2kTZW5wo5H1uttewGHd3PvQQPO32Q3W7TRS17YQg/p5OB6Dv+zeQ7b5GYIgVX8QU85A9pPowU3sh22h/6y1lja7mvII42Xcs9UYxYD8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5289
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDA2OCBTYWx0ZWRfXwYvpR/zxRFl3
 sU+LYW/wla8o0HNOgJn+cyV7rWx/6+vGcGW5Kkd2XOMq6F0T/jE1FZ6Dno5gMNplVgvjfxQ6+4y
 fgof0Z4//lvoE/C2v1vahwtwCiKl7V729nZe5hucXLHldKLqXvGeh97311PY0IHGRDra57gg7zk
 VFIB9Ujt9JlaKyOD+Hb0v6b1oH+ppJbKgbJlmb7atrxwJ2aExfChSpL1o5ujJks2P6t+4inQjdk
 BZZah7MaSpfgpLHmNfE5yZ7AtlUxQKa4phs4rr3lnPV79kU1sB8E2YBj6P0Z1nlDkESwcimd7MV
 dVBYa70ndpGD/w0pZ5MvoGAXUwPHbJ6T6XnsEZkFzoxFbVj+NUasBWmfZPMcI2mkdMNirbVBv+C
 xe+4+lSCsXjbSCzgq+C0681MUHP5hkRpUkQMdcKFF2qvEbMDh7HoeY1BQjNzFXxi4tQ8PNapE1S
 rUbpknI7fsrIZUn3zkg==
X-Proofpoint-ORIG-GUID: k2547x-HbijlVgDV3SygEH8fb4GnV5MT
X-Proofpoint-GUID: k2547x-HbijlVgDV3SygEH8fb4GnV5MT
X-Authority-Analysis: v=2.4 cv=Q7jiJY2a c=1 sm=1 tr=0 ts=6a041f5e cx=c_pps
 a=6WLOJMs9f1Zj6h4O4QgpUA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22 a=iKiJcTA2PjBS6x5JeXcw:22
 a=bC-a23v3AAAA:8 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8
 a=t7CeM3EgAAAA:8 a=T2nZPKwYVU4eKQKICpkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=FO4_E8m0qiDe52t0p3_H:22 a=Yupwre4RP9_Eg_Bd0iYG:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605130068

From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

commit 73a4ed8f9efaaaf8207614ccc1c9d5ca1888f23a upstream.

INTC10EE UART can end up into an interrupt storm where it reports
IIR_NO_INT (0x1). If the storm happens during active UART operation, it
is promptly stopped by IIR value change due to Rx or Tx events.
However, when there is no activity, either due to idle serial line or
due to specific circumstances such as during shutdown that writes
IER=0, there is nothing to stop the storm.

During shutdown the storm is particularly problematic because
serial8250_do_shutdown() calls synchronize_irq() that will hang in
waiting for the storm to finish which never happens.

This problem can also result in triggering a warning:

  irq 45: nobody cared (try booting with the "irqpoll" option)
  [...snip...]
  handlers:
    serial8250_interrupt
  Disabling IRQ #45

Normal means to reset interrupt status by reading LSR, MSR, USR, or RX
register do not result in the UART deasserting the IRQ.

Add a quirk to INTC10EE UARTs to enable Tx interrupts if UART's Tx is
currently empty and inactive. Rework IIR_NO_INT to keep track of the
number of consecutive IIR_NO_INT, and on fourth one perform the quirk.
Enabling Tx interrupts should change IIR value from IIR_NO_INT to
IIR_THRI which has been observed to stop the storm.

Fixes: e92fad024929 ("serial: 8250_dw: Add ACPI ID for Granite Rapids-D UART")
Cc: stable <stable@kernel.org>
Reported-by: Bandal, Shankar <shankar.bandal@intel.com>
Tested-by: Bandal, Shankar <shankar.bandal@intel.com>
Tested-by: Murthy, Shanth <shanth.murthy@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Link: https://patch.msgid.link/20260203171049.4353-6-ilpo.jarvinen@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[Ionut: adapt to 6.12.y - in dw8250_probe() resolve the trivial
 conflict against commit c213375e3283 ("serial: 8250_dw: Call
 dw8250_quirks() conditionally") not backported here: keep the
 existing 6.12.y unconditional dw8250_quirks() call and add only
 p->shutdown = dw8250_shutdown in an else-if branch; do not add
 the upstream-only dw8250_setup_dma_filter(p, data) call nor
 the redundant p->handle_irq = dw8250_handle_irq assignment
 (already done unconditionally earlier in dw8250_probe()).]
Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
---
 drivers/tty/serial/8250/8250_dw.c | 66 +++++++++++++++++++++++++++++--
 1 file changed, 63 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 1460eaf2a3a3..c24659f0b309 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -61,6 +61,13 @@
 #define DW_UART_QUIRK_IS_DMA_FC		BIT(3)
 #define DW_UART_QUIRK_APMC0D08		BIT(4)
 #define DW_UART_QUIRK_CPR_VALUE		BIT(5)
+#define DW_UART_QUIRK_IER_KICK		BIT(6)
+
+/*
+ * Number of consecutive IIR_NO_INT interrupts required to trigger interrupt
+ * storm prevention code.
+ */
+#define DW_UART_QUIRK_IER_KICK_THRES	4
 
 struct dw8250_platform_data {
 	u8 usr_reg;
@@ -82,6 +89,8 @@ struct dw8250_data {
 
 	unsigned int		skip_autocfg:1;
 	unsigned int		uart_16550_compatible:1;
+
+	u8			no_int_count;
 };
 
 static inline struct dw8250_data *to_dw8250_data(struct dw8250_port_data *data)
@@ -308,6 +317,29 @@ static unsigned int dw8250_serial_in32be(struct uart_port *p, int offset)
        return dw8250_modify_msr(p, offset, value);
 }
 
+/*
+ * INTC10EE UART can IRQ storm while reporting IIR_NO_INT. Inducing IIR value
+ * change has been observed to break the storm.
+ *
+ * If Tx is empty (THRE asserted), we use here IER_THRI to cause IIR_NO_INT ->
+ * IIR_THRI transition.
+ */
+static void dw8250_quirk_ier_kick(struct uart_port *p)
+{
+	struct uart_8250_port *up = up_to_u8250p(p);
+	u32 lsr;
+
+	if (up->ier & UART_IER_THRI)
+		return;
+
+	lsr = serial_lsr_in(up);
+	if (!(lsr & UART_LSR_THRE))
+		return;
+
+	serial_port_out(p, UART_IER, up->ier | UART_IER_THRI);
+	serial_port_in(p, UART_LCR);		/* safe, no side-effects */
+	serial_port_out(p, UART_IER, up->ier);
+}
 
 static int dw8250_handle_irq(struct uart_port *p)
 {
@@ -318,18 +350,30 @@ static int dw8250_handle_irq(struct uart_port *p)
 	unsigned int quirks = d->pdata->quirks;
 	unsigned int status;
 
+	guard(uart_port_lock_irqsave)(p);
+
 	switch (FIELD_GET(DW_UART_IIR_IID, iir)) {
 	case UART_IIR_NO_INT:
+		if (d->uart_16550_compatible || up->dma)
+			return 0;
+
+		if (quirks & DW_UART_QUIRK_IER_KICK &&
+		    d->no_int_count == (DW_UART_QUIRK_IER_KICK_THRES - 1))
+			dw8250_quirk_ier_kick(p);
+		d->no_int_count = (d->no_int_count + 1) % DW_UART_QUIRK_IER_KICK_THRES;
+
 		return 0;
 
 	case UART_IIR_BUSY:
 		/* Clear the USR */
 		serial_port_in(p, d->pdata->usr_reg);
 
+		d->no_int_count = 0;
+
 		return 1;
 	}
 
-	guard(uart_port_lock_irqsave)(p);
+	d->no_int_count = 0;
 
 	/*
 	 * There are ways to get Designware-based UARTs into a state where
@@ -558,6 +602,14 @@ static void dw8250_reset_control_assert(void *data)
 	reset_control_assert(data);
 }
 
+static void dw8250_shutdown(struct uart_port *port)
+{
+	struct dw8250_data *d = to_dw8250_data(port->private_data);
+
+	serial8250_do_shutdown(port);
+	d->no_int_count = 0;
+}
+
 static int dw8250_probe(struct platform_device *pdev)
 {
 	struct uart_8250_port uart = {}, *up = &uart;
@@ -683,8 +735,11 @@ static int dw8250_probe(struct platform_device *pdev)
 	dw8250_quirks(p, data);
 
 	/* If the Busy Functionality is not implemented, don't handle it */
-	if (data->uart_16550_compatible)
+	if (data->uart_16550_compatible) {
 		p->handle_irq = NULL;
+	} else if (data->pdata) {
+		p->shutdown = dw8250_shutdown;
+	}
 
 	if (!data->skip_autocfg)
 		dw8250_setup_port(p);
@@ -816,6 +871,11 @@ static const struct dw8250_platform_data dw8250_skip_set_rate_data = {
 	.quirks = DW_UART_QUIRK_SKIP_SET_RATE,
 };
 
+static const struct dw8250_platform_data dw8250_intc10ee = {
+	.usr_reg = DW_UART_USR,
+	.quirks = DW_UART_QUIRK_IER_KICK,
+};
+
 static const struct of_device_id dw8250_of_match[] = {
 	{ .compatible = "snps,dw-apb-uart", .data = &dw8250_dw_apb },
 	{ .compatible = "cavium,octeon-3860-uart", .data = &dw8250_octeon_3860_data },
@@ -845,7 +905,7 @@ static const struct acpi_device_id dw8250_acpi_match[] = {
 	{ "INT33C5", (kernel_ulong_t)&dw8250_dw_apb },
 	{ "INT3434", (kernel_ulong_t)&dw8250_dw_apb },
 	{ "INT3435", (kernel_ulong_t)&dw8250_dw_apb },
-	{ "INTC10EE", (kernel_ulong_t)&dw8250_dw_apb },
+	{ "INTC10EE", (kernel_ulong_t)&dw8250_intc10ee },
 	{ },
 };
 MODULE_DEVICE_TABLE(acpi, dw8250_acpi_match);
-- 
2.54.0

