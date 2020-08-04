Return-Path: <SRS0=ea2O=BO=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8167C433DF
	for <linux-serial@archiver.kernel.org>; Tue,  4 Aug 2020 15:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAA9321744
	for <linux-serial@archiver.kernel.org>; Tue,  4 Aug 2020 15:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596556191;
	bh=QsTMC6SLev6ciXKGAQQLQoUY0jFy36C74ksPMkq7COk=;
	h=Date:From:To:Subject:References:In-Reply-To:List-ID:From;
	b=SV64YA+eEF5B0yTa8XCrEv8VQPfx29pVo4ASFr0rJNdQy4Qk67bcWkjR2nc90HRXK
	 b1B57G3ofDATrOFqMpHJecn+fjv6sFLHMllppqmS/lvgxwcEpWEAbiOU81+RyLb0mJ
	 kgPzOP//8W66e+WAYKw7czgkn2xq0oWd8ctZUcJQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbgHDPto (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 4 Aug 2020 11:49:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:55082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728880AbgHDPtl (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 4 Aug 2020 11:49:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2AF6421744;
        Tue,  4 Aug 2020 15:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596556172;
        bh=QsTMC6SLev6ciXKGAQQLQoUY0jFy36C74ksPMkq7COk=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=HLYhnrNCP+LU+0Z7YJBOjhOf5u6gP45nqyYoZxh0fUnqECOE0ZJsJkDhZ1DOIeuJh
         3Z0jfjTITF80mzZqnG19XomRa0Su0varVijd0J0vHIROLImnW1BGwaiL76s44i08/P
         B0CA+7vHMdl176RsN13IxUxd1v0Y087cocISFRG0=
Date:   Tue, 4 Aug 2020 17:49:52 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Samuel Thibault <samuel.thibault@ens-lyon.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, speakup@linux-speakup.org
Subject: Re: [PATCH 2/2] speakup: only build serialio when ISA is enabled
Message-ID: <20200804154952.GB495852@kroah.com>
References: <20200804111332.dex7jobmabifdzw5@function>
 <20200804113413.GA181242@kroah.com>
 <20200804114951.ijs3hnezi4f64nll@function>
 <20200804115817.GC203147@kroah.com>
 <20200804153542.zowupa4ygdgxnciu@function>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200804153542.zowupa4ygdgxnciu@function>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Aug 04, 2020 at 05:35:42PM +0200, Samuel Thibault wrote:
> Greg KH, le mar. 04 août 2020 13:58:17 +0200, a ecrit:
> > 	ERROR: modpost: "spk_serial_io_ops" [drivers/accessibility/speakup/speakup_keypc.ko] undefined!
> > 	ERROR: modpost: "spk_stop_serial_interrupt" [drivers/accessibility/speakup/speakup_keypc.ko] undefined!
> 
> Oh, indeed, these are not covered by the first patch.
> 
> I realize that KEYPC depends on ISA, but with COMPILE_TEST as
> alternative. We can build serialio in the COMPILE_TEST case too, I'll
> update the patches.
> 
> But then we'll still have:
> 
> > the riscv build issues.
> 
> Actually I was surprised by the riscv build issue: the issue is within
> riscv's inb() implementation, serialio.c is only calling it.
> arch/riscv/include/asm/io.h says:
> 
> #define PCI_IOBASE		((void __iomem *)PCI_IO_START)
> [...]
> #define inb(c)		({ u8  __v; __io_pbr(); __v = readb_cpu((void*)(PCI_IOBASE + (c))); __io_par(__v); __v; })
> 
> and thus yes it's arithmetic over a (void*) pointer, the caller cannot
> do anything about it.

And that's fine, math with pointers, even void ones, is ok.

I wonder why riscv was complaining about that.  It's not nice, but it is
valid C.

> 8250_port.c itself uses inb(), doesn't it get a warning as well? Or is
> it getting compiled-out on riscv because of some Kconfig condition?

Probably this.

> I
> see that the whole drivers/tty/serial is under HAS_IOMEM, and that's the
> only condition I can see for 8250_port.c (except SERIAL_8250 of course),
> is that it, or is SERIAL_8250 just not enabled in the riscv bot?
> 
> Actually the warning seems new, when looking at the Debian build log:
> 
> https://buildd.debian.org/status/fetch.php?pkg=linux&arch=riscv64&ver=5.7.10-1&stamp=1595803499&raw=0
> 
> and looking for serialio.c, I do not see a warning, and its code hasn't
> changed. Is the build bot compiler just more talkative?

It's more talkative at times, and maybe the riscv code changed too.

Let's see if any of their developers care about it :)

thanks,

greg k-h
