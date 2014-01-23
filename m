From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/2] serial: samsung: Move uart_register_driver call to
 device probe
Date: Thu, 23 Jan 2014 21:33:21 +0000
Message-ID: <20140123213321.372ce82b@www.etchedpixels.co.uk>
References: <1390208555-27770-1-git-send-email-tushar.behera@linaro.org>
	<1390208555-27770-2-git-send-email-tushar.behera@linaro.org>
	<20140120100530.GY15937@n2100.arm.linux.org.uk>
	<CAHbNUh3m=uNybv=3yxmr2on=Cc0UuGrYP8zf3GMR-9RQZ394dg@mail.gmail.com>
	<20140123180423.1a62611a@www.etchedpixels.co.uk>
	<20140123184022.GC11727@sirena.org.uk>
	<52E163DC.1090002@samsung.com>
	<20140123193633.GG11727@sirena.org.uk>
	<20140123195144.2d3aa44d@www.etchedpixels.co.uk>
	<20140123200509.GO11727@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:34213 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932078AbaAWVdz (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 23 Jan 2014 16:33:55 -0500
In-Reply-To: <20140123200509.GO11727@sirena.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Tomasz Figa <t.figa@samsung.com>, Tushar Behera <tushar.behera@linaro.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, lkml <linux-kernel@vger.kernel.org>, linux-serial <linux-serial@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, jslaby <jslaby@suse.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ben Dooks <ben.dooks@codethink.co.uk>

On Thu, 23 Jan 2014 20:05:09 +0000
Mark Brown <broonie@kernel.org> wrote:

> On Thu, Jan 23, 2014 at 07:51:44PM +0000, Alan Cox wrote:
> 
> > That strikes me as rather more risky. We can propogate it through the
> > drivers as we are sure it is safe to do so on that platform and encourage
> > driver authors to migrate. Better than a "big bang" and the inevitable
> > fallout.
> 
> I don't see how we can meaningfully test this on a platform - the kernel
> would have to be pretty demented to care, it's userspace that cares and
> that's not really tied to individual serial drivers but is where we
> mainly need coverage.

Which is why I think we want to enable it gradually and platform by
platform as that platform or arch maintainer judges it appropriate given
their knowledge of their platform(s).

Alan
