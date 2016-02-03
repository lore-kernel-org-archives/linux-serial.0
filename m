From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: [PATCH 03/10] arm64: add Armada 3700 architecture entry
Date: Wed, 03 Feb 2016 12:13:40 +0100
Message-ID: <8737ta59nf.fsf@free-electrons.com>
References: <1454436468-4241-1-git-send-email-gregory.clement@free-electrons.com>
	<20160203142451.41381ff6@xhacker> <87k2mm5itx.fsf@free-electrons.com>
	<4284367.sAeqrVzAbo@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
In-Reply-To: <4284367.sAeqrVzAbo@wuerfel> (Arnd Bergmann's message of "Wed, 03
	Feb 2016 10:11:18 +0100")
Sender: linux-ide-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jisheng Zhang <jszhang@marvell.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, arm@kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Jonathan Corbet <corbet@lwn.net>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-ide@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, Tejun Heo <tj@kernel.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Hi Arnd,
=20
 On mer., f=C3=A9vr. 03 2016, Arnd Bergmann <arnd@arndb.de> wrote:

> On Wednesday 03 February 2016 08:55:22 Gregory CLEMENT wrote:
>> >>=20
>> >> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.pl=
atforms
>> >> index 21074f674bde..7da341f7b90d 100644
>> >> --- a/arch/arm64/Kconfig.platforms
>> >> +++ b/arch/arm64/Kconfig.platforms
>> >> @@ -1,5 +1,11 @@
>> >>  menu "Platform selection"
>> >> =20
>> >> +config ARCH_ARMADA_3700
>> >
>> > Would it be better to use ARCH_MVEBU? IMHO, there will be more ARM=
v8 SoCs
>> > from our EBU, do we plan to add one CONFIG_ARMADA_yyzz for each So=
C?
>>=20
>> Not for each SoC but for each family, yes. As we did for the other m=
vebu
>> SoC families.
>>=20
>
> We tend to use a little more general config strings for arm64 than we=
 have
> for arm32. I think just using ARCH_MVEBU is fine here, no need to lis=
t
> the 3700 series separately.

OK, for the arm32 mvebu SoC, the CONFIG_ARMADA_ were barely used, and
CONFIG_ARCH_MVEBU is mostly use as a "depends on" and do not force
anything.

The only annoying point was with the irqchip, but thanks to the last
series sent by Thomas irq-armada-370-xp.c won't be inconditionnaly buil=
t
if CONFIG_ARCH_MVEBU is selected.

So OK I will use CONFIG_ARCH_MVEBU.

Thanks,

Gregory



> 	Arnd

--=20
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
