Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011055.outbound.protection.outlook.com [40.107.130.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0331F9F73;
	Fri,  3 Oct 2025 14:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759502478; cv=fail; b=EE+NiUHQM4TJSaWK+gk5Fj1ova5bvUH9hzWyYsOmRT3/ssrWiH551WBGNghzqTfy1CQOdXc3Pibbk2sXURcLZRAcWv0aBIpSF1vbpZkoiwbAIXZdcOcdOGfAdu9Sw+LLqgO7xXNzsF/8FHiCg3Y6rfSXSWqzuJRm5NJM8bNQlcg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759502478; c=relaxed/simple;
	bh=pzWEp0rtZjnOuutFIwKeIoeQrA+TfkOEQ2MAGl88pt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=h9fb3z+C9awwzvMGojRt4IfrFFNjDC2dEiOKHhmrRdCFhS9hL8x8YbICq11okLoDfOQMADgx3QKmwcpP1Fs2THSb8y65Hlwgq6JIEKYGMyPbfZRNkbH3doo5hONDXVCHKZK3uLB5VJNmY/q9+ZH+4G1o+QPO23F30X3ts4hXkjk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=M1XjMzwa; arc=fail smtp.client-ip=40.107.130.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="M1XjMzwa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DMVz/yUD+CLqehMYlk/3yAbb8C4JUGyUWG2EKwKlYasrjNKwoemCMRN7qp5z2G/X8oWmEzbaZnNRWlI9bVAF6154aVIMIQFcCpgDnFgt+RUOl1wp8QoG0s66pLk6D/MnWLVEFg36ZhZOnTO6EG4Re2Fi9l4c+NfQU6PIeFUuU5OC6AM8DBEoHw1a4I/YoFy9MfPyLyAK425V3Frfs9iSLCELzBtiR2MQ4835Ovcwyh2ZVhW+s8tYWNwEKgUwjVCOljEaZbwd+wU7PSeXf2o5IVb24gUEoua0iT/N+PbtV83yWIW9vXh6OIevOZa6n6MS6WiM4yokd337rrGG9kqRSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JnVXQkCB1YDddDLQB8QZ2R3Z7CKnuL72YThbX4dI5dk=;
 b=Q71El0IOB8vghUTfue/+P7E+mENLpFq0FkhDaNGNuAazwHiuo1tqXPcK+hNrk3mfOHnATC+0IILK7FH+e4opB33FkNy9EWOPImIiuQ23tO4GNAEOWNNscd6o2m4DMCoGkPzkOMsiRUQEtCou+7n6Ti2ofX6DJJqfQBkvCTHKy+X3dp0Wq31PXdAKoT+Mb/Ygp20XWrxP8JzPuvHfzj1OyRhC55LkeIW5JXQrrI7VmKCDbJtLUHsnHFA7calCFV2fHsKVb+5KPRO4/jiAhVfVEQaf28L4SHQQFElKNTX36T383jcp1elHcSUU+exR2RZdhhXyRddUZsjEjZ3r0oZlFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JnVXQkCB1YDddDLQB8QZ2R3Z7CKnuL72YThbX4dI5dk=;
 b=M1XjMzwaFnotG1BubKnuyWgcqcRnnDUvo6icSuJXCBB8+0g7qVHP+KDXo8+HEtHA2cy8edcY3CF2LqQPn/KPf4K8OqePG0aNuGjrY/zAM6kyxcLXvzd5MrpzhEUMpxpk6jWe5Nsg0+rn/Tv41XOUxaPSPdaytkQtES1WA5ncKwxekocxlrR/K5Pz67+wshv+OFXC0X9VECyxVBY7zaWTLbGD/dW4SmmzgOyBUcCeWCRQv97TPNZ9v8Dq4czOa51Zm7mfSudwnbjlQCtOvB7VYaONXPuLSMUjUpIm3LD+reDkOHW/9hZJizJC7M5tRBpC5oJiaV604ncJMLAWf7fOaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by PA1PR04MB10368.eurprd04.prod.outlook.com (2603:10a6:102:445::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.16; Fri, 3 Oct
 2025 14:41:09 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9182.013; Fri, 3 Oct 2025
 14:41:09 +0000
Date: Fri, 3 Oct 2025 10:41:01 -0400
From: Frank Li <Frank.li@nxp.com>
To: Sherry Sun <sherry.sun@nxp.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, shawnguo@kernel.org,
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
	shenwei.wang@nxp.com, peng.fan@nxp.com,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: Re: [PATCH V4 2/2] tty: serial: imx: Add missing wakeup event
 reporting
Message-ID: <aN/gfXqw0LVqH1dv@lizhi-Precision-Tower-5810>
References: <20251002045259.2725461-1-sherry.sun@nxp.com>
 <20251002045259.2725461-3-sherry.sun@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251002045259.2725461-3-sherry.sun@nxp.com>
X-ClientProxiedBy: PH8PR21CA0019.namprd21.prod.outlook.com
 (2603:10b6:510:2ce::9) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|PA1PR04MB10368:EE_
X-MS-Office365-Filtering-Correlation-Id: f5261470-3837-492a-a55f-08de028ae424
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|19092799006|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?quNr1FK+sw5WHsrSpsDr1g5GdFYa1xUKdnGAxBVmGp5j5PhIRlosSqHEBX6/?=
 =?us-ascii?Q?FpW8jl3z2Rj3a3UWA+vCi9gnbG9lDcvBkH21h5nOE/gH/mnQ1Eoq43Emn7zp?=
 =?us-ascii?Q?pDsg6CUcsp7EK2fNTrKdcrE8aguniITo0s2uPF+RbwsLNbrxLxrngOcTI3RQ?=
 =?us-ascii?Q?yphKVa6Np3vOwRt4ohgxEvbQoVViHZmLV9buVkYyJb6l662Z8Uw3kIbGpfIv?=
 =?us-ascii?Q?v9aX+wrWyc5CGgDINyWq2zjNQhO9DLh+8UDWoeWoUhLIT7lTs4aE5zHtFlSq?=
 =?us-ascii?Q?lDOEuVF8EekWN47W2bv1wIzLh+GO8AEBNlmPRP0Ya/XPbcSAyK6nYGeKLrIM?=
 =?us-ascii?Q?WWMF3lBPZ0LSWZzCHTmmFZJ7iORPcLAM3vGjApm5tNZOKzTGWeA8PFZ19RTm?=
 =?us-ascii?Q?TTk2Y3f5NARujtcjeH64gER9bNFJo5MAWfFM9qWMnbeuysbkjP5oNwf+pKe6?=
 =?us-ascii?Q?ktamb8sNbVWUj0Ae+4rGKdZq72mSEoF/f6Ps53PlXNiX9NHw36msC9NsJ+wU?=
 =?us-ascii?Q?qNNGcoSJacCZd1J2ojJtFpfJKuXdQcFM2Zwsz7f3vNCcndcgOvIWP5MoHCGq?=
 =?us-ascii?Q?LM0S5G/veSMkUi+R2Vi9mdqgrWXy8Vp8qh/4tkDmLZDFL8ITQkTr2pu7v5mb?=
 =?us-ascii?Q?tba9r4SgcCf3yBY7huBMolcUNLnDViVDKt7SYKeyPAg60wJj8muNaT3BBS57?=
 =?us-ascii?Q?ExuVk+iAWO6T2bYCaLaOY6eMstC4rh9uI/tshseYuyORLerxKvaodw6Z+ZyM?=
 =?us-ascii?Q?KrD2WmK1OlHbVmlnmEP5q0YsGu2pEnqGo0F0p8h+ZZwBTZ9/LjupTOmcce0k?=
 =?us-ascii?Q?cV+WWRM1aNP6e6c9gW5zoDfEEDKccH3ABBQ4/A2HWjgCLVy6ADdIW60t4Vp0?=
 =?us-ascii?Q?/is6zv6SNqJBUStTjM7Z5fF2cBxSWHjVb6DNG18LuWxHeKXuxuMyeS9mofxG?=
 =?us-ascii?Q?7NqqhdqT6GDZ0CEdw4qV80Rm5EKGGqC2U8N2/tPs0c1/orPkobSqhu4en740?=
 =?us-ascii?Q?3SxHYf5Veb+GaXHBtF517aEL1J3wS7jrQRS35mWDTadn8qCHS9R8xSFYKikY?=
 =?us-ascii?Q?Xh19ECYQPhvR+BxTe2/OTpdW6/Vgnj40ZA+ZsyLAFrdYw5X8KRY2vfGTIS2h?=
 =?us-ascii?Q?7vuOZfFGf//KR+H7jLyFULHSSRj0Zp28DUdy4x7UI+bfx2uB5tiKOBj7gg9w?=
 =?us-ascii?Q?vGCyldcakKfMBU12+3rAmD8yPNdb8H3Wss9Ca7wvFFVqrwpvOLxX4IufL+qE?=
 =?us-ascii?Q?ES/bRLP2eMppBk6h806VK8UBr8+IrYtUQtj4kxGtII9mVtCj6buEm9w4iPJW?=
 =?us-ascii?Q?YpNURf49kpuffLhbqHJXEveHz/FoW0v/SXNw/yshg8kMON9a0xUd+akKP8W5?=
 =?us-ascii?Q?IRXnTXJ3bY8McOtXYeN7KnlOY5dkRn+rdCajbWy5EqfyeDjFJm6h941rvp7L?=
 =?us-ascii?Q?CEEEqxekX9QIK0r0ppRJ7U4a0qJMcFfjqpnah8Fhv365yQ3jzii3Yma+qklM?=
 =?us-ascii?Q?hcB1Jxc2Up4hI+ZcAgTfcNHU+P8vqA2kT4/S?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(19092799006)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JD0wPpnFOaEYmJbknP6ZrWD72o4scxBakAcY/gxmw+pXz0kOdnrDfsM4euBe?=
 =?us-ascii?Q?rpyLwK8pYRBPq2JrOVGToPhbgHAonGCCjXmEom4yDAI15Z/5yjJh/+LvAeW5?=
 =?us-ascii?Q?V4fOLDYRQoSe/QnvWCpoXFASbMm0MYMx7oCMuzigrc3Yj3+CIJpACbgqMsns?=
 =?us-ascii?Q?M+5yUhvgKywQ5HQSZQlbpRt8xtIQg1qvUpo9gbJh7OXFl3gzq4mZotzCgJTQ?=
 =?us-ascii?Q?4hps83GSzupuF775EH3deNMsplhwpTHcFa8HrSemKNEDEH2GSfEdUw3KqZ30?=
 =?us-ascii?Q?xAUHG3WMh5zIxgo9TUPhDu+Ff5nqJsa/fAsBiP6yWze/bzb1knC5TruUntNY?=
 =?us-ascii?Q?K548524M++MwOyoinjsT6vexXGxar7mLBV4jE4JA9uJTgJEv0+Z5G8uHT/Eg?=
 =?us-ascii?Q?YtprQ/HkpbWH7sJYbWbI5nDXl0sl1rbYil15cD1zHFtZhIiXDAcbtifO3Fff?=
 =?us-ascii?Q?MT1RxJurJbeo6TYE2pS2mczXt48P+XUWe01hGdL2+MKZU+KwVfvQ0rlxqRc/?=
 =?us-ascii?Q?A4hfBBtyLIqdxqHE7f6h2lWrvu28PIfpHp51k8d96gf5w3IAyE2V3w+L9kBq?=
 =?us-ascii?Q?8beHjtvCZWWYV6oPYqOSqUM87mWiS8C+TvP8rQkiArfN3rL0xPDXfHQJJS+N?=
 =?us-ascii?Q?a/DgA3XEAt9IwtfUvAGq9q5cC9Lc91izyHRLiIg//xFrnVULFlq3x4dTW6Rk?=
 =?us-ascii?Q?6lB1sYVchKoWaM4oeggxqXfklhtlBv9sHL4lOUo8ywMpZYNP8Q0tivRdHlVh?=
 =?us-ascii?Q?75xGCEUC7OhNgGGUp+M7+jCj/ua6qYwU4216Nrd1a4JQrYgCeg4KqtvnczqS?=
 =?us-ascii?Q?6F2QcarI2AKFuveYuqjB3v9Eg9i9P33NauBmguRb3qDDPtLnTIUp5NMKLV7Q?=
 =?us-ascii?Q?/LVY+k6hi4iD6oYcerjEvK7dirqR1mMDnkIFSaloEEr0kweXtiaecy6qmS74?=
 =?us-ascii?Q?bMFsootFQFJjF/hKcQlWPlXA/LvWPIg4inR8Axmpt/F+mM4VXM+tT2pxR7GZ?=
 =?us-ascii?Q?sO3WlnHlVDfl2MnBodQpHAYQZGThvp6pv9AM7nhcN7HPgeO+nsaIP/4ITVJ1?=
 =?us-ascii?Q?T1ZtZwe1ayqsebpj8UCSb0rGVY1J2Weky9ztbDAQuSf+iXBHTbpACHLcZ9RP?=
 =?us-ascii?Q?PGTP+YUpPdK5Yv2sedDgzo8vYCMzlyEvJy5g2drA1TKKDMT06B2CYas5yt81?=
 =?us-ascii?Q?QfnhoU9gxe6FDBeYzYxPqJJTQVZeL31DCHn24TRWFA+5VC0qHmLxOeXvN7Xe?=
 =?us-ascii?Q?JtIcJkvWUs1VeZLFEnpELQLB9Tafhav+kjjNnfm1PYCDP1XrRGSf/5w0PJp2?=
 =?us-ascii?Q?h+zljB5UijVvDZbomg9h2o7bPeX3sK09VIAfTLWv8TX8gzx7yNjPe/ZwaiH3?=
 =?us-ascii?Q?f8Oh+gNquWznF0Gs2dF4GxXJ/mAMu5L4MzBQQtKxfsu9MoiRiI3E4tD8uPgL?=
 =?us-ascii?Q?gtugqR7KLEG79JEudHpBmhxNxyB4kukYWAMgt9HqNZYayDTZW90AIzH6H2Ue?=
 =?us-ascii?Q?EJSx+S/JyYTmTrSRiC40aQeDOkKRxOq1CQjRu5Zv3uUa4jqvpSO4b+luA/sw?=
 =?us-ascii?Q?zTFXHSBi+wu811Ar4Uw=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5261470-3837-492a-a55f-08de028ae424
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2025 14:41:09.1502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8hSd03/PhNxDec+IGi0ni/ZVN4g7HOmVI+qE+tu1F7ZZ4xaSyK7nkewzCIIVFknDZUtwQDTbOpa8gR5thhNgZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10368

On Thu, Oct 02, 2025 at 12:52:59PM +0800, Sherry Sun wrote:
> Current imx uart wakeup event would not report itself as wakeup source
> through sysfs. Add pm_wakeup_event() to support it.
>
> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/tty/serial/imx.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 90e2ea1e8afe..c488e5d372ff 100644
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
> @@ -2699,8 +2699,8 @@ static void imx_uart_enable_wakeup(struct imx_port *sport, bool on)
>  {
>  	struct tty_port *port = &sport->port.state->port;
>  	struct device *tty_dev;
> -	bool may_wake = false;
> -	u32 ucr3;
> +	bool may_wake = false, wake_active = false;
> +	u32 ucr3, usr1;
>
>  	scoped_guard(tty_port_tty, port) {
>  		struct tty_struct *tty = scoped_tty();
> @@ -2715,12 +2715,14 @@ static void imx_uart_enable_wakeup(struct imx_port *sport, bool on)
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
> @@ -2731,10 +2733,14 @@ static void imx_uart_enable_wakeup(struct imx_port *sport, bool on)
>  			ucr1 |= UCR1_RTSDEN;
>  		} else {
>  			ucr1 &= ~UCR1_RTSDEN;
> +			wake_active = wake_active || (usr1 & USR1_RTSD);
>  		}
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
