From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/2] serdev: ttyport: enforce tty-driver open() requirement
Date: Tue, 17 Oct 2017 11:07:20 -0500
Message-ID: <CAL_JsqKhCue-vMzM2ip3NoGTKb9T_EexG3G2-SekfVZOTKdHOA@mail.gmail.com>
References: <20171016130620.5404-1-johan@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171016130620.5404-1-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Mon, Oct 16, 2017 at 8:06 AM, Johan Hovold <johan@kernel.org> wrote:
> The tty-driver open routine is mandatory, but the serdev
> tty-port-controller implementation did not treat it as such and would
> instead fall back to calling tty_port_open() directly.

The idea was to eventually get rid of the tty_struct dependency and
only depend on tty_port. That's very invasive though and needs various
pieces of tty_struct to move into tty_port.

Of course, tty_port_open itself would have to change as well, so this
change doesn't really matter.

Rob

> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  drivers/tty/serdev/serdev-ttyport.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/tty/serdev/serdev-ttyport.c b/drivers/tty/serdev/serdev-ttyport.c
> index 302018d67efa..404f3fd070a7 100644
> --- a/drivers/tty/serdev/serdev-ttyport.c
> +++ b/drivers/tty/serdev/serdev-ttyport.c
> @@ -102,10 +102,10 @@ static int ttyport_open(struct serdev_controller *ctrl)
>                 return PTR_ERR(tty);
>         serport->tty = tty;
>
> -       if (tty->ops->open)
> -               tty->ops->open(serport->tty, NULL);
> -       else
> -               tty_port_open(serport->port, tty, NULL);
> +       if (!tty->ops->open)
> +               goto err_unlock;
> +
> +       tty->ops->open(serport->tty, NULL);
>
>         /* Bring the UART into a known 8 bits no parity hw fc state */
>         ktermios = tty->termios;
> @@ -122,6 +122,12 @@ static int ttyport_open(struct serdev_controller *ctrl)
>
>         tty_unlock(serport->tty);
>         return 0;
> +
> +err_unlock:
> +       tty_unlock(tty);
> +       tty_release_struct(tty, serport->tty_idx);
> +
> +       return -ENODEV;
>  }
>
>  static void ttyport_close(struct serdev_controller *ctrl)
> --
> 2.14.2
>
