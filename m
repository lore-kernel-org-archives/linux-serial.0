From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH v4] serial: spi: add spi-uart driver for Maxim 3110
Date: Fri, 26 Feb 2010 11:41:42 -0800
Message-ID: <201002261141.43002.david-b@pacbell.net>
References: <20100224131130.61530b62@feng-i7> <20100226114729.679bb933@feng-i7> <201002260959.o1Q9xIVA021953@imail.sm.sony.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp125.sbc.mail.sp1.yahoo.com ([69.147.65.184]:42073 "HELO
	smtp125.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S965843Ab0BZTlo (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 26 Feb 2010 14:41:44 -0500
In-Reply-To: <201002260959.o1Q9xIVA021953@imail.sm.sony.co.jp>
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Masakazu Mokuno <mokuno@sm.sony.co.jp>
Cc: Feng Tang <feng.tang@intel.com>, Greg KH <greg@kroah.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, spi-devel-list <spi-devel-general@lists.sourceforge.net>, Andrew Morton <akpm@linux-foundation.org>, "alan@lxorguk.ukuu.org.uk" <alan@lxorguk.ukuu.org.uk>

On Friday 26 February 2010, Masakazu Mokuno wrote:
> > +static int max3110_read_multi(struct uart_max3110 *max, u8 *buf)
> > +{
> > +=A0=A0=A0=A0=A0u16 obuf[M3110_RX_FIFO_DEPTH], ibuf[M3110_RX_FIFO_D=
EPTH];
>=20
> Doing I/O on stack is guaranteed safe for spi functions?

Good catch ...  no it's not safe.

No DMA-enabled programming interface allows it, including SPI.

The Documentation/PCI/PCI-DMA-mapping.txt file has a section with
the oddly punctuated title "What memory is DMA'able?".  That's
generic to all uses of DMA.  When it was moved to the PCI area,
that information became harder to find ... but no less true for
non-PCI contexts (sigh).  One relevant paragraph being:

  This rule also means that you may use neither kernel image addresses
  (items in data/text/bss segments), nor module image addresses, nor
  stack addresses for DMA.  These could all be mapped somewhere entirel=
y
  different than the rest of physical memory.  Even if those classes of
  memory could physically work with DMA, you'd need to ensure the I/O
  buffers were cacheline-aligned.  Without that, you'd see cacheline
  sharing problems (data corruption) on CPUs with DMA-incoherent caches=
=2E
  (The CPU could write to one word, DMA would write to a different one
  in the same cache line, and one of them could be overwritten.)

Those cacheline sharing problems are particularly bad for the stack,
since the data corruption often includes return addresses.

In short, passing a stack-based I/O buffer could work on some machines,
but cause perplexing data corruption issues on others.  So don't try
to do it any driver that claims to be portable.

- Dave

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
