From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/4] ARM/serial: at91: move machine quirk into machine
Date: Tue, 5 Nov 2013 13:33:22 +0100
Message-ID: <CACRpkdbDksG=BW_udAV9vt7nP-Yqj1k9fkz9-5WS4qdeiWYy+Q@mail.gmail.com>
References: <1383643722-14189-1-git-send-email-linus.walleij@linaro.org>
	<5278D20C.50906@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-oa0-f49.google.com ([209.85.219.49]:33521 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754476Ab3KEMdX (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 5 Nov 2013 07:33:23 -0500
Received: by mail-oa0-f49.google.com with SMTP id l6so456219oag.36
        for <linux-serial@vger.kernel.org>; Tue, 05 Nov 2013 04:33:22 -0800 (PST)
In-Reply-To: <5278D20C.50906@atmel.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Andrew Victor <linux@maxim.org.za>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexandre Courbot <acourbot@nvidia.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Tue, Nov 5, 2013 at 12:10 PM, Nicolas Ferre <nicolas.ferre@atmel.com> wrote:
> On 05/11/2013 10:28, Linus Walleij :

> I do think that we have to remove this dependency but the only thing that
> embarrasses me is that your change only allows non-DT at91rm9200 to work
> well with its RTS line.
> If we use Device Tree with this product (which is actually possible) we
> don't have this feature available anymore...

You can still supply the callback into the machine using
AUXDATA if you wish.

But I can do the thing mentioned in the commit message and
switch the driver to use gpiolib instead, I'll send another patch,
can you please test it...

Yours,
Linus Walleij
