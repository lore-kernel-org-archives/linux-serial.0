Return-Path: <SRS0=INAG=AM=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F24C433E0
	for <linux-serial@archiver.kernel.org>; Wed,  1 Jul 2020 18:27:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6506F2082F
	for <linux-serial@archiver.kernel.org>; Wed,  1 Jul 2020 18:27:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kueMV6F7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732895AbgGAS1L (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 1 Jul 2020 14:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732893AbgGAS1L (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 1 Jul 2020 14:27:11 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5189C08C5C1
        for <linux-serial@vger.kernel.org>; Wed,  1 Jul 2020 11:27:10 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id z17so20966112edr.9
        for <linux-serial@vger.kernel.org>; Wed, 01 Jul 2020 11:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OG4wPTT0MmrDulPUOcAMjDpTxFn9+Ne6TG3MoSiqdqI=;
        b=kueMV6F7kixPK1r1LUmhosoUHdVoF26Nf7ilD50zWA0NpUVw2p9yB0VvFIkRe/MTtc
         91Xu9beFY4EHpT+wkm6Rf3FairVR3Ax2kAQon0LmoIDmczNj+HbtS5eTEZStT4jqB2js
         dQm6UUhYMhcNm6YfeIiWbP+SaALeAFyOb+DA7qWn0AR5SyN+87ut7KhZNq3KKd3y14f/
         CIPP7EhHSkxDxlRJHp4CIIeUz+56LGpAb9VTAJ0e2pFw0Pmx7tunsWd1JBt1SBdWRb9n
         cdxMSH7jDl+9lEbGa6XGaGGZUCnNedzKRgVZcs55lerfHPgFGrZMC2WFPInkX4+Nb7Iu
         zq6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OG4wPTT0MmrDulPUOcAMjDpTxFn9+Ne6TG3MoSiqdqI=;
        b=WE9ItpSW5mLeYf91eIKKT1SrV7KqWcB2bAweORkzN7HfVEayUxAsYh6WYopFNKSxIG
         aFtM1cOoGrcOCkIBNEPv03zFvQn1+m3BVTEbNUnNq4I5xhtgIa/n0G8RMfaKQH9UzllY
         RNtcDzZuJCAuI5co4b7QFyli10a5LAvgNGSON7QG6Z3unNUZXKLPwOX5RvkDzTc1sWN9
         IEO8d0uUlcmc1CMnyoMWebxn7dqUBnp+G7yIPOxOwXQKUPCqvqEFHjkMpfhBpeSIx1dE
         S97QhlxSYvv5ABuWCQRJ5m3aDUggC9EyKoqAADUkAqb8jhWo4VvLkxeQS6v7y6UVrFTq
         3CJg==
X-Gm-Message-State: AOAM5311v+RVWh1LwuEoPbIAVbcM+G93muPaD41F1o+Y9qFnYRbCdKM6
        rjONmWVzQlPC5zl/0XctQXPVQ0BeKmIqJpvDGtKcmw==
X-Google-Smtp-Source: ABdhPJwhuYNT92qHEkOHTddUFOs9/EMZDO1PWPD6MclccZefmL+2QM2Zb42zJC3klECb9ZpeCORMlH1ZSHciYjL+BvU=
X-Received: by 2002:a50:c219:: with SMTP id n25mr30985162edf.306.1593628029348;
 Wed, 01 Jul 2020 11:27:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200630164204.1.I2cc415fa5793b3e55acfd521ba8f0a71e79aa5f1@changeid>
 <20200701132606.GA2363542@kroah.com>
In-Reply-To: <20200701132606.GA2363542@kroah.com>
From:   Daniel Winkler <danielwinkler@google.com>
Date:   Wed, 1 Jul 2020 11:26:58 -0700
Message-ID: <CAP2xMbtvf1BcRLJqrdMwEtrxt-EeDvPtUSontfsRZT+FvNvJbQ@mail.gmail.com>
Subject: Re: [PATCH] Revert "serial: 8250: Fix max baud limit in generic 8250 port"
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org, linux-mediatek@lists.infradead.org,
        chromeos-bluetooth-upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        Aaron Sierra <asierra@xes-inc.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jiri Slaby <jslaby@suse.com>, Lukas Wunner <lukas@wunner.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hello all,

Please forgive any omitted information, as this is my first
upstreaming experience. I am preparing a second patch that will
clarify the requested points. Thanks in advance!

Best regards,
Daniel Winkler


On Wed, Jul 1, 2020 at 6:26 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Jun 30, 2020 at 04:42:11PM -0700, Daniel Winkler wrote:
> > This reverts commit 0eeaf62981ecc79e8395ca8caa1570eaf3a12257.
> >
> > The change regresses the QCA6174A-3 bluetooth chip, preventing
> > firmware from being properly loaded. We have verified that without
> > this patch, the chip works as intended.
> >
> > Signed-off-by: Daniel Winkler <danielwinkler@google.com>
>
> No cc: stable?  No Fixes: tag?
>
> {sigh}
>
