Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA10C54EBE
	for <linux-serial@archiver.kernel.org>; Mon, 16 Jan 2023 10:55:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbjAPKze (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 16 Jan 2023 05:55:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbjAPKyr (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 16 Jan 2023 05:54:47 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 127D61F4A3
        for <linux-serial@vger.kernel.org>; Mon, 16 Jan 2023 02:54:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673866466; x=1705402466;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=3282WoEC6A2GD22FVqXj23sTjPjw/Q0mQ8zv1v5m5Jw=;
  b=TPU7DqoLNUhXvum3Xlkhw3+j1b78QoylNUTyI52MZgifa2WrgINewXSX
   kHFoQcPl1acoWdy/fLn+y9ttxpz1O1DInkDaOjskIzMdCPT+eVKD53sFA
   lkK0KihATPnlvobSt1tS9SumyFm54hOQVb4hW258Q4UHIY2HWcDAL4BXF
   DxlHIpL/MoA/V/5AUkDfPvG+nyxHlAxNK6065WMkY4YuJdqYOFpLLLNW5
   GSa0/ecGUFuuhYElcewCZr17zd8gm6+GPmUqLceHt7PZN6T1dIwmCsohw
   zDU0po7/akIcgsuP1Mi7NwtgU32JyZjV6N47UC6QqM3fPULR97So98blb
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10591"; a="386782360"
X-IronPort-AV: E=Sophos;i="5.97,220,1669104000"; 
   d="scan'208";a="386782360"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2023 02:54:25 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10591"; a="689443626"
X-IronPort-AV: E=Sophos;i="5.97,220,1669104000"; 
   d="scan'208";a="689443626"
Received: from xsanroma-mobl.ger.corp.intel.com ([10.252.39.155])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2023 02:54:21 -0800
Date:   Mon, 16 Jan 2023 12:54:19 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Sergey Organov <sorganov@gmail.com>
cc:     linux-serial@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
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
Subject: Re: [PATCH 6/8] serial: imx: stop using USR2 in FIFO reading loop
In-Reply-To: <20230113184334.287130-7-sorganov@gmail.com>
Message-ID: <3c9ab74b-ff90-8371-75cd-1d2f7abb388d@linux.intel.com>
References: <87bko4e65y.fsf@osv.gnss.ru> <20230113184334.287130-1-sorganov@gmail.com> <20230113184334.287130-7-sorganov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, 13 Jan 2023, Sergey Organov wrote:

> The chip provides all the needed bits in the URXD0 register that we read
> anyway for data, so get rid of reading USR2 and use only URXD0 bits
> instead.
> 
> Signed-off-by: Sergey Organov <sorganov@gmail.com>
> ---
>  drivers/tty/serial/imx.c | 18 ++++++------------
>  1 file changed, 6 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index c44a7293c013..be00362b8b67 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -892,27 +892,21 @@ static irqreturn_t __imx_uart_rxint(int irq, void *dev_id)
>  	struct tty_port *port = &sport->port.state->port;
>  	u32 usr2;
>  
> -	usr2 = imx_uart_readl(sport, USR2);
> -
>  	/* If we received something, check for 0xff flood */
> +	usr2 = imx_uart_readl(sport, USR2);

Please just place the read into the correct place in 2/8 rather than 
moving it needlessly here again.

-- 
 i.


>  	if (usr2 & USR2_RDR)
>  		imx_uart_check_flood(sport, usr2);
>  
> -	for ( ; usr2 & USR2_RDR; usr2 = imx_uart_readl(sport, USR2)) {
> +	while ((rx = imx_uart_readl(sport, URXD0)) & URXD_CHARRDY) {
>  		flg = TTY_NORMAL;
>  		sport->port.icount.rx++;
>  
> -		rx = imx_uart_readl(sport, URXD0);
> -
> -		if (usr2 & USR2_BRCD) {
> -			imx_uart_writel(sport, USR2_BRCD, USR2);
> -			if (uart_handle_break(&sport->port))
> -				continue;
> -		}
> -
>  		if (unlikely(rx & URXD_ERR)) {
> -			if (rx & URXD_BRK)
> +			if (rx & URXD_BRK) {
>  				sport->port.icount.brk++;
> +				if (uart_handle_break(&sport->port))
> +					continue;
> +			}
>  			else if (rx & URXD_PRERR)
>  				sport->port.icount.parity++;
>  			else if (rx & URXD_FRMERR)
> 
