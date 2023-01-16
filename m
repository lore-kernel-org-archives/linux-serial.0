Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CE07C46467
	for <linux-serial@archiver.kernel.org>; Mon, 16 Jan 2023 10:50:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbjAPKuu (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 16 Jan 2023 05:50:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbjAPKun (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 16 Jan 2023 05:50:43 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D93E3196B1
        for <linux-serial@vger.kernel.org>; Mon, 16 Jan 2023 02:50:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673866242; x=1705402242;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=vJ1ctAqTpkAtaU0BcmAYC7zGY080YYDGaag4oLsWUfI=;
  b=O5jFtIIoQcUdUnOzYB7EMh/aO12diZLbFUEZ+ie2rMJ2Xs9vPvicCNNR
   XdbjTtjmWiD45dSTLtZI/b8+OpY8Sga6T4oW6SxL0L5KKUP/Dh+MlW4a5
   i6w4qqv484xiWweA7ZQ2d4NpBJRh0j9XdyrwXztgo/EKy4xxJwsjKglk8
   3NS+niSN/lKfQNs/iuy0Av7Z+SUphQ4t2HSE0DsFjNKMaf5tfRxciKskr
   8R9Sdhn9hPG+hJI475EL7CD2GM9kR9ym3wgSOoKEEWXRSp8bXJiJ4FehG
   inWVvjZQj0UWGJjYx10tAHek6hZbduNZF2mAMZl4zWKRJ9Hu4VLwPmZzN
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10591"; a="326496162"
X-IronPort-AV: E=Sophos;i="5.97,220,1669104000"; 
   d="scan'208";a="326496162"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2023 02:50:42 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10591"; a="658981009"
X-IronPort-AV: E=Sophos;i="5.97,220,1669104000"; 
   d="scan'208";a="658981009"
Received: from xsanroma-mobl.ger.corp.intel.com ([10.252.39.155])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2023 02:50:38 -0800
Date:   Mon, 16 Jan 2023 12:50:35 +0200 (EET)
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
Subject: Re: [PATCH 5/8] serial: imx: remove redundant USR2 read from FIFO
 reading loop
In-Reply-To: <20230113184334.287130-6-sorganov@gmail.com>
Message-ID: <d83872e5-4aac-baad-9d8-12df8c411fb8@linux.intel.com>
References: <87bko4e65y.fsf@osv.gnss.ru> <20230113184334.287130-1-sorganov@gmail.com> <20230113184334.287130-6-sorganov@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1919270866-1673866241=:1723"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1919270866-1673866241=:1723
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Fri, 13 Jan 2023, Sergey Organov wrote:

> There is no need to read USR2 twice at every loop iteration: get rid of the
> second read.
> 
> Signed-off-by: Sergey Organov <sorganov@gmail.com>
> ---
>  drivers/tty/serial/imx.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index b96b0edc7854..c44a7293c013 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -904,7 +904,6 @@ static irqreturn_t __imx_uart_rxint(int irq, void *dev_id)
>  
>  		rx = imx_uart_readl(sport, URXD0);
>  
> -		usr2 = imx_uart_readl(sport, USR2);
>  		if (usr2 & USR2_BRCD) {
>  			imx_uart_writel(sport, USR2_BRCD, USR2);
>  			if (uart_handle_break(&sport->port))
> 

I was already wondering why it's read more than once.

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

--8323329-1919270866-1673866241=:1723--
