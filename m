From: Bryan O'Donoghue <pure.logic@nexus-software.ie>
Subject: Re: [PATCH v3 09/11] serial: 8250_lpss: move Quark code from PCI
 driver
Date: Wed, 04 May 2016 12:01:36 +0100
Message-ID: <1462359696.27858.184.camel@nexus-software.ie>
References: <1461764894-14891-1-git-send-email-andriy.shevchenko@linux.intel.com>
	 <1461764894-14891-10-git-send-email-andriy.shevchenko@linux.intel.com>
	 <1462354262.27858.153.camel@nexus-software.ie>
	 <CAHp75VcgRi2wuBoZ8iQaKTCrv2p4sY5G9wcXgBtW=6_4pWv6Sg@mail.gmail.com>
	 <1462355477.27858.161.camel@nexus-software.ie>
	 <CAHp75VfW3UVLEvnPoG1AzeYrQ=GRgqZ-pJWbVgSfMs5j2hEwCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75VfW3UVLEvnPoG1AzeYrQ=GRgqZ-pJWbVgSfMs5j2hEwCA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Peter Hurley <peter@hurleysoftware.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Vinod Koul <vinod.koul@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dmaengine <dmaengine@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Puustinen, Ismo" <ismo.puustinen@intel.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

On Wed, 2016-05-04 at 13:03 +0300, Andy Shevchenko wrote:
> On Wed, May 4, 2016 at 12:51 PM, Bryan O'Donoghue
> <pure.logic@nexus-software.ie> wrote:
> > On Wed, 2016-05-04 at 12:42 +0300, Andy Shevchenko wrote:
> > > On Wed, May 4, 2016 at 12:31 PM, Bryan O'Donoghue
> > > <pure.logic@nexus-software.ie> wrote:
> > > > Andy,
> > > > 
> > > > If you are going to start removing working PCI devices from the
> > > > PCI
> > > > config table in favour of a shim in SERIAL_8250_LPSS then the
> > > > very
> > > > minimum should be some sort of dependency link between
> > > > SERIAL_8250_LPSS
> > > > and CONFIG_SERIAL_8250_PCI in kconfig.
> > > > 
> > > > A user could reasonably read the QRK datasheet - switch on
> > > > CONFIG_SERIAL_8250_PCI and then wonder why no console output
> > > > happened
> > > > on boot. S/he shouldn't have to know that devices were moved
> > > > from
> > > > the
> > > > PCI driver to an LPSS shim driver or that the 8250_lpss driver
> > > > now
> > > > needs to be selected instead of the intuitively correct
> > > > 8250_pci
> > > > driver.
> > > 
> > > That is taken care of since default is set to SERIAL_8250 (you
> > > even
> > > don't need to have PCI driver enabled!).
> > > Doesn't work for you?
> > 
> > The default may be set to SERIAL_8250 but, without the QRK specific
> > entry in 8250_pci.c you won't get console output.
> > 
> > So if you are going to remove the QRK entry from 8250_pci.c and
> > stuff
> > it into 8250_lpss.c then 8250_lpss needs to be selected by
> > CONFIG_SERIAL_8250_PCI.
> 
> Why?!
> 
> Now it should be enough to have SERIAL_8250 set to non-n to have
> 8250_lpss compiled.
> Can you check it?

I'm sure that's true.

My point to you is that - its a highly non-intuitive thing to do on a
reading of the datasheet for this part.

LPSS is, ostensibly at least, for passing processor resources via APCI.

If you look at a QRK datasheet it says "enumerate all this stuff via
PCI" - there's not a single mention of LPSS. Its reasonable, correct
and currently required for QRK to set CONFIG_8250_PCI.

To move away from a valid/standard PCI probe routine into a new special
LPSS/PCI shim (which the hardware doesn't actually mandate) I do think
you should to setup the dependency CONFIG_8250_PCI => CONFIG_8250_LPSS.

---
bod
