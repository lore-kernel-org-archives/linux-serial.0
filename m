From: Bryan O'Donoghue <pure.logic@nexus-software.ie>
Subject: Re: [PATCH v3 09/11] serial: 8250_lpss: move Quark code from PCI
 driver
Date: Wed, 04 May 2016 15:51:09 +0100
Message-ID: <1462373469.27858.203.camel@nexus-software.ie>
References: <1461764894-14891-1-git-send-email-andriy.shevchenko@linux.intel.com>
	 <1461764894-14891-10-git-send-email-andriy.shevchenko@linux.intel.com>
	 <1462354262.27858.153.camel@nexus-software.ie>
	 <CAHp75VcgRi2wuBoZ8iQaKTCrv2p4sY5G9wcXgBtW=6_4pWv6Sg@mail.gmail.com>
	 <1462355477.27858.161.camel@nexus-software.ie>
	 <CAHp75VfW3UVLEvnPoG1AzeYrQ=GRgqZ-pJWbVgSfMs5j2hEwCA@mail.gmail.com>
	 <1462359696.27858.184.camel@nexus-software.ie>
	 <1462360835.17131.224.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1462360835.17131.224.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Peter Hurley <peter@hurleysoftware.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Vinod Koul <vinod.koul@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dmaengine <dmaengine@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Puustinen, Ismo" <ismo.puustinen@intel.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

On Wed, 2016-05-04 at 14:20 +0300, Andy Shevchenko wrote:

> > To move away from a valid/standard PCI probe routine into a new
> > special
> > LPSS/PCI shim (which the hardware doesn't actually mandate) I do
> > think
> > you should to setup the dependency CONFIG_8250_PCI =>
> > CONFIG_8250_LPSS.
> 
> No, this is what we try avoiding

Fine.

Could you then select CONFIG_SERIAL_8250_LPSS when
CONFIG_X86_INTEL_QUARK is true - since it will be a dependency.

> If user selects CONFIG_SERIAL_8250_PCI, the CONFIG_SERIAL_8250_LPSS
> will
> be selected as well since it has same dependencies.

I still think the change is not an obvious one i.e. LPSS (as an ACPI
enumeration concept) is not a requirement to enumerate on Quark X1000.

So I understand why you want to separate out the code from 8250_pci -
however I think the *minimum* here should be a descriptive comment in
kconfig listing which PCI-enumerated SoCs now require the 8250_LPSS
work-around if just selecting 8250_LPSS isn't possible.

So how about listing out those SoCs - something like

"Selecting this option will enable handling of the extra features 
 present on the UART found on Intel Braswell SoC and various  other
 Intel platforms."

=>

"Selecting this option will enable handling of the extra features 
 present on the UART found on
 - Intel Braswell SoC
 - Intel Quark x1000 SoC
 - etc
"
If you make those changes - please add.

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@nexus-software.ie>
