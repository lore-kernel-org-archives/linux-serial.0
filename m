From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 1/3] tegra, serial8250: add ->handle_break() uart_port op
Date: Tue, 10 Apr 2012 10:51:36 +0000
Message-ID: <201204101051.36541.arnd@arndb.de>
References: <20120409194514.8004.53204.stgit@dwillia2-linux.jf.intel.com> <20120409194857.8004.86352.stgit@dwillia2-linux.jf.intel.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120409194857.8004.86352.stgit@dwillia2-linux.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: gregkh@linuxfoundation.org, Sudhakar Mamillapalli <sudhakar@fb.com>, Stephen Warren <swarren@nvidia.com>, linux-kernel@vger.kernel.org, ArndBergmannarnd@arndb.de, Grant Likely <grant.likely@secretlab.ca>, linux-serial@vger.kernel.org, Colin Cross <ccross@android.com>, Olof Johansson <olof@lixom.net>, Nhan H Mai <nhan.h.mai@intel.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Alan Cox <alan@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

On Monday 09 April 2012, Dan Williams wrote:
> The "KT" serial port has another use case for a "received break" quirk,
> so before adding another special case to the 8250 core take this
> opportunity to push such quirks out of the core and into a uart_port op.
> 
> Stephen says:
> "If the callback function is to no longer live in 8250.c itself,
>  arch/arm/mach-tegra/devices.c isn't logically a good place to put it,
>  and that file will be going away once we get rid of all the board files
>  and move solely to device tree."
> 
> ...so since 8250_pci.c houses all the quirks for pci serial devices this
> quirk is similarly housed in of_serial.c.  Once the open firmware
> conversion completes the infrastructure details (CONFIG_TEGRA_SERIAL,
> include/linux/of_serial.h, and the export) can all be removed to make
> this self contained to of_serial.c.

Looks much better to me, thanks!

Acked-by: Arnd Bergmann <arnd@arndb.de>

> @@ -81,7 +83,9 @@ static struct platform_device trimslice_audio_device = {
>  };
>  
>  static struct platform_device *trimslice_devices[] __initdata = {
> +#if IS_ENABLED(CONFIG_SERIAL_TEGRA)
>  	&debug_uart,
> +#endif
>  	&tegra_sdhci_device1,
>  	&tegra_sdhci_device4,
>  	&tegra_i2s_device1,

FWIW, I'd prefer to see this without the #if, I generally think the devices
that are present should not depend on the drivers that are built into the
kernel. However, since this code is going away soon, I don't care all that
much about it.

	Arnd
