From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 02/10] dt-bindings: serial: add optional pinctrl states
Date: Tue, 9 Jul 2019 08:38:38 -0600
Message-ID: <20190709143838.GA5665@bogus>
References: <1560433800-12255-1-git-send-email-erwan.leray@st.com>
 <1560433800-12255-3-git-send-email-erwan.leray@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1560433800-12255-3-git-send-email-erwan.leray@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Erwan Le Ray <erwan.leray@st.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, Mark Rutland <mark.rutland@arm.com>, linux-serial@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Fabrice Gasnier <fabrice.gasnier@st.com>, Bich Hemon <bich.hemon@st.com>
List-Id: linux-serial@vger.kernel.org

On Thu, Jun 13, 2019 at 03:49:52PM +0200, Erwan Le Ray wrote:
> From: Bich Hemon <bich.hemon@st.com>
> 
> Add options for pinctrl states:
> - "sleep" for low power
> - "idle" for low power and wakeup capabilities enabled
> - "no_console_suspend" for enabling console messages in low power
> 
> Signed-off-by: Bich Hemon <bich.hemon@st.com>
> Signed-off-by: Erwan Le Ray <erwan.leray@st.com>
> 
> diff --git a/Documentation/devicetree/bindings/serial/st,stm32-usart.txt b/Documentation/devicetree/bindings/serial/st,stm32-usart.txt
> index 5ec80c1..64a5ea9 100644
> --- a/Documentation/devicetree/bindings/serial/st,stm32-usart.txt
> +++ b/Documentation/devicetree/bindings/serial/st,stm32-usart.txt
> @@ -13,7 +13,14 @@ Required properties:
>  - clocks: The input clock of the USART instance
>  
>  Optional properties:
> -- pinctrl: The reference on the pins configuration
> +- pinctrl-names: Set to "default". An additional "sleep" state can be defined
> +  to set pins in sleep state when in low power. In case the device is used as
> +  a wakeup source, "idle" state is defined in order to keep RX pin active.
> +  For a console device, an optional state "no_console_suspend" can be defined
> +  to enable console messages during suspend. Typically, "no_console_suspend" and
> +  "default" states can refer to the same pin configuration.

no_console_suspend is a linux thing and doesn't belong in DT.

Rob
