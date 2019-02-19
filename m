From: "Sugaya, Taichi" <sugaya.taichi@socionext.com>
Subject: Re: [PATCH v2 09/15] dt-bindings: serial: Add Milbeaut serial driver
 description
Date: Tue, 19 Feb 2019 17:11:29 +0900
Message-ID: <04726ec4-4ee5-3aa8-8b46-2e1293f773f5@socionext.com>
References: <1549628849-31726-1-git-send-email-sugaya.taichi@socionext.com>
 <20190218195713.GA18625@bogus>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190218195713.GA18625@bogus>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Rutland <mark.rutland@arm.com>, Takao Orito <orito.takao@socionext.com>, Kazuhiro Kasai <kasai.kazuhiro@socionext.com>, Shinji Kanematsu <kanematsu.shinji@socionext.com>, Jassi Brar <jaswinder.singh@linaro.org>, Masami Hiramatsu <masami.hiramatsu@linaro.org>
List-Id: linux-serial@vger.kernel.org

Hi,

On 2019/02/19 4:57, Rob Herring wrote:
> On Fri, Feb 08, 2019 at 09:27:29PM +0900, Sugaya Taichi wrote:
>> Add DT bindings document for Milbeaut serial driver.
>>
>> Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
>> ---
>>   .../devicetree/bindings/serial/milbeaut-uart.txt    | 21 +++++++++++++++++++++
>>   1 file changed, 21 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/serial/milbeaut-uart.txt
>>
>> diff --git a/Documentation/devicetree/bindings/serial/milbeaut-uart.txt b/Documentation/devicetree/bindings/serial/milbeaut-uart.txt
>> new file mode 100644
>> index 0000000..8f61c38
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/serial/milbeaut-uart.txt
>> @@ -0,0 +1,21 @@
>> +Socionext Milbeaut UART controller
>> +
>> +Required properties:
>> +- compatible: should be "socionext,milbeaut-usio-uart".
>> +- reg: offset and length of the register set for the device.
>> +- interrupts: two interrupts specifier.
>> +- clocks: phandle to the input clock.
>> +- interrupt-names: should be "rx", "tx".
> 
> Put this next to 'interrupts'
> 

OK, change the order.

>> +
>> +Optional properties:
>> +- uart-flow-enable: flow control enable.
> 
> We already have a standard property for this: auto-flow-control
> 

Okay, I change the property name to "auto-flow-control"

>> +
>> +Example:
>> +	usio1: usio_uart@1e700010 {
> 
> serial@...
> 

I got it.

Thanks,
Sugaya Taichi

>> +		compatible = "socionext,milbeaut-usio-uart";
>> +		reg = <0x1e700010 0x10>;
>> +		interrupts = <0 141 0x4>, <0 149 0x4>;
>> +		interrupt-names = "rx", "tx";
>> +		clocks = <&clk 2>;
>> +		uart-flow-enable;
>> +	};
>> -- 
>> 1.9.1
>>
