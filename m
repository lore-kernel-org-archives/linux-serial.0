From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v2 5/9] ARM: meson6: clocksource: add Meson6 timer support
Date: Tue, 16 Sep 2014 11:06:37 +0200
Message-ID: <CABuKBeKSkT6k-EaqN17Exf5Qhd6cWJg_qESskrADtRU+_t4-tQ@mail.gmail.com>
References: <1410466300-19168-1-git-send-email-carlo@caione.org>
	<1410466300-19168-6-git-send-email-carlo@caione.org>
	<3053926.qBD36ymAOD@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-la0-f42.google.com ([209.85.215.42]:56857 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753364AbaIPJGj (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 16 Sep 2014 05:06:39 -0400
In-Reply-To: <3053926.qBD36ymAOD@wuerfel>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Carlo Caione <carlo@caione.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linux-serial@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Greg KH <gregkh@linuxfoundation.org>, jslaby@suse.cz, Grant Likely <grant.likely@linaro.org>, Beniamino Galvani <b.galvani@gmail.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, =?ISO-8859-1?Q?Andreas_F=E4rber?= <afaerber@suse.de>

2014-09-11 22:57 GMT+02:00 Arnd Bergmann <arnd@arndb.de>:
> On Thursday 11 September 2014 22:11:36 Carlo Caione wrote:
>> Meson6 SoCs are equipped with 5 32-bit timers, called TIMER_A, TIMER_B,
>> TIMER_C, TIMER_D and TIMER_E.
>>
>> The driver is providing clocksource support for the 32-bit counter using
>> TIMER_E. Clockevents are also supported using TIMER_A.
>>
>> Signed-off-by: Carlo Caione <carlo@caione.org>
>>

This version addresses all the comments I had:

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
>
> We should take all the platform code through the arm-soc tree, this one
> along with the DT binding document should go through the clocksource
> tree.



-- 
motzblog.wordpress.com
