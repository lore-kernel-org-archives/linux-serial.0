From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH 6/8] tty: Replace ASYNC_INITIALIZED bit and update
 atomically
Date: Fri, 29 Apr 2016 12:34:36 +0200
Message-ID: <20160429103436.GB22229@localhost>
References: <1460249607-8014-1-git-send-email-peter@hurleysoftware.com>
 <1460249607-8014-7-git-send-email-peter@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1460249607-8014-7-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Grant Edwards <grant.b.edwards@gmail.com>
List-Id: linux-serial@vger.kernel.org

On Sat, Apr 09, 2016 at 05:53:25PM -0700, Peter Hurley wrote:
> Replace ASYNC_INITIALIZED bit in the tty_port::flags field with
> TTY_PORT_INITIALIZED bit in the tty_port::iflags field. Introduce helpers
> tty_port_set_initialized() and tty_port_initialized() to abstract
> atomic bit ops.
> 
> Note: the transforms for test_and_set_bit() and test_and_clear_bit()
> are unnecessary as the state transitions are already mutually exclusive;
> the tty lock prevents concurrent open/close/hangup.
> 
> Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
> ---
>  drivers/char/pcmcia/synclink_cs.c  | 12 +++++-----
>  drivers/ipack/devices/ipoctal.c    |  5 ++---
>  drivers/isdn/i4l/isdn_tty.c        | 10 ++++-----
>  drivers/s390/char/con3215.c        | 12 +++++-----
>  drivers/tty/amiserial.c            | 14 ++++++------
>  drivers/tty/cyclades.c             | 14 ++++++------
>  drivers/tty/isicom.c               |  6 ++---
>  drivers/tty/moxa.c                 | 10 ++++-----
>  drivers/tty/mxser.c                | 14 +++++-------
>  drivers/tty/n_gsm.c                |  8 +++----
>  drivers/tty/rocket.c               | 10 ++++-----
>  drivers/tty/serial/crisv10.c       | 17 +++++++-------
>  drivers/tty/serial/serial_core.c   | 24 +++++++++++---------
>  drivers/tty/synclink.c             | 46 ++++++++++++++++++--------------------
>  drivers/tty/synclink_gt.c          | 16 ++++++-------
>  drivers/tty/synclinkmp.c           | 16 ++++++-------
>  drivers/tty/tty_port.c             | 13 ++++++-----
>  drivers/usb/class/cdc-acm.c        |  4 ++--
>  drivers/usb/serial/console.c       |  4 ++--
>  drivers/usb/serial/generic.c       |  6 ++---
>  drivers/usb/serial/mxuport.c       |  6 ++---
>  drivers/usb/serial/sierra.c        |  4 ++--
>  drivers/usb/serial/usb-serial.c    |  2 +-
>  drivers/usb/serial/usb_wwan.c      |  4 ++--

For usb-serial

Acked-by: Johan Hovold <johan@kernel.org>

Thanks,
Johan
