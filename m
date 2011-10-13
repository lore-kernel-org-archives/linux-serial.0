From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH v2 1/5] tty/serial: RS485 bindings for device tree
Date: Wed, 12 Oct 2011 19:02:28 -0600
Message-ID: <20111013010228.GM14042@ponder.secretlab.ca>
References: <1318435620-7481-1-git-send-email-nicolas.ferre@atmel.com>
 <37a19e194d02144aecd24f284f5e43979643a3c3.1318433947.git.nicolas.ferre@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <37a19e194d02144aecd24f284f5e43979643a3c3.1318433947.git.nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, claudio-YOzL5CV4y4YG1A2ADO40+w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Wed, Oct 12, 2011 at 06:06:56PM +0200, Nicolas Ferre wrote:
> Generic bindings for RS485 feature included in some UARTs.
> Those bindings have to be used withing an UART device tree node.
> Documentation updated to link to the bindings definition.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>

Acked-by: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>

> ---
>  Documentation/devicetree/bindings/serial/rs485.txt |   31 ++++++++++++++++++++
>  .../devicetree/bindings/tty/serial/atmel-usart.txt |   27 +++++++++++++++++
>  Documentation/serial/serial-rs485.txt              |    5 +++
>  3 files changed, 63 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/serial/rs485.txt
>  create mode 100644 Documentation/devicetree/bindings/tty/serial/atmel-usart.txt
> 
> diff --git a/Documentation/devicetree/bindings/serial/rs485.txt b/Documentation/devicetree/bindings/serial/rs485.txt
> new file mode 100644
> index 0000000..1e753c6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/serial/rs485.txt
> @@ -0,0 +1,31 @@
> +* RS485 serial communications
> +
> +The RTS signal is capable of automatically controlling line direction for
> +the built-in half-duplex mode.
> +The properties described hereafter shall be given to a half-duplex capable
> +UART node.
> +
> +Required properties:
> +- rs485-rts-delay: prop-encoded-array <a b> where:
> +  * a is the delay beteween rts signal and beginning of data sent in milliseconds.
> +      it corresponds to the delay before sending data.
> +  * b is the delay between end of data sent and rts signal in milliseconds
> +      it corresponds to the delay after sending data and actual release of the line.
> +
> +Optional properties:
> +- linux,rs485-enabled-at-boot-time: empty property telling to enable the rs485
> +  feature at boot time. It can be disabled later with proper ioctl.
> +- rs485-rx-during-tx: empty property that enables the receiving of data even
> +  whilst sending data.
> +
> +RS485 example for Atmel USART:
> +	usart0: serial@fff8c000 {
> +		compatible = "atmel,at91sam9260-usart";
> +		reg = <0xfff8c000 0x4000>;
> +		interrupts = <7>;
> +		atmel,use-dma-rx;
> +		atmel,use-dma-tx;
> +		linux,rs485-enabled-at-boot-time;
> +		rs485-rts-delay = <0 200>;		// in milliseconds
> +	};
> +
> diff --git a/Documentation/devicetree/bindings/tty/serial/atmel-usart.txt b/Documentation/devicetree/bindings/tty/serial/atmel-usart.txt
> new file mode 100644
> index 0000000..a49d9a1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/tty/serial/atmel-usart.txt
> @@ -0,0 +1,27 @@
> +* Atmel Universal Synchronous Asynchronous Receiver/Transmitter (USART)
> +
> +Required properties:
> +- compatible: Should be "atmel,<chip>-usart"
> +  The compatible <chip> indicated will be the first SoC to support an
> +  additional mode or an USART new feature.
> +- reg: Should contain registers location and length
> +- interrupts: Should contain interrupt
> +
> +Optional properties:
> +- atmel,use-dma-rx: use of PDC or DMA for receiving data
> +- atmel,use-dma-tx: use of PDC or DMA for transmitting data
> +
> +<chip> compatible description:
> +- at91rm9200:  legacy USART support
> +- at91sam9260: generic USART implementation for SAM9 SoCs
> +
> +Example:
> +
> +	usart0: serial@fff8c000 {
> +		compatible = "atmel,at91sam9260-usart";
> +		reg = <0xfff8c000 0x4000>;
> +		interrupts = <7>;
> +		atmel,use-dma-rx;
> +		atmel,use-dma-tx;
> +	};
> +
> diff --git a/Documentation/serial/serial-rs485.txt b/Documentation/serial/serial-rs485.txt
> index c8878f8..079cb3d 100644
> --- a/Documentation/serial/serial-rs485.txt
> +++ b/Documentation/serial/serial-rs485.txt
> @@ -28,6 +28,10 @@
>     RS485 communications. This data structure is used to set and configure RS485
>     parameters in the platform data and in ioctls.
>  
> +   The device tree can also provide RS485 boot time parameters (see [2]
> +   for bindings). The driver is in charge of filling this data structure from
> +   the values given by the device tree.
> +
>     Any driver for devices capable of working both as RS232 and RS485 should
>     provide at least the following ioctls:
>  
> @@ -121,3 +125,4 @@
>  5. REFERENCES
>  
>   [1]	include/linux/serial.h
> + [2]	Documentation/devicetree/bindings/serial/rs485.txt
> -- 
> 1.7.5.4
> 
