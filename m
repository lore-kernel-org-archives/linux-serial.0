From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/2] serial: samsung: Move uart_register_driver call to
 device probe
Date: Fri, 24 Jan 2014 14:38:59 +0000
Message-ID: <20140124143859.70e0e610@www.etchedpixels.co.uk>
References: <1390208555-27770-2-git-send-email-tushar.behera@linaro.org>
	<20140120100530.GY15937@n2100.arm.linux.org.uk>
	<CAHbNUh3m=uNybv=3yxmr2on=Cc0UuGrYP8zf3GMR-9RQZ394dg@mail.gmail.com>
	<20140123180423.1a62611a@www.etchedpixels.co.uk>
	<20140123184022.GC11727@sirena.org.uk>
	<52E163DC.1090002@samsung.com>
	<20140123193633.GG11727@sirena.org.uk>
	<20140123195144.2d3aa44d@www.etchedpixels.co.uk>
	<20140123200509.GO11727@sirena.org.uk>
	<20140123213321.372ce82b@www.etchedpixels.co.uk>
	<20140124120309.GU11727@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20140124120309.GU11727@sirena.org.uk>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Tomasz Figa <t.figa@samsung.com>, Tushar Behera <tushar.behera@linaro.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, lkml <linux-kernel@vger.kernel.org>, linux-serial <linux-serial@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, jslaby <jslaby@suse.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ben Dooks <ben.dooks@codethink.co.uk>
List-Id: linux-serial@vger.kernel.org

On Fri, 24 Jan 2014 12:03:09 +0000
Mark Brown <broonie@kernel.org> wrote:

> On Thu, Jan 23, 2014 at 09:33:21PM +0000, Alan Cox wrote:
> > Mark Brown <broonie@kernel.org> wrote:
> 
> > > I don't see how we can meaningfully test this on a platform - the kernel
> > > would have to be pretty demented to care, it's userspace that cares and
> > > that's not really tied to individual serial drivers but is where we
> > > mainly need coverage.
> 
> > Which is why I think we want to enable it gradually and platform by
> > platform as that platform or arch maintainer judges it appropriate given
> > their knowledge of their platform(s).
> 
> I don't see how that follows?  For the most part architecture
> maintainers aren't going to be able to say too much about which
> userspaces are being run on their platforms if the architecture
> has any kind of widespread use.

For most architectures I suspect that they do have a pretty good idea.
ARM is a bit different but I imagine the various platform specific
maintainers are the ones who have that knowledge

Alan
