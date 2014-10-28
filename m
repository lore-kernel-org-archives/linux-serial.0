From: Piotr =?iso-8859-1?Q?Kr=F3l?= <piotr.krol@3mdeb.com>
Subject: Re: amba-pl011 complains about DMA for bcm2835 where it is not
 supported
Date: Tue, 28 Oct 2014 01:09:23 +0100
Message-ID: <20141028000922.GB1788@haysend>
References: <20141027234430.GA1788@haysend>
 <20141027235942.GY27405@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from az0017.srv.az.pl ([46.242.145.17]:43479 "EHLO az0017.srv.az.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753108AbaJ1AJ1 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 27 Oct 2014 20:09:27 -0400
Content-Disposition: inline
In-Reply-To: <20141027235942.GY27405@n2100.arm.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-serial@vger.kernel.org, jslaby@suse.cz, gregkh@linuxfoundation.org

On Mon, Oct 27, 2014 at 11:59:42PM +0000, Russell King - ARM Linux wrot=
e:
> On Tue, Oct 28, 2014 at 12:44:31AM +0100, Piotr Kr=F3l wrote:
> > Hi all,
> > according to BCM2835 ARM Peripherals spec DMA is optional functiona=
lity
> > for ARM PL011 UART and it is not supported on this SoC. It looks li=
ke
> > amba-pl011 search for device tree property (dma-names) unconditiona=
lly,
> > what leads to error message:
> >=20
> > of_dma_request_slave_channel: dma-names property of node '/soc/uart=
@7e201000' missing or empty
> > uart-pl011 20201000.uart: no DMA platform data
> >=20
> > I assume that if it is possible that amba-pl011 can be without DMA =
we
> > should check if DMA is supported and then try to read properties. I=
s
> > there any known method for checking dma support ? If yes that I wou=
ld be
> > glad for any pointers.
> >=20
> > Let me know if I should ignore/accept this error message or there i=
s
> > some code fix needed.
>=20
> A great many implementations of PL011 do not have DMA support (some h=
ave
> DMA support but its well broken.)  The driver has always supported PI=
O
> mode, and continues to do so.
>=20

Driver works fine but IMHO this error message confuse user. Should I as=
sume
that error message is expected and we should not avoid it by trying to
check if DMA is supported ?

BTW above error message do not indicate that DMA is not supported but
indicates that something is wrong with DT, what in this case is not tru=
e.

Thanks,
Piotr Kr=F3l


--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
