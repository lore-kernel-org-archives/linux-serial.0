From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH v2 8/9] tty: Use termios c_*flag macros
Date: Tue, 19 Jan 2016 15:38:41 +0100
Message-ID: <20160119143841.GC12069@localhost>
References: <1452486976-7594-1-git-send-email-peter@hurleysoftware.com>
 <1452486976-7594-9-git-send-email-peter@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1452486976-7594-9-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Sun, Jan 10, 2016 at 08:36:15PM -0800, Peter Hurley wrote:
> Expressions of the form "tty->termios.c_*flag & FLAG"
> are more clearly expressed with the termios flags macros,
> I_FLAG(), C_FLAG(), O_FLAG(), and L_FLAG().
> 
> Convert treewide.
> 
> Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
> ---
>  drivers/char/pcmcia/synclink_cs.c    | 21 ++++++++-------------
>  drivers/mmc/card/sdio_uart.c         | 14 +++++++-------
>  drivers/staging/dgap/dgap.c          |  2 +-
>  drivers/staging/dgnc/dgnc_tty.c      |  2 +-
>  drivers/tty/amiserial.c              | 22 ++++++++--------------
>  drivers/tty/cyclades.c               | 14 ++++++--------
>  drivers/tty/isicom.c                 |  3 +--
>  drivers/tty/mxser.c                  | 10 ++++------
>  drivers/tty/n_gsm.c                  |  6 +++---
>  drivers/tty/pty.c                    |  3 +--
>  drivers/tty/rocket.c                 |  8 ++++----
>  drivers/tty/serial/68328serial.c     |  4 +---
>  drivers/tty/serial/crisv10.c         | 18 +++++++-----------
>  drivers/tty/serial/jsm/jsm_tty.c     |  3 +--
>  drivers/tty/serial/serial_core.c     | 20 +++++++++-----------
>  drivers/tty/synclink.c               | 23 +++++++++--------------
>  drivers/tty/synclink_gt.c            | 19 +++++++------------
>  drivers/tty/synclinkmp.c             | 19 +++++++------------
>  drivers/tty/tty_ioctl.c              | 12 ++++++------
>  drivers/tty/tty_port.c               |  2 +-
>  drivers/usb/serial/cypress_m8.c      |  3 +--
>  drivers/usb/serial/digi_acceleport.c |  8 ++++----
>  drivers/usb/serial/io_edgeport.c     |  4 ++--
>  drivers/usb/serial/mct_u232.c        |  2 +-
>  drivers/usb/serial/mos7720.c         |  4 ++--
>  drivers/usb/serial/mos7840.c         |  4 ++--

For usb-serial

Acked-by: Johan Hovold <johan@kernel.org>

>  net/irda/ircomm/ircomm_tty.c         | 11 +++++------
>  net/irda/ircomm/ircomm_tty_ioctl.c   | 13 ++++---------
>  28 files changed, 113 insertions(+), 161 deletions(-)

Thanks,
Johan
