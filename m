From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] serial: core: fix console problems on uart_close
Date: Tue, 25 Oct 2016 12:40:37 +0200
Message-ID: <CAMuHMdUtp9w6RE0abNZ3q3h7viH7bkGA0iqOM7Azo3kgHq4K-w@mail.gmail.com>
References: <20161024205649.32430-1-robh@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161024205649.32430-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>, Mike Galbraith <umgwanakikbuti@gmail.com>, Mugunthan V N <mugunthanvnm@ti.com>, Geert Uytterhoeven <geert+renesas@glider.be>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Peter Hurley <peter@hurleysoftware.com>, Alan Cox <alan@linux.intel.com>, Jiri Slaby <jslaby@suse.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi Rob,

On Mon, Oct 24, 2016 at 10:56 PM, Rob Herring <robh@kernel.org> wrote:
> Commit 761ed4a94582 ('tty: serial_core: convert uart_close to use
> tty_port_close') started setting the ttyport console flag for serial
> drivers. This is causing crashes, hangs, or garbage output on several
> platforms because the serial shutdown is skipped and IRQs are left
> enabled.

No, for me it hangs because uart_tty_port_shutdown() is _not_ skipped
when the UART is used as a serial console. Writing to the serial port while
it's shut down hangs.

> Partially revert commit 761ed4a94582 and drop reporting UART tty_ports
> as a console leaving the console handling to the serial_core as it was
> before.
>
> Fixes: 761ed4a94582ab29 ("tty: serial_core: convert uart_close to use tty=
_port_close")
> Reported-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.se=
>
> Reported-by: Mike Galbraith <umgwanakikbuti@gmail.com>
> Reported-by: Mugunthan V N <mugunthanvnm@ti.com>
> Cc: Peter Hurley <peter@hurleysoftware.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Alan Cox <alan@linux.intel.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jslaby@suse.com>
> Cc: linux-serial@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> Geert's fix seems to be inadequate for some systems as Mike reported[1].
> This fix works in Mike's case.
>
> Geert, Mugunthan, Can you all test this is enough to fix your issues.

This doesn't work for me, as port->console is still false. It should be tru=
e
when used as a serial console, to make sure tty_port_shutdown() skips
an active serial console.

Mike: I see you are using a PC, while I'm using an ARM board (with DT).
Are you using a serial console? If yes, what's the value of port->console
before and after the call to uart_console() that Rob's patch below removes?

Thanks!

> [1] https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1254753.=
html
>
>  drivers/tty/serial/serial_core.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial=
_core.c
> index 6e4f63627479..664c99aeeca5 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -2746,8 +2746,6 @@ int uart_add_one_port(struct uart_driver *drv, stru=
ct uart_port *uport)
>         uport->cons =3D drv->cons;
>         uport->minor =3D drv->tty_driver->minor_start + uport->line;
>
> -       port->console =3D uart_console(uport);
> -
>         /*
>          * If this port is a console, then the spinlock is already
>          * initialised.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
