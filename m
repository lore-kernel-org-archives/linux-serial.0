From: Piotr =?iso-8859-1?Q?Kr=F3l?= <piotr.krol@3mdeb.com>
Subject: amba-pl011 complains about DMA for bcm2835 where it is not supported
Date: Tue, 28 Oct 2014 00:44:31 +0100
Message-ID: <20141027234430.GA1788@haysend>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from az0017.srv.az.pl ([46.242.145.17]:48001 "EHLO az0017.srv.az.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752734AbaJ1ADK (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 27 Oct 2014 20:03:10 -0400
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: jslaby@suse.cz, gregkh@linuxfoundation.org, linux@arm.linux.org.uk

Hi all,
according to BCM2835 ARM Peripherals spec DMA is optional functionality
for ARM PL011 UART and it is not supported on this SoC. It looks like
amba-pl011 search for device tree property (dma-names) unconditionally,
what leads to error message:

of_dma_request_slave_channel: dma-names property of node '/soc/uart@7e2=
01000' missing or empty
uart-pl011 20201000.uart: no DMA platform data

I assume that if it is possible that amba-pl011 can be without DMA we
should check if DMA is supported and then try to read properties. Is
there any known method for checking dma support ? If yes that I would b=
e
glad for any pointers.

Let me know if I should ignore/accept this error message or there is
some code fix needed.

Thanks,
Piotr Kr=F3l
~
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
