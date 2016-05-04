From: Bryan O'Donoghue <pure.logic@nexus-software.ie>
Subject: Re: [PATCH v3 09/11] serial: 8250_lpss: move Quark code from PCI
 driver
Date: Wed, 04 May 2016 10:51:17 +0100
Message-ID: <1462355477.27858.161.camel@nexus-software.ie>
References: <1461764894-14891-1-git-send-email-andriy.shevchenko@linux.intel.com>
	 <1461764894-14891-10-git-send-email-andriy.shevchenko@linux.intel.com>
	 <1462354262.27858.153.camel@nexus-software.ie>
	 <CAHp75VcgRi2wuBoZ8iQaKTCrv2p4sY5G9wcXgBtW=6_4pWv6Sg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75VcgRi2wuBoZ8iQaKTCrv2p4sY5G9wcXgBtW=6_4pWv6Sg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Peter Hurley <peter@hurleysoftware.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Vinod Koul <vinod.koul@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dmaengine <dmaengine@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Puustinen, Ismo" <ismo.puustinen@intel.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

On Wed, 2016-05-04 at 12:42 +0300, Andy Shevchenko wrote:
> On Wed, May 4, 2016 at 12:31 PM, Bryan O'Donoghue
> <pure.logic@nexus-software.ie> wrote:
> > Andy,
> > 
> > If you are going to start removing working PCI devices from the PCI
> > config table in favour of a shim in SERIAL_8250_LPSS then the very
> > minimum should be some sort of dependency link between
> > SERIAL_8250_LPSS
> > and CONFIG_SERIAL_8250_PCI in kconfig.
> > 
> > A user could reasonably read the QRK datasheet - switch on
> > CONFIG_SERIAL_8250_PCI and then wonder why no console output
> > happened
> > on boot. S/he shouldn't have to know that devices were moved from
> > the
> > PCI driver to an LPSS shim driver or that the 8250_lpss driver now
> > needs to be selected instead of the intuitively correct 8250_pci
> > driver.
> 
> That is taken care of since default is set to SERIAL_8250 (you even
> don't need to have PCI driver enabled!).
> Doesn't work for you?

The default may be set to SERIAL_8250 but, without the QRK specific
entry in 8250_pci.c you won't get console output.

So if you are going to remove the QRK entry from 8250_pci.c and stuff
it into 8250_lpss.c then 8250_lpss needs to be selected by
CONFIG_SERIAL_8250_PCI.

Otherwise the person doing the config needs to know that stuff was
moved from one file to another - even though it's a PCI device (not an
LPSS/ACPI enumerated device) - which seems like an unreasonable level
of knowledge to assume on the part of the user.
