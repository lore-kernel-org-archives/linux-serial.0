From: Anton Vorontsov <anton.vorontsov@linaro.org>
Subject: Re: [tty:tty-next 36/40] kernel/debug/kdb/kdb_main.c:2839:4:
 warning: passing argument 2 of 'kdb_register_repeat' from incompatible
 pointer type
Date: Wed, 26 Sep 2012 18:39:33 -0700
Message-ID: <20120927013930.GA27336@lizard>
References: <20120927012916.GA9207@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:57290 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753614Ab2I0BmU (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 26 Sep 2012 21:42:20 -0400
Received: by pbbrr4 with SMTP id rr4so2771765pbb.19
        for <linux-serial@vger.kernel.org>; Wed, 26 Sep 2012 18:42:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120927012916.GA9207@localhost>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Fengguang Wu <fengguang.wu@intel.com>
Cc: Yuanhan Liu <yuanhan.liu@intel.com>, kernel-janitors@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, Jason Wessel <jason.wessel@windriver.com>

On Thu, Sep 27, 2012 at 09:29:16AM +0800, Fengguang Wu wrote:
> FYI, there are new compile warnings show up in
> 
> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-next
> head:   0c57dfcc6c1d037243c2f8fbf62eab3633326ec0
> commit: 729043e82cdd403a131127254528afea8031ebab [36/40] kdb: Turn KGDB_KDB=n stubs into static inlines
> config: cris-allyesconfig
> 
> All warnings (together with lots of *old* errors):

As we switched from empty macros to proper type-checking functions, the
new warnings most probably are all OK, but just to be sure...

Which are the new warnings? Do you have old build logs to compare?

And KDB is (and was) obviously broken for cris, should we disable it via
Kconfig?

Thanks,
Anton.
