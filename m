Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB12FE95A91
	for <linux-serial@archiver.kernel.org>; Mon,  9 Oct 2023 10:05:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346026AbjJIKFb (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 9 Oct 2023 06:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346045AbjJIKFa (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 9 Oct 2023 06:05:30 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36A0299
        for <linux-serial@vger.kernel.org>; Mon,  9 Oct 2023 03:05:28 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2bffd6c1460so50507691fa.3
        for <linux-serial@vger.kernel.org>; Mon, 09 Oct 2023 03:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696845926; x=1697450726; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qFG+CiAZlRg4OOl3cBMYm6ObwNj6T13IKlkez+l7sys=;
        b=M/RDmf1d3ZD6SdaLyBJvyBVT4KjON7mq4I0ex7QsQt+NcY6zO3DPXY+TY/bw6+o25J
         BdBmLiVfCyAnUUjduFdQGYMpK/yTIjce13efaPxglf0r+K830+2rAyfvba0V/na5T9F+
         QIxyL8aHEPYCZ+J891llrE0wOYEzCtoeruNwbXGLXZZamfZvzqQ9CJKklG5OXKgDuzr6
         5CjpuwuWrNP7V5dJ/c3uYJCex7RJnGBoNFeR26mamBUsL4GqE7Y/spAQnH/WG39XvpXh
         tCNH5ZMN5oRpSoe31vZ/l2Z8M1wVYXvkYtg8aiFGlvfRY5MmtF48d06hNGtuTKw/w3oh
         SJ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696845926; x=1697450726;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qFG+CiAZlRg4OOl3cBMYm6ObwNj6T13IKlkez+l7sys=;
        b=CwcIoZDMQKrhZGQbZxZWgwHBMk0DS3wDQ7yLV+pEOkru9j6j0SgiJ9HC2JSiDpKzTx
         L0i1NOG2FYzmCpgO3Ya0hLdfR1Wqq5Etugp4GPVV2CpfeclAjvYtqWTegpB1DoOZi1F4
         ni1jez5iTF/kCLtifc0fwJlXBR+/6x7QD1jpLCD/p8mL37TGpfc5RNXKWun3afryCT3J
         ZtYcxZt2m0rbMEGzOJTfJgcBu5wU4byKbBqrpdrTKlNy8RSel/xVizCAdJhdPMFbk2l2
         eoaRJSSJJVAdx0AuGbOnHySdIwnAHN9dYpY5g3Fxg/v1IEvhkYfK3txbywQy/Xjo854r
         1cVg==
X-Gm-Message-State: AOJu0YwoB2QAud7z6clX5cvPr2DBohSozBKQUBYpIS4dMsNhmcmllldP
        LFsidqGd9SJVBjKPt55v+5q70NqfzEiypQ/cAxs=
X-Google-Smtp-Source: AGHT+IGiDgo+rsW3vX/OG1IO4kHkeXBvv4m9x76xZ13hyIEnChIQOvMw7PZQzqbXZtaXuD2aoXZc6w==
X-Received: by 2002:a2e:9882:0:b0:2bd:a5:3560 with SMTP id b2-20020a2e9882000000b002bd00a53560mr12695521ljj.38.1696845926404;
        Mon, 09 Oct 2023 03:05:26 -0700 (PDT)
Received: from nuoska (dsl-olubng11-54f814-94.dhcp.inet.fi. [84.248.20.94])
        by smtp.gmail.com with ESMTPSA id y2-20020a2eb002000000b002c128e4524dsm1983944ljk.116.2023.10.09.03.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 03:05:25 -0700 (PDT)
Date:   Mon, 9 Oct 2023 13:05:23 +0300
From:   Mikko Rapeli <mikko.rapeli@linaro.org>
To:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Richard Purdie <richard.purdie@linuxfoundation.org>
Cc:     openembedded-core <openembedded-core@lists.openembedded.org>,
        Paul Gortmaker <p_gortmaker@yahoo.com>,
        Bruce Ashfield <bruce.ashfield@gmail.com>,
        Randy MacLeod <randy.macleod@windriver.com>
Subject: Kernel 6.5 ttyS1 hang with qemu (was Re: [OE-core] Summary of the
 remaining 6.5 kernel serial issue (and 6.5 summary)
Message-ID: <ZSPQY6UYg21Z0PnN@nuoska>
References: <178BF2895FF685E6.5378@lists.openembedded.org>
 <a2ad67a0575548b6d5d8d187e597dcd72ae07f64.camel@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a2ad67a0575548b6d5d8d187e597dcd72ae07f64.camel@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi linux-serial and Greg,

Yocto Linux distro maintainer Richard Purdie is seeing a regression or behavior
change after updating kernel from 6.4 to 6.5. Yocto runs a lot of automated tests with qemu
where a python test framework configures and spawns qemu (version 8.1) with two
serial ports and boots a newly built kernel and rootfs there. The python test framework
tries to detect getty login prompt from ttyS1 while boot time logging
from qemu, kernel, userspace etc happens on serial console ttyS0. This has worked
reliably for years and across multiple kernel versions. Now with 6.5 kernel there are
suddenly frequent failures where ttyS1 doesn't show the login prompt in the python code
which listens on the qemu socket from target system ttyS1. The target system ttyS0 is working
and boot time logs and getty prompt are visible there. The ttyS1 logs from test framework show
that only two characters CR and LF make it through. This same happens on x86_64 host
running qemu machine for x86_64 and arm64 targets.

The kernel boot logs from target system with 6.5.5 don't show any errors and getty
processes are started correctly and they don't see any errors either. Data from
target system userspace is being written, but seems to sometimes hang inside kernel
or qemu serial port buffers, and only on the ttyS1 while ttyS0 works reliably all
the time.

Example target logs with 6.5.5 via ttyS0:

https://autobuilder.yocto.io/pub/failed-builds-data/6.5%20kernel/j/qemu_boot_log.20231007084853
or https://pastebin.com/raw/jRRa2CwW

ttyS1 logs from the same run:
https://autobuilder.yocto.io/pub/failed-builds-data/6.5%20kernel/j/qemu_boot_log.20231007084853.2

Kernel config:
https://pastebin.com/raw/Lv9Hfeuh

Do you have any ideas or hints how to debug or possibly fix this?

tty layer has seen quite a few major changes between 6.4.14 and 6.5.5 and we're not able
to pinpoint or bisect the issue, since it so annoyingly rare.

Some more details from Richard below.

Cheers,

-Mikko

On Sun, Oct 08, 2023 at 09:23:57AM +0100, Richard Purdie wrote:
> On Sat, 2023-10-07 at 23:05 +0100, Richard Purdie via
> lists.openembedded.org wrote:
> > I thought I'd summarise where things are at with the 6.5 kernel.
> > 
> > We've fixed:
> > * the ARM LTP OOM lockup (kernel patch)
> > * the locale ARM selftest failure which was OOM due to silly buffer 
> >   allocations in 6.5 (kernel commandline)
> > * the ARM jitterentropy errors (kernel patch)
> > * the cryptodev build failures (recipe updated)
> > 
> > We've also:
> > * disabled the strace tests that fail with 6.5.
> > * made sure the serial ports and getty counts match
> > * added ttyrun which wraps serial consoles and avoids hacks
> > * made the qemurunner logging save all the port logs
> > * made the qemurunner write the binary data it is sent verbatim
> > * made sure to use nodelay on qemu's tcpserial
> > 
> > This leaves an annoying serial console problem where ttyS1 never has
> > the getty login prompt appear.
> > 
> > What we know:
> > 
> > * We've only seen this on x86 more recently (yesterday/today) but have
> > seen it on ARM in the days before that.
> > 
> > * It affects both sysvinit and systemd images.
> > 
> > * Systemd does print that it started a getty on ttyS0 and ttyS1 when
> > the failure occurs
> > 
> > * There is a getty running according to "ps" when the failure occurs
> > 
> > * There are only ever one or three characters received to ttyS1 in the
> > failure case (0x0d and 0x0a chars, i.e. CR and LF)
> > 
> > * It can't be any kind of utf-8 conversion issue since the login prompt
> > isn't visible in the binary log
> > 
> > * the kernel boot logs do show the serial port created with the same
> > ioport and irq on x86.
> > 
> > Previously we did see some logs with timing issues on the ttyS0 port
> > but the nodelay parameter may have helped with that.
> > 
> > There are debug patches in master-next against qemurunner which try and
> > poke around to gather more debug when things fail using ttyS0.
> > 
> > The best failure log we have is now this one:
> > 
> > https://autobuilder.yoctoproject.org/typhoon/#/builders/79/builds/5874/steps/14/logs/stdio
> > 
> > where I've saved the logs:
> > 
> > https://autobuilder.yocto.io/pub/failed-builds-data/6.5%20kernel/j/qemu_boot_log.20231007084853
> > and
> > https://autobuilder.yocto.io/pub/failed-builds-data/6.5%20kernel/j/qemu_boot_log.20231007084853.2
> > 
> > You can see ttyS1 times out after 1000 seconds and the port only has a
> > single byte (in the .2 file). The other log shows ps output showing the
> > getty running for ttyS1.
> > 
> > Ideas welcome on where from here. 
> > 
> > I've tweaked master-next to keep reading the ttyS1 port after we poke
> > it from ttyS0 to see if that reveals anything next time it fails (build
> > running).
> 
> Testing overnight with the new debug yielded:
> 
> https://autobuilder.yoctoproject.org/typhoon/#/builders/87/builds/5895/steps/14/logs/stdio
> 
> The interesting bit being:
> 
> """
> WARNING: core-image-full-cmdline-1.0-r0 do_testimage: Extra read data: 
> Poky (Yocto Project Reference Distro) 4.2+snapshot-
> 7cb4ffbd8380b0509d7fac9191095379af321686 qemux86-64 ttyS1
> 
> qemux86-64 login: helloA
> 
> Poky (Yocto Project Reference Distro) 4.2+snapshot-
> 7cb4ffbd8380b0509d7fac9191095379af321686 qemux86-64 ttyS1
> qemux86-64 login: 
> 
> """
> 
> i.e. the getty didn't appear in 1000s but sometime in shutdown the
> original prompt, the "helloA" and the new getty prompt did.
> 
> So the data *is* there but stuck in a buffer somehow. Kernel or qemu
> side, I don't know.
> 
> Cheers,
> 
> Richard
> 
> 
> 
> 
