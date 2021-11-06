Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 353F4C433F5
	for <linux-serial@archiver.kernel.org>; Sat,  6 Nov 2021 12:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A5D96120D
	for <linux-serial@archiver.kernel.org>; Sat,  6 Nov 2021 12:06:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234118AbhKFMIp (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 6 Nov 2021 08:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234105AbhKFMIo (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 6 Nov 2021 08:08:44 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 887C9C061714;
        Sat,  6 Nov 2021 05:06:03 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id v40-20020a056830092800b0055591caa9c6so17267065ott.4;
        Sat, 06 Nov 2021 05:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NQeZyi95jWJGOsuGRgyHzDyg1Fg28fFWiAntEq83cYY=;
        b=SwDBBd8xITup5COq/PlmYeNl9XWxgsLKWKFHJzIVG5DfFKDv5eIgAQ34JMxfi5JZI2
         pcsI/fgxL7hn6MHwCQ9a/NTleRnfxhnM4++jzK9VBwKEFV1bceef8MYVewX1+4cuyFcT
         RBuWGyNarcNYDx0JYTZ7jFPFgnbBYSU7wHcGNS/dAVlojDVkz4tEgLGswSQPiagTFkWp
         fIsy07ds0d+IcQgRybErvnIWJ/1RfjlrUYCkPMC34Kn2Y/f8SW0bVml2okp3DVXIw7aB
         IJDQU1j2KykPrErDUlVoEHXPaZj95F1Z5oE9ppArqDfY3HCTCcxnb93AtTUSYr9emrsH
         KUBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NQeZyi95jWJGOsuGRgyHzDyg1Fg28fFWiAntEq83cYY=;
        b=hvqbVH763kP3dpNhXxRRquZv30P1SXJP+jSuWY3IL3BoH8n4CPcyYLIbQKZhGnaAvz
         bZLFztk9GgJoovla9I4GylelJJQVyKJKUmElR8hIRzR+2AWXS4ByI14YhKPulSruOi0l
         D7PA9S7YiLfbMKBBtbU40ReSCvR6Zq5z+c0ZKnIaEAO0Uz4Dww47grg2QeNJvBf6vYhi
         Ki7vsqWk83ZCuG3gdm+L0XupvE70eFjZ9yKWsjJB0DG3z78Ea7gqPTwaVMuBtcGep/Kn
         Gutb9P1Dudfe5sDWrqxcREz9fNwkt0x+15GL8v4I655vNUPw6r03wHqLmjnfmzgtTPbe
         igUA==
X-Gm-Message-State: AOAM5303x0dy6BGzhk/PvFo2YVh+Ft0qrqbNxhuBus+YKVexfhp219sc
        IdXdg7B6HW5dtrkhHF2iM4/o7VEv1aW/wwPMu/oWUJDJFXM=
X-Google-Smtp-Source: ABdhPJyKBYTyYffavL+IJkMJ+UETnE/yD/v718tH2ZwXb2SIjM2xZ5ysWJN+vdZsUgMyOTBBZUi8bAuG/uPCQyPiw1A=
X-Received: by 2002:a9d:7617:: with SMTP id k23mr34752623otl.351.1636200361419;
 Sat, 06 Nov 2021 05:06:01 -0700 (PDT)
MIME-Version: 1.0
References: <20211106092041.43745-1-ajaygargnsit@gmail.com> <9eafae1f-d9f0-298d-cf20-212865d0becc@gmail.com>
In-Reply-To: <9eafae1f-d9f0-298d-cf20-212865d0becc@gmail.com>
From:   Ajay Garg <ajaygargnsit@gmail.com>
Date:   Sat, 6 Nov 2021 17:35:49 +0530
Message-ID: <CAHP4M8X5ZrrVBS6Y3tg6c8jK4BA0JK+q8reiGwVeoZX9gUvogw@mail.gmail.com>
Subject: Re: [PATCH] tty: vt: keyboard: do not copy an extra-byte in copy_to_user
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Pavel,

Thanks for the review.

> >               len = strlcpy(kbs, func_table[kb_func] ? : "", len);
>
>                 ^^^^^^^^^
>
> len is reinitialized here, i.e len passed to kmalloc and len passed to
> copy_to_user() can be different.

Sorry, I missed this part.


>
> strlcpy() returns strlen() of source string (2nd argument), that's why
> we need +1 here to pass null byte to user.
>
> Am I missing something?
>
>

Seems things are more screwed.
I tried to see the behaviour, via a small program as below :

##########################
#include <stdio.h>
#include <bsd/string.h>

char a[10] = {0};
char b[] = "1234567890123456";

int main()
{
    int len = strlcpy(a, b, sizeof(a));
    printf("len = [%d]\n", len);
    printf("a = [%s]\n", a);

    return 0;
}
##########################


The result is :

##########################
len = [16]
a = [123456789]
##########################


As seen, len is *not equal* to the number of bytes actually copied.
(The bytes actually copied are 9 in number, plus 1 for the terminator,
as expected by strlcpy).

On re-reading the doc for strlcpy, it seems that strlcpy returns the
length of src it "intended* to copy, and not the bytes *actually
copied*. If so, then returned value of len is meaningless.



So, it seems following two changes should be made in the original code :

1.
                len = strlcpy(kbs, func_table[kb_func] ? : "", len);
=>
                strlcpy(kbs, func_table[kb_func] ? : "", len);


2.
ret = copy_to_user(user_kdgkb->kb_string, kbs, len) ?
                        -EFAULT : 0;
=>
ret = copy_to_user(user_kdgkb->kb_string, kbs, strlen(kbs) + 1) ?
                        -EFAULT : 0;


In 1, we change to simply not using the returned value of strlcpy.
In 2, we change to using strlen(kbs) + 1, as the number of bytes to copy.



Kindly know your thoughts.



Thanks and Regards,
Ajay
