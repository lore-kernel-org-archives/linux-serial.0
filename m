Return-Path: <SRS0=jKy5=43=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 209E0C18E5A
	for <linux-serial@archiver.kernel.org>; Tue, 10 Mar 2020 10:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1E4720637
	for <linux-serial@archiver.kernel.org>; Tue, 10 Mar 2020 10:11:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbgCJKLo (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 10 Mar 2020 06:11:44 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42121 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbgCJKLo (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 10 Mar 2020 06:11:44 -0400
Received: by mail-ot1-f66.google.com with SMTP id 66so12546176otd.9;
        Tue, 10 Mar 2020 03:11:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jCYTtqKtRPChhEMP3SdFyK3zUQ497N5Se4SQbI0RklA=;
        b=Vf27KfOZaPJN9fqG3b6SsYQMcuje0KATMB6Ws4w4IWeGZCEFLlPAcTinMWG8YJXWzf
         kTUxtYQBqZKN/Ky0Lu0J/hL8d3dhXe6W0Dq06lASPOqig59+GtfEnaDiz6MCcjae+s3u
         khdYtQ8QwKidbEBHnquTJGzGcb+gBUmeJePUBPtdVjpi7acyykGa+eFwxqQsNWkNYoq1
         eHqzpYjsZ8eWjaXJ0CAQmDdiuoMV50v1jGEMTSNWywSyDiNcYzx3NBJ/tIBFSmXTMPts
         81jHrFUjnfwJXYr6TTxpXvul+IiEphzGblpghARTwUP4pIyORB3rjxmMSD+bN8nKeIRx
         ++4A==
X-Gm-Message-State: ANhLgQ19O45IWZZzZnLUevyCafndwGtpZuSEe+c53WzPJajwo/ctwYi+
        G3Pre1v5ZcbE/0SLMTawSJTYdLjXX+QyuXIrcQ0=
X-Google-Smtp-Source: ADFU+vssgAzcj0QjNkwqKXMBxmZbVcV4/65kDwlBPN53wWEVCESi0Az4nNTiu33PAlepRYJQFKcqU7lq18xKx1kM570=
X-Received: by 2002:a9d:b89:: with SMTP id 9mr16497345oth.297.1583835103460;
 Tue, 10 Mar 2020 03:11:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200306102301.16870-1-geert+renesas@glider.be> <CAJKOXPeknZDrA7cXbznvrcCoV4hFfaUAtd6mzHO+dbepkzueQw@mail.gmail.com>
In-Reply-To: <CAJKOXPeknZDrA7cXbznvrcCoV4hFfaUAtd6mzHO+dbepkzueQw@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 10 Mar 2020 11:11:32 +0100
Message-ID: <CAMuHMdVhOECZPMno3vgw4x0fo9yX5j0G9rss1QvHFyi73RRXVQ@mail.gmail.com>
Subject: Re: [PATCH] Revert "tty: serial: samsung_tty: build it for any platform"
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Kukjin Kim <kgene@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Krzysztof,

On Mon, Mar 9, 2020 at 7:09 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> .On Fri, 6 Mar 2020 at 11:23, Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:
> > This reverts commit 175b558d0efb8b4f33aa7bd2c1b5389b912d3019.
> >
> > When the user configures a kernel without support for Samsung SoCs, it
> > makes no sense to ask the user about enabling "Samsung SoC serial
> > support", as Samsung serial ports can only be found on Samsung SoCs.
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> >  drivers/tty/serial/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> >
>
> Discussion about removal and then re-adding of PLAT_SAMSUNG and
> ARCH_EXYNOS dependencies remind me [1]: "[RFC] Input: tm2-touchkey -
> add hardware dependency".
>
> In both cases the driver is clearly only for Samsung SoC or even for
> particular device, although one could argue that touchscreen could be
> reused while re-usage of serial IP of SoC is highly unlikely. My
> understanding, maybe not correct, of "depends on" syntax is a kernel
> source code, building or running dependency. I do not see it as a
> hardware dependency. Although Samsung S3C/Exynos serial driver will
> not exist outside of Samsung SoC, there is no kernel dependency.
> Unless I missed something...

The touchscreen is something different: I can easily mount that type of
touchscreen on my own board, while I cannot integrate a Samsung serial
port on my board, unless I'm using a Samsung SoC.

> I understand and agree with concerns mentioned in [1] and in the
> thread here, that removal of this "depends on" makes life of
> distributions and generic users more difficult. To solve this problem
> I was thinking about adding weaker type of dependency. A hint about
> hardware dependency. Something like the "imply" is for "select". This
> did not happen, therefore I still stand on my understanding of
> "depends on" thus I gave positive feedback to Greg's patch.

A weak dependency can be expressed using "|| COMPILE_TESTING".

<(not so) wild idea>
During the past few days, I've been giving this more thought.
And I realized we might as well get rid of pci_driver, and just have
platform_drivers that match against "pci<VendorID>,<DeviceID>" (yes,
this is what real Open Firmware had in the compatible property, cfr.
http://users.telenet.be/geertu/Linux/PPC/pci/ethernetAT4/).
That way there would be no longer a build dependency on CONFIG_PCI, and
we can drop all "depends on PCI" from driver Kconfig symbols.
But would dropping that dependency be welcomed? Perhaps, as "everybody"
uses PCI.

Now repeat the exercise for Zorro, TURBOchannel, NuBus, Sbus, PCMCIA,
..., and wait for the outcry from Linus suddenly seeing lots of
questions about support for hardware he can't possibly have in his
machine...
</(not so) wild idea>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
