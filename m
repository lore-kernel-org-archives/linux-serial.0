From: Paul Burton <paul.burton@mips.com>
Subject: Re: [PATCH] Revert "serial: 8250: Fix clearing FIFOs in RS485 mode
 again"
Date: Sun, 16 Dec 2018 22:24:13 +0000
Message-ID: <20181216222411.5jkexuaqxpfudj7b@pburton-laptop>
References: <20181213174834.kxdy6fphaeoivqgh@pburton-laptop>
 <20181216200833.27928-1-paul.burton@mips.com>
 <f5a76d73-862f-3ebc-cd07-effc5c432103@denx.de>
 <20181216213133.kwe24pif3v4wcgwp@pburton-laptop>
 <949fdd3d-535e-d235-f406-d5bde4658c5e@denx.de>
 <CAAEAJfAad75bHX39ETCdVv9vP0dF7PLz2vvFLLqgtyikPHqJyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <CAAEAJfAad75bHX39ETCdVv9vP0dF7PLz2vvFLLqgtyikPHqJyA@mail.gmail.com>
Content-Language: en-US
Content-ID: <724D18326746444A950683E6C4278B91@namprd22.prod.outlook.com>
Sender: stable-owner@vger.kernel.org
To: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc: Marek Vasut <marex@denx.de>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Paul Burton <pburton@wavecomp.com>, Daniel Jedrychowski <avistel@gmail.com>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, stable <stable@vger.kernel.org>, Ezequiel Garcia <ezequiel@collabora.com>
List-Id: linux-serial@vger.kernel.org

Hi Ezequiel,

On Sun, Dec 16, 2018 at 06:52:53PM -0300, Ezequiel Garcia wrote:
> diff --git a/drivers/tty/serial/8250/8250_port.c
> b/drivers/tty/serial/8250/8250_port.c
> index c39482b96111..fac19cbc51d1 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -2209,10 +2209,11 @@ int serial8250_do_startup(struct uart_port *port)
>         /*
>          * Clear the FIFO buffers and disable them.
>          * (they will be reenabled in set_termios())
>          */
>         serial8250_clear_fifos(up);
> +       serial_out(up, UART_FCR, 0);
>=20
>         /*
>          * Clear the interrupt registers.
>          */
>         serial_port_in(port, UART_LSR);
>=20

This helps, but it only addresses one part of one of the 4 reasons I
listed as motivation for my revert. For example serial8250_do_shutdown()
also clearly intends to disable the FIFOs.

Thanks,
    Paul
