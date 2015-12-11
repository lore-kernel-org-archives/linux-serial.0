From: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 3/9] ACPI: add struct acpi_amba_quirk for AMD pl330
	specific device config
Date: Fri, 11 Dec 2015 15:01:49 +0530
Message-ID: <20151211093148.GX1854@localhost>
References: <1449199466-6081-1-git-send-email-annie.wang@amd.com>
	<1449199466-6081-4-git-send-email-annie.wang@amd.com>
	<20151204131619.GC11655@xora-haswell.xora.org.uk>
	<BLUPR12MB04339648B98F07977B6FA61F81EA0@BLUPR12MB0433.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <BLUPR12MB04339648B98F07977B6FA61F81EA0-7LeqcoF/hwrdEWIfrEWxYwdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "Wang, Annie" <Annie.Wang-5C7GfCeVMHo@public.gmane.org>
Cc: "Li, Tony" <Tony.Li-5C7GfCeVMHo@public.gmane.org>, "Wan, Vincent" <Vincent.Wan-5C7GfCeVMHo@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "Huang, Ray" <Ray.Huang-5C7GfCeVMHo@public.gmane.org>, Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>, Graeme Gregory <gg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "Xue,
	Ken" <Ken.Xue-5C7GfCeVMHo@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On Fri, Dec 11, 2015 at 06:57:51AM +0000, Wang, Annie wrote:
> >> +	/*
> >> +	 * If the ACPI device already has a node attached. It must be
> >> +	 * renamed.
> >> +	 */
> >> +	if (quirk->quirk & MULTI_ATTACHED_QUIRK)
> >> +		sprintf(amba_devname, "%s%s", dev_name(&adev->dev),
> >"DMA");
> >> +	else
> >> +		memcpy(amba_devname, dev_name(&adev->dev),
> >> +		       strlen(dev_name(&adev->dev)));
> >> +
> >> +	amba_dev = amba_device_alloc(amba_devname,
> >>  				     resource->start,
> >>  				     resource_size(resource));
> >>
> >
> >Isn't this basially an MFD in a rather odd fashion?

MFD yes, odd perhaps made out here!
> >
> >I would have though having a device which just splits the resources then creates 2
> >children would be a whole lot simpler?
> >
Yup!

> 
> It seems more complex, if I  trans an ACPI device to pdev, then attach 2 platform child nodes,
> and create an amba device refer to one of the childs. Too many trans. 

Sorry but I dont think that is right assumption, it will simper and PM would
become easy

-- 
~Vinod
