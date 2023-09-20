Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A93C00523
	for <linux-serial@archiver.kernel.org>; Wed, 20 Sep 2023 14:36:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236711AbjITOg5 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 20 Sep 2023 10:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236710AbjITOg3 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 20 Sep 2023 10:36:29 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E43AD
        for <linux-serial@vger.kernel.org>; Wed, 20 Sep 2023 07:36:19 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qiyJN-0007A7-N9; Wed, 20 Sep 2023 16:36:17 +0200
Message-ID: <33bf96d0-fbe0-dfb4-a791-233f49f9080d@leemhuis.info>
Date:   Wed, 20 Sep 2023 16:36:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regression: serial: 8250_omap: error during suspend if
 no_console_suspend is set
Content-Language: en-US, de-DE
References: <8a856171-e743-737e-eb9d-42852e4e4f19@bootlin.com>
From:   "Linux regression tracking #adding (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Cc:     linux-serial@vger.kernel.org, thomas.richard@bootlin.com
To:     Linux kernel regressions list <regressions@lists.linux.dev>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <8a856171-e743-737e-eb9d-42852e4e4f19@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1695220579;3b42b8a8;
X-HE-SMSGID: 1qiyJN-0007A7-N9
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

[CCing the regression list, as it should be in the loop for regressions:
https://docs.kernel.org/admin-guide/reporting-regressions.html]

[Note: part of this is now handled here:
https://lore.kernel.org/all/59b13c93-6637-3050-c145-31be0d6c12c9@bootlin.com/]

[TLDR: I'm adding this report to the list of tracked Linux kernel
regressions; the text you find below is based on a few templates
paragraphs you might have encountered already in similar form.]

On 14.09.23 18:26, Thomas Richard wrote:
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


Thanks for the report. To be sure the issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
tracking bot:

#regzbot ^introduced 20a41a62618d
#regzbot title serial: 8250_omap: suspend issue with console_suspend
disabled
#regzbot monitor:
https://lore.kernel.org/all/59b13c93-6637-3050-c145-31be0d6c12c9@bootlin.com/
#regzbot ignore-activity

This isn't a regression? This issue or a fix for it are already
discussed somewhere else? It was fixed already? You want to clarify when
the regression started to happen? Or point out I got the title or
something else totally wrong? Then just reply and tell me -- ideally
while also telling regzbot about it, as explained by the page listed in
the footer of this mail.

Developers: When fixing the issue, remember to add 'Link:' tags pointing
to the report (the parent of this mail). See page linked in footer for
details.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.
