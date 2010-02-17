From: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC][PATCH v2] serial: spi: add spi-uart
	driver for Maxim 3110
Date: Wed, 17 Feb 2010 14:58:17 -0800
Message-ID: <20100217225817.GD31557@kroah.com>
References: <20091229222006.1ddb28a4@feng-desktop>
	<20100208165946.0e4dde83@feng-i7>
	<20100208162010.b1f69728.akpm@linux-foundation.org>
	<fa686aa41002081626i24caff52n15f140d0fffadedd@mail.gmail.com>
	<20100209093644.2dead2d9@feng-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20100209093644.2dead2d9@feng-i7>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, spi-devel-list <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, "alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org" <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On Tue, Feb 09, 2010 at 09:36:44AM +0800, Feng Tang wrote:
> On Tue, 9 Feb 2010 08:26:35 +0800
> Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org> wrote:
> =

> > On Mon, Feb 8, 2010 at 5:20 PM, Andrew Morton
> > <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org> wrote:
> > > On Mon, 8 Feb 2010 16:59:46 +0800
> > > Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
> > >
> > >> Hi All,
> > >>
> > >> Here is a driver for Maxim 3110 SPI-UART device, please help to
> > >> review.
> > >>
> > >> It has been validated with Designware SPI controller (drivers/spi:
> > >> dw_spi.c & dw_spi_pci.c). It supports polling and IRQ mode,
> > >> supports batch read, and provides a console.
> > >>
> =

> > > I wonder if this is an "spi" subsystem thing or a "serial" subsystem
> > > thing. =A0It looks more like a serial driver to me.
> > =

> > I'm assuming serial; and hence I haven't picked it up into my tree.
> > =

> > g.
> =

> Yes, it's more related to serial stuff, and thus I put them into
> drivers/serial

That's fine.  Care to address Andrew's issues and resend the patch?

thanks,

greg k-h

---------------------------------------------------------------------------=
---
Download Intel&reg; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs =

proactively, and fine-tune applications for parallel performance. =

See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
