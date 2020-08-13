Return-Path: <SRS0=hLv5=BX=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9938FC433E1
	for <linux-serial@archiver.kernel.org>; Thu, 13 Aug 2020 12:03:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 773F020791
	for <linux-serial@archiver.kernel.org>; Thu, 13 Aug 2020 12:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597320235;
	bh=lzzY6+Qcf/8rSg07fhVvKCT1rgjxgjHFEq/i2gpmSS4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zS+cmmDcX07FR8OHgkLqGaMzas6ivEZbWNmYzESbxAdTgQfgVGfaKP9AxKmVq2Hl+
	 1IyGUXw75iika3szpR6h5VPe3Nuz8MC9ySO6KpNJmuVEfoV7Tpkm83ZZtFNa3BdbEG
	 3B8J71MnoWYFBcIXJjK/QmvC/aQGV7CojnbJ5/xI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbgHMMAK (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 13 Aug 2020 08:00:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:48164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726568AbgHML7p (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 13 Aug 2020 07:59:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80B41208B3;
        Thu, 13 Aug 2020 11:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597319979;
        bh=lzzY6+Qcf/8rSg07fhVvKCT1rgjxgjHFEq/i2gpmSS4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KTXkQX0LNCLLJcbpSLJmay7ngasF0z/VwY1Vilw/lbDE6KX2ZqvNLnGoADA/0sbBb
         QowOFoCQW4ZW5nwFoEliV7MDbpRrwYCFkJPaJ/+jUFqNY9oRxajKTdJJHOW+wOEKy/
         /DV6vxXdfaz2odQKwTzcFeqfZmw0FS7iWfSlkcXU=
Date:   Thu, 13 Aug 2020 13:59:48 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Recursive/circular locking in
 serial8250_console_write/serial8250_do_startup
Message-ID: <20200813115948.GA3854926@kroah.com>
References: <20200812154813.GA46894@roeck-us.net>
 <20200813050629.GA95559@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200813050629.GA95559@roeck-us.net>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Aug 12, 2020 at 10:06:29PM -0700, Guenter Roeck wrote:
> On Wed, Aug 12, 2020 at 08:48:13AM -0700, Guenter Roeck wrote:
> > Hi,
> > 
> > crbug.com/1114800 reports a hard lockup due to circular locking in the
> > 8250 console driver. This is seen if CONFIG_PROVE_LOCKING is enabled.
> > 
> > Problem is as follows:
> > - serial8250_do_startup() locks the serial (console) port.
> > - serial8250_do_startup() then disables interrupts if interrupts are
> >   shared, by calling disable_irq_nosync().
> > - disable_irq_nosync() calls __irq_get_desc_lock() to lock the interrupt
> >   descriptor.
> > - __irq_get_desc_lock() calls lock_acquire()
> > - If CONFIG_PROVE_LOCKING is enabled, validate_chain() and check_noncircular()
> >   are called and identify a potential locking error.
> > - This locking error is reported via printk, which ultimately calls
> >   serial8250_console_write().
> > - serial8250_console_write() tries to lock the serial console port.
> >   Since it is already locked, the system hangs and ultimately reports
> >   a hard lockup.
> > 
> > I understand we'll need to figure out and fix what lockdep complains about,
> > and I am working on that. However, even if that is fixed, we'll need a
> > solution for the recursive lock: Fixing the lockdep problem doesn't
> > guarantee that a similar problem (or some other log message) won't be
> > detected and reported sometime in the future while serial8250_do_startup()
> > holds the console port lock.
> > 
> > Ideas, anyone ? Everything I came up with so far seems clumsy and hackish.
> > 
> 
> Turns out the situation is a bit worse than I thought. disable_irq_nosync(),
> when called from serial8250_do_startup(), locks the interrupt descriptor.
> The order of locking is
> 	serial port lock
> 	  interrupt descriptor lock
> 
> At the same time, __setup_irq() locks the interrupt descriptor as well.
> With the descriptor locked, it may report an error message using pr_err().
> This in turn may call serial8250_console_write(), which will try to lock
> the console serial port. The lock sequence is
> 	interrupt descriptor lock
> 	  serial port lock
> 
> I added the lockdep splat to the bug log at crbug.com/1114800.
> 
> Effectively, I think, this means we can't call disable_irq_nosync()
> while holding a serial port lock, or at least not while holding a
> serial port lock that is associated with a console.
> 
> The problem was introduced (or, rather, exposed) with upstream commit
> 7febbcbc48fc ("serial: 8250: Check UPF_IRQ_SHARED in advance").

Adding Andy, who wrote the above commit :)

Andy, any thoughts?

