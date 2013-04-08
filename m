From: =?ISO-8859-1?Q?Hans_Beck=E9rus?= <hans.beckerus@gmail.com>
Subject: USB serial support / Prolific PL2303 Driver
Date: Mon, 8 Apr 2013 15:37:42 +0200
Message-ID: <CAFyqS9rphU1ua=mzvQhWPRuqJDJHo79s5fq9ZF+oXMMcMXkUjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-qe0-f45.google.com ([209.85.128.45]:62275 "EHLO
	mail-qe0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935827Ab3DHNhn (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 8 Apr 2013 09:37:43 -0400
Received: by mail-qe0-f45.google.com with SMTP id 1so1977895qee.32
        for <linux-serial@vger.kernel.org>; Mon, 08 Apr 2013 06:37:43 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

I have some problems getting a USB serial adapter to work on our
embedded Linux platform.
At installation of the driver I can see the following:

usbcore: registered new interface driver usbserial
usbserial: USB Serial Driver core
usbcore: registered new interface driver pl2303
USB Serial support registered for pl2303
pl2303 1-1.4:1.0: pl2303 converter detected
usb 1-1.4: pl2303 converter now attached to ttyUSB0

And there is such a device node created under /dev

crw--w--w-    1 root     root      188,   0 Apr  8 12:35 /dev/ttyUSB0


But I am not able to connect to it through putty :(
What I tried on the Linux end was (getty is from busybox):

/sbin/getty 115200 ttyUSB0

The serial adapter is connected through a USB HUB. Can that affect the
functionality?
The USB Ethernet we use is also connected to the same HUB and is working fine.

Is there something I can try to debug this further? Or is it something
obvious that I have overlooked?

Regards,
Hans
