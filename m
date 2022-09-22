Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1324AC6FA82
	for <linux-serial@archiver.kernel.org>; Thu, 22 Sep 2022 14:43:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbiIVOn5 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 22 Sep 2022 10:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231697AbiIVOn4 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 22 Sep 2022 10:43:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D6DD6AEA4
        for <linux-serial@vger.kernel.org>; Thu, 22 Sep 2022 07:43:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A13116126E
        for <linux-serial@vger.kernel.org>; Thu, 22 Sep 2022 14:43:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81F60C433C1;
        Thu, 22 Sep 2022 14:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1663857834;
        bh=YwHQq0FhvjqiPxBKD1Sk2kSS3UBduPxAxcSD2boUpQo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KrdjTsOPNBj1OCqQl0Voq+9R3udifkOMu92Sym+2Zvty7881OQb8y5vkeMy5M+IJP
         zV6GtcJg9CDBiRXrJFXRXu903PJX+W/rH6PKUMUuCaemiA199kNqyHBAsoYkFiueUh
         61R8YcX3kkLSmKB5WWL/PeONaEETWO4mcOGnr4Fg=
Date:   Thu, 22 Sep 2022 16:43:51 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Roosen Henri <Henri.Roosen@ginzinger.com>,
        linux-serial@vger.kernel.org,
        Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        David Laight <David.Laight@aculab.com>,
        Maarten Brock <m.brock@vanmierlo.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Su Bao Cheng <baocheng.su@siemens.com>,
        Chao Zeng <chao.zeng@siemens.com>,
        Peter Hung <hpeter+linux_kernel@gmail.com>,
        Daniel Golle <daniel@makrotopia.org>,
        "Codrin.Ciubotariu@microchip.com" <Codrin.Ciubotariu@microchip.com>,
        Sherry Sun <sherry.sun@nxp.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Ricardo Ribalda <ribalda@kernel.org>,
        Dario Binacchi <dariobin@libero.it>,
        Bich Hemon <bich.hemon@st.com>, Marek Vasut <marex@denx.de>,
        Vicente Bergas <vicencb@gmail.com>
Subject: Re: [PATCH v2] serial: Deassert Transmit Enable on probe in
 driver-specific way
Message-ID: <Yyx0p4d5vcjt2XNB@kroah.com>
References: <e688f63bc28827b0e8c9d8e2319e688aee412d24.1663733425.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e688f63bc28827b0e8c9d8e2319e688aee412d24.1663733425.git.lukas@wunner.de>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Sep 21, 2022 at 06:39:33AM +0200, Lukas Wunner wrote:
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
> Tested-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> Link: https://lore.kernel.org/all/20220329085050.311408-1-matthias.schiffer@ew.tq-group.com/
> Reported-by: Roosen Henri <Henri.Roosen@ginzinger.com>
> Link: https://lore.kernel.org/all/8f538a8903795f22f9acc94a9a31b03c9c4ccacb.camel@ginzinger.com/
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: stable@vger.kernel.org # v4.14+
> ---
>  v1 -> v2:
>  Deassert RTS in serial8250_em485_init() only if no transmission is
>  currently ongoing (Ilpo)
> 
>  Based on v6.0-rc3 + this dependency:
>  https://lore.kernel.org/linux-serial/72fb646c1b0b11c989850c55f52f9ff343d1b2fa.1662884345.git.lukas@wunner.de/

This message never made it to lore.kernel.org, so I can't seem to apply
it using `b4`.

Can you resend it so that it does make it to the public archives?

thanks,

greg k-h
