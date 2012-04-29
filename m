From: Xiaofan Chen <xiaofanc@gmail.com>
Subject: Re: [PATCH] usb: cp210x: Added support for GPIO (CP2103/4/5)
Date: Sun, 29 Apr 2012 22:35:21 +0800
Message-ID: <CAGjSPUB9s2ZvSUyb+45VfPQGZK_w13HVvnoCxt+Df5bgWAsnbw@mail.gmail.com>
References: <1335632134-2488-1-git-send-email-preston.fick@silabs.com>
	<20120428190502.32eaf294@pyramind.ukuu.org.uk>
	<20380.13347.472373.965813@elektron.ikp.physik.tu-darmstadt.de>
	<20120428203322.7680594f@pyramind.ukuu.org.uk>
	<20381.15336.604590.461744@elektron.ikp.physik.tu-darmstadt.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:45414 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750896Ab2D2OfW (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 29 Apr 2012 10:35:22 -0400
In-Reply-To: <20381.15336.604590.461744@elektron.ikp.physik.tu-darmstadt.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Uwe Bonnes <bon@elektron.ikp.physik.tu-darmstadt.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

On Sun, Apr 29, 2012 at 9:02 PM, Uwe Bonnes
<bon@elektron.ikp.physik.tu-darmstadt.de> wrote:
> most RS232/USB Adapter don't supply and most applications working with these
> adapters don't need hard realtime. So even writing and reading the serial
> lines can be handled with libusb, like libftdi does.
>
> But as soon as higher level protocols based on the serial line get involved,
> a kernel driver is needed...
>
> So when thinking some termiox, some thoughts for the FTDI special modes,
> like MPSSE or synchronous FIFO should be spent. It would come handy if I
> could open /dev/ttyUSBx, set som termiox and could use the kernel driver for
> sending and receiving MPSSE commands. MPSSE is e.g. used in OpenOCD and
> xc3sprog to talk e.g. JTAG to external devices.

On the other hand, OpenOCD and your xc3sprog will probably remain
to be cross-plattform and in that case libusb/libftdi is a good option
to go. There is a patch under review in OpenOCD where libusb-1.0
is used for the MPSSE engine instead of libftdi/ftd2xx and the
performance seems to be better.



-- 
Xiaofan
