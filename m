Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97DBCC54EE9
	for <linux-serial@archiver.kernel.org>; Thu, 22 Sep 2022 16:01:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbiIVQBU (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 22 Sep 2022 12:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231602AbiIVQBO (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 22 Sep 2022 12:01:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EEE2102501
        for <linux-serial@vger.kernel.org>; Thu, 22 Sep 2022 09:01:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC01561222
        for <linux-serial@vger.kernel.org>; Thu, 22 Sep 2022 16:01:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD5A7C433B5;
        Thu, 22 Sep 2022 16:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1663862470;
        bh=zTjYFNo9J6AcwsAlDdkce04h/tgaSZA9mtVfmuvO+vU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cEzinr/TDu3nmGlnSMJLiwc8s0M61QYIJkvpR5c7Dp50nF9g7t4GNhBb9pUU6EqlR
         qiBRCZIKT0oMFPycrNsELzkIj6q7dKdLkUmA8C+ORsd8zFmCVfOpkEoUHMjqGIEzdk
         V611LAoomTAv4V7VKDaiq+zUJedPVQUffkc4tKyY=
Date:   Thu, 22 Sep 2022 18:01:07 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     linux-serial@vger.kernel.org
Subject: Re: [PATCH v3] serial: Deassert Transmit Enable on probe in
 driver-specific way
Message-ID: <YyyGw0MQofFLaq1V@kroah.com>
References: <2de36eba3fbe11278d5002e4e501afe0ceaca039.1663860626.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2de36eba3fbe11278d5002e4e501afe0ceaca039.1663860626.git.lukas@wunner.de>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Sep 22, 2022 at 05:36:33PM +0200, Lukas Wunner wrote:
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
>  drivers/tty/serial/8250/8250_omap.c |  3 +++
>  drivers/tty/serial/8250/8250_pci.c  |  9 +--------
>  drivers/tty/serial/8250/8250_port.c | 12 +++++++-----
>  drivers/tty/serial/fsl_lpuart.c     | 10 ++++------
>  drivers/tty/serial/imx.c            |  8 ++------
>  drivers/tty/serial/serial_core.c    | 36 ++++++++++++++++++++----------------
>  include/linux/serial_core.h         |  1 -
>  7 files changed, 37 insertions(+), 42 deletions(-)

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/SubmittingPatches for what needs to be done
  here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
