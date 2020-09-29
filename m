Return-Path: <SRS0=bP+p=DG=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9381BC4727C
	for <linux-serial@archiver.kernel.org>; Tue, 29 Sep 2020 20:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 419C820757
	for <linux-serial@archiver.kernel.org>; Tue, 29 Sep 2020 20:51:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728480AbgI2Uv5 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 29 Sep 2020 16:51:57 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:36656 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728362AbgI2Uv5 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 29 Sep 2020 16:51:57 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 0AA59803086A;
        Tue, 29 Sep 2020 20:51:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id r4WGwg0cF7DZ; Tue, 29 Sep 2020 23:51:49 +0300 (MSK)
Date:   Tue, 29 Sep 2020 23:51:45 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Hans de Goede <hdegoede@redhat.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Will Deacon <will@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] serial: 8250_dw: Fix clk-notifier/port suspend
 deadlock
Message-ID: <20200929205145.23itpxwns32uhjnx@mobilestation>
References: <20200923161950.6237-1-Sergey.Semin@baikalelectronics.ru>
 <e508b9c8-bcc4-00a6-0ca0-0b4a0c34f626@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e508b9c8-bcc4-00a6-0ca0-0b4a0c34f626@redhat.com>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hello,

On Sun, Sep 27, 2020 at 05:01:52PM +0200, Hans de Goede wrote:
> Hi,
> 
> On 9/23/20 6:19 PM, Serge Semin wrote:
> > Hans has discovered that there is a potential deadlock between the ref
> > clock change notifier and the port suspension procedures {see the link at
> > the bottom of the letter}. Indeed the deadlock is possible if the port
> > suspension is initiated during the ref clock rate change:
> > 
> >      CPU0 (suspend CPU/UART)   CPU1 (update clock)
> >               ----                    ----
> >      lock(&port->mutex);
> >                                lock((work_completion)(&data->clk_work));
> >                                lock(&port->mutex);
> >      lock((work_completion)(&data->clk_work));
> > 
> >      *** DEADLOCK ***
> > 
> > So the CPU performing the UART port shutdown procedure will wait until the
> > ref clock change notifier is finished (worker is flushed), while the later
> > will wait for a port mutex being released.
> > 
> > A possible solution to bypass the deadlock is to move the worker flush out
> > of the critical section protected by the TTY port mutex. For instance we
> > can register and de-register the clock change notifier in the port probe
> > and remove methods instead of having them called from the port
> > startup/shutdown callbacks. But in order to do that we need to make sure
> > that the serial8250_update_uartclk() method is safe to be used while the
> > port is shutted down. Alas the current implementation doesn't provide that
> > safety. The solution described above is introduced in the framework of
> > this patchset. See individual patches for details.
> > 
> > Link: https://lore.kernel.org/linux-serial/f1cd5c75-9cda-6896-a4e2-42c5bfc3f5c3@redhat.com
> > 
> > Hans, could you test the patchset out on your Cherry Trail (x86)-based
> > devices? After that we can merge it in into the kernels 5.8 and 5.9 if
> > there is no objections against the fix.
> 
> Done, I can confirm that this fixes the lockdep issue for me, so you
> can add my:
> 
> Tested-by: Hans de Goede <hdegoede@redhat.com>

Great! Thank you very much.

Greg, could you merge the series in if you have no objection against the
solution design? Seeing the bug has been introduced together with the
original series integrated in the kernel 5.9, the fix provided by this
patchset will be only needed in 5.9.

-Sergey

> 
> To the entire series.
> 
> Regards,
> 
> Hans
> 
