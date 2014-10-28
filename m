From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: amba-pl011 complains about DMA for bcm2835 where it is not
 supported
Date: Tue, 28 Oct 2014 00:16:31 +0000
Message-ID: <20141028001631.GA27405@n2100.arm.linux.org.uk>
References: <20141027234430.GA1788@haysend>
 <20141027235942.GY27405@n2100.arm.linux.org.uk>
 <20141028000922.GB1788@haysend>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:46316 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752369AbaJ1AQh (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 27 Oct 2014 20:16:37 -0400
Content-Disposition: inline
In-Reply-To: <20141028000922.GB1788@haysend>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Piotr =?iso-8859-1?Q?Kr=F3l?= <piotr.krol@3mdeb.com>
Cc: linux-serial@vger.kernel.org, jslaby@suse.cz, gregkh@linuxfoundation.org

On Tue, Oct 28, 2014 at 01:09:23AM +0100, Piotr Kr=F3l wrote:
> On Mon, Oct 27, 2014 at 11:59:42PM +0000, Russell King - ARM Linux wr=
ote:
> > On Tue, Oct 28, 2014 at 12:44:31AM +0100, Piotr Kr=F3l wrote:
> > > Hi all,
> > > according to BCM2835 ARM Peripherals spec DMA is optional functio=
nality
> > > for ARM PL011 UART and it is not supported on this SoC. It looks =
like
> > > amba-pl011 search for device tree property (dma-names) unconditio=
nally,
> > > what leads to error message:
> > >=20
> > > of_dma_request_slave_channel: dma-names property of node '/soc/ua=
rt@7e201000' missing or empty
> > > uart-pl011 20201000.uart: no DMA platform data
> > >=20
> > > I assume that if it is possible that amba-pl011 can be without DM=
A we
> > > should check if DMA is supported and then try to read properties.=
 Is
> > > there any known method for checking dma support ? If yes that I w=
ould be
> > > glad for any pointers.
> > >=20
> > > Let me know if I should ignore/accept this error message or there=
 is
> > > some code fix needed.
> >=20
> > A great many implementations of PL011 do not have DMA support (some=
 have
> > DMA support but its well broken.)  The driver has always supported =
PIO
> > mode, and continues to do so.
> >=20
>=20
> Driver works fine but IMHO this error message confuse user. Should I =
assume
> that error message is expected and we should not avoid it by trying t=
o
> check if DMA is supported ?
>=20
> BTW above error message do not indicate that DMA is not supported but
> indicates that something is wrong with DT, what in this case is not t=
rue.

Unfortunately, the DT lobby believe that their way is the only way, and
that drivers should always complain if DT stuff is missing.  They seem
to loose sight of what behaviour an "optional" property should have.
I've seen this happen several times now, and I've commented on patches =
I
saw today which had made driver initialisation /fail/ if various option=
al
properties weren't specified!

--=20
=46TTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
