From: Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v2] serdev: add method to set parity
Date: Mon, 22 Jan 2018 19:23:00 +0100
Message-ID: <33F02495-73E7-47A6-B10B-FA6940F6DE63@holtmann.org>
References: <1516643792-22840-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1516643792-22840-1-git-send-email-ulrich.hecht+renesas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulrich Hecht <ulrich.hecht+renesas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Bluez mailing list <linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>, magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org
List-Id: linux-serial@vger.kernel.org

Hi Rob,

> Adds serdev_device_set_parity() and an implementation for ttyport.
> The interface uses an enum with the values SERIAL_PARITY_NONE,
> SERIAL_PARITY_EVEN and SERIAL_PARITY_ODD.
> 
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Reviewed-by: Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
> ---
> 
> Hi!
> 
> This revision addresses Johan's comments (see below for details) and adds
> Sebastian's Reviewed-by tag. Thank you for your reviews!
> 
> CU
> Uli
> 
> 
> Changes since v1:
> - added Reviewed-by tag
> - expanded commit message
> - shuffled stuff around to keep line-setting bits together
> - clear CMSPAR
> - (hopefully) detect errors correctly by checking tty->termios after call
>  to tty_set_termios().
> 
> 
> drivers/tty/serdev/core.c           | 12 ++++++++++++
> drivers/tty/serdev/serdev-ttyport.c | 24 ++++++++++++++++++++++++
> include/linux/serdev.h              | 10 ++++++++++
> 3 files changed, 46 insertions(+)

if there are no objections, I would like to just take this through bluetooth-next tree.

Regards

Marcel
