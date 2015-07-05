From: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 4/9] arm: twr-k70f120m: timer driver for Kinetis SoC
Date: Sun, 5 Jul 2015 09:39:26 -0500
Message-ID: <CAL_Jsq+r9fNWqD9O8Kz7Tn7oCaiJv7fSjEJ5QNcf+YLO146wPw@mail.gmail.com>
References: <1435667250-28299-1-git-send-email-pawelo@king.net.pl>
 <1435667250-28299-5-git-send-email-pawelo@king.net.pl> <2939807.q7WvOoYzDX@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <2939807.q7WvOoYzDX@wuerfel>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Paul Osmialowski <pawelo-rhuoMcPwk82rDJvtcaxF/A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Michael Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Tue, Jun 30, 2015 at 3:43 PM, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org> wrote:
> On Tuesday 30 June 2015 14:27:25 Paul Osmialowski wrote:
>

>>  / {
>> +     aliases {
>> +             pit0 = &pit0;
>> +             pit1 = &pit1;
>> +             pit2 = &pit2;
>> +             pit3 = &pit3;
>> +     };
>> +
>>       soc {
>> +             pit@40037000 {
>> +                     compatible = "fsl,kinetis-pit-timer";
>> +                     reg = <0x40037000 0x100>;
>> +                     clocks = <&mcg_pclk_gate 5 23>;
>> +                     #address-cells = <1>;
>> +                     #size-cells = <1>;
>> +                     ranges;
>> +
>> +                     pit0: timer@40037100 {
>> +                             reg = <0x40037100 0x10>;
>> +                             interrupts = <68>;
>> +                             status = "disabled";
>> +                     };
>
> I don't think it's necessary to have both an alias
> and a label here. What do you use the alias for?

Yes, don't use aliases. If you really need a specific timer to be used
then there must be some feature it has or doesn't have (e.g. always
on, output compare pin, specific clock, etc.) Put those those
properties in DT if that is the case. See OMAP timers for a complex
example of this.

Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
