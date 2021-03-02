Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4378AC4646B
	for <linux-serial@archiver.kernel.org>; Wed,  3 Mar 2021 02:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 273426023B
	for <linux-serial@archiver.kernel.org>; Wed,  3 Mar 2021 02:20:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348574AbhCCCRW (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 2 Mar 2021 21:17:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344172AbhCBGul (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 2 Mar 2021 01:50:41 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC98C06178A;
        Mon,  1 Mar 2021 22:49:40 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id dx17so5552415ejb.2;
        Mon, 01 Mar 2021 22:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jzxlQzv76Y/61eQ11eH1sQgFZWAUyijap1VZ663IHg0=;
        b=YnKI9LxURIeByYgZ0rjrwV721raQBTcA6esYWukVX6m4O9X6Czv25W8BdKF4nyy/rR
         1W5XUEid2pQbdb74IEAZxv9StTCqClDcmekin1F6IUcZRnLjcwUdPSzubKsXYVElDkLO
         WzYXTLNMFRhqnJc8GO/uJHp7ociRcMBR9bdlxZNWbKW+HoBH8mQkN8DW+O7H0kZsaeCN
         OIfERAvN/xfx/R1bT5LIpye6L/nOjqBk1NvM5YOWCwgiaH9lnga09dXKnITjxzwIog52
         413pzT8nND5Oz9CELnaNWQ8yc66dkBbeNdt2x/R+fa+9MP5eVdjMxRKkqiopfqRiEsYW
         Z0sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jzxlQzv76Y/61eQ11eH1sQgFZWAUyijap1VZ663IHg0=;
        b=l+dlGv7rVXtcoZ9sxUVAtui1GbhaEh9y9PJWKT57boZ2ShjVCkVn49zpA9uSLoghGm
         nbmuVaUUdjROe31FLkFelItGweSWOa3okJMdrhHCi/8lE/k6pdj/xZT/DpS3fLkQDriz
         J5QDUtyJJa5kzh5zEvdwE7s57Yta0vzR0bb33jfbhL8CnZRFWeo/J9kkOC9n9Kay3gDI
         DLcAg3MJYTAWKjmj/hQ6O0iDBe7mrhErM9NtwtrjPeWk/QcXH86dfAy72tA9BWwU63Cy
         U6mQO6C2BEXv+QWE6JSfLAYngiVg+SHkMzU6fC2PSR0Imk73YQcMXwVE/dhY9NrPb7Fy
         obaA==
X-Gm-Message-State: AOAM532hjQbNEJTAU/FL1nms3lRLq4P1ylfkXbNzkY4mG7EgQ65jMqNP
        vmVloZVmZYFDGpeb1GbSMsPV/jfU9GE4/k2diZ8=
X-Google-Smtp-Source: ABdhPJwljo+mnsADAPU1Bllfx6aUc5JBmvI3C9sySY2uIgDMMeT8KjuoWwE4NbMv9wDxKqDG84z6knAVtN2ZhlhV2vE=
X-Received: by 2002:a17:906:7797:: with SMTP id s23mr8953605ejm.98.1614667779511;
 Mon, 01 Mar 2021 22:49:39 -0800 (PST)
MIME-Version: 1.0
References: <20210302062214.29627-1-jslaby@suse.cz> <20210302062214.29627-31-jslaby@suse.cz>
In-Reply-To: <20210302062214.29627-31-jslaby@suse.cz>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Mon, 1 Mar 2021 22:49:28 -0800
Message-ID: <CAMo8BfK_Y4ifJ2caNYO5bu+BnxyfoUey3hkDGK7=u7GbnUFRRw@mail.gmail.com>
Subject: Re: [PATCH 31/44] tty: xtensa/iss, remove stale comments
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Chris Zankel <chris@zankel.net>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Mar 1, 2021 at 10:22 PM Jiri Slaby <jslaby@suse.cz> wrote:
>
> These are likely taken over from amiserial. iss doesn't do anything of
> that.
>
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: Chris Zankel <chris@zankel.net>
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> Cc: linux-xtensa@linux-xtensa.org
> ---
>  arch/xtensa/platforms/iss/console.c | 18 ------------------
>  1 file changed, 18 deletions(-)

Acked-by: Max Filippov <jcmvbkbc@gmail.com>

-- 
Thanks.
-- Max
