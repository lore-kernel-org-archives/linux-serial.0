From: Niklas Cassel <nks@flawful.org>
Subject: Re: [PATCH -next] serial: etraxfs-uart: Fix crash
Date: Mon, 2 Nov 2015 17:24:21 +0100
Message-ID: <56378E35.6050102@flawful.org>
References: <1446431576-4385-1-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1446431576-4385-1-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
List-Id: linux-serial@vger.kernel.org

Acked-by: Niklas Cassel <nks@flawful.org>

On 11/02/2015 03:32 AM, Guenter Roeck wrote:
> Since commit 7d8c70d8048c ("serial: mctrl-gpio: rename init function"=
),
> crisv32 either do not build or crash as follows.
>
> Unable to handle kernel NULL pointer dereference
> Linux 4.3.0-rc7-next-20151101 #1 Sun Nov 1 11:41:28 PST 2015
> ...
> Call Trace: [<c0004a0e>] show_stack+0x0/0x9e
> [<c004c0c0>] printk+0x0/0x2c
> [<c00059d4>] show_registers+0x14a/0x1c2
> [<c004c0c0>] printk+0x0/0x2c
> [<c0004b52>] die_if_kernel+0x7c/0x9e
> [<c0005346>] do_page_fault+0x32e/0x3e6
> [<c01dc59c>] of_get_property+0x0/0x2c
> [<c01e0558>] of_irq_parse_raw+0x12a/0x376
> [<c01dc59c>] of_get_property+0x0/0x2c
> [<c0053aca>] get_page_from_freelist+0x73e/0x856
> [<c01dc59c>] of_get_property+0x0/0x2c
> [<c0008912>] d_mmu_refill+0x10a/0x112
> [<c01b488c>] devm_kmalloc+0x40/0x56
> [<c01b47d0>] add_dr+0xc/0x1c
> [<c01b4800>] devm_add_action+0x2/0x4e
> [<c01abdbc>] mctrl_gpio_init_noauto+0x1c/0x76
> [<c01abf9e>] mctrl_gpio_init+0x22/0x110
>
> The function call in the etraxfs-uart driver was not renamed,
> possibly due to interference with commit 7b9c5162c182 ("serial:
> etraxfs-uart: use mctrl_gpio helpers for handling modem signals").
>
> Fixes: 7d8c70d8048c ("serial: mctrl-gpio: rename init function")
> Cc: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> Cc: Niklas Cassel <nks@flawful.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> It might make sense to merge this patch into the original patch if po=
ssible.
>
>  drivers/tty/serial/etraxfs-uart.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/etraxfs-uart.c b/drivers/tty/serial/e=
traxfs-uart.c
> index 6813e316e9ff..2f80bc7e44fb 100644
> --- a/drivers/tty/serial/etraxfs-uart.c
> +++ b/drivers/tty/serial/etraxfs-uart.c
> @@ -894,7 +894,7 @@ static int etraxfs_uart_probe(struct platform_dev=
ice *pdev)
>  	up->regi_ser =3D of_iomap(np, 0);
>  	up->port.dev =3D &pdev->dev;
> =20
> -	up->gpios =3D mctrl_gpio_init(&pdev->dev, 0);
> +	up->gpios =3D mctrl_gpio_init_noauto(&pdev->dev, 0);
>  	if (IS_ERR(up->gpios))
>  		return PTR_ERR(up->gpios);
> =20
