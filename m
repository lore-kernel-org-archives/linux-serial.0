Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E59C433EF
	for <linux-serial@archiver.kernel.org>; Fri,  8 Apr 2022 14:54:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236939AbiDHO47 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 8 Apr 2022 10:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231631AbiDHO46 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 8 Apr 2022 10:56:58 -0400
X-Greylist: delayed 304 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 08 Apr 2022 07:54:55 PDT
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05D2B640D
        for <linux-serial@vger.kernel.org>; Fri,  8 Apr 2022 07:54:54 -0700 (PDT)
Received: from mail-wr1-f53.google.com ([209.85.221.53]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MT7ip-1nY7Wd1dzL-00UYdI; Fri, 08 Apr 2022 16:49:48 +0200
Received: by mail-wr1-f53.google.com with SMTP id d3so13210960wrb.7;
        Fri, 08 Apr 2022 07:49:48 -0700 (PDT)
X-Gm-Message-State: AOAM5314q0WqgwudkYj1VSsf0mFE1X2Cqg4IBsQyi1m8/hEIRhSljyrQ
        MqjfG1vUu0u9eI+thrcSA/Fx7La61uyd5BxOaKw=
X-Google-Smtp-Source: ABdhPJwVNzAUvp4q5y9Xv8Pl9NcevPGw56Av/8fDlBAo0sYujt7tAUw/HOtRrfZixqKYu184m37g27gifqdWtdVR4Vc=
X-Received: by 2002:a05:6000:178c:b0:204:648:b4c4 with SMTP id
 e12-20020a056000178c00b002040648b4c4mr14628640wrg.219.1649429387994; Fri, 08
 Apr 2022 07:49:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220331092235.3000787-1-hasegawa-hitomi@fujitsu.com>
 <20220331092235.3000787-2-hasegawa-hitomi@fujitsu.com> <YkWVTEG5oFO82GPL@kroah.com>
 <CAK8P3a0jnzse4sG58taO5+Yd5vCgh1uddqbtAuim_z9r15Q3BA@mail.gmail.com>
 <20220408133246.fyw5554lgli4olvg@maple.lan> <CAK8P3a0u2xa9BFmakG+f4kyLsqNZQbE6KQ6jz2356Fyen=1EHw@mail.gmail.com>
 <YlBE6hZHmLo9/wrU@kroah.com>
In-Reply-To: <YlBE6hZHmLo9/wrU@kroah.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 8 Apr 2022 16:49:31 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3v4+AO5avGoxeZSyNTOWqk8YS95xQLWSBZ=yV_3DKggg@mail.gmail.com>
Message-ID: <CAK8P3a3v4+AO5avGoxeZSyNTOWqk8YS95xQLWSBZ=yV_3DKggg@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] soc: fujitsu: Add A64FX diagnostic interrupt driver
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Daniel Thompson <daniel.thompson@linaro.org>,
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
X-Provags-ID: V03:K1:yacM5vXlZ9M/b5opAPcDYsI9bcnrr5azz1UO9ROET8AV68QYf76
 GDDX5aJpyXCn52nPH4I7bT78OWiwreWlfHYGDjHS4SXXeFXBVxA/7Qeb/ZgL+srBYo9n4Jl
 7TXkWuKDyZ+6ENe3ZbsKCp1asyYtn01gIDf68HhdLuRSCMOHmrmk9ehEefRgFpWxp9lv4NC
 jgjjus0mN7qR9cifrY0KQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:U03SNWMO1xA=:XOaknGd6f5UJJqoG7J+yad
 vsSh5dnvIHW7w2kdzZlGwcN4aSv+H8Tl4mMn+TkvWg3jvyvBy7TQRYDa8dY3975MgqrDN4gMY
 3RBX7kNgZHVVkXESKmoyI0u+sa2NXD1p7kWeh6j3AyCO6CeCKWFiqt1A2cVNFHkcvecsFTY+x
 WubJNThfdHKbJD7xn0qS+TcdBdzVzGNKBrzdCgTptk3QwTMdjDBBF6pbA/tjClATN25yWg+Fq
 VW79Qo/XoAdwTakoo968jb4qXg4E9tDhI9o2dkXnRzH2S5766mu6aYta27728QCJ0RcEYDUKx
 r+pjn0ov+ouCGP4C/cD1cYPbf4BiZv4Fk0/OSXRWJDjUV3ntW3j1t1AHlSZp6+DPySKPEsCLl
 ylqo3kTSljiErKs1Jlknn5nOf9jkLzpG8APj8cNCa04zk/J4ZPNd8Iwv3YvT+Wuwy788JJFbb
 kr7PH4p5REWIoKmrwJdekrp/zfk7p6sC/lIapT0ElFG/AO8fQe3+UWJG34opN7klIgm6bItTt
 SOPaaUJIpSZaAXhsW7SugXyVLo8S8cO2qzp+GXpqNaGLV4V/CG+VjbWed0oDznV9ZK6H5pdCM
 Ces/awEn8kzjIkIB0hQ34JlsKs8jI89hjc7DpdX3FW0HtyTfl4pXRlvR0zrvJbSDqeOS4hkbv
 cICtD7qoNhNwyYPBELMi2t3WEHdUtTsH0oq9XTHrE+YTde7muba1zgbDWJJdOvU/br+f9IOvB
 DqHYuqkNMYwgS+iJRSzYQwOuxbEkMT0QYiXn/Ho0eFuDlkmlcOFrnep+pqektAC2gdyXvhZNh
 1mSDDh1EowMEif3IY6wQC5c41hHTbkdNw54GQhAlFI6VYfkk2M=
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Apr 8, 2022 at 4:21 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Fri, Apr 08, 2022 at 04:17:16PM +0200, Arnd Bergmann wrote:
> > On Fri, Apr 8, 2022 at 3:32 PM Daniel Thompson
> > <daniel.thompson@linaro.org> wrote:
> > > On Thu, Mar 31, 2022 at 05:44:55PM +0200, Arnd Bergmann wrote:
> > >
> > > There is some prior art for this sort of feature. AFAICT SGI UV has a
> > > similar mechanism that can send an NMI-with-no-side-channel to the
> > > kernel. The corresponding driver offers a range of actions using a
> > > module parameter:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/platform/uv/uv_nmi.c#n180
> > >
> > > I don't think a hardcoded 'c' makes any sense. With a hardcoded argument
> > > it is just obfuscation. However it is certainly seems attractive to be
> > > able to reuse handle_sysrq() to provide a more powerful set of actions.
> >
> > How about a module parameter that allows picking a sysrq character then?
>
> Module parameters are so 1990, as this is a platform device, why not get
> it from DT?

This machine doesn't use DT. I suppose the same could be done with an EFI
variable, but with a module parameter you get the added benefit of having both
a boot time kernel command line argument, and the option to override it at
run time.

         Arnd
