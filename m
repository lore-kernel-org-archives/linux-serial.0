Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56177CDB482
	for <linux-serial@archiver.kernel.org>; Mon, 16 Oct 2023 05:59:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjJPF7U (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 16 Oct 2023 01:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjJPF7T (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 16 Oct 2023 01:59:19 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4CFB95
        for <linux-serial@vger.kernel.org>; Sun, 15 Oct 2023 22:59:15 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-5079f9ec8d9so2489488e87.0
        for <linux-serial@vger.kernel.org>; Sun, 15 Oct 2023 22:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697435954; x=1698040754; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=e1K8EV2wJAuoZpfkUmMNPwyo7c1WmKE207qR09Xkxas=;
        b=IH3dsy7+is9PPsFXJjXChxuXZlNTQN2SqqgXvuZ7BEf6pLvh/hSRR6Bp3Q9NPwZDA9
         N44E9S/nZ/79h99bshrNgHV/zIMy2y1xyRIgyhPSh84d+hlv+ePEG1H+V/gpcbZ/oUuf
         HHMZdnU+KYS5NxFlucscs9BS1VCEnhYswVaHSW/5OMJgqOrgmjCeAS2yPOpUL4YBv09B
         lyKwOzHmJ/FKktJNGihrfJE05zXjgwO99BP3EZwLAiFg6fxijjJyEZJVN9f07Rghl9IG
         WEr0E+/b3x5fdainkJpYgQnbjfw/1kGjAMJj1UEe8i/wb3SEAb80R09yCMcn60e1pQL8
         hLyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697435954; x=1698040754;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e1K8EV2wJAuoZpfkUmMNPwyo7c1WmKE207qR09Xkxas=;
        b=SNQlLm+frrCCDiqBS0/FUQtP+PjI4iup5Ny2lh4Ol/SDtPa7dIGeC0YRaJ0BZ2x/8w
         OxmB5maUbBtvhnyAzyX6Esn3ldA8YsXKZrhjUV8LkoPcV+iywM9o1yvMBQjSgLNrG1KP
         zzNoYp2qt1JPh12PvRppwTTIjdxw9vcnMGEsGH4MLqK8LyA1r0RZnJQ9Ry/TQKr80DNf
         1CUykTYPwZVOF8/aWykPDgoDcbjNkPDwM3ewkZWa+Q4GGRZJmOppeOAzh4Br58Gha+31
         R+ppDlss1DLeImeul5YHaF+0N8TylqN/5puisajEBtO6m1JJkpowxGKuQEkUEv+sYMEV
         sVoQ==
X-Gm-Message-State: AOJu0YyKVzZtXSJhupyu4VaGI7+2Qy3DxsM9n9/vOBc+VXUSLc2z9bwI
        S0/Ubf/jeE8gIcLkXYYvNn0KdQY14HiKD7kC4W4=
X-Google-Smtp-Source: AGHT+IE7oVo8IzPmQSohdM2EJ/OwOMFMeJ6U1EDvPfOjxCxyH56jp+Czng47vRQkkZayjKNtMXPYkw==
X-Received: by 2002:a19:7618:0:b0:500:7aba:4d07 with SMTP id c24-20020a197618000000b005007aba4d07mr4141342lff.22.1697435953853;
        Sun, 15 Oct 2023 22:59:13 -0700 (PDT)
Received: from nuoska (dc7g6tyyyyyyyyyyyyhlt-3.rev.dnainternet.fi. [2001:14ba:16cb:a800::193])
        by smtp.gmail.com with ESMTPSA id j11-20020a056512344b00b004f13cd61ebbsm1411594lfr.175.2023.10.15.22.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Oct 2023 22:59:13 -0700 (PDT)
Date:   Mon, 16 Oct 2023 08:59:07 +0300
From:   Mikko Rapeli <mikko.rapeli@linaro.org>
To:     linux-serial@vger.kernel.org
Cc:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Richard Purdie <richard.purdie@linuxfoundation.org>,
        openembedded-core <openembedded-core@lists.openembedded.org>,
        Paul Gortmaker <p_gortmaker@yahoo.com>,
        Bruce Ashfield <bruce.ashfield@gmail.com>,
        Randy MacLeod <randy.macleod@windriver.com>
Subject: Re: Kernel 6.5 ttyS1 hang with qemu (was Re: [OE-core] Summary of
 the remaining 6.5 kernel serial issue (and 6.5 summary)
Message-ID: <ZSzRK-aR04AhUuwc@nuoska>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZSlfF+2cEHb8nUwO@windriver.com>
 <178C6861D9B097E8.24994@lists.openembedded.org>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,

Thanks a lot Paul! Updating linux-serial that bisection shows

84a9582fd203 serial: core: Start managing serial controllers to enable runtime PM

caused this regression in ttyS1 functionality with qemu.

Lots of more details below.

Cheers,

-Mikko

On Fri, Oct 13, 2023 at 11:15:35AM -0400, Paul Gortmaker wrote:
> So, here is an update for those not following on IRC:
> 
> [Re: [OE-core] Summary of the remaining 6.5 kernel serial issue (and 6.5 summary)] On 11/10/2023 (Wed 00:50) Paul Gortmaker wrote:
> 
> [snip details of getting RP's chunk of AB python working as a 1% reproducer]
> 
> > Next steps:
> > 
> > Each run takes approximately 20s, and with a 1.5% success factor, a
> > minimum of 150 clean runs is needed before one can say "OK, *maybe* this
> > kernel currently under test is OK.  That translates to over an hour to
> > get a data point you have some faith in as being "good".  [Still a heck
> > of a lot better than doing 150 *builds* though!]
> > 
> > On the other hand, just one instance of missing login on ttyS1 is
> > concretely "bad" and hence the test run can be stopped as soon as one
> > instance of that is seen.
> > 
> > This "good is really maybe perhaps good, but bad is for sure bad" type
> > of bisects that I love to hate.
> > 
> > Since the data points are "expensive", I probably won't just attempt a
> > mindless brute force bisect.  I'd probably do something more like...
> > 
> > --ensure modules (or lack of) don't impact the results, so I don't have
> >   to rebundle rootfs images.
> 
> This turned out to be true - didn't need modules.
> 
> > --maybe see if I can build with host gcc vs. using devshell/sysroot gcc
> >   and still see the issue.  Although really, kernel build time optimization
> >   won't be the bottleneck in this particular case, so not worthwhile?
> 
> I didn't bother with the above, since build time was not significant here.
> 
> > --check vanilla v6.5 (i.e. v6.5.0 -- no linux-stable content) so I know
> >   whether to dig around in v6.5.0 --> v6.5.5, or dig around in the
> >   much much larger v6.4 --> v6.5 additions.  I expect it to be the
> >   latter, i.e. digging through mainline, but who knows.
> 
> As expected, it followed v6.5.0 and linux-stable isn't to blame here.
> 
> > --assuming mainline introduced it, instead of a brute force bisect, I'd
> >   look for merges by Linus from gregKH pull requests for the tty and
> >   serial subsystems in the merge window (v6.4 ---> v6.5-rc1) and test
> >   both sides of that/those merge(s).
> 
> This also largely went according to plan. I started with the tty merge:
> 
> v6.5-rc1~74:
> 868a9fd94807 Merge tag 'tty-6.5-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty
> 
> and did burrow down into the 60-odd commits within.  One complication
> was that there were interim mainline merges into the dev stream:
> 
> $ git log --oneline --merges v6.5-rc1~74^2  ^v6.5-rc1~74^1
> 2076b2a4a6b7 Merge 6.4-rc5 into tty-next
> 0e4daea31d83 Merge 6.4-rc3 into tty-next
> 
> ..which usually indicate a dependency on work from another subsystem.
> Fortunately the test pass/fail boundary didn't land on one of those.
> 
> > --if things haven't completely fallen apart by that point, I'd be left
> >   with a relatively small set of subsystem specific commits from a single
> >   pull request which then could be bisected.
> 
> We did somehow manage to get here with just 60 commits to consider.
> 
> > 
> > Sometimes in the past, when I've got down to that small set of commits,
> > the culprit almost jumps out at you when scanning over the shortlogs.
> 
> While I didn't immediately spot the commit via the shortlog, extensive
> test iterations did give us confidence in pinpointing a single commit:
> 
> 84a9582fd203 serial: core: Start managing serial controllers to enable runtime PM       *******         <---- FAIL (33/1436)
> ae62c49c0cef serial: 8250: omap: convert to modern PM ops                                               <---- PASS (0/1593)
> 
> > Anyway, that is where my thoughts are at.  But of course we don't even
> > yet know if this "test" is even accurately reflecting the OEQA/AB issue!
> > So nobody should get their hopes up too early.
> 
> I think now, we can say with a solid degree of confidence that the PM
> commit gets to own the responsibility of causing the ttyS1 getty not
> flushing the login banner and prompt.  Hence why I did over 1000 runs on
> both the PASS and FAIL commit boundary.
> 
> Unfortunately, there is a lot in that commit ; also a lot in the
> discussion and the twelve iterations before acceptance that I've not
> even looked at yet:
> 
> https://lore.kernel.org/linux-serial/1431f5b4-fb39-483b-9314-ed2b7c118c11@gmail.com/T/#t
> 
> My "next steps" at this point would be to try and attempt to break down
> that relatively large commit into multiple "sub-commits" in order to use
> the AB test harness portion to better get an idea of which change
> component is the root cause of the ttyS1 getty stall/seizure.
> 
> I won't get to that until Saturday at the earliest - going AFK after
> sending this.  However, Mikko already opened a dialog with the
> linux-serial folks a few days ago:
> 
> https://lore.kernel.org/all/ZSPQY6UYg21Z0PnN@nuoska/
> 
> Mikko -- if you want to take our pseudo bisect information (below) and
> continue that thread; sharing what we've learned since, and also loop in
> Tony (author of v6.4-rc3-31-g84a9582fd203) and others on the CC there,
> that might be a good next step to do now, while I am AFK.
> 
> A quick technical note on testing - all my kernels have been built in
> the same devshell instance, so same path, same compiler, same ".config",
> same "test harness" from RP, same qemu, same underlying machine.  Both
> Richcard and I have also found that loading on the host machine running
> the qemu binary (ubu 20.04 default in my case) influences the rate of
> incidence - an otherwise idle machine is less likely to show the issue
> vs a machine that has other things going on -- indicating a qemu
> scheduling component influences the incident rate.
> 
> Paul.
> --
> 
> Note asterik "*****" marking suspect commit.
> 
> v6.5.7													<---- FAIL (2/188)
> v6.5.5													<---- FAIL (13/1039)
> v6.5.0													<---- FAIL (6/422)
> v6.5-rc1												<---- FAIL (2/230)
> 
> v6.5-rc1~74:
> 868a9fd94807 Merge tag 'tty-6.5-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty
> 
> $git log --oneline v6.5-rc1~74^2  ^v6.5-rc1~74^1
> e534756c9412 tty_audit: make data of tty_audit_log() const						<---- FAIL (3/266)
> e64ed44bce43 tty_audit: make tty pointers in exposed functions const
> 3e540a7bad85 tty_audit: make icanon a bool
> 94f94810efc4 tty_audit: invert the condition in tty_audit_log()
> e1488513abee tty_audit: use kzalloc() in tty_audit_buf_alloc()
> 777e456852f7 tty_audit: use TASK_COMM_LEN for task comm
> a82d62f70854 Revert "8250: add support for ASIX devices with a FIFO bug"
> 27a826837ec9 serial: atmel: don't enable IRQs prematurely
> 930cbf92db01 tty: serial: Add Nuvoton ma35d1 serial driver support
> e0edfdc15863 tty: serial: fsl_lpuart: add earlycon for imx8ulp platform
> 639949a7031e tty: serial: imx: fix rs485 rx after tx
> e8cc334847db selftests: tty: add selftest for tty timestamp updates
> 360c11e2258c tty: tty_io: update timestamps on all device nodes
> 4903fde8047a tty: fix hang on tty device with no_room set
> cef09673c35b serial: core: fix -EPROBE_DEFER handling in init
> 20a41a62618d serial: 8250_omap: Use force_suspend and resume for system suspend
> f3710f5e9e1a tty: serial: samsung_tty: Use abs() to simplify some code
> 832e231cff47 tty: serial: samsung_tty: Fix a memory leak in s3c24xx_serial_getclk() when iterating clk
> a9c09546e903 tty: serial: samsung_tty: Fix a memory leak in s3c24xx_serial_getclk() in case of error
> d9f59caf94a9 serial: 8250: Apply FSL workarounds also without SERIAL_8250_CONSOLE
> 1eea99c04555 powerpc/legacy_serial: Handle SERIAL_8250_FSL=n build failures
> 52861a3be8d6 serial: core: don't kfree device managed data
> b6c7ff2693dd serial: 8250_mtk: Simplify clock sequencing and runtime PM
> 643662d12bc2 serial: st-asc: fix typo in property name
> 66eff0ef528b powerpc/legacy_serial: Warn about 8250 devices operated without active FSL workarounds
> 2076b2a4a6b7 Merge 6.4-rc5 into tty-next								<---- FAIL (2/145)
> 49c80922ff81 serial: core: Fix error handling for serial_core_ctrl_device_add()				<---- FAIL (6/992)
> 539914240a01 serial: core: Fix probing serial_base_bus devices						<---- FAIL (3/145)
> d0a396083e91 serial: core: Don't drop port_mutex in serial_core_remove_one_port
> 84a9582fd203 serial: core: Start managing serial controllers to enable runtime PM	*******		<---- FAIL (33/1436)
> ae62c49c0cef serial: 8250: omap: convert to modern PM ops						<---- PASS (0/1593)
> c53aab207622 serial: 8250: omap: Move uart_write() inside PM section
> d2d4bd217ccd serial: 8250-fsl: Expand description of the MPC83xx UART's misbehaviour
> 1b997aef4f54 serial: Indicate fintek option may also be required for RS232 support
> 20ec397d694b tty: serial: fsl_lpuart: Check the return value of dmaengine_tx_status			<---- PASS (0/316)
> 0d07703be74f serial: Switch i2c drivers back to use .probe()
> d0b309a5d3f4 serial: 8250: synchronize and annotate UART_IER access
> 25614735a647 serial: 8250: lock port for UART_IER access in omap8250_irq()
> 8b45503776b6 serial: 8250: lock port for omap8250_restore_regs()
> 87660fb4041f serial: 8250: lock port for rx_dma() callback
> 51e45fba14bf serial: core: lock port for start_rx() in uart_resume_port()
> ca73a892c5be serial: 8250: lock port for stop_rx() in omap8250_irq()
> abcb0cf1f5b2 serial: core: lock port for stop_rx() in uart_suspend_port()
> b1207d86169d serial: 8250: lock port in startup() callbacks
> 0e4daea31d83 Merge 6.4-rc3 into tty-next
> d5b3d02d0b10 serial: Make uart_remove_one_port() return void
> 6bd6cd29c924 serial: stm32: Ignore return value of uart_remove_one_port() in .remove()
> 72fc578b220c serial: 8250_rt288x: Remove unnecessary UART_REG_UNMAPPED
> 33e3b0eb7550 serial: 8250_rt288x: Name non-standard divisor latch reg
> b334214ea08d serial: 8250: RT288x/Au1xxx code away from core
> 30c61f53fdf2 serial: 8250: Add dl_read/write, bugs and mapsize into plat_serial8250_port
> 98658ae8f392 serial: 8250: Document uart_8250_port's ->dl_read/write()
> b245aa0cc583 serial: 8250: Change dl_read/write to handle value as u32
> 9d86719f8769 serial: 8250: Allow using ports higher than SERIAL_8250_RUNTIME_UARTS
> db86bb6ed497 serial: 8250: omap: Shut down on remove for console uart
> fef4f600319e serial: 8250: omap: Fix life cycle issues for interrupt handlers
> 398cecc24846 serial: 8250: omap: Fix imprecise external abort for omap_8250_pm()
> b9ab22c2bc86 serial: 8250: omap: Fix freeing of resources on failed register
> 6d8c1fca0a6e serial: pl011: set UART011_CR_RXE in pl011_set_termios after port shutdown
> cf9aa72d2f91 tty: serial: fsl_lpuart: optimize the timer based EOP logic
> 
> Baseline of tty queue for v6.5 was:
> $git show --oneline --stat cf9aa72d2f91~
> ac9a78681b92 (tag: v6.4-rc1) Linux 6.4-rc1
>  Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Have also 1000+ runs on Yocto's v6.4.16 based kernel with no fails.

On Mon, Oct 09, 2023 at 01:05:23PM +0300, Mikko Rapeli via lists.openembedded.org wrote:
> Hi linux-serial and Greg,
> 
> Yocto Linux distro maintainer Richard Purdie is seeing a regression or behavior
> change after updating kernel from 6.4 to 6.5. Yocto runs a lot of automated tests with qemu
> where a python test framework configures and spawns qemu (version 8.1) with two
> serial ports and boots a newly built kernel and rootfs there. The python test framework
> tries to detect getty login prompt from ttyS1 while boot time logging
> from qemu, kernel, userspace etc happens on serial console ttyS0. This has worked
> reliably for years and across multiple kernel versions. Now with 6.5 kernel there are
> suddenly frequent failures where ttyS1 doesn't show the login prompt in the python code
> which listens on the qemu socket from target system ttyS1. The target system ttyS0 is working
> and boot time logs and getty prompt are visible there. The ttyS1 logs from test framework show
> that only two characters CR and LF make it through. This same happens on x86_64 host
> running qemu machine for x86_64 and arm64 targets.
> 
> The kernel boot logs from target system with 6.5.5 don't show any errors and getty
> processes are started correctly and they don't see any errors either. Data from
> target system userspace is being written, but seems to sometimes hang inside kernel
> or qemu serial port buffers, and only on the ttyS1 while ttyS0 works reliably all
> the time.
> 
> Example target logs with 6.5.5 via ttyS0:
> 
> https://autobuilder.yocto.io/pub/failed-builds-data/6.5%20kernel/j/qemu_boot_log.20231007084853
> or https://pastebin.com/raw/jRRa2CwW
> 
> ttyS1 logs from the same run:
> https://autobuilder.yocto.io/pub/failed-builds-data/6.5%20kernel/j/qemu_boot_log.20231007084853.2
> 
> Kernel config:
> https://pastebin.com/raw/Lv9Hfeuh
> 
> Do you have any ideas or hints how to debug or possibly fix this?
> 
> tty layer has seen quite a few major changes between 6.4.14 and 6.5.5 and we're not able
> to pinpoint or bisect the issue, since it so annoyingly rare.
> 
> Some more details from Richard below.
> 
> Cheers,
> 
> -Mikko
> 
> On Sun, Oct 08, 2023 at 09:23:57AM +0100, Richard Purdie wrote:
> > On Sat, 2023-10-07 at 23:05 +0100, Richard Purdie via
> > lists.openembedded.org wrote:
> > > I thought I'd summarise where things are at with the 6.5 kernel.
> > > 
> > > We've fixed:
> > > * the ARM LTP OOM lockup (kernel patch)
> > > * the locale ARM selftest failure which was OOM due to silly buffer 
> > >   allocations in 6.5 (kernel commandline)
> > > * the ARM jitterentropy errors (kernel patch)
> > > * the cryptodev build failures (recipe updated)
> > > 
> > > We've also:
> > > * disabled the strace tests that fail with 6.5.
> > > * made sure the serial ports and getty counts match
> > > * added ttyrun which wraps serial consoles and avoids hacks
> > > * made the qemurunner logging save all the port logs
> > > * made the qemurunner write the binary data it is sent verbatim
> > > * made sure to use nodelay on qemu's tcpserial
> > > 
> > > This leaves an annoying serial console problem where ttyS1 never has
> > > the getty login prompt appear.
> > > 
> > > What we know:
> > > 
> > > * We've only seen this on x86 more recently (yesterday/today) but have
> > > seen it on ARM in the days before that.
> > > 
> > > * It affects both sysvinit and systemd images.
> > > 
> > > * Systemd does print that it started a getty on ttyS0 and ttyS1 when
> > > the failure occurs
> > > 
> > > * There is a getty running according to "ps" when the failure occurs
> > > 
> > > * There are only ever one or three characters received to ttyS1 in the
> > > failure case (0x0d and 0x0a chars, i.e. CR and LF)
> > > 
> > > * It can't be any kind of utf-8 conversion issue since the login prompt
> > > isn't visible in the binary log
> > > 
> > > * the kernel boot logs do show the serial port created with the same
> > > ioport and irq on x86.
> > > 
> > > Previously we did see some logs with timing issues on the ttyS0 port
> > > but the nodelay parameter may have helped with that.
> > > 
> > > There are debug patches in master-next against qemurunner which try and
> > > poke around to gather more debug when things fail using ttyS0.
> > > 
> > > The best failure log we have is now this one:
> > > 
> > > https://autobuilder.yoctoproject.org/typhoon/#/builders/79/builds/5874/steps/14/logs/stdio
> > > 
> > > where I've saved the logs:
> > > 
> > > https://autobuilder.yocto.io/pub/failed-builds-data/6.5%20kernel/j/qemu_boot_log.20231007084853
> > > and
> > > https://autobuilder.yocto.io/pub/failed-builds-data/6.5%20kernel/j/qemu_boot_log.20231007084853.2
> > > 
> > > You can see ttyS1 times out after 1000 seconds and the port only has a
> > > single byte (in the .2 file). The other log shows ps output showing the
> > > getty running for ttyS1.
> > > 
> > > Ideas welcome on where from here. 
> > > 
> > > I've tweaked master-next to keep reading the ttyS1 port after we poke
> > > it from ttyS0 to see if that reveals anything next time it fails (build
> > > running).
> > 
> > Testing overnight with the new debug yielded:
> > 
> > https://autobuilder.yoctoproject.org/typhoon/#/builders/87/builds/5895/steps/14/logs/stdio
> > 
> > The interesting bit being:
> > 
> > """
> > WARNING: core-image-full-cmdline-1.0-r0 do_testimage: Extra read data: 
> > Poky (Yocto Project Reference Distro) 4.2+snapshot-
> > 7cb4ffbd8380b0509d7fac9191095379af321686 qemux86-64 ttyS1
> > 
> > qemux86-64 login: helloA
> > 
> > Poky (Yocto Project Reference Distro) 4.2+snapshot-
> > 7cb4ffbd8380b0509d7fac9191095379af321686 qemux86-64 ttyS1
> > qemux86-64 login: 
> > 
> > """
> > 
> > i.e. the getty didn't appear in 1000s but sometime in shutdown the
> > original prompt, the "helloA" and the new getty prompt did.
> > 
> > So the data *is* there but stuck in a buffer somehow. Kernel or qemu
> > side, I don't know.
> > 
> > Cheers,
> > 
> > Richard
> > 
> > 
> > 
> > 

> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#188831): https://lists.openembedded.org/g/openembedded-core/message/188831
> Mute This Topic: https://lists.openembedded.org/mt/101849211/7159507
> Group Owner: openembedded-core+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/openembedded-core/unsub [mikko.rapeli@linaro.org]
> -=-=-=-=-=-=-=-=-=-=-=-
> 

