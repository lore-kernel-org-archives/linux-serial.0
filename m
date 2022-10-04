Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8894C433F5
	for <linux-serial@archiver.kernel.org>; Tue,  4 Oct 2022 20:44:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbiJDUos (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 4 Oct 2022 16:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiJDUor (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 4 Oct 2022 16:44:47 -0400
X-Greylist: delayed 302 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 04 Oct 2022 13:44:45 PDT
Received: from ciao.gmane.io (ciao.gmane.io [116.202.254.214])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE8FAB1FE
        for <linux-serial@vger.kernel.org>; Tue,  4 Oct 2022 13:44:45 -0700 (PDT)
Received: from list by ciao.gmane.io with local (Exim 4.92)
        (envelope-from <lnx-linux-serial-6@m.gmane-mx.org>)
        id 1ofohZ-0005Im-HQ
        for linux-serial@vger.kernel.org; Tue, 04 Oct 2022 22:39:41 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:     linux-serial@vger.kernel.org
From:   Grant Edwards <grant.b.edwards@gmail.com>
Subject: Re: kernel 5.19.8: "Oxford Semiconductor Ltd OXPCIe952 Dual Native
 950 UART" gets wrong baudrate (PCI ID 1415:c158)
Date:   Tue, 4 Oct 2022 20:39:35 -0000 (UTC)
Message-ID: <thi5m6$j7r$1@ciao.gmane.io>
References: <ef8fd762-88cf-548a-0599-17d939ad3a57@control.lth.se>
 <YyA9maUOlPIExIUd@kroah.com>
 <ff41c70a-767a-45b8-f993-1f70ad3d9254@control.lth.se>
User-Agent: slrn/1.0.3 (Linux)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 2022-09-13, Anders Blomdell <anders.blomdell@control.lth.se> wrote:
> I get incorrect baudrates, my oscilloscope gives:
>
> Programmed	Measured
>
>    2400		  5208
>    4800		 13150
>    9600		 10410
>   19200		 71420
>   38400		142000
>   57600		201600
> 115200		138800

I just ran into what I think is the same problem when upgrading from
5.10.76 to 5.15.68 (sorry I don't have any intermediate kernel
versions to test with). This is an oxford quad 950 board that has
worked flawlessly for many years. Now the baud rates are all wrong.

$ lspci | grep OX
03:00.0 Serial controller: Oxford Semiconductor Ltd OXPCIe954 Quad Native 950 UART

$ dmesg | grep ttyS
[    0.265026] 0000:03:00.0: ttyS0 at MMIO 0xf7801000 (irq = 19, base_baud = 15625000) is a 16550A
[    0.265130] 0000:03:00.0: ttyS1 at MMIO 0xf7801200 (irq = 19, base_baud = 15625000) is a 16550A
[    0.265231] 0000:03:00.0: ttyS2 at MMIO 0xf7801400 (irq = 19, base_baud = 15625000) is a 16550A
[    0.265358] 0000:03:00.0: ttyS3 at MMIO 0xf7801600 (irq = 19, base_baud = 15625000) is a 16550A

The only change I could see in dmesg/setserial output is that the
baud base changed from 4000000 to 15625000. However, changing the baud
base back to 4000000 does not make the ports work again

With the default baud base of 15625000, baud rates look like this:

Programmed  Measured
    2400       5398
    4800      13812
    9600      10796 
   19200      74418
   
The curious thing is that the buad rate errors are non-linear, so you
can't just adjust the base baud value to get correct baud rates. The
algorithm used to calculate the baud divisors seems to be broken.

I've read through the rest of this thread a couple times, but was
unable to figure out what to do to fix this problem or if it got fixed
in more recent kernel versions.

Did this problem get fixed in more recent kernels?

Is there something I can do with a 6.15 kernel to get it this board to
work again?

--
Grant

