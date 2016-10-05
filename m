From: Gerald Baeza <gerald.baeza@st.com>
Subject: Re: [PATCH 02/11] DOCUMENTATION: dt-bindings: Document the STM32
 USART bindings
Date: Wed, 5 Oct 2016 16:09:12 +0200
Message-ID: <dd28f224-3e3b-0a00-f978-16861b946fd1@st.com>
References: <1473957763-30629-1-git-send-email-alexandre.torgue@st.com>
 <1473957763-30629-3-git-send-email-alexandre.torgue@st.com>
 <20160923152907.GA19206@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160923152907.GA19206@rob-hp-laptop>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Rob Herring <robh@kernel.org>, Alexandre TORGUE <alexandre.torgue@st.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Jiri Slaby <jslaby@suse.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

On 09/23/2016 05:29 PM, Rob Herring wrote:
> On Thu, Sep 15, 2016 at 06:42:34PM +0200, Alexandre TORGUE wrote:
>> This adds documentation of device tree bindings for the
>> STM32 USART
>
> Please make your subject prefixes consistent and drop "DOCUMENTATION".
>

Ok, thanks

>>
>> Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
>> Signed-off-by: Alexandre TORGUE <alexandre.torgue@st.com>
>>
>> diff --git a/Documentation/devicetree/bindings/serial/st,stm32-usart.txt b/Documentation/devicetree/bindings/serial/st,stm32-usart.txt
>> new file mode 100644
>> index 0000000..75b1400
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/serial/st,stm32-usart.txt
>> @@ -0,0 +1,34 @@
>> +* STMicroelectronics STM32 USART
>> +
>> +Required properties:
>> +- compatible: Can be either "st,stm32-usart", "st,stm32-uart",
>> +"st,stm32f7-usart" or "st,stm32f7-uart" depending on whether
>> +the device supports synchronous mode and is compatible with
>> +stm32(f4) or stm32f7.
>
> Why not put f4 in the compatible string. stm32 is too generic.

The initial binding is not in current kernel so it has been put in this 
serie as PATCH 07/11. It will be squashed with this one, as you requested.

But the driver tty/serial/stm32-usart.c was already upstreamed and it 
already mentions the "st,stm32-usart" and "st,stm32-uart" for stm32f4 so 
I kept this as it for backward compatibility for those who already use 
the driver.

I do not have the history to explain this inconsistency but can you 
confirm that keeping the existing compatible values from the driver is 
the good approach please?

> What determines sync mode or not? If it is IP configuration fixed in the
> design, then this is fine. If it is user choice or board dependent, then
> use a separate property.

This is IP configuration fixed in the design, indeed.

>> +- reg: The address and length of the peripheral registers space
>> +- interrupts: The interrupt line of the USART instance
>> +- clocks: The input clock of the USART instance
>> +
>> +Optional properties:
>> +- pinctrl: The reference on the pins configuration
>> +- st,hw-flow-ctrl: bool flag to enable hardware flow control.
>> +
>> +Examples:
>> +usart4: serial@40004c00 {
>> +	compatible = "st,stm32-uart";
>> +	reg = <0x40004c00 0x400>;
>> +	interrupts = <52>;
>> +	clocks = <&clk_pclk1>;
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_usart4>;
>> +};
>> +
>> +usart2: serial@40004400 {
>> +	compatible = "st,stm32-usart", "st,stm32-uart";
>
> What are valid combinations? usart is sync only, not sync and async?

usart (sync and async) is a superset of uart (async).
But the current driver does not use the synchronous mode, so the 
distinction is just here to be consistent with the reference manual 
instances naming (so configuration).

>> +	reg = <0x40004400 0x400>;
>> +	interrupts = <38>;
>> +	clocks = <&clk_pclk1>;
>> +	st,hw-flow-ctrl;
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_usart2 &pinctrl_usart2_rtscts>;
>> +};
>> --
>> 1.9.1
>>
