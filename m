Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45369C48BDF
	for <linux-serial@archiver.kernel.org>; Tue, 22 Jun 2021 15:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C9CC61027
	for <linux-serial@archiver.kernel.org>; Tue, 22 Jun 2021 15:20:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232203AbhFVPXJ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 22 Jun 2021 11:23:09 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:36913 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232087AbhFVPXI (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 22 Jun 2021 11:23:08 -0400
Received: from mail-wm1-f49.google.com ([209.85.128.49]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1Mdvyo-1lO1HY1hzS-00azLe; Tue, 22 Jun 2021 17:20:50 +0200
Received: by mail-wm1-f49.google.com with SMTP id m3so13074721wms.4;
        Tue, 22 Jun 2021 08:20:50 -0700 (PDT)
X-Gm-Message-State: AOAM532muqXB2+FeUvqK7kiC6sypaar83CR9sGO3csSxZ0TMzQF+Hzai
        CIEWo95FA2Id+JyxtDKfgXXChKOP6rr5wOOXX7Y=
X-Google-Smtp-Source: ABdhPJxnVRrZWU3JVswJ2QZq2pjCpSgY1JUazfWhbU6JSQfwjFgSvYmHDdjApi4t3KGHf+NqzVz/wr3QCt1/VR7iGng=
X-Received: by 2002:a1c:98d5:: with SMTP id a204mr4879216wme.43.1624375249974;
 Tue, 22 Jun 2021 08:20:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210509184519.15816-1-alex.nemirovsky@cortina-access.com>
 <20210509184519.15816-2-alex.nemirovsky@cortina-access.com>
 <YMiUpK/+PjsoCU1W@kroah.com> <CFD14D63-4537-4A91-861C-71B74E2CFAE6@cortina-access.com>
 <YMi1jOL6y+eUK3Df@kroah.com> <B71C5D02-EDBE-4AAD-AF1B-2FD467BE075A@cortina-access.com>
 <CAL_JsqKDf9W-1KHUoFFCoLareLKf0CAVMU6CXR22xW3hWM_8yg@mail.gmail.com>
 <9937DB34-7757-4A54-BCC6-AF5514FD7F1D@cortina-access.com> <CAL_JsqLHdi29Du1F=e1N471tnsziWpH7TPO_caDF3SrjvHS-iw@mail.gmail.com>
 <CAMuHMdXA9-ajoAza2JAW5879ECieMm1dbBbKHgJhDa7=3kWu3w@mail.gmail.com>
In-Reply-To: <CAMuHMdXA9-ajoAza2JAW5879ECieMm1dbBbKHgJhDa7=3kWu3w@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 22 Jun 2021 17:18:30 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3Zh37WwM5rRugJgm_b8f-fBcTm_pHZz439HMe8w-odPw@mail.gmail.com>
Message-ID: <CAK8P3a3Zh37WwM5rRugJgm_b8f-fBcTm_pHZz439HMe8w-odPw@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] dt-bindings: serial: Convert Cortina-Access UART
 to json-schema
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Alex Nemirovsky <Alex.Nemirovsky@cortina-access.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Li <jason.li@cortina-access.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Olof Johansson <olof@lixom.net>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:tOie7vWrEnexv0CRNGItMAUz9wQ0Ofa0PTa6xbTtiUTZQ3T8or4
 SiynUPlqei6d/gdefigWSaHhJxZhhKNBGUH/O5Cehp0HQiiWXon7s3qKygV8FNW0iMTm4pV
 xeG1ZXmMkDEInmQ0ZkpXKTeZRfWjLN+Yb8n5TnNYq9xtso0bByh/zm2+cw6fe2eWbwFu+Jh
 fjyw4mOBAuhq7b7SqG7Gg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+CN8r0Y3zoI=:Cu1IqOczSpgr0i3z2CFCMA
 sD8hgr9pyIh7wPJ/dLI+HmHpmzD/6xf/e//OMoR2MnZVhwHWWMUcHJmywHtQa0+AZBpRGzah2
 4Ih6kz/7vuqFLVLqBl8a8IcZmgH2by9RSWX/p8QO5/UaKhtjrTbL/vDpS8McvPLzObKNTJQVp
 P4EGMUWGqbjcGROqtk44XXaAMo1sG7CqRUafDDm9HgOP9HDTxgQ0ToeqCcGzCzTyXPyFkhiUL
 IVUZBGhVJdF9qvp4dS5HGB8g29JszrwoEwHJ0n1Ba6VJefjbTpmPCvFQOEzaFvX+3LXLkXNSv
 4KYLLZDjc2+lfX5I8/ZFbSLCvFURqDtkBAO+kaHGOjrsPjl+1fPdvRNp3VR92JjdGMVizFWC1
 z2v2gr0Bx+rOZhywJD+mXFBQo9VkDvac/npmYsVKNaIyppVPERqd4x7O6TTJ5OlfHMv6HDeBd
 bf19sVYofBmVwAna2BJKcVGIAw7JHa+zSOgjC94PneKtmK6GcTYlD30a37+RDM30xHjQw+ljA
 vPPzim+kdnLxg0WKigZWb0=
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Jun 22, 2021 at 1:29 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Tue, Jun 15, 2021 at 6:21 PM Rob Herring <robh+dt@kernel.org> wrote:
> > On Tue, Jun 15, 2021 at 10:06 AM Alex Nemirovsky <Alex.Nemirovsky@cortina-access.com> wrote:
> > > It sounds like you are find with patch 2/3 from a DT point of view.  Could we review the rest from the DT point of view
> > > to get either feedback for changes or ACK these, so we can unblock this series?
> >
> > Can't say I've seen it as I only see replies in my mail. Did this
> > originally go to the DT list? If not, it's never in my queue[1].
>
> None of the patches in this series ended up on a mailing list or on
> lore, so no one could comment on them, except for people CCed directly.

Right, in fact every email I see from @cortina-access.com at
https://lore.kernel.org/lkml/?q=cortina-access.com is a reply, but the
original mails are all missing, not just this series.

It appears that there is a problem between the mail servers of cortina-access
and kernel.org. Alex and Jason, please double-check if you find
anything in

https://www.kernel.org/doc/html/latest/process/submitting-patches.html
https://www.kernel.org/doc/html/latest/process/email-clients.html

that may have caused this on your end, or otherwise contact
postmaster@vger.kernel.org for help.

> The driver has been accepted in tty-next, commit b61c8bf4694b5115
> ("tty: serial: Add UART driver for Cortina-Access platform").  From a
> quick glance, it could have used some review.
>
> The driver is using the compatible value "cortina-access,serial", so I
> guess the binding patch added "cortina-access" to vendor-prefixes.yaml.

Ah right. That patch has not made it in because of the issue, but right
away I can tell that the binding is not great because the compatible
string is way too generic: it implies that cortina-access only uses a single
serial port type in every past, present or future SoC, which is clearly
not the case.

It's obviously up to Greg to decide whether to revert the patch, but
I'd suggest we don't treat the driver as conforming to the binding until
it has been reviewed, and assume that changes will be made.

> The SERIAL_CORTINA_ACCESS symbol doesn't depend on anything, so
> it will show up on everyone's oldconfig radar soon, regardless of
> building a kernel for a Cortina Access system or not.
> I wanted to change it to something like:
>
>      config SERIAL_CORTINA_ACCESS
>             tristate "Cortina-Access serial port support"
>     +       depends on FIXME || COMPILE_TEST
>             select SERIAL_CORE
>             help
>               This driver is for Cortina-Access SoC's UART. If you
> have a machine
>               based on the Cortina-Access SoC and wish to use the serial port,
>               say 'Y' here. Otherwise, say 'N'.
>
> but given there is no evidence of patches to add support for the
> CAXXXX line of SoCs, there's no symbol to depend on...

Assuming this is a SoC based on an Arm CPU core, it's clear that
nothing from cortina-access.com ever made it through the
linux-arm-kernel@lists.infradead.org mailing list either, if anything
was sent at all.

Alex, please try to contact me off-list about merging the full SoC
support, I should be able to help you come up with a plan for
submitting the rest as soon as the email troubles are resolved.

For new Arm based SoC platforms, arch/{arm,arm64} patches
should go through the soc tree and be picked up by Olof (on Cc)
or me. The exact process is not well documented, but please
contact us by email, or on irc://irc.libera.chat/#armlinux if you
have questions.

       Arnd
