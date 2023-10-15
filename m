Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6667CDB47E
	for <linux-serial@archiver.kernel.org>; Sun, 15 Oct 2023 15:31:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbjJOPbI (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 15 Oct 2023 11:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjJOPbH (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 15 Oct 2023 11:31:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03540C5
        for <linux-serial@vger.kernel.org>; Sun, 15 Oct 2023 08:31:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF17DC433C7;
        Sun, 15 Oct 2023 15:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697383865;
        bh=ef7HZaJQbBNvwYpz1+0Yb2YzTML2tXXwKBW5PqNTF2g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HO6/WU4Au1INB46Y6Kl6wsjGizCyqc5PXxzmTAQ+g1mT3hC082SMcDXpI8xVnVCV+
         o+jcppG5+IGu0oF6Hmi4GEzDAEzscCFTHABbmIPnb7KUgHVCGXH4UwvJ6gga8imBn/
         MQZ0EDoLqeivtEMTVFOv0NSht/JulBzX2PjOvguU=
Date:   Sun, 15 Oct 2023 17:31:03 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Richard Purdie <richard.purdie@linuxfoundation.org>
Cc:     Mikko Rapeli <mikko.rapeli@linaro.org>,
        linux-serial@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
        openembedded-core <openembedded-core@lists.openembedded.org>,
        Bruce Ashfield <bruce.ashfield@gmail.com>,
        Randy MacLeod <randy.macleod@windriver.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: Kernel 6.5 ttyS1 hang with qemu (was Re: [OE-core] Summary of
 the remaining 6.5 kernel serial issue (and 6.5 summary)
Message-ID: <2023101516-unmolded-otter-e3e0@gregkh>
References: <178BF2895FF685E6.5378@lists.openembedded.org>
 <a2ad67a0575548b6d5d8d187e597dcd72ae07f64.camel@linuxfoundation.org>
 <ZSPQY6UYg21Z0PnN@nuoska>
 <1520ecb5f4b6959af835a7781b94694913f76912.camel@linuxfoundation.org>
 <178DF50519C11C84.8679@lists.openembedded.org>
 <b208c9c6b72be4ef0f2aadb7bed103280bff60a0.camel@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b208c9c6b72be4ef0f2aadb7bed103280bff60a0.camel@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sun, Oct 15, 2023 at 01:29:48PM +0100, Richard Purdie wrote:
> On Sat, 2023-10-14 at 12:13 +0100, Richard Purdie via
> lists.openembedded.org wrote:
> > On Sat, 2023-10-14 at 10:41 +0100, Richard Purdie wrote:
> > > Brief summary:
> > > 
> > > We're seeing an issue on x86_64 with 6.5.X where data appears to be
> > > left in the transmission buffer and not sent to the port on the second
> > > serial port (ttyS1) until we trigger it with intervention.
> > > 
> > > Paul Gortmaker did some painful bisection over a few days down to:
> > > 
> > > serial: core: Start managing serial controllers to enable runtime PM
> > > https://lore.kernel.org/linux-serial/1431f5b4-fb39-483b-9314-ed2b7c118c11@gmail.com/T/#t
> > 
> > Having poked around a bit and knowing nothing about any of this, should
> > this bit of new code added in the above commit to __uart_start() in
> > serial_core.c:
> > 
> > 	/*
> > 	 * Start TX if enabled, and kick runtime PM. If the device is not
> > 	 * enabled, serial_port_runtime_resume() calls start_tx()
> > again
> > 	 * after enabling the device.
> > 	 */
> > 	if (pm_runtime_active(&port_dev->dev))
> > 		port->ops->start_tx(port);
> > 
> > 
> > actually be something like:
> > 
> > 
> > 	if (pm_runtime_active(&port_dev->dev) || !pm_runtime_enabled(&port_dev->dev))
> > 		port->ops->start_tx(port);
> > 
> > 
> > since there are uarts that don't enable runtime PM?
> > 
> > I notice that 16550A I'm using doesn't set UART_CAP_RPM and since we
> > have data left in the xmit buffer (I managed to confirm that), it is as
> > if during init, there is a race between the serial probing and the
> > getty putting data in the buffer? If it weren't statrted, that would
> > explain things...
> 
> The above change didn't work but what does appear to be making a
> difference is making this code call start_tx unconditionally which is
> what it did prior to the patch. That does cause a "wake" when there
> might not be any data but the code handles that gracefully.
> 
> I therefore suspect this is the place the issue is, the question is
> what the right conditions for calling start_tx are?
> 
> I'll keep going with testing of that as the intermittent nature does
> make this hard to know if any change helps or not.

Can you try the patch below?  I just sent it to Linus and it's from Tony
to resolve some other pm issues with the serial port code.

thanks,

greg k-h

From 81a61051e0ce5fd7e09225c0d5985da08c7954a7 Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Thu, 5 Oct 2023 10:56:42 +0300
Subject: [PATCH 3/4] serial: core: Fix checks for tx runtime PM state

Maximilian reported that surface_serial_hub serdev tx does not work during
system suspend. During system suspend, runtime PM gets disabled in
__device_suspend_late(), and tx is unable to wake-up the serial core port
device that we use to check if tx is safe to start. Johan summarized the
regression noting that serdev tx no longer always works as earlier when the
serdev device is runtime PM active.

The serdev device and the serial core controller devices are siblings of
the serial port hardware device. The runtime PM usage count from serdev
device does not propagate to the serial core device siblings, it only
propagates to the parent.

In addition to the tx issue for suspend, testing for the serial core port
device can cause an unnecessary delay in enabling tx while waiting for the
serial core port device to wake-up. The serial core port device wake-up is
only needed to flush pending tx when the serial port hardware device was
in runtime PM suspended state.

To fix the regression, we need to check the runtime PM state of the parent
serial port hardware device for tx instead of the serial core port device.

As the serial port device drivers may or may not implement runtime PM, we
need to also add a check for pm_runtime_enabled().

Reported-by: Maximilian Luz <luzmaximilian@gmail.com>
Cc: stable <stable@kernel.org>
Fixes: 84a9582fd203 ("serial: core: Start managing serial controllers to enable runtime PM")
Signed-off-by: Tony Lindgren <tony@atomide.com>
Tested-by: Maximilian Luz <luzmaximilian@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://lore.kernel.org/r/20231005075644.25936-1-tony@atomide.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/serial_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index ca26a8aef2cb..d5ba6e90bd95 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -156,7 +156,7 @@ static void __uart_start(struct uart_state *state)
 	 * enabled, serial_port_runtime_resume() calls start_tx() again
 	 * after enabling the device.
 	 */
-	if (pm_runtime_active(&port_dev->dev))
+	if (!pm_runtime_enabled(port->dev) || pm_runtime_active(port->dev))
 		port->ops->start_tx(port);
 	pm_runtime_mark_last_busy(&port_dev->dev);
 	pm_runtime_put_autosuspend(&port_dev->dev);
-- 
2.42.0

