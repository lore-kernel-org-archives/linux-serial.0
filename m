Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4F3CC47088
	for <linux-serial@archiver.kernel.org>; Mon,  5 Dec 2022 15:20:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232441AbiLEPUj (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 5 Dec 2022 10:20:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232476AbiLEPT0 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 5 Dec 2022 10:19:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A301C15710
        for <linux-serial@vger.kernel.org>; Mon,  5 Dec 2022 07:19:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 31DAB611A1
        for <linux-serial@vger.kernel.org>; Mon,  5 Dec 2022 15:19:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3156BC43470;
        Mon,  5 Dec 2022 15:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1670253563;
        bh=9k0SYsXmX7cliPCK7YBl1oc0n4q1INu5uGIeva0RvvI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rm3oF8GMByBcOCLygSZmLSuDknVEsReNrRg1o2Xvm5A2al4K29UbUWRZ4DkUAmqje
         f2jbDfHn1NqU3+MaLgfEL2upigiq4fCtQCMn0Z9mAzrhxeB6hNCY7/vLczAXqUziHS
         2b+UYrLsOMTVeY9JD2SWV9rWLZM2Yc5Qi5FvwBvA=
Date:   Mon, 5 Dec 2022 16:19:21 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oleksii Hryhorovych <alexcatze@gmail.com>
Cc:     linux-serial@vger.kernel.org
Subject: Re: serial driver issue
Message-ID: <Y44L+TVanDkwAwHq@kroah.com>
References: <CAB6k_g0siQ7O3LSBGAMUB0OFFn6MCAurXFohRSZaJyxjfneZ9Q@mail.gmail.com>
 <Y4zQhTKmTXRj+AG0@kroah.com>
 <CAB6k_g2GXwpgUndJQTYKVFjnmbpkLnhLa7vYGOi7AzO-ci-ENQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAB6k_g2GXwpgUndJQTYKVFjnmbpkLnhLa7vYGOi7AzO-ci-ENQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sun, Dec 04, 2022 at 08:11:11PM +0200, Oleksii Hryhorovych wrote:
> вс, 4 дек. 2022 г. в 18:53, Greg KH <gregkh@linuxfoundation.org>:
> >
> > On Sun, Dec 04, 2022 at 06:42:19PM +0200, Oleksii Hryhorovych wrote:
> > > Hi. I have a problem with linux "serial" driver. I`m using a MosChip
> > > 9901 based ExpressCard 34 dual rs-232 controller. When I plugged this
> > > card into my PC, the system detected it, but when I tried to send or
> > > read something from one of the ports, there was silence. Loopback test
> > > also fails. On windows this card works perfectly, so this is not a
> > > hardware issue. My kernel version is "5.15.78-1-MANJARO".
> >
> > How exactly are you trying to send data through the port?  What command
> > did you use and what was the result?
> >
> I tried(each test 4 times, trying each device node for each port):
> 1) Execute "cat /dev/ttyS6"(or ttyS7), connect rs-232 cable to port on
> the card and to another PC, then send from another PC something to
> port.
> Result: nothing new appeared in console

"cat" isn't the best test, minicom is good, as you tried:

> 2) Connect rs232 cable to port on card and to another PC. Run terminal
> on another PC, run minicom on this PC. Disable flow control. Send
> something to terminal on both PCs.
> Result: nothing appeared in terminals on both PCs.
> 3) Connect pins number 2 and 3 on rs232 port (loopback test). Open
> minicom, disable flow control and send something to the terminal.
> Result: nothing new appeared in the terminal
> 4) Connect pins number 2 and 3 on rs232 port (loopback test). Open
> first console window, run "cat /dev/ttyS6"(or ttyS7). Open second
> window, run "echo "test" > /dev/ttyS6"(or ttyS7).
> Result: nothing new appeared in the first console

I think the problem is that you do not have a driver attached to your
serial ports, because:

> > > "dmesg" output about this card:
> > >
> > > [64329.311478] pcieport 0000:00:1c.1: pciehp: Slot(1): Card present
> > > [64329.311485] pcieport 0000:00:1c.1: pciehp: Slot(1): Link Up
> > > [64329.442833] pci 0000:02:00.0: [9710:9901] type 00 class 0x070002
> > > [64329.442867] pci 0000:02:00.0: reg 0x10: [io  0x0000-0x0007]
> > > [64329.442883] pci 0000:02:00.0: reg 0x14: [mem 0x00000000-0x00000fff]
> > > [64329.442922] pci 0000:02:00.0: reg 0x20: [mem 0x00000000-0x00000fff]
> > > [64329.443096] pci 0000:02:00.0: supports D1 D2
> > > [64329.443099] pci 0000:02:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> > > [64329.443402] pci 0000:02:00.1: [9710:9901] type 00 class 0x070002
> > > [64329.443434] pci 0000:02:00.1: reg 0x10: [io  0x0000-0x0007]
> > > [64329.443451] pci 0000:02:00.1: reg 0x14: [mem 0x00000000-0x00000fff]
> > > [64329.443495] pci 0000:02:00.1: reg 0x20: [mem 0x00000000-0x00000fff]
> > > [64329.443679] pci 0000:02:00.1: supports D1 D2
> > > [64329.443683] pci 0000:02:00.1: PME# supported from D0 D1 D2 D3hot D3cold
> > > [64329.443948] pci 0000:02:00.0: BAR 1: assigned [mem 0xd0000000-0xd0000fff]
> > > [64329.443960] pci 0000:02:00.0: BAR 4: assigned [mem 0xd0001000-0xd0001fff]
> > > [64329.443969] pci 0000:02:00.1: BAR 1: assigned [mem 0xd0002000-0xd0002fff]
> > > [64329.443979] pci 0000:02:00.1: BAR 4: assigned [mem 0xd0003000-0xd0003fff]
> > > [64329.443987] pci 0000:02:00.0: BAR 0: assigned [io  0x2000-0x2007]
> > > [64329.443995] pci 0000:02:00.1: BAR 0: assigned [io  0x2008-0x200f]
> > > [64329.444006] pcieport 0000:00:1c.1: PCI bridge to [bus 02-22]
> > > [64329.444012] pcieport 0000:00:1c.1:   bridge window [io  0x2000-0x3fff]
> > > [64329.444017] pcieport 0000:00:1c.1:   bridge window [mem
> > > 0xd0000000-0xd3ffffff]
> > > [64329.444023] pcieport 0000:00:1c.1:   bridge window [mem
> > > 0xbfb00000-0xbfcfffff 64bit pref]
> > > [64329.444110] serial 0000:02:00.0: enabling device (0000 -> 0003)
> > > [64329.444690] 0000:02:00.0: ttyS6 at I/O 0x2000 (irq = 17, base_baud
> > > = 115200) is a 16550A
> > > [64329.448040] serial 0000:02:00.1: enabling device (0000 -> 0003)
> > > [64329.452843] 0000:02:00.1: ttyS7 at I/O 0x2008 (irq = 18, base_baud
> > > = 115200) is a 16550A

ttyS6 and ttyS7 seem to be the correct devices, but:

> > Which tty device node are you using here?
> >
> I tried using both nodes, /dev/ttyS6 and /dev/ttyS7, and the result
> was the same.
> > What does the output of `find /dev/serial/` show?
> >
> /dev/serial/
> /dev/serial/by-id
> /dev/serial/by-id/usb-HP_HP_hs2340_HSPA+_MobileBroadband_C69366190FA2EB60-if01
> /dev/serial/by-id/usb-HP_HP_hs2340_HSPA+_MobileBroadband_C69366190FA2EB60-if03
> /dev/serial/by-id/usb-HP_HP_hs2340_HSPA+_MobileBroadband_C69366190FA2EB60-if09
> /dev/serial/by-path
> /dev/serial/by-path/pci-0000:00:1a.0-usb-0:1.2:1.9
> /dev/serial/by-path/pci-0000:00:1a.0-usb-0:1.2:1.1
> /dev/serial/by-path/pci-0000:00:1a.0-usb-0:1.2:1.3

You only have usb-serial devices seen in the system.

Are you sure the PCI card is being controlled properly?  No other kernel
log messages?

Is /dev/ttyS6 and ttyS7 present in /dev?

What does 'ls -l /sys/class/tty/' show?

thanks,

greg k-h
