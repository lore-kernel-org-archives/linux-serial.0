From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] serial: pl011: implement workaround for CTS clear event issue
Date: Mon, 26 Mar 2012 11:14:56 +0200
Message-ID: <CACRpkdaHoDawAXnXSK4KG4L_fusbWny2-b=UOS8LcQh4pdQS2g@mail.gmail.com>
References: <1332748868-10172-1-git-send-email-linus.walleij@stericsson.com>
	<20120326081756.GI5611@n2100.arm.linux.org.uk>
	<2B1D156D95AE9B4EAD379CB9E465FE73255E4BB903@EXDCVYMBSTM005.EQ1STM.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:48011 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752738Ab2CZJO5 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 26 Mar 2012 05:14:57 -0400
Received: by obbeh20 with SMTP id eh20so4956785obb.19
        for <linux-serial@vger.kernel.org>; Mon, 26 Mar 2012 02:14:56 -0700 (PDT)
In-Reply-To: <2B1D156D95AE9B4EAD379CB9E465FE73255E4BB903@EXDCVYMBSTM005.EQ1STM.local>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Rajanikanth H V <rajanikanth.hv@stericsson.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Linus WALLEIJ <linus.walleij@stericsson.com>, Greg Kroah-Hartman <gregkh@suse.de>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Christophe ARNAL <christophe.arnal@stericsson.com>, Guillaume JAUNET <guillaume.jaunet@stericsson.com>, Matthias LOCHER <matthias.locher@stericsson.com>, Chanho Min <chanho0207@gmail.com>, Srinidhi KASAGAR <srinidhi.kasagar@stericsson.com>

On Mon, Mar 26, 2012 at 11:07 AM, Rajanikanth H V
<rajanikanth.hv@stericsson.com> wrote:

> As per my understanding, pass counter helps to identify/break the
> Deadlock situation and triggers bottom half handler in which
> Uart controller will be forced to reset (save and restore of UART register happens).

It was there before the fix for the deadlock situation found in ST hardwares,
which was solved by the tasklet, was ever introduced.

It has been around forever as a simple guard to stop the ISR from
going into a loop... which is nice coding practice anyway so let's
keep it.

Yours,
Linus Walleij
