Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011036.outbound.protection.outlook.com [52.101.62.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9DB33F8A4;
	Fri, 16 Jan 2026 05:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768542010; cv=fail; b=i1rFaZy7AhzjW6QFNBAgxh4GD1k1+15du8VO6wLJQnvxKDU0AgCegm0ZmwuNHtJre2LX2zSRKpFNeKTV/4OMyFLr4P75JU0UiWinDgJ6bFda6LO91cy/m+yWJT+P6GHro+lvPdNXG6f+eQsV8Lq6joqChbghNbyuu7Trxdm5LH8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768542010; c=relaxed/simple;
	bh=YbeuD+wAU6Wq/YZjHRjJzyB4XJ/Je3SlL/71ED9I3cQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Akz0m4jx8Zlc2SCrq5ZfsSStpLtK1g2u3KTLcldhAzMAMkwzuYtQBxI17VNboglmjbV8FH62AlToEm8kzftySx8HF57YuzFkqTTxqyrHycGfigHfTIIffvFsChZdGMHTuhx8JRra8MU9foBjt6lVupN0DXtWZnnMWTKV/QlrOkY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=CS4KSfYz; arc=fail smtp.client-ip=52.101.62.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="CS4KSfYz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V6C9yDYKGIy28ZPHHhRRZJXawMWYnEr1SOpGhCkWqQyYwR1lZHovY+xJqgy/LbdlXG/KRgWEGtzz75krYcJJ93Lw6Ctl23C/2CeEQuHF0+WVkrMfbSa1gc6qg5dOUb5Ro05dOKI+hUDkeG+IHwDFiXEsAJl7r0/ye7J6okQ68D95ArwqdpY4kxgxDKTkJut4B4A7sMcfTZHaUhLdeVNYXEwMJvHjz5dlWkL+aXAT57DeqPhEglRqDhAJueJ/iITLmt8qj0e0MKef5C3u2P58hUPYxF2ANIvZzHGhU7BjZNJ/9u1eugLSe70dE+GgWTUH93xyo5G8H2rscoKRFF+9gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZMdtDOCnMHP7WZm4xeoArw0Is7nzRQYx/60ZsCTXG3M=;
 b=sBAvRoFz35FckojVDnB7KEzBPiYi1nrAbFKizLYBiLXbyQLRNnFf4C6O1i2nW1Dj7sFL8lTzORHbaHhjeUn1uQSFrrTKif5MbK+Vk7lET1Ji9QR+PyUJ6Fq+qwmpwuVNdQheoiGGEdP5VcVrf0Up47+rTphbVR6HdcA0ogG9LBLxIfoNBtnMDcKjwqxrWS3hIc5Ircx1MVqrqGw4mH9xksCVTrUJ/H9fGYs46NnCI681hGiHLGqPVsWN5FxZzpPF948sUUMl6D+G6J0dQCdNyaqRWS9Zye3itpTfisk1t/DhaNS6tUgnUwwrywUFQhBCNLdZZI9VsUWzqqI+wdjZfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZMdtDOCnMHP7WZm4xeoArw0Is7nzRQYx/60ZsCTXG3M=;
 b=CS4KSfYzhV+kIR3+ft/JaLKKCNAe++0OKsp1JQegm8Uw1zlcRkWfjYWH7gEKmBO41Wp1Emoe36Zf2FSMlmwCSA7KUqrdQfsYVVXgdxNEpmJyFGLbAu0K7IhdRWQrpbRadZTwk1Zj7UypvFijGx7gUp+AlrLFz9bh/wmzlID2T7U=
Received: from SJ0PR03CA0094.namprd03.prod.outlook.com (2603:10b6:a03:333::9)
 by PH0PR10MB997665.namprd10.prod.outlook.com (2603:10b6:510:384::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Fri, 16 Jan
 2026 05:40:06 +0000
Received: from MWH0EPF000971E7.namprd02.prod.outlook.com
 (2603:10b6:a03:333:cafe::13) by SJ0PR03CA0094.outlook.office365.com
 (2603:10b6:a03:333::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.8 via Frontend Transport; Fri,
 16 Jan 2026 05:40:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 MWH0EPF000971E7.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Fri, 16 Jan 2026 05:40:06 +0000
Received: from DLEE200.ent.ti.com (157.170.170.75) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 15 Jan
 2026 23:40:04 -0600
Received: from DLEE213.ent.ti.com (157.170.170.116) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 15 Jan
 2026 23:40:03 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 15 Jan 2026 23:40:03 -0600
Received: from localhost (lcpd911.dhcp.ti.com [172.24.233.130])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60G5e2Dx2760208;
	Thu, 15 Jan 2026 23:40:03 -0600
Date: Fri, 16 Jan 2026 11:10:02 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Kendall Willis <k-willis@ti.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
	<jirislaby@kernel.org>, <vishalm@ti.com>, <sebin.francis@ti.com>,
	<msp@baylibre.com>, <khilman@baylibre.com>, <a-kaur@ti.com>,
	<s-kochidanadu@ti.com>, <linux-kernel@vger.kernel.org>,
	<linux-serial@vger.kernel.org>
Subject: Re: [PATCH] serial: 8250: omap: set out-of-band wakeup if wakeup
 pinctrl exists
Message-ID: <20260116054002.sm6i47bwl4kha73k@lcpd911>
References: <20251230-uart-wakeup-v1-1-13f1bb905f14@ti.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251230-uart-wakeup-v1-1-13f1bb905f14@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E7:EE_|PH0PR10MB997665:EE_
X-MS-Office365-Filtering-Correlation-Id: 96350429-06d0-433b-4402-08de54c1b459
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|34020700016|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UhyRvnxiuUutsa0xMui0rWzL2ML98qrP4qoZnLNNGo0Zx1N8hCjHPBGXcBJ8?=
 =?us-ascii?Q?1BcCLoL7Bpz2pu3fOcnbg18VwvgQQPx9qPY5tLYbRbt+6djkQD2lPS/Pvya6?=
 =?us-ascii?Q?T6o1Jl4NQ7JdHebPyk7BrTcD8IijUgz2q02HHXYf1Lzece+srrkwg2KZ6+W2?=
 =?us-ascii?Q?/15MKIsgQOHoi6MLH6XtNeHa3dhGOoEnUFeNeoPUT2TT0QmBYjgOuVh2nNv/?=
 =?us-ascii?Q?K13XsYvfUe/uE3FuU2BlNF394kZp7ADvkdCx0KChIX33rOJzZ3sFeIF+wH5I?=
 =?us-ascii?Q?fuiR/RMiWJB72B+BL8rjLE0IT1SEnWuNZKf2mqW733MtewwoF/qJJj6gdB3y?=
 =?us-ascii?Q?ldUOm33uY1vqSnKZJD32axZIprEnrrMNL0+B+J03QLNHeUGaszyDfF9Q7w4m?=
 =?us-ascii?Q?cH66Ld7BQqWQAEBriIlNq+RQz+9/W3Ns27EIvRReMk1Vi8nfV12eyEFe3f9/?=
 =?us-ascii?Q?2rbWm/wzZh1XCZLkiTESNd3TdB15dY8ibAkwEHnxB0eGgA+kjf9aplZwrttN?=
 =?us-ascii?Q?GwKQ4R/We7EQMXX/Mg4c9780lVkgsYBpWyHXK3dov5ZgwGf5BxSJrfYIIVUm?=
 =?us-ascii?Q?qOLynkALMzoqDbLLZc6dLGMr5sQv79aeP3shZgeEAMGsAIJO/B5h2RzfN9k7?=
 =?us-ascii?Q?3rpmDVqbRKoaiCFlze47ojN1+z+ZPH6YAJ+VmvS9uNYuF4FNjIvRLEEZj/aI?=
 =?us-ascii?Q?al0hQlu38kJYBUs6P8qRdDTx6M84at9xAdB8klxp0BQXzDksl0P0SD4RytGs?=
 =?us-ascii?Q?cQ10nnI1/zOq6EmMpuP4j0kpMzg5tMwjWSMbeRVeq+5LVjmOemaoTeUNd6Me?=
 =?us-ascii?Q?NwIcdGDnGOQlSTaFyV85RnJJowvAatUtkFbxuxnP4oWAdfmvAlCYbEEcSDO7?=
 =?us-ascii?Q?0tiTE15o2HPMUPWb03A2oUtsVEeqfknhilR+7/QPkjkAbUvxFNI4PpFhFgh1?=
 =?us-ascii?Q?WzIcaDiA4bnjOdapD/6O0SdkVMcwpTNBqw0AauCYfttTHUDCd4JjGY4mujR9?=
 =?us-ascii?Q?jdthqAtA/yI3PstM00/OCS4CUqYW+P0s/JkLwmB50umV5isUsroh6yeGIMWG?=
 =?us-ascii?Q?HXQrfd8qQubXhK7ciNJZgMPWWSbyn9p7vB37whgc4xWSwz5K+WeP3IMV+ru+?=
 =?us-ascii?Q?6AilHi8sPsA2Y3tILA3gvAiy3Yk23JoXztMnrjfafuYLpxkLo0NuRho1J2f1?=
 =?us-ascii?Q?09mDQ1LsnBUhmjU/4gBayDMTN7gYoG+I+PoSlKkCBhQov49/L6E/Fa1KGyBt?=
 =?us-ascii?Q?08RxnQ4Ryo1iCe4AOtkYJIRrfgAne/olkEhT0c0EUG4i4vN8w9rygI6jP0Hz?=
 =?us-ascii?Q?6sE/KjperWZHO1xWH2NIhldqaUQ+gJMFdexdNfIZnozwkdbV7F0Emh48n81g?=
 =?us-ascii?Q?sx4UrSLfCQAknbElFztql6bK2d89nBmZ8aolWRkEd7NuFHhhkFFdcCEA5Sqb?=
 =?us-ascii?Q?Vun+ekI1e4fCW/rN4NCJd5hShtlHq6fIj4JsIYx4zuRoc1O6boxL/W08a4aH?=
 =?us-ascii?Q?eFHBjpE05tl7bQ57c9hmR2Rvj7OKLK7e+Zd591EJYo2Er4i0tSOF6o63bPZS?=
 =?us-ascii?Q?+ruiq3Cwekqck2DI6j3MJWZYV+EQGr8qVCE6jO0trkZX/0HB91FlTQOzqibC?=
 =?us-ascii?Q?emodxV12FRDLg6UeVKAE53J7aTIX7v44z66/UgyH6N29uRs3Ne/n4pn6kL6g?=
 =?us-ascii?Q?Oda1XQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(34020700016)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 05:40:06.3008
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96350429-06d0-433b-4402-08de54c1b459
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB997665

On Dec 30, 2025 at 15:24:51 -0600, Kendall Willis wrote:
> In TI K3 SoCs, I/O daisy chaining is used to allow wakeup from UART when
> the UART controller is off. Set UART device as wakeup capable using
> out-of-band wakeup if the 'wakeup' pinctrl state exists and the device may
> wakeup.
> 
> Signed-off-by: Kendall Willis <k-willis@ti.com>
> ---
> Implementation
> --------------
> This patch is intended to be implemented along with the following
> series. This patch has no dependencies on any of the other series:
> 
> 1. "pmdomain: ti_sci: handle wakeup constraint for out-of-band wakeup":
>    Skips setting constraints for wakeup sources that have out-of-band
>    wakeup capability.
>    https://github.com/kwillis01/linux/commits/v6.19/uart-daisy-chain/pmdomain
> 
> 2. "serial: 8250: omap: set out-of-band wakeup if wakeup pinctrl exists"
>    (this patch): Implements out-of-band wakeup from the UARTs for TI K3
>    SoCs
>    https://github.com/kwillis01/linux/tree/v6.19/uart-daisy-chain/uart-wakeup
> 
> 3. "arm64: dts: ti: k3-am62: Support Main UART wakeup": Implements the
>    functionality to wakeup the system from the Main UART
>    https://github.com/kwillis01/linux/tree/b4/uart-daisy-chain-dts
> 
> Testing
> -------
> Tested on a AM62P SK EVM board with all series and dependencies
> implemented. Suspend/resume verified with the Main UART wakeup source
> by entering a keypress on the console.
> 
> This github branch has all the necessary patches to test the series
> using v6.19-rc1:
> https://github.com/kwillis01/linux/tree/v6.19/uart-daisy-chain/all
> ---
>  drivers/tty/serial/8250/8250_omap.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
> index 9e49ef48b851bf6cd3b04a77a4d0d7b4e064dc5f..6a5722b722650c1710e79fb76fc1a01cdeccc68f 100644
> --- a/drivers/tty/serial/8250/8250_omap.c
> +++ b/drivers/tty/serial/8250/8250_omap.c
> @@ -1363,6 +1363,8 @@ static int omap8250_select_wakeup_pinctrl(struct device *dev,
>  	if (!device_may_wakeup(dev))
>  		return 0;
>  
> +	device_set_out_band_wakeup(dev);
> +

Reviewed-by: Dhruva Gole <d-gole@ti.com>

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated
