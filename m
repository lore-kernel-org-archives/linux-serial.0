From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC 1/8] serial:st-asc: Add ST ASC driver.
Date: Wed, 8 May 2013 16:34:43 +0200
Message-ID: <201305081634.43498.arnd@arndb.de>
References: <1368022187-1633-1-git-send-email-srinivas.kandagatla@st.com>
 <1368022248-2153-1-git-send-email-srinivas.kandagatla@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1368022248-2153-1-git-send-email-srinivas.kandagatla@st.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Srinivas KANDAGATLA <srinivas.kandagatla@st.com>
Cc: Dave Martin <dave.martin@linaro.org>, linux-doc@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Will Deacon <will.deacon@arm.com>, Grant Likely <grant.likely@secretlab.ca>, jslaby@suse.cz, Russell King <linux@arm.linux.org.uk>, Samuel Ortiz <sameo@linux.intel.com>, Nicolas Pitre <nico@linaro.org>, Stephen Gallimore <stephen.gallimore@st.com>, linux-serial@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, devicetree-discuss@lists.ozlabs.org, Rob Herring <rob.herring@calxeda.com>, Stuart Menefy <stuart.menefy@st.com>, Stephen Warren <swarren@nvidia.com>, Dong Aisheng <dong.aisheng@linaro.org>, linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, Rob Landley <rob@landley.net>
List-Id: linux-serial@vger.kernel.org

On Wednesday 08 May 2013, Srinivas KANDAGATLA wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@st.com>

> +*st-asc(Serial Port)
> +
> +Required properties:
> +- compatible : Should be "st,asc".

Are there any hardware revision numbers for the asc? If there are potentially
incompatible or backwards-compatible variants, it would be good to include
the version in this string.

> +- reg, reg-names, interrupts, interrupt-names	: Standard way to define device
> +			resources with names. look in
> +			Documentation/devicetree/bindings/resource-names.txt
> +
> +Optional properties:
> +- st,hw-flow-ctrl	bool flag to enable hardware flow control.
> +- st,force-m1		bool flat to force asc to be in Mode-1 recommeded
> +			for high bit rates (above 19.2K)
> +Example:
> +serial@fe440000{
> +    compatible    = "st,asc";
> +    reg         = <0xfe440000 0x2c>;
> +    interrupts     =  <0 209 0>;
> +};

I would also recommed adding a way to set the default baud rate through
a property. Following the example of the 8250 driver, you should probably
call that "current-speed".

> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index 7e7006f..346f325 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -1484,6 +1484,25 @@ config SERIAL_RP2_NR_UARTS
>  	  If multiple cards are present, the default limit of 32 ports may
>  	  need to be increased.
>  
> +config SERIAL_ST_ASC
> +	tristate "ST ASC serial port support"
> +	depends on PLAT_STIXXXX
> +	default y
> +	select SERIAL_CORE
> +	help
> +	  This driver is for the on-chip Asychronous Serial Controller on
> +	  STMicroelectronics STixxxx SoCs.
> +	  ASC is embedded in ST COMMS IP block. It supports Rx & Tx functionality.
> +	  It support all industry standard baud rates.
> +
> +	  If unsure, say N.

I would not make it "default y".

> +config SERIAL_ST_ASC_CONSOLE
> +	bool "Support for console on ST ASC"
> +	depends on SERIAL_ST_ASC
> +	default y
> +	select SERIAL_CORE_CONSOLE
> +
>  endmenu

This needs to be "depends on SERIAL_ST_ASC=y". You would get a link error
if you try to make SERIAL_ST_ASC a loadable module and SERIAL_ST_ASC_CONSOLE
built-in.

> +
> +static struct asc_port asc_ports[ASC_MAX_PORTS];
> +static struct uart_driver asc_uart_driver;
> +
> +/*---- Forward function declarations---------------------------*/
> +static irqreturn_t asc_interrupt(int irq, void *ptr);
> +static void asc_transmit_chars(struct uart_port *);
> +static int asc_set_baud(struct asc_port *ascport, int baud);
> +

Please remove all forward declarations, by reordering the functions in
the way they are called.


> diff --git a/drivers/tty/serial/st-asc.h b/drivers/tty/serial/st-asc.h
> new file mode 100644
> index 0000000..e59f818
> --- /dev/null
> +++ b/drivers/tty/serial/st-asc.h
> +#ifndef _ST_ASC_H
> +#define _ST_ASC_H
> +
> +#include <linux/serial_core.h>
> +#include <linux/clk.h>
> +
> +struct asc_port {
> +	struct uart_port port;
> +	struct clk *clk;
> +	unsigned int hw_flow_control:1;
> +	unsigned int check_parity:1;
> +	unsigned int force_m1:1;
> +};

Since this header file is only used in one place, just merge it into
the driver itself.

> +#define ASC_MAJOR		204
> +#define ASC_MINOR_START		40

I don't know what the current policy is on allocating major/minor numbers,
but I'm sure you cannot just reuse one that is already used.

Documentation/devices.txt lists the ones that are officially assigned.
Can't you use dynamic allocation here?

	Arnd
