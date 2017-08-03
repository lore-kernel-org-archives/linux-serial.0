From: Sean Wang <sean.wang@mediatek.com>
Subject: Re: [PATCH 0/2] serial: 8250: add support for MediaTek BTIF controller
Date: Thu, 3 Aug 2017 11:18:11 +0800
Message-ID: <1501730291.21633.12.camel@mtkswgap22>
References: <cover.1501692369.git.sean.wang@mediatek.com>
 <1501694063.29303.361.camel@linux.intel.com>
 <1501695470.25246.7.camel@mtkswgap22>
 <1501696935.29303.367.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1501696935.29303.367.camel@linux.intel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: devicetree@vger.kernel.org, heikki.krogerus@linux.intel.com, vigneshr@ti.com, gregkh@linuxfoundation.org, jslaby@suse.com, hpeter@gmail.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org, linux-mediatek@lists.infradead.org, linux-serial@vger.kernel.org, jan.kiszka@siemens.com, matthias.bgg@gmail.com, "arnd.bergmann" <arnd.bergmann@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Wed, 2017-08-02 at 21:02 +0300, Andy Shevchenko wrote:
> On Thu, 2017-08-03 at 01:37 +0800, Sean Wang wrote:
> > On Wed, 2017-08-02 at 20:14 +0300, Andy Shevchenko wrote:
> > > On Thu, 2017-08-03 at 01:05 +0800, sean.wang@mediatek.com wrote:
> > > > From: Sean Wang <sean.wang@mediatek.com>
> > > > 
> > > > This patchset introduces the support for MediaTek BTIF controller.
> > > > 
> > > > MediaTek BTIF controller is the serial interface similar to UART
> > > > but
> > > > it
> > > > works only as the digital device which is mainly used to
> > > > communicate
> > > > with
> > > > the connectivity module also called CONNSYS inside the SoC which
> > > > could
> > > > be
> > > > mostly found on those MediaTek SoCs with Bluetooth feature.
> > > > 
> > > > And the controller is made as being compatible with the 8250
> > > > register
> > > > layout so it tends to be integrated with existing 8250 core driver
> > > > and
> > > > have no requirement for the modem configuration additionally such
> > > > as
> > > > the
> > > > baud rate calculation and assignment.
> 
> +Cc: Arnd.
> 
> > > Why it requires a separate driver?
> > > 
> > > 8250_of is for DT enabled drivers.
> > > 
> > 
> > Hi, Andy
> > 
> > thanks for your information
> > 
> > the hardware is not completely identical to 8250 device, 
> > it has extra registers belonged to platform control such as internal
> > loopback, dma disable/enable, sleep/wakeup setup and so on, so I
> > create
> > it as a separate driver.
> 
> Over all 200+ LOCs I didn't see any of the above except loopback, which
> is one property that can be easily added to 8250_of.c.
> 
> Moreover, if you have more code coming I would suggest you to split
> 8250_of to library and driver parts and re-use stuff from there.
> 
> Arnd, what is your opinion about new 8250 OF based drivers?
> 

Hi, Andy

many thanks for the detailed guidance.
I will turn into reusing 8250 OF stuff in the next version and look
forward to any idea from Arnd how to do with 8250 OF driver to add
specific programming/data for those devices using 8250 OF.

	Sean
