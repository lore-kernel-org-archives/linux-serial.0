From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 4/4] serial: sccnxp: Add DT support
Date: Thu, 01 Aug 2013 10:31:13 -0600
Message-ID: <51FA8D51.8030301@wwwdotorg.org>
References: <1375268145-13393-1-git-send-email-shc_work@mail.ru> <51F98562.9080307@wwwdotorg.org> <1375343473.135835596@f377.i.mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:41693 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752838Ab3HAQbR (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 1 Aug 2013 12:31:17 -0400
In-Reply-To: <1375343473.135835596@f377.i.mail.ru>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, devicetree@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ian.campbell@citrix.com>, Grant Likely <grant.likely@linaro.org>

On 08/01/2013 01:51 AM, Alexander Shiyan wrote:
>> On 07/31/2013 04:55 AM, Alexander Shiyan wrote:
>>> Add DT support to the SCCNCP serial driver.
>>
>>> diff --git a/Documentation/devicetree/bindings/tty/serial/sccnxp-serial.txt b/Documentation/devicetree/bindings/tty/serial/sccnxp-serial.txt
>>
>>> +Optional properties:
>>
>>> +- poll-interval: Poll interval time in nanoseconds.
>>
>> Is this a standard/common property? If not, then it'd be best if the
>> property name included the vendor-prefix "nxp,".
> 
> I am not sure about this, At least this property is used in gpio-keys-polled.
> 
>>> +- nxp,sccnxp-io-cfg: Array contains values for the emulated modem signals.
>>> +  The number of values depends on the UART-number in the selected chip.
>>> +  Each value should be composed according to the following rules:
>>> +  (LINE1 << SIGNAL1) | ... | (LINEX << SIGNALX), where:
>>> +   LINE - VALUE:
>>> +    OP0 - 1
>> ...
>>> +    IP6 - 15
>>> +   SIGNAL - VALUE:
>>> +    DTR - 0
>> ...
>>> +    DIR - 24
>>
>> I wonder that shouldn't be implemented using standard pinctrl bindings.
>> I could see someone wanting to create a pinmuxing-based serial port
>> multiplexing device, which would then need to rely on this node acting
>> as a standard pin controller...
> 
> In this case pin-controller cannot be applied here.

Why not?

> The device has several lines of general purpose inputs and outputs, there is
> no functional purpose of these lines as a modem signals. In the driver realized
> only an emulation of these signals. That is, this property describes the trick.
> I have no idea how to do this trick in another way.

I assume the HW design is that there are 15 pins, and there is a
register or are multiple registers that define which pins are used for
which purpose.

If so, that's exactly what the pinctrl bindings are for.

However, you're talking about emulation... Is this property really
describing HW? If not, it isn't appropriate for DT.

>>> +Example (Dual UART with direction control on OP0 & OP1):
>>> +sc2892@10100000 {
>>> +	compatible = "nxp,sc2892";
>>> +	reg = <0x10100000 0x10>;
>>> +	poll-interval = <10000>;
>>> +	clocks = <&sc2892_clk>;
>>> +	vcc-supply = <&sc2892_reg>;
>>> +	nxp,sccnxp-io-cfg = <0x01000000 0x02000000>;
>>
>> Why two cells for io-cfg when the shifts above imply everything fits
>> into a single cell?
>>
>> Oh I guess that "The number of values depends on the UART-number" means
>> "number of UARTs in the chip", whereas I read it as "the ID of the UART
>> within the chip"..
>>
>> When there are multiple UARTs in the chip, should each UART have its own
>> separate DT node? If not, how could you refer to each individual UART
>> e.g. in order to set up the /aliases node?
> 
> This is my translation inaccuracies: io-cfg count should be == UART count.
> Driver initializes all ports simultaneously (1 or 2). I cannot separate ports,
> because IC registers mixed in one address space.

If there really are multiple ports, I think there have to be multiple DT
nodes, given the way /aliases works.

> As variant, I can make the io-configuration of a single variable u64.

In DT, cells are U32.

> Or, at this stage, remove this option to add later.
> Thanks.

The binding should be as complete as possible up-front. Adding stuff
later only increases the likelihood of wanting to make incompatible changes.
