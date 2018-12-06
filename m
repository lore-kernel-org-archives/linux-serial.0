From: "Sugaya, Taichi" <sugaya.taichi@socionext.com>
Subject: Re: [PATCH 04/14] dt-bindings: timer: Add Milbeaut M10V timer
 description
Date: Thu, 6 Dec 2018 16:42:04 +0900
Message-ID: <230f9c6d-afc1-7e24-eb26-0bc7d1fee333@socionext.com>
References: <1542589274-13878-1-git-send-email-sugaya.taichi@socionext.com>
 <1542589274-13878-5-git-send-email-sugaya.taichi@socionext.com>
 <20181204230354.GA26204@bogus>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181204230354.GA26204@bogus>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Russell King <linux@armlinux.org.uk>, Jiri Slaby <jslaby@suse.com>, Masami Hiramatsu <masami.hiramatsu@linaro.org>, Jassi Brar <jaswinder.singh@linaro.org>
List-Id: linux-serial@vger.kernel.org

Hi,

Thank you for your comments.

On 2018/12/05 8:03, Rob Herring wrote:
> On Mon, Nov 19, 2018 at 10:01:09AM +0900, Sugaya Taichi wrote:
>> Add DT bindings document for Milbeaut M10V timer.
>>
>> Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
>> ---
>>   .../bindings/timer/socionext,milbeaut-timer.txt         | 17 +++++++++++++++++
>>   1 file changed, 17 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/timer/socionext,milbeaut-timer.txt
>>
>> diff --git a/Documentation/devicetree/bindings/timer/socionext,milbeaut-timer.txt b/Documentation/devicetree/bindings/timer/socionext,milbeaut-timer.txt
>> new file mode 100644
>> index 0000000..ddb1b31
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/timer/socionext,milbeaut-timer.txt
>> @@ -0,0 +1,17 @@
>> +Milbeaut SoCs Timer Controller
>> +
>> +Required properties:
>> +
>> +- compatible : should be "socionext,milbeaut-m10v-timer"
>> +- reg : Specifies base physical address and size of the registers.
> 
> How many register ranges? Looks like 2.

Yes, has two ranges.
So add the description about it.

> 
>> +- interrupts : The interrupt of the first timer
>> +- clocks: should be "rclk"
>> +
>> +Example:
>> +
>> +timer {
> 
> timer@1e000050

Okay.

Thanks
Sugaya Taichi

> 
>> +	compatible = "socionext,milbeaut-m10v-timer";
>> +	reg = <0x1e000050 0x10>, <0x1e000060 0x10>;
>> +	interrupts = <0 91 4>;
>> +	clocks = <&rclk>;
>> +};
>> -- 
>> 1.9.1
>>
