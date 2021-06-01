Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5134BC47080
	for <linux-serial@archiver.kernel.org>; Tue,  1 Jun 2021 04:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22B1861378
	for <linux-serial@archiver.kernel.org>; Tue,  1 Jun 2021 04:49:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232770AbhFAEvE (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 1 Jun 2021 00:51:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:35048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229521AbhFAEvD (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 1 Jun 2021 00:51:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 12B2D61005;
        Tue,  1 Jun 2021 04:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1622522961;
        bh=E6eMszyR4j43HLBX4pS6cALAerAGNXAaH9kUd/gzZFo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q5x13V+SKFxYk/dYvmAGs/sVqQ4W+yFASo4BLD0af2gMaXYKX9LADwF4VQIhAM/DB
         RqcQ8yXLSvtedE+pboogSjCxLbZZh4QhoEFtjjctFF4915RDR2D9MizKi8h4Y293Lq
         qKt7MzJcQbK2t/vNBl9Q+azSgOO3Re1pO+3hEhUE=
Date:   Tue, 1 Jun 2021 06:49:18 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Cc:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: Re: the usage of hardware flow control in serial console
Message-ID: <YLW8Th/dbKBs1Ntk@kroah.com>
References: <60B59E0F.7030609@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60B59E0F.7030609@fujitsu.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Jun 01, 2021 at 02:39:41AM +0000, xuyang2018.jy@fujitsu.com wrote:
> HI All
> 
> I append "console=ttyS0,115200n8r" to my kernel command line and reboot
> my system.
> 
> # cat /proc/tty/driver/serial
> serinfo:1.0 driver revision:
> 0: uart:16550A port:000003F8 irq:4 tx:0 rx:0 RTS|DTR
> 1: uart:unknown port:000002F8 irq:3
> 2: uart:unknown port:000003E8 irq:4
> 3: uart:unknown port:000002E8 irq:3
> 
> then I echo 1 > /dev/ttyS0, but it hangs.(If I don't use r, it works well.)

'echo' is horrible at testing serial port communication.  Why not use a
real serial terminal program that knows how to set the line settings?

> Does it need my console connected with other machine?

Something needs to be on the other end of that serial connection for
this to work properly, right?

> Also, many services become timeout when I use systemctl
> restart/status/stop(tx,rx data doesn't increase).
> 
> I just want to check whether it is a usage problem(my system environmet
> is centos8). My machine is physical machine and virtual machine doesn't
> have this problem(it has RTS|CTS|DTR|DSR|CD flag).

Why do you want to use "r" here?  What problem are you trying to solve?

thanks,

greg k-h
