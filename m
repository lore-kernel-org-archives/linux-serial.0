From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v2] tty: serial core: decouple pm states from ACPI
Date: Fri, 07 Dec 2012 12:19:30 +0100
Message-ID: <50C1D0C2.4030002@linaro.org>
References: <1354876568-10617-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:33141 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932732Ab2LGLTc (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 7 Dec 2012 06:19:32 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so155417bkw.19
        for <linux-serial@vger.kernel.org>; Fri, 07 Dec 2012 03:19:31 -0800 (PST)
In-Reply-To: <1354876568-10617-1-git-send-email-linus.walleij@stericsson.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Linus Walleij <linus.walleij@stericsson.com>
Cc: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <alan@linux.intel.com>, Rickard Andersson <rickard.andersson@stericsson.com>, linux-acpi@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>

On 12/07/2012 11:36 AM, Linus Walleij wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
>=20
> The serial core is using power states lifted from ACPI for no
> good reason. Remove this reference from the documentation and
> alter all users to use an enum specific to the serial core
> instead, and define it in <linux/serial_core.h>.
>=20
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - rename states from _DEFAULT and _SLEEP to simply _ON
>   and _OFF as Rafael suggests.
> ---

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

One suggestion below.


[ ... ]

> @@ -1620,7 +1621,7 @@ static void uart_line_info(struct seq_file *m, =
struct uart_driver *drv, int i)
>  {
>  	struct uart_state *state =3D drv->state + i;
>  	struct tty_port *port =3D &state->port;
> -	int pm_state;
> +	enum uart_pm_state pm_state;
>  	struct uart_port *uport =3D state->uart_port;
>  	char stat_buf[32];
>  	unsigned int status;
> @@ -1645,12 +1646,12 @@ static void uart_line_info(struct seq_file *m=
, struct uart_driver *drv, int i)
>  	if (capable(CAP_SYS_ADMIN)) {
>  		mutex_lock(&port->mutex);
>  		pm_state =3D state->pm_state;
> -		if (pm_state)
> -			uart_change_pm(state, 0);
> +		if (pm_state !=3D UART_PM_STATE_ON)
> +			uart_change_pm(state, UART_PM_STATE_ON);

The check is already done in the uart_change_pm function, no ?

>  		spin_lock_irq(&uport->lock);
>  		status =3D uport->ops->get_mctrl(uport);
>  		spin_unlock_irq(&uport->lock);
> -		if (pm_state)
> +		if (pm_state !=3D UART_PM_STATE_ON)
>  			uart_change_pm(state, pm_state);

Maybe it could be worth to change uart_change_pm to return the old stat=
e
value.

So the code will be simpler:

pm_state =3D uart_change_pm(state, UART_PM_STATE_ON);

=2E..

uart_change_pm(state, pm_state);


The uart_change_pm already takes care of changing the value if the
current one is different.

Well, maybe that could come on a different patch.

[ ... ]

--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
