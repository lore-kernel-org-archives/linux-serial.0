From: Johan Hovold <jhovold-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 0/4] TTY: port hangup and close fixes
Date: Wed, 20 Feb 2013 17:02:48 +0100
Message-ID: <1361376172-31860-1-git-send-email-jhovold@gmail.com>
References: <1360776446-31371-1-git-send-email-jhovold@gmail.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1360776446-31371-1-git-send-email-jhovold-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>, Johan Hovold <jhovold-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

These patches against tty-next fix a few issues with tty-port hangup and
close.

The first and third patch are essentially clean ups.

The second patch makes sure DTR is dropped also on hangup and that DTR
is only dropped for initialised ports (where is could have been raised
in the first place).

The fourth and final patch, make sure no tty callbacks are made from
tty_port_close_start when the port has not been initialised (successfully
opened). This was previously only done for wait_until_sent but there's
no reason to call flush_buffer or to honour port drain delay either.
The latter could cause a failed open to stall for up to two seconds.

As a side-effect, this patches also fix an issue in USB-serial where we
could get tty-port callbacks on an uninitialised port after having hung
up and unregistered a device after disconnect.

Johan


Changes since RFC-series:
 - fix up the two driver relying on tty_port_close_start directly but
   that did not manage DTR themselves


Johan Hovold (4):
  TTY: clean up port shutdown
  TTY: fix DTR not being dropped on hang up
  TTY: clean up port drain-delay handling
  TTY: fix close of uninitialised ports

 drivers/tty/mxser.c    |  4 +++
 drivers/tty/n_gsm.c    |  4 +++
 drivers/tty/tty_port.c | 71 ++++++++++++++++++++++++++++++--------------------
 3 files changed, 51 insertions(+), 28 deletions(-)

-- 
1.8.1.1

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
