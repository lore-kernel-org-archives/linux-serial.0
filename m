Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF18BC433EF
	for <linux-serial@archiver.kernel.org>; Sun,  7 Nov 2021 03:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACC99613A2
	for <linux-serial@archiver.kernel.org>; Sun,  7 Nov 2021 03:21:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232847AbhKGDYY (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 6 Nov 2021 23:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbhKGDYY (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 6 Nov 2021 23:24:24 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B561C061570;
        Sat,  6 Nov 2021 20:21:42 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id y11so21639778oih.7;
        Sat, 06 Nov 2021 20:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XJUFpExoWemk4FQi9OWmv4L9rgSOIELB05/UcaW0E6w=;
        b=Xlv04d61JczZqYaCpoSsR6OEo5lBdreRY0cpWCv7wCFbZiFguAVQ6YPD+5Z89cAFVM
         +Swpeyt/I/oVvcifDGH12potiupCL3IBslA5S5yfbGVBj+Kz3anjAz5Punxk60G+mnKF
         AtM0kvctrsI4JMTZNu/Iodd/EQ2WeYo79gfyjSjvUwoyl+2coyby8lbw0EbGY6ntLLx3
         zLg+9yu2ghcDrI4TgP6vKvEvqS4gN8OJgai2DeiPPPYGBsNWiIFoiYTUnMTZ4iS13I5j
         axoO2cvwWVry7mlXECTrmlFIyiTt2+DogAHLIG00uukaq4YdhT0Uoo1I+hHY6sccHQFE
         ma3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XJUFpExoWemk4FQi9OWmv4L9rgSOIELB05/UcaW0E6w=;
        b=4J7Q2/DCFNEMa7oiCY68nu+syzkVxdMy3YtP1SwpZRwdKFEDuE87WyXZtFGynKJ8Vb
         q9gsyWxVts44sJ/wuA9K0+M1lXVwy4wtyyqS+0wddWJZNnw9ZTn0AZ/LhxRxYCs+5JOw
         04g3OC4/4HIFt/trsZ8TViCDlYpDtQ8FNvGSZoT/a2oHE82JTrhW+p4nJM5hAPCKeSvJ
         30Ogvaw/V6ih6MJRvpZ+wp6Z8RDO9Kno3htrEzXKUqvgvFG7xDXS2jJmxcsM7C0+OhZT
         jSTbKVt3j/pwyHDBphV+iZTiFZP1y4ms0ea7sJNK7++m2XjIsZEv7t+R+Usl4xZ35sPG
         ZpYA==
X-Gm-Message-State: AOAM5310cciGNMvtONy+wTu3mS1W2YSTQlFIHlrZhUtkrUKUdYPwVnzW
        3oMBMqc7WJRXlpXWVgJ+Lgk5mNoQ78ulhBNRICQ=
X-Google-Smtp-Source: ABdhPJzZan1GBV86zvVjmrxC/YLRToOnTONoGVor8xMFVTJQAJ1EGzjuG8FCvKgw3YLE7kloiRkrYns976fKfU+PgvU=
X-Received: by 2002:a05:6808:2108:: with SMTP id r8mr15972082oiw.118.1636255301810;
 Sat, 06 Nov 2021 20:21:41 -0700 (PDT)
MIME-Version: 1.0
References: <20211106220315.392842-1-ajaygargnsit@gmail.com>
 <8d0346ba-4819-c25e-f208-0b51116d9147@gmail.com> <CAHP4M8VmPTiWjVa_PEMs+XT0VzsoAw8BuO-KBo08Uwuf=T1WFw@mail.gmail.com>
 <b7520698-44ef-55db-2b0f-ed47cd7d8b71@gmail.com>
In-Reply-To: <b7520698-44ef-55db-2b0f-ed47cd7d8b71@gmail.com>
From:   Ajay Garg <ajaygargnsit@gmail.com>
Date:   Sun, 7 Nov 2021 08:51:29 +0530
Message-ID: <CAHP4M8UXCb_6tAqDAZuKSUO=Y=U4wAk1C8v-MJbDCPOAV9+tFg@mail.gmail.com>
Subject: Re: [PATCH v3] tty: vt: keyboard: add default switch-case, to handle
 smatch-warnings in method vt_do_kdgkb_ioctl
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        andriy.shevchenko@linux.intel.com, kernel@esmil.dk,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

> >
>
> I am not against these braces, but I, honestly, dislike them, because
> `case : {` syntax looks ugly _to me_.
>
> KDGKBSENT uses it because of local variable `len` and not using them
> will cause build error.

Ahh, that explains the difference.

Floated the v4 patch at :
https://lore.kernel.org/linux-serial/20211107031721.4734-1-ajaygargnsit@gmail.com/T/#u

so that consistency is maintained in the styling.

Let's continue on the v4-patch link now.

Thanks again Pavel.


>
> I didn't find any strict requirements to not use brackets when there is
> no local variable, so it's up to maintainers (again).
>
>
> Anyway, thank for respinning :)
>
>
>
> With regards,
> Pavel Skripkin
