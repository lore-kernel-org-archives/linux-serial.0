From: Johan Hovold <jhovold-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v3 0/6] TTY: port hangup and close fixes
Date: Thu,  7 Mar 2013 15:55:47 +0100
Message-ID: <1362668153-10972-1-git-send-email-jhovold@gmail.com>
References: <51361724.4050107@suse.cz>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <51361724.4050107-AlSwsSmVLrQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>, Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Johan Hovold <jhovold-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

These patches against 3.9-rc1 fix a few issues with tty-port hangup and
close.

The first and fifth patch are essentially clean ups.

The second and third patch fix the fact that DTR could get raised
(rather than dropped) at hangup if there are blocked opens. [ Note that
the second patch has been separated into its own patch and that the
third patch is new in v3 of this series. ]

The fourth patch makes sure DTR is dropped also on hangup and that DTR
is only dropped for initialised ports (where it could have been raised
in the first place).

The sixth and final patch, makes sure no tty callbacks are made from
tty_port_close_start when the port has not been initialised (successfully
opened). This was previously only done for wait_until_sent but there's
no reason to call flush_buffer or to honour port drain delay either.
The latter could cause a failed open to stall for up to two seconds.

As a side-effect, these patches also fix an issue in USB-serial where we
could get tty-port callbacks on an uninitialised port after having hung
up and unregistered a device after disconnect.

Johan


v3: 
 - amend series with fix of DTR sometimes being raised on hang-up
 - do not lower DTR on hangup if port tty is gone
 - make sure tty in call to shutdown is refcounted
 - use cflag-macros throughout

v2:
 - reuse tty reference from hangup and close in shutdown. Both call sites
   guarantee tty is either NULL or has a kref.

Changes since RFC-series:
 - fix up the two driver relying on tty_port_close_start directly but
   that did not manage DTR themselves


Johan Hovold (6):
  TTY: clean up port shutdown
  TTY: wake up processes last at hangup
  TTY: fix DTR being raised on hang up
  TTY: fix DTR not being dropped on hang up
  TTY: clean up port drain-delay handling
  TTY: fix close of uninitialised ports

 drivers/tty/mxser.c    |  4 +++
 drivers/tty/n_gsm.c    |  4 +++
 drivers/tty/tty_port.c | 77 ++++++++++++++++++++++++++++++--------------------
 3 files changed, 54 insertions(+), 31 deletions(-)

-- 
1.8.1.1

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
