From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] serial/8250: Add support for Exar's XR17V35x family of
 multi-port PCIe UARTs.
Date: Wed, 14 Nov 2012 12:22:59 +0000
Message-ID: <20121114122259.596cd858@pyramind.ukuu.org.uk>
References: <CAJp1Oe4DuffN_EWP-zVznBX+JqnE6kEAsXS1oHvfvfLC5DVOAw@mail.gmail.com>
	<20121109235800.745dcf15@pyramind.ukuu.org.uk>
	<CAJp1Oe652P=eGTQjo2aWwn2f0iMDz0dM172QjkBcZhx+O2_Ygw@mail.gmail.com>
	<20121110232444.7914f76f@pyramind.ukuu.org.uk>
	<CAJp1Oe73J848d++W_NLbp96VKmr6JrgkM4boLFyqUZ4WsdehVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:52298 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161163Ab2KNMRu (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 14 Nov 2012 07:17:50 -0500
In-Reply-To: <CAJp1Oe73J848d++W_NLbp96VKmr6JrgkM4boLFyqUZ4WsdehVA@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Matt Schulte <matts@commtech-fastcom.com>
Cc: linux-serial@vger.kernel.org, Greg KH <greg@kroah.com>, Theodore Ts'o <tytso@mit.edu>

> I'm having trouble figuring out where would be the right place to override the
> 
>      uart_port.handle_irq = serial8250_default_handle_irq
> 
> with my
> 
>      uart_port.handle_irq = exar_handle_irq
> 
> Can you give me a tip as to where in 8250.c this should be done?


To get it going how about adding a hack for it into set_io_from_upio with
a fixme note that we will need to tidy it all up later once things are
done ?

Alan
