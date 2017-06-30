From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 4/6] dt-bindings: serial: Document RDA Micro UART
Date: Fri, 30 Jun 2017 09:27:34 -0500
Message-ID: <CAL_JsqLatRUwdA6GeWCHXFTHMUYY27pdmUpPEoHwCCFMg2F21Q@mail.gmail.com>
References: <20170627005520.23731-1-afaerber@suse.de> <20170627005520.23731-5-afaerber@suse.de>
 <20170629201051.cfr37kh2gozompqo@rob-hp-laptop> <e8b8eb0c-0362-0cfb-4d18-3e1ab2b77412@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <e8b8eb0c-0362-0cfb-4d18-3e1ab2b77412@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, service@rdamicro.com, zhao_steven@263.net, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Rutland <mark.rutland@arm.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Fri, Jun 30, 2017 at 6:12 AM, Andreas Färber <afaerber@suse.de> wrote:
> Am 29.06.2017 um 22:10 schrieb Rob Herring:
>> On Tue, Jun 27, 2017 at 02:55:18AM +0200, Andreas Färber wrote:
>>> Add an initial binding for the RDA8810PL UART.
>>>
>>> Signed-off-by: Andreas Färber <afaerber@suse.de>
>>> ---
>>>  Documentation/devicetree/bindings/serial/rda-uart.txt | 13 +++++++++++++
>>>  1 file changed, 13 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/serial/rda-uart.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/serial/rda-uart.txt b/Documentation/devicetree/bindings/serial/rda-uart.txt
>>> new file mode 100644
>>> index 000000000000..6840a8aee035
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/serial/rda-uart.txt
>>> @@ -0,0 +1,13 @@
>>> +RDA Micro UART
>>> +
>>> +Required properties:
>>> +- compatible :  "rda,8810pl-uart" for RDA8810PL
>>> +- reg        :  Offset and length of the register set for the device.
>>
>> No clocks or interrupts?
>
> Not yet. I've only pieced together an earlycon driver so far, no full
> serial driver. The .dtsi doesn't even have an interrupt-controller node
> yet - wasn't clear to me whether this SoC even has a GIC and, if so,
> where, from the downstream pre-DT code.

How far can you boot with no interrupts?

DT bindings shouldn't unnecessarily evolve. Really, anything added
should be optional to maintain compatibility. Sometimes that's
unavoidable, but this isn't one of those cases. So submit this when
you have something more complete.

Rob
