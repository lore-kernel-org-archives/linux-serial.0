From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 0/9] tty: drop broken alt-speed handling
Date: Wed, 7 Jun 2017 12:53:43 +0300
Message-ID: <CAHp75Vc6hhOmCDE5y7R=frSYG7o5xPV2CwSWXjPEtamgigyzgA@mail.gmail.com>
References: <20170606105441.689-1-johan@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170606105441.689-1-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Samuel Ortiz <samuel@sortiz.org>, "David S. Miller" <davem@davemloft.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, USB <linux-usb@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Tue, Jun 6, 2017 at 1:54 PM, Johan Hovold <johan@kernel.org> wrote:
> Setting an alt-speed using TIOCSSERIAL and SPD flags has been deprecated
> since v2.1.69 and has been broken for all tty drivers but serial-core
> since v3.10 and commit 6865ff222cca ("TTY: do not warn about setting
> speed via SPD_*") without anyone noticing (for four years).
>
> Instead of reverting the offending commit, lets get rid of this legacy
> code while adding back a warning about the SPD flags being deprecated to
> the drivers that once implemented it. Note that drivers implementing
> SPD_CUST will continue to support using a custom divisor.
>
> Also note that serial-core did not rely on the TTY layer for SPD
> handling and continues to support it while warning about deprecation
> (since 2003 at least).
>
> Greg, I suggest you take it all trough the TTY tree even if merging
> through multiple trees and applying the final patch once everything is
> upstream would be an option. Also the irda clean up does not depend on
> the rest of series as the code implementing SPD handling was ifdefed
> out.

What a nice clean up!

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

>
> Johan
>
>
> Johan Hovold (9):
>   serial: rate limit custom-speed deprecation notice
>   USB: serial: ftdi_sio: simplify TIOCSSERIAL flag logic
>   USB: serial: ftdi_sio: remove broken alt-speed handling
>   tty: simserial: drop unused alt_speed handling
>   tty: amiserial: drop broken alt-speed support
>   tty: cyclades: drop broken alt-speed support
>   tty: rocket: drop broken alt-speed support
>   tty: ircomm: remove dead and broken ioctl code
>   tty: drop unused alt_speed from tty_struct
>
>  arch/ia64/hp/sim/simserial.c       |  13 -----
>  drivers/tty/amiserial.c            |  23 ++------
>  drivers/tty/cyclades.c             |  21 ++++----
>  drivers/tty/rocket.c               |  27 +++-------
>  drivers/tty/serial/serial_core.c   |   5 +-
>  drivers/usb/serial/ftdi_sio.c      |  67 +++++------------------
>  include/linux/tty.h                |   1 -
>  net/irda/ircomm/ircomm_tty_ioctl.c | 107 +------------------------------------
>  8 files changed, 34 insertions(+), 230 deletions(-)
>
> --
> 2.13.0
>



-- 
With Best Regards,
Andy Shevchenko
