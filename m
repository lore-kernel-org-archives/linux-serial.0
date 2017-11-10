From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/5] dt-bindings: serial: Add common rs485 binding for
 RTS polarity
Date: Fri, 10 Nov 2017 15:58:06 -0600
Message-ID: <20171110215806.htd2mk245c3ehz7i@rob-hp-laptop>
References: <cover.1510134353.git.lukas@wunner.de>
 <60d6ef2cf6c599d2d8717250fe52a0ccb1272be8.1510134353.git.lukas@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <60d6ef2cf6c599d2d8717250fe52a0ccb1272be8.1510134353.git.lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Uwe Kleine-Koenig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Mark Jackson <mpfj-2FZW7xY0fHgqdlJmJB21zg@public.gmane.org>, Michal Oleszczyk <oleszczyk.m-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Wed, Nov 08, 2017 at 11:32:34AM +0100, Lukas Wunner wrote:
> rs485 allows for robust half-duplex serial communication.  It is often
> implemented by attaching an rs485 transceiver to a UART.  The UART's
> RTS line is wired to the transceiver's Transmit Enable pin and
> determines whether the transceiver is sending or receiving.
> 
> Examples for such transceivers are Maxim MAX13451E and TI SN65HVD1781A:
> https://datasheets.maximintegrated.com/en/ds/MAX13450E-MAX13451E.pdf
> http://www.ti.com/lit/ds/symlink/sn65hvd1781a-q1.pdf
> 
> In the devicetree, the transceiver itself is not represented, only the
> UART is.  A few rs485-specific dt-bindings already exist and these go
> into the UART's device node.

That often ends up being a mistake. We don't describe things, then add a 
few properties and then finally realize we need a full representation. 
Connectors are a good example.

> This commit adds a binding to set the RTS polarity.  Most (if not all)
> transceivers require the Transmit Enable pin be driven high for sending,
> but in some cases boards may negate the pin and RTS must then be driven
> low.  Consequently the polarity defaults to active high but can be
> inverted with the newly added "rs485-rts-active-low" binding.
> 
> Document this binding in rs485.txt and in the two drivers fsl-imx-uart
> and fsl-lpuart that are about to be amended with support for it.
> 
> Curiously, the omap_serial driver defaults to active low and already
> supports an "rs485-rts-active-high" binding to invert the polarity.
> This is left unchanged to retain compatibility, but the binding is
> herewith documented.
> 
> Cc: Mark Jackson <mpfj-2FZW7xY0fHgqdlJmJB21zg@public.gmane.org>
> Cc: Michał Oleszczyk <oleszczyk.m-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> Cc: Uwe Kleine-König <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> Signed-off-by: Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/serial/fsl-imx-uart.txt | 3 ++-
>  Documentation/devicetree/bindings/serial/fsl-lpuart.txt   | 3 ++-
>  Documentation/devicetree/bindings/serial/omap_serial.txt  | 1 +
>  Documentation/devicetree/bindings/serial/rs485.txt        | 1 +
>  4 files changed, 6 insertions(+), 2 deletions(-)

Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
