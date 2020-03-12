Return-Path: <SRS0=FKjJ=45=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA11CC10DCE
	for <linux-serial@archiver.kernel.org>; Thu, 12 Mar 2020 08:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEF62206EB
	for <linux-serial@archiver.kernel.org>; Thu, 12 Mar 2020 08:21:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbgCLIVq (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 12 Mar 2020 04:21:46 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:52263 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbgCLIVq (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 12 Mar 2020 04:21:46 -0400
Received: from mail-qt1-f180.google.com ([209.85.160.180]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MIxmm-1it05q2ztK-00KOMq; Thu, 12 Mar 2020 09:21:44 +0100
Received: by mail-qt1-f180.google.com with SMTP id m33so3657984qtb.3;
        Thu, 12 Mar 2020 01:21:44 -0700 (PDT)
X-Gm-Message-State: ANhLgQ1A/IfHUyqD3GeB85kBOFDXJP9EBXp/bjL2OVWjwCovuNgYb+gV
        pl2Z0oXc/SWU0ZH4Yx0LD3ad5+KrEpKqyBLdVQA=
X-Google-Smtp-Source: ADFU+vtOQNPznjYe/Sy/lYyrfux9hY5ptAw2nqB8sEyYtJ/TLiMgVZg/2vWZibfn8pDuNY2sEmExUqnpy/rOO3Z723o=
X-Received: by 2002:aed:3b4c:: with SMTP id q12mr6098643qte.18.1584001303366;
 Thu, 12 Mar 2020 01:21:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200311225736.32147-1-rdunlap@infradead.org> <20200311225736.32147-4-rdunlap@infradead.org>
In-Reply-To: <20200311225736.32147-4-rdunlap@infradead.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 12 Mar 2020 09:21:27 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3RJ=6Gdz-GGGoqB9n9TRdhpuYwwiJO1mJ8500OguYpAg@mail.gmail.com>
Message-ID: <CAK8P3a3RJ=6Gdz-GGGoqB9n9TRdhpuYwwiJO1mJ8500OguYpAg@mail.gmail.com>
Subject: Re: [PATCH 3/3 v2] tty: reorganize tty & serial menus
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:krMIOC6iue83XsEuQ/nY9eWlQawjPX2hCkjC9gf+NWTIQRqwxPj
 ji5rVchQb1tloRlX90KtJBU8HhIUL6PUMv5Icb9vYEkuDICGa1YyTYZ3jRmGr3+2lv7UJ8l
 cAZ0Z9nubCNPdqNChGFIZT632CK5P8gxqmWair328X4SDi+EDM+nSXbURkOrPfoIcju2jY9
 prAuSXwOA3jpy6iKIcnew==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jTxOpbX2+ek=:+1VQYEqz2i0UmlerZRJFqE
 rBmc11qY5a+A52yJIGsdHDfw/JT2cRUlnV2TATuRrxqVYzxtb2ZV1KvntbSBvaAElU+HR64fR
 6AVdp2YlPxXQkcHD60ZP9o5oKLMmsgZqS2VnCP2xC7s38wUUDqqg9AGhdoXrHvKISOo8jdEF4
 +VL5j5ZXGpCp6ufpFvPn6JErwCHzwz6vFe7LEIZKwavch56BgcvGWeJ9pTv/Y+ILaJoZ63Psy
 Uh+rXp7QpFR9jcdG5yP5PjE5DTAwLmerZOEDVMsgogi0FwzoeZlv8lY6eDJoK1CaI7hngRmku
 Gza6jIb4an4cdk+h8sDluHFuSH5RO42SX+2x+PMOmpKjgiJcLLa1ihOv+L7tBJSY11fX8BEZL
 pm7jw0P/RWqv/015cQ1ReTs9n2hUdXAASgzgrdYaPsFkILing1xcKdDUoWtV4d64y9sAEcOH1
 R7iBlDFvUDREqVm908pTwQZJW0siDxmCJItpXxBft64Z+01vUKk2aAq+dMtMOeCarRxTxqkM6
 pkm6PBZHxK8sj7Gsq54OFK5iNRUfODCJYq+G4UdaeqpHolrvbJnteo9ws9oveUWUuMw0st5pj
 vlNOaeFrE3/GJVWhYYoqUtfrTKRmunktcHiJxXq936W70CEjqttAyQBjpFHjrdeL6rJQ4LeNB
 iEQVf5wP0gjmAHhX/t1au8yHvZDid68BQ/wtcOK01VSybDCV6rryD+KcoAWgFFBQViUan8wn7
 MRw3bWBn1eNPpGF8mWr1CYhKi5/4QC2VRSWBkuBORt3zzEvw8CeJ3bMAyk7J6ANncDeYIOSyB
 MP+LW5HFYoE75GzZND8rqyCjyv/2kdnvh2DoSu72qH8vJQjmkY=
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Mar 11, 2020 at 11:57 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Move LDISC_AUTOLOAD ahead of the Serial drivers menu.
>
> Move the Serial drivers menu ahead of the Non-standard serial port
> support menu.
>
> Move NOZOMI out of the SERIAL_NONSTANDARD area since it does not
> depend on SERIAL_NONSTANDARD and it breaks the SERIAL_NONSTANDARD
> menu list.
>
> Alphabetize the remaining drivers (in tty/Kconfig) by their prompt strings.
> [The drivers in tty/hvc/Kconfig and tty/serial/Kconfig have not
> been alphabetized.]
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jslaby@suse.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
