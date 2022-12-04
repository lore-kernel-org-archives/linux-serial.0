Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D30E3C4321E
	for <linux-serial@archiver.kernel.org>; Sun,  4 Dec 2022 18:11:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbiLDSL3 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 4 Dec 2022 13:11:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbiLDSL1 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 4 Dec 2022 13:11:27 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5610E11149
        for <linux-serial@vger.kernel.org>; Sun,  4 Dec 2022 10:11:23 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id b16so3117436yba.0
        for <linux-serial@vger.kernel.org>; Sun, 04 Dec 2022 10:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P9tOmcNBAIJX3PWoxRpY/FEoUe+pWpuWDYmU2C20A4k=;
        b=FcO9qXXxQ5oOjlWEjVfALpugPnz3EqI4WStOzZjlad8NgAhPMYJmvk2uKaZRFAGmFC
         VlP9INs+HQzU+fvwJJVUdkvqEvdUnmsx0K3V3W3r34E7XdwKFJ3hZ8FPUzCPu1Adh+pQ
         vgQeU2dGo6w+GSkF92WSRLrvNZSqs1RJ8yN1YD0insnEACNzvsJZJ8JZFJFWSDQ21ILj
         uMz/r2by0CtSdeiLylm8tdWIa4GyP3QYpyDzkMTgdyUxHMsRWOcxST/Og/smvJR4FBVQ
         784LuQ5HQpX21hBUGG25tvgqcPohVGcCFfov+awHLHWcuoGtP48WjyD3Z+S5/RrdHGDz
         53UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P9tOmcNBAIJX3PWoxRpY/FEoUe+pWpuWDYmU2C20A4k=;
        b=0FPzTwr3THv5I011ANk1K8xdhyMO0i8OMaomEKKb8O0P2KsWseNtelFrNEM+xPMBIQ
         9spijqQRcXtCMTKxcGNhyWJkizGL7HxvYXEHkMOiSexUzEl5kZjHezYtfUgCUU+LWYpd
         lGqZgGW7O4rGrQvbVXoLq0fc60mBhkGuwg/cLxorq4+Ftxx18Uq7RPOuLWalmlzPkRxx
         aXtNhP8F9z6fVi3ppwv0RaojzdqwqCff4uTluSe3XLrvbibCL7NpOVaG71lcloxQ4eBR
         0fHcC6yv6gty8x1vaeuornZvq7nXL85cS29fDCJ2sKfDAPhmP2I8h9cZhL3SuBBgYFui
         o2Tw==
X-Gm-Message-State: ANoB5pni/+i1KKdQAhb5hVtZsvUHPIy4BDunURGYhZtgR14RQcsOjPDI
        ELFr9rFQwgYJ9bfULalBeMceBKpQuki8VLcz4MYv+F3iMbZpHQ==
X-Google-Smtp-Source: AA0mqf7vNyXiMT4+0fRhbouMwXtxmNZGbm3oVToMWF1CoZMjyrlQYY5uuXB0SVBkaKiWnxJ+7aOxfQHP7AKYLhxVrdY=
X-Received: by 2002:a25:30c1:0:b0:6ef:fb99:4af9 with SMTP id
 w184-20020a2530c1000000b006effb994af9mr50116500ybw.108.1670177482580; Sun, 04
 Dec 2022 10:11:22 -0800 (PST)
MIME-Version: 1.0
References: <CAB6k_g0siQ7O3LSBGAMUB0OFFn6MCAurXFohRSZaJyxjfneZ9Q@mail.gmail.com>
 <Y4zQhTKmTXRj+AG0@kroah.com>
In-Reply-To: <Y4zQhTKmTXRj+AG0@kroah.com>
From:   Oleksii Hryhorovych <alexcatze@gmail.com>
Date:   Sun, 4 Dec 2022 20:11:11 +0200
Message-ID: <CAB6k_g2GXwpgUndJQTYKVFjnmbpkLnhLa7vYGOi7AzO-ci-ENQ@mail.gmail.com>
Subject: Re: serial driver issue
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

=D0=B2=D1=81, 4 =D0=B4=D0=B5=D0=BA. 2022 =D0=B3. =D0=B2 18:53, Greg KH <gre=
gkh@linuxfoundation.org>:
>
> On Sun, Dec 04, 2022 at 06:42:19PM +0200, Oleksii Hryhorovych wrote:
> > Hi. I have a problem with linux "serial" driver. I`m using a MosChip
> > 9901 based ExpressCard 34 dual rs-232 controller. When I plugged this
> > card into my PC, the system detected it, but when I tried to send or
> > read something from one of the ports, there was silence. Loopback test
> > also fails. On windows this card works perfectly, so this is not a
> > hardware issue. My kernel version is "5.15.78-1-MANJARO".
>
> How exactly are you trying to send data through the port?  What command
> did you use and what was the result?
>
I tried(each test 4 times, trying each device node for each port):
1) Execute "cat /dev/ttyS6"(or ttyS7), connect rs-232 cable to port on
the card and to another PC, then send from another PC something to
port.
Result: nothing new appeared in console
2) Connect rs232 cable to port on card and to another PC. Run terminal
on another PC, run minicom on this PC. Disable flow control. Send
something to terminal on both PCs.
Result: nothing appeared in terminals on both PCs.
3) Connect pins number 2 and 3 on rs232 port (loopback test). Open
minicom, disable flow control and send something to the terminal.
Result: nothing new appeared in the terminal
4) Connect pins number 2 and 3 on rs232 port (loopback test). Open
first console window, run "cat /dev/ttyS6"(or ttyS7). Open second
window, run "echo "test" > /dev/ttyS6"(or ttyS7).
Result: nothing new appeared in the first console
>
> >
> > "dmesg" output about this card:
> >
> > [64329.311478] pcieport 0000:00:1c.1: pciehp: Slot(1): Card present
> > [64329.311485] pcieport 0000:00:1c.1: pciehp: Slot(1): Link Up
> > [64329.442833] pci 0000:02:00.0: [9710:9901] type 00 class 0x070002
> > [64329.442867] pci 0000:02:00.0: reg 0x10: [io  0x0000-0x0007]
> > [64329.442883] pci 0000:02:00.0: reg 0x14: [mem 0x00000000-0x00000fff]
> > [64329.442922] pci 0000:02:00.0: reg 0x20: [mem 0x00000000-0x00000fff]
> > [64329.443096] pci 0000:02:00.0: supports D1 D2
> > [64329.443099] pci 0000:02:00.0: PME# supported from D0 D1 D2 D3hot D3c=
old
> > [64329.443402] pci 0000:02:00.1: [9710:9901] type 00 class 0x070002
> > [64329.443434] pci 0000:02:00.1: reg 0x10: [io  0x0000-0x0007]
> > [64329.443451] pci 0000:02:00.1: reg 0x14: [mem 0x00000000-0x00000fff]
> > [64329.443495] pci 0000:02:00.1: reg 0x20: [mem 0x00000000-0x00000fff]
> > [64329.443679] pci 0000:02:00.1: supports D1 D2
> > [64329.443683] pci 0000:02:00.1: PME# supported from D0 D1 D2 D3hot D3c=
old
> > [64329.443948] pci 0000:02:00.0: BAR 1: assigned [mem 0xd0000000-0xd000=
0fff]
> > [64329.443960] pci 0000:02:00.0: BAR 4: assigned [mem 0xd0001000-0xd000=
1fff]
> > [64329.443969] pci 0000:02:00.1: BAR 1: assigned [mem 0xd0002000-0xd000=
2fff]
> > [64329.443979] pci 0000:02:00.1: BAR 4: assigned [mem 0xd0003000-0xd000=
3fff]
> > [64329.443987] pci 0000:02:00.0: BAR 0: assigned [io  0x2000-0x2007]
> > [64329.443995] pci 0000:02:00.1: BAR 0: assigned [io  0x2008-0x200f]
> > [64329.444006] pcieport 0000:00:1c.1: PCI bridge to [bus 02-22]
> > [64329.444012] pcieport 0000:00:1c.1:   bridge window [io  0x2000-0x3ff=
f]
> > [64329.444017] pcieport 0000:00:1c.1:   bridge window [mem
> > 0xd0000000-0xd3ffffff]
> > [64329.444023] pcieport 0000:00:1c.1:   bridge window [mem
> > 0xbfb00000-0xbfcfffff 64bit pref]
> > [64329.444110] serial 0000:02:00.0: enabling device (0000 -> 0003)
> > [64329.444690] 0000:02:00.0: ttyS6 at I/O 0x2000 (irq =3D 17, base_baud
> > =3D 115200) is a 16550A
> > [64329.448040] serial 0000:02:00.1: enabling device (0000 -> 0003)
> > [64329.452843] 0000:02:00.1: ttyS7 at I/O 0x2008 (irq =3D 18, base_baud
> > =3D 115200) is a 16550A
>
>
> Which tty device node are you using here?
>
I tried using both nodes, /dev/ttyS6 and /dev/ttyS7, and the result
was the same.
> What does the output of `find /dev/serial/` show?
>
/dev/serial/
/dev/serial/by-id
/dev/serial/by-id/usb-HP_HP_hs2340_HSPA+_MobileBroadband_C69366190FA2EB60-i=
f01
/dev/serial/by-id/usb-HP_HP_hs2340_HSPA+_MobileBroadband_C69366190FA2EB60-i=
f03
/dev/serial/by-id/usb-HP_HP_hs2340_HSPA+_MobileBroadband_C69366190FA2EB60-i=
f09
/dev/serial/by-path
/dev/serial/by-path/pci-0000:00:1a.0-usb-0:1.2:1.9
/dev/serial/by-path/pci-0000:00:1a.0-usb-0:1.2:1.1
/dev/serial/by-path/pci-0000:00:1a.0-usb-0:1.2:1.3

And it doesn't changes when I remove or insert back this card.
> thanks,
>
> greg k-h
