Return-Path: <SRS0=ea2O=BO=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53511C433E0
	for <linux-serial@archiver.kernel.org>; Tue,  4 Aug 2020 15:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35B0A206D8
	for <linux-serial@archiver.kernel.org>; Tue,  4 Aug 2020 15:45:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728244AbgHDPpV (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 4 Aug 2020 11:45:21 -0400
Received: from hera.aquilenet.fr ([185.233.100.1]:50430 "EHLO
        hera.aquilenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbgHDPpT (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 4 Aug 2020 11:45:19 -0400
X-Greylist: delayed 573 seconds by postgrey-1.27 at vger.kernel.org; Tue, 04 Aug 2020 11:45:19 EDT
Received: from localhost (localhost [127.0.0.1])
        by hera.aquilenet.fr (Postfix) with ESMTP id 7450B1689;
        Tue,  4 Aug 2020 17:35:44 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
        by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id NNp9mwS61FzL; Tue,  4 Aug 2020 17:35:43 +0200 (CEST)
Received: from function (lfbn-bor-1-797-11.w86-234.abo.wanadoo.fr [86.234.239.11])
        by hera.aquilenet.fr (Postfix) with ESMTPSA id A37C4154E;
        Tue,  4 Aug 2020 17:35:43 +0200 (CEST)
Received: from samy by function with local (Exim 4.94)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1k2yyc-00278t-Dr; Tue, 04 Aug 2020 17:35:42 +0200
Date:   Tue, 4 Aug 2020 17:35:42 +0200
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     Greg KH <gregkh@linuxfoundation.org>,
        linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        speakup@linux-speakup.org
Subject: Re: [PATCH 2/2] speakup: only build serialio when ISA is enabled
Message-ID: <20200804153542.zowupa4ygdgxnciu@function>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, speakup@linux-speakup.org
References: <20200804111332.dex7jobmabifdzw5@function>
 <20200804113413.GA181242@kroah.com>
 <20200804114951.ijs3hnezi4f64nll@function>
 <20200804115817.GC203147@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200804115817.GC203147@kroah.com>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Greg KH, le mar. 04 août 2020 13:58:17 +0200, a ecrit:
> 	ERROR: modpost: "spk_serial_io_ops" [drivers/accessibility/speakup/speakup_keypc.ko] undefined!
> 	ERROR: modpost: "spk_stop_serial_interrupt" [drivers/accessibility/speakup/speakup_keypc.ko] undefined!

Oh, indeed, these are not covered by the first patch.

I realize that KEYPC depends on ISA, but with COMPILE_TEST as
alternative. We can build serialio in the COMPILE_TEST case too, I'll
update the patches.

But then we'll still have:

> the riscv build issues.

Actually I was surprised by the riscv build issue: the issue is within
riscv's inb() implementation, serialio.c is only calling it.
arch/riscv/include/asm/io.h says:

#define PCI_IOBASE		((void __iomem *)PCI_IO_START)
[...]
#define inb(c)		({ u8  __v; __io_pbr(); __v = readb_cpu((void*)(PCI_IOBASE + (c))); __io_par(__v); __v; })

and thus yes it's arithmetic over a (void*) pointer, the caller cannot
do anything about it.

8250_port.c itself uses inb(), doesn't it get a warning as well? Or is
it getting compiled-out on riscv because of some Kconfig condition?  I
see that the whole drivers/tty/serial is under HAS_IOMEM, and that's the
only condition I can see for 8250_port.c (except SERIAL_8250 of course),
is that it, or is SERIAL_8250 just not enabled in the riscv bot?

Actually the warning seems new, when looking at the Debian build log:

https://buildd.debian.org/status/fetch.php?pkg=linux&arch=riscv64&ver=5.7.10-1&stamp=1595803499&raw=0

and looking for serialio.c, I do not see a warning, and its code hasn't
changed. Is the build bot compiler just more talkative?

Samuel
