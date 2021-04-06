Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5668C433B4
	for <linux-serial@archiver.kernel.org>; Tue,  6 Apr 2021 21:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F29B613CC
	for <linux-serial@archiver.kernel.org>; Tue,  6 Apr 2021 21:52:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242121AbhDFVwi (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 6 Apr 2021 17:52:38 -0400
Received: from mail-ot1-f48.google.com ([209.85.210.48]:42949 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238486AbhDFVwh (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 6 Apr 2021 17:52:37 -0400
Received: by mail-ot1-f48.google.com with SMTP id c24-20020a9d6c980000b02902662e210895so15596947otr.9;
        Tue, 06 Apr 2021 14:52:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SZYgSptA3ZzQ3t6TtpWVpGXzldK/l7dPJJEKGwpB+bk=;
        b=SjxbpVi9DSvDd7++IPTHXEfzFN6cL7eag1erjhqqlwbU+JN/rU5AhHQKmT2ISyh+il
         GYh2VjlAyEuHQVORaKV2iVUh8D+bJ70ukzOwXkqGkeNwDwlDpNGT8xJqX8WCcwloK43s
         NjGMkYGbnQCzM9NDouJnP6xAc6lTa72h4n98FeYZz0TulhDw07ilBXCXWBF4LzGIXId/
         KmY9MrWCrwvRU9BkCtRPRd+ySLszyz9eYBGPNkVvGmEVSIWOmmtr7k8ZaTgBOybL6KLi
         GNjRJgx5wSiFPfSBIUYxIq3cMZiPVD+UJW0GsFBZeTv31u6Jy1ehDHXI18sV409wqcU8
         kT8g==
X-Gm-Message-State: AOAM532/HNUXsxKv71MpRuoNsiizfOum8JQSlTlqI9ajczdFP95C2+oa
        61RvaKJAC8U/dyfmQg7gmxtpMZsYHWc=
X-Google-Smtp-Source: ABdhPJwdooz2Y7uz3cXkCptffNZbmAgNq/gCfJ7Apu5L8QIclBqafGGgx+cZAbD3z/3dQVH1Jvd1rw==
X-Received: by 2002:a9d:2f24:: with SMTP id h33mr177021otb.128.1617745947601;
        Tue, 06 Apr 2021 14:52:27 -0700 (PDT)
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com. [209.85.167.172])
        by smtp.gmail.com with ESMTPSA id m19sm4350392oop.6.2021.04.06.14.52.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Apr 2021 14:52:26 -0700 (PDT)
Received: by mail-oi1-f172.google.com with SMTP id w70so16748188oie.0;
        Tue, 06 Apr 2021 14:52:26 -0700 (PDT)
X-Received: by 2002:aca:53cb:: with SMTP id h194mr4992128oib.175.1617745946741;
 Tue, 06 Apr 2021 14:52:26 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1615053848.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1615053848.git.christophe.leroy@csgroup.eu>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Tue, 6 Apr 2021 16:52:14 -0500
X-Gmail-Original-Message-ID: <CADRPPNSx=sbWu9FGujp7=EV7d=dTn+ukvKAgpEHQ5u0vNwR+QQ@mail.gmail.com>
Message-ID: <CADRPPNSx=sbWu9FGujp7=EV7d=dTn+ukvKAgpEHQ5u0vNwR+QQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] Remove qe_io{read,write}* IO accessors
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Qiang Zhao <qiang.zhao@nxp.com>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Timur Tabi <timur@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sat, Mar 6, 2021 at 12:11 PM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
> Commit 6ac9b61786cc ("soc: fsl: qe: introduce qe_io{read,write}*
> wrappers") added specific I/O accessors for qe because at that
> time ioread/iowrite functions were sub-optimal on powerpc/32
> compared to the architecture specific in_/out_ IO accessors.
>
> But as ioread/iowrite accessors are now equivalent since
> commit 894fa235eb4c ("powerpc: inline iomap accessors"),
> use them in order to allow removal of the qe specific ones.
>
> Christophe Leroy (3):
>   soc: fsl: qe: replace qe_io{read,write}* wrappers by generic
>     io{read,write}*
>   tty: serial: ucc_uart: replace qe_io{read,write}* wrappers by generic
>     io{read,write}*
>   Revert "soc: fsl: qe: introduce qe_io{read,write}* wrappers"

Series applied.  Thanks.

>
>  drivers/soc/fsl/qe/gpio.c     |  20 +++---
>  drivers/soc/fsl/qe/qe.c       |  24 +++----
>  drivers/soc/fsl/qe/qe_ic.c    |   4 +-
>  drivers/soc/fsl/qe/qe_io.c    |  36 +++++-----
>  drivers/soc/fsl/qe/ucc_fast.c |  68 +++++++++----------
>  drivers/soc/fsl/qe/ucc_slow.c |  42 ++++++------
>  drivers/tty/serial/ucc_uart.c | 124 +++++++++++++++++-----------------
>  include/soc/fsl/qe/qe.h       |  34 +++-------
>  8 files changed, 168 insertions(+), 184 deletions(-)
>
> --
> 2.25.0
>
