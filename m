Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD09BC46CA1
	for <linux-serial@archiver.kernel.org>; Mon, 18 Sep 2023 07:39:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232409AbjIRHjY (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 18 Sep 2023 03:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240117AbjIRHjJ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 18 Sep 2023 03:39:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B71CD2
        for <linux-serial@vger.kernel.org>; Mon, 18 Sep 2023 00:36:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D1EDC433C8;
        Mon, 18 Sep 2023 07:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695022560;
        bh=NC6o6Gz7c2YLjNoSh2OTjuNoOKqv3CP69KUmb1zCBjQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Tl2a2dw+5l4/y4pNiwOz2zI5vhS47otgDJGBm7itpbpYg+9U58HafwgDdT4/7L6Yq
         AuwgY7A0TXnxDB7fCeXoSn+UzGMVky2eb97wRk+e+222vRePEvM6qtnVsOJLJP93U7
         PgrQXK1Juh4f1SODXJu2HKNe94SACCgLu4FZ2vfs=
Date:   Mon, 18 Sep 2023 09:35:55 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Thomas Richard <thomas.richard@bootlin.com>
Cc:     linux-serial@vger.kernel.org
Subject: Re: Regression: serial: 8250_omap: error during suspend if
 no_console_suspend is set
Message-ID: <2023091839-basil-maybe-46b7@gregkh>
References: <8a856171-e743-737e-eb9d-42852e4e4f19@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a856171-e743-737e-eb9d-42852e4e4f19@bootlin.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Sep 14, 2023 at 06:26:44PM +0200, Thomas Richard wrote:
> Hi
> 
> After switching to Linux 6.6-rc1, i met an issue during suspend to idle
> with 8250_omap driver (no_console_suspend is set).
> The driver fails to suspend the uart port used for the serial console so
> the suspend sequence is stopped.
> 
> [  114.629197] port 2800000.serial:0.0: PM: calling
> pm_runtime_force_suspend+0x0/0x134 @ 114, parent: 2800000.serial:0
> [  114.639617] port 2800000.serial:0.0: PM:
> pm_runtime_force_suspend+0x0/0x134 returned 0 after 2 usecs
> [  114.648739] omap8250 2800000.serial: PM: calling
> omap8250_suspend+0x0/0xf4 @ 114, parent: bus@100000
> [  114.657861] omap8250 2800000.serial: PM: dpm_run_callback():
> omap8250_suspend+0x0/0xf4 returns -16
> [  114.666808] omap8250 2800000.serial: PM: omap8250_suspend+0x0/0xf4
> returned -16 after 8951 usecs
> [  114.675580] omap8250 2800000.serial: PM: failed to suspend: error -16
> [  114.682011] PM: suspend of devices aborted after 675.644 msecs
> [  114.687833] PM: start suspend of devices aborted after 681.777 msecs
> [  114.694175] PM: Some devices failed to suspend, or early wake event
> detected
> 
> The following sequence is used to suspend to idle:
> $ echo 1 > /sys/power/pm_debug_messages
> $ echo 1 > /sys/power/pm_print_times
> $ echo 8 > /proc/sys/kernel/printk
> $ echo 0 > /sys/module/printk/parameters/console_suspend
> $ echo enabled >
> /sys/devices/platform/bus@100000/2800000.serial/tty/ttyS2/power/wakeup
> $ echo s2idle > /sys/power/mem_sleep
> $ echo mem > /sys/power/state
> 
> The regression was introduced in commit 20a41a62618d "serial: 8250_omap:
> Use force_suspend and resume for system suspend"
> 
> Before commit 20a41a62618d, omap8250_suspend returned 0.
> Now pm_runtime_force_suspend is called and its return code is used by
> omap8250_suspend.
> 
> static int omap8250_suspend(struct device *dev)
> {
> 	struct omap8250_priv *priv = dev_get_drvdata(dev);
> 	struct uart_8250_port *up = serial8250_get_port(priv->line);
> 	int err;
> 
> 	serial8250_suspend_port(priv->line);
> 
> 	err = pm_runtime_resume_and_get(dev);
> 	if (err)
> 		return err;
> 	if (!device_may_wakeup(dev))
> 		priv->wer = 0;
> 	serial_out(up, UART_OMAP_WER, priv->wer);
> 	err = pm_runtime_force_suspend(dev);
> 	flush_work(&priv->qos_work);
> 
> 	return err;
> }
> 
> The pm_runtime_force_suspend function calls omap8250_runtime_suspend
> which returns -EBUSY because console suspend was disabled (which is my
> case), as explained in the code.
> 
> /*
>  * When using 'no_console_suspend', the console UART must not be
>  * suspended. Since driver suspend is managed by runtime suspend,
>  * preventing runtime suspend (by returning error) will keep device
>  * active during suspend.
>  */
> if (priv->is_suspending && !console_suspend_enabled) {
> 	if (up && uart_console(&up->port))
> 		return -EBUSY;
> }
> 
> The port is used by the console, so we don't want to suspend it (console
> suspend was disabled).
> Of course, if console_suspend is enabled and messages are disabled there
> is no issue.

Do you have a proposed patch to fix this?  Or should the original be
reverted?

thanks,

greg k-h
