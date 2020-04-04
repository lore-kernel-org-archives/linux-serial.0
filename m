Return-Path: <SRS0=xrpD=5U=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F3D6C4332B
	for <linux-serial@archiver.kernel.org>; Sat,  4 Apr 2020 17:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 693D32071C
	for <linux-serial@archiver.kernel.org>; Sat,  4 Apr 2020 17:51:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bOWN+MEe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbgDDRvH (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 4 Apr 2020 13:51:07 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39615 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbgDDRvH (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 4 Apr 2020 13:51:07 -0400
Received: by mail-ed1-f66.google.com with SMTP id a43so13423154edf.6;
        Sat, 04 Apr 2020 10:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EYHlE7hzY1zLv8qJzBgPTe/TIerRSF04fiRQ/AXOHvk=;
        b=bOWN+MEenAoHrmIoRO75xbw7spR9Ma0bRi9pqeptH70bXQFnvrkLF6PYMDVeIbfCk/
         BwBbMqbU30aWM9snVArnPw+ivNd8QUyWm/G3WcNAA3KnWz0tWCu8+jPAum44QnpMZKqx
         F0gfeKpdJLqSe5v+QYs21jycUe8Pcasx8EiWo36R7udYDuL+c9MRNSk33RulxRf1RqjO
         puqJS6SlGjllg95t0M7g9CYzC6+d6RFfG0NUxetenqSo31WVWaCoFPqU7VgJP+3+GCEk
         04tJWIL9AmBYBeeYyOJ7U0vVP1YAauTYu6fVPx+0Ub/mNAPiyrjk/DqdTk291ByHOE0E
         pgjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EYHlE7hzY1zLv8qJzBgPTe/TIerRSF04fiRQ/AXOHvk=;
        b=DZfbaDbSGIQ63scGFSZ8AabEeFZJIvka/XaU0W7/581Xk/kX0KJUKAOuvaoOBxkeJ0
         Jwg0sm+YMqK12VEHUZVMKN4N+4aU3gymEAhi5tCA34XZCbL8cCB/zK08O5j5R5aT7ZYs
         +Ku/uavmQVZUNGWafw8YnMnkWSanoRc53BchQLex0cUlZzeWcSf/1ymwnvNwuo+Ct9Nd
         OrXzVAFVXTOI9Na34FE9QRkMWSoWSpLIpoh9GfRfAptIa7yTlo9G6Ja6/JDXeLkZq5cu
         hmi2QH5xDYqNuYY10qAE3CGoQJBWh2NvG0b1TgisylTqyP+FEvY6fxgUvx+lUhBR02L1
         U/9w==
X-Gm-Message-State: AGi0Puay08wMNorV6fPsyYo+RPRN8e8aSzP3mRbzBZKzPSS8FvnPaUoZ
        F5E79HwAyGF4EHTpkn30EEAO17Xc7MB505tNC6Y=
X-Google-Smtp-Source: APiQypL2xGjZbHIcOwqwCbdecCSlLtYicurlMAvux3jaJL76RMSNxBNgwbsRzxerqmiGxFu9p2ZRkwfdGBmbAhvV+Rc=
X-Received: by 2002:a17:906:c295:: with SMTP id r21mr14273848ejz.337.1586022665928;
 Sat, 04 Apr 2020 10:51:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200402172026.79478-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20200402172026.79478-1-andriy.shevchenko@linux.intel.com>
From:   Anatoly Pugachev <matorola@gmail.com>
Date:   Sat, 4 Apr 2020 20:50:56 +0300
Message-ID: <CADxRZqzgenruphXAKE8MJM2zayR7u7yvc=-5YwPHkCN4gW2eNQ@mail.gmail.com>
Subject: Re: [PATCH v1] serial: sunhv: Initialize lock for non-registered console
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org,
        Sparc kernel list <sparclinux@vger.kernel.org>,
        David Miller <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Apr 2, 2020 at 8:20 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> The commit a3cb39d258ef
> ("serial: core: Allow detach and attach serial device for console")
> changed a bit logic behind lock initialization since for most of the console
> driver it's supposed to have lock already initialized even if console is not
> enabled. However, it's not the case for Sparc HV console.
>
> Initialize lock explicitly in the ->probe().
>
> Note, there is still an open question should or shouldn't not this driver
> register console properly.
>
> Fixes: a3cb39d258ef ("serial: core: Allow detach and attach serial device for console")
> Reported-by: Anatoly Pugachev <matorola@gmail.com>
> Cc: David Miller <davem@davemloft.net>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/tty/serial/sunhv.c | 3 +++
>  1 file changed, 3 insertions(+)


fixes issue for me, sorry for the late testing
