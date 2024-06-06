Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2067.outbound.protection.outlook.com [40.107.100.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B3D19D898;
	Thu,  6 Jun 2024 06:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717656679; cv=fail; b=MfwxBnV+VXpZvyHxTApnxf/nLDFPWmXoLxJJhT5wtZNk14I/5HdYiqbF8Y8GhInoCOqKcF+284U0BBGIndHdJ4i/8OXdKAfNMJX/+2VW4qKo5ZtNsWpQotwkWUzYglG5QmA1KsyY0ugqU3FaBHgvIMAh/5ipwS/aHUXlm/YGIyI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717656679; c=relaxed/simple;
	bh=nGvW4yOXM4JnO1HUKDUS/bk+9RulcBQl9R66MLoM6gI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qSum2QR3wp+iezEt/InfnskU6Yy77N3UR2yfylUWgRBBPs9q5vKeOirNrwxLUTmn7/0dDdV/xomB1EpRDHi6rRWu7MxOdr6z5S4nj14MIqUijiou5zw1gnhWGURJu8V+8++PkOPJw+QAOS+e6Tpmw7N/vEkXAAhJ7tdaiCAGjSA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (1024-bit key) header.d=Sony.onmicrosoft.com header.i=@Sony.onmicrosoft.com header.b=eyLVBPdx; arc=fail smtp.client-ip=40.107.100.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=Sony.onmicrosoft.com header.i=@Sony.onmicrosoft.com header.b="eyLVBPdx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lAz4qE4+27xk67s7wY6+5nttPfkJ/+vhlLJi4OY1GkApV3I92vCsZhQR8Be2YfH2djcwbMMNlnqNMqXFPa6fb9yhLynfUcQJyNwNhvv8VyEXN0mKZMNMvE8QHXwyZGJdqgjUiVEsCUVC+nCj99NM8ImfwCB0dd7ot9/xH8znOTWBm4bvqzd5OhpniFpuT5WTFY9dOIvY4m3lhaK27jgqZFWOmFnjNjD57aFAMD04G7AyEOyyK5dSx9iv7boklDszK/6SUTvj3tCKsQSYFAZ6EEdJ+BFd+yVL2319ADOlEIXlHA19Vtb5FCItEX0C0vPImFoRLkIcBc7mZjmUVn0ZoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zWnl6b3x/8NzNd6mnRPaBXIO0coTbMS4V1K0jRQSvYw=;
 b=UBPMvDOiD1mjJgEiyE/Zg3mW3nIv51pGYEnw9sRxGXkdV0vjKbQv8x19hyVTfh+zWdV0KdqQltVpmx6vIQflXrJNgrWGr0IVPUtgJ6CsJFRLXhJoBbKWZP8Ga6P/BpUIUT170tND5StUjpPvj6hBRXxlmSnEMfWyTr3w2hMjUyK2Gs8D479Mguyy7LMEUHfaadLqa54caG+QG3M8CloCfmQV2PGTqinpqyWa5xeF9XIIqPeuiOrPrJRLYnUqApz25C0Rq6fK7RL0hMcxBJ0Ztk5nnmpRgixoA8rB5C22mR9fuQ7dZInxocTzrwmNI4ZAJ/ObREcPIomcRvD4Oiox9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 121.100.38.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=sony.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=sony.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Sony.onmicrosoft.com;
 s=selector2-Sony-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zWnl6b3x/8NzNd6mnRPaBXIO0coTbMS4V1K0jRQSvYw=;
 b=eyLVBPdxHa2JQCsmQofeuQ/XtIlYDeSEiJxwCaMych3xrnkzuHaBz9+dx+ohFay1UbH2mZK1Huydkzwrby4KY0kAhZ+bYpydD9b7uKhT8jVhAuOSWu6yz9+hWwhpZiytwkYUiwTnBk1cKE9LP3f1scXnJaTfN6pMKHDx1alujoM=
Received: from CH2PR14CA0041.namprd14.prod.outlook.com (2603:10b6:610:56::21)
 by PH0PR13MB4987.namprd13.prod.outlook.com (2603:10b6:510:75::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.20; Thu, 6 Jun
 2024 06:51:14 +0000
Received: from CH1PEPF0000AD83.namprd04.prod.outlook.com
 (2603:10b6:610:56:cafe::56) by CH2PR14CA0041.outlook.office365.com
 (2603:10b6:610:56::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31 via Frontend
 Transport; Thu, 6 Jun 2024 06:51:13 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 121.100.38.198)
 smtp.mailfrom=sony.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=sony.com;
Received-SPF: Fail (protection.outlook.com: domain of sony.com does not
 designate 121.100.38.198 as permitted sender)
 receiver=protection.outlook.com; client-ip=121.100.38.198;
 helo=gepdcl09.sg.gdce.sony.com.sg;
Received: from gepdcl09.sg.gdce.sony.com.sg (121.100.38.198) by
 CH1PEPF0000AD83.mail.protection.outlook.com (10.167.244.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Thu, 6 Jun 2024 06:51:13 +0000
Received: from gepdcl02.s.gdce.sony.com.sg (SGGDCSE1NS07.sony.com.sg [146.215.123.196])
	by gepdcl09.sg.gdce.sony.com.sg (8.14.7/8.14.4) with ESMTP id 4566ogC1000973;
	Thu, 6 Jun 2024 14:50:54 +0800
Received: from mail.sony.com ([43.88.80.246])
	by gepdcl02.s.gdce.sony.com.sg (8.14.7/8.14.4) with ESMTP id 4566ofwH016350;
	Thu, 6 Jun 2024 14:50:41 +0800
Received: by mail.sony.com (Postfix, from userid 1001)
	id 1E7731D8018C; Thu,  6 Jun 2024 12:20:41 +0530 (IST)
Date: Thu, 6 Jun 2024 12:20:40 +0530
From: Sreenath Vijayan <sreenath.vijayan@sony.com>
To: Petr Mladek <pmladek@suse.com>
Cc: john.ogness@linutronix.de, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        taichi.shimoyashiki@sony.com, daniel.palmer@sony.com,
        anandakumar.balasubramaniam@sony.com
Subject: Re: [PATCH] printk: Rename console_replay_all() and update context
Message-ID: <ZmFcQPDi+de6egqY@sreenath.vijayan@sony.com>
References: <66582edb.650a0220.8de7.c591SMTPIN_ADDED_BROKEN@mx.google.com>
 <ZlmPAZUeKIDFKLdf@pathway.suse.cz>
 <Zl7Lo5eGJKLjbTUc@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zl7Lo5eGJKLjbTUc@pathway.suse.cz>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD83:EE_|PH0PR13MB4987:EE_
X-MS-Office365-Filtering-Correlation-Id: d093c78b-f195-4d0d-4bf8-08dc85f50e93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|376005|36860700004|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rKKr1rMzBILCjpRCXAzPd0kIUcicY13L2Y7GuH7EEK9xZxLj0rHVfanwG66M?=
 =?us-ascii?Q?hK+mI4NNrq14gQsiQ9epr7OMv/Z37tpgRixy90WC/afwxSvFN2L71iVdcxXU?=
 =?us-ascii?Q?b0Jawt2ISHgV/dme+TddAjIsie4mI/+g3N8epWndoZhNtm+0Y8CqncmO9+gJ?=
 =?us-ascii?Q?xHZpOsX5wgfaJ0spqIfURMjsbh2hQlVR9wsqrfChnu5wGeQ4oxcGm1XpuFvf?=
 =?us-ascii?Q?8ZSpi1GhBsnbjOgKo/QXEqzxEiHLypthwJYJ67xOur4YTBA+iMahnHZj2EF1?=
 =?us-ascii?Q?It2j0xwdVeci5gB1i3sHxOTEMlEiWdqvzus7GDYDL7n92ee8zAaSYRgxnQjQ?=
 =?us-ascii?Q?Wx1SdFzSpG6IVL8libxWy0glOcZQ1XTYTvVm4mc2dt7o4kONhv4OzolEjoBp?=
 =?us-ascii?Q?a12GefQ3as3/9v76PLNUkEfqlxoIyTpyFLe4Gy5rJmWt/+iZWCofHbqBpCEh?=
 =?us-ascii?Q?Gkmv7PGvD8ApNgSY9ma0F0iqX8CXBZ4iTxzd976LxNiBGewuOo5aE8r7IEvz?=
 =?us-ascii?Q?hivg3VTzQ0zYSzXQ2awl/weVXQfaN7LE131+fWN9Be7v0WzH0n9zRrImoQZu?=
 =?us-ascii?Q?ejyEUBRuc4FuQorZDrPs8XOxe7oaX2YBJZAmY9tNqzKXc5msP8uDRFmVju4m?=
 =?us-ascii?Q?4vcorABL3ylhaZbP1mkSP2ZXYVtuapZEcE7O3l3/LNwN8voUaUPlLh+Dgf0v?=
 =?us-ascii?Q?XVp6bkf74X+zcJ1SE74OglB/5NRppRz1Q3PpYGui50lPJb0GIHPfZMDcSSjF?=
 =?us-ascii?Q?cR/ovmnGPiVCUN3ogF89Qo+Sar7rr7yzZFLWBD8GDiLoNhABETTOJqRZMFeJ?=
 =?us-ascii?Q?R7ZrM1HSC5YILfn4Fbu8znwD98zcPk3+eITwLEj7KsSFANUEn8vRWAqLP2nE?=
 =?us-ascii?Q?oqPbC4Jslu1iH/KXNIGsbedHzY7J8sLoGsU1ip+xaXuUZ9WqXts/ms5DxKmU?=
 =?us-ascii?Q?YFAJp6j3o1Mp0oj1awidu78tY6+9VHr6Jq/o56sJu1+0pHVrAqueqCfUMuyI?=
 =?us-ascii?Q?AunL/5IJ+zdsDYQGqQeUG8oD7+5GFQr5178Y3KieGefEHKTjDprZnEDmXOxr?=
 =?us-ascii?Q?4MHRD1gRi+hvAvm0mZPTBZDn3mkKJ5bJUzdfTtPVKHPwX4vJbGolN4xsf0Vz?=
 =?us-ascii?Q?NCk6jB3f5GB6h/Rj4H9EnOIGLIzCvxGEOvcIDcG9nO38DB9KrhuhQKxGVz2a?=
 =?us-ascii?Q?N1tNkUZX1sR8ZX4s4hREDf0T/+TmAELNr8sUkj+aOmLnMBXEU6lrJ8XH41zE?=
 =?us-ascii?Q?8BAJ7eZQWkcByR18EOB1xTdUNrtst7h2f5WOogIZUwot1eotj6+0VNvhXquW?=
 =?us-ascii?Q?dG4pwQokhTtp148tPNDfbplPYIjvoJNzs9tswlGdPh9yHHwt32hNN7pqcyKy?=
 =?us-ascii?Q?uHOnNBoAsicQoDGJGgXnyb8FD9ClqJcEDcmZ8+VG9wQNajoU9g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:121.100.38.198;CTRY:SG;LANG:;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:gepdcl09.sg.gdce.sony.com.sg;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400017)(376005)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 06:51:13.0596
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d093c78b-f195-4d0d-4bf8-08dc85f50e93
X-MS-Exchange-CrossTenant-Id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=66c65d8a-9158-4521-a2d8-664963db48e4;Ip=[121.100.38.198];Helo=[gepdcl09.sg.gdce.sony.com.sg]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CH1PEPF0000AD83.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR13MB4987

On Tue, Jun 04, 2024 at 10:09:07AM +0200, Petr Mladek wrote:
> On Fri 2024-05-31 10:49:08, Petr Mladek wrote:
> > On Thu 2024-05-30 13:15:47, Sreenath Vijayan wrote:
> > > Rename console_replay_all() to console_try_replay_all() to make
> > > clear that the implementation is best effort. Also, the function
> > > should not be called in NMI context as it takes locks, so update
> > > the comment in code.
> > > 
> > > Fixes: 693f75b91a91 ("printk: Add function to replay kernel log on consoles")
> > > Fixes: 1b743485e27f ("tty/sysrq: Replay kernel log messages on consoles via sysrq")
> > > Suggested-by: Petr Mladek <pmladek@suse.com>
> > > Signed-off-by: Shimoyashiki Taichi <taichi.shimoyashiki@sony.com>
> > > Signed-off-by: Sreenath Vijayan <sreenath.vijayan@sony.com>
> > 
> > Thanks for the fix.
> > 
> > Reviewed-by: Petr Mladek <pmladek@suse.com>
>  
> > PS: I am going to queue it for 6.11. It is not critical
> >     to hurry it into 6.10-rcX.
> 
> JFYI, the patch has been comitted into printk/linux.git,
> branch for-6.11.
>

Ok, thank you for the update.
 
> BTW:
> 
> I have pushed a patch which came to my mailbox with ID
> 
>    66582edb.650a0220.8de7.c591SMTPIN_ADDED_BROKEN@mx.google.com
> 
> >From some reasons, it is not available in the official archive
> at lore.kernel.org. Instead, I have mentioned in the commit
> message
> 
>      https://lore.kernel.org/r/Zlguq/wU21Z8MqI4@sreenath.vijayan@sony.com
> 
> which points to the same patch (same changes), exists at
> lore.kernel.org but I havn't got that one from some reason.
> 
> Best Regards,
> Petr

Understood.

Regards,
Sreenath
