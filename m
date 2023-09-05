Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A99DCA0FE2
	for <linux-serial@archiver.kernel.org>; Tue,  5 Sep 2023 16:34:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240935AbjIEQec (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 5 Sep 2023 12:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354922AbjIEPzb (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 5 Sep 2023 11:55:31 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0C4D512A
        for <linux-serial@vger.kernel.org>; Tue,  5 Sep 2023 08:55:27 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 2917F809E;
        Tue,  5 Sep 2023 15:55:26 +0000 (UTC)
Date:   Tue, 5 Sep 2023 18:55:24 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Matthew Howell <matthew.howell@sealevel.com>
Cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        ryan.wenglarz@sealevel.com, james.olson@sealevel.com
Subject: Re: [PATCH] serial: Revert serial: core: Fix serial core port id to
 not use port->line
Message-ID: <20230905155524.GR11662@atomide.com>
References: <98a891fd-5a1f-6568-a12c-28577126a42@sealevel.com>
 <20230829035245.GF11662@atomide.com>
 <511f2dcf-f637-695-8e81-8eaa3735ba88@sealevel.com>
 <20230829201557.GK11662@atomide.com>
 <472581f-e7f6-6cc-c749-5be16e4fe9af@sealevel.com>
 <20230901044730.GL11662@atomide.com>
 <e8579280-2f44-a585-a3b8-98fad29e6a2d@sealevel.com>
 <20230902043424.GM11662@atomide.com>
 <c4b1db31-7814-0d22-36de-a7e6f117d89c@sealevel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4b1db31-7814-0d22-36de-a7e6f117d89c@sealevel.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

* Matthew Howell <matthew.howell@sealevel.com> [230905 15:05]:
> On Sat, 2 Sep 2023, Tony Lindgren wrote:
> > OK. If the patch did not apply against v6.5, can you please verify you don't
> > have other patches applied like your revert? I don't think the patch I sent
> > is white space damanged or anything. Doing git diff v6.5.. should show you
> > what might be different :)
> 
> It shouldn't have had any patches applied to. Just verified again by 
> running git diff after pulling the v6.5 branch, but git diff shows no 
> differences. 
> 
> I suspect alpine may be mangling the text on my end in some way. If I 
> apply the changes manually and then run git diff v6.5 the patch looks the 
> same as what you provided, but tab/spaces are different.

OK thanks for checking.

> > Not sure what you mean with the 8250 entries from before loading the
> > patched driver..
> > 
> > Maybe things go wrong already somewhere earlier if the integrated 8250
> > port(s) don't show up either? If so, maybe this issue is somehow machine
> > specific rather than 8250_exar specific.
> 
> I should have been more specific there. I was actually referring to 
> 8250_exar entries, not 8250 entries. I have not had any issues with the 
> base 8250 driver loading.

Ah OK sorry I misunderstood.

> HOWEVER, I did just find something very interesting. When I first found 
> the issue my running kernel was still an RC version (6.5-RC4, I 
> believe). The issue did NOT occur in the running kernel, or when building 
> 8250_exar from the 6.5-RC4 source. I expected the issue to exist in the 
> running kernel after I updated to 6.5, but this is NOT the the case. 
> XR17V35X devices still work in my running kernel. It is only when I build 
> from source AND the source contains the port_id changes that the issue 
> occurs. My current kernel is 6.5.0-1-MANJARO. 
> 
> Could I be doing something wrong here that for some reason only
> manifests itself in combination with the port_id change? 
> 
> The only things I can think of are:
> 1) insmod does not account for dependencies, so in theory I could be 
> failing to build and load some other required module. However, modprobe 
> indicates 8250_exar has no dependencies, so I didn't think this should be 
> an issue.

If you are not using modprobe, and have CONFIG_SERIAL_CORE=m, you
need to load serial_base.ko. I don't think we can build the core stuff as
as serial_core.ko without renaming serial_core.c to something else. Looks
like your config has SERIAL_CORFE built-in though, and without the serial
core stuff you'd likely get "Unknown symbol in module" error loading
8250_exar.

> 2) The Arch/Manjaro Kernel I am running does not actually have the port_id 
> change, even though it should. Do you know of an a wy to determine this?

Well I guess you could check the patches applied to that kernel, but
presumably it's v6.5 for that part.

> The general build procedure I have been using is:
> 
> ## Clone v6.5 tagged kernel source
> git clone --depth=1 https://github.com/torvalds/linux.git --branch v6.5
> 
> ## Link symvers
> ln -s /usr/lib/modules/$(uname -r)/build/Module.symvers . 
> 
> ## Copy existing config
> zcat /proc/config.gz > .config
> 
> ## Make sure 8250_exar is built as a module. Disable auto-version.
> sed -i '/CONFIG_SERIAL_8250_EXAR=/c\CONFIG_SERIAL_8250_EXAR=m' .config
> sed -i '/CONFIG_LOCALVERSION_AUTO=/c\CONFIG_LOCALVERSION_AUTO=n' .config
> sed -i '/CONFIG_LOCALVERSION=/c\CONFIG_LOCALVERSION=""' .config
> make modules_prepare LOCALVERSION=-MANJARO EXTRAVERSION=-1
> 
> ## Apply patch, if applicable
> patch -p1 < patch.diff
> 
> ## Build and load module
> make M=drivers/tty/serial/8250/
> sudo rmmod 8250_exar

Maybe check if rmmod 8250_exar now somehow causes the following insmod
8250_exar attempts to fail?

> sudo insmod drivers/tty/serial/8250/8250_exar.ko
> 
> > Can you please post or email me your full working dmesg output, failing
> > dmesg output, the kernel .config used, and kernel command line?
> 
> ---
> Kernel Command Line:
> quiet splash resume=UUID=46a37dda-0d60-4ed1-94ea-9219fbe85dde udev.log_priority=3 iomem=relaxed
> ---
> 
> ---
> dmesg start
> Note: Everything before [ 1149.943049] is prior to loading the module 
> built from source. The successful version looks the same, except instead 
> of the error message I see the same ttyS4 and ttyS5 at MMIO... messages 
> that appeared before. 

OK yeah thanks, not seeing anything wrong early in the dmesg.

Regards,

Tony
