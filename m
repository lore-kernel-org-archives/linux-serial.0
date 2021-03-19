Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC4C5C433E6
	for <linux-serial@archiver.kernel.org>; Fri, 19 Mar 2021 08:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6F7964F6A
	for <linux-serial@archiver.kernel.org>; Fri, 19 Mar 2021 08:10:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234296AbhCSIKT (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 19 Mar 2021 04:10:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:50964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234084AbhCSIJt (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 19 Mar 2021 04:09:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 390DC64F68;
        Fri, 19 Mar 2021 08:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616141389;
        bh=8yyL1lc9w1zEvs02giHe/AkhySpLaZuLjBUihev2WZ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Og2XGq/C9jDWrFpkn7jIMmJ42fTa76imA6COYLkGsphWC8N7QNr0CGZXcBkNn5hec
         FsxHbz4caYtDKM9wsahMmOLDIGuNhvPqIYWUvn7rj5TCM4+MpAWWMS+31omZS6tZHn
         7Mu77FSS7n1U/61aoUqnS9/1Wfaqh2F7DaKCm9CY40cD+92yxaX7iZjp1J8wuQHCK+
         XqRk4V0Qa+TomLDA9SXtKcTPKXMjZJrZhDO86Zia5TTv1vk9G+stk7fogSpQpISehZ
         uKgm+vhAevfpaX+HtrEfpCx9jzkB7yLVl+6NTkYm3Ciaz7Cl0vFlcAMV2IbtJePVXQ
         nNOnd9DXYhk3Q==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lNACu-0001jF-Ft; Fri, 19 Mar 2021 09:10:09 +0100
Date:   Fri, 19 Mar 2021 09:10:08 +0100
From:   Johan Hovold <johan@kernel.org>
To:     "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Finn Thain <fthain@telegraphics.com.au>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hector Martin <marcan@marcan.st>,
        Arnd Bergmann <arnd@kernel.org>
Subject: Re: [PATCH] tty: serial: samsung_tty: remove spinlock flags in
 interrupt handlers
Message-ID: <YFRcYCMQrPXUG6ZU@hovoldconsulting.com>
References: <20210315181212.113217-1-krzysztof.kozlowski@canonical.com>
 <YFB0OcBg3Vj555eA@hovoldconsulting.com>
 <CAHp75VfcbC63t_eZeBOA0NY28BtGBD0YyLR6nSNuKAnKhXTSzA@mail.gmail.com>
 <4771468d968a44789518bc547acf5f93@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4771468d968a44789518bc547acf5f93@hisilicon.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Mar 19, 2021 at 06:36:39AM +0000, Song Bao Hua (Barry Song) wrote:
> 
> 
> > -----Original Message-----
> > From: Andy Shevchenko [mailto:andy.shevchenko@gmail.com]
> > Sent: Tuesday, March 16, 2021 10:41 PM
> > To: Johan Hovold <johan@kernel.org>; Finn Thain <fthain@telegraphics.com.au>;
> > Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>
> > Cc: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>; Greg
> > Kroah-Hartman <gregkh@linuxfoundation.org>; Jiri Slaby <jirislaby@kernel.org>;
> > linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>; Linux Samsung
> > SOC <linux-samsung-soc@vger.kernel.org>; open list:SERIAL DRIVERS
> > <linux-serial@vger.kernel.org>; Linux Kernel Mailing List
> > <linux-kernel@vger.kernel.org>; Hector Martin <marcan@marcan.st>; Arnd
> > Bergmann <arnd@kernel.org>
> > Subject: Re: [PATCH] tty: serial: samsung_tty: remove spinlock flags in
> > interrupt handlers
> > 
> > On Tue, Mar 16, 2021 at 11:02 AM Johan Hovold <johan@kernel.org> wrote:
> > >
> > > On Mon, Mar 15, 2021 at 07:12:12PM +0100, Krzysztof Kozlowski wrote:
> > > > Since interrupt handler is called with disabled local interrupts, there
> > > > is no need to use the spinlock primitives disabling interrupts as well.
> > >
> > > This isn't generally true due to "threadirqs" and that can lead to
> > > deadlocks if the console code is called from hard irq context.
> > >
> > > Now, this is *not* the case for this particular driver since it doesn't
> > > even bother to take the port lock in console_write(). That should
> > > probably be fixed instead.
> > >
> > > See https://lore.kernel.org/r/X7kviiRwuxvPxC8O@localhost.
> > 
> > Finn, Barry, something to check I think?
> 
> My understanding is that spin_lock_irqsave can't protect the context
> the console_write() is called in hardirq for threaded_irq case mainly
> for preempt-rt scenarios as spin_lock_irqsave doesn't disable irq in
> that case at all.

Forced threaded interrupts have so far run with interrupts enabled and
spin_lock_irqsave() would suffice on non-RT. This is about to change
though so that drivers don't need to worry about "threadirqs":

	https://lore.kernel.org/r/20210317143859.513307808@linutronix.de

> See:
> https://www.kernel.org/doc/html/latest/locking/locktypes.html
> spinlock_t and PREEMPT_RT
> On a PREEMPT_RT kernel spinlock_t is mapped to a separate implementation
> based on rt_mutex which changes the semantics:
> Preemption is not disabled.
> The hard interrupt related suffixes for spin_lock / spin_unlock operations
> (_irq, _irqsave / _irqrestore) do not affect the CPU’s interrupt disabled
> state.
> 
> So if console_write() can interrupt our code in hardirq, we should
> move to raw_spin_lock_irqsave for this driver.

No, no. RT handles this by deferring console writes apparently.

> I think it is almost always wrong to call spin_lock_irqsave in hardirq.

Again, no. It's even been a requirement due to "threadirqs" in some
cases (e.g. hrtimers) up until now (or rather until the above patch is
in mainline).

Johan
