Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1962C433B4
	for <linux-serial@archiver.kernel.org>; Wed, 21 Apr 2021 19:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B476660698
	for <linux-serial@archiver.kernel.org>; Wed, 21 Apr 2021 19:58:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245563AbhDUT6s (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 21 Apr 2021 15:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244346AbhDUT6r (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 21 Apr 2021 15:58:47 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 714B6C06174A;
        Wed, 21 Apr 2021 12:58:14 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id t22so21946530ply.1;
        Wed, 21 Apr 2021 12:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g7Dt7W5Mxl9G7oi5L3qGNDNnt9Em30kp1T3Hp3xUxkM=;
        b=dpUf+CVvCMi1AYWmBC2rHhk8OyFaRbJpPRMjWanrxu+IWv5gcX9uVNB+ei5xQZx4ti
         ancgdM09RFr4tkts12pWpdZiZ+zospi6xdQnZbJjvu3PJrV2+Ib5yjQ2Kb02C4sOIf1y
         w6X6WWjYX4yJkLyokm1N199eaKhp5iJ7ZMHD5NdmeznHfohWZpL86U8WRsDySI8gJboh
         seJGyMaIjtoeEsDaJV6OUancH3hNAYnAWcx9L4dR8KSlQJROorPTdEVP4377Mm6lg0w/
         SwwraX3012WRjK8ZjJdiAXehmtZMqy57rF9K7yESgxbb8fJypP48GxZCn8llZovWUqhw
         GliQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g7Dt7W5Mxl9G7oi5L3qGNDNnt9Em30kp1T3Hp3xUxkM=;
        b=I9c9zkU7m4ldI7B87uY1GVgx6sPjiVMGjSXmhbQ2DOcU8ATakyEM2FWZDGB+u3cr7N
         Qmr3zdLwF2ya4rZeFsTrM3N+qmlKIy94AR1+s4CdjPvU4jPU+XyVUPA1qsDosD4UUd2h
         FZlL4HnQES72+5Iwf9M8dnk9Ww/jD5ivKFSQTa6YXHMoW4JA3sguYVyfRKHswKuVgJi/
         ciEsrXGzkMaE2WDPM/YqEVxNcV+cZqYFtdioe3GIkzUwoqdB/suKVdqb8gaWJhfIAXuQ
         vYGoPg9+PQR/nwowc+8SiZESzFe8xvHzIXeLpqav2MBVNiOnP6CzSnFuZEsNUlAvk4m8
         PF8w==
X-Gm-Message-State: AOAM532Muvp8Tm9/NcteWXN6Am3q/M1ohL+SfcGj1YIJ9Qr708HA9qro
        IW2c4X5g+flqh5lisf2J0Z6jLodrdObw5cmCSx0=
X-Google-Smtp-Source: ABdhPJwGyUat37EhTNdKQbeFJkPX00Ux+oJgBQKHwncw5b3/YWpBN0W94IIFtNCFVbWO8vjqh7dK8FK3pPar345adTM=
X-Received: by 2002:a17:902:264:b029:eb:3d3a:a09c with SMTP id
 91-20020a1709020264b02900eb3d3aa09cmr35565531plc.0.1619035093996; Wed, 21 Apr
 2021 12:58:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210414134539.42332-1-alcooperx@gmail.com> <CAHp75VfQetCJJZ_U70xEduVBQHEx_GkHeKBs2uzNtvcq9H0BqQ@mail.gmail.com>
 <CAOGqxeUiFE0348Y=yEoD7bnMaGnFkbvNy3WZ2oSZZzR4D-xz_w@mail.gmail.com>
In-Reply-To: <CAOGqxeUiFE0348Y=yEoD7bnMaGnFkbvNy3WZ2oSZZzR4D-xz_w@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 21 Apr 2021 22:57:57 +0300
Message-ID: <CAHp75VfD7i9irKDxk0v+j1c1wFrcu9v+OA-X7+edsg6johhJnQ@mail.gmail.com>
Subject: Re: [-next] serial: 8250: Match legacy NS16550A UARTs
To:     Alan Cooper <alcooperx@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Apr 21, 2021 at 10:04 PM Alan Cooper <alcooperx@gmail.com> wrote:
> On Thu, Apr 15, 2021 at 6:44 AM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Wed, Apr 14, 2021 at 7:13 PM Al Cooper <alcooperx@gmail.com> wrote:

> The problem is that when both the 8250_of and 8250_bcm7271 drivers
> were running, occasionally the 8250_of driver would be bound to the
> enhanced UART instead of the 8250_bcm7271 driver. This was happening
> because we use SCMI based clocks which come up late in initialization
> and cause probe DEFER's when the two drivers get their clocks.
> Occasionally the SCMI clock would become ready between the
> 8250_bcm7271 probe and the 8250_of probe and the 8250_of driver would
> be bound. To fix this we decided to config only our 8250_bcm7271
> driver and added "ns16665a0" to the compatible string so the driver
> would work on our older system.

Interesting reading.

As far as I understand the 8250 approach (*), you blacklist (or
whatever naming you prefer, b/c 8250_of seems does not have such) the
binding based on the presence of the specific compatible string.

I.o.w. in 8250_of you need to check if you are trying to probe the
device which has both compatible strings. In that case you simply
return -ENODEV.

*) 8250_pci does like this.

-- 
With Best Regards,
Andy Shevchenko
