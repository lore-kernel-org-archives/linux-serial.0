From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 0/5] ARM: at91: fix irq_pm_install_action WARNING
Date: Tue, 16 Dec 2014 15:52:23 +0100 (CET)
Message-ID: <alpine.DEB.2.11.1412161551290.17382@nanos>
References: <1418660152-17185-1-git-send-email-boris.brezillon@free-electrons.com> <2662748.NJbkr6jW7r@vostro.rjw.lan> <3542278.8lcJeXLMFm@vostro.rjw.lan> <20141216100715.57baeb65@bbrezillon> <alpine.DEB.2.11.1412161013570.17382@nanos> <20141216122503.77c5632f@bbrezillon>
 <alpine.DEB.2.11.1412161349420.17382@nanos> <20141216152041.56ff9b2e@bbrezillon>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20141216152041.56ff9b2e@bbrezillon>
Sender: linux-kernel-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com, Mike Turquette <mturquette@linaro.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Andrew Victor <linux@maxim.org.za>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Tue, 16 Dec 2014, Boris Brezillon wrote:
> On Tue, 16 Dec 2014 13:56:26 +0100 (CET)
> Okay, that's what I had in mind, thanks for clarifying this aspect.
> 
> Regarding the DT representation, it should look like this, right ?
> 
> aic: interrupt-controller@fffff000 {
> 	#interrupt-cells = <3>;
> 	compatible = "atmel,at91rm9200-aic";
> 	interrupt-controller;
> 	reg = <0xfffff000 0x200>;
> 	atmel,external-irqs = <29 30 31>;
> 
> 	irq1_demux: irq1-demux {
> 		#interrupt-cells = <1>;
> 		interrupt-controller;
> 	}
> };
> 
> pit: timer@fffffd30 {
> 	compatible = "atmel,at91sam9260-pit";
> 	reg = <0xfffffd30 0xf>;
> 	/* 0 is the id reserved for the PIT */
> 	interrupts-extended = <&irq1_demux 0>;
> 	clocks = <&mck>;
> };
> 
> pmc: pmc@fffffc00 {
> 	compatible = "atmel,at91sam9260-pmc";
> 	reg = <0xfffffc00 0x100>;
> 	/* 1 is the id reserved for the PMC */
> 	interrupts-extended = <&irq1_demux 1>;

Not that I'm a DT expert, but that looks about right.

Thanks,

	tglx
