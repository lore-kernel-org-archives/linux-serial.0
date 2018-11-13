From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH v2 05/10] mailbox: tegra-hsp: Add suspend/resume support
Date: Tue, 13 Nov 2018 11:17:58 +0000
Message-ID: <9a7a55fa-9989-21cd-f981-f43d3b0f2d6c@nvidia.com>
References: <20181112151853.29289-1-thierry.reding@gmail.com>
 <20181112151853.29289-6-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20181112151853.29289-6-thierry.reding@gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Thierry Reding <thierry.reding@gmail.com>, Jassi Brar <jassisinghbrar@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: devicetree@vger.kernel.org, Mika Liljeberg <mliljeberg@nvidia.com>, Mikko Perttunen <mperttunen@nvidia.com>, Timo Alho <talho@nvidia.com>, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, linux-tegra@vger.kernel.org, Pekka Pessi <ppessi@nvidia.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org


On 12/11/2018 15:18, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Upon resuming from a system sleep state, the interrupts for all active
> shared mailboxes need to be reenabled, otherwise they will not work.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  drivers/mailbox/tegra-hsp.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/mailbox/tegra-hsp.c b/drivers/mailbox/tegra-hsp.c
> index 0100a974149b..1259abf3542f 100644
> --- a/drivers/mailbox/tegra-hsp.c
> +++ b/drivers/mailbox/tegra-hsp.c
> @@ -18,6 +18,7 @@
>  #include <linux/of.h>
>  #include <linux/of_device.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm.h>
>  #include <linux/slab.h>
>  
>  #include <dt-bindings/mailbox/tegra186-hsp.h>
> @@ -817,6 +818,23 @@ static int tegra_hsp_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +static int tegra_hsp_resume(struct device *dev)
> +{
> +	struct tegra_hsp *hsp = dev_get_drvdata(dev);
> +	unsigned int i;
> +
> +	for (i = 0; i < hsp->num_sm; i++) {
> +		struct tegra_hsp_mailbox *mb = &hsp->mailboxes[i];
> +
> +		if (mb->channel.chan->cl)
> +			tegra_hsp_mailbox_startup(mb->channel.chan);
> +	}
> +
> +	return 0;
> +}
> +
> +static SIMPLE_DEV_PM_OPS(tegra_hsp_pm_ops, NULL, tegra_hsp_resume);

Is it worth disabling interrupts on suspend to avoid any in-flight
interrupt triggering a bad access on entering suspend? I assume that the
context of the mailbox registers get cleared/lost at some point and so I
was not sure if there is a time where they have a bad state or are
inaccessible?

Cheers
Jon

-- 
nvpublic
