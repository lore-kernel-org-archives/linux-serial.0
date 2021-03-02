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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 113EEC46461
	for <linux-serial@archiver.kernel.org>; Wed,  3 Mar 2021 02:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECBB86023B
	for <linux-serial@archiver.kernel.org>; Wed,  3 Mar 2021 02:20:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348565AbhCCCRV (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 2 Mar 2021 21:17:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347849AbhCBGqH (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 2 Mar 2021 01:46:07 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1AEFC06178A;
        Mon,  1 Mar 2021 22:45:26 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id mj10so13007651ejb.5;
        Mon, 01 Mar 2021 22:45:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wJXh5JalEhVse0qJW0VOHI5f4foaNIcMUtcvKKJasfQ=;
        b=dhSf9U6HzpbfvVbH5USxTu/mgglrcDn5nL7ApwwV7YvP12gdja2yCAj05Nii6uqe6c
         0gY3636OGXi+qz8e+PjivQGvRJeYHQKCp+2JNMbAFLez0RZ/9Tie9pFa2uUbr8GFK3RN
         te7kQ5C/TB66UOv2GtIcyTF3RDdXOkeqlSuiu0J5jf5mhNd9STs5VOdZ0E01dAURwBme
         ZLLPbhqfLMkYLuNtE2kV9POrs5lmw0GL//yE3MqOpUBcxwQrHXPwuYUOBzjLBmgA8BRU
         Hff+8oUxBOKJyuIvV//9YR2Qa9hHE4Vu0y6VdCzB7ArLHVTHli2FwRwJgWY6f+O+m0OA
         iCgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wJXh5JalEhVse0qJW0VOHI5f4foaNIcMUtcvKKJasfQ=;
        b=kADGTEr2mJ9lKB1nXxeNIH935V9fHLbZVt+C7eYmDGgdhv1arotPaz8cJb9LXXoC0N
         iTV9FRfi/Sj5yCMm6sL0crJf63RHgp3aQxhG2RmR12a9mBVtsj/vjbaJnaM9c+Cll2bx
         TSuwcNhTKhQjGwS+BJOkHqwPhbkidU8LLHfwKCgPw88BRLHOiPbiDgY9dTqev1hhAAqs
         cGP3ZYvbMymor93TuuKXGH/HyGrXwEEgycFKtlgGGq8Sa6rRu+LpAxmPgxifLiSxymtY
         G6cNbU3Fi89TBbh9qaX8T8keY0MwyI4T+CrGj+MSY5i8VSMA5ZpaNKxkbFJu+BQXa672
         nrNQ==
X-Gm-Message-State: AOAM530mChIklV70lgCanU+YsZ1LjPT21GYEabBe6dQ7+LayyLOocl/B
        xaKJc20dRO4ifIVJhbY0cXdnJRfCfHzhZtm3serHaKnf
X-Google-Smtp-Source: ABdhPJyfeSEkJtAZCSPW0OjbWtOEt4hvwGLIUzr5p2cE3aqNEJBS+u2nw7lEEz+QG+Ui2h5wnVka/aNpze7fc4oqspI=
X-Received: by 2002:a17:906:3587:: with SMTP id o7mr19621807ejb.443.1614667525431;
 Mon, 01 Mar 2021 22:45:25 -0800 (PST)
MIME-Version: 1.0
References: <20210302062214.29627-1-jslaby@suse.cz> <20210302062214.29627-29-jslaby@suse.cz>
In-Reply-To: <20210302062214.29627-29-jslaby@suse.cz>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Mon, 1 Mar 2021 22:45:14 -0800
Message-ID: <CAMo8BfJoVnSkw_9J9w-is+_0aWbcmE+B_FMUha6Rv=n5+my_zw@mail.gmail.com>
Subject: Re: [PATCH 29/44] tty: xtensa/iss, drop serial_version & serial_name
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
> There is no need to print the information during module load. Neither to
> print some artificial version. So drop these strings and a print.
>
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: Chris Zankel <chris@zankel.net>
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> Cc: linux-xtensa@linux-xtensa.org
> ---
>  arch/xtensa/platforms/iss/console.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)

Acked-by: Max Filippov <jcmvbkbc@gmail.com>

-- 
Thanks.
-- Max
