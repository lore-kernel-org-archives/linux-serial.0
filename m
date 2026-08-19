Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012058.outbound.protection.outlook.com [40.107.75.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C679429827;
	Wed, 19 Aug 2026 09:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787130467; cv=fail; b=JEsYgwckU+m+ox3aWFaklWzxrNb78gnZIIPJLyyuqAjZxTnbKuxjvuc6U548DfryFEXhT7j6T/NU01vXl/MiyvlbTTcDkBmCZlSjT9wvQXDt3W2nauhxJTflHNqhgEJKDDC1luP2W3rmRXUE2wsDZlQFCxrgCIuV26uOj1N1r5U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787130467; c=relaxed/simple;
	bh=5prq5f4hxZkOT2Wf0LxG/d4hyhq/SPbSXuj8qbduv8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LqlvKOU8X1Mw7nOxu5G8FCe/2RGuiVHwZe+JdhLmJmucowGNnYDWaZ5rJAgc5UAaxl6NmuwiRj7dEwj+jx5WrUiaYZ4sGzJ/NDVv7CyQIsvn29+sz/KZXpMIp5WyOBK0bR8olvw+YC1LUo+gHRDTyyeLgJD/OY6+NzyuqFbjwuc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=GaTBEDy5; arc=fail smtp.client-ip=40.107.75.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="GaTBEDy5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GDrRWeptClzr5VcnWDIdqusm08eIo9gj1GbRp6/7dSyO803stLdjdJXnRLG16BC81iXO+7E546/Mxll3ywXWk/Ktyc+LC2oUPySriwXi4hfmp2qfb8mExf6wqMmFCHuae3UvfGSjl/Zq20fXCApjfh/na3Jv//08Hz0iDpFVAOm9hfSeFuAFGNlgZqLieeinR3/8aG2wV6GpZ/uPasvrO9pSU37MjiOtoosF0dRWOmZETmI8ryJwVG4BL2QS+FIiSj0oWcpwvCqSemgfu0r3zE7eFlXoYzAlAdJMsgj1O+AFmWID6BSD8kIS1LQqLNhGQ2oFvRniVpqXFgX2l+wkCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KGXCtg46Ad+kMEqyKzmXSx5CvZaFJ0mCARgk+d/DcCc=;
 b=Z+qZTS+0N08+tQPNldF7seIMwHmDGwH4GJTOZ/DMFfWhBaGjV1V+B9BukuDuC3kbGgworPysvTB9Z5LnlxI5oSDh845d45Js1+wWoSJWboiklr3NG09A/AsQQ6OUFZltfkJo45YX+/1Wj9RRmmZANq9ouhCxQ1JgoQiIJ2Gok5JvJQ7kiVBAsLv5a2R6FBSNTDe76kWw0FWjmvYEyqFEyC9/A4QlUQAuOuio4keC3hlgs0Rm0LdRuEp5WOawvx04+XEu+qOKDDf2Mz4/sts7L5/PNpIUrB5i7IzzteX468IQ9but4aJvKhvP27g5YlywFIliJ+wTVRRgpKBnOYbxcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KGXCtg46Ad+kMEqyKzmXSx5CvZaFJ0mCARgk+d/DcCc=;
 b=GaTBEDy5coqejTtbu4O3n+thiq+2VMMWv8EcJy5uoY1UbBzy+KGd4hR2IMnnTrBh4/8q/Ok8864MJ7vPE9geZy5K8TXZxQ9Zxy4AL4ITuVNLUtpOUc1M0nliZG0JK1PZmK0M83mxwt7c3w2+71Sqm1Futj15dMsRhg9iYJ/VSQE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by SEL0PFC835A01E4.apcprd01.prod.exchangelabs.com
 (2603:1096:108:1::5d0) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Wed, 19 Aug
 2026 09:07:40 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717%4]) with mapi id 15.21.0315.016; Wed, 19 Aug 2026
 09:07:39 +0000
Date: Wed, 19 Aug 2026 17:07:35 +0800
From: Crescent Hsieh <crescentcy.hsieh@moxa.com>
To: Linmao Li <lilinmao@kylinos.cn>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	Gerhard Engleder <gerhard@engleder-embedded.com>,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] serial: 8250_mxpcie: set the driver data before
 registering ports
Message-ID: <aoVyV8x0HgCrCGv2@moxa-KabyLake-H>
References: <20260818093918.3190686-1-lilinmao@kylinos.cn>
 <20260818093918.3190686-2-lilinmao@kylinos.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260818093918.3190686-2-lilinmao@kylinos.cn>
X-ClientProxiedBy: TPYP295CA0012.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:9::17) To PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|SEL0PFC835A01E4:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d38e106-9c43-4524-3057-08defdd15107
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|52116014|376014|38350700014|6133799003|10067099003|4143699003|5023799004|56012099006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	l/2Lo5YdX80l1nofb/HBRkJWWeYain329MlukudcPO/c+cjmgA2bjMoQtd9A/9kd5Lxltx5kVSCeGkLzmKH4Xt1ixXRmOy7FAfSTtHzv8VEVvn+ldnAnq9VjGJMhJma9HKtLGYdunIvC3cq30Crrm7OYNaZ39/6FfRkm33Sten8EWzUEr9A3AwxOho4CevxXy6nKrCEgfTVrI5KbNBmz345EyKvCVGqdSPhlVq8OEDMJIMosiK3RST2iZuuJ4hBch+Vg/iI6ImG45x8lbv5JCs5/7fjfX/JxHCB1RW7f8BnqTARaLB9dgvXs1QqRdHVo7avgSthPWcqlKvRjU1SiHUy/iNiSYKm/VyBuq7w3Zyq4l9nus+vdaZBkR4aBc09gq3tDdudCZnyCrkzRMfSrcKPUwIILzZoZG8futhOzPqXEkAPKW44MqpDV9zrYI9IYCCl+BWS76lcr2D2w34L8nR+k4q6d4jsiL8eC1jXFDr6pkqs1sWmWX7LTQfF7J3bo34TFqUZVSLRC+8HwFu2pZdljnDTRTkyzKwl2YXZYxhrR+omlcDWWJGdfJFQH43bIorVwWmUgX2jH2MPq/1VHx5iLqyOjwMrwLSCnGsvsD1OgfNdwmTVq/1q+N3buMstUTADEgL7gmsxf34NeZ4UeUl3KE6RIyEo5qqSAzimAglsr1W4ftyckpQkojXx+XuBb3bk60wbmAls2UDADdwNShwPDY+e2G7QwktokWXuZpVs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(52116014)(376014)(38350700014)(6133799003)(10067099003)(4143699003)(5023799004)(56012099006)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KxNNvJ61ujau82N8XPebahksQ236TOlxZOo5GAxNjGEgjPth8CmbT4vTcDE9?=
 =?us-ascii?Q?st0dDNtaQrLQkfBGGBfbrfrsdvbgG70TkQ4++ZcZYyayS4eCZatNZkRSawER?=
 =?us-ascii?Q?F0eoVJc66DVaeyeu3Q1ziKkZPetynqvtnwTOW5GN0DMjyMoJKffidqd9mz5w?=
 =?us-ascii?Q?UFmyH9sgIPc2kteFQV1bDBerrU/MsoGeksMfameSLhX9aItvxE0mAG3SebdL?=
 =?us-ascii?Q?v6onR0p/gL3yn+msxX6HVg065kPnGz8SYtfm5jlmygZVMR8SEQfOMnRRBcIs?=
 =?us-ascii?Q?EyTTrAsdVzUOEw80z+cevuJv5CwqGkkGkjYFOg4P8yw7SRkm8EP2cf05N3G9?=
 =?us-ascii?Q?HnQSpLJ9crPKwtmo9osOwqybjilq77yUfZc3R0yzEJu1h2BZqGJAfaq0bp+p?=
 =?us-ascii?Q?lrA6D71cvqBMlmr74IS3XU+yBeuuYCSU8S7gTPHOTHRdb+UD4LJXcKRcxtnD?=
 =?us-ascii?Q?maaW/NdXBqu4wbUOqeciy2vRBAxPV5ZDJ1UXnm2qzDCUypepuHixFKurJ2Qr?=
 =?us-ascii?Q?rSnpp1UIpQjSPnVIOeZuQwgQ7IoOQEOhiqAZZTRU+B7ii2to5Xps/8EsRhbM?=
 =?us-ascii?Q?DTPl+yW9WTZjtVQtasSzGowa1ip2e2mTmvcSvO7PXhmvoxAbfwM8eC3O517Q?=
 =?us-ascii?Q?CbRSwuc9ET30K9b765Ef20olizAzeypLVwrqVyOMB6NXU3kFwsHsUvSGeCh7?=
 =?us-ascii?Q?4DqbKK+1glixG7KfykTv7/oDY3fxUDjs6muCThwewdm2mObsRtyZN/i2iWh7?=
 =?us-ascii?Q?bybJADUeB4OMdMUPq8gvBk4DW2Ja3MYCNHZrypZrIhF13aQ8O3ZM2lUlxy/Y?=
 =?us-ascii?Q?Fn5g/Aa5dZ8QdnovOWB6kkGe1Vzjqjm/F+jHaYa0de3aLAmYRpfSe+WVUNHs?=
 =?us-ascii?Q?hX3YckT8l9ND8Fm51pCmtB3KoNR+2mYCuautAdcTSwxI5+dDabF17c6T4zt/?=
 =?us-ascii?Q?B4kQ1+ntohmkd6zFcgkYhht1dWAAr4nj3yyjXixoNOwiYMXMCKxUG8fSihGe?=
 =?us-ascii?Q?t2K1wCRlyBwBtz0vTcpS+IHWISUuBuRNZWBPU9MK9ydLF4egDxNsUziAlGcM?=
 =?us-ascii?Q?YV70wGsl6bcTKYOffW9L8QCw+FXC/BtJcGV/CqtcVfZaWqPpulUHoUsalRdi?=
 =?us-ascii?Q?YxEdm4jIG3Xc48jcpAklJ9Ya9RN6xojGZoW73KWhDNrx+zhJGq3tzMt+4vfj?=
 =?us-ascii?Q?8oq4bFxuDHWtqkpV7yZ7iIUIb5ViRuFm1E7avkdETfMsJh3zwzAv2EYo+Jo1?=
 =?us-ascii?Q?8E949U3fIu4tuuH3/TgI6q8BGbFkY485f+uED3ur8xal+CY321ZKPSY3W68d?=
 =?us-ascii?Q?bl4PULpGX3BbWVNHNRzF0gx05u2PoR+/coOr7+pdB2KDxfb+qkIp3Adj+Rgl?=
 =?us-ascii?Q?i91RFyciZmMoqgDDaMXTJ2lrC4T6XqwDi0Vb8w+/QAfHDBcqrobONoBxNz4J?=
 =?us-ascii?Q?O9U8RXKzJpGzWRe4D2znTVL+FfltXOTV0LGveKO1bc5qX6AuZwHbJv+Y0dp1?=
 =?us-ascii?Q?g3qpv61Iqr58MX/lCKXSMFDbjImvHXGGE9ENJ/j2cpvLsb5YXpaGzzj70HoZ?=
 =?us-ascii?Q?Y+RtYJ745GbKWvGONXgZZ5/JJMAcrEpzPRAPoONAzChQP/743E5JGcr8pZ0t?=
 =?us-ascii?Q?7FVF9fmiV4OP0UPdqx4j044tdAZJGAeH5fIeAOQfKPnaRFPB8k+Yz2hvI31p?=
 =?us-ascii?Q?by6OJipK8DP8LYixVx+P8cIlGlztwG5+ixcmeOPKEW5Tyc3qAxOud1sAXlkk?=
 =?us-ascii?Q?Ew1Vpr3v2P8NDUiC2M1sDpB08dTdqmg=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d38e106-9c43-4524-3057-08defdd15107
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 09:07:38.9725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4CSdplKOarXt2FKmXGBuwbceIigmS9NXfcV+YG7HplnuL5b6qaEQg1x9fR9abXr+hRakCDbJu+DggXYL6H661vZSERKa95xXV/qGGe/hlxc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEL0PFC835A01E4

On Tue, Aug 18, 2026 at 05:39:16PM +0800, Linmao Li wrote:
> mxpcie8250_rs485_config() looks the board up with dev_get_drvdata() on
> the PCI device, but pci_set_drvdata() only runs after the registration
> loop.  Where mxpcie8250_setup_port() presets rs485.flags to
> SER_RS485_ENABLED, uart_configure_port() calls ->rs485_config() from
> inside serial8250_register_8250_port(), and the callback dereferences a
> NULL board pointer.
> 
> Publish the driver data before the first port is registered.
> 
> Fixes: d21a1509c623 ("serial: 8250_mxpcie: support serial interface mode switching")
> Signed-off-by: Linmao Li <lilinmao@kylinos.cn>

Hi,

Thanks for pointing this out.

I tried to reproduce the NULL pointer dereference with a CP-134EL-A on
an ACPI x86 system, but the callback was not reached during port
registration.

The driver initially sets the RS485 flags to 0x201
(SER_RS485_ENABLED | SER_RS485_MODE_RS422) and directly programs the
hardware interface for RS422. However, uart_get_rs485_mode() finds an
ACPI firmware node and changes the flags to 0x202 because the node does
not provide the linux,rs485-enabled-at-boot-time property.

uart_configure_port() subsequently calls uart_rs485_config(), but the
latter returns without calling mxpcie8250_rs485_config() because
SER_RS485_ENABLED is no longer set. Therefore, the NULL driver-data
pointer is not dereferenced on this system.

This also leaves the software state inconsistent with the hardware
after initialization. The hardware is configured for RS422, while
TIOCGRS485 reports SER_RS485_MODE_RS422 without SER_RS485_ENABLED.

I also reviewed commit 6974711cf770 ("serial: Keep rs485 settings for
devices without firmware node") and its review discussion [1]. That
change preserves driver-provided defaults when no firmware node exists.
In this case, however, the PCI device has a generic ACPI firmware node
without any RS485 properties.

The driver-data ordering change still looks correct to me because
SER_RS485_ENABLED is preserved on systems without a firmware node,
allowing mxpcie8250_rs485_config() to be called during port
registration. The case where an ACPI firmware node exists but provides
no RS485 properties appears to be a separate issue that also needs to
be addressed.

[1]
https://lore.kernel.org/all/20251023151229.11774-2-gerhard@engleder-embedded.com/

---
Thanks,
Crescent Hsieh
