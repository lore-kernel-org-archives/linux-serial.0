Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 992FBC433F5
	for <linux-serial@archiver.kernel.org>; Sun, 19 Dec 2021 17:41:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233452AbhLSRlU (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 19 Dec 2021 12:41:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233443AbhLSRlT (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 19 Dec 2021 12:41:19 -0500
Received: from wp441.webpack.hosteurope.de (wp441.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:85d2::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 740A6C061574;
        Sun, 19 Dec 2021 09:41:19 -0800 (PST)
Received: from [2a03:7846:b79f:101:21c:c4ff:fe1f:fd93] (helo=valdese.nms.ulrich-teichert.org); authenticated
        by wp441.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1mz0BQ-0002Hp-Bw; Sun, 19 Dec 2021 18:41:16 +0100
Received: from valdese.nms.ulrich-teichert.org (localhost [127.0.0.1])
        by valdese.nms.ulrich-teichert.org (8.15.2/8.15.2/Debian-8+deb9u1) with ESMTPS id 1BJHfElu008737
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 19 Dec 2021 18:41:14 +0100
Received: (from ut@localhost)
        by valdese.nms.ulrich-teichert.org (8.15.2/8.15.2/Submit) id 1BJHfEU8008736;
        Sun, 19 Dec 2021 18:41:14 +0100
Message-Id: <202112191741.1BJHfEU8008736@valdese.nms.ulrich-teichert.org>
Subject: Re: [PATCH] serial: 8250: Move alpha-specific quirk out of the core
To:     glaubitz@physik.fu-berlin.de (John Paul Adrian Glaubitz)
Date:   Sun, 19 Dec 2021 18:41:14 +0100 (CET)
Cc:     krypton@ulrich-teichert.org (Ulrich Teichert),
        lukas@wunner.de (Lukas Wunner),
        gregkh@linuxfoundation.org (Greg Kroah-Hartman),
        jirislaby@kernel.org (Jiri Slaby), linux-serial@vger.kernel.org,
        rmk+kernel@armlinux.org.uk (Russell King),
        torvalds@linux-foundation.org (Linus Torvalds),
        rth@twiddle.net (Richard Henderson),
        ink@jurassic.park.msu.ru (Ivan Kokshaysky),
        mattst88@gmail.com (Matt Turner), linux-alpha@vger.kernel.org,
        LinoSanfilippo@gmx.de (Lino Sanfilippo),
        p.rosenberger@kunbus.com (Philipp Rosenberger)
In-Reply-To: <d372fa08-b935-f13a-e003-805a4b09aa57@physik.fu-berlin.de>
From:   Ulrich Teichert <krypton@ulrich-teichert.org>
X-Mailer: ELM [version 2.5 PL8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;ut@ulrich-teichert.org;1639935679;a6000694;
X-HE-SMSGID: 1mz0BQ-0002Hp-Bw
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Adrian,

> On 12/16/21 21:36, Ulrich Teichert wrote:
> > Wouldn't that mean that you can't use a generic Alpha kernel on the Jensen
> > anymore? CONFIG_ALPHA_JENSEN is only set if you specifically select the
> > Jensen as target, not when you build a generic kernel. That would be a step
> > back in my opinion, as the Debian generic kernel from debian-ports did
> > as least boot up on real hardware and the serial console worked just fine
> > [granted, the EISA cards were not detected, even after support for it
> > got enabled, but that's another case of worms].
> 
> If you could figure out what kernel option we might be missing for the Jensen
> machine to get EISA working, please let me know. I only have newer Alphas myself,
> so I am relying on your debugging help here.

I know, I know, have been completely absorbed in real-live matters lately,
my apologies, but I will dig into that between xmas and new year,

promise,
CU,
Uli
-- 
Dipl. Inf. Ulrich Teichert|e-mail: Ulrich.Teichert@gmx.de | Listening to:
Stormweg 24               |Eat Lipstick: Dirty Little Secret, The Baboon Show:
24539 Neumuenster, Germany|Work Work Work, The Bellrays: Bad Reaction
