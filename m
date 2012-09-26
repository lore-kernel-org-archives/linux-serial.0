From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] RFC: serial: pl011: allow very high baudrates
Date: Wed, 26 Sep 2012 10:03:31 +0200
Message-ID: <CACRpkdb_+RaVP+vX9hutnhDNfZTUcsLnPsTr8_bY_t_yt8Ni-g@mail.gmail.com>
References: <1348250399-5651-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:41114 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752943Ab2IZIDc (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 26 Sep 2012 04:03:32 -0400
Received: by wgbdr13 with SMTP id dr13so277164wgb.1
        for <linux-serial@vger.kernel.org>; Wed, 26 Sep 2012 01:03:31 -0700 (PDT)
In-Reply-To: <1348250399-5651-1-git-send-email-linus.walleij@stericsson.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Linus Walleij <linus.walleij@stericsson.com>
Cc: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <linux@arm.linux.org.uk>, Alan Cox <alan@linux.intel.com>, linux-arm-kernel@lists.infradead.org, Anmar Oueja <anmar.oueja@linaro.org>, Par-Gunnar Hjalmdahl <par-gunnar.hjalmdahl@stericsson.com>, Guillaume Jaunet <guillaume.jaunet@stericsson.com>, Christophe Arnal <christophe.arnal@stericsson.com>, Matthias Locher <matthias.locher@stericsson.com>, Rajanikanth HV <rajanikanth.hv@stericsson.com>

On Fri, Sep 21, 2012 at 7:59 PM, Linus Walleij
<linus.walleij@stericsson.com> wrote:

> From: Linus Walleij <linus.walleij@linaro.org>
>
> The ST Microelectronics variant of the PL011 is capable of supporting
> very high non-standard baud rates, even above 4 Mbps. Mostly this
> works, but when we try to use 4050000 baud, the code in
> tty_termios_encode_baud_rate(), which is called from
> uart_get_baud_rate() will do some fuzzy matching and "snap" the
> baudrate to 4000000 baud, which happens to be in the baud_table[].

So I've found the right solution to this problem, Greg ignore
this patch.

Yours,
Linus Walleij
