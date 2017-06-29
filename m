From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 4/6] dt-bindings: serial: Document RDA Micro UART
Date: Thu, 29 Jun 2017 15:10:51 -0500
Message-ID: <20170629201051.cfr37kh2gozompqo@rob-hp-laptop>
References: <20170627005520.23731-1-afaerber@suse.de>
 <20170627005520.23731-5-afaerber@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170627005520.23731-5-afaerber@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, service@rdamicro.com, zhao_steven@263.net, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Rutland <mark.rutland@arm.com>, linux-serial@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Tue, Jun 27, 2017 at 02:55:18AM +0200, Andreas Färber wrote:
> Add an initial binding for the RDA8810PL UART.
> 
> Signed-off-by: Andreas Färber <afaerber@suse.de>
> ---
>  Documentation/devicetree/bindings/serial/rda-uart.txt | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/serial/rda-uart.txt
> 
> diff --git a/Documentation/devicetree/bindings/serial/rda-uart.txt b/Documentation/devicetree/bindings/serial/rda-uart.txt
> new file mode 100644
> index 000000000000..6840a8aee035
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/serial/rda-uart.txt
> @@ -0,0 +1,13 @@
> +RDA Micro UART
> +
> +Required properties:
> +- compatible :  "rda,8810pl-uart" for RDA8810PL
> +- reg        :  Offset and length of the register set for the device.

No clocks or interrupts?

Rob
