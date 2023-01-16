Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 934E9C677F1
	for <linux-serial@archiver.kernel.org>; Mon, 16 Jan 2023 10:43:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbjAPKn6 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 16 Jan 2023 05:43:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbjAPKnD (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 16 Jan 2023 05:43:03 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 982091E9DF
        for <linux-serial@vger.kernel.org>; Mon, 16 Jan 2023 02:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673865678; x=1705401678;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=RfJT/JzRam+75L1tvavZrg0JqU9AGOUl5+//Cd9fB+8=;
  b=PgKB9grCDNHArev90RJem+2FOtupr38fi7x0ULjeWSEHcmKm8SW9yOQn
   TKO1y2ftLntuPXVRFcaV6/ee8nzUiR+pYHcrKYf6MdwWNV6Lxls619JP2
   lTU2LZANZ39YAhqJ+/UR9YwDpm1MmDP3UarirCTv2f3hy1yqdh//L+uN7
   3zSs+NhC4Z05WzpqBDdrAtaMucwJbjtWIkyIfoDIBeYmrxhyBNGm/Yesl
   AiAMaIfLuLEyAGXujObgt6j1u/zBIklcV4MUug+uz+LQ2E+I7mGjFqjMy
   CBpoqgl78NgXNhoZFxk/oo1lv1eJw08711q3uyY1UGi8o+/14iJVw57Ly
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10591"; a="351684093"
X-IronPort-AV: E=Sophos;i="5.97,220,1669104000"; 
   d="scan'208";a="351684093"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2023 02:41:18 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10591"; a="747681335"
X-IronPort-AV: E=Sophos;i="5.97,220,1669104000"; 
   d="scan'208";a="747681335"
Received: from xsanroma-mobl.ger.corp.intel.com ([10.252.39.155])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2023 02:41:14 -0800
Date:   Mon, 16 Jan 2023 12:41:11 +0200 (EET)
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
Subject: Re: [PATCH 3/8] serial: imx: do not sysrq broken chars
In-Reply-To: <20230113184334.287130-4-sorganov@gmail.com>
Message-ID: <1239d563-f14e-6542-842e-3f2be0f574b0@linux.intel.com>
References: <87bko4e65y.fsf@osv.gnss.ru> <20230113184334.287130-1-sorganov@gmail.com> <20230113184334.287130-4-sorganov@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-2015868155-1673865677=:1723"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2015868155-1673865677=:1723
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Fri, 13 Jan 2023, Sergey Organov wrote:

> Do not call uart_handle_sysrq_char() if we got any receive error along with
> the character, as we don't want random junk to be considered a sysrq.
> 
> Signed-off-by: Sergey Organov <sorganov@gmail.com>
> ---
>  drivers/tty/serial/imx.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index e7fce31e460d..1c950112a598 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -911,9 +911,6 @@ static irqreturn_t __imx_uart_rxint(int irq, void *dev_id)
>  				continue;
>  		}
>  
> -		if (uart_handle_sysrq_char(&sport->port, (unsigned char)rx))
> -			continue;
> -
>  		if (unlikely(rx & URXD_ERR)) {
>  			if (rx & URXD_BRK)
>  				sport->port.icount.brk++;
> @@ -942,7 +939,8 @@ static irqreturn_t __imx_uart_rxint(int irq, void *dev_id)
>  				flg = TTY_OVERRUN;
>  
>  			sport->port.sysrq = 0;
> -		}
> +		} else if (uart_handle_sysrq_char(&sport->port, (unsigned char)rx))
> +			continue;
>  
>  		if (sport->port.ignore_status_mask & URXD_DUMMY_READ)
>  			goto out;

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>


-- 
 i.

--8323329-2015868155-1673865677=:1723--
