From: peter.sheeren@axiris.be
Subject: Fwd: Bug in USB FTDI SIO driver
Date: Sat, 08 Sep 2012 12:14:39 +0200
Message-ID: <20120908121439.15264wgwo05hva8f@webmail.axiris.be>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="=_4v6mnlyk9tov"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailrelay04-01.mx.hostbasket.com ([85.255.200.186]:38816 "EHLO
	mailrelay04-01.mx.hostbasket.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753250Ab2IHK24 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 8 Sep 2012 06:28:56 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: peter.sheeren@axiris.be

This message is in MIME format.

--=_4v6mnlyk9tov
Content-Type: text/plain;
 charset=ISO-8859-1;
 DelSp="Yes";
 format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Hello

At the suggestion of Greg's friendly e-mail bot I'm sending my report  
to this e-mail address. I hope it's the right one.

Peter


--=_4v6mnlyk9tov
Content-Type: message/rfc822;
 name="Forwarded Message: Bug in USB FTDI SIO driver"

Received: from d54C26B86.access.telenet.be (d54C26B86.access.telenet.be
 [84.194.107.134]) by webmail.axiris.be (Horde Framework) with HTTP; Sat, 08
 Sep 2012 04:21:06 +0200
Message-ID: <20120908042106.60247e3thepx3q1e@webmail.axiris.be>
Date: Sat, 08 Sep 2012 04:21:06 +0200
From: peter.sheeren@axiris.be
To: jhovold@gmail.com, greg@kroah.com
Subject: Bug in USB FTDI SIO driver
MIME-Version: 1.0
Content-Type: text/plain;
 charset=ISO-8859-1;
 DelSp="Yes";
 format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit


Hello

I didn't find an easy way to file a bug report so I extracted the  
source file ftdi_sio.c from the latest Linux kernel and browsed for  
the e-mail addresses hence this e-mail.

I've been struggling with an annoying plug-and-play issue involving an  
FT232RL-based USB device on ARM machines with Linux lately (including  
Raspberry Pi and BeagleBoard). In a nutshell the following is happening:
* I plug in the FT232RL-based USB device. /dev/ttyUSB0 is created.
* I run an application that communicate with the device via  
/dev/ttyUSB0. The application sets a baudrate - this is important. The  
application reads and writes data successfully.
* I unplug the USB device. /dev/ttyUSB0 remains in existence - this is  
important too.
* I replug the USB device. /dev/ttyUSB0 is still there.
* I rerun the application. The application again connects with  
/dev/ttyUSB0 but it fails to transfer data. So it seems.

I ran I number of tests with a small program on my ARM based systems  
and I discovered that the culprit is setting the baudrate. It turns  
out that, after replugging the USB device, setting the baudrate is not  
relayed to the USB device.

Since this looks like a caching problem, I tracked down the  
corresponding source code in ftdi_sio.c and I'm confident the  
following text is the cause of the problem:

(line 1375)

	if (((old_priv.flags & ASYNC_SPD_MASK) !=
	     (priv->flags & ASYNC_SPD_MASK)) ||
	    (((priv->flags & ASYNC_SPD_MASK) == ASYNC_SPD_CUST) &&
	     (old_priv.custom_divisor != priv->custom_divisor))) {
		change_speed(tty, port);

Function change_speed() is called only when the baudrate  
(custom_divisor) has changed but after a USB replug this assumption is  
wrong. Also note that /dev/ttyUSB0 remains in existence on the system  
under test. If it were up to me, I'd always send the baudrate setting  
over the USB bus nomatter whether the baudrate (supposedly) has  
changed or not.

I found a workaround for this bug: my software sets a different  
baudrate prior to the intended baudrate hence fooling the ftdi_sio.c  
code but ofcourse it's a workaround.

I hope this report will help you improve your driver.

Best regards,

Peter S'heeren
http://www.axiris.be/


--=_4v6mnlyk9tov--
