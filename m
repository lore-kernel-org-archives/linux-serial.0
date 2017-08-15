From: Rob Herring <robherring2@gmail.com>
Subject: Re: [PATCH] earlycon: initialise baud field of earlycon device structure
Date: Tue, 15 Aug 2017 14:26:28 -0500
Message-ID: <CAL_Jsq+=LQ0kXtBx7xXJEb0FtfqwQRZoUYtG0oDFnUj_VfoG1A@mail.gmail.com>
References: <20170815172141.29115-1-Eugeniy.Paltsev@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170815172141.29115-1-Eugeniy.Paltsev@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, arcml <linux-snps-arc@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
List-Id: linux-serial@vger.kernel.org

On Tue, Aug 15, 2017 at 12:21 PM, Eugeniy Paltsev
<Eugeniy.Paltsev@synopsys.com> wrote:
> For now baud field of earlycon structure device is't initialised at all
> in of_setup_earlycon (in opposit=D0=B5 to register_earlycon).
>
> So when I use stdout-path to point earlycon device
> (like stdout-path =3D &serial or stdout-path =3D "serial:115200n8")
> baud field of earlycon device structure remains uninitialised and
> earlycon initialization is not performed correctly as
> of_setup_earlycon is used.

Because the console driver is supposed to parse the option string.
That allows in theory for the options to be specific for each console.
Maybe your earlycon driver is failing to do that.

> When pass all arguments via bootargs
> (like bootargs =3D "earlycon=3Duart8250,mmio32,0xf0005000,115200n8")
> initialization is performed correctly as register_earlycon is used.
>
> So initialise baud field of earlycon device structure by baud value
> from device tree or from options (if they exist) when we use
> of_setup_earlycon
>
> Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
> ---
>  drivers/tty/serial/earlycon.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.=
c
> index c365154..6c2e2b6 100644
> --- a/drivers/tty/serial/earlycon.c
> +++ b/drivers/tty/serial/earlycon.c
> @@ -240,6 +240,7 @@ int __init of_setup_earlycon(const struct earlycon_id=
 *match,
>  {
>         int err;
>         struct uart_port *port =3D &early_console_dev.port;
> +       unsigned long baud;
>         const __be32 *val;
>         bool big_endian;
>         u64 addr;
> @@ -282,7 +283,15 @@ int __init of_setup_earlycon(const struct earlycon_i=
d *match,
>                 }
>         }
>
> +       val =3D of_get_flat_dt_prop(node, "baud", NULL);

No, we already have a defined way to set the baud, we don't need a
property in addition. Plus you didn't document it.

> +       if (val)
> +               early_console_dev.baud =3D be32_to_cpu(*val);
> +
>         if (options) {
> +               err =3D kstrtoul(options, 10, &baud);
> +               if (!err)
> +                       early_console_dev.baud =3D baud;

This seems fine to do here, but then we should also parse the other
standard options here too. And we should make sure we're not doing it
twice.

> +
>                 strlcpy(early_console_dev.options, options,
>                         sizeof(early_console_dev.options));
>         }
> --
> 2.9.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-serial" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
