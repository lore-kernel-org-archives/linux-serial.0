From: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 5/9] dmaengine: pl330: provide ACPI dmaengine interface
Date: Sun, 13 Dec 2015 04:21:57 +0200
Message-ID: <CAHp75VdZyr=zZptJtTUJE+fVrC=6gpYod47SLxdGyfQx2QvZdA@mail.gmail.com>
References: <1449199466-6081-1-git-send-email-annie.wang@amd.com>
	<1449199466-6081-6-git-send-email-annie.wang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1449199466-6081-6-git-send-email-annie.wang-5C7GfCeVMHo@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Wang Hongcheng <annie.wang-5C7GfCeVMHo@public.gmane.org>
Cc: Tony Li <tony.li-5C7GfCeVMHo@public.gmane.org>, Wan Zongshun <vincent.wan-5C7GfCeVMHo@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>, Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, dmaengine <dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Ken Xue <ken.xue-5C7GfCeVMHo@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On Fri, Dec 4, 2015 at 5:24 AM, Wang Hongcheng <annie.wang-5C7GfCeVMHo@public.gmane.org> wrote:
> register acpi_dma controller, so ACPI devices can request pl330 DMA
> channel.
> A filter is added in private data for Carrizo specific hardware
> design
>
> Signed-off-by: Wang Hongcheng <annie.wang-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/acpi/acpi_apd.c    | 12 ++++++++++++
>  drivers/dma/pl330.c        | 38 ++++++++++++++++++++++++++++++++++++++
>  include/linux/amba/pl330.h |  1 +
>  3 files changed, 51 insertions(+)
>
> diff --git a/drivers/acpi/acpi_apd.c b/drivers/acpi/acpi_apd.c
> index 7a582f5..906a20f 100644
> --- a/drivers/acpi/acpi_apd.c
> +++ b/drivers/acpi/acpi_apd.c
> @@ -38,12 +38,15 @@ struct apd_private_data;
>
>  static u8 peri_id[2] = { 0, 1 };
>
> +static int apd_acpi_xlate_filter(int slave_id, struct device *dev);
> +
>  static struct dma_pl330_platdata amd_pl330 = {
>         .nr_valid_peri = 2,
>         .peri_id = peri_id,
>         .has_no_cap_mask = true,
>         .mcbuf_sz = 0,
>         .flags = IRQF_SHARED,
> +       .acpi_xlate_filter = apd_acpi_xlate_filter,
>  };
>
>  /**
> @@ -68,6 +71,15 @@ struct apd_private_data {
>         const struct apd_device_desc *dev_desc;
>  };
>
> +int apd_acpi_xlate_filter(int slave_id, struct device *dev)
> +{
> +       if (((slave_id == 1) && (!strcmp(dev_name(dev), "AMD0020:00DMA")))
> +           || ((slave_id == 2) && (!strcmp(dev_name(dev), "AMD0020:01DMA"))))
> +               return 0;

First of all, too many parens. No need to have them here: (!strcmp()),
for example.

Second, looks like you actually compare slave_id with device _UID, am
I right? In that case maybe better to check device's _HID, _UID and
eventually slave_id.

> +
> +       return 1;
> +}
> +
>  #ifdef CONFIG_X86_AMD_PLATFORM_DEVICE
>  #define APD_ADDR(desc) ((unsigned long)&desc)
>
> diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
> index 8300969..9d7af0d 100644
> --- a/drivers/dma/pl330.c
> +++ b/drivers/dma/pl330.c
> @@ -2079,6 +2079,35 @@ static struct dma_chan *of_dma_pl330_xlate(struct of_phandle_args *dma_spec,
>         return dma_get_slave_channel(&pl330->peripherals[chan_id].chan);
>  }
>
> +static struct dma_chan *acpi_dma_pl330_xlate(struct acpi_dma_spec *dma_spec,
> +                                            struct acpi_dma *adma)
> +{
> +       struct pl330_dmac *pl330 = adma->data;
> +       struct dma_pl330_platdata *pdat;
> +       unsigned int chan_id;
> +       int ret;
> +
> +       if (!dma_spec)
> +               return NULL;

AFAIR dma_spec is guaranteed not to be NULL.

> +
> +       if (!adma)
> +               return NULL;

Ditto.

> +
> +       pdat = dev_get_platdata(adma->dev);
> +
> +       chan_id = dma_spec->chan_id;
> +       if (chan_id >= pl330->num_peripherals)
> +               return NULL;
> +
> +       if (pdat->acpi_xlate_filter) {
> +               ret = pdat->acpi_xlate_filter(dma_spec->slave_id, adma->dev);
> +               if (ret)
> +                       return NULL;
> +       }
> +
> +       return dma_get_slave_channel(&pl330->peripherals[chan_id].chan);
> +}
> +
>  static int pl330_alloc_chan_resources(struct dma_chan *chan)
>  {
>         struct dma_pl330_chan *pch = to_pchan(chan);
> @@ -2918,6 +2947,15 @@ pl330_probe(struct amba_device *adev, const struct amba_id *id)
>                 }
>         }
>
> +       if (ACPI_HANDLE(&adev->dev)) {

I suspect where did you get this, but it's already updated. You better use
has_acpi_companion() instead.

> +               ret = acpi_dma_controller_register(&adev->dev,
> +                                                  acpi_dma_pl330_xlate, pl330);

So, someone has either to provide CSRT (which is mostly foreign to
ACPI tables), or to provide those resources somehow else (request line
base and number). In the latter case you would need to add the hook
into acpi_dma_controller_register().

> +               if (ret) {
> +                       dev_err(&adev->dev,
> +                               "unable to register DMA to the generic ACPI DMA helpers\n");
> +               }
> +       }
> +
>         adev->dev.dma_parms = &pl330->dma_parms;
>
>         /*

-- 
With Best Regards,
Andy Shevchenko
