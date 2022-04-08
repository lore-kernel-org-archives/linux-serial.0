Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C50C433FE
	for <linux-serial@archiver.kernel.org>; Fri,  8 Apr 2022 14:22:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236855AbiDHOYt (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 8 Apr 2022 10:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236859AbiDHOYr (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 8 Apr 2022 10:24:47 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB6432F08A
        for <linux-serial@vger.kernel.org>; Fri,  8 Apr 2022 07:22:41 -0700 (PDT)
Received: from mail-wr1-f45.google.com ([209.85.221.45]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MAgIQ-1nns2P0Jiq-00B36t; Fri, 08 Apr 2022 16:17:33 +0200
Received: by mail-wr1-f45.google.com with SMTP id r13so13052825wrr.9;
        Fri, 08 Apr 2022 07:17:33 -0700 (PDT)
X-Gm-Message-State: AOAM533+S4NKupeNPBjsQTy9XVS2f1OXQU3w4uKgOkpJIcQvovvf5gSr
        wKepiB6SvggL4EmMLFDmiLUcR9Y7G9CwalQszUw=
X-Google-Smtp-Source: ABdhPJyRvLylYLoRuY6841KYpUytqXI11HqBYxQTS325hyru8pYNuf4xphTlAZhMdkzDaG6t0dxOMOlKEQOVIRLpsBk=
X-Received: by 2002:a05:6000:178c:b0:204:648:b4c4 with SMTP id
 e12-20020a056000178c00b002040648b4c4mr14524137wrg.219.1649427452724; Fri, 08
 Apr 2022 07:17:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220331092235.3000787-1-hasegawa-hitomi@fujitsu.com>
 <20220331092235.3000787-2-hasegawa-hitomi@fujitsu.com> <YkWVTEG5oFO82GPL@kroah.com>
 <CAK8P3a0jnzse4sG58taO5+Yd5vCgh1uddqbtAuim_z9r15Q3BA@mail.gmail.com> <20220408133246.fyw5554lgli4olvg@maple.lan>
In-Reply-To: <20220408133246.fyw5554lgli4olvg@maple.lan>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 8 Apr 2022 16:17:16 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0u2xa9BFmakG+f4kyLsqNZQbE6KQ6jz2356Fyen=1EHw@mail.gmail.com>
Message-ID: <CAK8P3a0u2xa9BFmakG+f4kyLsqNZQbE6KQ6jz2356Fyen=1EHw@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] soc: fujitsu: Add A64FX diagnostic interrupt driver
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        SoC Team <soc@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Doug Anderson <dianders@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Peter Zijlstra <peterz@infradead.org>,
        Mike Travis <mike.travis@hpe.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:fSUH//fRoVL1JVYdqkQNFLMppuXsqI6gVGhc2sXbbA+du6trdHy
 1HbyaM1VXF9d+cnpAL2SSV2ATjO1Rtm/sURdcEO1mMAwEACchy3ufqF+tkhVWFcsD0tLnG+
 StSV/nu3BbVNBvtV5TQBuzxlwCb76H/h7kOxH9WvYIWUoYF40CtqkYeJqtaCitVNzSBNf1f
 vvSb0SByiO2QNMztj7uSQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:L5yLut/OGFM=:8P0cXhOnpv0STzJtKp+IV7
 I5+rNWI/3dFK4kfTw3rqLGLJ0buFFgtbjtKSm+oXpBiF5xd0NhIxexvV+cFyLY74chobCYcsa
 J7Gs/0J6F33B+LyFDYIeRBxAv2+vTBYB8kFRWiVzPUIVECuj2UdhX4uO94986trCfKSJ4zYYN
 noPF/a7F0X9Z08BqqW+bQ+VSppQox7L2awVcJ9A6IlK2ywQ+93GCJTHK8MlrcXO/WN3UO246V
 ofkCm32/KvwAtJVh1IpB5uGnmTNgKXw+1b701pVh3e97xrpa0hGgcp8nulhqdxDqpu0uoAFBX
 gskFHUq27VdAKPqmJCm6Fi6TvOP9R1C+5XIU6fgBH/Ny2bZWJ54f+ra4AV4sfe+IrZSU8KIZu
 CQGEg9xEukpq5oGCiQdHzoOB4CO0uutuKcfnNOccgqOepduqIBMjsJiKgWzcBu/FhHwBTzoK/
 RtZCz2TSsqYu5fhOsWbOupgarD346/xl3UZ+AKB5bq9Fh5PPxbFsOvAaXwcXQEsiTaRbRYC4v
 SxZKEJyp+gi89lXp3eMJBiHEKwMtr3DZvds8mGiLq62u5h4Rde8e0R44WSZm6fXCZxv9Cq92+
 +usz4uCIy4NryQm/6fIYMeZnwvxj6TNcnZfO90vpX2cySVdO4Wm+0QaPo5Fi0+W8+Pz7A/DKu
 zac/rc/coQ/G1WHJNpBfFmqSd6vDmc7WRrFGOQ0dj6qlwhgqWtVkgAPTo5B0Jz/HUZyg=
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Apr 8, 2022 at 3:32 PM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
> On Thu, Mar 31, 2022 at 05:44:55PM +0200, Arnd Bergmann wrote:
>
> There is some prior art for this sort of feature. AFAICT SGI UV has a
> similar mechanism that can send an NMI-with-no-side-channel to the
> kernel. The corresponding driver offers a range of actions using a
> module parameter:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/platform/uv/uv_nmi.c#n180
>
> I don't think a hardcoded 'c' makes any sense. With a hardcoded argument
> it is just obfuscation. However it is certainly seems attractive to be
> able to reuse handle_sysrq() to provide a more powerful set of actions.

How about a module parameter that allows picking a sysrq character then?

        Arnd
