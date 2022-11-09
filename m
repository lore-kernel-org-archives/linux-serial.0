Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC52C433FE
	for <linux-serial@archiver.kernel.org>; Wed,  9 Nov 2022 08:21:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiKIIV6 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 9 Nov 2022 03:21:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiKIIV5 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 9 Nov 2022 03:21:57 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F2F21CFD5
        for <linux-serial@vger.kernel.org>; Wed,  9 Nov 2022 00:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667982116; x=1699518116;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=VMrD3pLP+mqv6TezKopc1BPgIejnnUIw0KzNtfIhXyc=;
  b=lVzbDbP55Zv6eDYXVJXvXfP4DeEpVeBCg5mk3Zk6iX09rDcN9qjtOo/S
   5eeHuqPEiQwD85pkfhirCzjTZNt1D7zgdX94uCUHzRfm483YiIudR5akt
   s25gih4/yeBZlmr/AMapx5zqWKfHd6MU+cp9dd1YGO0MdT5uoT85NmvZt
   BfQTUm8LpooIxM6pbqc3etU6HYUWf0Ddrac5LmIOdylZ9b2xDa0zy3fr4
   WE9VpsJSS8UHl4cstxkmswWSNdNf4LXZ7quxW+qRhu8g1+n+dpRBWPaHS
   URrtzqXoSvs14U3lV4sK5YNmXaVNV4txgKxbNAf7O4v09Ou5rFZ3AILrt
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="397214582"
X-IronPort-AV: E=Sophos;i="5.96,149,1665471600"; 
   d="scan'208";a="397214582"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 00:21:56 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="725891752"
X-IronPort-AV: E=Sophos;i="5.96,149,1665471600"; 
   d="scan'208";a="725891752"
Received: from jsanche3-mobl1.ger.corp.intel.com ([10.251.219.48])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 00:21:46 -0800
Date:   Wed, 9 Nov 2022 10:21:35 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Lukas Wunner <lukas@wunner.de>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Dan Carpenter <error27@gmail.com>,
        linux-serial <linux-serial@vger.kernel.org>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Vignesh Raghavendra <vigneshr@ti.com>, Bin Liu <b-liu@ti.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Su Bao Cheng <baocheng.su@siemens.com>,
        Nishanth Menon <nm@ti.com>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        Zeng Chao <chao.zeng@siemens.com>
Subject: Re: [PATCH tty-next] serial: 8250: 8250_omap: Fix calculation of
 RS485 delays
In-Reply-To: <7d5b04da13d89b8708b9543a0b125f2b6062a77b.1667977259.git.lukas@wunner.de>
Message-ID: <4ede67f0-3839-3de1-6b48-787229135e6d@linux.intel.com>
References: <7d5b04da13d89b8708b9543a0b125f2b6062a77b.1667977259.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-2084623902-1667982109=:8279"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2084623902-1667982109=:8279
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Wed, 9 Nov 2022, Lukas Wunner wrote:

> Commit 801954d1210a ("serial: 8250: 8250_omap: Support native RS485")
> calculates RS485 delays from the baudrate.  The baudrate is generated
> with either a 16x or 13x divisor.  The divisor is set in the Mode
> Definition Register 1 (MDR1).
> 
> The commit erroneously assumes that the register stores the divisor as
> a bitmask and uses a logical AND to differentiate between 16x and 13x
> divisors.  However the divisor is really stored as a 3-bit mode
> (see lines 363ff in include/uapi/linux/serial_reg.h).
> 
> The logical AND operation is performed with UART_OMAP_MDR1_16X_MODE,
> which is defined as 0x0 and hence yields false.  So the commit always
> assumes a 13x divisor.  Fix by using an equal comparison.  This works
> because we never set any of the other 5 bits in the register.  (They
> pertain to IrDA mode, which is not supported by the driver).
> 
> Fixes: 801954d1210a ("serial: 8250: 8250_omap: Support native RS485")
> Link: https://lore.kernel.org/linux-serial/202211070440.8hWunFUN-lkp@intel.com/
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <error27@gmail.com>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> ---
>  drivers/tty/serial/8250/8250_omap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
> index 1dd8c5b..734f092 100644
> --- a/drivers/tty/serial/8250/8250_omap.c
> +++ b/drivers/tty/serial/8250/8250_omap.c
> @@ -824,7 +824,7 @@ static int omap8250_rs485_config(struct uart_port *port,
>  	 * of the AM65 TRM:  https://www.ti.com/lit/ug/spruid7e/spruid7e.pdf
>  	 */
>  	if (priv->quot) {
> -		if (priv->mdr1 & UART_OMAP_MDR1_16X_MODE)
> +		if (priv->mdr1 == UART_OMAP_MDR1_16X_MODE)
>  			baud = port->uartclk / (16 * priv->quot);
>  		else
>  			baud = port->uartclk / (13 * priv->quot);

It was very lucky that 16x mode happened to be zero so that automation 
could catch this problem.

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

--8323329-2084623902-1667982109=:8279--
