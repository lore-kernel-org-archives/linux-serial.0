From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: amba-pl011 complains about DMA for bcm2835 where it is not
 supported
Date: Mon, 27 Oct 2014 23:59:42 +0000
Message-ID: <20141027235942.GY27405@n2100.arm.linux.org.uk>
References: <20141027234430.GA1788@haysend>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:46221 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752752AbaJ0X7t (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 27 Oct 2014 19:59:49 -0400
Content-Disposition: inline
In-Reply-To: <20141027234430.GA1788@haysend>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Piotr =?iso-8859-1?Q?Kr=F3l?= <piotr.krol@3mdeb.com>
Cc: linux-serial@vger.kernel.org, jslaby@suse.cz, gregkh@linuxfoundation.org

On Tue, Oct 28, 2014 at 12:44:31AM +0100, Piotr Kr=F3l wrote:
> Hi all,
> according to BCM2835 ARM Peripherals spec DMA is optional functionali=
ty
> for ARM PL011 UART and it is not supported on this SoC. It looks like
> amba-pl011 search for device tree property (dma-names) unconditionall=
y,
> what leads to error message:
>=20
> of_dma_request_slave_channel: dma-names property of node '/soc/uart@7=
e201000' missing or empty
> uart-pl011 20201000.uart: no DMA platform data
>=20
> I assume that if it is possible that amba-pl011 can be without DMA we
> should check if DMA is supported and then try to read properties. Is
> there any known method for checking dma support ? If yes that I would=
 be
> glad for any pointers.
>=20
> Let me know if I should ignore/accept this error message or there is
> some code fix needed.

A great many implementations of PL011 do not have DMA support (some hav=
e
DMA support but its well broken.)  The driver has always supported PIO
mode, and continues to do so.

--=20
=46TTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
