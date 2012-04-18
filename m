From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v4 2/3] serial/8250_pci: Clear FIFOs for Intel ME Serial
 Over Lan device on BI
Date: Wed, 18 Apr 2012 16:00:07 -0700
Message-ID: <20120418230007.GA9329@kroah.com>
References: <20120410210438.13805.40525.stgit@dwillia2-linux.jf.intel.com>
 <20120410211058.13805.75833.stgit@dwillia2-linux.jf.intel.com>
 <20120418221207.GA4489@kroah.com>
 <CABE8wwvw1R_ObcjGLfPXhGLq1g1H54QTRZf2Y-E3XHYg+v=APg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pz0-f52.google.com ([209.85.210.52]:45869 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752799Ab2DRXAL (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 18 Apr 2012 19:00:11 -0400
Received: by dake40 with SMTP id e40so10489168dak.11
        for <linux-serial@vger.kernel.org>; Wed, 18 Apr 2012 16:00:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CABE8wwvw1R_ObcjGLfPXhGLq1g1H54QTRZf2Y-E3XHYg+v=APg@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: Sudhakar Mamillapalli <sudhakar@fb.com>, Nhan H Mai <nhan.h.mai@intel.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Alan Cox <alan@linux.intel.com>

On Wed, Apr 18, 2012 at 03:36:40PM -0700, Dan Williams wrote:
> On Wed, Apr 18, 2012 at 3:12 PM, Greg KH <gregkh@linuxfoundation.org>=
 wrote:
> > On Tue, Apr 10, 2012 at 02:10:58PM -0700, Dan Williams wrote:
> >> From: Sudhakar Mamillapalli <sudhakar@fb.com>
> >>
> >> When using Serial Over Lan (SOL) over the virtual serial port in a=
 Intel
> >> management engine (ME) device, on device reset the serial FIFOs ne=
ed to
> >> be cleared to keep the FIFO indexes in-sync between the host and t=
he
> >> engine.
> >>
> >> On a reset the serial device assertes BI, so using that as a cue F=
IFOs
> >> are cleared. =A0So for this purpose a new handle_break callback ha=
s been
> >> added. =A0One other problem is that the serial registers might tem=
porarily
> >> go to 0 on reset of this device. =A0So instead of using the IER re=
gister
> >> read, if 0 returned use the ier value in uart_8250_port. This is h=
idden
> >> under a custom serial_in.
> >>
> >> Cc: Nhan H Mai <nhan.h.mai@intel.com>
> >> Signed-off-by: Sudhakar Mamillapalli <sudhakar@fb.com>
> >> Acked-by: Alan Cox <alan@linux.intel.com>
> >> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> >
> > What tree did you make this against?
> >
> > It fails with:
> > patching file drivers/tty/serial/8250/8250.c
> > patching file drivers/tty/serial/8250/8250.h
> > patching file drivers/tty/serial/8250/8250_pci.c
> > Hunk #2 FAILED at 1093.
> > 1 out of 2 hunks FAILED -- saving rejects to file drivers/tty/seria=
l/8250/8250_pci.c.rej
> >
> > While that file hasn't been changed since it was moved to that loca=
tion.
> >
> > Any ideas?
>=20
> Hmm, I think this is because this patch depends on the reverts went
> into 3.4 via tty-linus.

Ah, ok, that makes more sense, let me go merge 3.4-rc3 into tty-next an=
d
see if that solves the problem...

Yup, it did, thanks, I'll go apply these two patches now, sorry for the
noise.

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
