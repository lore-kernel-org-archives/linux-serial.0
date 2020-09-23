Return-Path: <SRS0=vWxX=DA=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E0FC2D0A8
	for <linux-serial@archiver.kernel.org>; Wed, 23 Sep 2020 16:20:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5160920BED
	for <linux-serial@archiver.kernel.org>; Wed, 23 Sep 2020 16:20:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbgIWQUB (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 23 Sep 2020 12:20:01 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:40222 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgIWQT6 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 23 Sep 2020 12:19:58 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 9AC68803073C;
        Wed, 23 Sep 2020 16:19:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Je9HNbMWeOV5; Wed, 23 Sep 2020 19:19:54 +0300 (MSK)
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Will Deacon <will@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/3] serial: 8250_dw: Fix clk-notifier/port suspend deadlock
Date:   Wed, 23 Sep 2020 19:19:47 +0300
Message-ID: <20200923161950.6237-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hans has discovered that there is a potential deadlock between the ref
clock change notifier and the port suspension procedures {see the link at
the bottom of the letter}. Indeed the deadlock is possible if the port
suspension is initiated during the ref clock rate change:

    CPU0 (suspend CPU/UART)   CPU1 (update clock)
             ----                    ----
    lock(&port->mutex);
                              lock((work_completion)(&data->clk_work));
                              lock(&port->mutex);
    lock((work_completion)(&data->clk_work));

    *** DEADLOCK ***

So the CPU performing the UART port shutdown procedure will wait until the
ref clock change notifier is finished (worker is flushed), while the later
will wait for a port mutex being released.

A possible solution to bypass the deadlock is to move the worker flush out
of the critical section protected by the TTY port mutex. For instance we
can register and de-register the clock change notifier in the port probe
and remove methods instead of having them called from the port
startup/shutdown callbacks. But in order to do that we need to make sure
that the serial8250_update_uartclk() method is safe to be used while the
port is shutted down. Alas the current implementation doesn't provide that
safety. The solution described above is introduced in the framework of
this patchset. See individual patches for details.

Link: https://lore.kernel.org/linux-serial/f1cd5c75-9cda-6896-a4e2-42c5bfc3f5c3@redhat.com

Hans, could you test the patchset out on your Cherry Trail (x86)-based
devices? After that we can merge it in into the kernels 5.8 and 5.9 if
there is no objections against the fix.

Note, in order to have the fix working for the older kernel all of patches
need to be backported.

Fixes: cc816969d7b5 ("serial: 8250_dw: Fix common clocks usage race condition")
Fixes: 868f3ee6e452 ("serial: 8250: Add 8250 port clock update method")
Reported-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Cc: Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Serge Semin (3):
  serial: 8250: Discard RTS/DTS setting from clock update method
  serial: 8250: Skip uninitialized TTY port baud rate update
  serial: 8250_dw: Fix clk-notifier/port suspend deadlock

 drivers/tty/serial/8250/8250_dw.c   | 54 ++++++++++-------------------
 drivers/tty/serial/8250/8250_port.c |  5 ++-
 2 files changed, 23 insertions(+), 36 deletions(-)

-- 
2.27.0

