From: Dennis Borgmann <dennis.borgmann@googlemail.com>
Subject: Reading more than 255 bytes at once
Date: Tue, 25 Jan 2011 15:52:47 +0100
Message-ID: <4D3EE3BF.80703@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:52279 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750960Ab1AYOwy (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 25 Jan 2011 09:52:54 -0500
Received: by fxm20 with SMTP id 20so5315025fxm.19
        for <linux-serial@vger.kernel.org>; Tue, 25 Jan 2011 06:52:53 -0800 (PST)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hello linux-serial list!

I am using termios to process data on a /dev/ttyUSB*-port. Data is
coming in on one of these ports in burst of over 500bytes. I am doing
this with kernel 2.6.33.7, which contains FTDI-driver in Version 1.5.0.
My serial-hardware is a FT4232 and I am using non-canonical input.

My problem is, that I can only read bursts of up to 255 bytes, since the
array of control characters within the kernel named c_cc represents only
an unsigned char. So, if I set a value higher than 255 to c_cc[VMIN], it
won't be set the way I want within the kernel.

How would it be possible to read bursts of over 255 bytes? Right now I
am doing a workaround, which checks for data within the buffer (ioctl
SIOCINQ) of the serial driver and as soon as it gets above a wanted
value (let's say 501 bytes), I read the buffer and flush it.

I would rather like to do this with select(2) in combination with
read(2), which only returns after 501 bytes are available.

I already sent this question on ftdi-usb-sio-devel and privately to the
developers of the FTDI-driver in use without any success.

Is there a way to do this?

Very kind regards,
Dennis
