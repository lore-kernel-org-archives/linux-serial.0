From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH/RFC 2/5] serial: sh-sci: Update DT binding documentation
 for dedicated RTS/CTS
Date: Sat, 19 Mar 2016 19:10:59 -0500
Message-ID: <20160320001059.GA20960@rob-hp-laptop>
References: <1458222449-12324-1-git-send-email-geert+renesas@glider.be>
 <1458222449-12324-3-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1458222449-12324-3-git-send-email-geert+renesas@glider.be>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Peter Hurley <peter@hurleysoftware.com>, Magnus Damm <magnus.damm@gmail.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Thu, Mar 17, 2016 at 02:47:26PM +0100, Geert Uytterhoeven wrote:
> Some Renesas SCIF UARTs have dedicated lines for RTS/CTS hardware flow
> control.  Whether these lines exist depends on SoC and UART instance
> inside the SoC.  Whether these lines can be used for hardware flow
> control depends on board wiring.
> 
> Amend the DT bindings with an optional property to indicate that RTS/CTS
> hardware flow control lines exist, and can be used as such.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: devicetree@vger.kernel.org
> ---
> This has been mimicked after the "fsl,uart-has-rtscts" and
> "sirf,uart-has-rtscts" properties.
> 
> However, as this is fairly generic, perhaps it should just be named
> "uart-has-rtscts" instead?

Yes. And there are some other variations of properties to enable 
flow-control.

> ---
>  Documentation/devicetree/bindings/serial/renesas,sci-serial.txt | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
> index f8d7b36742967163..8de177c187536c68 100644
> --- a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
> +++ b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
> @@ -79,6 +79,11 @@ Optional properties:
>    - {cts,dsr,dcd,rng,rts,dtr,out1,out2}-gpios: Must contain a GPIO specifier,
>      referring to the GPIO pin to be used as the UART's CTS, DSR, DCD, RNG, RTS,
>      DTR, OUT1, or OUT2 line.
> +  - renesas,uart-has-rtscts: The presence of this property indicates that the
> +    UART has dedicated lines for RTS/CTS hardware flow control, and that
> +    they are available for use (wired and enabled by pinmux configuration).
> +    Note that this property is mutually-exclusive with "cts-gpios" and
> +    "rts-gpios" above.
>  
>  Example:
>  	aliases {
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
