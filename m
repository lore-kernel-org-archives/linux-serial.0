Return-Path: <SRS0=xWBg=BY=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A454C433E1
	for <linux-serial@archiver.kernel.org>; Fri, 14 Aug 2020 12:06:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10E2F2054F
	for <linux-serial@archiver.kernel.org>; Fri, 14 Aug 2020 12:06:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rCN61g45"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbgHNMGv (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 14 Aug 2020 08:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727987AbgHNMGu (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 14 Aug 2020 08:06:50 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F64C061385
        for <linux-serial@vger.kernel.org>; Fri, 14 Aug 2020 05:06:50 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id y2so649967ljc.1
        for <linux-serial@vger.kernel.org>; Fri, 14 Aug 2020 05:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xTYBrkMPYKHND6Y0Pf59epaQl0DOsspR8aK4JTKm68k=;
        b=rCN61g45Uj5RAeXU3ZrO9R56Wpm3Zvr8GekOvDvvz4aIZohZJYliwqW0KKfipQpjm3
         dfRAg7XvqBHvcBi737ixXx66TqbFyytmlFrdedZGT5Qv1vO81xuIqjq1ioezmWC/I+Xr
         GM/P4FLNaWnPV4nY8mmekeRA4CDISmoug8hYnFLSrH+ol+7od7RmQMNLXzGYH3ODgCFE
         tqR0bEdTscFbskdo6XQxyrUOwv4glcS592tDiVgA/y8iQ+vS875dbPGxMPpoZjFi7oh1
         A112kq6ZPpG25ilSPSbHbbb2o8QnxfLsFyohMMGo3mwJmvn71xxuVV8GdGECB7M6GsxN
         qsgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xTYBrkMPYKHND6Y0Pf59epaQl0DOsspR8aK4JTKm68k=;
        b=m1tprs1PFTfNtWtRtQrN7ei1JfzJJTeqvL7HwIT6D8OLhvEfEzSPkzmGjIxg6XFKgO
         ZXc8+8BawjFoHwv0YcBHt/SUGpZapLsSsPlhLfemwI0HClsW1y5RWbImQkzoGTNE44vP
         NwGB1JtwQqYRkc+cA5WHbJ9aFNir54bjqZ8tQl956bQYDfSXK7VN/6k94FI34wm/RJWk
         Wsxw1NFMKzlYav3JvIiSZLhLugFmjm8331k303BhC+DGyM4Ttirfrfs0vGpQQp6f1+k9
         ymlL+PKshZ13jYo80rH3n22Uy5XSaW7GLCmTKMLitq5g55E8BI7zAadLuqIpzpr/5cK7
         axkQ==
X-Gm-Message-State: AOAM531OnIhT0fJ8lNYz3d6uua8FhqGi6W+Xus9HuwfWwVsPjHudmelE
        Zgfk+lkGjQKI3rQai6e6le1odqlUfE/O3mfF25f0TA==
X-Google-Smtp-Source: ABdhPJywj23a4nvERV3TKhIYGPaMXV4zmy4h23AHgBTAYyeNijyM6bL8LmRUqDcquSKjRsPVWJJY9vAMmjV8KCcU/+Y=
X-Received: by 2002:a2e:3202:: with SMTP id y2mr1253902ljy.30.1597406808381;
 Fri, 14 Aug 2020 05:06:48 -0700 (PDT)
MIME-Version: 1.0
References: <1595333413-30052-1-git-send-email-sumit.garg@linaro.org>
 <CAFA6WYMN=na4Pxnu1LYRVAAZRdV==5EwU-Vcq-QkRb_jaLiPmw@mail.gmail.com>
 <20200811135801.GA416071@kroah.com> <CAFA6WYMN8i96rEZuHLnskB+4k0o=K9vF1_we83P04h2BSoGjmQ@mail.gmail.com>
 <20200811145816.GA424033@kroah.com> <CAD=FV=UD=cTn6jwpYS-C-=1ORd-4azZ8ZiBR6om++2sMS1nmMg@mail.gmail.com>
 <CAFA6WYPBdOiVsKR_hSLpigN_1b9jimXKaqyRZjvKSx3xpAmLjA@mail.gmail.com>
 <CAD=FV=WccmFRkV4UUTLSYR9+7210h00Si=nG4tRs3BBuweA6ng@mail.gmail.com>
 <CAD=FV=V8UhQVQvcAp6XCmT3=6FYM=_zPELy4FTj4kMKUswaR8Q@mail.gmail.com>
 <CAFA6WYPxieH6ZTa_BFdaLuiwbqAs6r7eKmxG7ci4XtyRONGN7g@mail.gmail.com> <20200813101703.566thqmnc2d7cb3n@holly.lan>
In-Reply-To: <20200813101703.566thqmnc2d7cb3n@holly.lan>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Fri, 14 Aug 2020 17:36:36 +0530
Message-ID: <CAFA6WYPd-fcDkYNk1KrjYwD=FH3FBvjDGEoxCBBN9CRidoVXbw@mail.gmail.com>
Subject: Re: [RFC 0/5] Introduce NMI aware serial drivers
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Doug Anderson <dianders@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net,
        Jiri Slaby <jslaby@suse.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Jason Wessel <jason.wessel@windriver.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, 13 Aug 2020 at 15:47, Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Thu, Aug 13, 2020 at 02:55:12PM +0530, Sumit Garg wrote:
> > On Thu, 13 Aug 2020 at 05:38, Doug Anderson <dianders@chromium.org> wrote:
> > > On Wed, Aug 12, 2020 at 8:27 AM Doug Anderson <dianders@chromium.org> wrote:
> > > > One
> > > > last worry is that I assume that most people testing (and even
> > > > automated testing labs) will either always enable NMI or won't enable
> > > > NMI.  That means that everyone will be only testing one codepath or
> > > > the other and (given the complexity) the non-tested codepath will
> > > > break.
> > > >
> >
> > The current patch-set only makes this NMI to work when debugger (kgdb)
> > is enabled which I think is mostly suitable for development
> > environments. So most people testing will involve existing IRQ mode
> > only.
> >
> > However, it's very much possible to make NMI mode as default for a
> > particular serial driver if the underlying irqchip supports it but it
> > depends if we really see any production level usage of NMI debug
> > feature.
>
> The effect of this patch is not to make kgdb work from NMI it is to make
> (some) SysRqs work from NMI. I think that only allowing it to deploy for
> kgdb users is a mistake.
>
> Having it deploy automatically for kgdb users might be OK but it seems
> sensible to make this feature available for other users too.

I think I wasn't clear enough in my prior reply. Actually I meant to
say that this patch-set enables NMI support for a particular serial
driver via ".poll_init()" interface and the only current user of that
interface is kgdb.

So if there are other users interested in this feature, they can use
".poll_init()" interface as well to enable it.

-Sumit

>
> Daniel.
