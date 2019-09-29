Return-Path: <SRS0=vVzV=XY=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F28BFC4360C
	for <linux-serial@archiver.kernel.org>; Sun, 29 Sep 2019 06:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C32712082F
	for <linux-serial@archiver.kernel.org>; Sun, 29 Sep 2019 06:47:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vG1clVXG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726076AbfI2GrC (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 29 Sep 2019 02:47:02 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34806 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbfI2GrB (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 29 Sep 2019 02:47:01 -0400
Received: by mail-wr1-f68.google.com with SMTP id a11so7444051wrx.1
        for <linux-serial@vger.kernel.org>; Sat, 28 Sep 2019 23:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ea98FLe2YSc9AH2kkPcPMyW8ZDa2ISCP3kklsnWKnJs=;
        b=vG1clVXGu/XNlAV0pEu5j95IAOzuPGkqdhF85jisuTJ/+gClNoTsSyVRDAfschWLki
         NNh6vVRTV/mWs3QV23z02yju+EDeQ4XXfusCdQZv9ECL2F0UTjEID0h0oU9DMQelQBi+
         0Kr5fVNb2oOxti/GIvC8jt7H3/gtUpchdkZ26MgAJF6g566+Fy0AFPvu0dHVegQaJpym
         NM4Th5NHYQuIt3amAEMwZoWHg1O1t5s+QwhTbxWEC1lvhAWCj6mKXli1WzUALmWXY+em
         +4w5Pdcw22xyq79e0XiZi5vpe/CttcgLJBkKbThsAqeYWlF5Rdqgpbus0CrtDNDARL+U
         arMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ea98FLe2YSc9AH2kkPcPMyW8ZDa2ISCP3kklsnWKnJs=;
        b=bVGYquZfyY45GM1Wbzotyz5btqucGXNlzflHRU1KUAPqC9L9Ja03tZcVXt/tOkkaE4
         mn8tUb7CVxl0lqucmIcbTFfHa1XXi+eNZD/HtTeEMdiCN6DBbh0rpuBwcwI1fIDrl5Or
         gFk+xu3vaPBgabT3jYYgj7toPD2/93pVD5feDIjxmZorNLVMk3pTSZ+wzkB+CQeY4q0j
         /mUH8DOFr6hpeDJOwO+qJbjCUTr+UDhvK+D533M27uMLhb6FrENGDc/CBbZiSMKw/XRX
         Ey9rU4jlhUXaoS8gT8A4wJCDFWkt7MCrX1xFBN7PNhfHbLvk3cUnBNYjblaeeNvG3iCR
         m3dQ==
X-Gm-Message-State: APjAAAUnt6CEDz8DgGglShitdKcnrfN+qsI810UhFPvlD3SwmG4I3oSL
        yodRb65USp2DjwZyzG4MDnn+3uRnzGeWnTewuXtT2Fg7KRI=
X-Google-Smtp-Source: APXvYqyuZe0hA3u/nOchM5U01Lx0kkIxy3koIEVte3NLmPgJjXg590PtROAPR7i/f7FAk7pvxEQO+9jxoAl3/qtirac=
X-Received: by 2002:a5d:67c3:: with SMTP id n3mr8150767wrw.294.1569739619077;
 Sat, 28 Sep 2019 23:46:59 -0700 (PDT)
MIME-Version: 1.0
References: <CAEXMXLRBpQcSq3SrvL4LkG8_7S0CWJFGqRCnjywjbUEPZg9XxQ@mail.gmail.com>
In-Reply-To: <CAEXMXLRBpQcSq3SrvL4LkG8_7S0CWJFGqRCnjywjbUEPZg9XxQ@mail.gmail.com>
From:   =?UTF-8?Q?Nuno_Gon=C3=A7alves?= <nunojpg@gmail.com>
Date:   Sun, 29 Sep 2019 08:46:47 +0200
Message-ID: <CAEXMXLSty8v1K_yaxoAnoMEny=XYn2ngUdCPi_0uTqy5NTViAQ@mail.gmail.com>
Subject: Re: Regression since 4a96895f74c9633b51427fd080ab70fa62b65bc4
To:     linux-serial@vger.kernel.org, yegorslists@googlemail.com
Cc:     sr@denx.de, andriy.shevchenko@linux.intel.com,
        mika.westerberg@linux.intel.com, giulio.benetti@micronovasrl.com,
        gregkh@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

I have since found that I am affected by two apparently different
regressions since 5.3.

4a96895f74c9633b51427fd080ab70fa62b65bc4 is only confirmed to affect
me on a omap8250 where the issue is that there are a few char errors
every few seconds. I can't confirm if chars are added, removed or
changed, for now I only can confirm my state machine looses tracking.

I will make a separate report from the problem identified on sunxi.

On Sat, Sep 28, 2019 at 7:59 AM Nuno Gon=C3=A7alves <nunojpg@gmail.com> wro=
te:
>
> On 32 bit arm platforms (am335x and sunxi) I get unexpected bytes on
> serial ports after this commit.
>
> I use CTS (so: for input flow control).
>
> I've observed two different issues, one where I get just a few missed
> or added bytes about once a minute, and another where I get totally
> unexpected chars until I reopen the port.
>
> I will have a hard time to analyse and give a better description of
> how exactly the port is failing, so maybe you have a idea of what is
> the issue with this patch.
>
> I've reverted this on top of 5.3.1 and consistently got the issue fixed.
>
> Thanks,
> Nuno
>
> commit 4a96895f74c9633b51427fd080ab70fa62b65bc4
> Author: Yegor Yefremov <yegorslists@googlemail.com>
> Date:   Thu Jun 20 08:24:20 2019 +0200
>
>     tty/serial/8250: use mctrl_gpio helpers
>
>     This patch permits the usage for GPIOs to control
>     the CTS/RTS/DTR/DSR/DCD/RI signals.
>
>     Changed by Stefan:
>     Only call mctrl_gpio_init(), if the device has no ACPI companion devi=
ce
>     to not break existing ACPI based systems. Also only use the mctrl_gpi=
o_
>     functions when "gpios" is available.
>
>     Use MSR / MCR <-> TIOCM wrapper functions.
>
>     Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
>     Signed-off-by: Stefan Roese <sr@denx.de>
>     Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>     Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>     Tested-by: Yegor Yefremov <yegorslists@googlemail.com>
>     Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
>     Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>     Cc: Giulio Benetti <giulio.benetti@micronovasrl.com>
>     Cc: Yegor Yefremov <yegorslists@googlemail.com>
>     Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
