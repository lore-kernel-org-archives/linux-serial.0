Return-Path: <SRS0=2Nu8=37=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2054C352A3
	for <linux-serial@archiver.kernel.org>; Tue, 11 Feb 2020 16:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C04F22070A
	for <linux-serial@archiver.kernel.org>; Tue, 11 Feb 2020 16:18:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kopismobile-com.20150623.gappssmtp.com header.i=@kopismobile-com.20150623.gappssmtp.com header.b="y7FoXWC3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729816AbgBKQSZ (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 11 Feb 2020 11:18:25 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:44706 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729022AbgBKQSZ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 11 Feb 2020 11:18:25 -0500
Received: by mail-ua1-f67.google.com with SMTP id a33so4142616uad.11
        for <linux-serial@vger.kernel.org>; Tue, 11 Feb 2020 08:18:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kopismobile-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=r+dhJtros61nMlqvN6u+WCwHtQAEek+hNMl0AfxFAgY=;
        b=y7FoXWC3+x5msas+5aDzeR9sbPiCYfofLR87Kc/ruDtp8EvuO5lcplL6FI4P1wv0fm
         FAortV7wJ9ppiUO6Ns4F8z2YYj++lZIoElbPaVXdSFsBM77YCFmxorhUVRm643ZNm+vP
         VFuvANMrUFSwH0uffXiAZZcidp27EGSzflCQIotSolG002Dson8oRPBqXII/4+ghePYJ
         7lntFHN0B09kV21DFWvlkU76gnGEdbkSwRG9DGHtRhQIQrcQb/0QHrs3iWQ/jxcV/CFm
         +Q18ym4EaiZQQJnJRiQxMQm+vx3CSqyxVKATRK3UtboksACC944zopuy5vNN6AkJbo8A
         FLqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=r+dhJtros61nMlqvN6u+WCwHtQAEek+hNMl0AfxFAgY=;
        b=OtOOxlyYVAtn/vve/UhnqCwln/+3Q+wP0U7HOBXIsu7FT28/SWcWsKCSN3SAaHXtfn
         xCpYsT5w5EUui72952sHyjIJybxb3hZu30Fc+WV0IjIrmkP5IHv3SAb84tGZr/UM4dbL
         RFot+3uT9kRzOaMuSXZmgrXzUofBNfqu411/b+A1sm2WOR1c45KoMtSfNZcEEdIXeX70
         EDmE6E9t0jmRKvRd0dUaB21B6CReaLuWLw3zkDOW+bbQ1HHP7bByYdP3VyE4AQ6FqyxO
         ZQNzu5d1JWdLOhgnpNN8SVHiTonkspef70lv23hsDqtyjCmYJtgw2sovZugaQKNlqcG4
         tmOg==
X-Gm-Message-State: APjAAAXtwAofZvGldwPEe3s09g9JFaiQP+OIl4aYWpuZNra1O+6xNqxV
        g6WeLe59il1tswkreeDKeaymameK38ZOVWGQyUamCewDEO2gLw==
X-Google-Smtp-Source: APXvYqyue1Nzk42xzuVYhYGNU6JzBZuhDlCPPrCcto25F/bNM00SBZAcT1FIn+z1dTtOU0yagP3ZeR1IvG5K6j9f6ik=
X-Received: by 2002:ab0:740e:: with SMTP id r14mr2130887uap.104.1581437903740;
 Tue, 11 Feb 2020 08:18:23 -0800 (PST)
MIME-Version: 1.0
References: <20200210192949.7338-1-ghilliard@kopismobile.com>
 <20200210192949.7338-3-ghilliard@kopismobile.com> <20200210205003.x7xduj3avwjhimjm@pengutronix.de>
 <CALM8J=dZjK9C+-yMOC_DKp+6m2MaKJsNXaz_+enDVtkgj32U+A@mail.gmail.com> <20200211073834.ndtusa7vvmvsydz4@pengutronix.de>
In-Reply-To: <20200211073834.ndtusa7vvmvsydz4@pengutronix.de>
From:   George Hilliard <ghilliard@kopismobile.com>
Date:   Tue, 11 Feb 2020 10:18:12 -0600
Message-ID: <CALM8J=dy2yRxJHYEhAyXwCwmubuRCGwd3W5gvGH=kYgxCgKASQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] tty: imx serial: Implement support for reversing
 TX and RX polarity
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel@pengutronix.de, devicetree@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Feb 11, 2020 at 1:38 AM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> Hello George,
>
> On Mon, Feb 10, 2020 at 05:03:14PM -0600, George Hilliard wrote:
> > On Mon, Feb 10, 2020 at 2:50 PM Uwe Kleine-K=C3=B6nig
> > <u.kleine-koenig@pengutronix.de> wrote:
> > > On Mon, Feb 10, 2020 at 01:29:49PM -0600, George Hilliard wrote:
> > > > @@ -1390,6 +1392,8 @@ static int imx_uart_startup(struct uart_port =
*port)
> > > >       ucr4 =3D imx_uart_readl(sport, UCR4) & ~UCR4_OREN;
> > > >       if (!sport->dma_is_enabled)
> > > >               ucr4 |=3D UCR4_OREN;
> > > > +     if (sport->inverted_rx)
> > > > +             ucr4 |=3D UCR4_INVR;
> > >
> > > You fail to clear this bit if .inverted_rx is false.
> >
> > I believe this is taken care of by the SRST asserted slightly above
> > this - UCR* is reset by this.
>
> The i.MX6 manual states: Reset the transmit and receive state machines,
> all FIFOs and register USR1, USR2, UBIR, UBMR, UBRC, URXD, UTXD and
> UTS[6-3]. UCR* isn't mentioned here. So please at least confirm your
> belief experimentally.

Oh, I see now - I misread "S" vs "C".  You are correct; I will send v3
with both changes.
Even with experimental evidence, there's no guarantee made by NXP, so
I'll handle it.

Thanks,
George
