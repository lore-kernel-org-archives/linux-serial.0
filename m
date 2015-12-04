From: Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH 8/9] Documentation: Add ivrs_acpihid kernel parameter
	description
Date: Fri, 4 Dec 2015 13:21:50 +0100
Message-ID: <20151204122149.GD21177@pd.tnic>
References: <1449199466-6081-1-git-send-email-annie.wang@amd.com>
	<1449199466-6081-9-git-send-email-annie.wang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1449199466-6081-9-git-send-email-annie.wang-5C7GfCeVMHo@public.gmane.org>
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
Cc: Tony Li <tony.li-5C7GfCeVMHo@public.gmane.org>, Wan Zongshun <vincent.wan-5C7GfCeVMHo@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Ken Xue <ken.xue-5C7GfCeVMHo@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On Fri, Dec 04, 2015 at 11:24:25AM +0800, Wang Hongcheng wrote:
> From: Wan Zongshun <Vincent.Wan-5C7GfCeVMHo@public.gmane.org>
> 
> Add ivrs_acpihid kernel parameter description,
> like ivrs_acpihid[00:14.5]=AMD0020:0.
> 
> Signed-off-by: Wan Zongshun <Vincent.Wan-5C7GfCeVMHo@public.gmane.org>
> ---
>  Documentation/kernel-parameters.txt | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
> index 742f69d..5c364c6 100644
> --- a/Documentation/kernel-parameters.txt
> +++ b/Documentation/kernel-parameters.txt
> @@ -1680,6 +1680,13 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
>  			PCI device 00:14.0 write the parameter as:
>  				ivrs_hpet[0]=00:14.0
>  
> +	ivrs_acpihid	[HW,X86_64]
> +			Provide an override to the ACPI-HID:UID<->DEVICE-ID
> +			mapping provided in the IVRS ACPI table. For
> +			example, to map UART-HID:UID AMD0020:0 to
> +			PCI device 00:14.5 write the parameter as:
> +				ivrs_acpihid[00:14.5]=AMD0020:0

What is that parameter needed for? Can't you deduce the mapping from the
hardware?

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
