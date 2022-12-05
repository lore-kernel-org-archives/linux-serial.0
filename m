Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1DF0C4321E
	for <linux-serial@archiver.kernel.org>; Mon,  5 Dec 2022 16:59:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbiLEQ7W (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 5 Dec 2022 11:59:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbiLEQ7V (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 5 Dec 2022 11:59:21 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA303D2CA
        for <linux-serial@vger.kernel.org>; Mon,  5 Dec 2022 08:59:18 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id l67so15287383ybl.1
        for <linux-serial@vger.kernel.org>; Mon, 05 Dec 2022 08:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SI0XaDAeZL1zxr1fkF4CAUPtTmJfvkptlNJIs6hD3P0=;
        b=Zi/ns/knBoukPixOPvQVdeEnlC6CcElHx1pD9ihNHoaCZivvRgVWDBEVVlRqfew/X8
         AWlmKVf6V9/v8ph7IZQgLmzPSmdQQkVaLPMvJWioUoBRjZHy+UoB4q/d2qoVcQIwP2Dy
         MYg3yHkg/C8zDTfjFoO7FbNFGpWpAWPie54Mk5hok+CLppEGCxZe2b1g4yWiWSz+Ueob
         T5tF0MR6MWmSsXKy3ZT7OJB6uXb5YJ97uWX7vDsW1j9hK4hKBEJN2jHVTP34podAUFaV
         N+4A+IdqMsqfUHs25MTGXsxYm5fbENjU7HxK3xAl1BTGk1J+GzYvS/LlmAWGmHlJ2A9o
         luFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SI0XaDAeZL1zxr1fkF4CAUPtTmJfvkptlNJIs6hD3P0=;
        b=5B8keiOygmczpTOdjSMdLk1NsQNDFZMf2t/3bpSqcDQsLBjHeac65I3qgp/7lMZVbf
         mCRww4UfTmwCQXkr8fseuhOsq0eJLgcNyxG4ZK+kM1EPbquVpWHE41mzO6jP8pY5/tQd
         TnlnQpy7V7JPOnvzKLQKftfiK+4Sb/lq7URHcgTgrrejl0JYP90o5M5ZJtIygCQnnqvU
         bmIlMTwiK8BnIxGewpdkZ5aGbOLtAqIQfGnIgUvUTa7ZEths1V7fRKUuCyJEc/CACT5k
         PZKoZ1sD2UlUMTxCkPTkTw33yptGC4q57CvJdoWYrYS+wM/mRqdFuyDR6hDJTo/Us6R0
         fyiQ==
X-Gm-Message-State: ANoB5pn0vKR137F1p8Y9zLh8PU8Ga77yl4sRXYOJ8z2Ka/XsvfJ1uMvi
        e3lnzxzLBYVf5ZIyjZEEt46/6UV0Z0pT9rvtRbI=
X-Google-Smtp-Source: AA0mqf4IPSAM+jQSglz0ZwKBhyRUCEbHJmnJSNE/Hrt/eSv7zHWiByUdqunqFK0yY8kGaWG+QuqENsjdtXKvlSCwTHU=
X-Received: by 2002:a25:8a:0:b0:6f6:2180:3b8c with SMTP id 132-20020a25008a000000b006f621803b8cmr37336029yba.333.1670259557909;
 Mon, 05 Dec 2022 08:59:17 -0800 (PST)
MIME-Version: 1.0
References: <CAB6k_g0siQ7O3LSBGAMUB0OFFn6MCAurXFohRSZaJyxjfneZ9Q@mail.gmail.com>
 <Y4zQhTKmTXRj+AG0@kroah.com> <CAB6k_g2GXwpgUndJQTYKVFjnmbpkLnhLa7vYGOi7AzO-ci-ENQ@mail.gmail.com>
 <Y44L+TVanDkwAwHq@kroah.com>
In-Reply-To: <Y44L+TVanDkwAwHq@kroah.com>
From:   Oleksii Hryhorovych <alexcatze@gmail.com>
Date:   Mon, 5 Dec 2022 18:59:06 +0200
Message-ID: <CAB6k_g1nVGTmLey9zQVFp87hzcj089EeXcFEoW5P=mtM7wujGQ@mail.gmail.com>
Subject: Re: serial driver issue
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

=D0=BF=D0=BD, 5 =D0=B4=D0=B5=D0=BA. 2022 =D0=B3. =D0=B2 17:19, Greg KH <gre=
gkh@linuxfoundation.org>:
>
> On Sun, Dec 04, 2022 at 08:11:11PM +0200, Oleksii Hryhorovych wrote:
> > =D0=B2=D1=81, 4 =D0=B4=D0=B5=D0=BA. 2022 =D0=B3. =D0=B2 18:53, Greg KH =
<gregkh@linuxfoundation.org>:
> > >
> > > On Sun, Dec 04, 2022 at 06:42:19PM +0200, Oleksii Hryhorovych wrote:
> > > > Hi. I have a problem with linux "serial" driver. I`m using a MosChi=
p
> > > > 9901 based ExpressCard 34 dual rs-232 controller. When I plugged th=
is
> > > > card into my PC, the system detected it, but when I tried to send o=
r
> > > > read something from one of the ports, there was silence. Loopback t=
est
> > > > also fails. On windows this card works perfectly, so this is not a
> > > > hardware issue. My kernel version is "5.15.78-1-MANJARO".
> > >
> > > How exactly are you trying to send data through the port?  What comma=
nd
> > > did you use and what was the result?
> > >
> > I tried(each test 4 times, trying each device node for each port):
> > 1) Execute "cat /dev/ttyS6"(or ttyS7), connect rs-232 cable to port on
> > the card and to another PC, then send from another PC something to
> > port.
> > Result: nothing new appeared in console
>
> "cat" isn't the best test, minicom is good, as you tried:
>
> > 2) Connect rs232 cable to port on card and to another PC. Run terminal
> > on another PC, run minicom on this PC. Disable flow control. Send
> > something to terminal on both PCs.
> > Result: nothing appeared in terminals on both PCs.
> > 3) Connect pins number 2 and 3 on rs232 port (loopback test). Open
> > minicom, disable flow control and send something to the terminal.
> > Result: nothing new appeared in the terminal
> > 4) Connect pins number 2 and 3 on rs232 port (loopback test). Open
> > first console window, run "cat /dev/ttyS6"(or ttyS7). Open second
> > window, run "echo "test" > /dev/ttyS6"(or ttyS7).
> > Result: nothing new appeared in the first console
>
> I think the problem is that you do not have a driver attached to your
> serial ports, because:
>
> > > > "dmesg" output about this card:
> > > >
> > > > [64329.311478] pcieport 0000:00:1c.1: pciehp: Slot(1): Card present
> > > > [64329.311485] pcieport 0000:00:1c.1: pciehp: Slot(1): Link Up
> > > > [64329.442833] pci 0000:02:00.0: [9710:9901] type 00 class 0x070002
> > > > [64329.442867] pci 0000:02:00.0: reg 0x10: [io  0x0000-0x0007]
> > > > [64329.442883] pci 0000:02:00.0: reg 0x14: [mem 0x00000000-0x00000f=
ff]
> > > > [64329.442922] pci 0000:02:00.0: reg 0x20: [mem 0x00000000-0x00000f=
ff]
> > > > [64329.443096] pci 0000:02:00.0: supports D1 D2
> > > > [64329.443099] pci 0000:02:00.0: PME# supported from D0 D1 D2 D3hot=
 D3cold
> > > > [64329.443402] pci 0000:02:00.1: [9710:9901] type 00 class 0x070002
> > > > [64329.443434] pci 0000:02:00.1: reg 0x10: [io  0x0000-0x0007]
> > > > [64329.443451] pci 0000:02:00.1: reg 0x14: [mem 0x00000000-0x00000f=
ff]
> > > > [64329.443495] pci 0000:02:00.1: reg 0x20: [mem 0x00000000-0x00000f=
ff]
> > > > [64329.443679] pci 0000:02:00.1: supports D1 D2
> > > > [64329.443683] pci 0000:02:00.1: PME# supported from D0 D1 D2 D3hot=
 D3cold
> > > > [64329.443948] pci 0000:02:00.0: BAR 1: assigned [mem 0xd0000000-0x=
d0000fff]
> > > > [64329.443960] pci 0000:02:00.0: BAR 4: assigned [mem 0xd0001000-0x=
d0001fff]
> > > > [64329.443969] pci 0000:02:00.1: BAR 1: assigned [mem 0xd0002000-0x=
d0002fff]
> > > > [64329.443979] pci 0000:02:00.1: BAR 4: assigned [mem 0xd0003000-0x=
d0003fff]
> > > > [64329.443987] pci 0000:02:00.0: BAR 0: assigned [io  0x2000-0x2007=
]
> > > > [64329.443995] pci 0000:02:00.1: BAR 0: assigned [io  0x2008-0x200f=
]
> > > > [64329.444006] pcieport 0000:00:1c.1: PCI bridge to [bus 02-22]
> > > > [64329.444012] pcieport 0000:00:1c.1:   bridge window [io  0x2000-0=
x3fff]
> > > > [64329.444017] pcieport 0000:00:1c.1:   bridge window [mem
> > > > 0xd0000000-0xd3ffffff]
> > > > [64329.444023] pcieport 0000:00:1c.1:   bridge window [mem
> > > > 0xbfb00000-0xbfcfffff 64bit pref]
> > > > [64329.444110] serial 0000:02:00.0: enabling device (0000 -> 0003)
> > > > [64329.444690] 0000:02:00.0: ttyS6 at I/O 0x2000 (irq =3D 17, base_=
baud
> > > > =3D 115200) is a 16550A
> > > > [64329.448040] serial 0000:02:00.1: enabling device (0000 -> 0003)
> > > > [64329.452843] 0000:02:00.1: ttyS7 at I/O 0x2008 (irq =3D 18, base_=
baud
> > > > =3D 115200) is a 16550A
>
> ttyS6 and ttyS7 seem to be the correct devices, but:
>
> > > Which tty device node are you using here?
> > >
> > I tried using both nodes, /dev/ttyS6 and /dev/ttyS7, and the result
> > was the same.
> > > What does the output of `find /dev/serial/` show?
> > >
> > /dev/serial/
> > /dev/serial/by-id
> > /dev/serial/by-id/usb-HP_HP_hs2340_HSPA+_MobileBroadband_C69366190FA2EB=
60-if01
> > /dev/serial/by-id/usb-HP_HP_hs2340_HSPA+_MobileBroadband_C69366190FA2EB=
60-if03
> > /dev/serial/by-id/usb-HP_HP_hs2340_HSPA+_MobileBroadband_C69366190FA2EB=
60-if09
> > /dev/serial/by-path
> > /dev/serial/by-path/pci-0000:00:1a.0-usb-0:1.2:1.9
> > /dev/serial/by-path/pci-0000:00:1a.0-usb-0:1.2:1.1
> > /dev/serial/by-path/pci-0000:00:1a.0-usb-0:1.2:1.3
>
> You only have usb-serial devices seen in the system.
>
> Are you sure the PCI card is being controlled properly?  No other kernel
> log messages?

I'm not sure about it, because I haven't proof of it. But there are no
other kernel messages about this card, and no errors in general.

>
> Is /dev/ttyS6 and ttyS7 present in /dev?

Yes.

>
> What does 'ls -l /sys/class/tty/' show?

lrwxrwxrwx 1 root root 0 =D0=B4=D0=B5=D0=BA  2 15:03 console ->
../../devices/virtual/tty/console
lrwxrwxrwx 1 root root 0 =D0=B4=D0=B5=D0=BA  2 15:03 ptmx -> ../../devices/=
virtual/tty/ptmx
lrwxrwxrwx 1 root root 0 =D0=B4=D0=B5=D0=BA  2 15:03 tty -> ../../devices/v=
irtual/tty/tty
lrwxrwxrwx 1 root root 0 =D0=B4=D0=B5=D0=BA  2 15:03 tty0 -> ../../devices/=
virtual/tty/tty0
lrwxrwxrwx 1 root root 0 =D0=B4=D0=B5=D0=BA  2 15:03 tty1 -> ../../devices/=
virtual/tty/tty1
lrwxrwxrwx 1 root root 0 =D0=B4=D0=B5=D0=BA  2 15:03 tty10 -> ../../devices=
/virtual/tty/tty10
lrwxrwxrwx 1 root root 0 =D0=B4=D0=B5=D0=BA  2 15:03 tty11 -> ../../devices=
/virtual/tty/tty11
lrwxrwxrwx 1 root root 0 =D0=B4=D0=B5=D0=BA  2 15:03 tty12 -> ../../devices=
/virtual/tty/tty12
lrwxrwxrwx 1 root root 0 =D0=B4=D0=B5=D0=BA  2 15:03 tty13 -> ../../devices=
/virtual/tty/tty13
lrwxrwxrwx 1 root root 0 =D0=B4=D0=B5=D0=BA  2 15:03 tty14 -> ../../devices=
/virtual/tty/tty14
lrwxrwxrwx 1 root root 0 =D0=B4=D0=B5=D0=BA  2 15:03 tty15 -> ../../devices=
/virtual/tty/tty15
lrwxrwxrwx 1 root root 0 =D0=B4=D0=B5=D0=BA  2 15:03 tty16 -> ../../devices=
/virtual/tty/tty16
lrwxrwxrwx 1 root root 0 =D0=B4=D0=B5=D0=BA  2 15:03 tty17 -> ../../devices=
/virtual/tty/tty17
lrwxrwxrwx 1 root root 0 =D0=B4=D0=B5=D0=BA  2 15:03 tty18 -> ../../devices=
/virtual/tty/tty18
lrwxrwxrwx 1 root root 0 =D0=B4=D0=B5=D0=BA  2 15:03 tty19 -> ../../devices=
/virtual/tty/tty19
lrwxrwxrwx 1 root root 0 =D0=B4=D0=B5=D0=BA  2 15:03 tty2 -> ../../devices/=
virtual/tty/tty2
lrwxrwxrwx 1 root root 0 =D0=B4=D0=B5=D0=BA  2 15:03 tty20 -> ../../devices=
/virtual/tty/tty20
lrwxrwxrwx 1 root root 0 =D0=B4=D0=B5=D0=BA  2 15:03 tty21 -> ../../devices=
/virtual/tty/tty21
lrwxrwxrwx 1 root root 0 =D0=B4=D0=B5=D0=BA  2 15:03 tty22 -> ../../devices=
/virtual/tty/tty22
lrwxrwxrwx 1 root root 0 =D0=B4=D0=B5=D0=BA  2 15:03 tty23 -> ../../devices=
/virtual/tty/tty23
lrwxrwxrwx 1 root root 0 =D0=B4=D0=B5=D0=BA  2 15:03 tty24 -> ../../devices=
/virtual/tty/tty24
lrwxrwxrwx 1 root root 0 =D0=B4=D0=B5=D0=BA  2 15:03 tty25 -> ../../devices=
/virtual/tty/tty25
lrwxrwxrwx 1 root root 0 =D0=B4=D0=B5=D0=BA  2 15:03 tty26 -> ../../devices=
/virtual/tty/tty26
lrwxrwxrwx 1 root root 0 =D0=B4=D0=B5=D0=BA  2 15:03 tty27 -> ../../devices=
/virtual/tty/tty27
lrwxrwxrwx 1 root root 0 =D0=B4=D0=B5=D0=BA  2 15:03 tty28 -> ../../devices=
/virtual/tty/tty28
lrwxrwxrwx 1 root root 0 =D0=B4=D0=B5=D0=BA  2 15:03 tty29 -> ../../devices=
/virtual/tty/tty29
lrwxrwxrwx 1 root root 0 =D0=B4=D0=B5=D0=BA  2 15:03 tty3 -> ../../devices/=
virtual/tty/tty3
lrwxrwxrwx 1 root root 0 =D0=B4=D0=B5=D0=BA  2 15:03 tty30 -> ../../devices=
/virtual/tty/tty30
lrwxrwxrwx 1 root root 0 =D0=B4=D0=B5=D0=BA  2 15:03 tty31 -> ../../devices=
/virtual/tty/tty31
lrwxrwxrwx 1 root root 0 =D0=B4=D0=B5=D0=BA  2 15:03 tty32 -> ../../devices=
/virtual/tty/tty32
lrwxrwxrwx 1 root root 0 =D0=B4=D0=B5=D0=BA  2 15:03 tty33 -> ../../devices=
/virtual/tty/tty33
lrwxrwxrwx 1 root root 0 =D0=B4=D0=B5=D0=BA  2 15:03 tty34 -> ../../devices=
/virtual/tty/tty34
lrwxrwxrwx 1 root root 0 =D0=B4=D0=B5=D0=BA  2 15:03 tty35 -> ../../devices=
/virtual/tty/tty35
lrwxrwxrwx 1 root root 0 =D0=B4=D0=B5=D0=BA  2 15:03 tty36 -> ../../devices=
/virtual/tty/tty36
lrwxrwxrwx 1 root root 0 =D0=B4=D0=B5=D0=BA  2 15:03 tty37 -> ../../devices=
/virtual/tty/tty37
lrwxrwxrwx 1 root root 0 =D0=B4=D0=B5=D0=BA  2 15:03 tty38 -> ../../devices=
/virtual/tty/tty38
lrwxrwxrwx 1 root root 0 =D0=B4=D0=B5=D0=BA  2 15:03 tty39 -> ../../devices=
/virtual/tty/tty39
lrwxrwxrwx 1 root root 0 =D0=B4=D0=B5=D0=BA  2 15:03 tty4 -> ../../devices/=
virtual/tty/tty4
lrwxrwxrwx 1 root root 0 =D0=B4=D0=B5=D0=BA  2 15:03 tty40 -> ../../devices=
/virtual/tty/tty40
lrwxrwxrwx 1 root root 0 =D0=B4=D0=B5=D0=BA  2 15:03 tty41 -> ../../devices=
/virtual/tty/tty41
lrwxrwxrwx 1 root root 0 =D0=B4=D0=B5=D0=BA  2 15:03 tty42 -> ../../devices=
/virtual/tty/tty42
lrwxrwxrwx 1 root root 0 =D0=B4=D0=B5=D0=BA  2 15:03 tty43 -> ../../devices=
/virtual/tty/tty43
lrwxrwxrwx 1 root root 0 =D0=B4=D0=B5=D0=BA  2 15:03 tty44 -> ../../devices=
/virtual/tty/tty44
lrwxrwxrwx 1 root root 0 =D0=B4=D0=B5=D0=BA  2 15:03 tty45 -> ../../devices=
/virtual/tty/tty45
lrwxrwxrwx 1 root root 0 =D0=B4=D0=B5=D0=BA  2 15:03 tty46 -> ../../devices=
/virtual/tty/tty46
lrwxrwxrwx 1 root root 0 =D0=B4=D0=B5=D0=BA  2 15:03 tty47 -> ../../devices=
/virtual/tty/tty47
lrwxrwxrwx 1 root root 0 =D0=B4=D0=B5=D0=BA  2 15:03 tty48 -> ../../devices=
/virtual/tty/tty48
lrwxrwxrwx 1 root root 0 =D0=B4=D0=B5=D0=BA  2 15:03 tty49 -> ../../devices=
/virtual/tty/tty49
lrwxrwxrwx 1 root root 0 =D0=B4=D0=B5=D0=BA  2 15:03 tty5 -> ../../devices/=
virtual/tty/tty5
lrwxrwxrwx 1 root root 0 =D0=B4=D0=B5=D0=BA  2 15:03 tty50 -> ../../devices=
/virtual/tty/tty50
lrwxrwxrwx 1 root root 0 =D0=B4=D0=B5=D0=BA  2 15:03 tty51 -> ../../devices=
/virtual/tty/tty51
lrwxrwxrwx 1 root root 0 =D0=B4=D0=B5=D0=BA  2 15:03 tty52 -> ../../devices=
/virtual/tty/tty52
lrwxrwxrwx 1 root root 0 =D0=B4=D0=B5=D0=BA  2 15:03 tty53 -> ../../devices=
/virtual/tty/tty53
lrwxrwxrwx 1 root root 0 =D0=B4=D0=B5=D0=BA  2 15:03 tty54 -> ../../devices=
/virtual/tty/tty54
lrwxrwxrwx 1 root root 0 =D0=B4=D0=B5=D0=BA  2 15:03 tty55 -> ../../devices=
/virtual/tty/tty55
lrwxrwxrwx 1 root root 0 =D0=B4=D0=B5=D0=BA  2 15:03 tty56 -> ../../devices=
/virtual/tty/tty56
lrwxrwxrwx 1 root root 0 =D0=B4=D0=B5=D0=BA  2 15:03 tty57 -> ../../devices=
/virtual/tty/tty57
lrwxrwxrwx 1 root root 0 =D0=B4=D0=B5=D0=BA  2 15:03 tty58 -> ../../devices=
/virtual/tty/tty58
lrwxrwxrwx 1 root root 0 =D0=B4=D0=B5=D0=BA  2 15:03 tty59 -> ../../devices=
/virtual/tty/tty59
lrwxrwxrwx 1 root root 0 =D0=B4=D0=B5=D0=BA  2 15:03 tty6 -> ../../devices/=
virtual/tty/tty6
lrwxrwxrwx 1 root root 0 =D0=B4=D0=B5=D0=BA  2 15:03 tty60 -> ../../devices=
/virtual/tty/tty60
lrwxrwxrwx 1 root root 0 =D0=B4=D0=B5=D0=BA  2 15:03 tty61 -> ../../devices=
/virtual/tty/tty61
lrwxrwxrwx 1 root root 0 =D0=B4=D0=B5=D0=BA  2 15:03 tty62 -> ../../devices=
/virtual/tty/tty62
lrwxrwxrwx 1 root root 0 =D0=B4=D0=B5=D0=BA  2 15:03 tty63 -> ../../devices=
/virtual/tty/tty63
lrwxrwxrwx 1 root root 0 =D0=B4=D0=B5=D0=BA  2 15:03 tty7 -> ../../devices/=
virtual/tty/tty7
lrwxrwxrwx 1 root root 0 =D0=B4=D0=B5=D0=BA  2 15:03 tty8 -> ../../devices/=
virtual/tty/tty8
lrwxrwxrwx 1 root root 0 =D0=B4=D0=B5=D0=BA  2 15:03 tty9 -> ../../devices/=
virtual/tty/tty9
lrwxrwxrwx 1 root root 0 =D0=B4=D0=B5=D0=BA  2 16:19 ttyACM0 ->
../../devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.2/1-1.2:1.1/tty/ttyACM0
lrwxrwxrwx 1 root root 0 =D0=B4=D0=B5=D0=BA  2 16:19 ttyACM1 ->
../../devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.2/1-1.2:1.3/tty/ttyACM1
lrwxrwxrwx 1 root root 0 =D0=B4=D0=B5=D0=BA  2 16:19 ttyACM2 ->
../../devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.2/1-1.2:1.9/tty/ttyACM2
lrwxrwxrwx 1 root root 0 =D0=B4=D0=B5=D0=BA  2 15:03 ttyS0 ->
../../devices/platform/serial8250/tty/ttyS0
lrwxrwxrwx 1 root root 0 =D0=B4=D0=B5=D0=BA  2 15:03 ttyS1 ->
../../devices/platform/serial8250/tty/ttyS1
lrwxrwxrwx 1 root root 0 =D0=B4=D0=B5=D0=BA  2 15:03 ttyS10 ->
../../devices/platform/serial8250/tty/ttyS10
lrwxrwxrwx 1 root root 0 =D0=B4=D0=B5=D0=BA  2 15:03 ttyS11 ->
../../devices/platform/serial8250/tty/ttyS11
lrwxrwxrwx 1 root root 0 =D0=B4=D0=B5=D0=BA  2 15:03 ttyS12 ->
../../devices/platform/serial8250/tty/ttyS12
lrwxrwxrwx 1 root root 0 =D0=B4=D0=B5=D0=BA  2 15:03 ttyS13 ->
../../devices/platform/serial8250/tty/ttyS13
lrwxrwxrwx 1 root root 0 =D0=B4=D0=B5=D0=BA  2 15:03 ttyS14 ->
../../devices/platform/serial8250/tty/ttyS14
lrwxrwxrwx 1 root root 0 =D0=B4=D0=B5=D0=BA  2 15:03 ttyS15 ->
../../devices/platform/serial8250/tty/ttyS15
lrwxrwxrwx 1 root root 0 =D0=B4=D0=B5=D0=BA  2 15:03 ttyS16 ->
../../devices/platform/serial8250/tty/ttyS16
lrwxrwxrwx 1 root root 0 =D0=B4=D0=B5=D0=BA  2 15:03 ttyS17 ->
../../devices/platform/serial8250/tty/ttyS17
lrwxrwxrwx 1 root root 0 =D0=B4=D0=B5=D0=BA  2 15:03 ttyS18 ->
../../devices/platform/serial8250/tty/ttyS18
lrwxrwxrwx 1 root root 0 =D0=B4=D0=B5=D0=BA  2 15:03 ttyS19 ->
../../devices/platform/serial8250/tty/ttyS19
lrwxrwxrwx 1 root root 0 =D0=B4=D0=B5=D0=BA  2 15:03 ttyS2 ->
../../devices/platform/serial8250/tty/ttyS2
lrwxrwxrwx 1 root root 0 =D0=B4=D0=B5=D0=BA  2 15:03 ttyS20 ->
../../devices/platform/serial8250/tty/ttyS20
lrwxrwxrwx 1 root root 0 =D0=B4=D0=B5=D0=BA  2 15:03 ttyS21 ->
../../devices/platform/serial8250/tty/ttyS21
lrwxrwxrwx 1 root root 0 =D0=B4=D0=B5=D0=BA  2 15:03 ttyS22 ->
../../devices/platform/serial8250/tty/ttyS22
lrwxrwxrwx 1 root root 0 =D0=B4=D0=B5=D0=BA  2 15:03 ttyS23 ->
../../devices/platform/serial8250/tty/ttyS23
lrwxrwxrwx 1 root root 0 =D0=B4=D0=B5=D0=BA  2 15:03 ttyS24 ->
../../devices/platform/serial8250/tty/ttyS24
lrwxrwxrwx 1 root root 0 =D0=B4=D0=B5=D0=BA  2 15:03 ttyS25 ->
../../devices/platform/serial8250/tty/ttyS25
lrwxrwxrwx 1 root root 0 =D0=B4=D0=B5=D0=BA  2 15:03 ttyS26 ->
../../devices/platform/serial8250/tty/ttyS26
lrwxrwxrwx 1 root root 0 =D0=B4=D0=B5=D0=BA  2 15:03 ttyS27 ->
../../devices/platform/serial8250/tty/ttyS27
lrwxrwxrwx 1 root root 0 =D0=B4=D0=B5=D0=BA  2 15:03 ttyS28 ->
../../devices/platform/serial8250/tty/ttyS28
lrwxrwxrwx 1 root root 0 =D0=B4=D0=B5=D0=BA  2 15:03 ttyS29 ->
../../devices/platform/serial8250/tty/ttyS29
lrwxrwxrwx 1 root root 0 =D0=B4=D0=B5=D0=BA  2 15:03 ttyS3 ->
../../devices/platform/serial8250/tty/ttyS3
lrwxrwxrwx 1 root root 0 =D0=B4=D0=B5=D0=BA  2 15:03 ttyS30 ->
../../devices/platform/serial8250/tty/ttyS30
lrwxrwxrwx 1 root root 0 =D0=B4=D0=B5=D0=BA  2 15:03 ttyS31 ->
../../devices/platform/serial8250/tty/ttyS31
lrwxrwxrwx 1 root root 0 =D0=B4=D0=B5=D0=BA  2 15:03 ttyS4 ->
../../devices/pnp0/00:04/tty/ttyS4
lrwxrwxrwx 1 root root 0 =D0=B4=D0=B5=D0=BA  2 15:03 ttyS5 ->
../../devices/pci0000:00/0000:00:16.3/tty/ttyS5
lrwxrwxrwx 1 root root 0 =D0=B4=D0=B5=D0=BA  5 18:50 ttyS6 ->
../../devices/pci0000:00/0000:00:1c.1/0000:02:00.0/tty/ttyS6
lrwxrwxrwx 1 root root 0 =D0=B4=D0=B5=D0=BA  5 18:50 ttyS7 ->
../../devices/pci0000:00/0000:00:1c.1/0000:02:00.1/tty/ttyS7
lrwxrwxrwx 1 root root 0 =D0=B4=D0=B5=D0=BA  2 15:03 ttyS8 ->
../../devices/platform/serial8250/tty/ttyS8
lrwxrwxrwx 1 root root 0 =D0=B4=D0=B5=D0=BA  2 15:03 ttyS9 ->
../../devices/platform/serial8250/tty/ttyS9

>
> thanks,
>
> greg k-h
