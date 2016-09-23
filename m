From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4] devicetree: bindings: uart: Add new compatible string
 for ZynqMP
Date: Fri, 23 Sep 2016 17:37:48 -0500
Message-ID: <20160923223747.GA1163@rob-hp-laptop>
References: <1474629948-9780-1-git-send-email-navam@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1474629948-9780-1-git-send-email-navam-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nava kishore Manne <nava.manne-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, jslaby-IBi9RG/b67k@public.gmane.org, michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, punnaia-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, Nava kishore Manne <navam-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On Fri, Sep 23, 2016 at 04:55:48PM +0530, Nava kishore Manne wrote:
> From: Nava kishore Manne <nava.manne-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
> 
> This patch Adds the new compatible string for ZynqMP.
> 
> Signed-off-by: Nava kishore Manne <navam-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
> ---
> Changes for v4:
> 		-Modified the ChangeLog comment.
> Changes for v3:
> 		-Added changeLog comment.
> Changes for v2:
>                 -None
> 
>  Documentation/devicetree/bindings/serial/cdns,uart.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/serial/cdns,uart.txt b/Documentation/devicetree/bindings/serial/cdns,uart.txt
> index a3eb154..4fe7aae 100644
> --- a/Documentation/devicetree/bindings/serial/cdns,uart.txt
> +++ b/Documentation/devicetree/bindings/serial/cdns,uart.txt
> @@ -1,7 +1,8 @@
>  Binding for Cadence UART Controller
>  
>  Required properties:
> -- compatible : should be "cdns,uart-r1p8", or "xlnx,xuartps"
> +- compatible : should be "cdns,uart-r1p8", or "xlnx,xuartps" for Zynq and
> +               "cdns,uart-r1p12" for Zynq Ultrascale+ MPSoC uart controller.

Please format this as one valid combination per line.

xuartps is not very specific. It needs some abbreviation of "Zynq 
Ultrascale+ MPSoC" in it.

>  - reg: Should contain UART controller registers location and length.
>  - interrupts: Should contain UART controller interrupts.
>  - clocks: Must contain phandles to the UART clocks
> -- 
> 2.1.2
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
