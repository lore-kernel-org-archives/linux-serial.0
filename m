From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH 03/10] arm64: add Armada 3700 architecture entry
Date: Wed, 03 Feb 2016 10:11:18 +0100
Message-ID: <4284367.sAeqrVzAbo@wuerfel>
References: <1454436468-4241-1-git-send-email-gregory.clement@free-electrons.com> <20160203142451.41381ff6@xhacker> <87k2mm5itx.fsf@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87k2mm5itx.fsf-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Jisheng Zhang <jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, arm-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Wednesday 03 February 2016 08:55:22 Gregory CLEMENT wrote:
> >> 
> >> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
> >> index 21074f674bde..7da341f7b90d 100644
> >> --- a/arch/arm64/Kconfig.platforms
> >> +++ b/arch/arm64/Kconfig.platforms
> >> @@ -1,5 +1,11 @@
> >>  menu "Platform selection"
> >>  
> >> +config ARCH_ARMADA_3700
> >
> > Would it be better to use ARCH_MVEBU? IMHO, there will be more ARMv8 SoCs
> > from our EBU, do we plan to add one CONFIG_ARMADA_yyzz for each SoC?
> 
> Not for each SoC but for each family, yes. As we did for the other mvebu
> SoC families.
> 

We tend to use a little more general config strings for arm64 than we have
for arm32. I think just using ARCH_MVEBU is fine here, no need to list
the 3700 series separately.

	Arnd
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
