From: Anton Vorontsov <anton.vorontsov@linaro.org>
Subject: Re: [tty:tty-next 36/40] kernel/debug/kdb/kdb_main.c:2839:4:
 warning: passing argument 2 of 'kdb_register_repeat' from incompatible
 pointer type
Date: Wed, 26 Sep 2012 19:52:42 -0700
Message-ID: <20120927025242.GA10435@lizard>
References: <20120927012916.GA9207@localhost>
 <20120927013930.GA27336@lizard>
 <20120927021119.GA29097@lizard>
 <20120927023647.GA12399@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:46519 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753806Ab2I0CzZ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 26 Sep 2012 22:55:25 -0400
Received: by pbbrr4 with SMTP id rr4so2852804pbb.19
        for <linux-serial@vger.kernel.org>; Wed, 26 Sep 2012 19:55:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120927023647.GA12399@localhost>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Fengguang Wu <fengguang.wu@intel.com>
Cc: Yuanhan Liu <yuanhan.liu@intel.com>, kernel-janitors@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, Jason Wessel <jason.wessel@windriver.com>

On Thu, Sep 27, 2012 at 10:36:47AM +0800, Fengguang Wu wrote:
[...]
> > I suspect there are some toolchain issues, or arch/cris/ does something
> > weird with the build system.
> 
> Ah silly me! I'm doing "make M=kernel/debug/kdb" which leads to all
> the error/warnings. This can be fixed trivially. :)

:-)

That explains it.

> > Also, "arch/cris/arch-v32/kernel/kgdb.c" -- it seems like it is its own
> > implementation of KGDB. :-) But it's CONFIG_ETRAX_KGDB...
> 
> Doing the regular 'make' triggers these errors:
> 
> arch/cris/arch-v10/kernel/kgdb.c:1273:6: warning: missing terminating " character [enabled by default]

Yup, as I said, arch/cris/arch-v10/kernel/kgdb.c have nothing to do with
kernel/debug/'s KGDB/KDB stuff. It seem to be a very-very old, completely
separate implementation of GDB protocol.

Thanks,
Anton.
