Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011034.outbound.protection.outlook.com [52.101.65.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76B7549391;
	Thu, 15 Oct 2026 15:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792077910; cv=fail; b=SYsUn1N0smrIhHxUZX1OIxJwBDUL497otBSvDtBlqNS2dN2FOPVcdH30uB1S6K3l3B4ZuMOxxYVQqrK3sfYB00sGkg975mK/217v5v8RMRXD6s3af/IdfNxvycedgP2hE9DPJiNnZon6HLNM5JVuIhMGzqDcClGeD8ZtHZUM9U0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792077910; c=relaxed/simple;
	bh=8U1NpvnVCO0Owhibyckrt5cxGOKTLNqjsmenssCCU2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AD/I6hbxyYTLxoI5bOuSlWepXIbzPL6qcGvKVlW9mj7pdQrYS81pHJpvNFg/+aNit0tASirl1nehNXbaxeB2PHkqFB+Tlax/R5j3CoQgOqOhPRWcqIl7Oo97WKt1n9ipVHhql9FMT6Bh16sk92epkdW+d22TZVid2A5PpI0yfsw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=d6Dq3Npu; arc=fail smtp.client-ip=52.101.65.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="d6Dq3Npu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yob4rHTTVNaAmJHG9EajJnS+Y4ycItjOZVNI4Hg6gnq/Q/XaaVRlL8o+xBSv+Tj1CwbF9f6v8KCsp6Nh65i4UoUQIuZYqvPxbDv+Vw/twpdgDS0Akjxn6k3zjsxOn6L3/jAyyXrc0f+85HRqDLmn47R4+ytBxPlc15Ns7HZ9NNj68WFrSmgQWsofHPAa5Aui1A1xO47PJ1he056wACUnKN0HARj1tVC9oUtNizW6sLHB7/iawjBKWpLjlFIhRPIE1MZjtw7CV2Vb8UflgWtm7zSlR0Q3I2e3JFHh6PdpFzQZ4wtdsKyB69GcxFlGn0P+QtQHk6/kEd+RePDMCkaWXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JPnqRj+ouWeiOmjc3Ub3XFr/pLArvg8XvA/m9s4Q9QM=;
 b=N9audIVyp4jW8kxHC9IfOTrPljS3FU/Ga20TSVxw2yZKuT0xYiOBg50PreaMTpWLhsYpf9bSw+5erCB2N6MGYFJMWaIn2XeVuxJgzyTHOSTI/hxhYQO7ADA/S2S9/c4hQ/MInap/n6m26Ay5FraFfjVgLIsFBipxWyD7hJlcBESLMPftsKJrnLMsTutnsk1g2SHHznlAvLhJLxB63fI4WQtIngad0/2/nAxWeJ521aUt1ol6zqfoGwdSdAYU6Mbohcj35mmKuUrk+xJrfCxYww4vunSlGBJL6VmeZNqlCPM0nLbmLn39as32L0tJy1JfxMslV2brQo4Ozl3FQ7mIHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JPnqRj+ouWeiOmjc3Ub3XFr/pLArvg8XvA/m9s4Q9QM=;
 b=d6Dq3NpuzTD764RGw63lVC/lRQ4z8bfhbWVNbejQrZA+DagH36uCp65p2Y7MndWp3bHwqE/SHA9Y1qN9rqI7LrfBDnQtRl1XK856GMTrACQYqkVdns1Wr9N79AY4n0IK2da2eoK66aDYfFlAx3chIIPhLuJYlrsj+19SS5qUF7JbksuP5btz2vTxXf75L5MbVHdFZvLOS/JaAGVuiDRqnrRuYOR8I/NmcLoXHmlXQRXHWnh15ODPuDvFIBIfokJemB9ym47NSsGv4Bc6kI7dtArHL695gvH27C0TjcL3+2ERPCLIqZdAiFN5lmJSjwFDsmWp4SlC10LN+LYm9DjYow==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PA1PR04MB10601.eurprd04.prod.outlook.com (2603:10a6:102:488::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 15:24:58 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 15:24:58 +0000
Date: Thu, 15 Oct 2026 10:24:49 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Otavio Salvador <otavio@ossystems.com.br>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, Frank.Li@nxp.com,
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
	linux-serial@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	"Rodrigo M. Duarte" <rodrigo.duarte@ossystems.com.br>
Subject: Re: [PATCH] serial: imx: keep the CPU out of deep idle while an
 RS485 port is open
Message-ID: <atDwQfCyI6yUpAWK@SMW015318>
References: <20261015144627.2461915-1-otavio@ossystems.com.br>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261015144627.2461915-1-otavio@ossystems.com.br>
X-ClientProxiedBy: DS7P220CA0038.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:8:223::29) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PA1PR04MB10601:EE_
X-MS-Office365-Filtering-Correlation-Id: 307044b7-c6ac-4929-1dff-08df2ad07939
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|23010399003|19092799006|366016|56012099006|11063799006|10067099003|261009223027099003|261009221227099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	gMQ5u9HqP4JWIiA7iC72ofpYoGC1K958dC+sIejkzSZQ3YvL6x/Uyuz78+XUGoQ7wG8A+m2RO58gvidCWDbYM/0TsgnmkiEdsUGtr/i4i9tGEAFOSgsc7g0G9rBCZjjGs9ORM0iiFJwGyFTS3cVZ2cj5pYbtWTrXiiKK4yBddSdIUO0+UVaFMnwIsOGLtLhbYTA429wVprNv0SDWYPLGLlpxrG46rTbIL91IJjCBgLtW5wYxuUcRAdnrtksS8EZphla89IScS/JpzW6itx8q0qqZIUKFFLRJo9t53YmB1mgyx8b3rVE9PMzE5JhaTNmSICDHQ+LElsffpv9zg7Vj6DBf8donAnMIZT6EP9k05tqmYzs2DSUBXxTuYUAP2cti1LCcpMyhztrGagZ8JPn+zgnCuE/xQid5LL5/FHMdENpAox+ykB9a5TalSx4cGgU7WY2H1faKP0li28Mw6vjeWpyrYRAKtQGvHWjLj8dIeqvCqPt1jktnC8jBSmzHzntcEmzOle1bkVEnLBB6+OtFWPsj0fYaGurwrZijx0RIgm7CGSQ/EBKoLqC2gigQHQXOw9luiF5k7XoLkEFX6l1jhfZ8piF01IHRy8ZIuI0btwBkGdJpK9oofv0TrU2VOfF7kDv5NH81YmojYoM4Rt8qRsP1vbFuVaePbAx7HWbwnUU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(23010399003)(19092799006)(366016)(56012099006)(11063799006)(10067099003)(261009223027099003)(261009221227099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DmyyZaqPCaeaIuXx3qHsjlVNCXZ3pv8Gl86gVr0cUd6CrGZL8wRuOm6b4b6C?=
 =?us-ascii?Q?x/sfh5DQWAhXLEsS7w+toZ/AEBXbNsR/HyC9pU2SeX8OTrvz2dMBqPgLj5I/?=
 =?us-ascii?Q?asTnQETmEB1THnYH+jqTedhAZcIgz+iM65/oUsRjyPcO246o6uMIHc1G1ANH?=
 =?us-ascii?Q?Z3JK9z4XrNCXkIjbFnBqt+IDPVuz6UdobiIR5HkbjD9vjB+Sp2I8ScsBS4u2?=
 =?us-ascii?Q?G1SJtN/nUM0+2aXxzz3R/5tEP6T0FnTzxQfGbYj7KLUzGhvAyShFl/TUYMti?=
 =?us-ascii?Q?MRCH0Ze+uDRxVyaqh7coPNGqP1f8Qoqif5rJuv9I46WEGz2KE4ZrZoleVlmd?=
 =?us-ascii?Q?A8NqZLYOrzGREgdQB+F7HigQH0AiOhsJ2NBj4SviYpXjJFTE54jMZ8W/iQxs?=
 =?us-ascii?Q?RHgS0wOBrH099FNm41ovtzuO33Omkgi9wOS748A9XtUqeTggZS0buPf8yOY2?=
 =?us-ascii?Q?Ganm9S5IRsoQymq7ZQMDuOFiNHxxIHLDjtRF1JjemgA3hxok3MuTGihyRWQA?=
 =?us-ascii?Q?1v8+CD0aSJM9zqeDDBHIaNC62JzkGd7Hefu5+HdcDDsoGUOD5eY+4FeV1RCc?=
 =?us-ascii?Q?uaPujjbhJcnqY4MKmEdSTw1umy5WCGXYJbdQ5W6wk8a9n0yM3iq6HUO2It13?=
 =?us-ascii?Q?/gZiopvzc/ofjOS1mo7bVPm0MVwdSweoBYHjKO4NAe9y9ZtmAEwMZFN88cOF?=
 =?us-ascii?Q?zclZ1tmxIuYCBRo/bMjeaZWdU7iAnWvA+0FFa7iWPi+JS5xBWgPkmkG61wqX?=
 =?us-ascii?Q?/KzVd2cWYiORb6kPdV2e4DOAdCvz5SoqISIqgnbPPvj2DFbr/pNvqq0FJf5H?=
 =?us-ascii?Q?jc8Vg40DZNIe1RaFiKQUSuN51vGsYlXDoukf7aZq6dCl/6GB6Mg27z80DrdA?=
 =?us-ascii?Q?vfwyq/R/Ha0V7UqEyg2rjtSa2ajXcB9csm9DNSb0OwopDPQupDM1anQmftLS?=
 =?us-ascii?Q?MnX0uHpGySy7Ey/IKCoQcp3TVKQsnqiAd//vmKarB7vFZ3QqZTGRozj/6JnT?=
 =?us-ascii?Q?UZlCeTxX/oEnYTx9dWaaLLPb/G+DCFnRBx9d0B9jb3CP6QvAMR6vnNxQPHyY?=
 =?us-ascii?Q?qXvfaXrBqDxEpZD3ddQjJaz+3Kr34JLXXfGXCsxiMNGgncExz9efpSjbDJT1?=
 =?us-ascii?Q?qg3pPbKwiDF8jcri0HDmCBtKBYaYMywGrK3Gx/jszovBZSD6Nt94WujuJSXx?=
 =?us-ascii?Q?fOKs3PXMGpPMrGWnvRHHx53VI1QuhkMvb88cXVMxMvfnfR43bCsJBBSAUZXx?=
 =?us-ascii?Q?x2k7N0zf/R5akUB3UPXqxVDCZw595I5P2bAKTg4rFbXITdPkn2MnwJ0RQqdp?=
 =?us-ascii?Q?Oe0I+HsW4fzSepVjREXSU4BdhdLwZ413GHvF+zJpp4z3qJfAaPtVaNPpr1ym?=
 =?us-ascii?Q?6B7JNu0klER2K9oCsfkj6Q6iYLYv9dZD6eXoyFYBC9c7gCLYvyIPlJQOCGwz?=
 =?us-ascii?Q?g6OBy0Q5IW3mDBYtBKWNjVr8a5JlkGVUh4Gtn1Vq/V/ADrwQOubFDNe4+183?=
 =?us-ascii?Q?M1LKxAWvorb56dmdw1MzITExfbmY0vWIN8m7NV1muGZ4Q8aiygHHgogdW/EX?=
 =?us-ascii?Q?HgmNQSowo/OFrFSCy79KqfszijiOj89ejLAlzTuxqUSCNAOFC9gCHMAjxRHX?=
 =?us-ascii?Q?1xo+SdohaOus598ZpCQMpNF6vRO4TDZChxINyO13G7M/Jv/CWZM/mc3+0/tS?=
 =?us-ascii?Q?ALzbn0GJi2yFeJUrhtXNcxOn71fo9HX0vKoML+NW/qqk59sscn6xzGjbtPUS?=
 =?us-ascii?Q?BuHadmClVSpryLKG/s31NmVskL2z+sND1dECJ+x0bu0S5Y480Eq0?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 307044b7-c6ac-4929-1dff-08df2ad07939
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 15:24:58.8029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yLS862lWwogSBiYDOc3T49Iy0TVjiMv0/UJmPdDo/cE5dzDNcCIdyjbL0T7kJG4u3WaghcaWYF0cJKe0xYZzeyKXQWgEjhUMBrSe0AdnZMTtaEhWUq2fLWk+TBccOZ8F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10601

On Thu, Oct 15, 2026 at 11:46:27AM -0300, Otavio Salvador wrote:
> [You don't often get email from otavio@ossystems.com.br. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> In RS485 mode the driver releases the transmitter (RTS/DE) from the TX
> complete interrupt. On i.MX6UL/ULL the imx6sx cpuidle driver offers an
> "ARM power off" state with a declared exit latency of 300us, measured at
> up to 2ms. When the CPU enters it while the last character is shifted
> out, DE is released that much later. Modbus RTU slaves may answer after
> 3.5 character times (1.75ms at >=19200 baud), so the head of their reply
> collides with our still-driven transmitter and is lost.
>
> Add a CPU latency QoS request of 100us while an RS485 port is open. It
> excludes the power-off state but keeps WFI and WAIT (50us) available, so
> cpuidle can stay enabled and the constraint only applies while the port
> is in use.
>
> The request is added on startup and removed on shutdown, and its value
> follows the RS485 state in imx_uart_rs485_config(), so RS485 enabled
> through TIOCSRS485 after the port is opened, as libmodbus does, is
> covered as well.
>
> Tested-by: Rodrigo M. Duarte <rodrigo.duarte@ossystems.com.br>
> Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/tty/serial/imx.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 986fefb45c632..be05ed94bf0c4 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -24,6 +24,7 @@
>  #include <linux/ktime.h>
>  #include <linux/mutex.h>
>  #include <linux/pinctrl/consumer.h>
> +#include <linux/pm_qos.h>
>  #include <linux/rational.h>
>  #include <linux/slab.h>
>  #include <linux/of.h>
> @@ -237,6 +238,7 @@ struct imx_port {
>         struct hrtimer          trigger_start_tx;
>         struct hrtimer          trigger_stop_tx;
>         unsigned int            rxtl;
> +       struct pm_qos_request   rs485_pm_qos;
>  };
>
>  struct imx_port_ucrs {
> @@ -339,6 +341,22 @@ static void start_hrtimer_ms(struct hrtimer *hrt, unsigned long msec)
>         hrtimer_start(hrt, ms_to_ktime(msec), HRTIMER_MODE_REL);
>  }
>
> +/*
> + * In RS485 mode the transmitter is only released from the TX complete
> + * interrupt. If the CPU sits in a deep idle state at that point, the wakeup
> + * delays the release long enough to collide with fast responders on the
> + * bus. The i.MX6UL/SX "ARM power off" state has a 300us exit latency and was
> + * measured at up to 2ms, so keep the CPU out of states slower than this while
> + * an RS485 port is open.
> + */
> +#define IMX_UART_RS485_CPU_LATENCY_US  100
> +
> +static s32 imx_uart_rs485_cpu_latency(u32 rs485_flags)
> +{
> +       return rs485_flags & SER_RS485_ENABLED ?
> +               IMX_UART_RS485_CPU_LATENCY_US : PM_QOS_DEFAULT_VALUE;
> +}
> +
>  /* called with port.lock taken and irqs off */
>  static void imx_uart_soft_reset(struct imx_port *sport)
>  {
> @@ -1585,6 +1603,9 @@ static int imx_uart_startup(struct uart_port *port)
>
>         uart_port_unlock_irqrestore(&sport->port, flags);
>
> +       cpu_latency_qos_add_request(&sport->rs485_pm_qos,
> +                                   imx_uart_rs485_cpu_latency(port->rs485.flags));
> +
>         return 0;
>  }
>
> @@ -1710,6 +1731,8 @@ static void imx_uart_shutdown(struct uart_port *port)
>
>         clk_disable_unprepare(sport->clk_per);
>         clk_disable_unprepare(sport->clk_ipg);
> +
> +       cpu_latency_qos_remove_request(&sport->rs485_pm_qos);
>  }
>
>  /* called with port.lock taken and irqs off */
> @@ -2053,6 +2076,11 @@ static int imx_uart_rs485_config(struct uart_port *port, struct ktermios *termio
>                 imx_uart_start_rx(port);
>         }
>
> +       /* The request only exists while the port is open */
> +       if (cpu_latency_qos_request_active(&sport->rs485_pm_qos))
> +               cpu_latency_qos_update_request(&sport->rs485_pm_qos,
> +                                              imx_uart_rs485_cpu_latency(rs485conf->flags));
> +
>         return 0;
>  }
>
> --
> 2.55.0
>
>
