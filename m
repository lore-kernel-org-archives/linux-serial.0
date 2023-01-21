Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D34AFC004D4
	for <linux-serial@archiver.kernel.org>; Sat, 21 Jan 2023 18:04:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbjAUSEb (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 21 Jan 2023 13:04:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjAUSEa (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 21 Jan 2023 13:04:30 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 473B71E9C9
        for <linux-serial@vger.kernel.org>; Sat, 21 Jan 2023 10:04:29 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id kt14so21409222ejc.3
        for <linux-serial@vger.kernel.org>; Sat, 21 Jan 2023 10:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1gUlDI6v8VKTtaMxxZBnCUHzXRHq2WNi9uyLdu5nGAY=;
        b=GGDo6doU7wzIcOBqhbO7K0p5p6Aygeh0vlu/HrtwiOV0PCao7kpHWcwNWzfxu+iIAF
         qU7tj2e9v9B2FRPcF5VIoeFK1x09qja63eRS6TLg+SoVwG8huSykA3IBqrucNyBhN+5i
         EbuUWtAPE1nUpunFHOJ3eeBTrQEMbhU4jcOxnT2XedpNDBOkIW2/03S38nUifG4Ef9C9
         WcPEb60QS5i250lCauKdh54JUf6mBInH/6U9THc2D4HjoZnywEuRkF4IYVZneKzqeRAb
         Y52t2RSu5rbVr418Wa6A8tvX3TXQkXaIjme1Kavz9ha57aY9q+7T2BlQat/04JnVh/25
         21wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:subject:cc:to:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1gUlDI6v8VKTtaMxxZBnCUHzXRHq2WNi9uyLdu5nGAY=;
        b=wYxEgYx5BDQ1ZIdty21060TywZPQR+50sZrtmbTALY93uckGe4R2kXqQZDV4MVhNp+
         1qxfzBEcE7xldz9otG+SRRrfIuJ1lpX5afL4UJO+r0GfigUDzpnh9eFMOtiP505LgvuN
         CZBr+mYugX1QuxUJleT5txc/DrGKUbKrZoFDSe2G2vaKW+n2QXq1hp+jwjIyMJdTttt7
         PJWaNtfiHlBcs490Hm/OkNqkJI48KHDS7Y279M0og3rUvc6RLo2LTvNv4facasttX10A
         rC5Q+7ZgcaQlOiIgMpEGE2mnr2qROhxUTv8wbmOwufZE5mn7eUhKWU5Uy1k+hMH8VQaw
         kOdg==
X-Gm-Message-State: AFqh2kqBJx0upbNfpVZ1xFRrG76+gCYBCv7Q0xzzNHPyPWxh+9eCkSNb
        /89//WvXgzjmZnoH4dMMWGU=
X-Google-Smtp-Source: AMrXdXsyo7NAgz0UE5nMv1yReeP76ZOEOrdOk4E6pbjKafS+QNxSvabQa5BgrB8Sb4Jbl9Re/Dcq4Q==
X-Received: by 2002:a17:906:1c51:b0:864:8ffe:135b with SMTP id l17-20020a1709061c5100b008648ffe135bmr18366470ejg.22.1674324267627;
        Sat, 21 Jan 2023 10:04:27 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id d7-20020a50fb07000000b0049cbd334b13sm11156896edq.29.2023.01.21.10.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jan 2023 10:04:27 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Richard Genoud <richard.genoud@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-serial@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Tim Harvey <tharvey@gateworks.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Tomasz =?utf-8?Q?Mo=C5=84?= <tomasz.mon@camlingroup.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 7/8] serial: imx: use readl() to optimize FIFO reading loop
References: <87bko4e65y.fsf@osv.gnss.ru>
        <20230113184334.287130-1-sorganov@gmail.com>
        <20230113184334.287130-8-sorganov@gmail.com>
        <20230117113205.l5byaz3srzpagzhz@pengutronix.de>
        <87bkmx47o4.fsf@osv.gnss.ru>
        <20230117212702.vvwe3rqjedivqbhn@pengutronix.de>
        <87ilh3zw9q.fsf@osv.gnss.ru>
        <20230119070114.e62pqb6ibousxgx7@pengutronix.de>
Date:   Sat, 21 Jan 2023 21:04:25 +0300
Message-ID: <87k01fwyqe.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hello Uwe,

Uwe Kleine-König <u.kleine-koenig@pengutronix.de> writes:

> Hello Sergey,
>
> On Wed, Jan 18, 2023 at 06:40:17PM +0300, Sergey Organov wrote:
>> Uwe Kleine-König <u.kleine-koenig@pengutronix.de> writes:
>> > On Tue, Jan 17, 2023 at 04:22:51PM +0300, Sergey Organov wrote:
>> >> Uwe Kleine-König <u.kleine-koenig@pengutronix.de> writes:
>> >> > On Fri, Jan 13, 2023 at 09:43:33PM +0300, Sergey Organov wrote:
>> >> >> Use readl() instead of heavier imx_uart_readl() in the Rx ISR, as we know
>> >> >> we read registers that must not be cached.
>> >> >> 
>> >> >> Signed-off-by: Sergey Organov <sorganov@gmail.com>
>> >> >> ---
>> >> >>  drivers/tty/serial/imx.c | 5 +++--
>> >> >>  1 file changed, 3 insertions(+), 2 deletions(-)
>> >> >> 
>> >> >> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
>> >> >> index be00362b8b67..f4236e8995fa 100644
>> >> >> --- a/drivers/tty/serial/imx.c
>> >> >> +++ b/drivers/tty/serial/imx.c
>> >> >> @@ -890,14 +890,15 @@ static irqreturn_t __imx_uart_rxint(int irq, void *dev_id)
>> >> >>  	struct imx_port *sport = dev_id;
>> >> >>  	unsigned int rx, flg;
>> >> >>  	struct tty_port *port = &sport->port.state->port;
>> >> >> +	typeof(sport->port.membase) membase = sport->port.membase;
>> >> >>  	u32 usr2;
>> >> >>  
>> >> >>  	/* If we received something, check for 0xff flood */
>> >> >> -	usr2 = imx_uart_readl(sport, USR2);
>> >> >> +	usr2 = readl(membase + USR2);
>> >> >>  	if (usr2 & USR2_RDR)
>> >> >>  		imx_uart_check_flood(sport, usr2);
>> >> >>  
>> >> >> -	while ((rx = imx_uart_readl(sport, URXD0)) & URXD_CHARRDY) {
>> >> >> +	while ((rx = readl(membase + URXD0)) & URXD_CHARRDY) {
>> >> >>  		flg = TTY_NORMAL;
>> >> >>  		sport->port.icount.rx++;
>> >> >
>> >> > One of the motivations to introduce imx_uart_readl was to have a single
>> >> > place to add a debug output to be able to inspect what the driver is
>> >> > doing.
>> >> >
>> >> > I wonder where your need for higher speed comes from and if the compiler
>> >> > really generates more effective code with your change.
>> >> 
>> >> Mostly it's because I'm obviously slowing things down a bit with the
>> >> patch to fight the flood, so I feel obliged to get things back on par
>> >> with the origin. Then, higher speed, let alone the time spent with
>> >> interrupts disabled and/or spinlocks taken, is always one of generic
>> >> goals for me.
>> >> 
>> >> As for the generated code, with this patch I don't aim to affect code
>> >> generation, I rather avoid execution of part of existing code while
>> >> being on the most critical path. It should be quite obvious that not
>> >> executing some code is at least not slower than executing it.
>> >
>> > That's true, but I think it doesn't apply here.
>> 
>> Well, "at least not slower" still applies ;-)
>> 
>> >
>> > I would expect that the compiler "sees" for the call
>> >
>> > 	imx_uart_readl(sport, USR2)
>> >
>> > that the 2nd argument is constant and that for that value of offset the
>> > call is equivalent to readl(sport->port.membase + offset);
>> >
>> > So I doubt you're making anything quicker here.
>> 
>> Yep, it's nice compiler is clever enough to optimize-out the switch for
>> constant argument, though I still typically prefer to avoid over-relying
>> on optimizations. That said, I now tend to agree with your POV in this
>> particular case.
>> 
>> >
>> > I tried the following patch on mainline (that is without the preceding
>> > patches in this series):
>> >
>> > diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
>> > index 757825edb0cd..cfc2f7057345 100644
>> > --- a/drivers/tty/serial/imx.c
>> > +++ b/drivers/tty/serial/imx.c
>> > @@ -807,7 +807,7 @@ static irqreturn_t __imx_uart_rxint(int irq, void *dev_id)
>> >  	unsigned int rx, flg, ignored = 0;
>> >  	struct tty_port *port = &sport->port.state->port;
>> >  
>> > -	while (imx_uart_readl(sport, USR2) & USR2_RDR) {
>> > +	while (readl(sport->port.membase + USR2) & USR2_RDR) {
>> >  		u32 usr2;
>> >  
>> >  		flg = TTY_NORMAL;
>> >
>> > and the resulting code didn't change at all. For a bigger change (i.e.
>> > adding a variable for sport->port.membase and replacing two
>> > imx_uart_readl) the code changed quite a bit (it got 28 bytes bigger for
>> > imx_v6_v7_defconfig) and in the short time I tried I couldn't judge if
>> > the resulting code is better or not.
>> >
>> > So a change that explicitly doesn't execute the code that the compiler
>> > optimizes away anyhow isn't a win. Together with the fact that your
>> > patch makes register access use different idioms and so makes it harder
>> > to understand for a human I'd say the net benefit of your patch is
>> > negative.
>> 
>> OK, you convinced me to drop it.
>> 
>> >
>> >> > Please either drop the patch from your series or provide the differences
>> >> > the compiler produces and a benchmark.
>> >> 
>> >> If your only objection against this patch is the desire to keep a single
>> >> place to add debug output, I'll be happy to tune the resulting code to
>> >> still have one.
>> >
>> > I don't see the need to optimize it.
>> >
>> >> That said, before we make a decision, could you please tell why register
>> >> shadows that the imx_uart_readl/writel are dealing with are needed in
>> >> the first place? It looks like all the registers that are shadowed are
>> >> readable as well. What's going on here, and if it happens to be a
>> >> speed-up, do we have any benchmarks?
>> >
>> > Not sure I did benchmarks back then, probably not. The main motivation
>> > was really to have that single access function. So I admit being guilty
>> > to have implemented an optimization without hard numbers just assuming
>> > that access to (cached) RAM is quicker than the register space.
>> 
>> Well, even if it is quicker, we still spend time writing to both RAM and
>> register, and then there is no gain for the data Tx/Rx registers that
>> aren't cached, yet are on most critical paths.
>
> Well, assuming we're saving some time for the ctrl registers, it's worth
> keeping it even though there is no gain for RX/TX, right? There is no
> overhead for RX/TX.
>
>> So, if this is just caching and doesn't change behavior, I'd suggest to
>> get rid of the shadowing altogether, making code simpler to follow.
>
> Knowing it's subjective I don't think the shadowing is complicated.
> Functions are using the driver specific readl and writel functions and
> shadowing is limited to these two functions.

It's not complicated indeed, but it's still code, and the less code, --
the better.

>
> in sum today I wouldn't change if the code does shadow the registers
>or not if there isn't at least a strong hint that the one or the other
>variant is better. So if you still want to work on that you're welcome,
>but I invite you to do some benchmarks first and not only assume one or
>the other variant is better.

No code is better hands down, unless proved otherwise. I dunno if a code
that somehow sneaked into the kernel gets any specific significance from
the maintenance POV though. If so, for me it'd be the only sound
argument in favor of keeping the code intact.

>
> My (unproved) assumption is that for console usage there is hardly a
> difference and with a workflow that needs more changing of control
> settings (like half duplex rs485) shadowing is slightly better.

Well, also unproved, I tend to disagree here. I'm afraid you'd rather
have hard time finding a case where it is noticeably better, especially
as on the write path the shadowing is pure overhead, and so you'd have
hard time getting this code into the kernel in the first place, provided
somebody would care to object.

For what it's worth, I've removed the shadowing in my kernel version,
and it gave me no troubles yet. For reference, I use RS232 only with DMA
turned off.

Overall, my feeling about the issue: the shadowing code is confusing and
should not have been put there in the first place. Essentially it looks
like pure code bloat, so removing it would be an improvement. Thus I
figure I'll send a separate patch for this, and you guys decide if the
patch goes in (and the code in question goes out) or not.

Thanks,
-- Sergey Organov
