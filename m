Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BD50C433F5
	for <linux-serial@archiver.kernel.org>; Thu, 16 Dec 2021 21:19:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236291AbhLPVTE (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 16 Dec 2021 16:19:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234877AbhLPVTD (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 16 Dec 2021 16:19:03 -0500
X-Greylist: delayed 2558 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 16 Dec 2021 13:19:03 PST
Received: from wp441.webpack.hosteurope.de (wp441.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:85d2::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46BCAC061574;
        Thu, 16 Dec 2021 13:19:03 -0800 (PST)
Received: from [2a03:7846:b79f:101:21c:c4ff:fe1f:fd93] (helo=valdese.nms.ulrich-teichert.org); authenticated
        by wp441.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1mxxUE-0005iT-R9; Thu, 16 Dec 2021 21:36:22 +0100
Received: from valdese.nms.ulrich-teichert.org (localhost [127.0.0.1])
        by valdese.nms.ulrich-teichert.org (8.15.2/8.15.2/Debian-8+deb9u1) with ESMTPS id 1BGKaM5K003166
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Dec 2021 21:36:22 +0100
Received: (from ut@localhost)
        by valdese.nms.ulrich-teichert.org (8.15.2/8.15.2/Submit) id 1BGKaKGI003165;
        Thu, 16 Dec 2021 21:36:20 +0100
Message-Id: <202112162036.1BGKaKGI003165@valdese.nms.ulrich-teichert.org>
Subject: Re: [PATCH] serial: 8250: Move alpha-specific quirk out of the core
To:     lukas@wunner.de (Lukas Wunner)
Date:   Thu, 16 Dec 2021 21:36:20 +0100 (CET)
Cc:     gregkh@linuxfoundation.org (Greg Kroah-Hartman),
        jirislaby@kernel.org (Jiri Slaby), linux-serial@vger.kernel.org,
        rmk+kernel@armlinux.org.uk (Russell King),
        krypton@ulrich-teichert.org (Ulrich Teichert),
        torvalds@linux-foundation.org (Linus Torvalds),
        rth@twiddle.net (Richard Henderson),
        ink@jurassic.park.msu.ru (Ivan Kokshaysky),
        mattst88@gmail.com (Matt Turner), linux-alpha@vger.kernel.org,
        LinoSanfilippo@gmx.de (Lino Sanfilippo),
        p.rosenberger@kunbus.com (Philipp Rosenberger)
In-Reply-To: <af967f273724aff4cff3c49470110a48f790794e.1639676574.git.lukas@wunner.de>
From:   Ulrich Teichert <krypton@ulrich-teichert.org>
X-Mailer: ELM [version 2.5 PL8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;ut@ulrich-teichert.org;1639689543;e2e54a13;
X-HE-SMSGID: 1mxxUE-0005iT-R9
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Lukas,

> struct uart_8250_port contains mcr_mask and mcr_force members whose
> sole purpose is to work around an alpha-specific quirk.  This code
> doesn't belong in the core where it is executed by everyone else,
> so move it to a proper ->set_mctrl callback which is used on alpha only.
> 
> The alpha-specific quirk was introduced in January 1995:
> https://git.kernel.org/pub/scm/linux/kernel/git/history/history.git/diff/drivers/char/serial.c?h=1.1.83
> 
> The members in struct uart_8250_port were added in 2002:
> https://git.kernel.org/history/history/c/4524aad27854
> 
> The quirk applies to non-PCI alphas and arch/alpha/Kconfig specifies
> "select FORCE_PCI if !ALPHA_JENSEN".  So apparently the only affected
> machine is the EISA-based Jensen that Linus was working on back then:
> https://lore.kernel.org/all/CAHk-=wj1JWZ3sCrGz16nxEj7=0O+srMg6Ah3iPTDXSPKEws_SA@mail.gmail.com/
> 
> Up until now the quirk is not applied unless CONFIG_PCI is disabled.
> If users forget to do that, the serial ports aren't usable on Jensen
> and the machine may not boot in the first place.  Avoid by confining
> the quirk to CONFIG_ALPHA_JENSEN instead.

Wouldn't that mean that you can't use a generic Alpha kernel on the Jensen
anymore? CONFIG_ALPHA_JENSEN is only set if you specifically select the
Jensen as target, not when you build a generic kernel. That would be a step
back in my opinion, as the Debian generic kernel from debian-ports did
as least boot up on real hardware and the serial console worked just fine
[granted, the EISA cards were not detected, even after support for it
got enabled, but that's another case of worms].

Unfortunately I still can't boot my Jensen with a self-build kernel (that
it's the only Alpha without netboot makes it only harder), so
I can't even test your patch, but my plan is to get it booting over
my xmas vacation :-)

CU,
Uli
-- 
Dipl. Inf. Ulrich Teichert|e-mail: Ulrich.Teichert@gmx.de | Listening to:
Stormweg 24               |Eat Lipstick: Dirty Little Secret, The Baboon Show:
24539 Neumuenster, Germany|Work Work Work, The Bellrays: Bad Reaction
