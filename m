Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE03BC433F5
	for <linux-serial@archiver.kernel.org>; Mon, 17 Jan 2022 13:26:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232716AbiAQN0u (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 17 Jan 2022 08:26:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45448 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232371AbiAQN0t (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 17 Jan 2022 08:26:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642426009;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pXzs5583XlXxVJoeYm1lsNSqwpnwiNPE8/zYY3vVDHg=;
        b=I/S/ixtp+ZX+Ze/WiSEtQJcqTGtX4+RmkEJE+1tPMQajNwXYJ1H71VxcK7INjcaZDxmAlS
        EKAfRLTJDTUAVt3KHjY2Gf8dYKAEmx24jb1VqMZgfV4Y4DbgLXnNjqAUslPrM0E1JlUXMy
        kcy5WQE/dmCpaMHKlLqx/5Cl/eAwUj0=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-342-bj8O14pJO024CgqlRVArYw-1; Mon, 17 Jan 2022 08:26:39 -0500
X-MC-Unique: bj8O14pJO024CgqlRVArYw-1
Received: by mail-ed1-f70.google.com with SMTP id h1-20020aa7cdc1000000b0040042dd2fe4so12920281edw.17
        for <linux-serial@vger.kernel.org>; Mon, 17 Jan 2022 05:26:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pXzs5583XlXxVJoeYm1lsNSqwpnwiNPE8/zYY3vVDHg=;
        b=D2u76cR2pJdRo2lrQtyv1VEqWtTXwRKxbw0Ythd614xl0lExkQVom4KMzcv3zXoeD6
         3PsP5/yhmwqo1rySmFk+dVEF7XVpIET7SrYfDDfjbLV5yWfFRmbTcM4PqTCYxrOTOt+F
         ipInB+NSl4h4UR6ND6RzwDVo0DqPaWRffQR3grj7vGcQQXZfqtJl4OfdJgR7TT/zC4F3
         7xQrMWn4LTSZovAcLsz5FC291zfm9CkCNteRWDkqwnUKL085aRZWRpENx066bQ6N1sFo
         b9oBCezBJI2dcoH7tzPzTb40ZWMxaV4RHdLqeFAPnL7aoFfFnX7zFom+v31WXRBugGZK
         ID5w==
X-Gm-Message-State: AOAM530ZyQ5F+91eY0EjRXrC3sCabybdP/aG5E9krzWOfhePuGGULkHQ
        d58FU2V1NO0JJX5TcG66axwlJ5uVfawayl8pkoSaFMBPzuJFdbMLTmC59eNU/r9vseh4MK2M6XD
        5RifH4QzfHFbENBUsG+7pT+aAau1GmSCeMmqOVkjf
X-Received: by 2002:a05:6402:8c6:: with SMTP id d6mr12036692edz.316.1642425997165;
        Mon, 17 Jan 2022 05:26:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx8YaV1aLTswuEFHaE1fusKVZRcGKTSjM1NX25QZWlQE0HFL6k78U6xAC/cq4nVM/7Je6tjHmbvjgnuBm7YP4g=
X-Received: by 2002:a05:6402:8c6:: with SMTP id d6mr12036670edz.316.1642425996929;
 Mon, 17 Jan 2022 05:26:36 -0800 (PST)
MIME-Version: 1.0
References: <202201170006.31440.pisa@cmp.felk.cvut.cz>
In-Reply-To: <202201170006.31440.pisa@cmp.felk.cvut.cz>
From:   Wander Costa <wcosta@redhat.com>
Date:   Mon, 17 Jan 2022 10:26:25 -0300
Message-ID: <CAAq0SUnfPDX5Rkci9RQrrdvc7Js4KuRXoPD5UPnVrxGg16waNw@mail.gmail.com>
Subject: Re: TTY layer discussion about generic FIFO depth and Rx iddle
 timeout control
To:     Pavel Pisa <pisa@cmp.felk.cvut.cz>
Cc:     Wander Lairson Costa <wander@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        =?UTF-8?Q?Rostislav_Lisov=C3=BD?= <lisovy@gmail.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Jiri Slaby <jslaby@suse.cz>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=wcosta@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sun, Jan 16, 2022 at 8:06 PM Pavel Pisa <pisa@cmp.felk.cvut.cz> wrote:
>
> Dear Wander and Greg,
>

Hi there,

Notice that by no means I am an expert either on the TTY or CAN subsystems.

> [resend on base of email-bot of Greg Kroah-Hartman's inbox]
>
> I have noticed that you have sent enhancements
> to the TTY layer.
>
> I have worked on architecture of automotive LIN-bus
> support for Linux UARTs. The SocketCAN API was idea
> of Oliver Hartkopp and we have designed internals
> to implement actual protocol. Rostislav Lisovy
> was main author at our university in 2011. The code
> has been used and is used by more people and I have
> helped its integration to local Volkswagen subsidiary
> projects. I have helped to maintain it for years
> even that I have actually no use for it or contract.
> But is seems usable...
>
> I am not sure if it can reach quality standards
> for mainline but I have tried to consolidate
> many forks and copies from our original GIT
> server which can be found on GitHub and united
> project under
>
>   https://github.com/lin-bus
>
> Kernel part - slLIN TTY discipline - can be found there
>
>   https://github.com/lin-bus/linux-lin/tree/master/sllin
>
> Documentation
>
>   https://github.com/lin-bus/linux-lin/wiki/
>
> The main obstacle to have version which can be used
> with different UARTs seamlessly is missing internal low
> level kernel API which would allow to control Rx trig
> level.
>

Do you mean the electric wire-level or Rx buffer threshold?

> I have not checked your changes yet but I would be happy
> if some API is available for this control. Please see
> issue
>
>   https://github.com/lin-bus/linux-lin/issues/13
>

From what I read I believe you are talking about the FIFO threshold.
One approach Is adding a new function to serdev_controller_ops for
supported (and tested) controllers, I think.

> Please suggest where to discuss the proposal/solutions
> or if you plan to implement something like that.
>
> I would be happy to work on that myself or with my students
> but I personally do not get to that probably earlier
> than in summer. I have to finish project for European Space
> Agency at PiKRON company. We have quite lot of work
> to switch our Computer Architectures classes and corresponding
> QtMips/QtRvSim simulator to RISC-V etc...
> Mainlining CTU CAN FD driver has higher priority than LIN for
> me as well.
>
> So my actual motivation is to document the need and get some
> feedback if some such solution is on the horizon
> and what should API look like if I get to it ourselves etc..
>

As Greg said, it is easier to organize the work in a series of patches
and send them for review.


> Best wishes,
>
>                 Pavel
> --
>                 Pavel Pisa
>     phone:      +420 603531357
>     e-mail:     pisa@cmp.felk.cvut.cz
>     Department of Control Engineering FEE CVUT
>     Karlovo namesti 13, 121 35, Prague 2
>     university: http://dce.fel.cvut.cz/
>     personal:   http://cmp.felk.cvut.cz/~pisa
>     projects:   https://www.openhub.net/accounts/ppisa
>     CAN related:http://canbus.pages.fel.cvut.cz/
>     Open Technologies Research Education and Exchange Services
>     https://gitlab.fel.cvut.cz/otrees/org/-/wikis/home
>
>

