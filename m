Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30899C54EE9
	for <linux-serial@archiver.kernel.org>; Fri, 16 Sep 2022 12:28:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbiIPM2I (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 16 Sep 2022 08:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbiIPM2H (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 16 Sep 2022 08:28:07 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920C4B14FB
        for <linux-serial@vger.kernel.org>; Fri, 16 Sep 2022 05:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663331285; x=1694867285;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=6AZaI0eYQkJs0a4XMXGeGaTqrNDNELZ4cNIKUOU6H/M=;
  b=Y8C+p5/6dUYXGVM2MrRCZOO8P6tzS0werqJ7secShRvYAWx3Gbl0R4pK
   99m5ZGB4kLHuGYKBqrvf03S5SShq1ImQirfdohivLoygUdU/KLM82TYRg
   SwsIMXpBNnPuhqd0KOxq7deWaB2AcDy+KCtpnJRmBYoNqNBd3BWOr7oY1
   jMUjYCi3nmCEbWXlWKQbUvug1Is6dITpPASATfRbwLrUmvKVoYVltIHu0
   GLAz3Vno1WBcclUy7GXXYz4f3oR9OzXu1/z4jfoZ3aebCW3bSC3z4p0Y2
   xhyzoA9uosCJsWRDZRNV22qoCi77HUYz6+vadu/1AuQGRwYQacsidJ9yd
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10471"; a="385271627"
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="385271627"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 05:28:05 -0700
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="620078217"
Received: from lroque-mobl1.amr.corp.intel.com ([10.251.209.126])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 05:27:59 -0700
Date:   Fri, 16 Sep 2022 15:27:58 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Lukas Wunner <lukas@wunner.de>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Roosen Henri <Henri.Roosen@ginzinger.com>,
        linux-serial <linux-serial@vger.kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        David Laight <David.Laight@ACULAB.COM>,
        Maarten Brock <m.brock@vanmierlo.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Su Bao Cheng <baocheng.su@siemens.com>, baocheng_su@163.com,
        Chao Zeng <chao.zeng@siemens.com>,
        Peter Hung <hpeter+linux_kernel@gmail.com>,
        Joachim Eastwood <manabian@gmail.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Codrin Ciubotariu <Codrin.Ciubotariu@microchip.com>,
        Sherry Sun <sherry.sun@nxp.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Ricardo Ribalda <ribalda@kernel.org>,
        Dario Binacchi <dariobin@libero.it>,
        Bich Hemon <bich.hemon@st.com>, Marek Vasut <marex@denx.de>
Subject: Re: [PATCH] serial: Deassert RS485 Transmit Enable on probe in
 driver-specific way
In-Reply-To: <b17842d9792762948f75d74205596d36bdd27f22.1663310999.git.lukas@wunner.de>
Message-ID: <94e754d-12ae-271c-9462-7f90ebb2b164@linux.intel.com>
References: <b17842d9792762948f75d74205596d36bdd27f22.1663310999.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, 16 Sep 2022, Lukas Wunner wrote:

> When a UART port is newly registered, uart_configure_port() seeks to
> deassert RS485 Transmit Enable by setting the RTS bit in port->mctrl.
> However a number of UART drivers interpret a set RTS bit as *assertion*
> instead of deassertion:  Affected drivers include those using
> serial8250_em485_config() (except 8250_bcm2835aux.c) and some using
> mctrl_gpio (e.g. imx.c).
> 
> Since the interpretation of the RTS bit is driver-specific, it is not
> suitable as a means to centrally deassert Transmit Enable in the serial
> core.  Instead, the serial core must call on drivers to deassert it in
> their driver-specific way.  One way to achieve that is to call
> ->rs485_config().  It implicitly deasserts Transmit Enable.
> 
> So amend uart_configure_port() and uart_resume_port() to invoke
> uart_rs485_config().  That allows removing calls to uart_rs485_config()
> from drivers' ->probe() hooks and declaring the function static.
> 
> Skip any invocation of ->set_mctrl() if RS485 is enabled.  RS485 has no
> hardware flow control, so the modem control lines are irrelevant and
> need not be touched.  When leaving RS485 mode, reset the modem control
> lines to the state stored in port->mctrl.  That way, UARTs which are
> muxed between RS485 and RS232 transceivers drive the lines correctly
> when switched to RS232.  (serial8250_do_startup() historically raises
> the OUT1 modem signal because otherwise interrupts are not signaled on
> ancient PC UARTs, but I believe that no longer applies to modern,
> RS485-capable UARTs and is thus safe to be skipped.)
> 
> imx.c modifies port->mctrl whenever Transmit Enable is asserted and
> deasserted.  Stop it from doing that so port->mctrl reflects the RS232
> line state.
> 
> 8250_omap.c deasserts Transmit Enable on ->runtime_resume() by calling
> ->set_mctrl().  Because that is now a no-op in RS485 mode, amend the
> function to call serial8250_em485_stop_tx().
> 
> fsl_lpuart.c retrieves and applies the RS485 device tree properties
> after registering the UART port.  Because applying now happens on
> registration in uart_configure_port(), move retrieval of the properties
> ahead of uart_add_one_port().
> 
> Fixes: d3b3404df318 ("serial: Fix incorrect rs485 polarity on uart open")
> Reported-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> Link: https://lore.kernel.org/all/20220329085050.311408-1-matthias.schiffer@ew.tq-group.com/
> Reported-by: Roosen Henri <Henri.Roosen@ginzinger.com>
> Link: https://lore.kernel.org/all/8f538a8903795f22f9acc94a9a31b03c9c4ccacb.camel@ginzinger.com/
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: stable@vger.kernel.org # v4.14+
> ---
>  Based on v6.0-rc3 + this dependency:
>  https://lore.kernel.org/linux-serial/72fb646c1b0b11c989850c55f52f9ff343d1b2fa.1662884345.git.lukas@wunner.de/

> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index 907c5ff..a6f03b1 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -600,7 +600,7 @@ void serial8250_rpm_put(struct uart_8250_port *p)
>  static int serial8250_em485_init(struct uart_8250_port *p)
>  {
>  	if (p->em485)
> -		return 0;
> +		goto deassert_rts;
>  
>  	p->em485 = kmalloc(sizeof(struct uart_8250_em485), GFP_ATOMIC);
>  	if (!p->em485)
> @@ -616,6 +616,7 @@ static int serial8250_em485_init(struct uart_8250_port *p)
>  	p->em485->active_timer = NULL;
>  	p->em485->tx_stopped = true;
>  
> +deassert_rts:
>  	p->rs485_stop_tx(p);

	if (p->em485->tx_stopped)
		p->rs485_stop_tx(p);

?

Because if p->em485->tx_stopped is false and serial8250_em485_init() is 
called again (the comment above it says it is safe to do so), it would 
stop tx at wrong point.

-- 
 i.

