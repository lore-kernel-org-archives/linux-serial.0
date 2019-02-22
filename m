From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 3/9] serial: core: add rs485-rts-delay-us devicetree
 property for RS485
Date: Fri, 22 Feb 2019 17:44:29 -0600
Message-ID: <20190222234429.GA19985@bogus>
References: <20190221171758.10322-1-martin.kepplinger@ginzinger.com>
 <20190221171758.10322-3-martin.kepplinger@ginzinger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190221171758.10322-3-martin.kepplinger@ginzinger.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Martin Kepplinger <martin.kepplinger@ginzinger.com>
Cc: gregkh@linuxfoundation.org, mark.rutland@arm.com, jslaby@suse.com, corbet@lwn.net, richard.genoud@gmail.com, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Thu, Feb 21, 2019 at 06:17:52PM +0100, Martin Kepplinger wrote:
> struct serial_rs485 now optionally holds the rts delay values in
> microseconds. Users can set these delays in their devicetree descriptions,
> so this adds the microseconds-option with the "rs485-rts-delay-us" boolean
> property.

If it has a value, it's not boolean.

Should the old prop be deprecated?

> 
> Signed-off-by: Martin Kepplinger <martin.kepplinger@ginzinger.com>
> ---
>  Documentation/devicetree/bindings/serial/rs485.txt |  1 +
>  drivers/tty/serial/serial_core.c                   | 11 +++++++++++
>  2 files changed, 12 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/serial/rs485.txt b/Documentation/devicetree/bindings/serial/rs485.txt
> index b92592dff6dd..77396c62b383 100644
> --- a/Documentation/devicetree/bindings/serial/rs485.txt
> +++ b/Documentation/devicetree/bindings/serial/rs485.txt
> @@ -12,6 +12,7 @@ Optional properties:
>    * b is the delay between end of data sent and rts signal in milliseconds
>        it corresponds to the delay after sending data and actual release of the line.
>    If this property is not specified, <0 0> is assumed.
> +- rs485-rts-delay-us: the same as rs485-rts-delay, but in microseconds.
>  - rs485-rts-active-low: drive RTS low when sending (default is high).
>  - linux,rs485-enabled-at-boot-time: empty property telling to enable the rs485
>    feature at boot time. It can be disabled later with proper ioctl.
