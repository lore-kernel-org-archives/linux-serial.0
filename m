Return-Path: <SRS0=9Cit=CG=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E7C0C433E2
	for <linux-serial@archiver.kernel.org>; Fri, 28 Aug 2020 12:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E2D52078A
	for <linux-serial@archiver.kernel.org>; Fri, 28 Aug 2020 12:42:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ThW49ctl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729348AbgH1Mmj (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 28 Aug 2020 08:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729317AbgH1Mlh (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 28 Aug 2020 08:41:37 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B21C061232;
        Fri, 28 Aug 2020 05:41:37 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id m23so1042036iol.8;
        Fri, 28 Aug 2020 05:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/PjC7+cnl5CWnyCWiaQzqw74CMAkPasrXZ6S6jQlDPs=;
        b=ThW49ctlu0d2JrV6uT92UoDyZs4JLao0pgs68KzMIUCj24D2QSJ8r4PE+WBYx5ezcL
         ekZCydxJd/4bdBNTURbBUN1RlKYqmlDxCcelenBXOZYJGtyFfv+x82NB4M6xCL6rRF77
         qJaNwBZbgnfLFA2xQnPQZ553Cz7LT0UjZWm84dF30dG85c6kmlCl76I/QR/IZqmJNVmT
         1VIWad3vXrfWmzFtJ+Wul4aZBOqYrTm9gaj8AqFQDmG2uYMASInu8LDMG+rFWZQ0IpVj
         EdOE1kDrJ4whYSqzmbOCnBUWfZ8yQj5FXtrlWCB54xy5jMkOFT7zv4nAluK34Q2sBlN7
         lJ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/PjC7+cnl5CWnyCWiaQzqw74CMAkPasrXZ6S6jQlDPs=;
        b=nUhfjfATUl0lZtkqJtsK3BLFQ0rZSAI3O9zD1CeaNcoaPWUel/N10YbDVKLO1JLF6U
         QDNhcdJFQWprT9GCZP7nhfH/V2R2nblMfBAdhW9HSxXJQ+FGyCDjjGukjZ7rmmtSgJj6
         j+MgzODHx/GBCM+ikbHvEGbGBzsb3TMioScAi8sx/b0vewW806/KTg6CIMeKbZPksbPH
         FVteW/s1SgluMNnK8UqPh3a/Ec1kTszcwOQqif4N43S7ldZsuBeVrMzSRtD6GDdTYdJS
         uyJs7fepAhQBwEKZZy3oHTKmDc/c+TYLLWu/TmeUamLRI7g4oom7jbfq7CCwQnHN5hVE
         +anw==
X-Gm-Message-State: AOAM5328sAcHwvAbAwe7jW4qhNyBzdgeuMDx4nxrRLIhMaX4MFhzsZ24
        ayJwOwrMNZvLhGHsKwNTumSf6Dvf0S8qU2qaeSk=
X-Google-Smtp-Source: ABdhPJxZ84KnMEe2egigaI7iy7iamRHxIBQMcvh9SAIuKVSS4I1KLLHQIaSZZQwXoqZqKD896pVL7NRwItklDk4Vzcg=
X-Received: by 2002:a02:e4a:: with SMTP id 71mr938436jae.133.1598618496331;
 Fri, 28 Aug 2020 05:41:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200818162556.6621-1-ztong0001@gmail.com> <20200818185458.84418-1-ztong0001@gmail.com>
 <20200828082015.GA1052883@kroah.com>
In-Reply-To: <20200828082015.GA1052883@kroah.com>
From:   Tong Zhang <ztong0001@gmail.com>
Date:   Fri, 28 Aug 2020 08:41:25 -0400
Message-ID: <CAA5qM4BFYuwE+-Ooqn=wJ29nvcMX6oTCakJVcgybeO5J9qFoYA@mail.gmail.com>
Subject: Re: [PATCH v4] tty: serial: earlycon dependency
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, robh@kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Aug 28, 2020 at 4:20 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> > Fixes: 9aac5887595b ("tty/serial: add generic serial earlycon")
>
> This should be up above your signed-off-by line.
>
> Can you fix that up and resend?
>
> thanks,
>
> greg k-h

Thanks Greg! I did another revision.
