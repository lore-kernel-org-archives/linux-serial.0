From: =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>
Subject: Re: [PATCH RFC 3/6] tty: Rename xilinx_uart -> cadence_uart
Date: Wed, 5 Mar 2014 10:22:05 -0800
Message-ID: <0c95ba9c-30bd-4fb2-ae44-e0e3e4553e84@CO9EHSMHS018.ehs.local>
References: <1393953449-28551-1-git-send-email-soren.brinkmann@xilinx.com>
 <1393953449-28551-4-git-send-email-soren.brinkmann@xilinx.com>
 <20140304193913.71c6f307@alan.etchedpixels.co.uk>
 <201403042316.26221.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from co9ehsobe005.messaging.microsoft.com ([207.46.163.28]:4458 "EHLO
	co9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752221AbaCESWx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 5 Mar 2014 13:22:53 -0500
Content-Disposition: inline
In-Reply-To: <201403042316.26221.arnd@arndb.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Michal Simek <michal.simek@xilinx.com>, Peter Crosthwaite <peter.crosthwaite@xilinx.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, Olof Johansson <olof@lixom.net>, Kevin Hilman <khilman@linaro.org>

Hi Arnd, Alan,

On Tue, 2014-03-04 at 11:16PM +0100, Arnd Bergmann wrote:
> On Tuesday 04 March 2014, One Thousand Gnomes wrote:
> > On Tue,  4 Mar 2014 09:17:26 -0800
> > Soren Brinkmann <soren.brinkmann@xilinx.com> wrote:
>=20
> > The following aspects of the change set are IMHO acceptable
> >=20
> > - Cleaning up all the code formatting
> > - Update the driver comments and header to explain the Cadence/Xili=
nx
> >   thing
> > - change "Xilinx PS UART Support" text to "Cadence (Xilinx PS) Supp=
ort"
> >   or similar wording in Kconfig
> > - Adding the cadence devicetree compatibility strings and inputs *i=
n
> >   addition* to the existing ones.
> > - Documentation for the new options
>=20
> I agree. I think it would also be nice to allow the standard clock na=
mes
> to be used as an alternative to the bogus ref_clk" and "aper_clk"
> names, but just like the compatible string, it's too late to remove
> support for the existing ones.
>=20
> Regarding the "xlnx,xuartps" compatible string, even if we were to br=
eak
> backwards comptibility with the clocks, I would still want to see thi=
s
> string being used in addition to "cdns,uart-r1p8" so we have a way to
> detect possible changes that xilinx did on top of the r1p8 version.
> I also wonder if "cdns,uart-r1p8" is actually specific enough: r1p8
> looks like a version number rather than a name, and it seems possible
> that Cadence has produced more than one uart implemention in the past
> or will do another one in the future that is not just a different
> revision of this one but instead something completely different.

This was pretty much what I expected, but I wanted to at least try,
before documenting the binding.

So, to summarize:
 - don't rename the file
 - I think changing the Kconfig option might be possible, but doesn't
   really matter either. So, I'll leave it as is.
 - compat strings is the easy part, we can simple add another one
 - clock-names is not that forgiving. I'm inclined to document only the
   Cadence names, but allow both with issuing a deprecated warning when
   the Zynq ones are used. Then we can remove those probably a little
   later(?)
 - I'll do something like Alan's suggestion for the Kconfig prompt

Regarding how specific we can make the compat string: I asked myself th=
e
same question when I looked at the docs. But they don't seem to use any
fancy names or anything. It's pretty much just a UART. The other proble=
m
I have is, I'd have to double check what information, beyond what alrea=
dy
is in the Zynq TRM, is allowed to be disclosed.

	Thanks,
	S=C3=B6ren


--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
