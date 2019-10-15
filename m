From: Jakub Kicinski <jakub.kicinski@netronome.com>
Subject: Re: [PATCH v10 4/6] mfd: ioc3: Add driver for SGI IOC3 chip
Date: Tue, 15 Oct 2019 12:23:49 -0700
Message-ID: <20191015122349.612a230b@cakuba.netronome.com>
References: <20191015120953.2597-1-tbogendoerfer@suse.de>
        <20191015120953.2597-5-tbogendoerfer@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20191015120953.2597-5-tbogendoerfer@suse.de>
Sender: netdev-owner@vger.kernel.org
To: Thomas Bogendoerfer <tbogendoerfer@suse.de>
Cc: Jonathan Corbet <corbet@lwn.net>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Lee Jones <lee.jones@linaro.org>, "David S. Miller" <davem@davemloft.net>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, netdev@vger.kernel.org, linux-rtc@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Tue, 15 Oct 2019 14:09:49 +0200, Thomas Bogendoerfer wrote:
> SGI IOC3 chip has integrated ethernet, keyboard and mouse interface.
> It also supports connecting a SuperIO chip for serial and parallel
> interfaces. IOC3 is used inside various SGI systemboards and add-on
> cards with different equipped external interfaces.
> 
> Support for ethernet and serial interfaces were implemented inside
> the network driver. This patchset moves out the not network related
> parts to a new MFD driver, which takes care of card detection,
> setup of platform devices and interrupt distribution for the subdevices.
> 
> Serial portion: Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> 
> Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>

Looks good, I think.
