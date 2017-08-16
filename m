From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 6/6] dt-bindings: slave-device: add reg property
Date: Wed, 16 Aug 2017 16:27:31 +0300
Message-ID: <10586476.xpvXiRN2X6@avalon>
References: <1502889748-31499-1-git-send-email-ulrich.hecht+renesas@gmail.com> <1502889748-31499-7-git-send-email-ulrich.hecht+renesas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1502889748-31499-7-git-send-email-ulrich.hecht+renesas@gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Cc: linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org, magnus.damm@gmail.com, wsa@the-dreams.de, robh@kernel.org, peda@axentia.se, geert@linux-m68k.org, linux-i2c@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi Ulrich,

Thank you for the patch.

On Wednesday 16 Aug 2017 15:22:28 Ulrich Hecht wrote:
> This adds a new DT property to define the index used by a multiplexer to
> select the device.
> 
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> ---
>  Documentation/devicetree/bindings/serial/slave-device.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/serial/slave-device.txt
> b/Documentation/devicetree/bindings/serial/slave-device.txt index
> 40110e0..f9b0783 100644
> --- a/Documentation/devicetree/bindings/serial/slave-device.txt
> +++ b/Documentation/devicetree/bindings/serial/slave-device.txt
> @@ -30,6 +30,8 @@ Optional Properties:
>  		      way to reset the device
>  		    * device baud rate is configured by its firmware but
>  		      there is no way to request the actual settings
> +- reg		: Index used to select the device if it is controlled 
by a
> +		  multiplexer.

The reg property should describe the device address on the bus it is connected 
to. This seems like an abuse of the property to me. The device shouldn't care 
about the multiplexer, I think you should describe the hardware by adding the 
serial device's DT node as a child of the multiplexer's port it is connected 
to.

>  Example:

-- 
Regards,

Laurent Pinchart
