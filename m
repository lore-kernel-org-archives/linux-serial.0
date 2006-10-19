From: Olof Johansson <olof@lixom.net>
Subject: Re: [RFC][PATCH] Xilinx uartlite serial driver
Date: Thu, 19 Oct 2006 18:06:59 -0500
Message-ID: <20061019180659.200d7763@pb15>
References: <87ac9o3ak3.fsf@sleipner.barco.com>
	<878xlgercm.fsf@slug.be.48ers.dk>
	<20060912093301.77f75bfb@localhost.localdomain>
	<87ejugxqbw.fsf@slug.be.48ers.dk>
	<871wqfyjgi.fsf@slug.be.48ers.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lixom.net ([66.141.50.11]:50133 "EHLO mail.lixom.net")
	by vger.kernel.org with ESMTP id S1946632AbWJSXIF (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 19 Oct 2006 19:08:05 -0400
In-Reply-To: <871wqfyjgi.fsf@slug.be.48ers.dk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Peter Korsgaard <jacmet@sunsite.dk>
Cc: rmk+serial@arm.linux.org.uk, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 13 Sep 2006 15:39:09 +0200 Peter Korsgaard <jacmet@sunsite.dk> wrote:

> +static int __devinit ulite_probe(struct platform_device *pdev)
[...]
> +	port = &ports[pdev->id];
> +
> +	port->fifosize	= 16;
> +	port->regshift	= 2;
> +	port->iotype	= UPIO_MEM;
> +	port->iobase	= 1; /* mark port in use */
> +	port->mapbase	= res->start;
> +	port->membase	= 0;
> +	port->ops	= &ulite_ops;
> +	port->irq	= res2->start;
> +	port->flags	= UPF_BOOT_AUTOCONF;
> +	port->dev	= &pdev->dev;
> +	port->type	= PORT_UNKNOWN;

Hi Peter,

You never fill in the 'line' member here, so probing of a second
uartlite port will fail.

Add:
	port->line	 = pdev->id;


-Olof
