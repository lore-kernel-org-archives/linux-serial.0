From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v5] devicetree: bindings: uart: Add new compatible string
 for ZynqMP
Date: Mon, 3 Oct 2016 13:42:34 -0500
Message-ID: <20161003184234.GA13165@rob-hp-laptop>
References: <1474898801-36571-1-git-send-email-navam@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1474898801-36571-1-git-send-email-navam@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nava kishore Manne <nava.manne@xilinx.com>
Cc: gregkh@linuxfoundation.org, mark.rutland@arm.com, jslaby@suse.com, michal.simek@xilinx.com, soren.brinkmann@xilinx.com, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, punnaia@xilinx.com, Nava kishore Manne <navam@xilinx.com>
List-Id: linux-serial@vger.kernel.org

On Mon, Sep 26, 2016 at 07:36:41PM +0530, Nava kishore Manne wrote:
> From: Nava kishore Manne <nava.manne@xilinx.com>
> 
> This patch Adds the new compatible string for ZynqMP SoC.
> 
> Signed-off-by: Nava kishore Manne <navam@xilinx.com>
> ---
> Changes for v5:
> 		-Fixed some minor comments.

Not a useful changelog. The point of these comments is to remind the 
reviewers of what they commented on.

> Changes for v4:
>                 -Modified the ChangeLog comment.
> Changes for v3:
>                 -Added changeLog comment.
> Changes for v2:
>                 -None
> 
>  Documentation/devicetree/bindings/serial/cdns,uart.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/serial/cdns,uart.txt b/Documentation/devicetree/bindings/serial/cdns,uart.txt
> index a3eb154..30c885c 100644
> --- a/Documentation/devicetree/bindings/serial/cdns,uart.txt
> +++ b/Documentation/devicetree/bindings/serial/cdns,uart.txt
> @@ -1,7 +1,9 @@
>  Binding for Cadence UART Controller
>  
>  Required properties:
> -- compatible : should be "cdns,uart-r1p8", or "xlnx,xuartps"
> +- compatible :
> +  Use "cdns,uart-r1p8", or "xlnx,xuartps" for Zynq-7xxx SoC.

This is still not right. It was wrong before, but you are touching it so 
make it right. 

OR doesn't match the dts files. It is AND and the opposite order.

xlnx,xuartps wasn't the best naming, but it's in use so we'll have to 
live with it for zynq-7xxx.

> +  Use "cdns,uart-r1p12" for Zynq Ultrascale+ MPSoC.

What I meant here was this should have something like "xlnx,mpsoc-uart" 
as the first compatible with "cdns,uart-r1p12" as the second. Not sure 
if "mpsoc" is the best name here. 

Rob
