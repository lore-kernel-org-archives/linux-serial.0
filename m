From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v10 4/6] mfd: ioc3: Add driver for SGI IOC3 chip
Date: Wed, 16 Oct 2019 07:18:56 +0100
Message-ID: <20191016061856.GA4365@dell>
References: <20191015120953.2597-1-tbogendoerfer@suse.de>
 <20191015120953.2597-5-tbogendoerfer@suse.de>
 <20191015122349.612a230b@cakuba.netronome.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191015122349.612a230b@cakuba.netronome.com>
Sender: netdev-owner@vger.kernel.org
To: Jakub Kicinski <jakub.kicinski@netronome.com>
Cc: Thomas Bogendoerfer <tbogendoerfer@suse.de>, Jonathan Corbet <corbet@lwn.net>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, "David S. Miller" <davem@davemloft.net>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, netdev@vger.kernel.org, linux-rtc@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Tue, 15 Oct 2019, Jakub Kicinski wrote:

> On Tue, 15 Oct 2019 14:09:49 +0200, Thomas Bogendoerfer wrote:
> > SGI IOC3 chip has integrated ethernet, keyboard and mouse interface.
> > It also supports connecting a SuperIO chip for serial and parallel
> > interfaces. IOC3 is used inside various SGI systemboards and add-on
> > cards with different equipped external interfaces.
> > 
> > Support for ethernet and serial interfaces were implemented inside
> > the network driver. This patchset moves out the not network related
> > parts to a new MFD driver, which takes care of card detection,
> > setup of platform devices and interrupt distribution for the subdevices.
> > 
> > Serial portion: Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> > 
> > Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
> 
> Looks good, I think.

Is that a Reviewed-by?

If so, it doesn't sound like a very convincing one?

If not, it's probably not worth replying at all.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
