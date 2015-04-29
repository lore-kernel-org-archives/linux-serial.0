From: Vineet Gupta <Vineet.Gupta1-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v3 3/3] arm64: dts: Add mediatek MT8173 earlycon support
Date: Wed, 29 Apr 2015 08:19:02 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA230756659C0C2@IN01WEMBXB.internal.synopsys.com>
References: <1430228434-31779-1-git-send-email-eddie.huang@mediatek.com>
 <1430228434-31779-4-git-send-email-eddie.huang@mediatek.com>
 <20150429064454.GR6325@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org" <srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>, Howard Chen <ibanezchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ashwin Chaugule <ashwin.chaugule-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>, Wang Long <long.wanglong-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Kevin Cernekee <cernekee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>linu
List-Id: linux-serial@vger.kernel.org

On Wednesday 29 April 2015 12:15 PM, Sascha Hauer wrote:
> Hi Eddie,
>
> On Tue, Apr 28, 2015 at 09:40:34PM +0800, Eddie Huang wrote:
>> Add earlycon support to mediatek MT8173 evaluation board dts.
> This is not about earlycon support. It adds the stdout-path property
> which is generally about console.

Indeed, this is shorter way of specifying the default console by referring to uart
device.

>  It only happens to used for earlycon,
> but would be used as a regular console aswell if it wasn't broken for
> some kernel revisisions.

Really - I'm confused. When I last tried this for arc_uart (in 3.17 time frame),
it would setup default console, but to use it for earlycon we needed
bootargs=earlycon in chosen. However I had to revet that change since OF core
still was fixing a few things in that area.

See mainline 22524b02b17b901f28 ("Revert "ARC: [arcfpga] stdout-path now suffices
for earlycon/console"")

-Vineet

>
>>  
>> -	chosen { };
>> +	chosen {
>> +		linux,stdout-path = &uart0;
>> +	};
> Please use stdout-path, without the 'linux,'.
>
> Sascha
>

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
