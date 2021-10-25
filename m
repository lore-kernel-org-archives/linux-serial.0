Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6DB2C433FE
	for <linux-serial@archiver.kernel.org>; Mon, 25 Oct 2021 12:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9C3360F02
	for <linux-serial@archiver.kernel.org>; Mon, 25 Oct 2021 12:45:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233115AbhJYMrX (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 25 Oct 2021 08:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233066AbhJYMrX (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 25 Oct 2021 08:47:23 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9EF9C061745;
        Mon, 25 Oct 2021 05:45:00 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id g8so11077570edb.2;
        Mon, 25 Oct 2021 05:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kDmEW0Tv1vVvneTsDNEtubja07RCwecOGKS8TXQGysg=;
        b=kYPKOX6Xbh7fyWkHOqMmudlQsRLyg7P3ezHuMqSt5prqWB/GnK38dA18GPVj26sg5z
         8+4376Lhd86TxYHY0kNwybHh9vd6U0yF4vq/4G3NV1KvcSR7HNJHr+uM1x6Pagu8Ij7G
         4GiObxa4qc8F2cyMYJV8jH2Nr//9wChJZX+CQYF4sdjI6sAljIUsitNVPkuCNWXMqSh4
         6hwBqDc9z/CsulTbUoARdpUv5rTFUofC96lTkixonjR7uBiLMK1m/H7AdqKchj0TnSfz
         vipeALnmNEbtrl0QXhpt8GI++GB+OQEdAOybrmQOS7RKfAECgoPXW6gns+qXq2UQPdYc
         ALwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kDmEW0Tv1vVvneTsDNEtubja07RCwecOGKS8TXQGysg=;
        b=thqlDp4JyzphPqNu+2xSfP6OgSGoTwFfx+sCeUrTZAFzm6fznwXzFSssxFCYaa0pr/
         fT+0uJcUn2csvu4ldpiklPxF0cVsHEyFDMzcWOO2A0cR37MYEolMMEb1XwemtwpJOcay
         LNbLh0yiRlpfV60BWCV425qFgCROpCVDz00R/KA6y4S4Cem/uvrAyY2VSvl2V7+q2iOi
         07lT8UidiV9lAMmO5k0BQieQ9gdZ0LSRWvbbXCow/JtKwBfikiNBkFMgr3ev/t+Kawf/
         Ke4PaIURXX+i50BAd03hNqSOerIVexQ/ojJ0jrEF1LAc+rw40LlfZM7Sgn6k3NKmCe8Y
         gAEA==
X-Gm-Message-State: AOAM532Lu+PZGcygc070y8RVxvayJOsyRTGgV+HXXbZrWYMLzIQiBQON
        ZdV4848jD3Md0UbyIcALf7y1jUzUAKRFyiYxUWg=
X-Google-Smtp-Source: ABdhPJzl0uhqvAmfS9/rqmTknUZTTl2hOyHA5QxDh/hvohb6wGp5oULyMhs5qR5igwp6aLEyOTL2kVJLjC0uMVwUiX0=
X-Received: by 2002:a17:906:d553:: with SMTP id cr19mr14709544ejc.128.1635165873760;
 Mon, 25 Oct 2021 05:44:33 -0700 (PDT)
MIME-Version: 1.0
References: <20211025124142.18041-1-andriy.shevchenko@linux.intel.com> <20211025124142.18041-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20211025124142.18041-2-andriy.shevchenko@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 25 Oct 2021 15:43:39 +0300
Message-ID: <CAHp75VfcwGdRRJha132uKCP6_xtPRqmQ1ii3zXBwtPUvT=7+Lg@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] serial: 8250_port: properly handle runtime PM in IRQ
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Oct 25, 2021 at 3:42 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> We can't and basically don't need to call runtime PM in IRQ handler. If IRQ is
> ours, device must be powered on. Otherwise check if the device is powered off
> and return immediately.

Please, ignore.

-- 
With Best Regards,
Andy Shevchenko
