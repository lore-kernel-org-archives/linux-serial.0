From: Rob Herring <robh@kernel.org>
Subject: Re: [patch v2 2/2] drivers: jtag: Add Aspeed SoC 24xx and 25xx
 families JTAG master driver
Date: Thu, 10 Aug 2017 15:58:14 -0500
Message-ID: <20170810205814.mumwv2lxl6jn37gt@rob-hp-laptop>
References: <1502115467-1735-1-git-send-email-oleksandrs@mellanox.com>
 <1502115467-1735-3-git-send-email-oleksandrs@mellanox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1502115467-1735-3-git-send-email-oleksandrs@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Oleksandr Shamray <oleksandrs@mellanox.com>
Cc: gregkh@linuxfoundation.org, arnd@arndb.de, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, openbmc@lists.ozlabs.org, joel@jms.id.au, jiri@resnulli.us, tklauser@distanz.ch, linux-serial@vger.kernel.org, mec@shout.net, vadimp@maellanox.com, system-sw-low-level@mellanox.com, openocd-devel-owner@lists.sourceforge.net
List-Id: linux-serial@vger.kernel.org

On Mon, Aug 07, 2017 at 05:17:47PM +0300, Oleksandr Shamray wrote:
> Driver adds support of Aspeed 2500/2400 series SOC JTAG master controller.
> 
> Driver implements the following jtag ops:
> - freq_get;
> - freq_set;
> - status_get;
> - idle;
> - xfer;
> 
> It has been tested on Mellanox system with BMC equipped with
> Aspeed 2520 SoC for programming CPLD devices.
> 
> Signed-off-by: Jiri Pirko <jiri@resnulli.us>
> Signed-off-by: Oleksandr Shamray <oleksandrs@mellanox.com>
> ---
> v1->v2
> Comments pointed by Greg KH <gregkh@linuxfoundation.org>
> - change license type from GPLv2/BSD to GPLv2
> 
> Comments pointed by Neil Armstrong <narmstrong@baylibre.com>
> - Add clk_prepare_enable/clk_disable_unprepare in clock init/deinit
> - Change .compatible to soc-specific compatible names
>   aspeed,aspeed4000-jtag/aspeed5000-jtag
> - Added dt-bindings
> 
> Comments pointed by Arnd Bergmann <arnd@arndb.de>
> - Reorder functions and removed the forward declarations
> - Add static const qualifier to state machine states transitions
> - Change .compatible to soc-specific compatible names
>   aspeed,aspeed4000-jtag/aspeed5000-jtag
> - Add dt-bindings
> 
> Comments pointed by Randy Dunlap <rdunlap@infradead.org>
> - Change module name jtag-aspeed in description in Kconfig
> 
> Comments pointed by kbuild test robot <lkp@intel.com>
> - Remove invalid include <asm/mach-types.h>
> - add resource_size instead of calculation
> ---
>  .../devicetree/bindings/jtag/aspeed-jtag.txt       |   27 +

Please split binding to separate patch.

>  drivers/jtag/Kconfig                               |   13 +
>  drivers/jtag/Makefile                              |    1 +
>  drivers/jtag/jtag-aspeed.c                         |  774 ++++++++++++++++++++
>  4 files changed, 815 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/jtag/aspeed-jtag.txt
>  create mode 100644 drivers/jtag/jtag-aspeed.c
> 
> diff --git a/Documentation/devicetree/bindings/jtag/aspeed-jtag.txt b/Documentation/devicetree/bindings/jtag/aspeed-jtag.txt
> new file mode 100644
> index 0000000..27b1d34
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/jtag/aspeed-jtag.txt
> @@ -0,0 +1,27 @@
> +Aspeed JTAG driver for ast2400 and ast2500 SoC
> +
> +Required properties:
> +- compatible:		Should be one of
> +      - "aspeed,aspeed2400-jtag"
> +      - "aspeed,aspeed2500-jtag"
> +- reg			contains the offset and length of the JTAG memory
> +			region
> +- clocks		root clock of bus, should reference the APB clock
> +- reg-shift		device register offsets are shifted by this value

It doesn't appear that you use this. It should be implied by the 
compatible in any case.

> +- interrupts		should contain JTAG controller interrupt
> +
> +Optional properties:
> +- status 		 defines the operation status of the JTAG. Valid
> +values are:
> +      - "disabled"	 the JTAG is disabled
> +      - "okay"		 the JTAG is enabled

Don't need to document status. It's implied for any node.

> +
> +Example:
> +jtag: jtag@1e6e4000 {
> +	compatible = "aspeed,aspeed2500-jtag";
> +	reg = <0x1e6e4000 0x1c>;
> +	reg-shift = <2>;
> +	clocks = <&clk_apb>;
> +	interrupts = <43>;
> +	status = "disabled";

Don't need to show status in examples either.

> +};
> \ No newline at end of file

^^^
