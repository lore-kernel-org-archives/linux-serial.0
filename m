Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 229D6C4332E
	for <linux-serial@archiver.kernel.org>; Wed,  6 Jan 2021 20:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE00A2313F
	for <linux-serial@archiver.kernel.org>; Wed,  6 Jan 2021 20:17:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbhAFURz (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 6 Jan 2021 15:17:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbhAFURy (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 6 Jan 2021 15:17:54 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EECFC06134C
        for <linux-serial@vger.kernel.org>; Wed,  6 Jan 2021 12:17:13 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id jx16so6687455ejb.10
        for <linux-serial@vger.kernel.org>; Wed, 06 Jan 2021 12:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/LXigFpPNOCeOqHnGy6mQiQq0ybJHedQswcmkfdAhmQ=;
        b=eHMqPJyrc7py5Tjh67Tr30SRYf+31s4cEkTv6+CXFfZ+afA+qwUYaLAiLwICN2DQpz
         yhgzDSuYuv0QMZYyogVRQ0NHCbLeL2Wm5b//IqHZ3sU/QjkQNDprtmLOf2xItQGhagsj
         yTMh+QH+BzinSF/ORXnBfiAkC9DdpBOithl7vuTDAfhy/zmyowyEFvX5vSPYEXfEHjh8
         uZ8KRDXSetai0ywfqk+PsllVnK9l6OKkQte8NQsVbCEKZv2UdnfxGWy0Cpykdu0C27Xj
         2SgIsDtOHnU2PCEWKQqfxgSV7CVU44k2CP+w+bNwZtUBOrddsWnREyvJz56R2icLMFoF
         qhFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/LXigFpPNOCeOqHnGy6mQiQq0ybJHedQswcmkfdAhmQ=;
        b=LFNhmEZMocDqw9NiMdSpYTcK1dY4l3eDiNWk7DNJ4k7AC3wkm3IEE0ld3GAXZSVsaE
         O5k47n7P4bDZWEQhe5ZqCRdVKzGE/7Gfsv/xK34S2BMnLSgHzGGAYOd88x+r7/Fwe45V
         uK5BfCOpndjEaZekJluCN1YAxnI4KxXtqizRv3xsHNcegFwAqEhQU2fUdKvmtumhUTWW
         1dyZvYpqu9X+arXM9oI/uyML0R7qK7u3iiQy2Ydxy9FFCVOKEyIq2vpNH76mFQ+IJ66q
         umg3FSss3lpf19A4YquWgtM8ekjJhjNjHLiG593JiHtAgUTqd97Zsym6GXShxsOn8qAR
         q98g==
X-Gm-Message-State: AOAM533zD/+iqqFeK8bRwezG3PfntDUcy52tRTf2eJz3Ia5o7DuFkQhc
        pvZGPXIoBGduh9TwCtz8puNl6PgTkUq1DcMzUjO3xg==
X-Google-Smtp-Source: ABdhPJw3btoGzIXnkKpV6UbQEtZs4ktrsUYZkwUTams7nFpWW/etLT7hvyrfxDbluFAJ/SLMgMSOZ7/z33yocuNFrZc=
X-Received: by 2002:a17:906:2b50:: with SMTP id b16mr3877909ejg.255.1609964232355;
 Wed, 06 Jan 2021 12:17:12 -0800 (PST)
MIME-Version: 1.0
References: <CAJ+vNU1XJCisZWpr-huf5gt3V592gz8kX+VHga58iM-Kx+h5=Q@mail.gmail.com>
 <X/WdJ6WEWtK1zix+@hovoldconsulting.com>
In-Reply-To: <X/WdJ6WEWtK1zix+@hovoldconsulting.com>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Wed, 6 Jan 2021 12:17:01 -0800
Message-ID: <CAJ+vNU3WyXT5ozp1mc2EnxHrPGxzEGy8Tt1sNVLV+5WSfeAA+w@mail.gmail.com>
Subject: Re: Linux gnss driver SPI support?
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Jan 6, 2021 at 3:21 AM Johan Hovold <johan@kernel.org> wrote:
>
> On Tue, Jan 05, 2021 at 10:23:43AM -0800, Tim Harvey wrote:
> > Johan,
> >
> > I have noticed you maintain a gnss receiver subsystem and according to
> > the device-tree binding Documentation it looks like it supports SPI
> > but I'm not seeing any code support for SPI. Am I missing something or
> > would that support need to be added for use?
>
> Correct, there are currently no drivers supporting SPI and hence no
> shared implementation either like there is for UART interfaces.
>
> The driver for your device would need to handle the SPI bits itself for
> now. What kind of device is it?

Johan,

It is the u-blox ZOE-M8Q which has a UART as well as SPI/I2C/SQI
interface. The particular board design we are working on is
unfortunately out of UART's which is why we were looking at connecting
it via SPI.

I did come across a posting about this [1] which uses a userspace app
that creates a spy to pty bridge but it seems like they ran into some
performance/latency issues.

Tim
[1] https://portal.u-blox.com/s/question/0D52p00008jOh43CAC/using-neo-m8p-over-spi-as-a-high-accuracy-time-source-with-chrony
