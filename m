From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: [PATCH v3 05/12] arm64: add mvebu architecture entry
Date: Tue, 16 Feb 2016 18:03:14 +0100
Message-ID: <87a8n0twod.fsf@free-electrons.com>
References: <1454951660-13289-1-git-send-email-gregory.clement@free-electrons.com>
	<1454951660-13289-6-git-send-email-gregory.clement@free-electrons.com>
	<20160216141212.00f037e5@xhacker>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160216141212.00f037e5@xhacker> (Jisheng Zhang's message of
	"Tue, 16 Feb 2016 14:12:12 +0800")
Sender: linux-kernel-owner@vger.kernel.org
To: Jisheng Zhang <jszhang@marvell.com>
Cc: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, arm@kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Jonathan Corbet <corbet@lwn.net>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-ide@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Omri Itach <omrii@marvell.com>, linux-kernel@vger.kernel.org, Nadav Haklai <nadavh@marvell.com>, Hans de Goede <hdegoede@redhat.com>, Lior Amsalem <alior@marvell.com>, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, Tejun Heo <tj@kernel.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Hi Jisheng,
=20
 On mar., f=C3=A9vr. 16 2016, Jisheng Zhang <jszhang@marvell.com> wrote=
:

> Dear Gregory,
>
> On Mon, 8 Feb 2016 18:14:13 +0100 Gregory CLEMENT wrote:
>
>> The Armada 3700 is an mvebu ARM64 SoC using one or two Cortex-A53 co=
res
>> depending of the variant.
>>=20
>> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
>> Reviewed-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
>> ---
>>  arch/arm64/Kconfig.platforms | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>=20
>> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platf=
orms
>> index 21074f674bde..c621e69ed170 100644
>> --- a/arch/arm64/Kconfig.platforms
>> +++ b/arch/arm64/Kconfig.platforms
>> @@ -1,5 +1,11 @@
>>  menu "Platform selection"
>> =20
>> +config ARCH_MVEBU
>
> it's better to keep ARCH_YYZZ sorted in alphabetic order


Yes I should have move the entry when I renamed it.

I will sent a v4 soon for this point.

Gregory

>
> Thanks,
> Jisheng
>
>> +	bool "Marvell EBU SoC Family"
>> +	help
>> +	  This enables support for Marvell EBU family such as the
>> +	  Armada 3700 SoC family.
>> +
>>  config ARCH_BCM_IPROC
>>  	bool "Broadcom iProc SoC Family"
>>  	help
>

--=20
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
