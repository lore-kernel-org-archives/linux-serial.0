From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 2/2] dt-bindings: serial: Move renesas,rzn1-uart into the
 snps-dw-apb-uart binding
Date: Mon, 14 Jan 2019 10:30:25 +0100
Message-ID: <20190114093025.ntshd3oioqacvkm2@verge.net.au>
References: <20190110222017.6390-1-robh@kernel.org>
 <20190110222017.6390-2-robh@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190110222017.6390-2-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Phil Edworthy <phil.edworthy@renesas.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Thu, Jan 10, 2019 at 04:20:17PM -0600, Rob Herring wrote:
> The renesas,rzn1-uart binding only differs in compatible string from the
> snps-dw-apb-uart binding. Move it there, converting it to json-schema in
> the process.

This confused me slightly as this patch removes renesas,rzn1-uart.txt
but doesn't add the renesas bindings elsewhere. I now see that is done
in patch 1/2, which is fine. But it might be worth rewording the changelog.

That notwithstanding:

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>


> Cc: Phil Edworthy <phil.edworthy@renesas.com>
> Cc: Simon Horman <horms+renesas@verge.net.au>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-serial@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/serial/renesas,rzn1-uart.txt   | 10 ----------
>  1 file changed, 10 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/serial/renesas,rzn1-uart.txt
> 
> diff --git a/Documentation/devicetree/bindings/serial/renesas,rzn1-uart.txt b/Documentation/devicetree/bindings/serial/renesas,rzn1-uart.txt
> deleted file mode 100644
> index 8b9e0d4dc2e4..000000000000
> --- a/Documentation/devicetree/bindings/serial/renesas,rzn1-uart.txt
> +++ /dev/null
> @@ -1,10 +0,0 @@
> -Renesas RZ/N1 UART
> -
> -This controller is based on the Synopsys DesignWare ABP UART and inherits all
> -properties defined in snps-dw-apb-uart.txt except for the compatible property.
> -
> -Required properties:
> -- compatible : The device specific string followed by the generic RZ/N1 string.
> -   Therefore it must be one of:
> -   "renesas,r9a06g032-uart", "renesas,rzn1-uart"
> -   "renesas,r9a06g033-uart", "renesas,rzn1-uart"
> -- 
> 2.19.1
> 
