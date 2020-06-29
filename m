Return-Path: <SRS0=FCDA=AK=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E33C433DF
	for <linux-serial@archiver.kernel.org>; Mon, 29 Jun 2020 20:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C2F820672
	for <linux-serial@archiver.kernel.org>; Mon, 29 Jun 2020 20:40:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rS5h5EDV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729847AbgF2UkW (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731704AbgF2TOL (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 29 Jun 2020 15:14:11 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1226CC006895
        for <linux-serial@vger.kernel.org>; Mon, 29 Jun 2020 04:45:05 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id q5so16206560wru.6
        for <linux-serial@vger.kernel.org>; Mon, 29 Jun 2020 04:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XGw/iLKNRAiVkZjoBpYpVGlTMGowb6J/RzcIqE9oUnc=;
        b=rS5h5EDVXcM6nddGacPz/Nj3KgrOPH0q0nYOztg+J1s+b0tDo9soLUxF+5ac5OLI08
         4pj4d8PGVhb2QpuWHGjPLdHrKX0AJKO5kd4h+mlDscVYvZ+wmgjgPcaGK+I6f94mzM4l
         fb7mw0e8YVatfs/UV5KEfnEtOEVMtAaikz8UK4gdg/86d82CkVVrazsC2z8uZG7CUXUZ
         niM55Y4S1aOeUjTWaFRV7epBvRNNInwxRoJNp/+oJDa1DqvxWLK+V7ia1o54br2dUWjk
         r2bBnqELUcWJVWzHCzsw9/yfgbDJJaiY6No8zpA3wSx7ZRHXQyrZbqiOr9LQIvxuxb/V
         Q9Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XGw/iLKNRAiVkZjoBpYpVGlTMGowb6J/RzcIqE9oUnc=;
        b=HnEUNG2WX3otqblfVT+ui5U2wkl1B99SmKCeXK6p+cTvnbVYL8YHpz3VJC52vQ+gMM
         BTwVmHIXQPRx7oz1pVleuI1rx+shZgepZt/SYvnfK9fiNGvt8eI/cP3FNHzrWiCXxi+D
         AenoiNv3QR5lwaiO0P4lX+a0FaY2MvxZrVAFt5orCNoAP+u2Uvt0TSP9ssfLyaODEPuf
         XwtTCYkR8JuKBwDkAP9dASu0Whczlit36addpzNY2n/qmoEI0a963at7nCRJpyl0fFNl
         DOU9C1rI0RDlYfHLr8YtPtWz8hTG6qfj1/mULGzR7aW6Cl2uzl7F7QnCdYKC5V9deY/h
         rSkg==
X-Gm-Message-State: AOAM5300fo9KxXBh0LXM0zTiftyVBQPkZQX80WtN+isUd12DZECoL8+t
        hBGQatI2m52TaxrR/+EKo8oS4Q==
X-Google-Smtp-Source: ABdhPJxOJjSafM1OFUfqJURXwD3lrGdaznzf+9LM4EAUq/q+VGG6z+FfLqPpw2iGsX1ac9JHkVsJXw==
X-Received: by 2002:adf:c142:: with SMTP id w2mr15839442wre.337.1593431103458;
        Mon, 29 Jun 2020 04:45:03 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id s10sm17859915wme.31.2020.06.29.04.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 04:45:02 -0700 (PDT)
Date:   Mon, 29 Jun 2020 12:45:01 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Jiri Slaby <jslaby@suse.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/7] kgdb: Add request_nmi() to the io ops table for
 kgdboc
Message-ID: <20200629114501.7aq547dzo6o2abrt@holly.lan>
References: <1592835984-28613-1-git-send-email-sumit.garg@linaro.org>
 <1592835984-28613-4-git-send-email-sumit.garg@linaro.org>
 <20200622160300.avgfhnfkpqzqqtsr@holly.lan>
 <CAFA6WYOmQT-OQvjpy1pVPq2mx5S264bJPd-XfwnDY2BjeoWekg@mail.gmail.com>
 <20200623105934.wvyidi3xgqgd35af@holly.lan>
 <CAD=FV=XHZT9ud0Ze1pDvz-kQy7FMFzd9T6+jM5URt1k5BwQ15g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=XHZT9ud0Ze1pDvz-kQy7FMFzd9T6+jM5URt1k5BwQ15g@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Jun 26, 2020 at 12:44:15PM -0700, Doug Anderson wrote:
> Hi,
> 
> On Tue, Jun 23, 2020 at 3:59 AM Daniel Thompson
> <daniel.thompson@linaro.org> wrote:
> >
> > On Tue, Jun 23, 2020 at 02:07:47PM +0530, Sumit Garg wrote:
> > > On Mon, 22 Jun 2020 at 21:33, Daniel Thompson
> > > <daniel.thompson@linaro.org> wrote:
> > > > > +     irq_set_status_flags(irq, IRQ_NOAUTOEN);
> > > > > +     res = request_nmi(irq, fn, IRQF_PERCPU, "kgdboc", dev_id);
> > > >
> > > > Why do we need IRQF_PERCPU here. A UART interrupt is not normally
> > > > per-cpu?
> > > >
> > >
> > > Have a look at this comment [1] and corresponding check in
> > > request_nmi(). So essentially yes UART interrupt is not normally
> > > per-cpu but in order to make it an NMI, we need to request it in
> > > per-cpu mode.
> > >
> > > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/irq/manage.c#n2112
> >
> > Thanks! This is clear.
> >
> > > > > +     if (res) {
> > > > > +             res = request_irq(irq, fn, IRQF_SHARED, "kgdboc", dev_id);
> > > >
> > > > IRQF_SHARED?
> > > >
> > > > Currrently there is nothing that prevents concurrent activation of
> > > > ttyNMI0 and the underlying serial driver. Using IRQF_SHARED means it
> > > > becomes possible for both drivers to try to service the same interrupt.
> > > > That risks some rather "interesting" problems.
> > > >
> > >
> > > Could you elaborate more on "interesting" problems?
> >
> > Er... one of the serial drivers we have allowed the userspace to open
> > will, at best, be stone dead and not passing any characters.
> >
> >
> > > BTW, I noticed one more problem with this patch that is IRQF_SHARED
> > > doesn't go well with IRQ_NOAUTOEN status flag. Earlier I tested it
> > > with auto enable set.
> > >
> > > But if we agree that both shouldn't be active at the same time due to
> > > some real problems(?) then I can rid of IRQF_SHARED as well. Also, I
> > > think we should unregister underlying tty driver (eg. /dev/ttyAMA0) as
> > > well as otherwise it would provide a broken interface to user-space.
> >
> > I don't have a particular strong opinion on whether IRQF_SHARED is
> > correct or not correct since I think that misses the point.
> >
> > Firstly, using IRQF_SHARED shows us that there is no interlocking
> > between kgdb_nmi and the underlying serial driver. That probably tells
> > us about the importance of the interlock than about IRQF_SHARED.
> >
> > To some extent I'm also unsure that kgdb_nmi could ever actually know
> > the correct flags to use in all cases (that was another reason for the
> > TODO comment about poll_get_irq() being a bogus API).
> 
> I do wonder a little bit if the architecture of the "kgdb_nmi_console"
> should change.  I remember looking at it in the past and thinking it a
> little weird that if I wanted to get it to work I'd need to change my
> "console=" command line to go through this new driver and (I guess)
> change the agetty I have running on my serial port to point to
> ttyNMI0.  Is that how it's supposed to work?  Then if I want to do a
> build without kgdb then I need to go in and change my agetty to point
> back at my normal serial port?
> 
> It kinda feels like a better way to much of what the driver does would be to:
> 
> 1. Allow kgdb to sniff incoming serial bytes on a port and look for
> its characters.  We already have this feature in the kernel to a small
> extent for sniffing a break / sysrq character.
> 
> 2. If userspace doesn't happen to have the serial port open then
> ideally we could open the port (using all the standard APIs that
> already exist) from in the kernel and just throw away all the bytes
> (since we already sniffed them).  As soon as userspace tried to open
> the port when it would get ownership and if userspace ever closed the
> port then we'd start reading / throwing away bytes again.
> 
> If we had a solution like that:
> 
> a) No serial drivers would need to change.
> 
> b) No kernel command line parameters would need to change.
> 
> Obviously that solution wouldn't magically get you an NMI, though.
> For that I'd presume the right answer would be to add a parameter for
> each serial driver that can support it to run its rx interrupt in NMI
> mode.

... or allow modal changes to the uart driver when kgdboc comes up?

We already allow UART drivers to de-optimize themselves and use
different code paths when polling is enabled so its not totally crazy
;-).


> Of course, perhaps I'm just confused and crazy and the above is a
> really bad idea.

Thanks for bringing this up.

Sumit and I were chatting last week and our discussion went in a similar
direction (I think not exactly the same which is why it is good to
see your thoughts too).

Personally I think it comes down to how intrusive adding NMI support is
to serial drivers. kgdb_nmi is rather hacky and feels a bit odd to
enable. It is clearly intended to avoid almost all changes to the UART
driver. On our side we have been wondering whether the serial core can
add helpers to make it easy for a serial driver to implement an simple,
safe but not optimal NMI implementation. Making it easy to have
safety-first might make NMI more palatable.


> Speaking of confused: is there actually any way to use the existing
> kgdb NMI driver (CONFIG_SERIAL_KGDB_NMI) in mainline without out of
> tree patches?  When I looked before I assumed it was just me that was
> outta luck because I didn't have NMI at the time, but I just did some
> grepping and I can't find anyplace in mainline where
> "arch_kgdb_ops.enable_nmi" would not be NULL.  Did I miss it, or do we
> need out-of-tree patches to enable this?

Out-of-tree...

If, after looking at other approaches, we do all agree to nuke kgdb_nmi
then there shouldn't be much impediment (nor that many tears).


Daniel.
