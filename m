From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v6 00/12] Earlycon cleanup
Date: Sat, 6 Feb 2016 22:08:45 -0800
Message-ID: <20160207060845.GA26035@kroah.com>
References: <1452980244-20512-1-git-send-email-peter@hurleysoftware.com>
 <1452986629-17210-1-git-send-email-peter@hurleysoftware.com>
 <56B4693C.8070301@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56B4693C.8070301@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Peter Hurley <peter@hurleysoftware.com>, Rob Herring <robh@kernel.org>, Grant Likely <grant.likely@linaro.org>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Kevin Cernekee <cernekee@gmail.com>, Paul Burton <paul.burton@imgtec.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Sebastian Frias <sf84@laposte.net>
List-Id: linux-serial@vger.kernel.org

On Fri, Feb 05, 2016 at 09:19:56AM +0000, Jon Hunter wrote:
> Hi all,
> 
> On 16/01/16 23:23, Peter Hurley wrote:
> > Hi Greg, Grant & Rob,
> > 
> > This patch series is a rebase of the v3 from April last year.
> > 
> > This patch series builds on my earlier "Extensible console matching &
> > direct earlycon" to add several useful features to earlycon:
> > * Proper port i/o configuration from DT node with of_serial properties
> >   (such as reg-io-width, reg-shift and reg-offset, and endianness)
> > * Proper console name & index initialization from earlycon name
> >   (for both command line and DT-defined earlycons)
> > * Support for DT 'stdout-path' options pass-through to earlycon setup
> > * Improved log messages for troubleshooting
> > * Support for multiple OF earlycon declarations so different
> >   compatible strings can specify the same OF earlycon
> 
> I just wanted to check the status of this series. I have not seen it
> appear in -next yet. I was waiting for this to get merged so that I can
> enable earlycon via DT for Tegra.

Now in my testing branch, if all goes well, will show up in -next in a
few days.

thanks,

greg k-h
