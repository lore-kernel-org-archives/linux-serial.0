Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94519C636CC
	for <linux-serial@archiver.kernel.org>; Sun,  5 Feb 2023 20:17:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbjBEUR1 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 5 Feb 2023 15:17:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBEUR1 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 5 Feb 2023 15:17:27 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 299F27D93
        for <linux-serial@vger.kernel.org>; Sun,  5 Feb 2023 12:17:25 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id dr8so28786720ejc.12
        for <linux-serial@vger.kernel.org>; Sun, 05 Feb 2023 12:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vuDqBGiso2ipHrhZ3TVaxXym8pN3xmoOWp0BE38pfVA=;
        b=W42BN5rreyugL2nruL5TpgbVeOyHyYADshRnETRXpZ5gWTEDwZoz/ZJhrzw9p/mSU5
         4GYap/Db9VgulivKnMUfaXM0q9OU1KpEiXQ5xlkckCsLSbJ4VbVzbPhSAelVtxyMtQhz
         VeQ+DzCoz5BKRUNlvjpF4X2Wterev09VDMhRo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vuDqBGiso2ipHrhZ3TVaxXym8pN3xmoOWp0BE38pfVA=;
        b=CQ+1B3bkDuOcnVQbMHgCwkE/28NnqN4y5Tb5bYZQY4Vks3qdnmCyKn3SGMu7wH0xv9
         Ls+U28t2EeMxKeqJyGur4nK8uF8mtSfqiOVFNs+gcoIbIKOOXhVeNIsdYM0EjYDJTMYK
         GQ8wF7qzo/TKmv0HwZzkI9BjKaAE4jJUYay3oS5eu71EOQeDzJyI9+YWRkO59Lq/sL5O
         s0dlKLgTJxIoPlo33+dM32oIcE1zavNixBEDZwSDYBEKgEm/eElBsBnQ0EOS9ho6rROZ
         Ijv7D8K86XTdga4Q/fh81n8TbABgD/cwb1E0YIwPFPLICJmgm91Y5bVyJLaxyHKMSb5F
         qO9w==
X-Gm-Message-State: AO0yUKVhd459JkdIitxPsEfCjJDysfUF0jWfMsgL61GXiYksYDSAhcAQ
        m0MNpWk0jDaclOABSxxyHYfwFr36P201g+3ukLg=
X-Google-Smtp-Source: AK7set8EjWUg/kGcaIqNyqeI0RcymPrVPynBAiQpFbE9MouudlF1C3+4SkRK2Wihwj/DDYIXzIcCdQ==
X-Received: by 2002:a17:906:4d50:b0:877:a7ec:5ff with SMTP id b16-20020a1709064d5000b00877a7ec05ffmr17754136ejv.10.1675628243401;
        Sun, 05 Feb 2023 12:17:23 -0800 (PST)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id y14-20020a17090668ce00b00887f6c39ac0sm4538239ejr.98.2023.02.05.12.17.22
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Feb 2023 12:17:22 -0800 (PST)
Received: by mail-ej1-f45.google.com with SMTP id p26so28760738ejx.13
        for <linux-serial@vger.kernel.org>; Sun, 05 Feb 2023 12:17:22 -0800 (PST)
X-Received: by 2002:a17:906:892:b0:87a:7098:ca09 with SMTP id
 n18-20020a170906089200b0087a7098ca09mr4391723eje.78.1675628242466; Sun, 05
 Feb 2023 12:17:22 -0800 (PST)
MIME-Version: 1.0
References: <Y9+Yv1CQKNP0Bwqq@kroah.com>
In-Reply-To: <Y9+Yv1CQKNP0Bwqq@kroah.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 5 Feb 2023 12:17:05 -0800
X-Gmail-Original-Message-ID: <CAHk-=whSQFHVzgQ+s8cbCSyE_yrd+BFuYktHe2=0h-nLXBi__Q@mail.gmail.com>
Message-ID: <CAHk-=whSQFHVzgQ+s8cbCSyE_yrd+BFuYktHe2=0h-nLXBi__Q@mail.gmail.com>
Subject: Re: [GIT PULL] TTY/Serial driver fixes for 6.2-rc7
To:     Greg KH <gregkh@linuxfoundation.org>,
        George Kennedy <george.kennedy@oracle.com>
Cc:     Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sun, Feb 5, 2023 at 3:53 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> George Kennedy (1):
>       vc_screen: move load of struct vc_data pointer in vcs_read() to avoid UAF

Hmm.

I think the "goto unlock_out" should be a "break". A partial read
should return the partial success, not an error.

That situation didn't exist when the check was outside the loop, but does now.

Now, I don't think this matters for any sane situation, but since I
looked at this patch I thought I'd mention it.

                   Linus
