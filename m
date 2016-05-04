From: Bryan O'Donoghue <pure.logic@nexus-software.ie>
Subject: Re: [PATCH v3 09/11] serial: 8250_lpss: move Quark code from PCI
 driver
Date: Wed, 04 May 2016 10:31:02 +0100
Message-ID: <1462354262.27858.153.camel@nexus-software.ie>
References: <1461764894-14891-1-git-send-email-andriy.shevchenko@linux.intel.com>
	 <1461764894-14891-10-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1461764894-14891-10-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Peter Hurley <peter@hurleysoftware.com>, linux-serial@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, ismo.puustinen@intel.com, Heikki Krogerus <heikki.krogerus@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

On Wed, 2016-04-27 at 16:48 +0300, Andy Shevchenko wrote:
> Intel Quark has DesignWare UART. Move the code from 8250_pci to
> 8250_lpss.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/tty/serial/8250/8250_lpss.c | 11 +++++++++++
>  drivers/tty/serial/8250/8250_pci.c  | 15 +--------------
>  2 files changed, 12 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_lpss.c
> b/drivers/tty/serial/8250/8250_lpss.c
> index 3112e8b..af34189 100644
> --- a/drivers/tty/serial/8250/8250_lpss.c
> +++ b/drivers/tty/serial/8250/8250_lpss.c

Andy,

If you are going to start removing working PCI devices from the PCI
config table in favour of a shim in SERIAL_8250_LPSS then the very
minimum should be some sort of dependency link between SERIAL_8250_LPSS
and CONFIG_SERIAL_8250_PCI in kconfig.

A user could reasonably read the QRK datasheet - switch on
CONFIG_SERIAL_8250_PCI and then wonder why no console output happened
on boot. S/he shouldn't have to know that devices were moved from the
PCI driver to an LPSS shim driver or that the 8250_lpss driver now
needs to be selected instead of the intuitively correct 8250_pci
driver.

So assuming you agree with that (profound and sublime) logic and will
make that dependency linkage then this is fine for me from a QRK POV.

Reviewed-by: Bryan O'Donoghue <pure.logic@nexus-software.ie>
