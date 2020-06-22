Return-Path: <SRS0=XDGD=AD=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05A57C433E0
	for <linux-serial@archiver.kernel.org>; Mon, 22 Jun 2020 14:36:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C935420732
	for <linux-serial@archiver.kernel.org>; Mon, 22 Jun 2020 14:36:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FDD5TX5K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728404AbgFVOgk (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 22 Jun 2020 10:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728341AbgFVOgj (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 22 Jun 2020 10:36:39 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB0AC061573;
        Mon, 22 Jun 2020 07:36:36 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id h95so8712852pje.4;
        Mon, 22 Jun 2020 07:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dKQAr0AzqF//CMcdvyZux8j8igYj0jeJ37SF6QSpEzM=;
        b=FDD5TX5K6HKPItrzjIIBKSe6VqdurJXbR1eGATMXyVJMQm6p0BvOAz4y7vL2oxRh2T
         FM3tNFk5hiTaWtNe8oBQWqiAKAN59s/PI8ncuz+iUTxgQUmUtn0MpFXKTG3y1ePyroyz
         vGfszLLnANuox8b8wR1Uxl9AkGwZVTox+McODYnNa/0mvMEKGhDF6TjHpudZiV8W7GmX
         Xi/fuP6GnDpkWNPDLxs72gsyzPwpAuGFWSa26lIoIjpr7I8+QaX4SibJGVYnyCvvyTCY
         hivAM0wFs0Y89dIJu8P0ur0PbH8csuGRqOy0pDTts0ibT0mUfwubUkExGQs7jVf9TBAm
         4WRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dKQAr0AzqF//CMcdvyZux8j8igYj0jeJ37SF6QSpEzM=;
        b=N5xc5fCfZ+ueFvhE7piCbFVxHzF9gCUc9GCdaTA5hGsFxD4t6zd7pYmtVoRrLpE6Uh
         96UCsMfDiNuZ/D/5TpZ2/oGKj4fLe/nVovBadv2CDlEx+uSiQxJypNmfruwxw0iXRNX5
         nS/qJzCm/ITG1RtLYbE3IHup6goc0N9BXPa302T2yS8T911vANYHn6+LkgyF8zC9wbht
         a706vTl1F4dqsfaXnH/VjrQpiVraGmdRAqeh5WZrQFiHXFeE5bt+YjzmWNG99kkFn8tI
         mmAg+kgOvU6rT1OujcA0BMOi6fXjqjZ6TMSLCDawklToyjDp7Oz2bu5bCJEzkXaVnbim
         1i/A==
X-Gm-Message-State: AOAM530j0D5zt9PSUZhPtFsgR+u6ilgxl7P6KC2EdH3N/CXhLs4DLN7m
        Kx6N3x3HmVtrs9V5gQlh05iqNu2CwfgmWY0LdHNmMHBZ
X-Google-Smtp-Source: ABdhPJwONkkBXuckxOwuh/Kd2q9DlPnyBqZSMqfHNXBbQ9l3Czd0OWGQLpfhQ0kbCKEyeea9H399eVScKOGmHiIjaKw=
X-Received: by 2002:a17:90a:220f:: with SMTP id c15mr19521759pje.129.1592836595666;
 Mon, 22 Jun 2020 07:36:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200618164751.56828-1-andriy.shevchenko@linux.intel.com>
 <20200618164751.56828-2-andriy.shevchenko@linux.intel.com> <15960896-3874-599c-6304-18b01ffd5c94@suse.com>
In-Reply-To: <15960896-3874-599c-6304-18b01ffd5c94@suse.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 22 Jun 2020 17:36:23 +0300
Message-ID: <CAHp75VcBV0djS=z+_FTDjkyxFmQ+wnj1rmLT1VDCSX3d2AvZ3w@mail.gmail.com>
Subject: Re: [PATCH v1 1/6] mips: Return proper error code from console
 ->setup() hook
To:     Jiri Slaby <jslaby@suse.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Jun 22, 2020 at 5:30 PM Jiri Slaby <jslaby@suse.com> wrote:
>
> On 18. 06. 20, 18:47, Andy Shevchenko wrote:
> > For unifying console ->setup() handling, which is pure documented,
>
> Did you mean s/pure/poorly/ in all the patches? Or purely? But then where?

Poorly.

-- 
With Best Regards,
Andy Shevchenko
