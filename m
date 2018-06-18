From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/7] MIPS: dts: Add aliases node for lantiq danube serial
Date: Mon, 18 Jun 2018 12:59:24 +0200
Message-ID: <CAK8P3a0WVxHU98zjY6d8jN0bDtwabFkrbcxr3a7xRkxSjD2ZLg@mail.gmail.com>
References: <20180612054034.4969-1-songjun.wu@linux.intel.com>
 <20180612054034.4969-2-songjun.wu@linux.intel.com> <CAK8P3a1=CBahrEE2uDRfdrSi=ALc5LBED1=KbLbLa40c9H8dmQ@mail.gmail.com>
 <539411c1-82b7-cf76-71cf-d50f3303f50f@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <539411c1-82b7-cf76-71cf-d50f3303f50f@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Wu, Songjun" <songjun.wu@linux.intel.com>
Cc: hua.ma@linux.intel.com, yixin.zhu@linux.intel.com, chuanhua.lei@intel.com, "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>, qi-ming.wu@intel.com, linux-clk <linux-clk@vger.kernel.org>, linux-serial@vger.kernel.org, DTML <devicetree@vger.kernel.org>, James Hogan <jhogan@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Philippe Ombredanne <pombredanne@nexb.com>, Rob Herring <robh+dt@kernel.org>, Kate Stewart <kstewart@linuxfoundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Rutland <mark.rutland@arm.com>, Ralf Baechle <ralf@linux-mips.org>
List-Id: linux-serial@vger.kernel.org

On Mon, Jun 18, 2018 at 11:42 AM, Wu, Songjun
<songjun.wu@linux.intel.com> wrote:
> On 6/14/2018 6:03 PM, Arnd Bergmann wrote:
>>
>> On Tue, Jun 12, 2018 at 7:40 AM, Songjun Wu <songjun.wu@linux.intel.com>
>> wrote:
>>>
>>> Previous implementation uses a hard-coded register value to check if
>>> the current serial entity is the console entity.
>>> Now the lantiq serial driver uses the aliases for the index of the
>>> serial port.
>>> The lantiq danube serial dts are updated with aliases to support this.
>>>
>>> Signed-off-by: Songjun Wu <songjun.wu@linux.intel.com>
>>> ---
>>>
>>>   arch/mips/boot/dts/lantiq/danube.dtsi | 6 +++++-
>>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/mips/boot/dts/lantiq/danube.dtsi
>>> b/arch/mips/boot/dts/lantiq/danube.dtsi
>>> index 2dd950181f8a..7a9e15da6bd0 100644
>>> --- a/arch/mips/boot/dts/lantiq/danube.dtsi
>>> +++ b/arch/mips/boot/dts/lantiq/danube.dtsi
>>> @@ -4,6 +4,10 @@
>>>          #size-cells = <1>;
>>>          compatible = "lantiq,xway", "lantiq,danube";
>>>
>>> +       aliases {
>>> +               serial0 = &asc1;
>>> +       };
>>> +
>>
>> You generally want the aliases to be part of the board specific file,
>> not every board numbers their serial ports in the same way.
>>
>
> In this chip only asc1 can be used as console,  so serial0 is defined in
> chip specific file.

This was a more general comment about 'aliases' being board specific
in principle (though we've had exceptions in the past). Even if there
is only one uart on the chip, I'd recommend following the same
conventions as the other chips that have more than one uart.

       Arnd
