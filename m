From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/3] serial: pl011: safeguard against impossible baudrates
Date: Fri, 21 Sep 2012 10:26:52 +0200
Message-ID: <CACRpkdZXEnPpw6ZWuZL4Lt1qeHJJ6+WtMi41HtOb+BHiG4-+iw@mail.gmail.com>
References: <1348134346-25593-1-git-send-email-linus.walleij@stericsson.com>
	<20120920185748.GA15609@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:57849 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755896Ab2IUI0y (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 21 Sep 2012 04:26:54 -0400
Received: by weyx8 with SMTP id x8so1809890wey.19
        for <linux-serial@vger.kernel.org>; Fri, 21 Sep 2012 01:26:52 -0700 (PDT)
In-Reply-To: <20120920185748.GA15609@n2100.arm.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Linus Walleij <linus.walleij@stericsson.com>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Guillaume Jaunet <guillaume.jaunet@stericsson.com>, Par-Gunnar Hjalmdahl <par-gunnar.hjalmdahl@stericsson.com>, Anmar Oueja <anmar.oueja@linaro.org>, Matthias Locher <matthias.locher@stericsson.com>, "Rajanikanth H.V" <rajanikanth.hv@stericsson.com>, Christophe Arnal <christophe.arnal@stericsson.com>, linux-arm-kernel@lists.infradead.org

On Thu, Sep 20, 2012 at 8:57 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:

> uart_get_baud_rate() is there precisely to do the right thing for invalid
> baud rates, which is to fallback to the old termios setting (and update
> the new termios with that) if the old termios setting satisifies the
> limits, if not it falls back to something within the limited range.

Yeah, hm, passing 4800000 as max rate to this function and
requesting 4050000 returns 4000000... (Other high baud rates
such as 3250000 or 3000000 works fine) so there is some fishy
bug in there we're just duct-taping around, I'll go hunt the real bug
instead.

Thanks!
Linus Walleij
