From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v2] serial: pl011: honour serial aliases in device tree
Date: Tue, 21 Aug 2012 21:42:04 +0100
Message-ID: <20120821204204.GA8316@mudshark.cambridge.arm.com>
References: <1345564094-16565-1-git-send-email-matthew.leach@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1345564094-16565-1-git-send-email-matthew.leach-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Matthew Leach <matthew.leach-5wv7dgnIgG8@public.gmane.org>
Cc: "gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org" <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

Hi Matthew,

On Tue, Aug 21, 2012 at 04:48:14PM +0100, Matthew Leach wrote:
> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
> index d3553b5..33c90f6 100644
> --- a/drivers/tty/serial/amba-pl011.c
> +++ b/drivers/tty/serial/amba-pl011.c
> @@ -52,6 +52,8 @@
>  #include <linux/scatterlist.h>
>  #include <linux/delay.h>
>  #include <linux/types.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
>  #include <linux/pinctrl/consumer.h>
>  #include <linux/sizes.h>
>  
> @@ -1869,6 +1871,38 @@ static struct uart_driver amba_reg = {
>  	.cons			= AMBA_CONSOLE,
>  };
>  
> +static int pl011_probe_dt_alias(int index, struct device *dev)
> +{
> +	struct device_node *np;
> +	static bool seen_dev_with_alias = false;
> +	static bool seen_dev_without_alias = false;
> +	int ret = index;
> +
> +	if (!IS_ENABLED(CONFIG_OF))
> +		return index;

May as well return ret here for consistency. With that:

Reviewed-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>

I guess this goes via Greg's tree rather than the ARM one?

Will
