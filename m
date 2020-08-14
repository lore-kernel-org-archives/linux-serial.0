Return-Path: <SRS0=xWBg=BY=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A7C3C433DF
	for <linux-serial@archiver.kernel.org>; Fri, 14 Aug 2020 14:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E87C207DA
	for <linux-serial@archiver.kernel.org>; Fri, 14 Aug 2020 14:34:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fOhW/yhl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728801AbgHNOeR (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 14 Aug 2020 10:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbgHNOeP (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 14 Aug 2020 10:34:15 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E23EC061384;
        Fri, 14 Aug 2020 07:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YYYrjEgMAA4u8RoHDSiUNVuFlpaGFObMWit7kqQR9vU=; b=fOhW/yhl8mj63z46HaCxzt/X5J
        XNcVszm1/6jzcRI4Dhj9LUdZHuvb0F+XA2jTy+xBujD5/Nh1TgIz6YWlOsIlxLnJ3fJSAC356go8F
        cMKV9QxC7Q/z7/mwZjCU11Dg/P4PvZqxnYrHHtMP6/4EUNA0RnAAIx3qdSsscPP6C2LeXkHTayD0R
        bmITOvcic+ZbcOMCEUfGWQrhWsuAWrbFySHWUA0EHRy/ScEbQnPG4QId4HvJnhGBdlCGKQHdE9wmI
        /tfPaJEK/mUWwSXPyudzMHgV0qBNTOFnFLugzmiJdSn0og5NQ3rsUupcnSGKsQtcYbm2D2NnXR7tH
        PJ2+EN7A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k6amT-0008I7-PU; Fri, 14 Aug 2020 14:34:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3DDBC300238;
        Fri, 14 Aug 2020 16:34:00 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2258C2C36C972; Fri, 14 Aug 2020 16:34:00 +0200 (CEST)
Date:   Fri, 14 Aug 2020 16:34:00 +0200
From:   peterz@infradead.org
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Doug Anderson <dianders@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        linux-serial@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net,
        Jiri Slaby <jslaby@suse.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Jason Wessel <jason.wessel@windriver.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [RFC 1/5] tty/sysrq: Make sysrq handler NMI aware
Message-ID: <20200814143400.GB165568@hirez.programming.kicks-ass.net>
References: <1595333413-30052-1-git-send-email-sumit.garg@linaro.org>
 <1595333413-30052-2-git-send-email-sumit.garg@linaro.org>
 <CAD=FV=Uqi28A=sm5+JhAqBM2OtBM3_XwvvkaKyEDVL9uVEioog@mail.gmail.com>
 <CAFA6WYMy_+RdsPJekm7zmCrFUXHqjsfr3JvyD7L8A2X8+jB8Qw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFA6WYMy_+RdsPJekm7zmCrFUXHqjsfr3JvyD7L8A2X8+jB8Qw@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Aug 14, 2020 at 12:54:35PM +0530, Sumit Garg wrote:
> On Thu, 13 Aug 2020 at 05:30, Doug Anderson <dianders@chromium.org> wrote:
> > On Tue, Jul 21, 2020 at 5:10 AM Sumit Garg <sumit.garg@linaro.org> wrote:
> > Wishful thinking, but (as far as I can tell) irq_work_queue() only
> > queues work on the CPU running the NMI.  I don't have lots of NMI
> > experience, but any chance there is a variant that will queue work on
> > any CPU?  Then sysrq handlers that aren't NMI aware will be more
> > likely to work.
> >
> 
> Unfortunately, queuing work on other CPUs isn't safe in NMI context,
> see this warning [1]. The comment mentions:
> 
> /* Arch remote IPI send/receive backend aren't NMI safe */
> 
> Peter,
> 
> Can you throw some light here as to why it isn't considered NMI-safe
> to send remote IPI in NMI context? Is it an arch specific limitation?

Yeah, remote irq_work uses __smp_call_single_queue() /
send_call_function_single_ipi() which isn't safe to be used from NMI
context in general.

arch_irq_work_raise() is very carefully implemented on a number of
platforms to be able to (self) IPI from NMI context.

