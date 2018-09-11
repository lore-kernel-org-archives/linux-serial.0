From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [GIT PULL] Immutable branch between MFD, SPI and TTY due for the
 v4.20 merge window
Date: Tue, 11 Sep 2018 10:44:30 +0100
Message-ID: <20180911094430.GG4185@dell>
References: <20180713164736.26028-1-radu.pirea@microchip.com>
 <20180910151803.GX28860@dell>
 <20180911084548.GC4185@dell>
 <20180911090132.GB25161@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180911090132.GB25161@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Radu Pirea <radu.pirea@microchip.com>, broonie@kernel.org, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, richard.genoud@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Tue, 11 Sep 2018, Greg KH wrote:

> On Tue, Sep 11, 2018 at 09:45:48AM +0100, Lee Jones wrote:
> > On Mon, 10 Sep 2018, Lee Jones wrote:
> > 
> > > Enjoy!
> > > 
> > > The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:
> > > 
> > >   Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)
> > > 
> > > are available in the Git repository at:
> > > 
> > >   git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/ib-mfd-spi-tty-v4.20
> > > 
> > > for you to fetch changes up to c24d25317a7c6bb3053d4c193b3cf57d1e9a3e4b:
> > > 
> > >   tty/serial: atmel: Change the driver to work under at91-usart MFD (2018-09-10 16:12:43 +0100)
> > > 
> > > ----------------------------------------------------------------
> > > Immutable branch between MFD, SPI and TTY due for the v4.20 merge window
> > 
> > Due to a comedy of errors, I'm voiding this pull-request.
> 
> Um, I can't do that as my tree can not be rebased :(

Oh dear. :(

> I can take follow-on patches, so I will go apply the patch posted so
> that my tree builds again.  I recommend you just apply it as well.

What a pickle.  As per my last email, it looks as though this set was
applied under false pretences.  The MFD patch which was carrying my
Ack was doing so incorrectly.  The author mistakenly applied it to the
wrong patch.  After re-review (actually initial review) I wish to NACK
the implementation.

My suggestion would be to sit tight, rather than do anything rash and
see how this plays out.  After which we can fix your tree.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
