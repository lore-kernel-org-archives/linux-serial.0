From: John Garry <john.garry-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH V5 1/3] ARM64 LPC: Indirect ISA port IO introduced
Date: Wed, 9 Nov 2016 11:29:46 +0000
Message-ID: <6dee9821-5145-2113-e391-6317e4533c06@huawei.com>
References: <1478576829-112707-1-git-send-email-yuanzhichang@hisilicon.com>
 <8adfe182-4939-479d-6013-25ec40021b20@huawei.com>
 <20161108164948.GG20591@arm.com> <2479288.4UmF9SBrq1@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <2479288.4UmF9SBrq1@wuerfel>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, mark.rutland-5wv7dgnIgG8@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, gabriele.paoloni-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, liviu.dudau-5wv7dgnIgG8@public.gmane.org, linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, minyard-HInyCGIudOg@public.gmane.org, xuwei5-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, zhichang.yuan02-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, kantyzc-9Onoh4P/yGk@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "zhichang.yuan" <yuanzhichang-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>, zourongrong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On 08/11/2016 22:35, Arnd Bergmann wrote:
> On Tuesday, November 8, 2016 4:49:49 PM CET Will Deacon wrote:
>> On Tue, Nov 08, 2016 at 04:33:44PM +0000, John Garry wrote:
>>> On 08/11/2016 16:12, Will Deacon wrote:
>>>> On Tue, Nov 08, 2016 at 11:47:07AM +0800, zhichang.yuan wrote:
>
>>>> Is there no way to make this slightly more generic, so that it can be
>>>> re-used elsewhere? For example, if struct extio_ops was common, then
>>>> you could have the singleton (which maybe should be an interval tree?),
>>>> type definition, setter function and the BUILD_EXTIO invocations
>>>> somewhere generic, rather than squirelled away in the arch backend.
>>>>
>>> The concern would be that some architecture which uses generic higher-level
>>> ISA accessor ops, but have IO space, could be affected.
>>
>> You're already adding a Kconfig symbol for this stuff, so you can keep
>> that if you don't want it on other architectures. I'm just arguing that
>> plumbing drivers directly into arch code via arm64_set_extops is not
>> something I'm particularly fond of, especially when it looks like it
>> could be avoided with a small amount of effort.
>
> Agreed, I initially suggested putting this into arch/arm64/, but there isn't
> really a reason why it couldn't just live in lib/ with the header file
> bits moved to include/asm-generic/io.h which we already use.
>

Right, Zhichang will check the logistics of this. The generic io.h is 
quite clean, so as long as you don't mind new build switches of this 
nature being added, it should be ok; and we'll plan on moving extio.h 
into include/asm-generic as well.

Cheers,
John

> 	Arnd
>
> .
>


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
