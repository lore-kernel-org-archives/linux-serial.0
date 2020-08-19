Return-Path: <SRS0=XS4C=B5=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26590C433E1
	for <linux-serial@archiver.kernel.org>; Wed, 19 Aug 2020 09:21:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CE2320639
	for <linux-serial@archiver.kernel.org>; Wed, 19 Aug 2020 09:21:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbgHSJVL (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 19 Aug 2020 05:21:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:42968 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726634AbgHSJVI (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 19 Aug 2020 05:21:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7302CADC1;
        Wed, 19 Aug 2020 09:21:33 +0000 (UTC)
Date:   Wed, 19 Aug 2020 11:21:06 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Tony Lindgren <tony@atomide.com>,
        Kurt Kanzenbach <kurt@linutronix.de>,
        Raul Rangel <rrangel@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-serial@vger.kernel.org
Subject: Re: [PATCHv2] serial: 8250: change lock order in
 serial8250_do_startup()
Message-ID: <20200819092106.GA4353@alley>
References: <20200817022646.1484638-1-sergey.senozhatsky@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200817022646.1484638-1-sergey.senozhatsky@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon 2020-08-17 11:26:46, Sergey Senozhatsky wrote:
> We have a number of "uart.port->desc.lock vs desc.lock->uart.port"
> lockdep reports coming from 8250 driver; this causes a bit of trouble
> to people, so let's fix it.
> 
> The problem is reverse lock order in two different call paths:
> 
> chain #1:
> 
>  serial8250_do_startup()
>   spin_lock_irqsave(&port->lock);
>    disable_irq_nosync(port->irq);
>     raw_spin_lock_irqsave(&desc->lock)
> 
> chain #2:
> 
>   __report_bad_irq()
>    raw_spin_lock_irqsave(&desc->lock)
>     for_each_action_of_desc()
>      printk()
>       spin_lock_irqsave(&port->lock);
> 
> Fix this by changing the order of locks in serial8250_do_startup():
>  do disable_irq_nosync() first, which grabs desc->lock, and grab
>  uart->port after that, so that chain #1 and chain #2 have same lock
>  order.
> 
> 
> Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

The patch is committed in printk/linux.git, branch for-5.10.

Best Regards,
Petr
