Return-Path: <SRS0=7S4r=BV=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD18AC433E0
	for <linux-serial@archiver.kernel.org>; Tue, 11 Aug 2020 20:03:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8407D20781
	for <linux-serial@archiver.kernel.org>; Tue, 11 Aug 2020 20:03:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xuN4qX3c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgHKUDE (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 11 Aug 2020 16:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726271AbgHKUDD (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 11 Aug 2020 16:03:03 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 268F0C061787
        for <linux-serial@vger.kernel.org>; Tue, 11 Aug 2020 13:03:03 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id b22so13397379oic.8
        for <linux-serial@vger.kernel.org>; Tue, 11 Aug 2020 13:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/L5XEoeU6SfSw+3MAGdjCZdmWhATe3RdZadKI67cXZo=;
        b=xuN4qX3cNWgNZIkfenGKniMbJgU7TWaqGefaAdIjgLuz82L5ys44wwFfm/lbiuAeqp
         4VNghtvxbMCCekrVw0BRCBmXO9EaCB87qMJrh1o012IFDkTI98U+tXoJihtWFJ+jfWUA
         EY6iMFHKCFRaJylHUFxYYoEEUfwAhTVukp+ihgaa/4iNizF25DEGM/0sOVpOR71L6uTF
         sqJxHU3UJoHadr/CQTgQJSYvd8hjuGu59uFWF0Z7gd2Q7UgZLCloetJljvx5SDVBx8Ak
         oRoLdr3njf+UyhcXOp9HMgJxsWrn9XeFLZRP57ixcuHAtf30QAU/ljV84hWWf5+COulF
         L+ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/L5XEoeU6SfSw+3MAGdjCZdmWhATe3RdZadKI67cXZo=;
        b=hzT1KB0jrQg4FMHBW6+2x5tbZpeZPQI9RyAEWTl0Lt43Et/zSrJ2Zc4zVcyCDNEX2Q
         b2Rtp5sTeBv1QaeeeEQx/TkE4o3UAmwgxsGyEQi4sL19PMdUAfirobWTPA5bAy/1txBx
         5ckyre901H7HDTxmU12qrWCUPZGkIYslq1GNpu+2rbiBVWWq6XBofYVojgAiNL4bOgYV
         CiTPNTcuT9jwqyC6XTyImzCqBfzCopGUceYMJoBWyjkQMPIKFpTcBGb2OHCdUL5JYXlC
         RkR6Q66np3m74M2LOtmdNLPrFp84QNzljfdUexdDigWn0WsdO+w5vyvrwgwunlgnNtBK
         LzxA==
X-Gm-Message-State: AOAM5335k/FYMQ7mQh7r3ZNyxGBXFYcS+gVj4eUNyRmtqS/IWv6qqGft
        QL/nUssaGUrwWJ8wHaHr4rjrD3sFs8oRItzRUbzDlw==
X-Google-Smtp-Source: ABdhPJwUnhWji9+O9FsKo96nRE2LnEz6aMDJgYGbDEg7BsXVRFWBFXMET8NIbAlW54wWzH2BYtM26yo4Bx/x2QiRfLI=
X-Received: by 2002:aca:b50b:: with SMTP id e11mr5131759oif.10.1597176182150;
 Tue, 11 Aug 2020 13:03:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200811025044.70626-1-john.stultz@linaro.org> <CAGETcx8qjnVNNB_z-Ar8gxKAy7Sc8kcj8oAWQ76mXcBpaqnagg@mail.gmail.com>
In-Reply-To: <CAGETcx8qjnVNNB_z-Ar8gxKAy7Sc8kcj8oAWQ76mXcBpaqnagg@mail.gmail.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Tue, 11 Aug 2020 13:02:50 -0700
Message-ID: <CALAqxLUhX0JLLvn=4fNXk0z6dm=teqCaBmz2VDPEKGfZ+EDFZw@mail.gmail.com>
Subject: Re: [RFC][PATCH] tty: serial: qcom_geni_serial: Drop __init from qcom_geni_console_setup
To:     Saravana Kannan <saravanak@google.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Todd Kjos <tkjos@google.com>,
        Amit Pundir <amit.pundir@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Aug 11, 2020 at 10:00 AM Saravana Kannan <saravanak@google.com> wrote:
>
> On Mon, Aug 10, 2020 at 7:50 PM John Stultz <john.stultz@linaro.org> wrote:
> >
> > When booting with heavily modularized config, the serial console
> > may not be able to load until after init when modules that
> > satisfy needed dependencies have time to load.
> >
> > Unfortunately, as qcom_geni_console_setup is marked as __init,
> > the function may have been freed before we get to run it,
> > causing boot time crashes such as:
>
> Btw, I thought non-__init functions calling __init functions would be
> caught by the build system. Is that not correct? If it's correct, do
> we know how this gets past that check?

I think it's because it's indirectly called through a function pointer.

thanks
-john
