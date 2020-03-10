Return-Path: <SRS0=jKy5=43=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7557AC18E5B
	for <linux-serial@archiver.kernel.org>; Tue, 10 Mar 2020 04:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5323B2467D
	for <linux-serial@archiver.kernel.org>; Tue, 10 Mar 2020 04:19:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="UezJBUd8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbgCJETH (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 10 Mar 2020 00:19:07 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:52683 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbgCJETH (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 10 Mar 2020 00:19:07 -0400
Received: by mail-pj1-f66.google.com with SMTP id f15so843357pjq.2
        for <linux-serial@vger.kernel.org>; Mon, 09 Mar 2020 21:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/nvpQDa2s0MPVMjqN65EPRdkP1shvWxs57ggK4I2Mg4=;
        b=UezJBUd8UBFyj3bKah7Qw2Wo2AtojekX2ufF2g3ZSYIv0sEUqPhtk3IYefMBkbFntK
         niMJRQRYZqV+HvnHSDhBuzfxA+FDgFL2zorgk2mt8cw8NOd0wRXCkT9vIlXB1FMqh7tj
         OhCrI5/4S94tcBaKvKOHcE0C0xEd3yz7AxbBO8utT20BqpRcb95IClwp8iF3E/mhmNJK
         k8idTur7D8G3lVXh5CbfP5dUkZ6EqQd2BZuBB/nPHy90/EYLxBe4DkL80Qym9ZhPji7G
         ssk8cc4aoVvAed8Eu92Mtdan/qI7hNq+tSfTBhm3aUKgMB/B9ntD3C9Elj0xr6AtGbp3
         ozHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/nvpQDa2s0MPVMjqN65EPRdkP1shvWxs57ggK4I2Mg4=;
        b=q9VricIrwHVxHi3I8IT2R7cecBEM+4mmyNivmjtEYxVFZQwnoN5SD58W3wmZTSrQQX
         dQyAid3idEgAF/Rbvf9qU1stpl2qZVNWdXc19AK5BivtKhucEP3OHUY0M5y4GN+BLcjW
         NzHr6QxHJKMMXQcDLB8fmOMJyLX6osmeGpe5uxSvfWJR5968EUOanTLXqPtuf6UsEGCO
         iwlmxGPIlmtH9Vcbog+lpxMVYMLGbyBXktqgDDld3JtFZzKAQJIoycO6E/X52dw7vzcE
         r8JIreY0KwcPiwfJbfz1p4gh6a6CriXYWh4uDJ30bj4VCfm6fdrB6wEIW63+UwxL3XwB
         JaSg==
X-Gm-Message-State: ANhLgQ2KMrnTw18feUO3pQb6wNsWbtnV4IoGeTK+0y8MGKDNLDNXrIvz
        khbhGN6vVY79D8ZrkzpfjHaLTA==
X-Google-Smtp-Source: ADFU+vutaDK0+h41+jM+ieqjovHYAnMwRD0e/via06npv351pht7qAqbdVGySjzm9/g9/OXDlq5GNA==
X-Received: by 2002:a17:902:ab8e:: with SMTP id f14mr18389189plr.339.1583813944702;
        Mon, 09 Mar 2020 21:19:04 -0700 (PDT)
Received: from localhost ([2620:15c:211:0:fb21:5c58:d6bc:4bef])
        by smtp.gmail.com with ESMTPSA id 128sm33508515pfe.163.2020.03.09.21.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 21:19:03 -0700 (PDT)
Date:   Mon, 9 Mar 2020 21:19:03 -0700
From:   Sandeep Patil <sspatil@android.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Chunyan Zhang <zhang.lyra@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Jiri Slaby <jslaby@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Android Kernel Team <kernel-team@android.com>,
        saravanak@google.com
Subject: Re: [PATCH 1/2] arm64: change ARCH_SPRD Kconfig to tristate
Message-ID: <20200310041903.GA260998@google.com>
References: <20200305103228.9686-1-zhang.lyra@gmail.com>
 <CAMuHMdVyy3v24zBxJFe5hYdnzdj80dvE2Z9GO4=AC1N8fD64pw@mail.gmail.com>
 <CAAfSe-spu2oNmfEYt+WQvRQy1bCC0e1MFjbUyBAFzghd5XNBfw@mail.gmail.com>
 <CAMuHMdV1qQZF-kAwbcxhHQZZ9hs0dG-OTZ2NcB25Jtra6ii5iA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdV1qQZF-kAwbcxhHQZZ9hs0dG-OTZ2NcB25Jtra6ii5iA@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Geert,

On Mon, Mar 09, 2020 at 11:32:06AM +0100, Geert Uytterhoeven wrote:
> Hi Chunyan,
> 
> On Mon, Mar 9, 2020 at 9:32 AM Chunyan Zhang <zhang.lyra@gmail.com> wrote:
> > On Mon, 9 Mar 2020 at 16:03, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > On Thu, Mar 5, 2020 at 11:33 AM Chunyan Zhang <zhang.lyra@gmail.com> wrote:
> > > > From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > > >
> > > > The default value of Kconfig for almost all sprd drivers are the same with
> > > > ARCH_SPRD, making these drivers built as modules as default would be easier
> > > > if we can set ARCH_SPRD as 'm', so this patch change ARCH_SPRD to tristate.
> > > >
> > > > Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > >
> > > Can you actually boot a kernel on a Spreadtrum platform when all platform
> > > and driver support is modular?
> >
> > Yes, even if all drivers are modular.
> 
> Cool. No hard dependencies on e.g. regulators that are turned off when
> unused?
> 
> > But I hope serial can be builtin, then I can have a console to see
> > kernel output before loading modules.
> 
> No dependency on the clock driver?
> Oh, I see you have a hack in the serial driver, to assume default
> values when the serial port's parent clock is not found.  That may
> limit use of the other serial ports, depending on the actual serial
> hardware.
> And on Sharkl64, the serial port's clock is a fixed-clock anyway, so
> you don't even need the hack.
> 
> But in general you cannot rely on that, especially if your SoC has clock
> and/or power domains.
> 
> BTW, what about the watchdog driver? That one does need a clock, and
> loading it too late will reboot your system.
> 
> > Also, this's what Google GKI [1] asked :)
> >
> > Regards,
> > Chunyan
> >
> > [1] https://arstechnica.com/gadgets/2019/11/google-outlines-plans-for-mainline-linux-kernel-support-in-android/
> 
> Let's see how having everything modular works out on an SoC where all
> hardware is part of a clock and power domain.

I'm curious, are there any problems that we should be aware of? We know about
the regulator sync state and consumer-supplier dependencies. [1]

(Adding Saravana inline)

Thanks,
- ssp
