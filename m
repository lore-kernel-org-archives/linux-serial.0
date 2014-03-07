From: =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>
Subject: Re: [PATCH RFC v2 08/11] tty: xuartps: Rename Kconfig symbols
Date: Fri, 7 Mar 2014 14:59:04 -0800
Message-ID: <a588bea6-d402-4a87-ada0-cdf13f13ba59@CH1EHSMHS033.ehs.local>
References: <1394219614-3197-1-git-send-email-soren.brinkmann@xilinx.com>
 <1394219614-3197-9-git-send-email-soren.brinkmann@xilinx.com>
 <20140307213058.702ff194@alan.etchedpixels.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from ch1ehsobe005.messaging.microsoft.com ([216.32.181.185]:48405
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753810AbaCGW7K convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 7 Mar 2014 17:59:10 -0500
Content-Disposition: inline
In-Reply-To: <20140307213058.702ff194@alan.etchedpixels.co.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Arnd Bergmann <arnd@arndb.de>, Michal Simek <michal.simek@xilinx.com>, Peter Crosthwaite <peter.crosthwaite@xilinx.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org

On Fri, 2014-03-07 at 09:30PM +0000, One Thousand Gnomes wrote:
> On Fri,  7 Mar 2014 11:13:31 -0800
> Soren Brinkmann <soren.brinkmann@xilinx.com> wrote:
>=20
> > Rename the config symbols for the Cadence UART to reflect the drive=
r
> > rebranding:
> >   SERIAL_XILINX_PS_UART(_CONSOLE) -> SERIAL_CADENCE_UART(_CONSOLE)
>=20
> This breaks all those setups people have with pre-packed .config file=
s
> that have worked for a long time and now randomly need changing for t=
his
> kernel.

And this will be dropped as well.

	Thanks,
	S=C3=B6ren


--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
