Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010034.outbound.protection.outlook.com [52.101.69.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D61A30C63B;
	Wed, 24 Sep 2025 14:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758725420; cv=fail; b=YJGZeTZIbO7nKs2Zw+COf4x3UWvsP/rYjEHJIdoh9t99KBd4Q1hZ42m5zwN/ZCcK0lxmn+kfbuAzjHkNxda6SQo60peaI97wkxVQQPjuhwuL3+StYTlcGk5rVVIZ0Wq3fvSTDgFq6gTSoLh+v78BBRxDWQ6JfGIrnw42liKXHvA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758725420; c=relaxed/simple;
	bh=M5SHIneSgLRpEQ9xN6vLe3w2HS4hjaIQf0iSfTkppFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AcLFCSip6jRsy9H7GPKQb+LOVh1UL0FQZbnA5r35+zCyHMQIT5yDEcyc2B1k4OHa5OREGpsfQ+c9zK99xg1dxajUR1TKB1OLTg2KWJln4tjFFWZtLO8ScVbzumAeq/i6VqzvQlbkVx+a9I4zaVEHW0Y3mr9pU2d2fLATrQ+bSa4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WdOevolK; arc=fail smtp.client-ip=52.101.69.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WdOevolK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M+S5CqgdBF9BCjO7om85/c4F08x3vxLo1XFdyNsBMdMow6rqbPf19G+KRijhVnSqIVD/i6P+eHtDIXhEEeF/fri4NUG9hV04nH+CkJ5HFdQHbgupbFTXi24u7ei4h0UEtgxFI7CMvDpRVOgt05DD2iZ/THPz0BoarxRi4Ob+puF48ijzWDTzA367YyJBgGGCMYbcs4zdsbzZ63i3UInrvHITBs4MvsznZbpXiZ9mJRQnmF/0qM/cSZtle/MiUC+kV8wBts5N4ZhxWHUR7vkPEDvjmi1H8R6AofgJV3CHvmDC16IrSjeiKTBpX6IBesICcgTy0B/Qej6CPtQliKJSjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A2uHNANt9VJpHKzs9mw07w87mTB2M8/EXEKDfW9kADo=;
 b=BmUGcG1Ggz8jEo4hPZp3z34AL0JLWgNqoz4fZfE8ilBx1ATHHqcw9GR3klR2b5kL+TGnaK2OgZseOgrt+RXho1rLOb05vIFaaXXhpbVSLggANsOqZi47gLgOY8KcspeEaWaZwfZ+eWMFhOfnQ5sR8BWjqK7DJZnHrAhQpanrZZnqIrfAQrJajJMsLlOYTibsFbJA5C2mpDRuBSfeL5p+Zgs2M8wGQR4S1Y/qvui9ZegOmNCVXibqVbzpg1Gs5rO+cHBdJh4Gt2vj9i11SWdWvN2mxKjfhGRwM6oeJe7CDfUn3K1n9SXjc+qqpfex3iK3Yb0d4YdBTgHComMPA9bczg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A2uHNANt9VJpHKzs9mw07w87mTB2M8/EXEKDfW9kADo=;
 b=WdOevolKR+W9v3cdTG8BHCzxjxyil/7XwKF1V4lFh6quzKpHACDjMzUHH09MqYJIx/RORgiJ+4Bk3nNr3RRJOuhJj1sQpCfQo73xwI078IPkoshClIQDns2PNFsI+qY6pGKIsfcOg9MUQNx7dq1eP7IhCk3rKSMZoGm/jvO61fe0caW5Negf1NYvx3wt1d//D/G0ElJeS6o2OBybBl4F3gAVh9zj8FtEOfjZBX7a9vncSLYfID5rIfkthZ9wto1y/U6OrK1sSdxeF0PBTwlhr9kh/R5vMzvCJSkEL+YDUrxiYB8q3WSvejOfdn6MC67K94tYahbA33JLa8P4hEjzog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com (2603:10a6:20b:4ff::22)
 by VI0PR04MB10509.eurprd04.prod.outlook.com (2603:10a6:800:214::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 14:50:11 +0000
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e]) by AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e%4]) with mapi id 15.20.9160.008; Wed, 24 Sep 2025
 14:50:11 +0000
Date: Wed, 24 Sep 2025 10:50:04 -0400
From: Frank Li <Frank.li@nxp.com>
To: Sherry Sun <sherry.sun@nxp.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, shawnguo@kernel.org,
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
	shenwei.wang@nxp.com, peng.fan@nxp.com,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: Re: [PATCH V2 1/2] tty: serial: imx: Only configure the wake
 register when device is set as wakeup source
Message-ID: <aNQFHJlnmn9V2Eyy@lizhi-Precision-Tower-5810>
References: <20250924031550.2516704-1-sherry.sun@nxp.com>
 <20250924031550.2516704-2-sherry.sun@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924031550.2516704-2-sherry.sun@nxp.com>
X-ClientProxiedBy: PH5P222CA0009.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:34b::14) To AS4PR04MB9621.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ff::22)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9621:EE_|VI0PR04MB10509:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dd597eb-b732-4492-4771-08ddfb79a9a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gqYvU3MD1fw9neA3fw+zeg788WT7JmJVU2FYb/DXiZoeFyv/NukfxQsM7rF9?=
 =?us-ascii?Q?9Oq/HOGQ4QYLX9sDx6IdBny95B8EJmeqqFrxT9qtip7rbMukNhb5W02rDkMA?=
 =?us-ascii?Q?ZxLemDSVtB4BJcDc04NZKa8R2bsMQZG/Z+Qy1EWTEV0cyYKRELYHMz6t7F3J?=
 =?us-ascii?Q?iNIedvpCeXiXy04bQF8vi8NKdr6p25B6ZpA0qhxtVKvfC9+mIdBlVtiezkDk?=
 =?us-ascii?Q?yH71UZzYXFMC/H8nz6cpJAmWOSJyIORyS5SxR8ZWReNEfdHle+c2tlFl6Y4j?=
 =?us-ascii?Q?JfFHQ81Hr07aeD5AGGR4hhPeSF2frsxVadckusjQjVqgTDDs7KRE4zHNkNfy?=
 =?us-ascii?Q?YfbFfwvIFxsaBzu1lHtvD2vH2VNipmiyu45YPzpYEA2vMKraFIvpbYZWvc7n?=
 =?us-ascii?Q?+2SER4+ytrpLIxWIxhg8uG9dzA3sSmtG4SDC6WgU+9Kt7pRGwjCiwWTFWYWR?=
 =?us-ascii?Q?K5VPS6A3gqG+JMrbJHAC92dvKpG3qYY78ocew2VsbVvxwixYXqnt+d3RS0FH?=
 =?us-ascii?Q?yOD81c5guwUewx9cuOjKfc3WUSYhvXh+KK2AvFltN61a79F660dlUD09jJxh?=
 =?us-ascii?Q?15wniYrsM1n9+/v/Xwq+wy4cjeJ2P+9k0N5BgMxpSvAYDOMkldl4F/k4X8VV?=
 =?us-ascii?Q?35nyhwC2S+QXYujlfXJI8q9/EB6nkCCLrsuMFgW5OA7cNOSchs1cw40OLo5h?=
 =?us-ascii?Q?LZZc6xN8ueNYp2gMnT+X4O9+wG6OGSXIV5f/XqxEW9P5X1bcBF+4DzA35Ig8?=
 =?us-ascii?Q?DTkke5V9lwVzGQkwK2Gro2rZLsHRn5/sXVK+keMH2a5hYB6HLdcxRo90eBrh?=
 =?us-ascii?Q?5NA43cllCYXsAWslfC3HQjG9s7pAltAwgRsZsnNvR0hsXwv4neWUfikqIY1e?=
 =?us-ascii?Q?+XjCMFjNVzQ4NupCJ6EvfmHDSTfr1zetCxS7TrdF7uLorvBX4rRvQRtabs43?=
 =?us-ascii?Q?7UbDLfeO6bik8V/7teU+rL5Kp8HV+Bqxo4/+MVoWBerb6ChGsaRwy5xXUk/B?=
 =?us-ascii?Q?D1awrqflNfPgJcWxYmmZ1LtJ7CrPbj/Soe7o7KY65+1IvHQ71NRof3NGZYaQ?=
 =?us-ascii?Q?PaOUBsVwzpbEAj832VMkRv/jBMFXcr/B2ArsFHzxffNrjqyvnWLTQnzDzX+2?=
 =?us-ascii?Q?gHiXkowwingE8lhblrLapLRUW8T50gt1q0sfmpBMKwdRDnkNmvxHiUGN4pHX?=
 =?us-ascii?Q?YYo12+JlMZ2m8hOxsRYw4ucx/SXBwgcGWdtInMAAco57LgBRaQibf5h3CLo8?=
 =?us-ascii?Q?/NPwu/1NBor+L/vl/CyTdbdzAGdv3tFKkW6MlATaiyCOS+1acsMxB1gG0EFh?=
 =?us-ascii?Q?VQDd78BhuiFrcJfxaSmWtBjz7/z4EOeFk4gRwMILOFTwDrQw/z/AACmH+frs?=
 =?us-ascii?Q?02MJv9PyfcVno2uME31gUckI4WDOR9anMb+sasxtw7v6olKc9u6ahMA/Tbx/?=
 =?us-ascii?Q?I5ilmqeyFpegVYa/TMW1D+6QyPEpC/jG3yJ/t2ddlP3D4p1GC2CpeQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9621.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WFZ0djL+whwdkSBL1AH46pYxBr7vtMZkuo1/iw8UhpAuskOb5Vvt8l9JASde?=
 =?us-ascii?Q?6HZNn4KH9/rH1Q6eSBW12DMk4vvx8nbnuHFEAkpGhQmzyoRdE9+gB7jOlBMH?=
 =?us-ascii?Q?Vt2kY5Dc5nyMZZl70g8aSwFedT2Ixs9gCVI1QQHoWWpaaaisOsBS7xbq1T2M?=
 =?us-ascii?Q?aeKsctPtZIrWHKrJJxccEF7sDjfJIpphKnRHPmR0PvvO3uw5jLD4GQWBTjyO?=
 =?us-ascii?Q?vUOsU8iCR475sreWn5g9wOLsdSlhi1gifDwyq+P4ncHJ9BQ7+sGvgjPxoh8/?=
 =?us-ascii?Q?Dz92u9nFXi1t2gIjcjOq6x9kSFF+n8ZwscgVxVZvXj9qtUeXhTALtnGxkwkr?=
 =?us-ascii?Q?jlQk8OkVvHtvmvv9dZ6eyiNj1uUHXSoV6okL4/xa/ykxe3NIqOA/xO7eQaHt?=
 =?us-ascii?Q?BNleCMfrl5UyrO8zaNburs3amWxanm8apnGh/1/mtPNIhMypEf9nsBq3SG5j?=
 =?us-ascii?Q?YAL0p/fHODd+/uBz9ZQOAEBRmH2wUNhE3DSgx9zau74+GpcNRMJg+5zw9e0X?=
 =?us-ascii?Q?uZG12AlYScOuqqdEV/z5u0PG+bWRJr/44GNZ+dTsQK2RYp1tAO1K43lo9aLI?=
 =?us-ascii?Q?4NE0Ykm7Cn8ee1JwM3js6IkSXvFxYw6U8rja3oNIOG3VcnfrWNbNywrcKc9B?=
 =?us-ascii?Q?yU3nv7Dj6utz9im+/7yHhVXlOD4oUKUCOtOJqszSeak7ys3SEOZnVS2HJEad?=
 =?us-ascii?Q?YCX963mWv7Xn040PQMNgRGGQ3V3tWtTRp06957XHd6DngiWvbkbF+SqFxsiS?=
 =?us-ascii?Q?G5+wNkxmREQXusulUtzwyhGlOT8Ja1jlYBRPte0YuMlkET/nicpBj9yjglvk?=
 =?us-ascii?Q?flrXjPZTi+lpFL00A+WwIuBjoOT0VC3j1x17zpz3W5/JW6prDg8JT5wG4ReC?=
 =?us-ascii?Q?6QuFoQ9YtHBItyTNrlc8JWb2RFPClvgEHGGJitl713zpFnyI+0s52P1mSaPc?=
 =?us-ascii?Q?xFGtzltNLfefPAvNFFDgSEt4axpxoQ8j0Aqouj80bmEQNP0XM45fDBWn5KW7?=
 =?us-ascii?Q?tB11rki6Lm+Tsk8PS60B8zOXQA0L9mBO0a6gJ//5NV9rp7yBFJy0XDtOrlMU?=
 =?us-ascii?Q?HLJniME98K39ffU45WeXW3hv1mE4rxOQxpiWMptOIuYUdZaV/7FamZid8R0C?=
 =?us-ascii?Q?XYGK1J5XbBkHWmV8CvK/Byc3YDce+eU/POR9L+VEtgvAEgos7jKJh2OpnZLl?=
 =?us-ascii?Q?o9ZOt9GhLhfl3oKFfjAii+a/0ZbFtaSCVa/fH08rkgNZe2JRdlo7jrMaVM3a?=
 =?us-ascii?Q?+CkQZSJKSrgHp0WvPAAvea4Q339rClZaddksJl4eRBSllR/0R1+FBpwUAQfn?=
 =?us-ascii?Q?oJcajob1UkOAD2MD4iXcAJrQOkmQhG/mPYXr3HbFi89sm8lcy9ASlZhWMtEB?=
 =?us-ascii?Q?aUm69tFnTddK7/SrC9UudZ0/jCVU/hvxUDJNWyWQARG9ULm3PETHGe/xjb//?=
 =?us-ascii?Q?wBsybuqThUk7Vn6nhsiXVh06GwL2JMt82LRR5cmBSRgq5pncCaM8spW7ehfa?=
 =?us-ascii?Q?USkwgzfJdSh+BEuEnlRWTdMXX5vYyOY4rxMK8oW49lBBIajnjw4HZGz7ihdB?=
 =?us-ascii?Q?mvcVgPN1mUhf1z7hukOaCm9xs6AKo3ANFHmwSgiQ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dd597eb-b732-4492-4771-08ddfb79a9a0
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9621.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 14:50:11.3599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B8fW6oC4zHYXoM5TipctyDAVmg4LFeBj+dHWPTr1KEkGguHCctqNHIA3BtpqvxrU/WF7LzlQ7Ap3cWF1AueskQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10509

On Wed, Sep 24, 2025 at 11:15:49AM +0800, Sherry Sun wrote:
> Currently, the i.MX UART driver enables wake-related registers for all
> UART devices by default. However, this is unnecessary for devices that
> are not configured as wakeup sources. To address this, add a
> device_may_wakeup() check before configuring the UART wake-related
> registers.
>
> Fixes: db1a9b55004c ("tty: serial: imx: Allow UART to be a source for wakeup")
> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> ---
Reviewed-by: Frank Li <Frank.Li@nxp.com>
>  drivers/tty/serial/imx.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 500dfc009d03..87d841c0b22f 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -2697,8 +2697,23 @@ static void imx_uart_save_context(struct imx_port *sport)
>  /* called with irq off */
>  static void imx_uart_enable_wakeup(struct imx_port *sport, bool on)
>  {
> +	struct tty_port *port = &sport->port.state->port;
> +	struct tty_struct *tty;
> +	struct device *tty_dev;
> +	bool may_wake = false;
>  	u32 ucr3;
>
> +	tty = tty_port_tty_get(port);
> +	if (tty) {
> +		tty_dev = tty->dev;
> +		may_wake = tty_dev && device_may_wakeup(tty_dev);
> +		tty_kref_put(tty);
> +	}
> +
> +	/* only configure the wake register when device set as wakeup source */
> +	if (!may_wake)
> +		return;
> +
>  	uart_port_lock_irq(&sport->port);
>
>  	ucr3 = imx_uart_readl(sport, UCR3);
> --
> 2.34.1
>
