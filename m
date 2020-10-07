Return-Path: <SRS0=cVGZ=DO=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FF6DC4363C
	for <linux-serial@archiver.kernel.org>; Wed,  7 Oct 2020 08:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E6A421D90
	for <linux-serial@archiver.kernel.org>; Wed,  7 Oct 2020 08:48:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PFms68Hc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbgJGIsL (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 7 Oct 2020 04:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727914AbgJGIsL (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 7 Oct 2020 04:48:11 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38519C061755
        for <linux-serial@vger.kernel.org>; Wed,  7 Oct 2020 01:48:11 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id e10so968562pfj.1
        for <linux-serial@vger.kernel.org>; Wed, 07 Oct 2020 01:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ik1oEgp1T80byoGqbNiNVs/dfMtf5Ch/lCaFFQ9eyAE=;
        b=PFms68HcnqBXElED5VebUwLLrk07JKpOP4LpCSRGt56Ga6lW27Qu3bxqSKxgRKHimK
         jGs45MyVpC6OqQdx6u8YjZOgDv10Ckff1s0dJxBuZ1bkFJ0fUve+mBgi0TZ6cW2EhZjH
         dKDgcwvnHzjkPS0XB2GCbsHJ4mgWSGUltIA036/eBOhPk8mJahi/2bVWqPissuSjrizr
         IjhUhb5j7UzJojln1a805NQa700MV84EQzvd4gxuFpuH08LSpnB1xLZUvsuO1crKAgpz
         NL1VecY6vpAeHCfMBnZJKeAfr7iphQXaKl5BOoR8ZK2JqWqM2egC2+Hd88uQGQRNEwOD
         oi6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ik1oEgp1T80byoGqbNiNVs/dfMtf5Ch/lCaFFQ9eyAE=;
        b=pcI7D0hScDYHUltz5WO24/YWzh2q7aHOjJMeI508KKLSWFvL02i9DBacw5zgoKp7Iy
         kOcyTnkTGg08INTEB2y4MPkG6ueTwE5dLO1x+atdd4h4fT+dUe6SopPm18Pfj6BRCs1W
         5ZrB0Chyy/h9FTuK1LxjNhJjHmiA0TBHkvMERMF3f1HvK9nEa1n3p2/b9iRlnaQfO8sO
         NEr9ZqcZ0p0pAeNrDVdxMxYES2RGb/41j9D5ONsDQW/iNEkGHItQfkvolAEc+1ejYfAh
         H1Gw5hoKedCF4s1LuKK4SO9etDUpqNQUpFhbyMpRSffM3koxEASRP4v6HEqPKkGZ4pzb
         B+KQ==
X-Gm-Message-State: AOAM533ubRFF/mXV1MHr/jL/7tLAGc76z1KaRX4ttDeqEEP0Vc+73K4D
        Ag1IM1tobdtROZrWspeuxm0+xrFY5VKagQDTuVWKFzH0RzyLpA==
X-Google-Smtp-Source: ABdhPJwbBbEDLQvJ4NcrpQ56/t2yyVRTEpv7z42yUUyygJlU0zvrFPFqfzZ1jO//hym/AQATbUHeve+7ikDeErCdCe0=
X-Received: by 2002:a63:ec4c:: with SMTP id r12mr2081411pgj.74.1602060490711;
 Wed, 07 Oct 2020 01:48:10 -0700 (PDT)
MIME-Version: 1.0
References: <20201006222222.583254-1-andy.shevchenko@gmail.com> <20201007073232.GB340590@kroah.com>
In-Reply-To: <20201007073232.GB340590@kroah.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 7 Oct 2020 11:47:54 +0300
Message-ID: <CAHp75VcHyH9vu7-hW2w36WLBpjRLyffDyyt9Cn0_PHzTw+kXeg@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] serial: max310x: Make use of device properties
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Oct 7, 2020 at 10:31 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Wed, Oct 07, 2020 at 01:22:21AM +0300, Andy Shevchenko wrote:
> > Device property API allows to gather device resources from different sources,
> > such as ACPI. Convert the drivers to unleash the power of device property API.

> Did you send 2 copies of this patch series?

Sorry for that. I had issues with local MTA, now fixed.

> Which is correct?

Any, but...

> I'll drop both and wait for a v2 :)

...just sent a v2, thanks!


-- 
With Best Regards,
Andy Shevchenko
