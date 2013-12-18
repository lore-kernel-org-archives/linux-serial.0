From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] tty: xuartps: Fix build when SYSRQ is disabled
Date: Tue, 17 Dec 2013 16:01:17 -0800
Message-ID: <20131218000117.GA21915@kroah.com>
References: <1387322858-5111-1-git-send-email-broonie@kernel.org>
 <20131217234744.GB21329@kroah.com>
 <3cc3bceb-93a4-4053-bbde-0aa3c2eebe1c@VA3EHSMHS043.ehs.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:56474 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750950Ab3LRABQ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 17 Dec 2013 19:01:16 -0500
Content-Disposition: inline
In-Reply-To: <3cc3bceb-93a4-4053-bbde-0aa3c2eebe1c@VA3EHSMHS043.ehs.local>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: S??ren Brinkmann <soren.brinkmann@xilinx.com>
Cc: Mark Brown <broonie@kernel.org>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>

On Tue, Dec 17, 2013 at 03:53:14PM -0800, S??ren Brinkmann wrote:
> Hi Greg, Mark,
> 
> On Tue, Dec 17, 2013 at 03:47:44PM -0800, Greg Kroah-Hartman wrote:
> > On Tue, Dec 17, 2013 at 11:27:38PM +0000, Mark Brown wrote:
> > > From: Mark Brown <broonie@linaro.org>
> > > 
> > > The sysrq field in struct uart_port is only defined when
> > > SERIAL_CORE_CONSOLE or SUPPORT_SYSRQ are selected but the driver uses
> > > the field unconditionally, causing build failures if they aren't (as
> > > happens when doing an arm64 allmodconfig).  Make the usage conditional
> > > as well.
> > > 
> > > Signed-off-by: Mark Brown <broonie@linaro.org>
> > > ---
> > >  drivers/tty/serial/xilinx_uartps.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > 
> > Is this a 3.13-final fix, or can it wait for 3.14?
> 
> I sent out pretty much the same fix a week ago:
> https://lkml.org/lkml/2013/12/2/694

ah, sorry, missed that one somehow.  I'll go queue this up...

greg k-h
