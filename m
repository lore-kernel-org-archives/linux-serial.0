Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A47DC433F5
	for <linux-serial@archiver.kernel.org>; Thu, 16 Dec 2021 21:58:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237313AbhLPV6m (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 16 Dec 2021 16:58:42 -0500
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:53055 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234459AbhLPV6m (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 16 Dec 2021 16:58:42 -0500
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.94)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1mxylo-001skq-DA; Thu, 16 Dec 2021 22:58:36 +0100
Received: from p5b13a809.dip0.t-ipconnect.de ([91.19.168.9] helo=[192.168.178.81])
          by inpost2.zedat.fu-berlin.de (Exim 4.94)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1mxylm-0048uL-M8; Thu, 16 Dec 2021 22:58:36 +0100
Message-ID: <d372fa08-b935-f13a-e003-805a4b09aa57@physik.fu-berlin.de>
Date:   Thu, 16 Dec 2021 22:58:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] serial: 8250: Move alpha-specific quirk out of the core
Content-Language: en-US
To:     Ulrich Teichert <krypton@ulrich-teichert.org>,
        Lukas Wunner <lukas@wunner.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        Philipp Rosenberger <p.rosenberger@kunbus.com>
References: <202112162036.1BGKaKGI003165@valdese.nms.ulrich-teichert.org>
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
In-Reply-To: <202112162036.1BGKaKGI003165@valdese.nms.ulrich-teichert.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 91.19.168.9
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Ulrich!

On 12/16/21 21:36, Ulrich Teichert wrote:
> Wouldn't that mean that you can't use a generic Alpha kernel on the Jensen
> anymore? CONFIG_ALPHA_JENSEN is only set if you specifically select the
> Jensen as target, not when you build a generic kernel. That would be a step
> back in my opinion, as the Debian generic kernel from debian-ports did
> as least boot up on real hardware and the serial console worked just fine
> [granted, the EISA cards were not detected, even after support for it
> got enabled, but that's another case of worms].

If you could figure out what kernel option we might be missing for the Jensen
machine to get EISA working, please let me know. I only have newer Alphas myself,
so I am relying on your debugging help here.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

