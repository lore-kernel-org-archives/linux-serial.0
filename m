Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBDD6C2B9F4
	for <linux-serial@archiver.kernel.org>; Tue, 22 Jun 2021 11:28:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 968A2613B4
	for <linux-serial@archiver.kernel.org>; Tue, 22 Jun 2021 11:28:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbhFVLae convert rfc822-to-8bit (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 22 Jun 2021 07:30:34 -0400
Received: from mail-ua1-f50.google.com ([209.85.222.50]:40861 "EHLO
        mail-ua1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbhFVLae (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 22 Jun 2021 07:30:34 -0400
Received: by mail-ua1-f50.google.com with SMTP id r9so6170724ual.7;
        Tue, 22 Jun 2021 04:28:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/cdIiccgG5jxWjPE+ludHp9/DNq5RJZLWtlTIZf2YpU=;
        b=n5FWcCSrvEVtiPW6l3FmZKbrU9eAeD6UO9N0PdPHV8bNizWFtI8JXTidjQUKXkd/22
         LJEVWWJctQEzZa0A7f1TAo4bY914M0bAHz4vkMMPvSV4rp6+rtWpE3jM0QSOIs0cxV04
         meQdR/ii+k3MigQl8ziagl6tEPKlMD5y8HF3FDH7ZYRxavzeRHmJNkAY8BWqM13LQ/S7
         nVWlO0ANF/BBntdoZMDD4HwqEmNY+EfIAi9U/wsii2b/bXwS1Takiedw0K+klwTT1ke7
         lCho60I65Ndz11SIYMMgRAbxYT6Wc1TPwegnoGqoM8HqJN9aSQ7pIPMK1Wk5iPn5lxOD
         1eiQ==
X-Gm-Message-State: AOAM531Wf3Dkf8MP7GGTrXmGwJGL0mC+n3B0uYQr38d2Phagy2gdrKvJ
        lwj7Bg2mixJvP7xgUzrY7RfYlrItOeEbb2sNFFs=
X-Google-Smtp-Source: ABdhPJyuU46d59XF2UZN2pHmabdDyGsE9QRXUyv16gvV0JFM5/+ESuZ7FIv1Kf6/jvL+6qaaLtPVwPxVteMCJrBZINQ=
X-Received: by 2002:ab0:70b3:: with SMTP id q19mr2805173ual.2.1624361297367;
 Tue, 22 Jun 2021 04:28:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210509184519.15816-1-alex.nemirovsky@cortina-access.com>
 <20210509184519.15816-2-alex.nemirovsky@cortina-access.com>
 <YMiUpK/+PjsoCU1W@kroah.com> <CFD14D63-4537-4A91-861C-71B74E2CFAE6@cortina-access.com>
 <YMi1jOL6y+eUK3Df@kroah.com> <B71C5D02-EDBE-4AAD-AF1B-2FD467BE075A@cortina-access.com>
 <CAL_JsqKDf9W-1KHUoFFCoLareLKf0CAVMU6CXR22xW3hWM_8yg@mail.gmail.com>
 <9937DB34-7757-4A54-BCC6-AF5514FD7F1D@cortina-access.com> <CAL_JsqLHdi29Du1F=e1N471tnsziWpH7TPO_caDF3SrjvHS-iw@mail.gmail.com>
In-Reply-To: <CAL_JsqLHdi29Du1F=e1N471tnsziWpH7TPO_caDF3SrjvHS-iw@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 22 Jun 2021 13:28:06 +0200
Message-ID: <CAMuHMdXA9-ajoAza2JAW5879ECieMm1dbBbKHgJhDa7=3kWu3w@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] dt-bindings: serial: Convert Cortina-Access UART
 to json-schema
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Alex Nemirovsky <Alex.Nemirovsky@cortina-access.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Li <jason.li@cortina-access.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Jun 15, 2021 at 6:21 PM Rob Herring <robh+dt@kernel.org> wrote:
> On Tue, Jun 15, 2021 at 10:06 AM Alex Nemirovsky
> <Alex.Nemirovsky@cortina-access.com> wrote:
> > > On Jun 15, 2021, at 8:44 AM, Rob Herring <robh+dt@kernel.org> wrote:
> > > On Tue, Jun 15, 2021 at 8:39 AM Alex Nemirovsky
> > > <Alex.Nemirovsky@cortina-access.com> wrote:
> > >>
> > >>
> > >>
> > >>> On Jun 15, 2021, at 7:13 AM, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > >>>
> > >>> On Tue, Jun 15, 2021 at 01:36:39PM +0000, Alex Nemirovsky wrote:
> > >>>> MAINTAINERS modification was made in the initial version 1.  We made no changes to it since then,
> > >>>> thus not sure what we could at to  Changelog which would add value or clarity for others
> > >>>> from the v1.
> > >>>>
> > >>>>> On Jun 15, 2021, at 4:53 AM, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > >>>>>
> > >>>>> On Sun, May 09, 2021 at 11:45:17AM -0700, Alex Nemirovsky wrote:
> > >>>>>> From: Jason Li <jason.li@cortina-access.com>
> > >>>>>>
> > >>>>>> Convert the Cortina-Access UART binding to DT schema format.
> > >>>>>>
> > >>>>>> Signed-off-by: Jason Li <jason.li@cortina-access.com>
> > >>>>>> ---
> > >>>>>> .../serial/cortina-access,serial.yaml         | 46 +++++++++++++++++++
> > >>>>>> .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
> > >>>>>> MAINTAINERS                                   |  6 +++
> > >>>>>
> > >>>>> You are also adding a MAINTAINERS entry here, which is not listed in the
> > >>>>> changelog text, so I couldn't take it anyway :(
> > >>>
> > >>> Add the maintainers entry in the first patch, with the driver please.
> > >>
> > >> The change to MAINTAINERS here add a new file into the DT documentation.
> > >> Should it not be grouped into the dt-binding portion and reviewed by the DT time for which this patch
> > >> is CC’ed to? Why would moving the DT documentation file that is introduced be into the first patch, which is the
> > >> serial driver itself be the correct approach?
> > >
> > > The binding doesn't actually need a MAINTAINERS entry (though having
> > > one is fine). get_maintainers.pl will also pull emails from the
> > > binding schema.
> > >
> > > Rob
> >
> > Hi Rob,
> > It sounds like you are find with patch 2/3 from a DT point of view.  Could we review the rest from the DT point of view
> > to get either feedback for changes or ACK these, so we can unblock this series?
>
> Can't say I've seen it as I only see replies in my mail. Did this
> originally go to the DT list? If not, it's never in my queue[1].
>
> Rob
>
> [1] https://patchwork.ozlabs.org/project/devicetree-bindings/list/

None of the patches in this series ended up on a mailing list or on
lore, so no one could comment on them, except for people CCed directly.

The driver has been accepted in tty-next, commit b61c8bf4694b5115
("tty: serial: Add UART driver for Cortina-Access platform").  From a
quick glance, it could have used some review.

The driver is using the compatible value "cortina-access,serial", so I
guess the binding patch added "cortina-access" to vendor-prefixes.yaml.
According to https://www.cortina-access.com/news-and-events, this is
the same company as Cortina Systems, which already has the "cortina"
vendor prefix.  In 2015, it was acquired by Realtek, so perhaps it
should use the "realtek" prefix instead for new development?

The SERIAL_CORTINA_ACCESS symbol doesn't depend on anything, so
it will show up on everyone's oldconfig radar soon, regardless of
building a kernel for a Cortina Access system or not.
I wanted to change it to something like:

     config SERIAL_CORTINA_ACCESS
            tristate "Cortina-Access serial port support"
    +       depends on FIXME || COMPILE_TEST
            select SERIAL_CORE
            help
              This driver is for Cortina-Access SoC's UART. If you
have a machine
              based on the Cortina-Access SoC and wish to use the serial port,
              say 'Y' here. Otherwise, say 'N'.

but given there is no evidence of patches to add support for the
CAXXXX line of SoCs, there's no symbol to depend on...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
