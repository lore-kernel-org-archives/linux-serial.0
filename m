From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 1/4] tty: serial: Add 8250 earlycon to support noinit
 option
Date: Sun, 1 Feb 2015 21:24:23 -0800
Message-ID: <20150202052423.GA3346@kroah.com>
References: <1421068104-30463-1-git-send-email-eddie.huang@mediatek.com>
 <1421068104-30463-2-git-send-email-eddie.huang@mediatek.com>
 <54CE53F3.5040709@hurleysoftware.com>
 <54CE6FD9.5030606@hurleysoftware.com>
 <1422846994.5512.25.camel@mtksdaap41>
 <54CEF2C8.1050808@hurleysoftware.com>
 <20150202042843.GA24765@kroah.com>
 <54CF07F3.2040100@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <54CF07F3.2040100@hurleysoftware.com>
Sender: linux-doc-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Eddie Huang <eddie.huang@mediatek.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, devicetree@vger.kernel.org, Vladimir Murzin <vladimir.murzin@arm.com>, srv_heupstream@mediatek.com, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Jonathan Corbet <corbet@lwn.net>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, yh.chen@mediatek.com, Howard Chen <ibanezchen@gmail.com>, Ashwin Chaugule <ashwin.chaugule@linaro.org>, linux-serial@vger.kernel.org, Kumar Gala <galak@codeaurora.org>, "Joe.C" <yingjoe.chen@mediatek.com>, Jiri Slaby <jslaby@suse.cz>, linux-arm-kernel@lists.infradead.org, Alan Cox <alan@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

On Mon, Feb 02, 2015 at 12:15:31AM -0500, Peter Hurley wrote:
> On 02/01/2015 11:28 PM, Greg Kroah-Hartman wrote:
> > On Sun, Feb 01, 2015 at 10:45:12PM -0500, Peter Hurley wrote:
> >> On 02/01/2015 10:16 PM, Eddie Huang wrote:
> 
> >> I'll respin proper patches on top of Greg's tty-testing branch with reverts
> >> for the noinit options. I noticed that one of the noinit patches actually
> >> has the linkage for the mtk earlycon, so I'll be sure to preserve that.
> > 
> > I can just drop the patches in the tty-testing branch, that's what it is
> > there for :)
> > 
> > Just let me know the specific patches and I will do so, thanks.
> 
> Well that pretty much means dropping the 3 patches that add earlycon to
> 8250_mtk and then applying my patch (needs fixed to apply cleanly, which
> I can do) and then applying a fixed-up replacement patch to add earlycon
> to 8250_mtk (which I can also supply).
> 
> Is that the way you want to go?

Sounds good to me, send your patch, and I'll fix it all up tomorrow.

thanks,

greg k-h
