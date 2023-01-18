Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99EB1C32793
	for <linux-serial@archiver.kernel.org>; Wed, 18 Jan 2023 15:40:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjARPkY (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 18 Jan 2023 10:40:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjARPkX (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 18 Jan 2023 10:40:23 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 326AB1A1
        for <linux-serial@vger.kernel.org>; Wed, 18 Jan 2023 07:40:22 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id x10so47285983edd.10
        for <linux-serial@vger.kernel.org>; Wed, 18 Jan 2023 07:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JdynXb9AFJSkLCiMWLmy2PGBzyt5yNCXHVTVGIouuMI=;
        b=O8xBNI2mCGIsYXgLx553Aoj3TCRNj0uhB9jVEcmD6ZqiqK3soB23ZDQT4Cf6PvBATa
         1jAFcOG5/s2vdQDHAEtu0zbqzoonva/sWtC4Q0YaKj0iFh+Cf3S14s5kTrIzFLQEd2rE
         HEk9ryIEqALuTZIC2C15Eb6LVhZqb/UrWQc8+S9pMR2tjwScq/afi+GNA+wtjk3Kmc5A
         LMo2DQQ8LaTEcTvgQs+EYlKMjaN+VvQblHfrTtppUOL+V4YVgWhl9b0eQgFxs507AGDz
         G4ys4iFRdV7m4rWeog0kslUc6wLWxtNLLmZfLE19nDOH8076h35HVfoYMeGrrBoj9ZvR
         SOhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JdynXb9AFJSkLCiMWLmy2PGBzyt5yNCXHVTVGIouuMI=;
        b=1xBTGE1Ukk441xceeaEKxsDOwP1nMcxUpGUyv6TNpy96VXFu9Ou1QylGwK/S8O8J87
         gE+i4y1pq29S2YEauDGxg34WiKb3HCyxsiqkGlEX0lWrfm3qlq6tw40ojymrqPAYuQ2N
         4zGJJtsp7aVL9UHx6mNxfkZcGfQh+pgFA4tILUwPHAlHbaXD1SINqYONXb7Y+B1cmlHP
         4i4jVUj+pktjHR2ymmLflVHsGyyJMN73y1u+M6T45KECnnpXYrX0UUmaNeCccm9kWhlr
         uLQWRiCCCAJ0rveRwwk52wIXjMwlcMSSVlSuYKgNTDV5463Sa3yOw51MhHtcYS99ghkI
         DfDQ==
X-Gm-Message-State: AFqh2kqNEGYA08WiL3vqYwE+EnqemEzyRvkyWdx0QmLlF0WVwkxOVWuq
        IQa3FBD7sB0FgjGwsxd5j6knAA5llOE=
X-Google-Smtp-Source: AMrXdXsNRgjbRp9/UsIp51mIZAsHt9N8Cv3aBOjVjdadVE0cAGrMeWpkj57fDfzBNrMGuFt7CfL8QQ==
X-Received: by 2002:a05:6402:43ce:b0:461:2288:6808 with SMTP id p14-20020a05640243ce00b0046122886808mr8033780edc.21.1674056420402;
        Wed, 18 Jan 2023 07:40:20 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id en6-20020a056402528600b00499b3d09bd2sm12083032edb.91.2023.01.18.07.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 07:40:19 -0800 (PST)
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
Date:   Wed, 18 Jan 2023 18:40:17 +0300
In-Reply-To: <20230117212702.vvwe3rqjedivqbhn@pengutronix.de> ("Uwe
        =?utf-8?Q?Kleine-K=C3=B6nig=22's?= message of "Tue, 17 Jan 2023 22:27:02
 +0100")
Message-ID: <87ilh3zw9q.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Uwe Kleine-König <u.kleine-koenig@pengutronix.de> writes:

> Hello Sergey,
>
> On Tue, Jan 17, 2023 at 04:22:51PM +0300, Sergey Organov wrote:
>> Uwe Kleine-König <u.kleine-koenig@pengutronix.de> writes:
>> > On Fri, Jan 13, 2023 at 09:43:33PM +0300, Sergey Organov wrote:
>> >> Use readl() instead of heavier imx_uart_readl() in the Rx ISR, as we know
>> >> we read registers that must not be cached.
>> >> 
>> >> Signed-off-by: Sergey Organov <sorganov@gmail.com>
>> >> ---
>> >>  drivers/tty/serial/imx.c | 5 +++--
>> >>  1 file changed, 3 insertions(+), 2 deletions(-)
>> >> 
>> >> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
>> >> index be00362b8b67..f4236e8995fa 100644
>> >> --- a/drivers/tty/serial/imx.c
>> >> +++ b/drivers/tty/serial/imx.c
>> >> @@ -890,14 +890,15 @@ static irqreturn_t __imx_uart_rxint(int irq, void *dev_id)
>> >>  	struct imx_port *sport = dev_id;
>> >>  	unsigned int rx, flg;
>> >>  	struct tty_port *port = &sport->port.state->port;
>> >> +	typeof(sport->port.membase) membase = sport->port.membase;
>> >>  	u32 usr2;
>> >>  
>> >>  	/* If we received something, check for 0xff flood */
>> >> -	usr2 = imx_uart_readl(sport, USR2);
>> >> +	usr2 = readl(membase + USR2);
>> >>  	if (usr2 & USR2_RDR)
>> >>  		imx_uart_check_flood(sport, usr2);
>> >>  
>> >> -	while ((rx = imx_uart_readl(sport, URXD0)) & URXD_CHARRDY) {
>> >> +	while ((rx = readl(membase + URXD0)) & URXD_CHARRDY) {
>> >>  		flg = TTY_NORMAL;
>> >>  		sport->port.icount.rx++;
>> >
>> > One of the motivations to introduce imx_uart_readl was to have a single
>> > place to add a debug output to be able to inspect what the driver is
>> > doing.
>> >
>> > I wonder where your need for higher speed comes from and if the compiler
>> > really generates more effective code with your change.
>> 
>> Mostly it's because I'm obviously slowing things down a bit with the
>> patch to fight the flood, so I feel obliged to get things back on par
>> with the origin. Then, higher speed, let alone the time spent with
>> interrupts disabled and/or spinlocks taken, is always one of generic
>> goals for me.
>> 
>> As for the generated code, with this patch I don't aim to affect code
>> generation, I rather avoid execution of part of existing code while
>> being on the most critical path. It should be quite obvious that not
>> executing some code is at least not slower than executing it.
>
> That's true, but I think it doesn't apply here.

Well, "at least not slower" still applies ;-)

>
> I would expect that the compiler "sees" for the call
>
> 	imx_uart_readl(sport, USR2)
>
> that the 2nd argument is constant and that for that value of offset the
> call is equivalent to readl(sport->port.membase + offset);
>
> So I doubt you're making anything quicker here.

Yep, it's nice compiler is clever enough to optimize-out the switch for
constant argument, though I still typically prefer to avoid over-relying
on optimizations. That said, I now tend to agree with your POV in this
particular case.

>
> I tried the following patch on mainline (that is without the preceding
> patches in this series):
>
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 757825edb0cd..cfc2f7057345 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -807,7 +807,7 @@ static irqreturn_t __imx_uart_rxint(int irq, void *dev_id)
>  	unsigned int rx, flg, ignored = 0;
>  	struct tty_port *port = &sport->port.state->port;
>  
> -	while (imx_uart_readl(sport, USR2) & USR2_RDR) {
> +	while (readl(sport->port.membase + USR2) & USR2_RDR) {
>  		u32 usr2;
>  
>  		flg = TTY_NORMAL;
>
> and the resulting code didn't change at all. For a bigger change (i.e.
> adding a variable for sport->port.membase and replacing two
> imx_uart_readl) the code changed quite a bit (it got 28 bytes bigger for
> imx_v6_v7_defconfig) and in the short time I tried I couldn't judge if
> the resulting code is better or not.
>
> So a change that explicitly doesn't execute the code that the compiler
> optimizes away anyhow isn't a win. Together with the fact that your
> patch makes register access use different idioms and so makes it harder
> to understand for a human I'd say the net benefit of your patch is
> negative.

OK, you convinced me to drop it.

>
>> > Please either drop the patch from your series or provide the differences
>> > the compiler produces and a benchmark.
>> 
>> If your only objection against this patch is the desire to keep a single
>> place to add debug output, I'll be happy to tune the resulting code to
>> still have one.
>
> I don't see the need to optimize it.
>
>> That said, before we make a decision, could you please tell why register
>> shadows that the imx_uart_readl/writel are dealing with are needed in
>> the first place? It looks like all the registers that are shadowed are
>> readable as well. What's going on here, and if it happens to be a
>> speed-up, do we have any benchmarks?
>
> Not sure I did benchmarks back then, probably not. The main motivation
> was really to have that single access function. So I admit being guilty
> to have implemented an optimization without hard numbers just assuming
> that access to (cached) RAM is quicker than the register space.

Well, even if it is quicker, we still spend time writing to both RAM and
register, and then there is no gain for the data Tx/Rx registers that
aren't cached, yet are on most critical paths.

So, if this is just caching and doesn't change behavior, I'd suggest to
get rid of the shadowing altogether, making code simpler to follow.
Besides, if it were so, I'd had no temptation to replace the
imx_uart_readl() with raw readl().

Thanks,
-- Sergey
