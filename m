Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010023.outbound.protection.outlook.com [52.101.56.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB9A46AA98;
	Fri, 16 Oct 2026 09:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792142939; cv=fail; b=bnXB+OUDu0BwCRdNlHkGQEH40Y/+A81nwdQgRNpXNwUe9S/DM8ik039YVdT05ghGmji1XsTgYrkBYkk7vFY1rACXtNsHmbSGwpCJf7Uy/QpcE10/pl//OozxPPVyXblMa/VUvqf7Mya4gqWmyTt8U4R2lU/XvvE7g/WmwTQVEEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792142939; c=relaxed/simple;
	bh=p/YHvFErQz4kaUpOi5z7sbwR2NcQLuwKnWgUZL/bBZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PlEHpiKeOcAaqTeBRN87TZwMkRaitI2nXLHdmTt71TL3QZb3WGnQeTpE8O3lTp6f7jzF3JvfrGEc6PwvjqVTdj5jpfwhuGHML/nIHolM2oMrXDCE/27LzPQJ801tF35/bjDCOKVpmMam+Tk1iQl07iodGdRmfiSQiyGDMsvC36I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=A3Lz90Qk; arc=fail smtp.client-ip=52.101.56.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="A3Lz90Qk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FhnYE0xNpKm+BhZLOTlTG7zW+M2LvEIt5c/376KSTULs++Otiwyv4BAwh9YXEfyA9B4RTRdyLOlS7EmHbkowXsP11PiL37v7kn2zaeE17m5RTw7koRMm63L4vG+D3xHX5OK4RheGJHOZeOB2k+uQYLTB3KxxREZKnSIXo9FkwoJS9CPaqYi3mWdljnMTbLhVWUTvrzU110JMnxMXiZKEiQXTEeM61cTx7zW4NnZe3Whj6+IWRIqYc536/M5pQHlBaWZOQgK2/zWVM+kWV+NADkvARxXXRuen867zYwZ8VHNP4HzPMKZ0PiR8Tp7cxfUBGpqxe7CmoRLIMzKi2YEiZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p/YHvFErQz4kaUpOi5z7sbwR2NcQLuwKnWgUZL/bBZQ=;
 b=Y6RwMKrUy99IEqnwiOZ0H51azowLIBPAvIzGtRzGt2AzKe67cPaLOQRt7svBDFfN17rJhBUpdbKiwwncZFvDbJD7ASnmOkkzw2JZXKC+inNPnBSRBwecqsuAMVFKgBkJ+/pkxd4pG96wNZdvFSnZy7UGFHzPZN+8ksF9ZeipWmBWGyqwlqSMouB85hROyJu5MRclenh09YBw62JJDNTMfW8OU82/qJR7uNELRnjmCS8VwAtzwbohGGrZocsResaNLL6LEPs315LgxdkhmAHumO1xQ7Desv2tUjN6DdGccLcl5oYUfEPbJcECpz9HYP2RZSufDGmxH96LMcynmxFhGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p/YHvFErQz4kaUpOi5z7sbwR2NcQLuwKnWgUZL/bBZQ=;
 b=A3Lz90Qku2CcrSjEYiuLu2/H2Ep/xCPm7WzkYUYI7+9s4wggdRBhPg07Mqbcm74/oLM6fBklMWd0IMussPlVc290xCutmeLazQubm2IH5oeRACssZLkI3PmA14RVTmHaTeVvqWrpNsdAtml+0AFDvwXYUE+xBZ7B9mGxt0O6UFqoIs7uk2kwxzw0YSE1RkQoYEaMgMwgUGte2ECmbewjqX4MPuhK7wx5A2FgP5mTxbAIPYhG4P3VyaE248MgQtDZBfmpIJGdxmz5uf71q8Enf2AklgGz11jnPVLA7A6aA1NXxCfqIOH3Qo83vHCqpBFCuNGDsfmJbPuPwL3K6WKPkw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5974.namprd12.prod.outlook.com (2603:10b6:510:1d9::19)
 by BN5PR12MB9539.namprd12.prod.outlook.com (2603:10b6:408:2aa::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Fri, 16 Oct
 2026 09:28:54 +0000
Received: from PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0]) by PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0%3]) with mapi id 15.21.0522.012; Fri, 16 Oct 2026
 09:28:54 +0000
From: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-usb@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH 10/11] tty: Add NVIDIA LSTP UART driver
Date: Fri, 16 Oct 2026 12:28:19 +0300
Message-ID: <20261016092821.2049721-8-aambrozewicz@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <sashiko-outbox-168497@kernel.org>
References: <20261012-lstp-usb-adapter-v1-0-aambrozewicz@nvidia.com> <20261012-lstp-usb-adapter-v1-10-aambrozewicz@nvidia.com> <sashiko-outbox-168497@kernel.org>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0196.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:44::22) To PH7PR12MB5974.namprd12.prod.outlook.com
 (2603:10b6:510:1d9::19)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5974:EE_|BN5PR12MB9539:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fa92cfa-8152-4da8-46ba-08df2b67e5d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|56012099006|4143699003|11063799006|261009223027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	i7WCpt3Yax11PN4PvLgOPHJnjAe7vbFVB0yBgI5Iy2abxeCsSsINVIt/H1h8TmXAq+ig22YSFgiMhKpIXwWGrO+sl/MOlXwjAgX1VZeGCnjZpv9xWW7Yoq6TmkbiFkyWqrODxQYwPpvVBUlrVRUyOyXXZUFEwoBaxdWusW8XOAX7yLxpAzLFFXU/GAXFurVfvN1SR1Piod85UxkSI4AGIcOb10w2QYuCcV3QnMGI1EsXSwhc7qw8OPJ4HjG5T9KwpXajblzT512K+n9GKrMjy97/N5kSqbHwDSo5LHshROpq9s8MccYqeEDulhaBXIz8Ht75qaSeOnicXIL1H9F4WGAax7arjpRiGS4BVThNsFVff80po2F5jXXShQhtkotrrxuLQCUlhP+3XbaYmMuKb39CduyzDtiaQgQcYoW42Dygwkx+gJ6rpCLWXGcocudI72cSB40vYC+hrTMqlgLYsyHTBtIeK58zxzbXyzOGE63gdmz6AShbU1Mh3ZgXniXAi0CiQvlVi01AudFIaFIouC4zPQW39csvKRSOIsOTtMkzixZI5Oax2eltnzpIbAU1sO5ePgVTLGOjXemvf8NmhBPkeESfGbMzXY+4xzbIpBDY01tiPSDbm4oCvKqu8K9g7cPgpO6RW7uXqYaoAmd26RwkEvxTmuYiN8lAGveMfiE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5974.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(56012099006)(4143699003)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wn8du0hoJt56seszlyzCBz5dWlEaEWrj595HJeJqwZyYGykq3K8vn6u+rqPt?=
 =?us-ascii?Q?jCPAqhgr/bxV25Fyd3UkZxTRHU3CIhwkBWK9yYwXlAG4K8hyR9DBu1fybzrX?=
 =?us-ascii?Q?5pdNUXdcuu7rFcZ3HkMiFMP59Uv0WQkckf9ZtdfJ0i1vAateC8bLMguJrQSD?=
 =?us-ascii?Q?3YnYzeVh6OifOghKxPBeVwvI4mN0zSw+GCNHbZ1NePBMsNGP1/EfXwjK3ZCA?=
 =?us-ascii?Q?tvUiV8wGSwLosT1ELcVQfqbu0rrtYMRBd4wv4HzKov1QRLzMIGmbNkBsVlXF?=
 =?us-ascii?Q?xK+boxoGMMbfW7YpK8dHLUxOENyAQrI1J8tPKwo4OnAhNbCTQcOFKcj6t9Rl?=
 =?us-ascii?Q?U24o43Gcd4EubabxAQT7Ja/A6zl2lHgCqnwwyAmvMIiAK3/MhdGfanDDSbkF?=
 =?us-ascii?Q?L+c5HE4R1BIT1+2U+uYUKO3ET7rRNG0dx/oKwJGyXER8CnSmJw/qPzZIPewS?=
 =?us-ascii?Q?iykS6cT236R+F7khgkdIe/5kkb6YBL6LXHxqSYf/V01+LJNYJfUEjgi6V5Y+?=
 =?us-ascii?Q?ISbgSUsZNEQfKPY8PyUXvTkgl5xVi69W8fpDrvnWYqQ2UNWLrZcpSDWu7ad3?=
 =?us-ascii?Q?Jxv5bpdfbaop5KYWqKwHI1Dt9lVwqDbM+lO7ZaGmd7D0atVnh3Cz1SiaAItN?=
 =?us-ascii?Q?vgjbe8SAyFHLi/wNKQeJGnO4MmORYpAAGYVlZjWsEdnPHE5Qt/FqvvW2rmsB?=
 =?us-ascii?Q?w9G7koB0ALEqBwn1Jg+EZAZttixjrY9EDAnIcjUeGdFRugIZrOfSjMeD69tq?=
 =?us-ascii?Q?p9+5tl9E5ji1F6wVwtYgwXlXfXgEGQ+XD7bjRrZ4F0/WhM5kNvIxstkURBl6?=
 =?us-ascii?Q?J1rDw2ZBO/UhH6e7LNtntZCis0UiAajEjpoRVK8KFeS0MBJJXZIXfwHvqqRn?=
 =?us-ascii?Q?NEuML4pI/Ag5MUVgBSQjgwoic2VdwhynTgyxmRfzEG6Ybq3D+edpwk8yLA82?=
 =?us-ascii?Q?wfjTc3ToNwjKSNGZxsk8hmrNKoeQxqr18nbiY1UBmLMe0vB+iI7tMuUTn6Kj?=
 =?us-ascii?Q?ZpSocTKQja7xfQfiqtCh9cTqoRzH2f4O2TwVtaYMGmURcu2dkWmAWv9tM4FK?=
 =?us-ascii?Q?9nYxFZoXe37ak5WLJzbFx9OZklyTghaCymxXCUau5usLfFizKTmtu5WA0MCr?=
 =?us-ascii?Q?vROYsQa3cJCJLg1O+p0RdlyaY5QfehR+Z2u6K9v2BPSLlw1fYosMalSlQj5u?=
 =?us-ascii?Q?F2O6tB1CRMssaujtQi45uH6bPoACVJzb4aXuhtZzk/qC+l9U6EqdKUCisvFp?=
 =?us-ascii?Q?VD09Q6XVdoXpjnpJds4F4y/uOJbcKVYSH/Lng8nBpxfT0bHw/16z3XKqZwnL?=
 =?us-ascii?Q?S/zMUQQquoOphGTW31D6kGO5a/27HZazlH/0QUna88enBV7diwv2p4G7r4o5?=
 =?us-ascii?Q?/cabe8hMNR2xxdsn8iYcaISoJPMZwTBPceypeozzqu/900AA7TCUK/BF4AWH?=
 =?us-ascii?Q?ti2hhKHgHe4E6iP97RJbKlw+f559U4G2j1DnxWdyk7owctvRGGFyIffhXJcB?=
 =?us-ascii?Q?Xnrca0uMew80GZuqJlzMzOvZhxgpMckiGuzY/w7qfM+dtVXVMdcUtl1+373O?=
 =?us-ascii?Q?JjkVMI69OJaYy5ULo1w2HHfIuRZsITU3Y6vdcH2wQ1p67/Hj3+m4G1fqLDY9?=
 =?us-ascii?Q?q3Hxil4bsMz0qat8VjJcX7wNPVm9DAHodisViANC686DACDXXLKNsJDRN6UB?=
 =?us-ascii?Q?5eKkifD6s1POmPkHN0hNLVoopNSsmR9XTeCJP1wwQXVbPBFCQ8cIKmlF1FG/?=
 =?us-ascii?Q?MRxltXejhw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fa92cfa-8152-4da8-46ba-08df2b67e5d0
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5974.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 09:28:54.8171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0W/p2CkZ7ybCCFDZst5XqWUqTNXpXod9JtAnOcD9IA9RJnC+ocyLMaAvj5gg6HNqNMYeDDiRsosAEAnGECpnXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9539

On Mon, Oct 12, 2026 at 05:50:52PM +0000, sashiko-bot@kernel.org wrote:
> If the firmware persistently responds with LSTP_NACK and the loop exhausts
> all LSTP_UART_NAK_MAX_RETRIES, does this exit with ret equal to 0 instead of
> an error code? When lstp_request transmits successfully over USB but the
> firmware NACKs, it populates lstp_status with LSTP_NACK and returns 0.

No. lstp_request() returns -ENXIO when the device answers with a NACK,
along with setting lstp_status. After the last retry, ret is -ENXIO:
the warning is printed, and lstp_uart_write_work() does not count the
bytes as sent.

[...]
> Is a final cancel_work_sync needed here before freeing ctx?
>
> If lstp_port_shutdown cancels the work locklessly, a concurrent
> lstp_tty_write could acquire write_lock, see the channel as still connected,
> and call schedule_work on ctx->write_work.

Unbind is covered: tty_vhangup() runs lstp_port_shutdown(), which
cancels the work. But I can't rule out a write arriving after shutdown
on a port that stays open, and destruct shouldn't depend on that. This
will be addressed in v2.

Adrian
