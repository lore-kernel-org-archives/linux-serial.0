From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/5] serial: Factor out uart_poll_timeout() from 8250
 driver
Date: Tue, 28 Sep 2010 15:04:33 +0100
Message-ID: <20100928150433.76cc8178@lxorguk.ukuu.org.uk>
References: <20100928133511.GA8289@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100928133511.GA8289@oksana.dev.rtsoft.ru>
Sender: linux-kernel-owner@vger.kernel.org
To: Anton Vorontsov <cbouatmailru@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Alan Cox <alan@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, Tobias Klauser <tklauser@distanz.ch>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

> +/* Base timer interval for polling */
> +int uart_poll_timeout(struct uart_port *port)
> +{
> +	int timeout = port->timeout;
> +
> +	return timeout > 6 ? (timeout / 2 - 2) : 1;
> +}
> +EXPORT_SYMBOL(uart_poll_timeout);

inline this rather than exporting it and making it global - it's a tiny
spec of code and the export symbol probably costs more !
