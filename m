From: Nishanth Menon <nm@ti.com>
Subject: Re: [RFC PATCH 3/6] serial: 8250_omap: Add support for AM654 UART
 controller
Date: Tue, 12 Jun 2018 17:03:33 -0500
Message-ID: <20180612220333.4odussbccwmup26v@kahuna>
References: <20180605060125.9518-1-nm@ti.com> <20180605060125.9518-4-nm@ti.com>
 <20180612210640.GA20728@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20180612210640.GA20728@rob-hp-laptop>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Rob Herring <robh@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>, Vignesh R <vigneshr@ti.com>, Tony Lindgren <tony@atomide.com>, Catalin Marinas <catalin.marinas@arm.com>, Santosh Shilimkar <ssantosh@kernel.org>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>, Russell King <linux@armlinux.org.uk>, Tero Kristo <t-kristo@ti.com>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On 21:06-20180612, Rob Herring wrote:
> > diff --git a/Documentation/devicetree/bindings/serial/omap_serial.txt b/Documentation/devicetree/bindings/serial/omap_serial.txt
> > index 4b0f05adb228..c35d5ece1156 100644
> > --- a/Documentation/devicetree/bindings/serial/omap_serial.txt
> > +++ b/Documentation/devicetree/bindings/serial/omap_serial.txt
> > @@ -1,6 +1,7 @@
> >  OMAP UART controller
> >  
> >  Required properties:
> > +- compatible : should be "ti,am654-uart" for AM654 controllers
> 
> Not compatible with any existing TI 8250 UARTs?

Base is compatible, however there are differences in DMA operation and
few additional bits. omap4-uart is sufficient for a basic PIO mode of
operation given initialization a bootloader might do for base console.

I will split the bindings off into it's own patch to keep the confusion
to a minimum and allowing serial driver change to go in independently.

-- 
Regards,
Nishanth Menon
