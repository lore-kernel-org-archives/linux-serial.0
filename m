From: =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>
Subject: Re: [PATCH] tty: xuartps: Fix build when SYSRQ is disabled
Date: Tue, 17 Dec 2013 15:53:14 -0800
Message-ID: <3cc3bceb-93a4-4053-bbde-0aa3c2eebe1c@VA3EHSMHS043.ehs.local>
References: <1387322858-5111-1-git-send-email-broonie@kernel.org>
 <20131217234744.GB21329@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from va3ehsobe002.messaging.microsoft.com ([216.32.180.12]:10830
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751151Ab3LQXxU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 17 Dec 2013 18:53:20 -0500
Content-Disposition: inline
In-Reply-To: <20131217234744.GB21329@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Mark Brown <broonie@kernel.org>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>

Hi Greg, Mark,

On Tue, Dec 17, 2013 at 03:47:44PM -0800, Greg Kroah-Hartman wrote:
> On Tue, Dec 17, 2013 at 11:27:38PM +0000, Mark Brown wrote:
> > From: Mark Brown <broonie@linaro.org>
> >=20
> > The sysrq field in struct uart_port is only defined when
> > SERIAL_CORE_CONSOLE or SUPPORT_SYSRQ are selected but the driver us=
es
> > the field unconditionally, causing build failures if they aren't (a=
s
> > happens when doing an arm64 allmodconfig).  Make the usage conditio=
nal
> > as well.
> >=20
> > Signed-off-by: Mark Brown <broonie@linaro.org>
> > ---
> >  drivers/tty/serial/xilinx_uartps.c | 2 ++
> >  1 file changed, 2 insertions(+)
>=20
> Is this a 3.13-final fix, or can it wait for 3.14?

I sent out pretty much the same fix a week ago:
https://lkml.org/lkml/2013/12/2/694

It seems to fix a broken build for certain configurations. Hence, I'd
say it's a fix for 3.13.

	S=C3=B6ren


--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
