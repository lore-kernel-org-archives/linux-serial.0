From: Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH 4/5] dt-bindings: serial: lantiq: Update for new SoC
Date: Wed, 7 Aug 2019 16:17:42 +0300
Message-ID: <20190807131742.GV30120@smile.fi.intel.com>
References: <cover.1565160764.git.rahul.tanwar@linux.intel.com>
 <47c6565f5537575b16f65ca5ccc5ecfc61818dbc.1565160764.git.rahul.tanwar@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <47c6565f5537575b16f65ca5ccc5ecfc61818dbc.1565160764.git.rahul.tanwar@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rahul Tanwar <rahul.tanwar@linux.intel.com>
Cc: linux-serial@vger.kernel.org, devicetree@vger.kernel.org, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, jslaby@suse.com, robh+dt@kernel.org, mark.rutland@arm.com, qi-ming.wu@intel.com, cheol.yong.kim@intel.com, rahul.tanwar@intel.com
List-Id: linux-serial@vger.kernel.org

On Wed, Aug 07, 2019 at 05:21:34PM +0800, Rahul Tanwar wrote:
> There is a new Intel Atom based Lightning Mountain(LGM) network processor SoC which
> reuses Lantiq ASC serial controller IP. This patch adds new compatible string
> and its expected property value in order to support the driver for LGM as well.

I think it makes sense to convert to YAML before adding new properties.

> 
> Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>
> ---
>  Documentation/devicetree/bindings/serial/lantiq_asc.txt | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/serial/lantiq_asc.txt b/Documentation/devicetree/bindings/serial/lantiq_asc.txt
> index 40e81a5818f6..18b45dd13a61 100644
> --- a/Documentation/devicetree/bindings/serial/lantiq_asc.txt
> +++ b/Documentation/devicetree/bindings/serial/lantiq_asc.txt
> @@ -1,10 +1,14 @@
>  Lantiq SoC ASC serial controller
>  
>  Required properties:
> -- compatible : Should be "lantiq,asc"
> +- compatible : Should be "lantiq,asc" or "intel,lgm-asc"
>  - reg : Address and length of the register set for the device
> -- interrupts: the 3 (tx rx err) interrupt numbers. The interrupt specifier
> +- interrupts:
> +  For "lantiq,asc" - the 3 (tx rx err) interrupt numbers. The interrupt specifier
>    depends on the interrupt-parent interrupt controller.
> +	or
> +  For "intel,lgm-asc" - the common interrupt number for all of tx rx & err interrupts
> +  followed by level/sense specifier.
>  
>  Optional properties:
>  - clocks: Should contain frequency clock and gate clock
> @@ -29,3 +33,12 @@ asc1: serial@e100c00 {
>  	interrupt-parent = <&icu0>;
>  	interrupts = <112 113 114>;
>  };
> +
> +asc0: serial@e0a00000 {
> +	compatible = "intel,lgm-asc";
> +	reg = <0xe0a00000 0x1000>;
> +	interrupt-parent = <&ioapic1>;
> +	interrupts = <128 1>;
> +	clocks = <&cgu0 LGM_CLK_NOC4>, <&cgu0 LGM_GCLK_ASC0>;
> +	clock-names = "freq", "asc";
> +};
> -- 
> 2.11.0
> 

-- 
With Best Regards,
Andy Shevchenko
