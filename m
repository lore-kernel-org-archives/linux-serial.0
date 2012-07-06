From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: can't detect 16550A at port 0x010 on Vortex86dx board
Date: Fri, 6 Jul 2012 23:54:59 +0100
Message-ID: <20120706235459.5886e2ee@pyramind.ukuu.org.uk>
References: <CAJkQPOm_TpNp6Y=rx0x9EtH1zvvwOb5JAo7Z+45BKRQPru-4ZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:53191 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756360Ab2GFWvU (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 6 Jul 2012 18:51:20 -0400
In-Reply-To: <CAJkQPOm_TpNp6Y=rx0x9EtH1zvvwOb5JAo7Z+45BKRQPru-4ZQ@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Aras Vaichas <aras.vaichas@gmail.com>
Cc: linux-serial@vger.kernel.org

> Would Linux block my ability to manually probe these i/o ports?

Not beyond reserving the region which you've said you've covered.

What you may want to try is making sure Linux doesn't program the DMA
controller (in case its doing something which disables the port in poking
at it).

Beyond that I guess ask the manufacturer for info.

Alan
