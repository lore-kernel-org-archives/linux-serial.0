From: Johan Hovold <johan@kernel.org>
Subject: Re: usbserial / ftdi_sio (+ others) bug?
Date: Wed, 29 Oct 2014 09:51:28 +0100
Message-ID: <20141029085128.GC7841@localhost>
References: <CAHdUje_wc+-SwUTDsNHg8HkD2ynJDtOE18VXe5616UpFYyAU0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-lb0-f178.google.com ([209.85.217.178]:37947 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755492AbaJ2Iyh (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 29 Oct 2014 04:54:37 -0400
Content-Disposition: inline
In-Reply-To: <CAHdUje_wc+-SwUTDsNHg8HkD2ynJDtOE18VXe5616UpFYyAU0Q@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Janne Huttunen <jahuttun@gmail.com>
Cc: linux-usb@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>, linux-serial@vger.kernel.org

[ +CC: Peter, linux-serial ]

On Wed, Oct 29, 2014 at 10:07:26AM +0200, Janne Huttunen wrote:
> I own a device that implements a data logging interface using the
> FT232 USB-serial -chip. Very often it happens that connecting the
> associated software with the device requires multiple attempts.
> There seems to be two kinds of issues; either the program reports
> that it did not receive any data or it reports reading lots of
> data, but it was all invalid. I haven't yet looked at the former,
> but I did spend some time investigating the latter.
> 
> Simple strace of the program startup showed that when connecting
> fails, the program gets a lot (hundreds) of binary zeros while
> reading the device. I used usbmon to capture the traffic between
> the host and the device and the zeros are not strictly speaking
> coming from the device. However when this problem happens the
> device seems to report quite lot of overruns for a while, which
> was a clue. After a somewhat successful attempt to understand
> the operation of the tty code in Linux, I have a theory.
> 
> The usbserial driver sets the TTY_DRIVER_REAL_RAW flag. Based on
> the comment in tty_driver.h this implies that the driver is not
> supposed to report any statuses (including overruns) to ldisc
> if they are ignored by the application (like they are in this
> case). It's just that AFAICS the ftdi_sio subdriver (and many
> others) doesn't seem quite honor this, but seems to report any
> status unconditionally. Also AFAICS this then means that every
> overrun will get converted into single binary zero delivered to
> the application(?). If so, this probably isn't what is supposed
> to happen and would explain the flood of extraneous zeros the
> application was seeing when the connecting failed.
> 
> I haven't had yet the time to test this theory, but at least it
> seems plausible to me. Any thoughts, anybody?

You are correct. The usb-serial drivers, and at least some serial
drivers, fail to implement TTY_DRIVER_REAL_RAW correctly in that they
do not honour ((IGNBRK || (!BRKINT && !PARMRK)) && (IGNPAR || !INPCK)).

I'll take a look at the usb-serial drivers.

Having the driver not reporting overrun (and other) errors will
obviously not fix the underlying issue with your device, which is
generating all these errors in the first place.

Thanks,
Johan
