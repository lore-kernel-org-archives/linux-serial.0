From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH RFC] serial: mxs-auart: fix baud rate range
Date: Mon, 10 Aug 2015 09:22:09 -0300
Message-ID: <CAOMZO5CscLv+v=8QA-zchR3EeNogpwGRRARJo8qPROLwcBXTUg@mail.gmail.com>
References: <1439208767-29152-1-git-send-email-stefan.wahren@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1439208767-29152-1-git-send-email-stefan.wahren@i2se.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Janusz Uzycki <j.uzycki@elproma.com.pl>, Fabio Estevam <fabio.estevam@freescale.com>, Juergen Beisert <jbe@pengutronix.de>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Mon, Aug 10, 2015 at 9:12 AM, Stefan Wahren <stefan.wahren@i2se.com> wrote:

>         /* set baud rate */
> -       baud = uart_get_baud_rate(u, termios, old, 0, u->uartclk);
> +       baud_min = u->uartclk * 32 / 0x3fffc0;
> +       baud_max = u->uartclk * 32 / 0xec;
> +       baud = uart_get_baud_rate(u, termios, old, baud_min, baud_max);

Looks good. It would be nice to replace 0x3fffc0 and 0xec with defines though.

Regards,

Fabio Estevam
