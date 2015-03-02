From: Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH V3 3/7] of: Document {little,big,native}-endian bindings
Date: Mon, 02 Mar 2015 08:14:53 -0500
Message-ID: <54F4624D.6000909@hurleysoftware.com>
References: <1416872182-6440-1-git-send-email-cernekee@gmail.com> <1416872182-6440-4-git-send-email-cernekee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1416872182-6440-4-git-send-email-cernekee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Cernekee <cernekee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, jslaby-AlSwsSmVLrQ@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On 11/24/2014 06:36 PM, Kevin Cernekee wrote:
> These apply to newly converted drivers, like serial8250/libahci/...
> The examples were adapted from the regmap bindings document.
> 
> Signed-off-by: Kevin Cernekee <cernekee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  .../devicetree/bindings/common-properties.txt      | 60 ++++++++++++++++++++++
>  1 file changed, 60 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/common-properties.txt
> 
> diff --git a/Documentation/devicetree/bindings/common-properties.txt b/Documentation/devicetree/bindings/common-properties.txt
> new file mode 100644
> index 0000000..21044a4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/common-properties.txt
> @@ -0,0 +1,60 @@
> +Common properties
> +
> +The ePAPR specification does not define any properties related to hardware
> +byteswapping, but endianness issues show up frequently in porting Linux to
> +different machine types.  This document attempts to provide a consistent
> +way of handling byteswapping across drivers.
> +
> +Optional properties:
> + - big-endian: Boolean; force big endian register accesses
> +   unconditionally (e.g. ioread32be/iowrite32be).  Use this if you
> +   know the peripheral always needs to be accessed in BE mode.
> + - little-endian: Boolean; force little endian register accesses
> +   unconditionally (e.g. readl/writel).  Use this if you know the
> +   peripheral always needs to be accessed in LE mode.  This is the
> +   default.

There is a fundamental problem with specifying the default in DT bindings.
How can drivers which are currently native-endian support big-endian?

If the driver is converted to support big-endian, every previous
devicetree will be invalid with the new kernel (because those devicetrees
don't specify 'native-endian').

IOW, consider if the default were 'native-endian'. How would the 8250
driver support existing devicetrees?

Regards,
Peter Hurley


> + - native-endian: Boolean; always use register accesses matched to the
> +   endianness of the kernel binary (e.g. LE vmlinux -> readl/writel,
> +   BE vmlinux -> ioread32be/iowrite32be).  In this case no byteswaps
> +   will ever be performed.  Use this if the hardware "self-adjusts"
> +   register endianness based on the CPU's configured endianness.
> +
> +Note that regmap, in contrast, defaults to native-endian.  But this
> +document is targeted for existing drivers, most of which currently use
> +readl/writel because they expect to be accessing PCI/PCIe devices rather
> +than memory-mapped SoC peripherals.  Since the readl/writel accessors
> +perform a byteswap on BE systems, this means that the drivers in question
> +are implicitly "little-endian".
> +
> +Examples:
> +Scenario 1 : CPU in LE mode & device in LE mode.
> +dev: dev@40031000 {
> +	      compatible = "name";
> +	      reg = <0x40031000 0x1000>;
> +	      ...
> +	      native-endian;
> +};
> +
> +Scenario 2 : CPU in LE mode & device in BE mode.
> +dev: dev@40031000 {
> +	      compatible = "name";
> +	      reg = <0x40031000 0x1000>;
> +	      ...
> +	      big-endian;
> +};
> +
> +Scenario 3 : CPU in BE mode & device in BE mode.
> +dev: dev@40031000 {
> +	      compatible = "name";
> +	      reg = <0x40031000 0x1000>;
> +	      ...
> +	      native-endian;
> +};
> +
> +Scenario 4 : CPU in BE mode & device in LE mode.
> +dev: dev@40031000 {
> +	      compatible = "name";
> +	      reg = <0x40031000 0x1000>;
> +	      ...
> +	      little-endian;
> +};
> 

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
