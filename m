From: "Poulain, Loic" <loic.poulain@intel.com>
Subject: RE: [PATCH] 8250_dw: Support all baudrates on baytrail
Date: Fri, 18 Apr 2014 08:09:29 +0000
Message-ID: <50C3158CF44D924791C15F1437EF2EC65E3004@HASMSX104.ger.corp.intel.com>
References: <1397136684-11515-1-git-send-email-loic.poulain@intel.com>
 <20140417111953.GB17611@xps8300>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:16144 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751503AbaDRIJw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 18 Apr 2014 04:09:52 -0400
In-Reply-To: <20140417111953.GB17611@xps8300>
Content-Language: en-US
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

> > +struct dw8250_acpi_desc {
> > +	unsigned int uartclk;

> This one we could actually drop while at it. The uartclk was
> originally delivered as driver data in case of ACPI, but we now get a
> clk for ACPI enumerated boards.

Ok!

> > +	void (*setup)(struct uart_8250_port *up);

> Why not just have the set_termios hook here?

It was to allow any future other byt specific init
In the setup (no just set_termios). But, yes I can
point directly to set_termios.


> But I don't have a problem if we go ahead with this first. We can
> always change it later. In any case, I'll prepare the clock driver in
> drivers/acpi/acpi_lpss.c for this. Let's see what Rafael and Mika
> think about it.

Sounds good,  while waiting to get a better solution, I'm going to 
upload a new patch version.

Thanks & Regards,
Loic
---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, 
92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

