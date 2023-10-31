Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6FB4C4167B
	for <linux-serial@archiver.kernel.org>; Tue, 31 Oct 2023 09:35:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343928AbjJaJfj (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 31 Oct 2023 05:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343944AbjJaJfi (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 31 Oct 2023 05:35:38 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 512D8B7;
        Tue, 31 Oct 2023 02:35:34 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9C75C1BF208;
        Tue, 31 Oct 2023 09:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1698744933;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n3XKuvd+q+DDx/4/LtaFkuULZmEMgjP7tMlhhkc6940=;
        b=kDTWWWfBRbS8JJnlwhk6rtBmf+O202sJqbdO/h6ndj/0WLThDi9sGzFQsNINcts+7nhmLu
        RlZQpyG3AvH65hp/msgEtEUZ22E9A5CSi6v4F4wmyi+HTHi8ZqOeD/Msu0QR7QLD9YELES
        K19fhKTRui2lVqOryzR8+ir1UM/U2alCHbS0ToorLYAmljw4+ZYiklhIb+rb04Lq57eWZS
        bZZE4lMPmZ0+LlNypmt5DwnR2WB6c2peUg4/LOdPH8sVYRQANQJYAfBYWlS6VTofujYzIo
        loNxrXgrOQmb+O7a8fuTZ1lUE8ZS98sXhUXi3k0+qgSrFoeBGCHgIZlQdzQmng==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 31 Oct 2023 10:35:29 +0100
Message-Id: <CWMITJ9VX9IP.1WPQCX981VRDE@tleb-bootlin-xps13-01>
Cc:     "Russell King" <linux@armlinux.org.uk>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Jiri Slaby" <jirislaby@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        "Gregory CLEMENT" <gregory.clement@bootlin.com>,
        "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
        "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>,
        "Vladimir Kondratiev" <vladimir.kondratiev@mobileye.com>,
        "Tawfik Bayouk" <tawfik.bayouk@mobileye.com>
To:     "Hugo Villeneuve" <hugo@hugovil.com>
From:   =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH 6/6] tty: serial: amba-pl011: Parse bits option as 5, 6,
 7 or 8 in _get_options
X-Mailer: aerc 0.15.2
References: <20231026-mbly-uart-v1-0-9258eea297d3@bootlin.com>
 <20231026-mbly-uart-v1-6-9258eea297d3@bootlin.com>
 <20231026105329.0ee9603563202bd2157a7d27@hugovil.com>
In-Reply-To: <20231026105329.0ee9603563202bd2157a7d27@hugovil.com>
X-GND-Sasl: theo.lebrun@bootlin.com
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hello,

On Thu Oct 26, 2023 at 4:53 PM CEST, Hugo Villeneuve wrote:
> On Thu, 26 Oct 2023 12:41:23 +0200
> Th=C3=A9o Lebrun <theo.lebrun@bootlin.com> wrote:
>
> Hi,
> I would change the commit title to better indicate that you add support
> for bits 5 and 6, which was missing.
>
> Maybe "Add support for 5 and 6 bits in..." ?
>
> > pl011_console_get_options() gets called to retrieve currently configure=
d
> > options from the registers. Previously, LCRH_TX.WLEN was being parsed
>
> It took me some time to understand your explanation :) Maybe change
> to:
>
> "Previously, only 7 or 8 bits were supported."
>
> > as either 7 or 8 (fallback). Hardware supports values from 5 to 8
>
> Add bits:
>
> "5 to 8 bits..."
>
> And indicate that this patch adds support for 5 and 6 bits.

I agree the whole commit message is unclear. Let's rewrite it. What do
you think of the following:

   tty: serial: amba-pl011: Allow parsing word length of 5/6 bits at consol=
e setup

   If no options are given at console setup, we parse hardware register
   LCRH_TX.WLEN for bits per word. We compare the value to the 7 bits
   value (UART01x_LCRH_WLEN_7). If the hardware is configured for 5, 6
   or 8 bits per word, we fallback to 8 bits.

   Change that behavior to parse the whole range available: from 5 to 8
   bits per word.

Note that we don't add support for 5/6 bits, we only update the parsing
of the regs (if no options are passed at setup) to reflect the current
hardware config. The behavior will be different only if the inherited
value (from reset/bootloader) is 5 or 6: previously we guessed 8 bits
word length, now we guess the right value.

What's your opinion on this new commit message?

Thanks!

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
