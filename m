Return-Path: <SRS0=oHof=BM=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 227ABC433E0
	for <linux-serial@archiver.kernel.org>; Sun,  2 Aug 2020 10:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB31D2076B
	for <linux-serial@archiver.kernel.org>; Sun,  2 Aug 2020 10:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596365907;
	bh=MOrzMj2W55UJKJyvuXI+G/4EBNaq8w1o1Kkvy6T/r2k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=saHItqmYh+x17ECuTRQckwJpewvzgkBoBzOPl3vrxRuqjT6MCT8OZdu/ECLqdyviI
	 6GdRKeESIwYnQl8vJ4a/Xm+7XdLRCst4hFLuJ0b6INjJ2Z16UGgx+gWk5JllzuKEPu
	 mGljoif41b3OyoGNKmV7049WEZV3VfhnloINC5vE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbgHBK60 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 2 Aug 2020 06:58:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:36828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726765AbgHBK60 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sun, 2 Aug 2020 06:58:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 136C020738;
        Sun,  2 Aug 2020 10:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596365905;
        bh=MOrzMj2W55UJKJyvuXI+G/4EBNaq8w1o1Kkvy6T/r2k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JzBSDUgWdyzOLKpSKMOlE16XUzUVspN0ZmE9otAJGyosykI2/eLOjQSykhqPY0vgw
         f7D7uP/xQ2VXsJlsivi6B+zgfOaGvVrLO3hV2OAn19dIKlYHM4l0Ndl4ft2padKoKZ
         s2cUzeqK0bwnClj3LrW9rKKsJwYIONXivcrj+rlQ=
Date:   Sun, 2 Aug 2020 12:58:08 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     kernel test robot <lkp@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        lkp@lists.01.org
Subject: Re: [serial] 679193b7ba: BUG:spinlock_bad_magic_on_CPU
Message-ID: <20200802105808.GA164531@kroah.com>
References: <20200802054852.GR23458@shao2-debian>
 <CAHp75Vcdwz2RynZ0KVCDMFyO_GPREgGdCNVNGqosjf6iV0_uog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vcdwz2RynZ0KVCDMFyO_GPREgGdCNVNGqosjf6iV0_uog@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sun, Aug 02, 2020 at 01:50:29PM +0300, Andy Shevchenko wrote:
> On Sun, Aug 2, 2020 at 8:54 AM kernel test robot <lkp@intel.com> wrote:
> >
> > Greeting,
> >
> > FYI, we noticed the following commit (built with gcc-9):
> >
> > commit: 679193b7baf8d88e41cbeb397ca17f797654947d ("serial: 8250: Let serial core initialise spin lock")
> > https://git.kernel.org/cgit/linux/kernel/git/gregkh/tty.git tty-next
> >
> >
> > in testcase: boot
> >
> > on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> >
> > caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> >
> >
> > +-------------------------------+------------+------------+
> > |                               | f3af1b68fc | 679193b7ba |
> > +-------------------------------+------------+------------+
> > | boot_successes                | 4          | 0          |
> > | boot_failures                 | 0          | 4          |
> > | BUG:spinlock_bad_magic_on_CPU | 0          | 4          |
> > +-------------------------------+------------+------------+
> >
> >
> > If you fix the issue, kindly add following tag
> > Reported-by: kernel test robot <lkp@intel.com>
> 
> Thanks for the report. I didn't see it on real hardware though. Maybe
> because of timing (race?) differences.
> 
> Greg, I think the best is to revert the change until I will have better one.

Can you send me a revert patch with the reported-by: set up?

thanks,

greg k-h
