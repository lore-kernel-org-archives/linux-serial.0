From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH/RFC 1/5] serial: sh-sci: Update DT binding documentation
 for GPIO modem lines
Date: Fri, 18 Mar 2016 07:43:36 +0900
Message-ID: <20160317224336.GD23806@verge.net.au>
References: <1458222449-12324-1-git-send-email-geert+renesas@glider.be>
 <1458222449-12324-2-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1458222449-12324-2-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Peter Hurley <peter@hurleysoftware.com>, Magnus Damm <magnus.damm@gmail.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Thu, Mar 17, 2016 at 02:47:25PM +0100, Geert Uytterhoeven wrote:
> Amend the DT bindings for the Renesas SCI driver to allow describing
> optional GPIO-controlled modem lines, which can be used where dedicated
> modem lines are not available.
> 
> The property naming is dictated by the SERIAL_MCTRL_GPIO helpers.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: devicetree@vger.kernel.org
> ---
>  Documentation/devicetree/bindings/serial/renesas,sci-serial.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
> index 528c3b90f23cb04b..f8d7b36742967163 100644
> --- a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
> +++ b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
> @@ -76,6 +76,9 @@ Optional properties:
>    - dmas: Must contain a list of two references to DMA specifiers, one for
>  	  transmission, and one for reception.
>    - dma-names: Must contain a list of two DMA names, "tx" and "rx".
> +  - {cts,dsr,dcd,rng,rts,dtr,out1,out2}-gpios: Must contain a GPIO specifier,
> +    referring to the GPIO pin to be used as the UART's CTS, DSR, DCD, RNG, RTS,
> +    DTR, OUT1, or OUT2 line.
>  
>  Example:
>  	aliases {

Hi Geert,

I do not feel strongly about this but I wonder if it
would make sense to update the example with the new properties.
