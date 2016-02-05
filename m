From: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v2 08/12] devicetree: bindings: add DT binding for the Marvell Armada 3700 SoC family
Date: Fri, 05 Feb 2016 17:03:23 +0100
Message-ID: <87r3gr2lh0.fsf@free-electrons.com>
References: <1454524889-9207-1-git-send-email-gregory.clement@free-electrons.com>
	<1454524889-9207-9-git-send-email-gregory.clement@free-electrons.com>
	<20160203213825.4fa6a0ef@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160203213825.4fa6a0ef-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> (Thomas Petazzoni's
	message of "Wed, 3 Feb 2016 21:38:25 +0100")
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, arm-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Lior Amsalem <alior-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Omri Itach <omrii-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

Hi Thomas,
=20
 On mer., f=C3=A9vr. 03 2016, Thomas Petazzoni <thomas.petazzoni@free-e=
lectrons.com> wrote:

> Hello,
>
> On Wed,  3 Feb 2016 19:41:25 +0100, Gregory CLEMENT wrote:
>> The Marvell Armada 3700 is a family of ARMv8 CA53 SoCs. This commit
>> introduces the Device Tree binding that documents the top-level
>> compatible strings for Armada 3700 based platforms.
>>=20
>> Signed-off-by: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
>> ---
>>  .../devicetree/bindings/arm/marvell/armada-37xx.txt      | 16 +++++=
+++++++++++
>>  1 file changed, 16 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/arm/marvell/ar=
mada-37xx.txt
>>=20
>> diff --git a/Documentation/devicetree/bindings/arm/marvell/armada-37=
xx.txt b/Documentation/devicetree/bindings/arm/marvell/armada-37xx.txt
>> new file mode 100644
>> index 000000000000..17e90e8b5f76
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/marvell/armada-37xx.txt
>> @@ -0,0 +1,16 @@
>> +Marvell Armada 37xx Platforms Device Tree Bindings
>> +--------------------------------------------------
>> +
>> +Boards using a SoC of the Marvell Armada 37xx family must carry the
>> +following root node property:
>> +
>> + - compatible: must contain "marvell,armada3710"
>
> Are we sure at this point that the 3720 is a strict super-set of the
> 3710 ?

I think we are in the same situation with the Armada 380 with the other
Armada 38x. At this point the 3720 is a super-set of the 3710.

>
> If that's not the case, then it would be somewhat weird for a platfor=
m
> using the 3720 platform to carry the marvell,armada3710 compatible
> string, no?

Actually, we only said that the 3720 is compatible with the 3710 not
really a strict super-set. More over, for a 3720 we must use
marvell,armada3720 _and_ marvell,armada3710, and in case of conflict
marvell,armada3720 must be used.

I really prefer using marvell,armada3710 as common compatible for all
the Armada 3700 SoCs, that having no common compatible at all.

Thanks,

Gregory

>
> Thomas
> --=20
> Thomas Petazzoni, CTO, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com

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
