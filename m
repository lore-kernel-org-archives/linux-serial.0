From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCH 2/7] TTY: serial_core, remove unused variable
Date: Wed, 23 Mar 2011 14:45:31 +0530
Message-ID: <AANLkTim3XGC5EuHEdNqchQmWmcerXpnKCKZ3SbaibmXQ@mail.gmail.com>
References: <1300870200-24405-1-git-send-email-jslaby@suse.cz> <1300870200-24405-2-git-send-email-jslaby@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:59328 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755943Ab1CWJPw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 23 Mar 2011 05:15:52 -0400
In-Reply-To: <1300870200-24405-2-git-send-email-jslaby@suse.cz>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: jirislaby@gmail.com, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, linux-serial@vger.kernel.org

On Wed, Mar 23, 2011 at 2:19 PM, Jiri Slaby <jslaby@suse.cz> wrote:
> drivers/tty/serial/serial_core.c:1980:2: warning: Value stored to 'tt=
y' is never read
> =A0 =A0 =A0 =A0tty =3D port->tty;
> =A0 =A0 =A0 =A0^ =A0 =A0 ~~~~~~~~~
>
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>


Acked-by: Govindraj.R <govindraj.raja@ti.com>


> Cc: Greg Kroah-Hartman <gregkh@suse.de>
> Cc: linux-serial@vger.kernel.org
> ---
> =A0drivers/tty/serial/serial_core.c | =A0 =A04 ----
> =A01 files changed, 0 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/se=
rial_core.c
> index 733fe8e..d6e7240 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -1972,13 +1972,9 @@ int uart_suspend_port(struct uart_driver *drv,=
 struct uart_port *uport)
> =A0 =A0 =A0 =A0struct tty_port *port =3D &state->port;
> =A0 =A0 =A0 =A0struct device *tty_dev;
> =A0 =A0 =A0 =A0struct uart_match match =3D {uport, drv};
> - =A0 =A0 =A0 struct tty_struct *tty;
>
> =A0 =A0 =A0 =A0mutex_lock(&port->mutex);
>
> - =A0 =A0 =A0 /* Must be inside the mutex lock until we convert to tt=
y_port */
> - =A0 =A0 =A0 tty =3D port->tty;
> -
> =A0 =A0 =A0 =A0tty_dev =3D device_find_child(uport->dev, &match, seri=
al_match_port);
> =A0 =A0 =A0 =A0if (device_may_wakeup(tty_dev)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!enable_irq_wake(uport->irq))
> --
> 1.7.4.1
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-seria=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
