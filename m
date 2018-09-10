From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [GIT PULL] Immutable branch between MFD, SPI and TTY due for the
 v4.20 merge window
Date: Mon, 10 Sep 2018 17:59:17 +0200
Message-ID: <20180910155917.GB17956@kroah.com>
References: <20180713164736.26028-1-radu.pirea@microchip.com>
 <20180910151803.GX28860@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180910151803.GX28860@dell>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Radu Pirea <radu.pirea@microchip.com>, broonie@kernel.org, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, richard.genoud@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Mon, Sep 10, 2018 at 04:18:03PM +0100, Lee Jones wrote:
> Enjoy!
> 
> The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:
> 
>   Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/ib-mfd-spi-tty-v4.20
> 
> for you to fetch changes up to c24d25317a7c6bb3053d4c193b3cf57d1e9a3e4b:
> 
>   tty/serial: atmel: Change the driver to work under at91-usart MFD (2018-09-10 16:12:43 +0100)

thanks for this.  I'll suck it into my tty-next branch to make it easier
for any future at91 serial driver changes to be simpler to merge.

greg k-h
