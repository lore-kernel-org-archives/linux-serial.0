Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013034.outbound.protection.outlook.com [40.107.162.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2CB1E0E1F;
	Thu, 25 Sep 2025 15:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758815379; cv=fail; b=TVwc5jgLhnz9rUDTvxRp/OGrLv8b90cgZhRDgiJER/ZvjspaIyoktHQHSFnlK8YbP9T08LKXqAFLN+leEFSE01OVVInVS1QNLQVeCeGJdIZbdgWRoMnaOMVcQ28MW0WbtJzDl1Y8hdPed3BvMozQSY88yrleCMtQsioBS3pKAWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758815379; c=relaxed/simple;
	bh=WLuR/q5Xr/a2z9clvmKiTXUKephaRZCOU/LUjmVNt74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=m0tf4bE/4R/PozCjM7wPbDc2Gky7v7mxPZ/hbYtBhbA8oLd1vNZTHXyYUCDv4x0srKIt5ktdtzQ1i9gjYs9V7rhRTGtX39ef1GZrGhIvUQRrJLbJ7IbUQf7FHPZxXPc9HK//Ltl0ZfDALh9dQqSvTReSnjG0MUsHK8RhhREsLe4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RRpQPGRR; arc=fail smtp.client-ip=40.107.162.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RRpQPGRR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=toc01DTvJBMwWgdmWqGLNfzyoKhCgFFqiEoA6F3iWBmHn3AWjgVwRf/2kGeYNTaC9LUn2h93BEJYEA6ON8KNrv40ccAsYI4oPEjBkPPZw6pYx186Fnfw3MhD4jYRVFXqF818RbBqCC25xFCZ5gevyjwmnT43JZW6aPv5KvMFtMUApzcV1rwkGcqgAD56RJney+JysObwuNG1qCtcx1Rqp2hoVmVqUxRpoNyesxqk11cXnBFmOxxBSO3/YrkWUedHE+r2m79MuCBX+vyXOMg0gvc845N835yISqlIEovhC8Fdt8yWuPiuqr5vT9CAQxEKl+zj1p4AEMznf7K7s9VUcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4X0F5IpGzRJuesKz3zSje/DdxHOUBEdsigZqKTrUVUk=;
 b=IYOpXpKblW+BYP9o5wu42MEK6W3spQz+OaMEJjDDzzPpXmyjIfQ7QSur5CU3CFLwtqwafdsDKHsCx4SgyEqD7+yuQaT7i275cVu9kZXoWLceSsuypuwJ0a+O9c9K5PW1VvsVSCzJ/mnQCvihXN7Mxge+VCvheUgnRSv5EqkGpk9INRwhbcz16fTyQk8AEjzdWK3qLtbOW0cp9RKxZcz+QYpahqQ5F8Q+1cFNft0CLHRj1HRPdN7XX23cFWWCp4m0its7X/4s9n02HDEnNmF+75j+U7Ew7ZWnz/7NY5JxNR7UxxIdv5mr3SWr8ZXwhnliPZElMenYl0ebnJmlgDBRsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4X0F5IpGzRJuesKz3zSje/DdxHOUBEdsigZqKTrUVUk=;
 b=RRpQPGRR5DER4Ja5w7BjwAJ6KU08E8vP4Y7SE2BiLTn2e9MS77XXDCU08/zA8PIhobG++kvzRX8nh/A20v3PGWHzq19OG2D8dlRvw7cMv2hgNeYSIcfK8nFdqrnWMM5xGUV6feqJCUn7ORTEVRy5MqYaNzq2wCihssHj4wB09SE1tjOF/6KTFBR3hZIjb8/FnucpQCsWQDLgCf9Rx+Yx3XZuvu8lp45R7GErrTLaXplE0TS5pTkGmSJn4V4MPWb3qbZAotDwKdPUywzHKXa5o3RrdthGajmWyM74VE1ZQa3S4KOhw8UTQtjqVweR2Pvd7wlvx4dYywpowOF7FXDP6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by PA1PR04MB10178.eurprd04.prod.outlook.com (2603:10a6:102:463::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.8; Thu, 25 Sep
 2025 15:49:34 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 15:49:34 +0000
Date: Thu, 25 Sep 2025 11:49:26 -0400
From: Frank Li <Frank.li@nxp.com>
To: Sherry Sun <sherry.sun@nxp.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, shawnguo@kernel.org,
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
	shenwei.wang@nxp.com, peng.fan@nxp.com,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: Re: [PATCH V3 2/2] tty: serial: imx: Add missing wakeup event
 reporting
Message-ID: <aNVkhvmZ4GThHNqD@lizhi-Precision-Tower-5810>
References: <20250925091132.2537430-1-sherry.sun@nxp.com>
 <20250925091132.2537430-3-sherry.sun@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925091132.2537430-3-sherry.sun@nxp.com>
X-ClientProxiedBy: PH7PR17CA0028.namprd17.prod.outlook.com
 (2603:10b6:510:323::8) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|PA1PR04MB10178:EE_
X-MS-Office365-Filtering-Correlation-Id: 06173d03-baa4-4a75-a797-08ddfc4b1f85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|19092799006|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GJ3LXK7MRfCagpMqFT8BdztGNisbguqp2TTHO6RjTGfNZ1ZFy2oJuKIzCqDz?=
 =?us-ascii?Q?VCA8XQsUC9aeDA8LUIx4MnPnSj2o9vAjl6mbXNrlRsDopR70YpvJuQDm09vY?=
 =?us-ascii?Q?rgXhlFCn5ff1eGh9+puoGwiIX421ryYqSURYWw00oZkUtqIEmfg+p1xmd67f?=
 =?us-ascii?Q?u72jq7+wU8Bs/Sn6sbx0FhD8gwQYTxVe8DV4KlXSKFUQuKU/zi1OmY5JxBkb?=
 =?us-ascii?Q?Aeeza3dLeDTkM78+wOoz+TGwqzZ0reNtpoxyxheb5S+bhSVAtJNFY7msePzz?=
 =?us-ascii?Q?lC8KC62wOffJYNVRltNjdDy+4+TXgX5saIm+6c2gqh2Bgz6m2Y1HQkISlVVo?=
 =?us-ascii?Q?3X07Z2cs8urR5Y/d8llNPJMhw5zEhlh40wPCv9jUz64O0jbILVAqc9yxlNC3?=
 =?us-ascii?Q?xFtEb7SNY+opPl7E0ibQW4JaEquJ+b5j6OhNKOYHcjiCvuDu1ZPTc5abJfsK?=
 =?us-ascii?Q?8KQIbl88qxO7Oj4AIcg7i5FOluCi2ZAHgK6r/qF6MihKBDHStL3PNLLp+IHq?=
 =?us-ascii?Q?fgWhnu1kMeTeiuWmSpR3ay7JttDXA9Xv/1yuRiW8OlRCi2nELM6VlUd+AhO6?=
 =?us-ascii?Q?P6jKbLMzaFxSjsspbiVveLvfKaHknDWotYEOSiKYD/QGYuOGSULreI72/2+5?=
 =?us-ascii?Q?YZG7SMcqVhWLeqDryfzjHzHho8oKLbH9RDDVyIIMmzaCO2Wk6RCKN6gx4OX6?=
 =?us-ascii?Q?9w8cxp3/2mwd7UW5LTL0/2XKMeaa8CCbJF6rhev6d8Pi91Z4oJ3tB1sX5czU?=
 =?us-ascii?Q?TNP3e4m+5hvIia/S4X0WSOPUeS2ob3+Pbiey12OAnMJlwA8Uc+UgUSeuYwIV?=
 =?us-ascii?Q?1Wq+0mHtFEPJO9l169gAqkgHd/fOq1dSRLLRVB/J1c/h1EdcQoR8G4TkX2Xo?=
 =?us-ascii?Q?DTxP119935l4i153x5VdotD7vXAiV60Lw/1PZotBDpQ62Nvef5+V0Y+ot85V?=
 =?us-ascii?Q?4hkw5aZ10QHjpodXg8NWCSHHZq/aEshz4KehwiozBQwOfUUS/XsQ1FPeAJWN?=
 =?us-ascii?Q?d/aMfoOrCuMmaoiyFTuyXw6134QV5jP3VhGs0nWOghA4HGa7ZftnhHg+420B?=
 =?us-ascii?Q?CCCO7IhCY4SRYzRLgSb/erl8ga09zOGPL2cehcg8A6b7a3cFwESKpIr1FDaw?=
 =?us-ascii?Q?kmCiJyFe8QQxB/bj+7+k4QxrrW3YxI8pcfGyrp7wkYoL8xY3Hfrx2scsmzgc?=
 =?us-ascii?Q?S05k1v1QhljShjz1gXWA7yYGaQPFkAiHpvLEMJDtc2UctsOWF+rJBoIlK/2x?=
 =?us-ascii?Q?MNkBx7qdNDIeRNpyogQuBBvx9V4PmWwHqsi4QgKfXLbnlTPZlMyT+RR55iHP?=
 =?us-ascii?Q?iYwIWoXZb21Z+sOlQWJ3ay/BaUr4NHXy5dB/09xtbFXch40F7Dm1AUR7JCNt?=
 =?us-ascii?Q?lSHjIQoaYjWZH9aU8Bt+EwEtT4ToBck/rT5H0Mu3Z0ZqNl+YOzozYf9i3460?=
 =?us-ascii?Q?s7lh9dbI2lo209XLlyOfHtcko7ygYmE0o/OrEK/cGgpKIGMf4KkWaQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(19092799006)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3V8b7Fd9GIYHrySgMHWudLVTpVgq7FZgAJKs6rc5NDkoZnxazB0Zzh12EL68?=
 =?us-ascii?Q?JVo+klzMjnZHhpU7tT+Kk4qEDWExLQRa5cH9C7mjH2viyRIOJ5yjqd1uyLJX?=
 =?us-ascii?Q?oPeXEhE1QdH4lT60vt/PfUQNIHOlj4s/qddb/dpvKl+YJGZ/w/XbpgyJfdxh?=
 =?us-ascii?Q?Dh7XPzxPTAgPVlA9BY7z7JCvZvqxIspMOlrDGbEgXrHyUimdvtUvz8x+50bR?=
 =?us-ascii?Q?dmP//0/i9cs18JBc0eu22X42sLcLJJ6NsaWB1OByUFJEt5l9ARWpvTaNy3Lh?=
 =?us-ascii?Q?2s7P1zHcv/0Wm6hddU6B7bH+KJQFvfat5FnQEN/zXC/GwdJClFcNKVFoYK1A?=
 =?us-ascii?Q?X5OjqrV15IkYRDnPXDpPr4OP/7MUghMlt+q0OS+oAlAH5ZL5x7vCkn0dXATf?=
 =?us-ascii?Q?0YfVNoNr0yi5tD6+oMRguV4EUDw5vYYgxsE12Wo3Q+UuXvOl7bm51PTACCo/?=
 =?us-ascii?Q?UPj8F6jlKbILrTtwaO3aJHzPlJy/7RGSRtlofr1HpYVujEzpD+zg3KersJ4C?=
 =?us-ascii?Q?MG1dWsvWiHUd/R7wtk3Mei5DWxRMz/Ta79MhnPpEAb8k10U4p05khqnFZOXu?=
 =?us-ascii?Q?+VDOgrrfbuwHpSznx1m9zjbJbA2824fGeTnvL3jK63lAVH1n8Fkh1SilDFcu?=
 =?us-ascii?Q?Aph8oBg9FaOSH0hUp/dzPC1ZbQoeeE03VDth2ySkSZ1LZTrN7QlBfXmelTkW?=
 =?us-ascii?Q?DrCq4s/NvZbyV4NTIrbI+3AFfWzbyBca8ENaQjuYD6/VJ5/GRbf4OPOQTin9?=
 =?us-ascii?Q?YOykADRC/Plic/lWVaLOFNQklsg9UpddcUw9dQdBGrO49FwoXwcgnlzXlaRZ?=
 =?us-ascii?Q?LDgEhY7L5y7D4q+UeDDZLS7NfR28AZk2EmGSy3MiQ2Ie5HaXYL7GfHe1mLyX?=
 =?us-ascii?Q?JVXZza1gjXSIsFXshYLR78DtVmg8nlkgax+B3QGase60iLOxPjXaKtgwtVRY?=
 =?us-ascii?Q?Ov3CIkI2VxE30idq5RAuaPq2dZA99BkdclPqVkBcmVTRf1A8r7dC8drwooVC?=
 =?us-ascii?Q?xyXnGoPzHkjGBlZY8eQE6Tkhk/Eye4IiWjiKwOiE9sXOpn2473tbKjC1nG9q?=
 =?us-ascii?Q?ckzx1EIKuXXhrFK7OZGCzWuky9ReAF/k7vXbYNGjM3Z8LR/7DmjMBywLhHyf?=
 =?us-ascii?Q?8oBO4tR3EPoyUUg7Y5Gxzmf7SQ9dcqI3WdOmc9efmg6aS1JrOWLoADZvTTzQ?=
 =?us-ascii?Q?iaHBq87XfJw9Q8OXKEq1kbHRW5g7X5KqBXyd0V25DY+MXeOtKbzswQtR3ekf?=
 =?us-ascii?Q?0ulfHpRIMaCXtWB8IK37OvoUPZPPZd9i3WWLCmgIyHXSsQa6EMln+7CrMJlq?=
 =?us-ascii?Q?QwoL3+IwgSvCxEbY84kzLe4AMM+bW+pab4EGzO90sf4OSaQhe9vf1gZBZplc?=
 =?us-ascii?Q?WtANh+iXkVZ3WSigLEdnjT3+hKkvwz1bx/e0Ux5ChVLTOiJ9Ro70R4LoySNW?=
 =?us-ascii?Q?tfhDVnHjGkGch8gWLoAWDBe9y07uyNT3WiWWy2tDd7voQsZHVQzyPUKSv37+?=
 =?us-ascii?Q?+TEHZ0WQI6I3g444vSoikdjTvCghSkSZJT1xX3w61nJuWFhRsjBNna4xPUtg?=
 =?us-ascii?Q?UQ/9ezdHdvjoLZ9Td+p+rHW+9Ko0ctncXZz1rpfY?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06173d03-baa4-4a75-a797-08ddfc4b1f85
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 15:49:34.0794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2GD6YQuHa3uUNqHd3vBFz9RBHo81JzF6V2N+2lZg/t/BbdPeRcFV7G7XPIgCDvgGS+4qKxvGA14yDyxg8wslbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10178

On Thu, Sep 25, 2025 at 05:11:32PM +0800, Sherry Sun wrote:
> Current imx uart wakeup event would not report itself as wakeup source
> through sysfs. Add pm_wakeup_event() to support it.
>
> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> ---
>  drivers/tty/serial/imx.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 87d841c0b22f..0eb3f5b8f820 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -30,7 +30,7 @@
>  #include <linux/iopoll.h>
>  #include <linux/dma-mapping.h>
>
> -#include <asm/irq.h>
> +#include <linux/irq.h>
>  #include <linux/dma/imx-dma.h>
>
>  #include "serial_mctrl_gpio.h"
> @@ -2700,8 +2700,8 @@ static void imx_uart_enable_wakeup(struct imx_port *sport, bool on)
>  	struct tty_port *port = &sport->port.state->port;
>  	struct tty_struct *tty;
>  	struct device *tty_dev;
> -	bool may_wake = false;
> -	u32 ucr3;
> +	bool may_wake = false, wake_active = false;
> +	u32 ucr3, usr1;
>
>  	tty = tty_port_tty_get(port);
>  	if (tty) {
> @@ -2716,12 +2716,14 @@ static void imx_uart_enable_wakeup(struct imx_port *sport, bool on)
>
>  	uart_port_lock_irq(&sport->port);
>
> +	usr1 = imx_uart_readl(sport, USR1);
>  	ucr3 = imx_uart_readl(sport, UCR3);
>  	if (on) {
>  		imx_uart_writel(sport, USR1_AWAKE, USR1);
>  		ucr3 |= UCR3_AWAKEN;
>  	} else {
>  		ucr3 &= ~UCR3_AWAKEN;
> +		wake_active = usr1 & USR1_AWAKE;
>  	}
>  	imx_uart_writel(sport, ucr3, UCR3);
>
> @@ -2732,10 +2734,14 @@ static void imx_uart_enable_wakeup(struct imx_port *sport, bool on)
>  			ucr1 |= UCR1_RTSDEN;
>  		} else {
>  			ucr1 &= ~UCR1_RTSDEN;
> +			wake_active |= !!(usr1 & USR1_RTSD);

I think you miss understand my means. suppose bool type only support
||, &&, ==, !=, !

	wake_active = wake_active || (usr1 & USR1_RTSD);

a |= b actually equal to a = a | b.

bool | u32,  bool convert to u32 then bitwise to u32, algthough it is
allowed, but it is strange, like bool++ is strange.  (true | 0x2 is 0x3)

bool || u32, u32 convert to bool, bool || bool is perfered.
(true || 0x2 is true)

your case the result is the same.

If sparse don't report warning, it should be fine.

Frank
  		}
>  		imx_uart_writel(sport, ucr1, UCR1);
>  	}
>
> +	if (wake_active && irqd_is_wakeup_set(irq_get_irq_data(sport->port.irq)))
> +		pm_wakeup_event(tty_port_tty_get(port)->dev, 0);
> +
>  	uart_port_unlock_irq(&sport->port);
>  }
>
> --
> 2.34.1
>
