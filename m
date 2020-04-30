Return-Path: <SRS0=pdp3=6O=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3518CC47247
	for <linux-serial@archiver.kernel.org>; Thu, 30 Apr 2020 16:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11ECF2082E
	for <linux-serial@archiver.kernel.org>; Thu, 30 Apr 2020 16:47:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DR4GRE1T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbgD3Qrm (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 30 Apr 2020 12:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726396AbgD3Qrm (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 30 Apr 2020 12:47:42 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16E8EC035494
        for <linux-serial@vger.kernel.org>; Thu, 30 Apr 2020 09:47:42 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id e9so2175209iok.9
        for <linux-serial@vger.kernel.org>; Thu, 30 Apr 2020 09:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hBtVi/B4LPd4rRf9CEmZJjnlyoXbvXsuWtCUKyK+qR8=;
        b=DR4GRE1TTJdVdqqNkzD9HvSJO3aKd8slDhb6oW+zf4W3fg6ciNocMNd0uAmOp9/LgQ
         cdAfiNZUtnc15ebRDnToxFcEed9hDv0mdi28ZFPnEVxiEfo+BQszuWQgZRn65MiJoAyJ
         jn97XH/UG5N4WBMhhQ3jQLMtEX4MQqOPntizs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hBtVi/B4LPd4rRf9CEmZJjnlyoXbvXsuWtCUKyK+qR8=;
        b=uBu1tu0SDRnrhZT/VDeTfUbDMAmFz2rrezzov2eKTxDcZ9YoDzRNJ22SRn8oawFWCf
         u/DRClqdC50o2dtIQkgc/Cpsuy4hWSK/nHRb29OwNVK/I6vp1tCqj1AKYi9ytKXIRxCM
         v8Y4J3CJLtDb8rRMOdBiAWTXmzXv/4LoegxViYjV11zNpaYqDqSs3kQPTBC/AxTNhJh3
         uKwhONbtGEL8BpkhZtHHddfWh0N0yRKjFZxAsh65znUNl4aRYXc6/gwbkGxvtbxvZoNs
         s5LtaodsHjazEwAsuC3epFuXwv6abdABObLCRDHXY8SMNCDGa7kdzwNBlVUOvGo/9III
         9EAw==
X-Gm-Message-State: AGi0PuZAYQsM1dB4DTNMlwD5uTbyT+7YBGOpTZ0Bx6Xs4Cjl54fcx1aX
        M9DNtWu2cKeJMLrZSOTnrpZ1cepUjZ0=
X-Google-Smtp-Source: APiQypJvWjAq/asOQvKuou3rxlKx8BsHKEv26t/lhcdRr1t5qe/b2/+oWmiuVQ8B1DUM/oZTRf5o2Q==
X-Received: by 2002:a5e:d709:: with SMTP id v9mr2838279iom.195.1588265261295;
        Thu, 30 Apr 2020 09:47:41 -0700 (PDT)
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com. [209.85.166.45])
        by smtp.gmail.com with ESMTPSA id q88sm130231ilb.7.2020.04.30.09.47.41
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2020 09:47:41 -0700 (PDT)
Received: by mail-io1-f45.google.com with SMTP id k18so2208288ion.0
        for <linux-serial@vger.kernel.org>; Thu, 30 Apr 2020 09:47:40 -0700 (PDT)
X-Received: by 2002:a5d:87cd:: with SMTP id q13mr2758350ios.61.1588265259570;
 Thu, 30 Apr 2020 09:47:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200429170804.880720-1-daniel.thompson@linaro.org> <20200430161741.1832050-1-daniel.thompson@linaro.org>
In-Reply-To: <20200430161741.1832050-1-daniel.thompson@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 30 Apr 2020 09:47:27 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U64XLRFkTyTi1qDZjTYQKJ9WVBf3OoULpw6yncOQURTg@mail.gmail.com>
Message-ID: <CAD=FV=U64XLRFkTyTi1qDZjTYQKJ9WVBf3OoULpw6yncOQURTg@mail.gmail.com>
Subject: Re: [PATCH v2] serial: kgdboc: Allow earlycon initialization to be deferred
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Patch Tracking <patches@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,

On Thu, Apr 30, 2020 at 9:18 AM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> Currently there is no guarantee that an earlycon will be initialized
> before kgdboc tries to adopt it. Almost the opposite: on systems
> with ACPI then if earlycon has no arguments then it is guaranteed that
> earlycon will not be initialized.
>
> This patch mitigates the problem by giving kgdboc_earlycon a second
> chance during console_init(). This isn't quite as good as stopping during
> early parameter parsing but it is still early in the kernel boot.
>
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> ---
>
> Notes:
>     v2: Simplified, more robust, runs earlier, still has Doug's
>         recent patchset as a prerequisite. What's not to like?
>
>     More specifically, based on feedback from Doug Anderson, I
>     have replaced the initial hacky implementation with a console
>     initcall.
>
>     I also made it defer more aggressively after realizing that both
>     earlycon and kgdboc_earlycon are handled as early parameters
>     (meaning I think the current approach relies on the ordering
>     of drivers/tty/serial/Makefile to ensure the earlycon is enabled
>     before kgdboc tries to adopt it).
>
>     Finally, my apologies to Jason and kgdb ML folks, who are seeing
>     this patch for the first time. I copied the original circulation
>     list from a patch that wasn't kgdb related and forgot to update.
>
>  drivers/tty/serial/kgdboc.c | 41 +++++++++++++++++++++++++++++++++++--
>  1 file changed, 39 insertions(+), 2 deletions(-)

Thanks, this looks great!

Reviewed-by: Douglas Anderson <dianders@chromium.org>
