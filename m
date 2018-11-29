From: "Sugaya, Taichi" <sugaya.taichi@socionext.com>
Subject: Re: [PATCH 02/14] dt-bindings: soc: milbeaut: Add Milbeaut trampoline
 description
Date: Thu, 29 Nov 2018 21:24:51 +0900
Message-ID: <c746a3de-a9e3-9f25-ecb9-703ceb7e62d0@socionext.com>
References: <1542589274-13878-1-git-send-email-sugaya.taichi@socionext.com>
 <1542589274-13878-3-git-send-email-sugaya.taichi@socionext.com>
 <154337047410.88331.9696178601340675631@swboyd.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <154337047410.88331.9696178601340675631@swboyd.mtv.corp.google.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Russell King <linux@armlinux.org.uk>, Jiri Slaby <jslaby@suse.com>, Masami Hiramatsu <masami.hiramatsu@linaro.org>, Jassi Brar <jaswinder.singh@linaro.org>
List-Id: linux-serial@vger.kernel.org

Hi,

Thank you for your comments.

On 2018/11/28 11:01, Stephen Boyd wrote:
> Quoting Sugaya Taichi (2018-11-18 17:01:07)
>> Add DT bindings document for Milbeaut trampoline.
>>
>> Signed-off-by: Sugaya Taichi<sugaya.taichi@socionext.com>
>> ---
>>   .../devicetree/bindings/soc/socionext/socionext,m10v.txt     | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/soc/socionext/socionext,m10v.txt
>>
>> diff --git a/Documentation/devicetree/bindings/soc/socionext/socionext,m10v.txt b/Documentation/devicetree/bindings/soc/socionext/socionext,m10v.txt
>> new file mode 100644
>> index 0000000..f5d906c
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/soc/socionext/socionext,m10v.txt
>> @@ -0,0 +1,12 @@
>> +Socionext M10V SMP trampoline driver binding
>> +
>> +This is a driver to wait for sub-cores while boot process.
>> +
>> +- compatible: should be "socionext,smp-trampoline"
>> +- reg: should be <0x4C000100 0x100>
>> +
>> +EXAMPLE
>> +       trampoline: trampoline@0x4C000100 {
> Drop the 0x part of unit addresses.

Okay.


>> +               compatible = "socionext,smp-trampoline";
>> +               reg = <0x4C000100 0x100>;
> Looks like a software construct, which we wouldn't want to put into DT
> this way. DT doesn't describe drivers.
We would like to use this node only getting the address of the 
trampoline area
in which sub-cores wait.  (They have finished to go to this area in previous
bootloader process.)

So should we embed the constant value in source codes instead of getting 
from
DT because the address is constant at the moment? Or is there other 
approach?

Thanks
Sugaya Taichi
