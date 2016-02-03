From: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 03/10] arm64: add Armada 3700 architecture entry
Date: Wed, 03 Feb 2016 08:55:22 +0100
Message-ID: <87k2mm5itx.fsf@free-electrons.com>
References: <1454436468-4241-1-git-send-email-gregory.clement@free-electrons.com>
	<1454436468-4241-4-git-send-email-gregory.clement@free-electrons.com>
	<20160203142451.41381ff6@xhacker>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160203142451.41381ff6@xhacker> (Jisheng Zhang's message of
	"Wed, 3 Feb 2016 14:24:51 +0800")
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jisheng Zhang <jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Cc: Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, arm-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-serial@vger.kernel.org

Hi Jisheng,
=20
 On mer., f=C3=A9vr. 03 2016, Jisheng Zhang <jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org> wrote=
:

> On Tue, 2 Feb 2016 19:07:41 +0100 Gregory CLEMENT wrote:
>
>> The Armada 3700 is an mvebu ARM64 SoC using one or two Cortex-A53 co=
res
>> depending of the variant.
>>=20
>> Signed-off-by: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
>> Reviewed-by: Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
>> ---
>>  arch/arm64/Kconfig.platforms | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>=20
>> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platf=
orms
>> index 21074f674bde..7da341f7b90d 100644
>> --- a/arch/arm64/Kconfig.platforms
>> +++ b/arch/arm64/Kconfig.platforms
>> @@ -1,5 +1,11 @@
>>  menu "Platform selection"
>> =20
>> +config ARCH_ARMADA_3700
>
> Would it be better to use ARCH_MVEBU? IMHO, there will be more ARMv8 =
SoCs
> from our EBU, do we plan to add one CONFIG_ARMADA_yyzz for each SoC?

Not for each SoC but for each family, yes. As we did for the other mveb=
u
SoC families.

Gregory

>
>> +	bool "Armada 3700 SoC Family"
>> +	help
>> +	  This enables support for Armada 3700 SoC Family. It is is an
>> +	  ARMv8 based chipset belonging to the mvebu family.
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
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
