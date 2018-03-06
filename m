From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: serial: stm32: add wakeup option using
 note
Date: Mon, 5 Mar 2018 18:52:12 -0600
Message-ID: <20180306005212.acwhs2ajr64exf2s@rob-hp-laptop>
References: <1519815044-22669-1-git-send-email-bich.hemon@st.com>
 <1519815044-22669-2-git-send-email-bich.hemon@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1519815044-22669-2-git-send-email-bich.hemon@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bich HEMON <bich.hemon@st.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Rutland <mark.rutland@arm.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre TORGUE <alexandre.torgue@st.com>, Jiri Slaby <jslaby@suse.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Wed, Feb 28, 2018 at 10:51:17AM +0000, Bich HEMON wrote:
> Update bindings with interrupt-names and wakeup-source information
> 
> Signed-off-by: Bich Hemon <bich.hemon@st.com>
> ---
>  Documentation/devicetree/bindings/serial/st,stm32-usart.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/serial/st,stm32-usart.txt b/Documentation/devicetree/bindings/serial/st,stm32-usart.txt
> index d150b04..aaeb564 100644
> --- a/Documentation/devicetree/bindings/serial/st,stm32-usart.txt
> +++ b/Documentation/devicetree/bindings/serial/st,stm32-usart.txt
> @@ -10,6 +10,7 @@ Required properties:
>  - interrupts:
>    - The interrupt line for the USART instance,
>    - An optional wake-up interrupt.
> +- interrupt-names: Contains "event" for the USART interrupt line.

This should be moved down into optional properties.

>  - clocks: The input clock of the USART instance
>  
>  Optional properties:
> @@ -17,6 +18,9 @@ Optional properties:
>  - st,hw-flow-ctrl: bool flag to enable hardware flow control.
>  - dmas: phandle(s) to DMA controller node(s). Refer to stm32-dma.txt
>  - dma-names: "rx" and/or "tx"
> +- wakeup-source: bool flag to indicate this device has wakeup capabilities
> +- interrupt-names : Should contain "wakeup" if optional wake-up interrupt is
> +  used.
>  
>  Examples:
>  usart4: serial@40004c00 {
> -- 
> 1.9.1
