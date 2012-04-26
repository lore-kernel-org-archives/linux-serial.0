From: Corbin <corbinat@gmail.com>
Subject: How to detect serial buffer overruns
Date: Thu, 26 Apr 2012 16:28:36 -0500
Message-ID: <CAA0x6_8sn_FKiWwG-b2N7owwWMwMD-4S_HwaeDsQ3ydJtJTApQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:53668 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759106Ab2DZV25 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 26 Apr 2012 17:28:57 -0400
Received: by vcqp1 with SMTP id p1so59340vcq.19
        for <linux-serial@vger.kernel.org>; Thu, 26 Apr 2012 14:28:56 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hello,

Most of the documentation that I find to detect buffer overruns says
to use the TIOCGICOUNT ioctl along with serial_icounter_struct. It
appears, however, =A0that the buf_overrun field in this struct is not
updated in the 8250 driver. I confirmed this by writing a lot of data
to my computer's built-in serial port at 115200 baud and then doing a
read, which resulted in only receiving 69376 bytes back. It appears
the tty flip buffers begin to overflow at 69376 bytes, but again, the
buf_overrun field in the serial_icounter_struct shows no change after
calling the TIOCGICOUNT ioctl. I am able to get other information from
the ioctl just fine, such as parity, break, and framing errors. I went
through several of the drivers in /drivers/tty/serial and
drivers/usb/serial and it looks like my problem stems from that fact
that there aren't really any serial drivers that make use of
buf_overrun, including the 8250 driver which my port is using.

So, my question is, what is the recommended way to detect buffer overru=
ns?

Thanks,
Corbin Atkinson
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
