Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7748C433F5
	for <linux-serial@archiver.kernel.org>; Tue,  2 Nov 2021 07:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7D7160F02
	for <linux-serial@archiver.kernel.org>; Tue,  2 Nov 2021 07:08:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231558AbhKBHKp (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 2 Nov 2021 03:10:45 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:39681 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbhKBHK0 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 2 Nov 2021 03:10:26 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MAwsT-1mt3FP2hpp-00BJqq; Tue, 02 Nov 2021 08:07:50 +0100
Received: by mail-wr1-f46.google.com with SMTP id d13so31660540wrf.11;
        Tue, 02 Nov 2021 00:07:50 -0700 (PDT)
X-Gm-Message-State: AOAM531kSL2GF43nrVVXRqi8qu1MnvR0+1cC374j4ciB5pQRzegmnCaG
        FKA7PZJjCUpxszw2lQSW2DEb6ZlDP1y47pUGFPI=
X-Google-Smtp-Source: ABdhPJyKPutvp0oEXKz1zUFiJo8ovKwCRVt8gMksLMwC/SDvZPCkExERlVRWJ8UMYW7db1o1E4TYrF4YbzsW5Q3La9s=
X-Received: by 2002:adf:e292:: with SMTP id v18mr43153677wri.369.1635836870243;
 Tue, 02 Nov 2021 00:07:50 -0700 (PDT)
MIME-Version: 1.0
References: <20211102063810.932-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20211102063810.932-1-lukas.bulwahn@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 2 Nov 2021 08:07:34 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1eNO0joJq+e6YXuw8A_=vq0sxoL4hkpUd+Mx0swWQgQQ@mail.gmail.com>
Message-ID: <CAK8P3a1eNO0joJq+e6YXuw8A_=vq0sxoL4hkpUd+Mx0swWQgQQ@mail.gmail.com>
Subject: Re: [PATCH] arm: remove zte zx platform left-over
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        kernel-janitors <kernel-janitors@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:9kX8Xe6aGunkXxMoZoI3Nc1AGhcKMhcnAuxqz9Ybg/3TTjb9vSs
 5qGQ/9DN8OuUmHFxipe9zTlR5voZUcuyHk+e8Zvlk6t1f2lvNN5aKM+DwNnsXknkdeovkz6
 VJ5ubA5YWs9d76jhNBlqXf6F3Y4+qa7CUSNQrEoUBiYf6U1VPGVm8r1S+6u6h/Wz88EVbP9
 kUMsSDFgkOKHDfi4PfmWA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fvR87l8WnjA=:mlUAvKI1ptuyj7O6lId/9E
 LtfmrwxRLQWjJRwllUhXmso4FKe6ausg8hwOW3VMtEjFwh7rBvPwXQHs6jC/wO2vBrX0w+J2Q
 5W0LKZ11VHB2fMFkSkNeQPfE1ahnxeaJfAwo8Ks4TzaKMMa+j1pec1dfN24iQ576hdh9cRMjK
 kF+yT+bdIhbZfphRxYo6lo+bnnj0NUTzanGABqqG4nEhCQ5XnihxcGmhm/VlctzDs8j4GqBTN
 oM0zwyqpHIwdRHUqAUK1Ck6NuoMzA5p6/x64CtBa2LlO2OTGLyQJ8N1bC5Un4JXMlU2aaFMEO
 iUelMnGBXEaIF2xqIx580azOuYrj0UXl/q31jZymK7q9t4hHs+5CL3ykpc9+HP/1jdCTbXRD8
 sUbrcC/5SDiIFWtswwirHKfccMXMH8YQBOh/m63eJ2WZDNf5rs8CB0BVIINBnj4tRcQq7ZsGC
 gppYNZS1zr2INQ46Mc0zI7ln4d8pocpqJOjR9WpifSzB6UrApZVL3mb/mRRN0JJii+YzIZ7D0
 vdsU57FkJ7S4XQ8xasC/K/rdn6beg5iZoDgABjL3ts44Ziq5/bLYjujH7TEIB4Bnkz+ulNefG
 iWEwCVqmN91DbU+yUm8p8AYyfqUcDvVyKKnWu+scCcIEvByi5RLeGKYfEm4dJ6XFvw8/dBbS4
 M5qWyyTyn2bpMdAIWo2HfSN+ItglzMkJmDFosGtSs6fNLMF+W+HGjnV2yKiw50KAsgAB2wDjC
 DySXcnTK0wJeimwe0S/dYW9xEscTFyXFAI5Acu1eCHDZ/F3Z7VIfOCCFq1SNLtR57Nhc4Hy0h
 NJz3NzPrXDdvaQA04fedke539LAIYM3bviXjZ9mBymNzF3tn+U=
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Nov 2, 2021 at 7:38 AM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>
> Commit 89d4f98ae90d ("ARM: remove zte zx platform") missed to remove some
> definitions for this platform's debug and serial, e.g., code dependent on
> the config DEBUG_ZTE_ZX.
>
> Fortunately, ./scripts/checkkconfigsymbols.py detects this and warns:
>
> DEBUG_ZTE_ZX
> Referencing files: arch/arm/include/debug/pl01x.S
>
> Further review by Arnd Bergmann identified even more dead code in the
> amba serial driver.
>
> Remove all this left-over from the zte zx platform.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

> ---
> this is a new patch after the discussion around:
>
> https://lore.kernel.org/all/20211028141938.3530-2-lukas.bulwahn@gmail.com/

I'd suggest adding this to the patch description as

Link: https://lore.kernel.org/all/20211028141938.3530-2-lukas.bulwahn@gmail.com/
