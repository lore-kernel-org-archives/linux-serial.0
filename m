From: Johan Hovold <jhovold@gmail.com>
Subject: [RFC 0/4] tty: port hangup and close issues
Date: Wed, 13 Feb 2013 18:27:22 +0100
Message-ID: <1360776446-31371-1-git-send-email-jhovold@gmail.com>
References: <20130213142513.GA21078@localhost>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-la0-f42.google.com ([209.85.215.42]:50523 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760178Ab3BMR3I (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 13 Feb 2013 12:29:08 -0500
In-Reply-To: <20130213142513.GA21078@localhost>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Chris Ruehl <chris.ruehl@gtsys.com.hk>, Alan Stern <stern@rowland.harvard.edu>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-usb@vger.kernel.org, linux-serial@vger.kernel.org, Alan Cox <alan@linux.intel.com>, Johan Hovold <jhovold@gmail.com>

As mentioned in a previous mail there is a problem in the tty layer
which affects the USB-serial drivers. In summary, a call to dtr_rts()
can be made even after the device has been disconnected and the tty
device unregistered.

This can be worked around in usb-serial core by checking the
disconnected flag in dtr_rts() as we do in activate().

In my setup it can be almost perfectly reproduced by keeping the
usb-serial device open, while repeatedly opening and closing the port.
When the device is disconnected any open ports are properly hung up but
there is a window during disconnect where we can get a second open. This
call will fail in the serial driver because the disconnected flag is
checked in activate(). TTY core still proceeds to close the
never-successfully opened port, which involves the call to dtr_rts().

[ Note that this closing of an uninitialised port seems to be a bug in
  itself, which these patches aim to fix. ]

If the driver has port drain delay set, things get even worse, as we
then reschedule in tty_port_close_start() and usb-serial disconnect() can
proceed with unregistering the device. When scheduled back in, the device
is gone and the call to dtr_rts() will oops (as the usb-serial port
data is now NULL).

[ Note also that there has been a recent bug report, where dtr_rts() is
  called after tty device unregister when apparently only using minicom.
  This could indicate that there are more than one way to trigger this
  problem. ]

While trying to fix this bug I came across two related issues. First, it
turns out that dtr_rts() is normally not called at all during hang up,
and second, that the closing of uninitialised ports needlessly honours
drain delay.

1) With an open port (each open raising DTR/RST), dtr_rts() is never
   called to lower DTR/RTS when we get a hangup. This is because
   any open port reference will get the hung_up_tty_fops, which is later
   checked for in in tty_port_close_start before calling dtr_rts(). [ So
   it is only in the above somewhat construed case, with a second failed
   open that dtr_rts() is even called after a hangup. ]

   I propose to fix this by moving the HUPCL (DTR/RTS) handling from
   tty_port_close_start() to tty_shutdown() as well as protecting it
   with the ASYNC_INITIALISED flag. This way the signals are lowered on
   hangup as well as on the last close of a tty device (as before). This
   is also how things are currently handled in several serial drivers. 

   I've verified that all serial drivers that rely on
   tty_port_close_start() directly (rather than through tty_port_close())
   lowers DTR/RTS as part of their close() except for mxser.c and
   n_gsm.c, which I would need to fix.

   [ Note that some drivers currently seems broken with respect to this,
     as comments indicate that they do not expect tty_port_close_start to
     change the modem status. ]

   Note also that this would fix the usb-serial driver oops as a
   side-effect, as tty_port_shutdown() completes before the device is
   unregistered, and it would not be called again due to
   ASYNC_INITIALIZED.

2) Looking at tty_port_close_start() it seems to me that we should never
   do tty-driver callbacks on ports that have never been opened (as
   mentioned above). Currently, only the call to tty_wait_until_sent()
   is protected by the ASYNC_INITIALIZED flag, but I suggest this to be 
   extended to all driver callbacks as well as the drain-delay handling.

   As things stand today, a port with drain delay set could hang
   needlessly for up to two seconds on every failed open. The final
   patch below fixes this.

   Note that only protecting the driver call-backs could also in itself
   be enough to prevent the oops described above if it's decided best to
   keep HUPCL handling in tty_port_close_start().

The first, and third patches in the series are essentially clean-ups,
while the second patch fixes HUPCL handling and the last fixes the
closing of uninitialised ports.

Johan

   
Johan Hovold (4):
  tty: clean up port shutdown
  tty: fix DTR/RTS not being dropped on hang up
  tty: clean up port drain-delay handling
  tty: fix close of uninitialised ports

 drivers/tty/tty_port.c | 72 ++++++++++++++++++++++++++++++--------------------
 1 file changed, 44 insertions(+), 28 deletions(-)

-- 
1.8.1.1

