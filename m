Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33F9DC001B0
	for <linux-serial@archiver.kernel.org>; Wed,  9 Aug 2023 01:54:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjHIByr (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 8 Aug 2023 21:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjHIByq (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 8 Aug 2023 21:54:46 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A2A1BD4
        for <linux-serial@vger.kernel.org>; Tue,  8 Aug 2023 18:54:45 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-40fcc91258fso41520581cf.1
        for <linux-serial@vger.kernel.org>; Tue, 08 Aug 2023 18:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1691546085; x=1692150885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jPdHd3dHPLZ4M3JoFcie+26YcC9WO5uy2oLMLgktoeI=;
        b=OU3PSnnA00wAD10NZkfWd21vL8EzaIUAZtK+Qg7OMsNa9tJ/PkC4Et4gk6V+RsacaT
         QeYfVgRon03GTnp/cj88633IUJcgit8913i2Cw/86xL5dNLWc2Kt+e91+rTFBlFuVl5s
         tgEGB4vqxxiEqwsgIxq/FU8BRCr0yG0s67BkYJrLc1jNnOIIciBj32xh4Wd6WwhcXIq7
         RYd6+XFIM0zT8y2yxtidAoH4bmIFdVhIVDz7F5YbPhgJtS9IzrslMBinuvqfP15LVlJB
         6Sbkw8ZdCxShv1ceZeHFJqe9hrzKyOOuIyJeVS2dsmQ4VDHcQhD3pSwnHVScn+Wxo9Yb
         fDYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691546085; x=1692150885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jPdHd3dHPLZ4M3JoFcie+26YcC9WO5uy2oLMLgktoeI=;
        b=g+IUpvlfa37my3LE3Xzga169BXYSXlpdUQubeKxk778/dyKslm4WKTJrfpeuslMNFB
         v8QNF8uLwe6jrKj8lUg6PAkzRKVkL3jmZUbWujKxHhmoIZIsFN0Xz7w/01QnTnfiuJ8O
         s1HJ8ZmFWWsvrZc5+qPqARdyErQlZmsC8E5p6mTtnhaYmDEWvFipX2LnQhXNifZAztPT
         8dHBqcodwYkbJ0Rr2FlWxYG3mbswLN8msMILDdJRyKWUj33OItUmj0Gd82knkSvhQZzl
         A8jXocnkfP1NjSWtCK7q6v/00iIULb7SvHFT6pBQD2Yh8mndSuBQrr20tt97KUGjCFEZ
         gxMQ==
X-Gm-Message-State: AOJu0YwDb2tQvy28xCgi4tN4UE1RzCZ5xpOLLcQYY+q6Wl7TWKrlf6Mq
        qP1VQp6nkCImJG/+lXAqmL1P100Dp4axvRgRW48XCA==
X-Google-Smtp-Source: AGHT+IEYGschKJ5T3qO7w+VCCOczmPOzdCdurely6UZuaq78UNQd+9aB6v5d7ZiOrZpB79QILDgfYlosNVDERg0QFRc=
X-Received: by 2002:a05:622a:1309:b0:40f:f860:f047 with SMTP id
 v9-20020a05622a130900b0040ff860f047mr1903567qtk.56.1691546084960; Tue, 08 Aug
 2023 18:54:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230808072625.2109564-1-nick.hu@sifive.com> <20230808-pristine-celibate-60957ea523c0@spud>
In-Reply-To: <20230808-pristine-celibate-60957ea523c0@spud>
From:   Nick Hu <nick.hu@sifive.com>
Date:   Wed, 9 Aug 2023 09:54:34 +0800
Message-ID: <CAKddAkA3giaG6kjcxsaA9c4TpemKThPyAzb6+Sv4ug7S7kUm=w@mail.gmail.com>
Subject: Re: [PATCH 1/2] serial: sifive: Add suspend and resume operations
To:     Conor Dooley <conor@kernel.org>
Cc:     zong.li@sifive.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Ben Dooks <ben.dooks@codethink.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Conor


On Tue, Aug 8, 2023 at 4:44=E2=80=AFPM Conor Dooley <conor@kernel.org> wrot=
e:
>
> On Tue, Aug 08, 2023 at 03:26:25PM +0800, Nick Hu wrote:
> > If the Sifive Uart is not used as the wake up source, suspend the uart
> > before the system enter the suspend state to prevent it woken up by
> > unexpected uart interrupt. Resume the uart once the system woken up.
> >
> > Signed-off-by: Nick Hu <nick.hu@sifive.com>
> > Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
>
> Where is patch 2/2?
This was my bad. There is no patch 2/2. I'll correct it in V2.

Nick
