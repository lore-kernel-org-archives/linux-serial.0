From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3 09/11] serial: 8250_lpss: move Quark code from PCI
 driver
Date: Fri, 06 May 2016 13:39:16 +0300
Message-ID: <1462531156.17131.274.camel@linux.intel.com>
References: <1461764894-14891-1-git-send-email-andriy.shevchenko@linux.intel.com>
	 <1461764894-14891-10-git-send-email-andriy.shevchenko@linux.intel.com>
	 <1462354262.27858.153.camel@nexus-software.ie>
	 <CAHp75VcgRi2wuBoZ8iQaKTCrv2p4sY5G9wcXgBtW=6_4pWv6Sg@mail.gmail.com>
	 <1462355477.27858.161.camel@nexus-software.ie>
	 <CAHp75VfW3UVLEvnPoG1AzeYrQ=GRgqZ-pJWbVgSfMs5j2hEwCA@mail.gmail.com>
	 <1462359696.27858.184.camel@nexus-software.ie>
	 <1462360835.17131.224.camel@linux.intel.com>
	 <1462373469.27858.203.camel@nexus-software.ie>
	 <1462383792.17131.265.camel@linux.intel.com>
	 <1462470555.2404.3.camel@nexus-software.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1462470555.2404.3.camel@nexus-software.ie>
Sender: linux-kernel-owner@vger.kernel.org
To: Bryan O'Donoghue <pure.logic@nexus-software.ie>, Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Peter Hurley <peter@hurleysoftware.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Vinod Koul <vinod.koul@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dmaengine <dmaengine@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Puustinen, Ismo" <ismo.puustinen@intel.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

On Thu, 2016-05-05 at 18:49 +0100, Bryan O'Donoghue wrote:
> On Wed, 2016-05-04 at 20:43 +0300, Andy Shevchenko wrote:
> > 
> > > 
> > > Could you then select CONFIG_SERIAL_8250_LPSS when
> > > CONFIG_X86_INTEL_QUARK is true - since it will be a dependency.
> > Answered to this in the other email, but can repeat my question. Do
> > you
> > propose a new behaviour? Otherwise how does it work right now?
> I just mean when someone selects CONFIG_X86_INTEL_QUARK that, that
> kconfig option will select CONFIG_SERIAL_8250_LPSS automatically.
> 
> Maybe that's a bad idea .. I can't think of another driver that would
> be selected like that - though OTOH now that we're moving our
> perfectly
> normal PCI device into this LPSS shim my *feeling* is that it should
> be
> selected automagically.

It's still a PCI driver, just separated from 8250_pci.c.

> Feel free not to do that though - so long as you document the change
> in
> kconfig so that a casual reader understands the entry is moved I think
> it should suffice.

I've already updated (locally) help notice as you suggested.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
