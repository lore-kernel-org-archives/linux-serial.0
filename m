Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F40CC433DB
	for <linux-serial@archiver.kernel.org>; Mon, 22 Mar 2021 20:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27A2C619A2
	for <linux-serial@archiver.kernel.org>; Mon, 22 Mar 2021 20:49:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbhCVUtC (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 22 Mar 2021 16:49:02 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56276 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbhCVUsj (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 22 Mar 2021 16:48:39 -0400
Date:   Mon, 22 Mar 2021 21:48:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616446117;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oJ7SnGL63YNzmUIoNkN5uWafCnvlDUpQmFZmeX30mvs=;
        b=KobXtScO8ZGUPKCdmYD0WZVsPNnSy81JhTUFmLHrLEJxgrYU2X0BFhfaJQvg2PZM/BF6hU
        /wm4e1hXB2Yj96sSLvgAS/s1IRTgcfX9oYtUnfIO8jjQsaSW04yXKxhKIrOnHK1IcV4fdX
        823brl2EtOeg26SQFg6achSoDr/m2Ba+DdKPbFjlCGAGau+yYovFvY2rtnel4CwsXoCN0J
        RPLIHVYZanjxBHpJ159da+Aiolp4XV6Uuv2j/gt9XKjv+6JoxGeRukSeD2F+01H+Pm6ply
        L4nqIv+nIyH4Edkm4McvAP2G/EaCu+muN/ry/olXzRRJsXJidSq/u93V5NadgA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616446117;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oJ7SnGL63YNzmUIoNkN5uWafCnvlDUpQmFZmeX30mvs=;
        b=dxC5Bdd4q9/wLuu3RhPSwlhjBqTjc6vHbhPrwkT8TrBLdwXmj6Ptyr3xWvayUoFNMpd2Tq
        RjrzFLfn/yBFuABQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sam Nobs <samuel.nobs@taitradio.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] serial: imx: drop workaround for forced irq threading
Message-ID: <20210322204836.i4ksobvp6hxl5owh@linutronix.de>
References: <20210322111036.31966-1-johan@kernel.org>
 <20210322113402.naqzgkoe2xesnw4b@pengutronix.de>
 <20210322113918.ze52gq54cpsspgej@linutronix.de>
 <20210322115536.knkea7i6vrfpotol@pengutronix.de>
 <YFiZuXWYmxPIaQH9@hovoldconsulting.com>
 <20210322134032.kmirudtnkd4akkgu@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210322134032.kmirudtnkd4akkgu@pengutronix.de>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 2021-03-22 14:40:32 [+0100], Uwe Kleine-K=C3=B6nig wrote:
> From a strictly logically point of view you indeed cannot. But if you go
> to the street and say to people there that they can park their car in
> this street free of charge between Monday and Friday, I expect that most
> of them will assume that they have to pay for parking on weekends.

If I hear that parking is free on weekdays and on paid on weekends, I
expect it to be a scam.

Uwe, the patch reverts a change which was needed for !RT + threadirqs.
The commit message claims that since the referenced commit "=E2=80=A6 inter=
rupt
handlers always run with interrupts disabled on non-RT=E2=80=A6 ". This has
nothing to do with _this_ change. It argues why the workaround is not
needed.
If the referenced commit breaks RT then this is another story.

> So when you said that on on-RT the reason why it used to need a
> workaround is gone made me wonder what that implies for RT.

There was never reason (or a lockdep splat) for it on RT. If so you
should have seen it, right?

Sebastian
