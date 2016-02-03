From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: [PATCH 01/10] serial: mvebu-uart: initial support for Armada-3700 serial port
Date: Wed, 03 Feb 2016 17:56:56 +0100
Message-ID: <87egct4trb.fsf@free-electrons.com>
References: <1454436468-4241-1-git-send-email-gregory.clement@free-electrons.com>
	<1454436468-4241-2-git-send-email-gregory.clement@free-electrons.com>
	<20160202182842.GD29778@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
In-Reply-To: <20160202182842.GD29778@leverpostej> (Mark Rutland's message of
	"Tue, 2 Feb 2016 18:28:42 +0000")
Sender: linux-ide-owner@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, arm@kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Jonathan Corbet <corbet@lwn.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, Tejun Heo <tj@kernel.org>, Hans de Goede <hdegoede@redhat.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Wilson Ding <dingwei@marvell.com>, Nadav Haklai <nadavh@marvell.com>
List-Id: linux-serial@vger.kernel.org

Hi Mark,
=20
 On mar., f=C3=A9vr. 02 2016, Mark Rutland <mark.rutland@arm.com> wrote=
:

>> diff --git a/Documentation/devicetree/bindings/tty/serial/mvebu-uart=
=2Etxt b/Documentation/devicetree/bindings/tty/serial/mvebu-uart.txt
>> new file mode 100644
>> index 000000000000..6087defd9f93
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/tty/serial/mvebu-uart.txt
>> @@ -0,0 +1,13 @@
>> +* Marvell UART : Non standard UART used in some of Marvell EBU SoCs=
 (e.g., Armada-3700)
>> +
>> +Required properties:
>> +- compatible: "marvell,armada-3700-uart"
>> +- reg: offset and length of the register set for the device.
>> +- interrupts: device interrupt
>> +
>> +Example:
>> +	serial@12000 {
>> +		compatible =3D "marvell,armada-3700-uart";
>> +		reg =3D <0x12000 0x400>;
>> +		interrupts =3D <43>;
>> +	};
>
> There are no external clock inputs?

Right, even if we don't use it in the driver we should ad it in the
binding because there is an external clock input.

>
>> diff --git a/Documentation/kernel-parameters.txt b/Documentation/ker=
nel-parameters.txt
>> index 87d40a72f6a1..198f6bd56e84 100644
>> --- a/Documentation/kernel-parameters.txt
>> +++ b/Documentation/kernel-parameters.txt
>> @@ -1058,6 +1058,12 @@ bytes respectively. Such letter suffixes can =
also be entirely omitted.
>>  			A valid base address must be provided, and the serial
>>  			port must already be setup and configured.
>> =20
>> +		mvebu_uart,<addr>
>> +			Start an early, polled-mode console on an some mvebu
>> +			SoC (as the Armada-3700) serial port at the specified
>> +			address. The serial port must already be setup and
>> +			configured. Options are not yet supported.
>> +
>
> Does the the mvebu UART vary between platforms at all?

I am not sure to undersatnd your question.

If you asked about the UART used on the other mvebu SoCs then my answer
is: on all the other mvebu SoC until now third party IPs were used. Thi=
s
one is the first one dedicated to an mevbu SoC and currently only used
on Armada 3700 but I don't know what are the plan for the future mvebu
SoCs.

Gregory

--=20
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
