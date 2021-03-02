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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E7CC28E85
	for <linux-serial@archiver.kernel.org>; Wed,  3 Mar 2021 02:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F59B64E75
	for <linux-serial@archiver.kernel.org>; Wed,  3 Mar 2021 02:20:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348581AbhCCCRY (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 2 Mar 2021 21:17:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345011AbhCBGxP (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 2 Mar 2021 01:53:15 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E2ADC061756;
        Mon,  1 Mar 2021 22:52:17 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id v13so7386242edw.9;
        Mon, 01 Mar 2021 22:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rHHguOtq/SsmoWVv767qiYZjS1EduX+s7NH06dTB/5E=;
        b=RJv/UOK1Rl1s7110nIhpxe4b/ond/IgKPJUtMc5UpBqSdc/g7Yswb1SzFmZs4SD7tI
         igbMnrQiho1HeVqBBnZDspMXblybvDrUY0kgRGYI0BFcKamvexM8kT6hsvPxfolS1GCS
         coW5agR7+ctcm6vKT/3bVHNM0FhJN4zIgAKuzuhQLJ33mqLcUX+B8wza/jRBoUxX5Wfh
         pIoxdl8EnKCLs6mRm+Qft5XvnA6SClzlvqfAAEb5w9NmFyPTiJiwH8KgN2HnBBuuCq/y
         3YFdHzIsYT0FdYPOjPaHw4toWUXjBBVfLTzMCgCTF2m4QInHCv+j88I2zuFNKCQFwPe7
         6sag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rHHguOtq/SsmoWVv767qiYZjS1EduX+s7NH06dTB/5E=;
        b=WQs5INtpaglwazoI4ir9/rchXIcLdR+ldFDIQOV1NbEqWgw0W9rOD/zuS/3V/uUi2U
         82FK0xTJf6DEZ6vso8jzsWoFM5d4A7oKWopolBTyW+pW0z7PEITvoR0ujtAfNZ6+tiiN
         9gSOjOfsggH7X26DDpBBBtv6FQR4i7V38VZIPISwf9k+p947SEfjrbc4TujeKkCtfF2X
         4BLvU/4gWKChmrmGC2PqWQOUCLeNfI7q12bx8jZJU7s5CO+s+VmcirWhsXw5USXFHucM
         SIsxWcz3YlHT/xwCU2FiJGYGalKwCYykQePArAD9HmkQ02q52vWd7XS/QuX5DWG4VzTJ
         OnrA==
X-Gm-Message-State: AOAM5333ibFbLTpST8cYlBXXCA4K874du0HyoQC+6awMTEm04OEIzGK7
        frIMef+pCAcmGOQ802dacCn8SjliVW9kYulP+e8=
X-Google-Smtp-Source: ABdhPJzobTXq9iCvVESEdOAEuL6o/ZubpkKJZsWksmzJX34L0rWX2fSOlYOmfHgZ2Aqv1W8s49fkXRvKk98Gtiba5NU=
X-Received: by 2002:aa7:dd55:: with SMTP id o21mr32367edw.237.1614667934608;
 Mon, 01 Mar 2021 22:52:14 -0800 (PST)
MIME-Version: 1.0
References: <20210302062214.29627-1-jslaby@suse.cz> <20210302062214.29627-32-jslaby@suse.cz>
In-Reply-To: <20210302062214.29627-32-jslaby@suse.cz>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Mon, 1 Mar 2021 22:52:03 -0800
Message-ID: <CAMo8BfJeXxTatB74+4PLed9KZaoRgDgekHdvpWKsfFW-povZWw@mail.gmail.com>
Subject: Re: [PATCH 32/44] tty: xtensa/iss, setup the timer statically
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
> Use DEFINE_TIMER and avoid runtime initialization of the serial_timer.
>
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: Chris Zankel <chris@zankel.net>
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> Cc: linux-xtensa@linux-xtensa.org
> ---
>  arch/xtensa/platforms/iss/console.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)

Acked-by: Max Filippov <jcmvbkbc@gmail.com>

-- 
Thanks.
-- Max
