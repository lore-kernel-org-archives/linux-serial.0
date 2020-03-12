Return-Path: <SRS0=FKjJ=45=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30CCEC1975A
	for <linux-serial@archiver.kernel.org>; Thu, 12 Mar 2020 08:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 138FC206EB
	for <linux-serial@archiver.kernel.org>; Thu, 12 Mar 2020 08:19:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbgCLITG (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 12 Mar 2020 04:19:06 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:44173 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbgCLITG (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 12 Mar 2020 04:19:06 -0400
Received: from mail-qk1-f170.google.com ([209.85.222.170]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MiagL-1jr8Fb2jSh-00fmGH; Thu, 12 Mar 2020 09:19:04 +0100
Received: by mail-qk1-f170.google.com with SMTP id f28so4788394qkk.13;
        Thu, 12 Mar 2020 01:19:04 -0700 (PDT)
X-Gm-Message-State: ANhLgQ3ruQsrhq3lNqUzJf5mEhXBnTXX0Yvbp52P8o5BwTIIxLyJczag
        6DmUYEwWx9sSEW94cQPbUChOuuOxZ2FzQzf0JqA=
X-Google-Smtp-Source: ADFU+vuPtPEyegIJ1pPaVPT1TY9lSqZF2FVolLE80+77Sss8OE0uTHVZY9TkA/qLluF+/N3q9V82H7iO0p84lcRfxl8=
X-Received: by 2002:a37:8707:: with SMTP id j7mr4079152qkd.394.1584001143327;
 Thu, 12 Mar 2020 01:19:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200311225736.32147-1-rdunlap@infradead.org> <20200311225736.32147-3-rdunlap@infradead.org>
In-Reply-To: <20200311225736.32147-3-rdunlap@infradead.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 12 Mar 2020 09:18:47 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0LNFJ1srVAXrN6PKh9y9d4VXLz-NYRLsx5coF5uuS3_Q@mail.gmail.com>
Message-ID: <CAK8P3a0LNFJ1srVAXrN6PKh9y9d4VXLz-NYRLsx5coF5uuS3_Q@mail.gmail.com>
Subject: Re: [PATCH 2/3 v2] tty: source all tty Kconfig files in one place
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:9DolV4CgJV1q7IwQdYo4FMtlHDUWmWRTRIt+01gqSpE5XlDHjEJ
 6Jo1t4FOdka0/HmGpOpgaQQ6gb0u7UcTJ/hrcIWgORVFMkI7wqOYE60R5NSDySg71ap8HGf
 +0r5rAv5tKPDoKrjv2XReonGbF8Fe0pI/qG62caaZrd6uZIWibPFzG+yGMz75a21n7Hxfo1
 FzJlOWK4BI86U0YWBG/3g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:aq2ovGpGqWA=:Kpi7FWERJnslP8KkuSnWNr
 MKOGrZyV9FLNZHIQFm/koxCOIknR6cMzis7PtvXrZ2ZUdg00B2aaF71sDipoVlaUeWGWhbbOd
 OisoHfFkBV3mXRFBCWOFvjtb/6zYh1s2VTp8d+/8mruTuOBhwy1sUo6oczSZfH3HbxXLbzAR+
 DkHsNxfuaWmwyTqUa6dmEqxN4BJ8LvJJlPYE9VcxRD2KxSfNTRbCBYi/GhtrMCmixPy6ShESu
 N360BHPWKSACzxpB20joajQCTQnVabjHTh4M/BOD2snsJeatamuI1mqyx3qDRps0qBBu2Z5zc
 Q7+4ogPIe5n9ibuNDytnl4ucGr5/BIaZaVGNQEPqkjobLyIkFYAQo+6nmCYGzRciGTSDW7NFH
 l957KOo6syx1LFg1O+oHVFGW44OyO6FcafGkFeuyS7eu0L5Ofb8QIng11/Ss8mZdT4Kl0ZaAt
 ocbv0EqPa8IO1ePKzydVV7CHWBTZd7HHBTeKq1YOaUKRb9KAG6Wl0yMqnwnlk+DnncfZemQxW
 9TVDku86f6yZwx7CjoYZ6RqR9y6tsUvLoix4oDA43u2EA1FO7RlHAS1VPrFM7yMXtdy+0h0GU
 /4wxDxPe/qn4mlXC5TmdO2GOhOCGlKPnFgOuXrwdBSxbdJMnznDxY8OqcFnRqyf3wDNKDwlUi
 JmFDFkCpv71q8PuJVVCpjAspMNBu5GXGd8WnwMwAhEe0YT7ti8UpQCC88xyUR9m4jrsQJi97c
 3Rgztrbujawu0G1nKGjSHEaIHh4yBctpxXPDuMfQ6VXOiWTEzNTSSNyFFfo7Lh9Uh+U15ddL7
 YD+qV6LWkL5xByRl9ZMNQReyKNKdPpKI197KWLjL+YsGAHdI4s=
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Mar 11, 2020 at 11:57 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> 'source' (include) all of the tty/*/Kconfig files from
> drivers/tty/Kconfig instead of from drivers/char/Kconfig.
> This consolidates them both in source code and in menu
> presentation to the user.
>
> Move hvc/Kconfig and serial/Kconfig 'source' lines into the
> if TTY/endif block and remove the if TTY/endif blocks from
> those 2 files.
>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Suggested-by: Jiri Slaby <jslaby@suse.com>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jslaby@suse.com>
> Cc: linux-serial@vger.kernel.org
> ---
> v2: move hvc/Kconfig & serial/Kconfig lines and drop their if/endif blocks

Acked-by: Arnd Bergmann <arnd@arndb.de>
