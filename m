From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [RFC v2 10/10] serial: asc: Add support for KGDB's FIQ/NMI mode
Date: Fri, 23 May 2014 15:50:37 +0100
Message-ID: <537F603D.20707@linaro.org>
References: <1400083125-1464-1-git-send-email-daniel.thompson@linaro.org>
 <1400853478-5824-1-git-send-email-daniel.thompson@linaro.org>
 <1400853478-5824-11-git-send-email-daniel.thompson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1400853478-5824-11-git-send-email-daniel.thompson@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Daniel Thompson <daniel.thompson@linaro.org>, Jason Wessel <jason.wessel@windriver.com>
Cc: Mark Rutland <mark.rutland@arm.com>, kernel@stlinux.com, kgdb-bugreport@lists.sourceforge.net, Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, Dirk Behme <dirk.behme@de.bosch.com>, Russell King <linux@arm.linux.org.uk>, Nicolas Pitre <nico@linaro.org>, patches@linaro.org, Anton Vorontsov <anton.vorontsov@linaro.org>, "David A. Long" <dave.long@linaro.org>, linux-serial@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, kernel-team@android.com, devicetree@vger.kernel.org, linaro-kernel@lists.linaro.org, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Colin Cross <ccross@android.com>, Rob Herring <robh+dt@kernel.org>, John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, Maxime Coquelin <maxime.coquelin@st.com>, Greg
List-Id: linux-serial@vger.kernel.org

Hi Dan,

On 23/05/14 14:57, Daniel Thompson wrote:
> If the platform bus has provided the st-asc with a FIQ resource (i.e. a
> second IRQ) then speculatively register it with KGDB when the polling
> driver is initialized.
>
> By providing this information to KGDB the serial driver offers
> "permission" for KGDB to route the UART interrupt signal from the
> drivers own handler to KGDBs FIQ handler (which will eventually use the
> UART's polled I/O callbacks to interact with the user). This permission
> also implies the st-asc driver has already unmasked RX interrupts
> (otherwise the FIQ handler will never trigger). This unmask is copied
> from similar code in amba-pl011.c .
>
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Srinivas Kandagatla <srinivas.kandagatla@gmail.com>
> Cc: Maxime Coquelin <maxime.coquelin@st.com>
> Cc: Patrice Chotard <patrice.chotard@st.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jslaby@suse.cz>
> Cc: kernel@stlinux.com
> Cc: linux-serial@vger.kernel.org
> ---
>   drivers/tty/serial/st-asc.c | 27 +++++++++++++++++++++++++++
>   1 file changed, 27 insertions(+)
>


Also this new entry should be documented in the st-asc dt bindings.


> diff --git a/drivers/tty/serial/st-asc.c b/drivers/tty/serial/st-asc.c
> index c7f61ac..328720f 100644
> --- a/drivers/tty/serial/st-asc.c
> +++ b/drivers/tty/serial/st-asc.c
> @@ -30,6 +30,7 @@
>   #include <linux/of_platform.h>
>   #include <linux/serial_core.h>
>   #include <linux/clk.h>
> +#include <linux/kgdb.h>
>
>   #define DRIVER_NAME "st-asc"
>   #define ASC_SERIAL_NAME "ttyAS"
> @@ -39,6 +40,7 @@
>   struct asc_port {
>   	struct uart_port port;
>   	struct clk *clk;
> +	int fiq;
>   	unsigned int hw_flow_control:1;
>   	unsigned int force_m1:1;
>   };
...


>   #ifdef CONFIG_CONSOLE_POLL
> +#ifdef CONFIG_KGDB_FIQ
> +	.poll_init     = asc_poll_init,
> +#endif /* CONFIG_KGDB_FIQ */
>   	.poll_get_char = asc_get_poll_char,
>   	.poll_put_char = asc_put_poll_char,
>   #endif /* CONFIG_CONSOLE_POLL */
>   };
>
> +

no need of extra new line here.

>   static int asc_init_port(struct asc_port *ascport,
>   			  struct platform_device *pdev)
>   {
> @@ -673,6 +699,7 @@ static int asc_init_port(struct asc_port *ascport,
>   	port->fifosize	= ASC_FIFO_SIZE;
>   	port->dev	= &pdev->dev;
>   	port->irq	= platform_get_irq(pdev, 0);
> +	ascport->fiq    = platform_get_irq(pdev, 1);
>

Probably its better to give names to the irq resources and get them. As 
forcing the order in DT is always tricky highly possible for an error.



Thanks,
srini

>   	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>   	port->membase = devm_ioremap_resource(&pdev->dev, res);
>
