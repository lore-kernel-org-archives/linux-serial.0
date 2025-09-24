Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011045.outbound.protection.outlook.com [40.107.130.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6604030B505;
	Wed, 24 Sep 2025 14:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758725634; cv=fail; b=rwnyotPJ+z6aKz4Z/CCNvFUFJtHkVt+II0zjQ2D64e0o/Wnty8PDSJxbzalcj3LHfj8N2rZa0b5GPorCojmg6E+Opw7Po2FCtEBpaqvZcIuknv579sa4CZPZra2NiGIu0QMpe/9fVy1Y1V5m8jnx382sE3JkKfv4rXl8h05aMos=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758725634; c=relaxed/simple;
	bh=xz8rCzCRH9KQoptj238UfACpIe70eN9neskWhJLzqiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mP/kq6ljmi6U81dNkZd2vhxOX8v5r0YM811g/ILnSMhEGBLXn6kP45TiDzPRvj//CG3fnSBn4mCvQFiErYMSYszIf2AaJgjehqj9Q9/93nOO7BueFWZX0enYoWtATSx2G1+cs1XG4FPjz8+BQKmmrvyPn3WewG4lqxOOKDaaR/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mTlVENfm; arc=fail smtp.client-ip=40.107.130.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mTlVENfm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EjoX579oyjMLVatR3dJuPKZTD5PA9Rzyo7tzlu39FOO0NfNImElAXSReGWNf0jiPHG25or5iU6wsggPjo4gQ9cZA3SGVNBLA4nEbCmHhPpJQzj3bWF5k07gtEgyvihOqzUyY6vgFrxD9Xe4riWv3mEJ5j8dzRAnv0yV8cLKvOBCvkwQGXWHCToqidhCXq1M835QRYYpMoLxzIhh/6Hf3TjyObvS2ghZ8F3kOod8Kh4TfGhb6pD4nGFHnM9YPih1tpnGDRpdYP3qKMlP42R9v34ak9rcTAK3w/QkkUwu2CXZ+G14O1AeZablbjOYQA7LQl9OexjoC0AB1kddpY1fBvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KhWApUfFU3OceBQrw3AvgqUIxlMrhaZBAa20h4GKals=;
 b=rfiAd1BbJwpX4q2n/3ae48qI1RLOYxW/e3GK8ZY1d183mWFDPfRMv/w8HpECWL/PiDk12ANC/CZryccqSzJ5aWhYMohNge9BBwar8/pp9DTeQREvSuIl41k52WTf85jd4Y7GALdGhw3V5oGLZXri9rlW9dFuSC18vm7xQ34rqJXp0TRvmqZFYGZGCwK1i9KDEHRx8BK4Z/BmBi+3NEEdcEWmeBJhpcQHYhs382SqfhqqIBz6nEexGEhRJC5DenRz8jFlzjo2h/1L83jDaQ6I6K3vjwt/corllBu2r/94Nz06uH1CyyQyWPsJDTKFz5b9VeiLYRHoUYOwVETOLt4tOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KhWApUfFU3OceBQrw3AvgqUIxlMrhaZBAa20h4GKals=;
 b=mTlVENfmGJeFwSkB2ZunpTD4c3E/swvIDQTBwH5tEc7nOr5IL8s4zRCPUWFxLo9jufIu3LqZ4iRJnfb0zhDFIm65GHHSIolOYQbO6akczCeyEIt/IXS5K1NtKuzj4eZvHNFeS6JHljSdv09f6YeUXXUFp7NCgRpTF8V97PzLdIeY/X9O+YJZ23DeBQ7TyCAeaY1s+3gMwi6eEyZJOI74hx0yvsGAn4ryPjhzfGJH41V8ENm+TgEGxuFacU1COY6F061sf7d0Kw5IBXNiRtsZO4oMpr1dWZ28KvBIHU7T72Cnl7A/b97SCwkLakoMWWYGTL6am+2biQwT100JCMKEmQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com (2603:10a6:20b:4ff::22)
 by DB9PR04MB9428.eurprd04.prod.outlook.com (2603:10a6:10:368::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 14:53:49 +0000
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e]) by AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e%4]) with mapi id 15.20.9160.008; Wed, 24 Sep 2025
 14:53:49 +0000
Date: Wed, 24 Sep 2025 10:53:45 -0400
From: Frank Li <Frank.li@nxp.com>
To: Sherry Sun <sherry.sun@nxp.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, shenwei.wang@nxp.com,
	peng.fan@nxp.com, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH V2] tty: serial: fsl_lpuart: Add missing wakeup event
 reporting
Message-ID: <aNQF+alWmTakAmUl@lizhi-Precision-Tower-5810>
References: <20250924025607.2515833-1-sherry.sun@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924025607.2515833-1-sherry.sun@nxp.com>
X-ClientProxiedBy: AS4P189CA0052.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:659::21) To AS4PR04MB9621.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ff::22)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9621:EE_|DB9PR04MB9428:EE_
X-MS-Office365-Filtering-Correlation-Id: c99b58eb-5637-4f35-368d-08ddfb7a2b98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?O+6/jO+bnSprSVRDJdIeH7R44F1NzoCuKaUB5TfifbfkAvs/+pp8hQn4Q/7M?=
 =?us-ascii?Q?ZqhpzgJUXY0v0toG5TlUwXYmhiHQzl3iGi5XGnhehjEDkYuMMRmzXT2p7oVY?=
 =?us-ascii?Q?wK2avcWhm2rn6q55V/OCvhI5JkPBxRobYQhukGPuX5ABSncKpM9TuJPnFmWd?=
 =?us-ascii?Q?1xGvMvjr7+SYOMKGuFpW3hy1AJ8F710+2XJAWNciy7PZx+Ds6PDuE5uYrKB8?=
 =?us-ascii?Q?BCR/QGJpn/7XjBXUejVoGMPjpNFDQlLaVHEE/OErNkRhkxrvlm/h2F8X3WbY?=
 =?us-ascii?Q?iFWVcrJblAcsmvxlabVN3dZ8DitaeZWN0qd3bI+NF2t7zwKhAGuYgaNaVsNF?=
 =?us-ascii?Q?/whRF+fxIbyD2RDgv6cJYwdioLmqMQyWsLTiMFUX8a1lcgfn0u2z7JrGDZKe?=
 =?us-ascii?Q?YfXuHdtCHPAv9EGNPkQUrKkgx8GDp7+gBkaDSE0B7SOuCjXYlVxNAcKoikJM?=
 =?us-ascii?Q?vM4+6YSk3ItGsbCQ9xyKa7xMXkCWKFCs4/HA8ncALcVX0bJr8wVbCr2eclcG?=
 =?us-ascii?Q?JngisElTeGk/DJDScA86Cyhc3RyJrdkn9Yi9BtvaxlozYFDr7vsCLVu+uehr?=
 =?us-ascii?Q?hK27VQJeTw7ThlRMyX7Ks4QNyBGh1beLldjJP/UJLA+635OMog/kXePYSewe?=
 =?us-ascii?Q?aBwOoaEcIaEahtz4QeqFuq2GCas6+fWWFyFvmo4LDzoSy64PzqQ0HYL7Z2tG?=
 =?us-ascii?Q?40pRuvk6f7LHd7g+SUKIGB/POp2e7LxJfL213Gx9e/fKZRBXEmx4Bb2b8u8l?=
 =?us-ascii?Q?qzEtOyfOgM/Q1ifVaWDh3pg7S8ZrolfC4waFZVVpX4qDTiO7XbH42oz1pVuz?=
 =?us-ascii?Q?KJV0iGktMWGXgrz2YAx/uK0G2icuCmMBll3YCCTz/muHV0HIohyKQ4xz0tZY?=
 =?us-ascii?Q?UPISIfOnQRHDSNyXar0Vl5fnYlTt846MhkuK3w55suyVSh+UKprZV9f/BP5H?=
 =?us-ascii?Q?cMsDlBxZB8XhL0txqcjJxH0F8ZlSxzarBFLJdvev5Zt6fWbUrxy8glPm0+s7?=
 =?us-ascii?Q?JUclpAPHNV/APS8ju0yCztU7Qvd4ezrOtrgTDb35hNsb/CpgFaOdHeaIT0Uf?=
 =?us-ascii?Q?yM+LrtV5DhHpOEQYytSfJ3I1Nr3r2kGH7BSl2/DycQl0mi4kchFhE0C/Zxos?=
 =?us-ascii?Q?C76mNzE1VArDa66rlvyWCYipFiXO9SMsw8a5ZtZBmeOBUURs7WGhqH3nCRD5?=
 =?us-ascii?Q?9WvR/UIE1sdMmRhckuyHQq4ey4xAev6WM7b9JxAHRmPqGuAYaarOdwq5Mo9N?=
 =?us-ascii?Q?2sC2JteRXNZUjwXsSCnUOLZ/YguEktaIXoF27Bu87JAFfPjfvBCCl/70Fydl?=
 =?us-ascii?Q?3Cg3flKp1n5N6bR/hyZB5AfihXQqY7wtPn7GLVPBipS6GVgNpFgEtgypfz8U?=
 =?us-ascii?Q?0/0rpRGxTxbyqrO3U73xGMUBRCQjfFt12GJAXS1LjwkdMRy37XfDEUBO6KOf?=
 =?us-ascii?Q?o0oEiFZD9ndNP1YMcB/sQhkbBhBCqfsTb2Mr2243ublb8frjC09s7A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9621.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SQxY3hsEi3k+ghtk/BYERLNSAW3h1+m+ajIfZs9C1Epgw4u1uAgUX0yoLSFo?=
 =?us-ascii?Q?NOTt9jkGUQrgJbQ7zdEnpSgq9Gtia43yb6RZev2bmQjAfrWrLQ5KWl3qDlzI?=
 =?us-ascii?Q?zTvZOhBQ3eotsu3M0aeXDR7zDq6DUdEFKRSTsREQd+j2rGQqzPrGwYX3KeSF?=
 =?us-ascii?Q?IJ7ff4B/Q4MlxtLqcGrQWOy6zAyMjF/ACIlje8n3zbBWaLDPYv1jLW3YUD0v?=
 =?us-ascii?Q?jSfZD/y2g7lPMgHs+3ZdaKeZ+Mkb1JktzuDz6EcuWbTtjGwv5Lh6Sexb+h7W?=
 =?us-ascii?Q?UVn3zM4j3i+lLXcwDGf0M1LlAPivx83X9sThefBrrMGZpg45RRcHele6mQDJ?=
 =?us-ascii?Q?0yAYlEKtna6XA12QNuzYZqOsGy2wcgEi9vtpBhSS+7VI5Kn/La/EceycBrFR?=
 =?us-ascii?Q?BQGgj2t4w+ygZRDJ7Kvigp7U0NFTYLz0YGwhW+/iuad0n/vVVZoiOBhFmtoR?=
 =?us-ascii?Q?5t3vlUlz3kR3Kt1oDN/tU4EqzJ1T15R0Y9opYNou6aGq3RIG+yWIUB0tTnZv?=
 =?us-ascii?Q?w755JccyPN6gdf8HsmMKa+CALH3OUqqnph7itrcuyXeDmJaoJUYlq04nPOWa?=
 =?us-ascii?Q?qptnAlYmPvw7EifyHQCzPBBGeGDQaau+m8H9JXCV/e3U71mfQzwJ9a3K5UAG?=
 =?us-ascii?Q?VVSCOpbQPs2pwK91+CBqXuqrgQAnXRf9oE51JaTUgHvr8UqL9wvLcsfMGs36?=
 =?us-ascii?Q?YmfMxSOVSOiCbOPc4py1AmWHLyYj2Ts/xkJORubqUtt3VkacIooLJjMsUVvG?=
 =?us-ascii?Q?HO4ChZSoncr9/bFAK7CpbrlRP9Aveommt0T5WFOYZAS+wiFPEsX/PvCpuYLV?=
 =?us-ascii?Q?MFi713iagB44pTe9eJdxUyWqsgzp+2ZgVtCC9v5BfIKX8mObaNsyI1lT0j/V?=
 =?us-ascii?Q?DSNezDJilFE/mzwv7dj/pUVsmdcy9vhP/HcDS8V8B1uFNSs4pO9lrFBM9+ik?=
 =?us-ascii?Q?U/f6gYWiJY7a/KgGq/6H6nOhcR6Du6UgoRT1xS838Zw9X/K2EyoLKnndypRY?=
 =?us-ascii?Q?nmrwH+3RQFEcdEsiHm3OSJFuonIq4a28h4LwCWYByAFikzkDXgv/lb6+VzJe?=
 =?us-ascii?Q?QCgPvl+5CJxNrbypgl9t1FgZF3Ofl6c4Dw6cdb1R/hryZcdg/Vf7V/mdmXdQ?=
 =?us-ascii?Q?Pxk1I/6AFNxQmBMT3aknBtOpan9Srvv9vPK4iY68QCy4pbWAr8lj2mWlOhaR?=
 =?us-ascii?Q?u+/oc/9lH0WNZTJyL2+8YNjZ2TOvrcI0UVvA9wEzdO8+rwFXbL90xW95yU4a?=
 =?us-ascii?Q?T4R2oj3WZl+zCZlT+ne1i2Du1Zc74uYFxO/uzaaj3fTb2K+7lDC9LjPgi6Cw?=
 =?us-ascii?Q?FVnp4Dn6jinfTYQHHd0Izd3cXNBJbidU3pjBg5UbRBnAG0fn/2aIWG3aKi25?=
 =?us-ascii?Q?Olx0lm6RuwN2mig3Yt0BQWOikuoISkhBtX9GecKO64jmuBraNgwLAojwKtCe?=
 =?us-ascii?Q?kTTqc+/VLM2ODYTpxshbfRBQnyMF9+rr0LrFKAsftg8BFI4dJ3cIbRctnebs?=
 =?us-ascii?Q?cNLep4JYsNn34CErxtfG/UQv3NvtI4JpTuyKiI8XtGhC/w54eWjwuAv1H+Ua?=
 =?us-ascii?Q?E4suItDqHnB0KfTKVYICXC6Udw4Jx2fqwBYObURA?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c99b58eb-5637-4f35-368d-08ddfb7a2b98
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9621.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 14:53:49.4358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F6cs7ua7ptgoB3juTS36v3qTzGN2LLlzIE5E6IdQsmDQRrO2XHM3ohjVVwQsQ1LoGTl1jSpLZpvle/6LbrEDng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9428

On Wed, Sep 24, 2025 at 10:56:07AM +0800, Sherry Sun wrote:
> Current lpuart wakeup event would not report itself as wakeup source
> through sysfs. Add pm_wakeup_event() to support it.
>
> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> Changes in V2:
> 1. Improve the commit message as Frank suggested.
> 2. Move wake_active above u32 stat.
> 3. Use (stat & (UARTSTAT_RDRF | UARTSTAT_RXEDGIF)) instead of (stat &
>    UARTSTAT_RDRF || stat & UARTSTAT_RXEDGIF).
> ---
>  drivers/tty/serial/fsl_lpuart.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
> index c9519e649e82..1bd7ec9c81ea 100644
> --- a/drivers/tty/serial/fsl_lpuart.c
> +++ b/drivers/tty/serial/fsl_lpuart.c
> @@ -3087,6 +3087,8 @@ static int lpuart_suspend_noirq(struct device *dev)
>  static int lpuart_resume_noirq(struct device *dev)
>  {
>  	struct lpuart_port *sport = dev_get_drvdata(dev);
> +	struct tty_port *port = &sport->port.state->port;
> +	bool wake_active;
>  	u32 stat;
>
>  	pinctrl_pm_select_default_state(dev);
> @@ -3098,6 +3100,12 @@ static int lpuart_resume_noirq(struct device *dev)
>  		if (lpuart_is_32(sport)) {
>  			stat = lpuart32_read(&sport->port, UARTSTAT);
>  			lpuart32_write(&sport->port, stat, UARTSTAT);
> +
> +			/* check whether lpuart wakeup was triggered */
> +			wake_active = stat & (UARTSTAT_RDRF | UARTSTAT_RXEDGIF);
> +
> +			if (wake_active && irqd_is_wakeup_set(irq_get_irq_data(sport->port.irq)))
> +				pm_wakeup_event(tty_port_tty_get(port)->dev, 0);
>  		}
>  	}
>
> --
> 2.34.1
>
