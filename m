From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 5/9] ARM: meson6: clocksource: add Meson6 timer support
Date: Thu, 11 Sep 2014 22:57:17 +0200
Message-ID: <3053926.qBD36ymAOD@wuerfel>
References: <1410466300-19168-1-git-send-email-carlo@caione.org> <1410466300-19168-6-git-send-email-carlo@caione.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:62281 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751143AbaIKU57 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 11 Sep 2014 16:57:59 -0400
In-Reply-To: <1410466300-19168-6-git-send-email-carlo@caione.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Carlo Caione <carlo@caione.org>, devicetree@vger.kernel.org, linux-serial@vger.kernel.org, linux@arm.linux.org.uk, robh+dt@kernel.org, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, daniel.lezcano@linaro.org, tglx@linutronix.de, gregkh@linuxfoundation.org, jslaby@suse.cz, grant.likely@linaro.org, b.galvani@gmail.com, maxime.ripard@free-electrons.com, afaerber@suse.de, matthias.bgg@gmail.com

On Thursday 11 September 2014 22:11:36 Carlo Caione wrote:
> Meson6 SoCs are equipped with 5 32-bit timers, called TIMER_A, TIMER_B,
> TIMER_C, TIMER_D and TIMER_E.
> 
> The driver is providing clocksource support for the 32-bit counter using
> TIMER_E. Clockevents are also supported using TIMER_A.
> 
> Signed-off-by: Carlo Caione <carlo@caione.org>
> 

Acked-by: Arnd Bergmann <arnd@arndb.de>

We should take all the platform code through the arm-soc tree, this one
along with the DT binding document should go through the clocksource
tree.
