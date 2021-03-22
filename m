Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D96E0C433E0
	for <linux-serial@archiver.kernel.org>; Mon, 22 Mar 2021 11:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 905F561994
	for <linux-serial@archiver.kernel.org>; Mon, 22 Mar 2021 11:40:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbhCVLjn (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 22 Mar 2021 07:39:43 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53608 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbhCVLjX (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 22 Mar 2021 07:39:23 -0400
Date:   Mon, 22 Mar 2021 12:39:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616413160;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5ZhX+YE/qD6wm9rEUpODyk3JBhUspUq04ONWRA919tI=;
        b=DLf5/KRpvDoWIs85QD34KKZvMM/CGNjcRxRY3lF40GhFLoSYDDk6UwtmSdXqYqPqT5SFcq
        1kNJ+FbthHV/MpYxlQDutpf9KNfcekne/v9jsAk9/MGkFngNtAN9PN3Ke/TMlPVPKDvom/
        PdyIJSuCfZRCZnnb4KdXFX/owtIz58bE/Nkz6N4RvxWepBCnun65qMkRS6b2dzhrFXCflF
        VPbG/2BtSJPYLqYXuJCKC3fOazIQK9pxiQFnW0ddSBT1+F3/1r9yQeEruAtN3JovHR99HH
        tJIGSKzBG5UWLccY10hOcBYO8qxt/vb1epxPVMkRTWH+ePNF4J9lNOli7+Xn6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616413160;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5ZhX+YE/qD6wm9rEUpODyk3JBhUspUq04ONWRA919tI=;
        b=lviYqnUjfYbaYCagkQiljIDSUmTIThsm8Y5+YPECy0rY8ZuMD5rQlw4Yp9vyLOhYSuTeQo
        4oUDDcSx+Fb95fCA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sam Nobs <samuel.nobs@taitradio.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] serial: imx: drop workaround for forced irq threading
Message-ID: <20210322113918.ze52gq54cpsspgej@linutronix.de>
References: <20210322111036.31966-1-johan@kernel.org>
 <20210322113402.naqzgkoe2xesnw4b@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210322113402.naqzgkoe2xesnw4b@pengutronix.de>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 2021-03-22 12:34:02 [+0100], Uwe Kleine-K=C3=B6nig wrote:
> On Mon, Mar 22, 2021 at 12:10:36PM +0100, Johan Hovold wrote:
> > Force-threaded interrupt handlers used to run with interrupts enabled,
> > something which could lead to deadlocks in case a threaded handler
> > shared a lock with code running in hard interrupt context (e.g. timer
> > callbacks) and did not explicitly disable interrupts.
> >=20
> > This was specifically the case for serial drivers that take the port
> > lock in their console write path as printk can be called from hard
> > interrupt context also with forced threading ("threadirqs").
> >=20
> > Since commit 81e2073c175b ("genirq: Disable interrupts for force
> > threaded handlers") interrupt handlers always run with interrupts
> > disabled on non-RT so that drivers no longer need to do handle this.
>=20
> So we're breaking RT knowingly here? If this is the case I'm not happy
> with your change. (And if RT is not affected a different wording would
> be good.)

Which wording, could you be more specific? It looks good from here and
no, RT is not affected.

> Best regards
> Uwe

Sebastian
