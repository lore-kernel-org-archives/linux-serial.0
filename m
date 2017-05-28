From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 6/6] tty: serial: lpuart: add a more accurate baud rate
 calculation method
Date: Sun, 28 May 2017 03:04:15 +0300
Message-ID: <CAHp75Vemc5qoD7gbc_sJBSasYTFYSYOuWZv4N-4X60arWX8aJg@mail.gmail.com>
References: <1494316248-24052-1-git-send-email-aisheng.dong@nxp.com> <1494316248-24052-7-git-send-email-aisheng.dong@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1494316248-24052-7-git-send-email-aisheng.dong@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dong Aisheng <aisheng.dong@nxp.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, fugang.duan@nxp.com, Stefan Agner <stefan@agner.ch>, Mingkai.Hu@nxp.com, yangbo.lu@nxp.com
List-Id: linux-serial@vger.kernel.org

On Tue, May 9, 2017 at 10:50 AM, Dong Aisheng <aisheng.dong@nxp.com> wrote:
> On new LPUART versions, the oversampling ratio for the receiver can be
> changed from 4x (00011) to 32x (11111) which could help us get a more
> accurate baud rate divider.
>
> The idea is to use the best OSR (over-sampling rate) possible.
> Note, OSR is typically hard-set to 16 in other LPUART instantiations.
> Loop to find the best OSR value possible, one that generates minimum
> baud diff iterate through the rest of the supported values of OSR.

> +lpuart32_serial_setbrg(struct lpuart_port *sport, unsigned int baudrate)
> +{
> +       u32 sbr, osr, baud_diff, tmp_osr, tmp_sbr, tmp_diff, tmp;
> +       u32 clk =3D sport->port.uartclk;
> +
> +       /*
> +        * The idea is to use the best OSR (over-sampling rate) possible.
> +        * Note, OSR is typically hard-set to 16 in other LPUART instanti=
ations.
> +        * Loop to find the best OSR value possible, one that generates m=
inimum
> +        * baud_diff iterate through the rest of the supported values of =
OSR.
> +        *
> +        * Calculation Formula:
> +        *  Baud Rate =3D baud clock / ((OSR+1) =C3=97 SBR)
> +        */
> +       baud_diff =3D baudrate;
> +       osr =3D 0;
> +       sbr =3D 0;
> +

> +       for (tmp_osr =3D 4; tmp_osr <=3D 32; tmp_osr++) {

I _think_ you may simplify this and avoid for-loop if you reconsider approa=
ch.

> +               /* calculate the temporary sbr value  */
> +               tmp_sbr =3D (clk / (baudrate * tmp_osr));
> +               if (tmp_sbr =3D=3D 0)
> +                       tmp_sbr =3D 1;
> +
> +               /*
> +                * calculate the baud rate difference based on the tempor=
ary
> +                * osr and sbr values
> +                */

> +               tmp_diff =3D clk / (tmp_osr * tmp_sbr) - baudrate;

(32 - 4 + 1) times division is called...

> +
> +               /* select best values between sbr and sbr+1 */
> +               tmp =3D clk / (tmp_osr * (tmp_sbr + 1));
> +               if (tmp_diff > (baudrate - tmp)) {
> +                       tmp_diff =3D baudrate - tmp;
> +                       tmp_sbr++;
> +               }
> +
> +               if (tmp_diff <=3D baud_diff) {
> +                       baud_diff =3D tmp_diff;
> +                       osr =3D tmp_osr;
> +                       sbr =3D tmp_sbr;
> +               }
> +       }

> +       /* handle buadrate outside acceptable rate */
> +       if (baud_diff > ((baudrate / 100) * 3))
> +               dev_warn(sport->port.dev,
> +                        "unacceptable baud rate difference of more than =
3%%\n");

Shouldn't you fall back to previous setting?

> +
> +       tmp =3D lpuart32_read(sport->port.membase + UARTBAUD);
> +

> +       if ((osr > 3) && (osr < 8))

Isn't it

if (osr ^ BIT(2) < BIT(2))

?

> +               tmp |=3D UARTBAUD_BOTHEDGE;

> +}

> +       if (of_device_is_compatible(port->dev->of_node, "fsl,imx7ulp-lpua=
rt")) {
> +               lpuart32_serial_setbrg(sport, baud);

> +       } else {
> +               sbr =3D sport->port.uartclk / (16 * baud);
> +               bd &=3D ~UARTBAUD_SBR_MASK;
> +               bd |=3D sbr & UARTBAUD_SBR_MASK;
> +               bd |=3D UARTBAUD_BOTHEDGE;
> +               bd &=3D ~(UARTBAUD_TDMAE | UARTBAUD_RDMAE);
> +               lpuart32_write(bd, sport->port.membase + UARTBAUD);
> +       }

Perhaps it makes sense to split this to a helper function as well (in
a separate patch).

--=20
With Best Regards,
Andy Shevchenko
