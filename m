From: =?ISO-8859-1?Q?Eric_B=E9nard?= <eric@eukrea.com>
Subject: Re: serial/imx.c : wrong baudrate at resume if console is on UART
Date: Mon, 31 May 2010 09:33:07 +0200
Message-ID: <4C036633.6070702@eukrea.com>
References: <4BFEDDD0.8000607@eukrea.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from 30.mail-out.ovh.net ([213.186.62.213]:37784 "HELO
	30.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755972Ab0EaHjv (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 31 May 2010 03:39:51 -0400
In-Reply-To: <4BFEDDD0.8000607@eukrea.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hi,

Le 27/05/2010 23:02, Eric B=E9nard a =E9crit :
> while testing suspend/resume on i.MX27, I meet a problem on resume : =
if
> the console is on the UART the baudrate it not restored properly (I g=
et
> random bitrate between 50 to 2Mbps). Here is a patch to add pm to the
> uart_ops (but the problem occurs also without this patch) :
> http://lists.infradead.org/pipermail/linux-arm-kernel/2010-May/016495=
=2Ehtml
>
I've noticed that commenting out the following line in serial_core.c=20
"fix" the problem :
diff --git a/drivers/serial/serial_core.c b/drivers/serial/serial_core.=
c
index 7f28307..c63476e 100644
--- a/drivers/serial/serial_core.c
+++ b/drivers/serial/serial_core.c
@@ -2092,7 +2092,7 @@ int uart_resume_port(struct uart_driver *drv,=20
struct uart_
          */
         if (uart_console(uport)) {
                 uart_change_pm(state, 0);
-               uport->ops->set_termios(uport, &termios, NULL);
+//             uport->ops->set_termios(uport, &termios, NULL);
                 console_start(uport->cons);
         }

Do you have a hint of why the baudrate is not properly restored for the=
=20
console or where I should dig to fix this in serial/imx.c ?

Thanks
Eric
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
