From: Yao Yuan <yao.yuan@freescale.com>
Subject: RE: [PATCH] the eDMA support for the LPUART send driver
Date: Tue, 7 Jan 2014 06:32:02 +0000
Message-ID: <0602455564214ab7986348ea985fc820@BL2PR03MB338.namprd03.prod.outlook.com>
References: <1388143449-28640-1-git-send-email-yao.yuan@freescale.com>
 <201401051544.50036.arnd@arndb.de>
 <20140105145031.GB27432@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20140105145031.GB27432@n2100.arm.linux.org.uk>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Arnd Bergmann <arnd@arndb.de>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Thanks for your suggestion. It's important for me.

I read the source code for dma_map_single again. I found that both of them(as first argument is dma or uart) worked well. But in my code I found that the *sport->port.dev->dma_mask is not zero. By contrast the dma_mask for dma device is zero.
You are right. There should be dma device. But I also have a doubt here. Why I find many other driver use the first argument here rather than the dma device pointer.
They usually use the device like uart. 


-----Original Message-----
From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk] 
Sent: Sunday, January 05, 2014 10:51 PM
To: Yuan Yao-B46683
Cc: Arnd Bergmann; linux-arm-kernel@lists.infradead.org; gregkh@linuxfoundation.org; linux-serial@vger.kernel.org
Subject: Re: [PATCH] the eDMA support for the LPUART send driver

On Sun, Jan 05, 2014 at 03:44:49PM +0100, Arnd Bergmann wrote:
> On Friday 27 December 2013, Yuan Yao wrote:
> > +	dma_phys = dma_map_single(sport->port.dev,
> > +				sport->port.state->xmit.buf,
> > +				UART_XMIT_SIZE, DMA_TO_DEVICE);
> 
> This is wrong: Since the dma is performed by the dma engine rather 
> than the uart, the first argument here needs to be the dma device 
> pointer. In fact, dma_map_single is normally supposed to fail on the 
> uart device as the dma_mask value should be zero. Not sure why this 
> worked.
> 
> > +	if (!dma_phys) {
> > +		dev_err(sport->port.dev, "Dma_phys single failed\n");
> > +		return -ENOMEM;
> > +	}
> 
> Please also change all references to "phys" -- it's not a phys address 
> but a bus address. These are often the same, but that's not for the 
> driver to know.

This is also not how you test for failure of dma_map_single().  I recommend reading the documentation for the APIs you're trying to use...  Hint: dma_mapping_error().

--
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
