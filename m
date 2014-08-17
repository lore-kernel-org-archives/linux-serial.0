From: Carlo Caione <carlo@caione.org>
Subject: Re: [PATCH 5/7] ARM: meson: dts: add basic Meson/Meson6/Meson6-atv1200
 DTSI/DTS
Date: Sun, 17 Aug 2014 17:21:23 +0200
Message-ID: <CAOQ7t2Ye2FjB-+YYQJg6xnFyfj4VNpdm9NFqjE2A+inTZ1=BkQ@mail.gmail.com>
References: <1408272594-10814-1-git-send-email-carlo@caione.org>
	<1408272594-10814-6-git-send-email-carlo@caione.org>
	<20140817144201.GB29963@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-oi0-f53.google.com ([209.85.218.53]:54680 "EHLO
	mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751725AbaHQPVY (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 17 Aug 2014 11:21:24 -0400
In-Reply-To: <20140817144201.GB29963@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Beniamino Galvani <b.galvani@gmail.com>
Cc: Carlo Caione <carlo@caione.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, devicetree <devicetree@vger.kernel.org>, linux-serial@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, robh+dt@kernel.org, Mark Rutland <mark.rutland@arm.com>, ijc+devicetree@hellion.org.uk, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, gregkh@linuxfoundation.org, jslaby@suse.cz, Grant Likely <grant.likely@linaro.org>

On Sun, Aug 17, 2014 at 4:42 PM, Beniamino Galvani <b.galvani@gmail.com> wrote:
> Hi,

>> +/include/ "meson.dtsi"
>> +
>> +/ {
>> +     model = "Amlogic Meson6 SoC";
>> +     compatible = "amlogic,meson6", "amlogic,8726_mx";
>> +
>> +     interrupt-parent = <&gic>;
>> +
>> +     cpus {
>> +             #address-cells = <1>;
>> +             #size-cells = <0>;
>> +
>> +             cpu@0 {
>
> The address after the @ should match the value of the 'reg' property.

Agree

>> +                     device_type = "cpu";
>> +                     compatible = "arm,cortex-a9";
>> +                     reg = <0x200>;
>> +             };
>> +
>> +             cpu@1 {
>> +                     device_type = "cpu";
>> +                     compatible = "arm,cortex-a9";
>> +                     reg = <0x1>;
>
> According to Documentation/devicetree/bindings/arm/cpus.txt, this
> should be set to bits [23:0] of the CPU MPIDR register, in this case
> 0x201.

Right. Thanks for noticing.
I will fix it in v2.

Thank you,

-- 
Carlo Caione
