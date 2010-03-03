From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH v5] serial: spi: add spi-uart driver for Maxim 3110
Date: Tue, 2 Mar 2010 23:25:52 -0800
Message-ID: <201003022325.52315.david-b@pacbell.net>
References: <20091229222006.1ddb28a4@feng-desktop> <201003022216.08888.david-b@pacbell.net> <20100303143731.0c009c64@feng-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp108.sbc.mail.gq1.yahoo.com ([67.195.14.111]:42267 "HELO
	smtp108.sbc.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751568Ab0CCHcd (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 3 Mar 2010 02:32:33 -0500
In-Reply-To: <20100303143731.0c009c64@feng-i7>
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Feng Tang <feng.tang@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Greg KH <greg@kroah.com>, spi-devel-list <spi-devel-general@lists.sourceforge.net>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Grant Likely <grant.likely@secretlab.ca>, "alan@lxorguk.ukuu.org.uk" <alan@lxorguk.ukuu.org.uk>

On Tuesday 02 March 2010, Feng Tang wrote:
> > > Here comes another idea, can we add a capability flag in struct
> > > spi_master indicating the master supporting poll or dma or both.
> > > Also we add similar bits in struct spi_transfer indicating the th=
is
> > > transfer wants to be handled in poll or dma mode.
> >=20
> > Let's not do either of those. =A0There's no need to introduce such
> > complexity, or to enable the associated new failure modes and bugs.
>=20
> This idea has nothing to do with the dma-safe problem you pointed out=
,

Your comment has nothing to do with my response.  Are you implying that
your suggestions do *NOT* introduce complexity, including new failure
modes and thus the possibility of new confusing types of bugs?


> I will=20
> make the buffer dma safe anyway.

Good ...

=20
> What I proposed just wants to provide some flexibility for protocol d=
evice
> drivers, it will use dma-safe buffer always, but it prefer not to use=
 DMA
> for its one-word transfers,

That kind of heuristic is something the SPI controller driver could
already apply if it's a good tradeoff on that hardware.  (Considering
also the extra added complexity, failure modes, and potential for new
flavors of bug...)

Of course, drivers like the max3110 are high enough in the driver
stack that they can only guess about such tradeoffs.  (And thus
most drivers will likely guess wrong...)


> and hope to have a choice to do that. For current=20
> existing controller and device drivers, they can simply ignore the ne=
w=20
> working mode setting in struct spi_master and spi_transfer and leave =
them
> as 0.

If someone decided to update a SPI controller driver to avoid DMA in
some cases, in favor of PIO, they could already code such heuristics
without needing your proposed hinting from upper layers.

The result in the low-level driver would be just to use a different
test (maybe "is this a one-word transfer?" instead of checking your
per-transfer "use PIO?" hint) before kicking in whatever logic you
think would improve performance (by eliminating DMA setup and teardown
costs, including cache cleaning).

- Dave

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
