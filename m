From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH v2] serial/8250: Add support for Exar's XR17V35x family
 of multi-port PCIe UARTs
Date: Wed, 14 Nov 2012 23:00:36 +0000
Message-ID: <20121114230036.2504063c@pyramind.ukuu.org.uk>
References: <CAJp1Oe7tdGRzBAfXq67kzehgfUnw2FeeJRUEiX7RGya4NWkw7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:53144 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423302Ab2KNWzZ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 14 Nov 2012 17:55:25 -0500
In-Reply-To: <CAJp1Oe7tdGRzBAfXq67kzehgfUnw2FeeJRUEiX7RGya4NWkw7g@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Matt Schulte <matts@commtech-fastcom.com>
Cc: linux-serial@vger.kernel.org, Greg KH <greg@kroah.com>

> +	/* Fixme: needs tidying up */
> +	check = serial_in(up, UART_EXAR_DVID);
> +	if ((check == 0x82) || (check == 0x84) || (check == 0x88))
> +		p->handle_irq = exar_handle_irq;

Can't you check the port type here rather than re-probing stuff ?


Otherwise looks good
