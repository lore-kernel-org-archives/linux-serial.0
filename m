From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: USB serial support / Prolific PL2303 Driver
Date: Mon, 8 Apr 2013 08:03:51 -0700
Message-ID: <20130408150351.GA13824@kroah.com>
References: <CAFyqS9rphU1ua=mzvQhWPRuqJDJHo79s5fq9ZF+oXMMcMXkUjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:58801 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936387Ab3DHPDy (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 8 Apr 2013 11:03:54 -0400
Received: by mail-pa0-f47.google.com with SMTP id bj3so3289753pad.6
        for <linux-serial@vger.kernel.org>; Mon, 08 Apr 2013 08:03:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAFyqS9rphU1ua=mzvQhWPRuqJDJHo79s5fq9ZF+oXMMcMXkUjA@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Hans =?iso-8859-1?Q?Beck=E9rus?= <hans.beckerus@gmail.com>
Cc: linux-serial@vger.kernel.org

On Mon, Apr 08, 2013 at 03:37:42PM +0200, Hans Beck=E9rus wrote:
> I have some problems getting a USB serial adapter to work on our
> embedded Linux platform.

What kernel version are you using?

> At installation of the driver I can see the following:
>=20
> usbcore: registered new interface driver usbserial
> usbserial: USB Serial Driver core
> usbcore: registered new interface driver pl2303
> USB Serial support registered for pl2303
> pl2303 1-1.4:1.0: pl2303 converter detected
> usb 1-1.4: pl2303 converter now attached to ttyUSB0
>=20
> And there is such a device node created under /dev
>=20
> crw--w--w-    1 root     root      188,   0 Apr  8 12:35 /dev/ttyUSB0
>=20
>=20
> But I am not able to connect to it through putty :(

putty is a Windows program, how are you talking to it through your Linu=
x
box?

> What I tried on the Linux end was (getty is from busybox):
>=20
> /sbin/getty 115200 ttyUSB0

Can you run something like minicom on the Linux side?

Are you sure you have the hardware line settings correct for the device=
?

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
