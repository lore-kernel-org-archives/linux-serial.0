From: Alexandre Torgue <alexandre.torgue-qxv4g6HH51o@public.gmane.org>
Subject: Re: [PATCH 02/11] DOCUMENTATION: dt-bindings: Document the STM32
 USART bindings
Date: Thu, 6 Oct 2016 10:00:53 +0200
Message-ID: <34ed9c82-6aff-8770-68a8-afd95f161e27@st.com>
References: <1473957763-30629-1-git-send-email-alexandre.torgue@st.com>
 <1473957763-30629-3-git-send-email-alexandre.torgue@st.com>
 <20160923152907.GA19206@rob-hp-laptop>
 <dd28f224-3e3b-0a00-f978-16861b946fd1@st.com>
 <CAL_JsqK=VCHcPbupnwLVEWehqJbXfGD1CSZT++A4+N6DD6VqxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAL_JsqK=VCHcPbupnwLVEWehqJbXfGD1CSZT++A4+N6DD6VqxA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Gerald Baeza <gerald.baeza-qxv4g6HH51o@public.gmane.org>
Cc: Maxime Coquelin <mcoquelin.stm32-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

Hi Rob,

On 10/05/2016 05:13 PM, Rob Herring wrote:
> On Wed, Oct 5, 2016 at 9:09 AM, Gerald Baeza <gerald.baeza-qxv4g6HH51o@public.gmane.org> wrote:
>> On 09/23/2016 05:29 PM, Rob Herring wrote:
>>>
>>> On Thu, Sep 15, 2016 at 06:42:34PM +0200, Alexandre TORGUE wrote:
>>>>
>>>> This adds documentation of device tree bindings for the
>>>> STM32 USART
>>>
>>>
>>> Please make your subject prefixes consistent and drop "DOCUMENTATION".
>>>
>>
>> Ok, thanks
>>
>>>>
>>>> Signed-off-by: Maxime Coquelin <mcoquelin.stm32-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>>> Signed-off-by: Alexandre TORGUE <alexandre.torgue-qxv4g6HH51o@public.gmane.org>
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/serial/st,stm32-usart.txt
>>>> b/Documentation/devicetree/bindings/serial/st,stm32-usart.txt
>>>> new file mode 100644
>>>> index 0000000..75b1400
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/serial/st,stm32-usart.txt
>>>> @@ -0,0 +1,34 @@
>>>> +* STMicroelectronics STM32 USART
>>>> +
>>>> +Required properties:
>>>> +- compatible: Can be either "st,stm32-usart", "st,stm32-uart",
>>>> +"st,stm32f7-usart" or "st,stm32f7-uart" depending on whether
>>>> +the device supports synchronous mode and is compatible with
>>>> +stm32(f4) or stm32f7.
>>>
>>>
>>> Why not put f4 in the compatible string. stm32 is too generic.
>>
>>
>> The initial binding is not in current kernel so it has been put in this
>> serie as PATCH 07/11. It will be squashed with this one, as you requested.
>>
>> But the driver tty/serial/stm32-usart.c was already upstreamed and it
>> already mentions the "st,stm32-usart" and "st,stm32-uart" for stm32f4 so I
>> kept this as it for backward compatibility for those who already use the
>> driver.
>>
>> I do not have the history to explain this inconsistency but can you confirm
>> that keeping the existing compatible values from the driver is the good
>> approach please?
>
> Yes, keep it as it. Please reformat 1 valid combination per line.

Ok. Do you mean something like:

- compatible: "st,stm32-usart", "st,stm32-uart" For STM32F4 SOC and if
  	      IP supports synchronous mode.
- compatible: "st,stm32-uart" For STM32F4 SOC.
- compatible: "st,stm32f7-usart", "st,stm32f7-uart": For STM32F7 SOC
	      and if IP supports synchronous mode.
- compatible: "st,stm32f7-uart" For STM32F7 SOC

If you agree, what do you prefer to send modification ? I mean, those 
bindings documentation patches are already in linux-next tree. Do you 
want a new patch on top of linux-next or do you prefer I resend only 
those ones ?

Regards

Alex

>
>>> What determines sync mode or not? If it is IP configuration fixed in the
>>> design, then this is fine. If it is user choice or board dependent, then
>>> use a separate property.
>>
>>
>> This is IP configuration fixed in the design, indeed.
>>
>>>> +- reg: The address and length of the peripheral registers space
>>>> +- interrupts: The interrupt line of the USART instance
>>>> +- clocks: The input clock of the USART instance
>>>> +
>>>> +Optional properties:
>>>> +- pinctrl: The reference on the pins configuration
>>>> +- st,hw-flow-ctrl: bool flag to enable hardware flow control.
>>>> +
>>>> +Examples:
>>>> +usart4: serial@40004c00 {
>>>> +       compatible = "st,stm32-uart";
>>>> +       reg = <0x40004c00 0x400>;
>>>> +       interrupts = <52>;
>>>> +       clocks = <&clk_pclk1>;
>>>> +       pinctrl-names = "default";
>>>> +       pinctrl-0 = <&pinctrl_usart4>;
>>>> +};
>>>> +
>>>> +usart2: serial@40004400 {
>>>> +       compatible = "st,stm32-usart", "st,stm32-uart";
>>>
>>>
>>> What are valid combinations? usart is sync only, not sync and async?
>>
>>
>> usart (sync and async) is a superset of uart (async).
>> But the current driver does not use the synchronous mode, so the distinction
>> is just here to be consistent with the reference manual instances naming (so
>> configuration).
>
> Okay, but this point is not clear in the compatible text. The
> description should allow me to validate the example or a dts file.
>
> Rob
>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
