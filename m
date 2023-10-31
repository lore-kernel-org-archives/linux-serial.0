Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F99C4167D
	for <linux-serial@archiver.kernel.org>; Tue, 31 Oct 2023 11:04:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233601AbjJaLES (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 31 Oct 2023 07:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbjJaLER (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 31 Oct 2023 07:04:17 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E36FADF;
        Tue, 31 Oct 2023 04:04:13 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id B274DC0004;
        Tue, 31 Oct 2023 11:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1698750252;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gdH4ndnFFRWypp8VD9egRiAHe4ArCrVlink+NxvjNco=;
        b=no2UbQfmYmQ2oPoObwHZxxMVuHKMSVsWQe132gKW10ZGKFXxzq0kwps2F6wSOZIaIO64ik
        VZG2v1zF6eCg8tDHWodzkVlLvniRTEpZQgOTCQc+az8n+3UA4FjLvnk0KsIr1LQBzBzdf5
        O+EPcNvxzAR+Bhfw6dkmZ4jrLuGongRNvs5O6hybHt0tLzUrC9VZ8KytwLVd+v5F2G8GmF
        NCMJjPTemcZJSnfyeOGCADmvePqv/hIdGTQwiHeoVLfeEbfROqBgpIlbbwDvTT3Gjdu31R
        rP0eA33xpw8kQop64lorh9I8+fHoz61QCfzCFi7iL7peifhHnI4ZEEz1sygWzw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 31 Oct 2023 12:04:11 +0100
Message-Id: <CWMKPFZ9LOVD.2756QU9AP6U3W@tleb-bootlin-xps13-01>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
From:   =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH 6/6] tty: serial: amba-pl011: Parse bits option as 5, 6,
 7 or 8 in _get_options
Cc:     "Hugo Villeneuve" <hugo@hugovil.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Jiri Slaby" <jirislaby@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        "Gregory CLEMENT" <gregory.clement@bootlin.com>,
        "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
        "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>,
        "Vladimir Kondratiev" <vladimir.kondratiev@mobileye.com>,
        "Tawfik Bayouk" <tawfik.bayouk@mobileye.com>
X-Mailer: aerc 0.15.2
References: <20231026-mbly-uart-v1-0-9258eea297d3@bootlin.com>
 <20231026-mbly-uart-v1-6-9258eea297d3@bootlin.com>
 <20231026105329.0ee9603563202bd2157a7d27@hugovil.com>
 <CWMITJ9VX9IP.1WPQCX981VRDE@tleb-bootlin-xps13-01>
 <ZUDS5UpWlo+DUZc4@shell.armlinux.org.uk>
In-Reply-To: <ZUDS5UpWlo+DUZc4@shell.armlinux.org.uk>
X-GND-Sasl: theo.lebrun@bootlin.com
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hello,

On Tue Oct 31, 2023 at 11:11 AM CET, Russell King (Oracle) wrote:
> There is no point in supporting 5 or 6 bits for console usage. Think
> about it. What values are going to be sent over the console? It'll be
> ASCII, which requires at _least_ 7-bit. 6-bit would turn alpha
> characters into control characters, punctuation and numbers. 5-bit
> would be all control characters.
>
> So there's no point trying to do anything with 5 or 6 bits per byte,
> and I decided we might as well take that as an error (or maybe a
> case that the hardware has not been setup) and default to 8 bits per
> byte.

I see your point. Two things come to mind:

 - I added this parsing of 5/6 bits to be symmetrical with
   pl011_set_termios that handles 5/6 properly. Should pl011_set_termios
   be modified then?

 - If a value of 5 or 6 means the hardware has not been setup, shouldn't
   we ignore all other parsed values?

If you decide to keep the current behavior, I'd be down to adding a
comment to explicit this choice in pl011_console_get_options.

Regards,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

------------------------------------------------------------------------

