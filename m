From: Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH] tty: serial: msm_serial: Fix XON/XOFF
Date: Mon, 20 May 2019 07:51:09 -0700
Message-ID: <20190520145110.7BDAE21721@mail.kernel.org>
References: <20190520103435.30850-1-jorge.ramirez-ortiz@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190520103435.30850-1-jorge.ramirez-ortiz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: agross@kernel.org, david.brown@linaro.org, gregkh@linuxfoundation.org, jorge.ramirez-ortiz@linaro.org
Cc: jslaby@suse.com, keescook@chromium.org, anton@enomsg.org, ccross@android.com, tony.luck@intel.com, linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, khasim.mohammed@linaro.org, agsumit@qti.qualcomm.com
List-Id: linux-serial@vger.kernel.org

Quoting Jorge Ramirez-Ortiz (2019-05-20 03:34:35)
> When the tty layer requests the uart to throttle, the current code
> executing in msm_serial will trigger "Bad mode in Error Handler" and
> generate an invalid stack frame in pstore before rebooting (that is if
> pstore is indeed configured: otherwise the user shall just notice a
> reboot with no further information dumped to the console).
>=20
> This patch replaces the PIO byte accessor with the word accessor
> already used in PIO mode.

Because the hardware only accepts word based accessors and fails
otherwise? I can believe that.

I wonder if the earlier UART hardware this driver used to support (i.e.
pre-DM) would accept byte access to the registers. It's possible, but we
don't really care because those boards aren't supported.

>=20
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

>  drivers/tty/serial/msm_serial.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_ser=
ial.c
> index 109096033bb1..23833ad952ba 100644
> --- a/drivers/tty/serial/msm_serial.c
> +++ b/drivers/tty/serial/msm_serial.c
> @@ -869,10 +870,12 @@ static void msm_handle_tx(struct uart_port *port)
>                 else
>                         tf =3D port->membase + UART_TF;
> =20
> +               buf[0] =3D port->x_char;
> +
>                 if (msm_port->is_uartdm)
>                         msm_reset_dm_count(port, 1);
> =20
> -               iowrite8_rep(tf, &port->x_char, 1);
> +               iowrite32_rep(tf, buf, 1);

I suppose it's OK to write some extra zeroes here?
