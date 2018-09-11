From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [GIT PULL v2] Immutable branch between MFD, SPI and TTY due for
 the v4.20 merge window
Date: Tue, 11 Sep 2018 16:12:49 +0200
Message-ID: <20180911141249.GA19639@kroah.com>
References: <20180904111310.4049-1-radu_nicolae.pirea@upb.ro>
 <20180911111850.GJ4185@dell>
 <20180911140400.GB18410@kroah.com>
 <20180911140733.GU4185@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180911140733.GU4185@dell>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Radu Pirea <radu_nicolae.pirea@upb.ro>, robh+dt@kernel.org, mark.rutland@arm.com, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, broonie@kernel.org, jslaby@suse.com, richard.genoud@gmail.com, davem@davemloft.net, mchehab+samsung@kernel.org, akpm@linux-foundation.org, arnd@arndb.de, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-spi@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Tue, Sep 11, 2018 at 03:07:33PM +0100, Lee Jones wrote:
> On Tue, 11 Sep 2018, Greg KH wrote:
> 
> > On Tue, Sep 11, 2018 at 12:18:50PM +0100, Lee Jones wrote:
> > > [In case you missed it]
> > > 
> > > This new pull-request contains the following changes since v1:
> > > 
> > >  - Uplift the submission version from v11 to v12
> > >  - Include fix for build breakage due to missing Device Tree include file
> > > 
> > > Since it is based on the original pull-request, it can be pulled
> > > in either directly on top of it or as a pull in its own right.
> > > 
> > > The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:
> > > 
> > >   Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)
> > > 
> > > are available in the Git repository at:
> > > 
> > >   git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/ib-mfd-spi-tty-v4.20-1
> > 
> > Ok, let's try this again, I've dropped that other patch and taken this
> > branch into my tree.
> 
> What happened to not rebasing? :D

Turned out I hadn't pushed to my immutable branch yet, we got lucky :)
