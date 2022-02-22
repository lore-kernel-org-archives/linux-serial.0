Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D98C433F5
	for <linux-serial@archiver.kernel.org>; Tue, 22 Feb 2022 12:49:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232022AbiBVMuX (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 22 Feb 2022 07:50:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiBVMuX (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 22 Feb 2022 07:50:23 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2508B128658;
        Tue, 22 Feb 2022 04:49:58 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id a8so42686640ejc.8;
        Tue, 22 Feb 2022 04:49:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WvLhkjzSqJb5E/EJA2yDxnOjRCC3ggMcv4OBH6XBB3s=;
        b=krLU9JQvtbjmgr7T36yeBT7800xENccDS6OFzPD9iSCCtYa9F3jqs8Q9a9pyxjcOWn
         rtmcY263cLJLpnuvF6LySNsv39OBLeoInkWB6ygmFMMn1nUn2olOkyQyDtf2ZmsbBW6q
         hAD1foreF0/LjH+o6CZz4OU8qdNB+pcfvGtewVvJxVZ5isUFrCy4MXP/qDt76hzN25cZ
         tZxrKkMV5TubXjFQr1MHNPyulpyCLkemOvbjtYx1CyKVvoisC+JcUzd3bZ4cW183Rr7z
         RoUYnNF+87qXSi3aa2LzhbLjZcrRIpVng+okF+ezOe9vnHbTSGOpVu7WEEj2GP3iGjio
         2k1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WvLhkjzSqJb5E/EJA2yDxnOjRCC3ggMcv4OBH6XBB3s=;
        b=puG/rhy3JdrKVz9CQOC1Ng4pO/p6Dz4wc3+jtiMH+gKMX5cTS4bkbDw00OgGCcsBoo
         O6zAqasazzuIR/go/SnBesgdwTmyq8QOlA2mDblwFv8SFf9sBJuBNN7wAEnsjZF7I1yf
         6clTozf83WsbhQ1XXZp6cgsWwyZFMjhur+LtbAecUASjUwJzROeHhlGYI3rwoGXNsZ2r
         sh/m7cLEtBvwUrFGRb4hWY6nLulDLD+t7BpAhM1+hXj7akWs/LZ/5pyOJ1xwnu5nX43U
         kWUiTl3Iqkg+JALVi8v4epcIE4J6h87+wR4vWnX0rmozQGqM4XQugP9vxtUPh5n24WRt
         wYqg==
X-Gm-Message-State: AOAM530Pg3SJo/rIb/MzMr8UAjV0fBaN11E1iFUtUsFTXj3mP2hLVBiB
        iysyWGFybSC+aw1kwSkhUOE1Jw7kYVBF5edCgN0=
X-Google-Smtp-Source: ABdhPJxdHyUI1rUoXarUAEq39aC0w5AzvH1kx3kBVTs+1LLrh/i0ksHsY60Ni+0stPE653QOl6TKy7q53DBqhD3+pdU=
X-Received: by 2002:a17:907:3c12:b0:6cf:37d0:a551 with SMTP id
 gh18-20020a1709073c1200b006cf37d0a551mr19506893ejc.38.1645534196596; Tue, 22
 Feb 2022 04:49:56 -0800 (PST)
MIME-Version: 1.0
References: <20220222115604.7351-1-ilpo.jarvinen@linux.intel.com> <20220222115604.7351-3-ilpo.jarvinen@linux.intel.com>
In-Reply-To: <20220222115604.7351-3-ilpo.jarvinen@linux.intel.com>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Tue, 22 Feb 2022 04:49:44 -0800
Message-ID: <CAMo8BfKHn4MAwP++EgvB1ZNB7=qwydi-FZB_hrcjamP4pj01xg@mail.gmail.com>
Subject: Re: [PATCH 2/2] xtensa: termbits.h is identical to asm-generic one
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org,
        "open list:IA64 (Itanium) PL..." <linux-ia64@vger.kernel.org>,
        Chris Zankel <chris@zankel.net>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Feb 22, 2022 at 3:56 AM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> Remove arch specific termbits.h as there are only trivial space
> differences between include/uapi/asm-generic/termbits.h and
> arch/xtensa/include/uapi/asm/termbits.h.
>
> $ diff -u0 -b -B include/uapi/asm-generic/termbits.h arch/xtensa/include/=
uapi/asm/termbits.h
> . --- include/uapi/asm-generic/termbits.h       2022-01-10 13:44:42.81410=
7461 +0200
> . +++ arch/xtensa/include/uapi/asm/termbits.h   2022-01-10 13:44:42.69010=
6926 +0200
> . @@ -2,2 +2,15 @@
> . -#ifndef __ASM_GENERIC_TERMBITS_H
> . -#define __ASM_GENERIC_TERMBITS_H
> . +/*
> . + * include/asm-xtensa/termbits.h
> . + *
> . + * Copied from SH.
> . + *
> . + * This file is subject to the terms and conditions of the GNU General=
 Public
> . + * License.  See the file "COPYING" in the main directory of this arch=
ive
> . + * for more details.
> . + *
> . + * Copyright (C) 2001 - 2005 Tensilica Inc.
> . + */
> . +
> . +#ifndef _XTENSA_TERMBITS_H
> . +#define _XTENSA_TERMBITS_H
> . +
> . @@ -200 +221 @@
> . -#endif /* __ASM_GENERIC_TERMBITS_H */
> . +#endif /* _XTENSA_TERMBITS_H */
>
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  arch/xtensa/include/uapi/asm/termbits.h | 221 ------------------------
>  1 file changed, 221 deletions(-)
>  delete mode 100644 arch/xtensa/include/uapi/asm/termbits.h

Acked-by: Max Filippov <jcmvbkbc@gmail.com>

--=20
Thanks.
-- Max
