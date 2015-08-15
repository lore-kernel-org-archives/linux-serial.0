From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCHv3 6/8] serial: imx: add runtime pm support
Date: Fri, 14 Aug 2015 17:23:12 -0700
Message-ID: <20150815002312.GA26089@kroah.com>
References: <1439313687-28502-1-git-send-email-edubezval@gmail.com>
 <1439313687-28502-7-git-send-email-edubezval@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1439313687-28502-7-git-send-email-edubezval@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Jiri Slaby <jslaby@suse.com>, Fabio Estevam <festevam@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, Linux PM <linux-pm@vger.kernel.org>, linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Tue, Aug 11, 2015 at 10:21:25AM -0700, Eduardo Valentin wrote:
> This change introduces the runtime pm support on imx serial
> driver. The objective is to be able to idle the uart
> port whenever it is not in use while still being able
> to wake it up when needed. The key changes in this patch are:
> 1. Move the clock handling to runtime pm. Both, ipg and per,
> are now handled in the suspend and resume callbacks. Only
> enabling and disabling the clocks are handled in runtime
> suspend and resume, so we are able to use runtime pm
> in IRQ context.
> 2. Clocks are prepared in probe and unprepared in remove,
> so we do not need to prepare (may sleep) in runtime pm.
> 3. We mark the device activity based on uart and console
> callbacks. Whenever the device is needed and we want to
> access registers, we runtime_pm_get and then mark its
> last usage when we are done. This is done also across
> IRQs and DMA callbacks.
> 4. We reuse the infrastructure in place for suspend and
> resume, so we do not need to redo wakeup configuration,
> or context save and restore.
> 
> After this change, the clocks are still sane, in the sense
> of having balanced clock prepare and enable.
> 
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jslaby@suse.com>
> Cc: linux-serial@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
> ---
>  drivers/tty/serial/imx.c | 224 +++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 178 insertions(+), 46 deletions(-)
> 
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 50abb60..9447a55 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -39,6 +39,9 @@
>  #include <linux/of_device.h>
>  #include <linux/io.h>
>  #include <linux/dma-mapping.h>
> +#include <linux/pm.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/pm_wakeup.h>
>  
>  #include <asm/irq.h>
>  #include <linux/platform_data/serial-imx.h>
> @@ -219,6 +222,7 @@ struct imx_port {
>  	unsigned int            saved_reg[10];
>  	bool			context_saved;
>  
> +	struct device		*dev;

Do you really need this pointer?  Can't you get it from the platform
device that you have access to that sport is the data?

thanks,

greg k-h
