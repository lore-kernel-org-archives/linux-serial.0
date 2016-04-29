From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH] tty: Replace TTY_THROTTLED bit tests with tty_throttled()
Date: Fri, 29 Apr 2016 12:33:57 +0200
Message-ID: <20160429103357.GA22229@localhost>
References: <1460247096-6552-1-git-send-email-peter@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1460247096-6552-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Sat, Apr 09, 2016 at 05:11:36PM -0700, Peter Hurley wrote:
> Abstract TTY_THROTTLED bit tests with tty_throttled().
> 
> Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
> ---
>  drivers/char/pcmcia/synclink_cs.c      | 2 +-
>  drivers/mmc/card/sdio_uart.c           | 2 +-
>  drivers/net/usb/hso.c                  | 2 +-
>  drivers/staging/fwserial/fwserial.c    | 2 +-
>  drivers/staging/speakup/selection.c    | 2 +-
>  drivers/tty/amiserial.c                | 2 +-
>  drivers/tty/hvc/hvc_console.c          | 2 +-
>  drivers/tty/hvc/hvcs.c                 | 2 +-
>  drivers/tty/hvc/hvsi.c                 | 2 +-
>  drivers/tty/moxa.c                     | 2 +-
>  drivers/tty/nozomi.c                   | 2 +-
>  drivers/tty/serial/serial_core.c       | 2 +-
>  drivers/tty/synclink.c                 | 2 +-
>  drivers/tty/synclink_gt.c              | 2 +-
>  drivers/tty/synclinkmp.c               | 2 +-
>  drivers/tty/tty_ioctl.c                | 4 ++--
>  drivers/tty/vt/selection.c             | 2 +-
>  drivers/usb/gadget/function/u_serial.c | 4 ++--
>  drivers/usb/serial/digi_acceleport.c   | 3 +--

For usb-serial

Acked-by: Johan Hovold <johan@kernel.org>

Thanks,
Johan
