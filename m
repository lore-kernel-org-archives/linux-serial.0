Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD42C54EBE
	for <linux-serial@archiver.kernel.org>; Mon, 16 Jan 2023 11:03:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjAPLDm (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 16 Jan 2023 06:03:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbjAPLDa (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 16 Jan 2023 06:03:30 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD8D744A7
        for <linux-serial@vger.kernel.org>; Mon, 16 Jan 2023 03:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673867009; x=1705403009;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=nVzUMlIkcRKOW6FyXKII1uOTS/tz/e2GWzpaNPjVds8=;
  b=iRpN7G63JDfmKMeJ4X4Ajn4jG0yRlLKtsQxHHOUFX4OW6yaMRLFkr0lh
   xq6Gs8qhRVEM6Bcw2P1MifGE973QJw1UiULtbWD9VfhCKqYizgna0VDyV
   FVhraKd9QkvfLouyacRgLK/b6CDIsAHFoi4KXVAXS6Yst0dHKmHMHJGsw
   px86WcQs4BVZUoV7xtp2qfOit5WykwITxxB7kU2nggujJ+3W8YBYspt3I
   l7whbUzaJjxyqwMds0H6tXs3h/r47r0Ip0TqqK+CNYLvx6TTG8bLJlvC+
   ppHR7odLHawIbcXUrRRvbrCsrnMUw403dKA+Ry0eANY0uIjzdenPOsXTk
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10591"; a="351687761"
X-IronPort-AV: E=Sophos;i="5.97,220,1669104000"; 
   d="scan'208";a="351687761"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2023 03:03:29 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10591"; a="747685689"
X-IronPort-AV: E=Sophos;i="5.97,220,1669104000"; 
   d="scan'208";a="747685689"
Received: from xsanroma-mobl.ger.corp.intel.com ([10.252.39.155])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2023 03:03:26 -0800
Date:   Mon, 16 Jan 2023 13:03:23 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Sergey Organov <sorganov@gmail.com>
cc:     linux-serial <linux-serial@vger.kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Richard Genoud <richard.genoud@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Tim Harvey <tharvey@gateworks.com>,
        =?ISO-8859-2?Q?Tomasz_Mo=F1?= <tomasz.mon@camlingroup.com>,
        linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH 7/8] serial: imx: use readl() to optimize FIFO reading
 loop
In-Reply-To: <20230113184334.287130-8-sorganov@gmail.com>
Message-ID: <48ba84e3-7f52-9cfb-426a-a432587c1c9@linux.intel.com>
References: <87bko4e65y.fsf@osv.gnss.ru> <20230113184334.287130-1-sorganov@gmail.com> <20230113184334.287130-8-sorganov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, 13 Jan 2023, Sergey Organov wrote:

> Use readl() instead of heavier imx_uart_readl() in the Rx ISR, as we know
> we read registers that must not be cached.
> 
> Signed-off-by: Sergey Organov <sorganov@gmail.com>
> ---
>  drivers/tty/serial/imx.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index be00362b8b67..f4236e8995fa 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -890,14 +890,15 @@ static irqreturn_t __imx_uart_rxint(int irq, void *dev_id)
>  	struct imx_port *sport = dev_id;
>  	unsigned int rx, flg;
>  	struct tty_port *port = &sport->port.state->port;
> +	typeof(sport->port.membase) membase = sport->port.membase;
>  	u32 usr2;
>  
>  	/* If we received something, check for 0xff flood */
> -	usr2 = imx_uart_readl(sport, USR2);
> +	usr2 = readl(membase + USR2);
>  	if (usr2 & USR2_RDR)
>  		imx_uart_check_flood(sport, usr2);
>  
> -	while ((rx = imx_uart_readl(sport, URXD0)) & URXD_CHARRDY) {
> +	while ((rx = readl(membase + URXD0)) & URXD_CHARRDY) {
>  		flg = TTY_NORMAL;
>  		sport->port.icount.rx++;

I'd just make a uport local variable and use uport->membase + xx. There 
are plenty of sport->port constructs to replace with uport in that 
function anyway.

-- 
 i.

