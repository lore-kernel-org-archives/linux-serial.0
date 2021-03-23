Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8DDFC433C1
	for <linux-serial@archiver.kernel.org>; Tue, 23 Mar 2021 09:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B064619B2
	for <linux-serial@archiver.kernel.org>; Tue, 23 Mar 2021 09:04:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbhCWJE0 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 23 Mar 2021 05:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbhCWJEQ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 23 Mar 2021 05:04:16 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC2BC061574;
        Tue, 23 Mar 2021 02:04:15 -0700 (PDT)
Date:   Tue, 23 Mar 2021 10:04:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616490254;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GxnyY0C/BL+SWjI1WAMA2hS6FNIin/OZV9pi9TETKDA=;
        b=jKR8nH7Swa4DWx21vuj0HUcMHmuduY2uEBzGACtLxBeZjP4zBpKIatE/K0HTyMnvj+mHb1
        sIC6nIodDPCS5IG+jcjYHJlBSqmILOgPaDCgDWJz8+ru+PKFzMsWwq0UxUMsPedVtHReFK
        8lF2S/kv80gOutNHKDZhfi5fcWk8ZmcDw4/PL59oGx/gGIEBrcrvP49QEHgYZHMafz+t8M
        PtgzfVfSAg8Fl8/lR3CBpkb+xJ8ay9MeFtruL28vjuKb2myiRCuW4TS5xUpT+b1aeB57JX
        fAg8mdDgmZO8RlOcYOce6QVtnJ0pH1bGQ0gJInh8kOEs1b6WU07qxAAKhkJ2zw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616490254;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GxnyY0C/BL+SWjI1WAMA2hS6FNIin/OZV9pi9TETKDA=;
        b=q51R+RGcn4T8i7CWIilD8rjF69yvS499TTfLxi4DQ47DkWsSK3/LcE3o/EIDUtTjYOHeLB
        x39zsZNgCkG7TfDA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sam Nobs <samuel.nobs@taitradio.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>, kernel@pengutronix.de
Subject: Re: [PATCH] serial: imx: drop workaround for forced irq threading
Message-ID: <20210323090413.ogeweygw3iejtbsv@linutronix.de>
References: <20210322111036.31966-1-johan@kernel.org>
 <20210322113402.naqzgkoe2xesnw4b@pengutronix.de>
 <20210322113918.ze52gq54cpsspgej@linutronix.de>
 <20210322115536.knkea7i6vrfpotol@pengutronix.de>
 <YFiZuXWYmxPIaQH9@hovoldconsulting.com>
 <20210322134032.kmirudtnkd4akkgu@pengutronix.de>
 <20210322204836.i4ksobvp6hxl5owh@linutronix.de>
 <20210323073447.r3utxintt5c3blb4@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210323073447.r3utxintt5c3blb4@pengutronix.de>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 2021-03-23 08:34:47 [+0100], Uwe Kleine-K=C3=B6nig wrote:
> Hello Sebastian,
Hi Uwe,

> On Mon, Mar 22, 2021 at 09:48:36PM +0100, Sebastian Andrzej Siewior wrote:
> > On 2021-03-22 14:40:32 [+0100], Uwe Kleine-K=C3=B6nig wrote:
> > > From a strictly logically point of view you indeed cannot. But if you=
 go
> > > to the street and say to people there that they can park their car in
> > > this street free of charge between Monday and Friday, I expect that m=
ost
> > > of them will assume that they have to pay for parking on weekends.
> >=20
> > If I hear that parking is free on weekdays and on paid on weekends, I
> > expect it to be a scam.
>=20
> I don't feel taken seriously with this reply.

I'm sorry.

> > Uwe, the patch reverts a change which was needed for !RT + threadirqs.
>=20
> This would be a useful information for the commit log.
>=20
> > The commit message claims that since the referenced commit "=E2=80=A6 i=
nterrupt
> > handlers always run with interrupts disabled on non-RT=E2=80=A6 ". This=
 has
> > nothing to do with _this_ change. It argues why the workaround is not
> > needed.
>=20
> It argues why the work around is not needed on non-RT. It might be
> obvious for someone who is firm in the RT concepts, but IMHO commit logs
> should be understandable by and make sense for a wider audience than the
> deep experts. From what I know about RT "Force-threaded interrupt
> handlers used to run with interrupts enabled" still applies there.

Yes. The commit Johan referenced explains it in more detail.

> > If the referenced commit breaks RT then this is another story.
>=20
> I'm surprised to hear that from you. With the goal to get RT into
> mainline I would expect you to be happy if people consider the effects
> on RT in their reviews.

Correct, I do and I am glad if people consider other aspects of the
kernel in their review including RT.

> > > So when you said that on on-RT the reason why it used to need a
> > > workaround is gone made me wonder what that implies for RT.
> >=20
> > There was never reason (or a lockdep splat) for it on RT. If so you
> > should have seen it, right?
>=20
> No, I don't consider myself to be an RT expert who is aware of all the
> problems. So I admit that for me the effect on RT of the patch under
> discussion isn't obvious. I just wonder that the change is justified
> with being OK on non-RT. So it's either bad that it breaks RT *or*
> improving the commit log would be great.
>=20
> And even if I had reason to believe that there is no problem with the
> commit on RT, I'd still wish that the commit log wouldn't suggest to the
> casual reader that there might be a problem.

Okay. I added a sentence. What about this rewording:

  Force-threaded interrupt handlers used to run with interrupts enabled,
  something which could lead to deadlocks in case a threaded handler
  shared a lock with code running in hard interrupt context (e.g. timer
  callbacks) and did not explicitly disable interrupts. =20
 =20
  This was specifically the case for serial drivers that take the port
  lock in their console write path as printk can be called from hard
  interrupt context also with forced threading ("threadirqs").
 =20
  Since commit 81e2073c175b ("genirq: Disable interrupts for force
  threaded handlers") interrupt handlers always run with interrupts
  disabled on non-RT so that drivers no longer need to do handle this.
  RT is not affected by the referenced commit and the workaround, that is
  reverted, was not required because spinlock_t must not be acquired on
  RT in hardirq context.
 =20
  Drop the now obsolete workaround added by commit 33f16855dcb9 ("tty:
  serial: imx: fix potential deadlock").

> Best regards
> Uwe
>=20

Sebastian
