From: Jon Smirl <jonsmirl@gmail.com>
Subject: Is user space ldattach required?
Date: Sun, 11 Jul 2010 23:22:36 -0400
Message-ID: <AANLkTinahU8v-p8ZsawNxSIi3dcHzU7humyHwbmBd3_9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:62099 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755445Ab0GLDWi (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 11 Jul 2010 23:22:38 -0400
Received: by qwh6 with SMTP id 6so1184512qwh.19
        for <linux-serial@vger.kernel.org>; Sun, 11 Jul 2010 20:22:37 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

I have a USB stick containing a microcontroller. The microcontroller
is running TCP and can support two interfaces, the radio (802.15.4)
and USB serial. It supports the SLIP protocol (or PPP could be added).

This is not a general purpose serial connection. The only thing you
can do on the serial line without changing the firmware is talk SLIP.
It is a standard USB serial device with a unique device ID.

Can I use a device driver to get the SLIP ldisc attached to the port
or do I have to have a user space helper? I'd prefer ttyUSBx to not
even exist.

Is there a better way to get this device attached to the network stack?

-- 
Jon Smirl
jonsmirl@gmail.com
