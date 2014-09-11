From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 0/9] ARM: meson: add preliminary support for MesonX/Meson6 SoCs
Date: Thu, 11 Sep 2014 23:01:25 +0200
Message-ID: <6559897.Lg8qnr2oFx@wuerfel>
References: <1410466300-19168-1-git-send-email-carlo@caione.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:49287 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754970AbaIKVBj (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 11 Sep 2014 17:01:39 -0400
In-Reply-To: <1410466300-19168-1-git-send-email-carlo@caione.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Carlo Caione <carlo@caione.org>, devicetree@vger.kernel.org, linux-serial@vger.kernel.org, linux@arm.linux.org.uk, robh+dt@kernel.org, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, daniel.lezcano@linaro.org, tglx@linutronix.de, gregkh@linuxfoundation.org, jslaby@suse.cz, grant.likely@linaro.org, b.galvani@gmail.com, maxime.ripard@free-electrons.com, afaerber@suse.de, matthias.bgg@gmail.com

On Thursday 11 September 2014 22:11:31 Carlo Caione wrote:
> Amlogic AML8726-MX (codename Meson6) is a highly integrated multimedia
> application processor SoC for Multimedia Internet Device (MID), tablet
> and Set Top Box (STB). It integrates a powerful CPU, a 2D/3D graphics
> subsystem and a state-of-the-art video decoding engine together with
> all major peripherals. It is manufactured by Amlogic, inc.
> 
> This patchset introduces preliminary support for Meson6-based SoCs but
> several IPs and drivers are common among all the MesonX SoCs.
> 
> Amlogic doesn't release any documentation about their SoCs, so the code
> has been reverse-engineered from the messy source code released at:
> 
> http://openlinux.amlogic.com:8000/download/

I don't remember seeing v1 of the patch set, but this looks awesome.

Unless there are further review comments in the next few days, please
send a patches 1 and 6-9 to arm@kernel.org with a request to merge them
for 3.18.

	ARnd
