Return-Path: <SRS0=nzNS=BP=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45860C433E0
	for <linux-serial@archiver.kernel.org>; Wed,  5 Aug 2020 19:56:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2081920842
	for <linux-serial@archiver.kernel.org>; Wed,  5 Aug 2020 19:56:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pesu-pes-edu.20150623.gappssmtp.com header.i=@pesu-pes-edu.20150623.gappssmtp.com header.b="15Gzl4QZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbgHETzo (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 5 Aug 2020 15:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727893AbgHEQqQ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 5 Aug 2020 12:46:16 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42C00C08EA0C
        for <linux-serial@vger.kernel.org>; Wed,  5 Aug 2020 06:16:31 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id v4so37947616ljd.0
        for <linux-serial@vger.kernel.org>; Wed, 05 Aug 2020 06:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pesu-pes-edu.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a94+vY6/4IIigbXjg7NoT3QyS3gyeM3tRGM7IVe4C4A=;
        b=15Gzl4QZddTS7bZppiLCks8TnKdGjjThf1+1n2PB6hvFFKm0anFwj1mRbuIopHjtjZ
         PmhBrjQq9P0jGAtfWE0WpRv0NUlg+TC0xFMMPI0UdQ5zswvcPJgKz7zuojmmHBPoo+fM
         Nk0mZHL66mV47gSHqMPCmZEUVeTWLmSsOnPbETHn7F1sflFlCeHJG6lZ2ugkPeICATot
         05QaAVOAxe1WcFLQn+qCP6t5k76N4waNiQE70DxT7FRmkjn2xfCFlv5kCxbeR48a6fqW
         uAr7zHqPvdbgmz0OpHYND8tA6Zag4e4lDHNcV8RPJwuOPO8wmk2LM8lc02XvlEKJ7Fnh
         gSew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a94+vY6/4IIigbXjg7NoT3QyS3gyeM3tRGM7IVe4C4A=;
        b=LwmhIu0ps2UhYf91qoaOgH9wATYYA9s6nLScIuA1ca88v8jUebSd6Zo/a9kESV/FMx
         9btv3XY0blsddCzt3rNg3Y/0tciKKEpP0GQXB2IScOXpV+Tm6zd0SZT2JwoOKG0b49O7
         qOPs2VGug4koEgRMRkqfCR+xj6/1Ys7jTtcpyUTR/j+6Hd2hJh2XeurHKYrFOSjrn8GK
         AehUMboyZygWsKJLPczLYWuwCUCcIp2w5lb+s90pTsAy+fDN5D5wAOFR1T+mBEG1bWOD
         Kl4xnl301LEZk5tKxd7EGwd9pFE61I5wawqJWN5ytQ86tg2UN1Oimeqj9gbFYKWbo3M8
         UPmw==
X-Gm-Message-State: AOAM533Ol8FWxos6uFhX5utyWajhJHKle7RfHpgaIrGCRx7vsaukHigh
        e5+vmVP5URPwuNQTcaYos86V/rnqZZ1LBGLysmGXJKCR
X-Google-Smtp-Source: ABdhPJwjg5Ra/z1LK5PGj9yIvEUV894D92SaQPSdTYQ19poiZFDx8xCMEmv974RmQSyC4iXeKoYKya43bsM13OJHPJc=
X-Received: by 2002:a2e:9c59:: with SMTP id t25mr1397247ljj.402.1596633386436;
 Wed, 05 Aug 2020 06:16:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200721174228.misj2mgqzcfz2lsj@pesu.pes.edu> <20200729160333.GA3652767@kroah.com>
 <VI1PR04MB480018F32A080BC5CC76E3C7F34B0@VI1PR04MB4800.eurprd04.prod.outlook.com>
 <20200805125627.GA1822283@kroah.com>
In-Reply-To: <20200805125627.GA1822283@kroah.com>
From:   B K Karthik <bkkarthik@pesu.pes.edu>
Date:   Wed, 5 Aug 2020 18:46:15 +0530
Message-ID: <CAAhDqq3iZXdtxC6kaRZg7520gzBORmP75uWDf+fNBtwr_Zpi9A@mail.gmail.com>
Subject: Re: [PATCH v2] tty: serial: fsl_lpuart.c: prevent a bad shift operation
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Vabhav Sharma (OSS)" <vabhav.sharma@oss.nxp.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhuvanchandra.dv@toradex.com" <bhuvanchandra.dv@toradex.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Aug 5, 2020 at 6:26 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Aug 05, 2020 at 12:09:34PM +0000, Vabhav Sharma (OSS) wrote:
> >
> >
> > > -----Original Message-----
> > > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Sent: Wednesday, July 29, 2020 9:34 PM
> > > To: B K Karthik <bkkarthik@pesu.pes.edu>
> > > Cc: Jiri Slaby <jirislaby@kernel.org>; linux-serial@vger.kernel.org; linux-
> > > kernel@vger.kernel.org; Vabhav Sharma (OSS)
> > > <vabhav.sharma@oss.nxp.com>; bhuvanchandra.dv@toradex.com
> > > Subject: Re: [PATCH v2] tty: serial: fsl_lpuart.c: prevent a bad shift operation
> > >
> > > On Tue, Jul 21, 2020 at 11:12:29PM +0530, B K Karthik wrote:
> > > > prevent a bad shift operation by verifying that the argument to fls is
> > > > non zero.
> > > >
> > > > Reported-by: "Vabhav Sharma (OSS)" <vabhav.sharma@oss.nxp.com>
> > > > Signed-off-by: B K Karthik <bkkarthik@pesu.pes.edu>
> > > > ---
> > > > v1 -> v2:
> > > >   added Reported-by tag
> > > >
> > > >  drivers/tty/serial/fsl_lpuart.c | 3 ++-
> > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/tty/serial/fsl_lpuart.c
> > > > b/drivers/tty/serial/fsl_lpuart.c index 7ca642249224..0cc64279cd2d
> > > > 100644
> > > > --- a/drivers/tty/serial/fsl_lpuart.c
> > > > +++ b/drivers/tty/serial/fsl_lpuart.c
> > > > @@ -1168,7 +1168,8 @@ static inline int lpuart_start_rx_dma(struct
> > > lpuart_port *sport)
> > > >    * 10ms at any baud rate.
> > > >    */
> > > >   sport->rx_dma_rng_buf_len = (DMA_RX_TIMEOUT * baud /  bits /
> > > 1000) * 2;
> > > > - sport->rx_dma_rng_buf_len = (1 << (fls(sport->rx_dma_rng_buf_len)
> > > - 1));
> > > > + if (sport->rx_dma_rng_buf_len != 0)
> > >
> > > How can this variable become 0?
> > Condition x, taking false branch
> > Explicitly returning zero
> >
> > static __always_inline int fls(unsigned int x)
> > {
> >       return x ? sizeof(x) * 8 - __builtin_clz(x) : 0;
> > }
>
> What false branch?

I'm assuming he's talking about the value after : in the ? operator.

I am checking for the wrong thing in the if statement. We will have to
check for the return value of fls() before performing the shift.
I can change it and send a v3 if you agree.

Please let me know.

thanks,

karthik
