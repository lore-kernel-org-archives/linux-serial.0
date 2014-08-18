From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH 4/7] ARM: meson: add basic support for MesonX SoCs
Date: Mon, 18 Aug 2014 17:10:39 +0200
Message-ID: <CABuKBeLSJkxPM_gyhGXN5pft0R4-+RrdiURuPwH9VxA-cSzQNQ@mail.gmail.com>
References: <1408272594-10814-1-git-send-email-carlo@caione.org>
	<1408272594-10814-5-git-send-email-carlo@caione.org>
	<20140817142115.GB15297@lukather>
	<20140818132713.GA28819@carlo-MacBookPro>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-oi0-f44.google.com ([209.85.218.44]:43441 "EHLO
	mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751665AbaHRPKk (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 18 Aug 2014 11:10:40 -0400
In-Reply-To: <20140818132713.GA28819@carlo-MacBookPro>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Carlo Caione <carlo@caione.org>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>, Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Russell King <linux@arm.linux.org.uk>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Greg KH <gregkh@linuxfoundation.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Beniamino Galvani <b.galvani@gmail.com>, Rob Herring <robh+dt@kernel.org>, linux-serial@vger.kernel.org, Grant Likely <grant.likely@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, jslaby@suse.cz, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

2014-08-18 15:27 GMT+02:00 Carlo Caione <carlo@caione.org>:
> On Sun, Aug 17, 2014 at 04:21:15PM +0200, Maxime Ripard wrote:
>> Hi Carlo,
>
> Hi Maxime,
> thank you for reviewing also these patches, I'll keep you in CC for the
> next revisions if you are interested.
>
>> > +static __init void meson_init_machine_devicetree(void)
>> > +{
>> > +   of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
>> > +}
>>
>> This is the default, you can just remove it
>
> Agree
>
>> > +static const char * const m6_common_board_compat[] = {
>> > +   "amlogic,8726_mx",
>> > +   "amlogic,8726_mxs",
>> > +   "amlogic,8726_mxl",
>> > +   "amlogic,meson6",
>>
>> Why are all those compatibles needed? Usually, you add a single one
>> per SoC (which would be the last in your case I guess.
>
> They are taken from the weird DTS in the original Amlogic sources but I
> guess you are right. I am actually more inclined to just leave "8726_mx"
> and "meson6" since online you can find equally both the versions for
> exactly the same SoCs.
>
>> > +   NULL,
>> > +};
>> > +
>> > +DT_MACHINE_START(AML8726_MX, "Amlogic Meson6 platform")
>> > +   .init_machine   = meson_init_machine_devicetree,
>>
>> And since you don't need the init machine, you can just use the
>> generic machine support. I'm not sure what's been decided on this,
>> should we remove such empty machines?
>
> I can get rid of the .init_machine but what about the .dt_compat field?

AFIAK there is no consensus about that.
For now I would leave the .dt_compat field. There are proposals which
try to get rid of the name_str
in the DT_MACHINE_START [0], but from what I know they are not yet merged.

Cheers,
Matthias

[0] http://lists.infradead.org/pipermail/linux-arm-kernel/2013-November/208878.html

>
> Thanks,
>
> --
> Carlo Caione
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel



-- 
motzblog.wordpress.com
