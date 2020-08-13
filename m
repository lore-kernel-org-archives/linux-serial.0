Return-Path: <SRS0=hLv5=BX=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0793BC433E1
	for <linux-serial@archiver.kernel.org>; Thu, 13 Aug 2020 18:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5A862078B
	for <linux-serial@archiver.kernel.org>; Thu, 13 Aug 2020 18:38:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cQuRgKxk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbgHMSiy (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 13 Aug 2020 14:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbgHMSiy (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 13 Aug 2020 14:38:54 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D3BC061757;
        Thu, 13 Aug 2020 11:38:53 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id mw10so3162031pjb.2;
        Thu, 13 Aug 2020 11:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=q9FZKBKaijBL83LWUXEI07doO/72KYcb0943qIVuCGk=;
        b=cQuRgKxk7ii1ahgzQBt2a6E/hk/uKMKoxQxk/M03Z4iovEUCnsMaXBuWo6heLlRagN
         Fr7SCYo+byMV6uIcv9vB4Nx0Nwvczuv+gZY+kD5gAG5xbcWUMM0OpAYQ10DXZKY5FNtW
         DsQPfaKsSiwDfjr1TXPs1asDiXqlj6h/zeWDTCqOf3q46vXCbJWYSJZa4RveDnCecA6e
         LHUwxbo953e9G93TOw10bRn93u2cZVr134s/tselEWPxv/fVYc1j4mKS1Tx7XeUg21hG
         VzoocourUc+sTZ4X8WCRin3NkRVtwRS+W9/oKrrMsBQ0IyadIl0xg3cVm2FIYL55aFXh
         btLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=q9FZKBKaijBL83LWUXEI07doO/72KYcb0943qIVuCGk=;
        b=Vf1fOgjK/cbKcjbvmEIIRpyJj5zdtzB7sF8Kt7mRHQTVTVCjH3OJx5pj+vcIVWODs5
         21nQcmndwi/hxHEns/Ua4R6yd6GORsxADVEHY41mxPH12fqtBQIXAzgUNls4q81gjrMi
         V3rR81DR2A0Ii7okipCnSGT22t3qLFES9d+nbijzVaX0newMXDU9Wvj2kVr71xNn7GcY
         VlX7ptSWhKpXWsTZKTTL5kaUdJxvL6wI6v/Sa81xPchmcli0HAwg37Nvg+ETd0+xDUzg
         FudQjT6BLKB4buvp3amNarEdA3xTmpyH2vJlBePZSKByrhnerNpHpM+9psz+H7w03zhb
         dxJg==
X-Gm-Message-State: AOAM53024Ebw02L5xgEavPxo8qochZOW2piYoTiPIB5r//eUnQm1rks6
        0DRnZMc48H398eGonpIqda26KVjk
X-Google-Smtp-Source: ABdhPJwd3jT+OKhqhdOfVdNpK9Z7xrJWWdTdHG84V4DT2J8KL69/x4jFf0R82C8J/eih2m/OASvXkA==
X-Received: by 2002:a17:902:6ac9:: with SMTP id i9mr5194066plt.128.1597343933267;
        Thu, 13 Aug 2020 11:38:53 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l67sm5918113pga.41.2020.08.13.11.38.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Aug 2020 11:38:52 -0700 (PDT)
Date:   Thu, 13 Aug 2020 11:38:51 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tony Lindgren <tony@atomide.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        John Ogness <john.ogness@linutronix.de>, kurt@linutronix.de,
        Raul Rangel <rrangel@google.com>,
        "S, Shirish" <Shirish.S@amd.com>
Subject: Re: Recursive/circular locking in
 serial8250_console_write/serial8250_do_startup
Message-ID: <20200813183851.GA124169@roeck-us.net>
References: <20200812154813.GA46894@roeck-us.net>
 <20200813050629.GA95559@roeck-us.net>
 <20200813115948.GA3854926@kroah.com>
 <20200813142022.GY1891694@smile.fi.intel.com>
 <c9421d8a-7a2b-23ce-61f5-41f2136cf228@roeck-us.net>
 <e78b85b6-3134-290e-88e2-f1d6e88f0db0@roeck-us.net>
 <20200813180013.GZ1891694@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200813180013.GZ1891694@smile.fi.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Aug 13, 2020 at 09:00:13PM +0300, Andy Shevchenko wrote:
> On Thu, Aug 13, 2020 at 10:03:44AM -0700, Guenter Roeck wrote:
> > On 8/13/20 8:33 AM, Guenter Roeck wrote:
> > > On 8/13/20 7:20 AM, Andy Shevchenko wrote:
> > >> On Thu, Aug 13, 2020 at 01:59:48PM +0200, Greg KH wrote:
> > >>> On Wed, Aug 12, 2020 at 10:06:29PM -0700, Guenter Roeck wrote:
> > >>>> On Wed, Aug 12, 2020 at 08:48:13AM -0700, Guenter Roeck wrote:
> > >>>>> Hi,
> > >>>>>
> > >>>>> crbug.com/1114800 reports a hard lockup due to circular locking in the
> > >>>>> 8250 console driver. This is seen if CONFIG_PROVE_LOCKING is enabled.
> > >>>>>
> > >>>>> Problem is as follows:
> > >>>>> - serial8250_do_startup() locks the serial (console) port.
> > >>>>> - serial8250_do_startup() then disables interrupts if interrupts are
> > >>>>>   shared, by calling disable_irq_nosync().
> > >>>>> - disable_irq_nosync() calls __irq_get_desc_lock() to lock the interrupt
> > >>>>>   descriptor.
> > >>>>> - __irq_get_desc_lock() calls lock_acquire()
> > >>>>> - If CONFIG_PROVE_LOCKING is enabled, validate_chain() and check_noncircular()
> > >>>>>   are called and identify a potential locking error.
> > >>>>> - This locking error is reported via printk, which ultimately calls
> > >>>>>   serial8250_console_write().
> > >>>>> - serial8250_console_write() tries to lock the serial console port.
> > >>>>>   Since it is already locked, the system hangs and ultimately reports
> > >>>>>   a hard lockup.
> > >>>>>
> > >>>>> I understand we'll need to figure out and fix what lockdep complains about,
> > >>>>> and I am working on that. However, even if that is fixed, we'll need a
> > >>>>> solution for the recursive lock: Fixing the lockdep problem doesn't
> > >>>>> guarantee that a similar problem (or some other log message) won't be
> > >>>>> detected and reported sometime in the future while serial8250_do_startup()
> > >>>>> holds the console port lock.
> > >>>>>
> > >>>>> Ideas, anyone ? Everything I came up with so far seems clumsy and hackish.
> > >>>>>
> > >>>>
> > >>>> Turns out the situation is a bit worse than I thought. disable_irq_nosync(),
> > >>>> when called from serial8250_do_startup(), locks the interrupt descriptor.
> > >>>> The order of locking is
> > >>>> 	serial port lock
> > >>>> 	  interrupt descriptor lock
> > >>>>
> > >>>> At the same time, __setup_irq() locks the interrupt descriptor as well.
> > >>>> With the descriptor locked, it may report an error message using pr_err().
> > >>>> This in turn may call serial8250_console_write(), which will try to lock
> > >>>> the console serial port. The lock sequence is
> > >>>> 	interrupt descriptor lock
> > >>>> 	  serial port lock
> > >>>>
> > >>>> I added the lockdep splat to the bug log at crbug.com/1114800.
> > >>>>
> > >>>> Effectively, I think, this means we can't call disable_irq_nosync()
> > >>>> while holding a serial port lock, or at least not while holding a
> > >>>> serial port lock that is associated with a console.
> > >>>>
> > >>>> The problem was introduced (or, rather, exposed) with upstream commit
> > >>>> 7febbcbc48fc ("serial: 8250: Check UPF_IRQ_SHARED in advance").
> > >>>
> > >>> Adding Andy, who wrote the above commit :)
> > >>>
> > >>> Andy, any thoughts?
> > >>
> > >> So, we have here a problem and my commit is indeed revealed it since it's
> > >> basically did spread of what we used to have only in two drivers (and
> > >> originally reported problem was against third one, i.e. 8250_pnp) to all 8250.
> > >> Even if we revert that commit, we got the other problem appear, hence it's a
> > >> matter who to suffer until the clean solution will be provided.
> > >>
> > >> As per earlier discussion [1] (and I Cc'ed this to people from there) it
> > >> appears there is another issue with RT kernels which brought initially that
> > >> controversial disable_irq_nosync() call. Same here, if we drop this call
> > >> somebody will be unsatisfied.
> > >>
> > > 
> > > The lock chain in [1] is
> > > 	console_owner --> &port_lock_key --> &irq_desc_lock_class
> > > and in my case ([2], comment 13) it is
> > > 	&irq_desc_lock_class --> console_owner --> &port_lock_key
> > > 
> > > Looks like we just changed the order of locks.
> > > 
> > >> The real fix possible to go to completely lockless printk(), but on the other
> > >> hand it probably won't prevent other locking corner cases (dead lock?) in 8250
> > >> console write callback.
> > >> spin_lock_irqsave
> > >> The fix proposed in [2] perhaps not the way to go either...
> > >>
> > > 
> > > The code in [2] (Comment 10) was just a hack to prevent the hard lockup
> > > from happening and to be able see the lockdep splat. It wasn't supposed
> > > to fix anything (and it doesn't).
> > > 
> > > Can we change the order of spin_lock_irqsave / disable_irq_nosync ?
> > > 
> > > -               spin_lock_irqsave(&port->lock, flags);
> > >                 if (up->port.irqflags & IRQF_SHARED)
> > >                         disable_irq_nosync(port->irq);
> > > +               spin_lock_irqsave(&port->lock, flags);
> > > 
> > > [ plus of course the same for unlock ]
> > > 
> > 
> > I tried the above, and it solves the problem for me. It is less than perfect
> > (interrupts will be disabled for more time if the code has to wait for the
> > spinlock), but I _think_ it should work.
> > 
> > Should I submit a patch ? Or is there a major flaw in my thinking ?
> 
> That's basically what Sergey (IIRC) proposed in [1].
> (You missed enable_irq() part in above)

You are correct; I had missed that. Anyway, I was just lazy:

"[ plus of course the same for unlock ]"

See [3] for the real thing.

> 
> I guess we may try it. Sergey, can you submit a formal patch?
> 
Please Cc: me on it.

Thanks,
Guenter

> > >> The idea about not allowing disabling IRQ for console port may be least
> > >> painful as a (temporary?) mitigation.
> > >>
> > >> [1]: https://lore.kernel.org/lkml/CAHQZ30BnfX+gxjPm1DUd5psOTqbyDh4EJE=2=VAMW_VDafctkA@mail.gmail.com/T/#u
> > >> [2]: https://bugs.chromium.org/p/chromium/issues/detail?id=1114800
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
[3] https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/2354478
