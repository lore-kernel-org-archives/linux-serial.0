Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0435C4321E
	for <linux-serial@archiver.kernel.org>; Sun,  4 Dec 2022 16:53:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbiLDQxd (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 4 Dec 2022 11:53:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbiLDQxc (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 4 Dec 2022 11:53:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED1D7A1B4
        for <linux-serial@vger.kernel.org>; Sun,  4 Dec 2022 08:53:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AB4C9B80ACA
        for <linux-serial@vger.kernel.org>; Sun,  4 Dec 2022 16:53:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 214E1C433C1;
        Sun,  4 Dec 2022 16:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1670172808;
        bh=wM3hfp0kjv4qadCpXysvKqiIjtoCNvnNAhxRRek+Gn4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ou5aKhp9yXCHRp/4tLF42uNZG8hoYYBpAEXDIS2XPUryQCe7rDQDQ36pSSHhL2+S2
         GjzIVlF38IDnfUW6xv8nv45e83Yitnho3wfDTHyJiNWKtsZx3IgZs0jt42MYtaK+bH
         RMJ+B/qjfcNfUQpthTcA7PvHi8vH/Aq7itoFCMYE=
Date:   Sun, 4 Dec 2022 17:53:25 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oleksii Hryhorovych <alexcatze@gmail.com>
Cc:     linux-serial@vger.kernel.org
Subject: Re: serial driver issue
Message-ID: <Y4zQhTKmTXRj+AG0@kroah.com>
References: <CAB6k_g0siQ7O3LSBGAMUB0OFFn6MCAurXFohRSZaJyxjfneZ9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAB6k_g0siQ7O3LSBGAMUB0OFFn6MCAurXFohRSZaJyxjfneZ9Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sun, Dec 04, 2022 at 06:42:19PM +0200, Oleksii Hryhorovych wrote:
> Hi. I have a problem with linux "serial" driver. I`m using a MosChip
> 9901 based ExpressCard 34 dual rs-232 controller. When I plugged this
> card into my PC, the system detected it, but when I tried to send or
> read something from one of the ports, there was silence. Loopback test
> also fails. On windows this card works perfectly, so this is not a
> hardware issue. My kernel version is "5.15.78-1-MANJARO".

How exactly are you trying to send data through the port?  What command
did you use and what was the result?


> 
> "dmesg" output about this card:
> 
> [64329.311478] pcieport 0000:00:1c.1: pciehp: Slot(1): Card present
> [64329.311485] pcieport 0000:00:1c.1: pciehp: Slot(1): Link Up
> [64329.442833] pci 0000:02:00.0: [9710:9901] type 00 class 0x070002
> [64329.442867] pci 0000:02:00.0: reg 0x10: [io  0x0000-0x0007]
> [64329.442883] pci 0000:02:00.0: reg 0x14: [mem 0x00000000-0x00000fff]
> [64329.442922] pci 0000:02:00.0: reg 0x20: [mem 0x00000000-0x00000fff]
> [64329.443096] pci 0000:02:00.0: supports D1 D2
> [64329.443099] pci 0000:02:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> [64329.443402] pci 0000:02:00.1: [9710:9901] type 00 class 0x070002
> [64329.443434] pci 0000:02:00.1: reg 0x10: [io  0x0000-0x0007]
> [64329.443451] pci 0000:02:00.1: reg 0x14: [mem 0x00000000-0x00000fff]
> [64329.443495] pci 0000:02:00.1: reg 0x20: [mem 0x00000000-0x00000fff]
> [64329.443679] pci 0000:02:00.1: supports D1 D2
> [64329.443683] pci 0000:02:00.1: PME# supported from D0 D1 D2 D3hot D3cold
> [64329.443948] pci 0000:02:00.0: BAR 1: assigned [mem 0xd0000000-0xd0000fff]
> [64329.443960] pci 0000:02:00.0: BAR 4: assigned [mem 0xd0001000-0xd0001fff]
> [64329.443969] pci 0000:02:00.1: BAR 1: assigned [mem 0xd0002000-0xd0002fff]
> [64329.443979] pci 0000:02:00.1: BAR 4: assigned [mem 0xd0003000-0xd0003fff]
> [64329.443987] pci 0000:02:00.0: BAR 0: assigned [io  0x2000-0x2007]
> [64329.443995] pci 0000:02:00.1: BAR 0: assigned [io  0x2008-0x200f]
> [64329.444006] pcieport 0000:00:1c.1: PCI bridge to [bus 02-22]
> [64329.444012] pcieport 0000:00:1c.1:   bridge window [io  0x2000-0x3fff]
> [64329.444017] pcieport 0000:00:1c.1:   bridge window [mem
> 0xd0000000-0xd3ffffff]
> [64329.444023] pcieport 0000:00:1c.1:   bridge window [mem
> 0xbfb00000-0xbfcfffff 64bit pref]
> [64329.444110] serial 0000:02:00.0: enabling device (0000 -> 0003)
> [64329.444690] 0000:02:00.0: ttyS6 at I/O 0x2000 (irq = 17, base_baud
> = 115200) is a 16550A
> [64329.448040] serial 0000:02:00.1: enabling device (0000 -> 0003)
> [64329.452843] 0000:02:00.1: ttyS7 at I/O 0x2008 (irq = 18, base_baud
> = 115200) is a 16550A


Which tty device node are you using here?

What does the output of `find /dev/serial/` show?

thanks,

greg k-h
