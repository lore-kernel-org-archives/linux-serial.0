Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC74C433F5
	for <linux-serial@archiver.kernel.org>; Mon,  8 Nov 2021 09:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 972656125F
	for <linux-serial@archiver.kernel.org>; Mon,  8 Nov 2021 09:00:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238300AbhKHJDU (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 8 Nov 2021 04:03:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238264AbhKHJDN (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 8 Nov 2021 04:03:13 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F171DC061714;
        Mon,  8 Nov 2021 01:00:09 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id o15-20020a9d410f000000b0055c942cc7a0so1748856ote.8;
        Mon, 08 Nov 2021 01:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FZanGk8rGCBdhGfwRJPODn+28JTXVnU7A9yXQrXql5U=;
        b=My1raRicmldHpmqxFEz86vzjpTbpS6iuVV2GdMFpFRH2MptKMQYzu4qssYOMmfDvYV
         5ObAYAgUfVPWi7ignWFKfsDNA8+zW/RsFjYTxHhzbnYeb2Semfc5lDv8KZcOJst8FKOg
         6u1iYI56w4zESvLIcwfNWwfL1grVHalG30056Fwmbo2vLe2FTOGzsjcf2oGwblBwe81p
         Vo85vDS7/st80jjr6SpwqinLHHsuvhOQ+BTrjcprb8cyQafH+2ZRUCmcqifZbO7Rewyv
         XzXhCF5p6gizHWLXF7rohTFaQrB/Gyn7RJfQGRFyQ5yCcHgn9cAS21hSNh7p66E6O1y6
         z19Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FZanGk8rGCBdhGfwRJPODn+28JTXVnU7A9yXQrXql5U=;
        b=rTAaYFoM9ZAdEiFDn3m01cR32rOC4MQLyO8xKL8LI3pn72QjQBhq8SKUODHxwjBy4M
         lYc8/QdLxyQ74e7GmS3QGo5sIl5CBAHsnt8f0mjk952tgBuSSZ8NUMq4inIA/z4pJo2Z
         byCNAHCly8EMpphJsfBOUJ4pXozbjVOiC7dmL6FDb+HfNBBmvoeo+h28XdfYZT1Ebzhf
         tQLXOpy7dol+v1d0Wu/nis5D0Hh12LJQoKmHWo7czuBjkMUDIC5rFG2g1ubm9xYmBmXr
         NxmYmO/HErHBOpJ6toGskXG9MB9LCuuH9U4ZmNhtszAfBa5YZeYXKJQ9dT6MiLGO3ozN
         +lzg==
X-Gm-Message-State: AOAM530nJyiBhHKIFMzpURM/ShiOlQszZVvneU3650bp9wD2jUpCSqnz
        ysenCLzO/wlY+5Z9juasoRT58K90l+hzSY2TC666hoy/Pbk=
X-Google-Smtp-Source: ABdhPJx4StEUB+R6DAyP5d7YK12udwTm5xg8EZNd4Q6ZBUlffXWYR4nbReeR4Yo3+Td5hsWM30xNonMWWKdtRnSvpRc=
X-Received: by 2002:a9d:6f0e:: with SMTP id n14mr9928388otq.173.1636362008818;
 Mon, 08 Nov 2021 01:00:08 -0800 (PST)
MIME-Version: 1.0
References: <20211106092041.43745-1-ajaygargnsit@gmail.com>
 <9eafae1f-d9f0-298d-cf20-212865d0becc@gmail.com> <868025b485b94480ad17d0ec971b3ee9@AcuMS.aculab.com>
 <CAHP4M8Ww0-VqCBKX=iLd=zy1AcDoNdzTOqJuaqRxCGZsMhoX9w@mail.gmail.com>
 <CAHP4M8UcZ=ttB8jbN1yOY6YH8SiQ27NhdEKi9SDH1CWG-GY6eg@mail.gmail.com>
 <6b58a3e1-f2ea-cc4c-03b2-06334b559373@gmail.com> <CAHP4M8Vs8a8u98enuHXaBcC7D4fCZzCOtEq06VnvuPUqhqPK=Q@mail.gmail.com>
 <9717b429-597f-7778-c880-94361bcdee7f@gmail.com> <CAHP4M8XtFiAa1kF5A_rPbcui3DP8L6iyfP8GbwgLLzo0Bo+TNQ@mail.gmail.com>
 <65c45951-08ba-26bb-f96b-3d4442b1d4d4@gmail.com>
In-Reply-To: <65c45951-08ba-26bb-f96b-3d4442b1d4d4@gmail.com>
From:   Ajay Garg <ajaygargnsit@gmail.com>
Date:   Mon, 8 Nov 2021 14:29:56 +0530
Message-ID: <CAHP4M8X_D4WdK9TwQoeV=WTEGUyLCs1VV5qWbYbfWJyZ9+C_5w@mail.gmail.com>
Subject: Re: [PATCH] tty: vt: keyboard: do not copy an extra-byte in copy_to_user
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>, jirislaby@kernel.org,
        kernel@esmil.dk, David Laight <David.Laight@aculab.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Dropping all further discussions on this thread, as a RFC for a new
string-copy method has been posted at :
https://lore.kernel.org/linux-hardening/CAHP4M8U=0aTHgfREGJpSboV6J4X+E3Y6+H_kb-PvXxDKtV=n-g@mail.gmail.com/T/#t

which, if accepted, will make the clients' lives a lot easier.
