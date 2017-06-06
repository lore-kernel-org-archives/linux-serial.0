From: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH v4 16/28] tty: serial: owl: Implement console driver
Date: Tue, 6 Jun 2017 14:34:07 +0100
Message-ID: <20170606143407.56d15c3c@lxorguk.ukuu.org.uk>
References: <20170606005426.26446-1-afaerber@suse.de>
 <20170606005426.26446-17-afaerber@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170606005426.26446-17-afaerber@suse.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Andreas =?UTF-8?B?RsOkcmJlcg==?= <afaerber@suse.de>
Cc: support@lemaker.org, =?UTF-8?B?5byg5aSp55uK?= <tyzhang@actions-semi.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 96boards@ucrobotics.com, linux-kernel@vger.kernel.org, Thomas Liau <thomas.liau@actions-semi.com>, mp-cs@actions-semi.com, linux-serial@vger.kernel.org, =?UTF-8?B?5YiY54Kc?= <liuwei@actions-semi.com>, Jiri Slaby <jslaby@suse.com>, linux-arm-kernel@lists.infradead.org, =?UTF-8?B?5byg5Lic6aOO?= <zhangdf@actions-semi.com>
List-Id: linux-serial@vger.kernel.org

> +
> +static void owl_uart_set_termios(struct uart_port *port,
> +				 struct ktermios *termios,
> +				 struct ktermios *old)
> +{
> +	struct owl_uart_port *owl_port = to_owl_uart_port(port);
> +	unsigned int baud;
> +	u32 ctl;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&port->lock, flags);
> +
> +	/* We don't support modem control lines. */
> +	termios->c_cflag &= ~(HUPCL | CMSPAR);
> +	termios->c_cflag |= CLOCAL;

CLOCAL and HUPCL are software not hardware properties so are probably
best not forced (it'll confuse some apps if you do)
> +
> +	/* We don't support BREAK character recognition. */
> +	termios->c_iflag &= ~(IGNBRK | BRKINT);

Ditto these


You do clear CMSPAR which is right if not supported but then later on we
have:

> +	if (termios->c_cflag & PARENB) {
> +		if (termios->c_cflag & CMSPAR) {
> +			if (termios->c_cflag & PARODD)
> +				ctl |= OWL_UART_CTL_PRS_MARK;
> +			else
> +				ctl |= OWL_UART_CTL_PRS_SPACE;
> +		} else if (termios->c_cflag & PARODD)
> +			ctl |= OWL_UART_CTL_PRS_ODD;
> +		else
> +			ctl |= OWL_UART_CTL_PRS_EVEN;
> +	} else
> +		ctl |= OWL_UART_CTL_PRS_NONE;


Which seems to indicate you do support CMSPAR so shouldn't be clearing it.

> +
> +	if (termios->c_cflag & CRTSCTS)
> +		ctl |= OWL_UART_CTL_AFE;
> +	else
> +		ctl &= ~OWL_UART_CTL_AFE;
> +
> +	owl_uart_write(port, ctl, OWL_UART_CTL);
> +
> +	baud = uart_get_baud_rate(port, termios, old, 9600, 3200000);
> +	owl_uart_change_baudrate(owl_port, baud);

You should re-encode the resulting baud rate into the termios

        /* Don't rewrite B0 */
        if (tty_termios_baud_rate(termios))
                tty_termios_encode_baud_rate(termios, baud, baud);
