From: Ian Abbott <abbotti@mev.co.uk>
Subject: Re: [Nios2-dev] [PATCH 1/2] serial: Add driver for the Altera JTAG
 UART
Date: Thu, 6 May 2010 11:59:31 +0100
Message-ID: <1273143571.3477.29.camel@gentoo-ija64.mev.local>
References: <cover.1273048151.git.tklauser@distanz.ch>
	 <e83e74abd82079284d5c8f62b78f2417ebc9ee27.1273048151.git.tklauser@distanz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.mev.co.uk ([62.49.15.74]:50230 "EHLO mail.mev.co.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751228Ab0EFK7j (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 6 May 2010 06:59:39 -0400
In-Reply-To: <e83e74abd82079284d5c8f62b78f2417ebc9ee27.1273048151.git.tklauser@distanz.ch>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: "nios2-dev@sopc.et.ntust.edu.tw" <nios2-dev@sopc.et.ntust.edu.tw>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "gregkh@suse.de" <gregkh@suse.de>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "alan@lxorguk.ukuu.org.uk" <alan@lxorguk.ukuu.org.uk>

On Wed, 2010-05-05 at 09:35 +0100, Tobias Klauser wrote:
> Add an UART driver for the JTAG UART component available as a SOPC
> (System on Programmable Chip) component for Altera FPGAs.
> 
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
[...]
> +#if defined(CONFIG_SERIAL_ALTERA_JTAGUART_CONSOLE_BYPASS)
> +static void altera_jtaguart_console_putc(struct console *co, const char c)
> +{
> +       struct uart_port *port = &(altera_jtaguart_ports + co->index)->port;
> +       unsigned long status;
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&port->lock, flags);
> +       while (((status = readl(port->membase + ALTERA_JTAGUART_CONTROL_REG)) &
> +               ALTERA_JTAGUART_CONTROL_WSPACE_MSK) == 0) {
> +               if ((status & ALTERA_JTAGUART_CONTROL_AC_MSK) == 0) {
> +                       spin_unlock_irqrestore(&port->lock, flags);
> +                       return; /* no connection activity */
> +               }
> +               spin_unlock_irqrestore(&port->lock, flags);
> +               cpu_relax();
> +               spin_lock_irqsave(&port->lock, flags);
> +       }
> +       writel(c, port->membase + ALTERA_JTAGUART_DATA_REG);
> +       spin_unlock_irqrestore(&port->lock, flags);
> +}
> +#else
> +static void altera_jtaguart_console_putc(struct console *co, const char c)
> +{
> +       struct uart_port *port = &(altera_jtaguart_ports + co->index)->port;
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&port->lock, flags);
> +       while ((readl(port->membase + ALTERA_JTAGUART_CONTROL_REG) &
> +               ALTERA_JTAGUART_CONTROL_WSPACE_MSK) == 0) {
> +               spin_unlock_irqrestore(&port->lock, flags);
> +               cpu_relax();
> +               spin_lock_irqsave(&port->lock, flags);
> +       }
> +       writel(c, port->membase + ALTERA_JTAGUART_DATA_REG);
> +       spin_unlock_irqrestore(&port->lock, flags);
> +}
> +#endif

I was originally responsible for adding the spin locks to these console
putc functions, but I'm not sure what the policy is regarding that, as
the 8250 driver doesn't use them for console output for example.

-- 
-=( Ian Abbott @ MEV Ltd.    E-mail: <abbotti@mev.co.uk>        )=-
-=( Tel: +44 (0)161 477 1898   FAX: +44 (0)161 718 3587         )=-

