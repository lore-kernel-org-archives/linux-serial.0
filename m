From: "jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Plug and play for a tty line disciple networking device
Date: Tue, 19 Mar 2013 11:30:05 -0400
Message-ID: <CAKON4OxNV85-J8C-hodpq9pY5tRCT+7aYa=m4T3Vk04XSGhOrA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alan Ott <alan-yzvJWuRpmD1zbRFIqnYvSA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

How can you achieve plug and play for a ft2232 based USB serial device
implementing 802.15.4 networking?

The device has a 802.15.4 SOC with a UART attached to a ft2232. With
firmware loaded the only thing it can do is talk the 802.15.4 tty line
discipline, it is not a general purpose serial port.

Right now the device works by plugging it in and it appears as a
generic USB serial device like ttyUSB0. You then run a user space app
which sets the line discipline, holds the port open and attaches it to
the 6lowpan implementation in the networking code. But doing that is
inconvenient and users needs to be trained to do it. Much simpler if
we could just plug the device in and it worked.

We can add a EEPROM to the ft2232 to give it a unique USB ID.  Is it
possible to make a kernel driver that see this ID, sets the line
discipline and wires the serial port directly into the networking
code? There is already a driver in the 6lowpan code that turns the
line discipline into a net device. In this case there is no need for
the ttyUSB0 device to appear in user space.

--
Jon Smirl
jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
