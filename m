Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0350CEEAA53
	for <linux-serial@archiver.kernel.org>; Thu, 14 Sep 2023 16:26:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234922AbjINQ0v (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 14 Sep 2023 12:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234706AbjINQ0u (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 14 Sep 2023 12:26:50 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 333631BE3
        for <linux-serial@vger.kernel.org>; Thu, 14 Sep 2023 09:26:46 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 828EB240004;
        Thu, 14 Sep 2023 16:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1694708804;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=sGDxbo174giYxouY9sm9ZZi3efAvH8B+jOz7AvHVrWA=;
        b=icQ8mmmTw1NV+l40uLCvmo89IvTPWGFGY+LZeAbyO+Ly0/pNiLgE5vTqMdbAQrZBSDGI4+
        /ub/yH2seDCz0rmIieOf65jWlDB9+A9Pq2lOOOnw/Cq44r/HNavz4TqP3JCqIb4BFr18q4
        O+pQFX4/xg/txirPHclNKIU2yuIx8QUmslQ9CruowtiMt0Q5qvtijt5RWlk+mLDAY14j3s
        7lo34OrVDZP5rp3dvHVhmrixnxiIgOQMWELK0IfG5yqKYnwXi0euyXvuW5nt2QqJSRR83L
        nm/VCe2QDOxdsEPyhsxBBPjgfNxKmuPft5G2UFaPmg5GGUsQAf7bp576HK2cZw==
Message-ID: <8a856171-e743-737e-eb9d-42852e4e4f19@bootlin.com>
Date:   Thu, 14 Sep 2023 18:26:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
From:   Thomas Richard <thomas.richard@bootlin.com>
Subject: Regression: serial: 8250_omap: error during suspend if
 no_console_suspend is set
To:     linux-serial@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GND-Sasl: thomas.richard@bootlin.com
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi

After switching to Linux 6.6-rc1, i met an issue during suspend to idle
with 8250_omap driver (no_console_suspend is set).
The driver fails to suspend the uart port used for the serial console so
the suspend sequence is stopped.

[  114.629197] port 2800000.serial:0.0: PM: calling
pm_runtime_force_suspend+0x0/0x134 @ 114, parent: 2800000.serial:0
[  114.639617] port 2800000.serial:0.0: PM:
pm_runtime_force_suspend+0x0/0x134 returned 0 after 2 usecs
[  114.648739] omap8250 2800000.serial: PM: calling
omap8250_suspend+0x0/0xf4 @ 114, parent: bus@100000
[  114.657861] omap8250 2800000.serial: PM: dpm_run_callback():
omap8250_suspend+0x0/0xf4 returns -16
[  114.666808] omap8250 2800000.serial: PM: omap8250_suspend+0x0/0xf4
returned -16 after 8951 usecs
[  114.675580] omap8250 2800000.serial: PM: failed to suspend: error -16
[  114.682011] PM: suspend of devices aborted after 675.644 msecs
[  114.687833] PM: start suspend of devices aborted after 681.777 msecs
[  114.694175] PM: Some devices failed to suspend, or early wake event
detected

The following sequence is used to suspend to idle:
$ echo 1 > /sys/power/pm_debug_messages
$ echo 1 > /sys/power/pm_print_times
$ echo 8 > /proc/sys/kernel/printk
$ echo 0 > /sys/module/printk/parameters/console_suspend
$ echo enabled >
/sys/devices/platform/bus@100000/2800000.serial/tty/ttyS2/power/wakeup
$ echo s2idle > /sys/power/mem_sleep
$ echo mem > /sys/power/state

The regression was introduced in commit 20a41a62618d "serial: 8250_omap:
Use force_suspend and resume for system suspend"

Before commit 20a41a62618d, omap8250_suspend returned 0.
Now pm_runtime_force_suspend is called and its return code is used by
omap8250_suspend.

static int omap8250_suspend(struct device *dev)
{
	struct omap8250_priv *priv = dev_get_drvdata(dev);
	struct uart_8250_port *up = serial8250_get_port(priv->line);
	int err;

	serial8250_suspend_port(priv->line);

	err = pm_runtime_resume_and_get(dev);
	if (err)
		return err;
	if (!device_may_wakeup(dev))
		priv->wer = 0;
	serial_out(up, UART_OMAP_WER, priv->wer);
	err = pm_runtime_force_suspend(dev);
	flush_work(&priv->qos_work);

	return err;
}

The pm_runtime_force_suspend function calls omap8250_runtime_suspend
which returns -EBUSY because console suspend was disabled (which is my
case), as explained in the code.

/*
 * When using 'no_console_suspend', the console UART must not be
 * suspended. Since driver suspend is managed by runtime suspend,
 * preventing runtime suspend (by returning error) will keep device
 * active during suspend.
 */
if (priv->is_suspending && !console_suspend_enabled) {
	if (up && uart_console(&up->port))
		return -EBUSY;
}

The port is used by the console, so we don't want to suspend it (console
suspend was disabled).
Of course, if console_suspend is enabled and messages are disabled there
is no issue.

Best Regards,
