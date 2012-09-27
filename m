From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [tty:tty-next 36/40] kernel/debug/kdb/kdb_main.c:2839:4:
 warning: passing argument 2 of 'kdb_register_repeat' from incompatible
 pointer type
Date: Wed, 26 Sep 2012 19:15:21 -0700
Message-ID: <20120927021521.GA31724@kroah.com>
References: <20120927012916.GA9207@localhost>
 <20120927013223.GA20262@kroah.com>
 <20120927013622.GA9936@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:41539 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751125Ab2I0CPZ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 26 Sep 2012 22:15:25 -0400
Received: by pbbrr4 with SMTP id rr4so2808435pbb.19
        for <linux-serial@vger.kernel.org>; Wed, 26 Sep 2012 19:15:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120927013622.GA9936@localhost>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Fengguang Wu <fengguang.wu@intel.com>
Cc: Anton Vorontsov <anton.vorontsov@linaro.org>, Yuanhan Liu <yuanhan.liu@intel.com>, kernel-janitors@vger.kernel.org, linux-serial@vger.kernel.org, Jason Wessel <jason.wessel@windriver.com>

On Thu, Sep 27, 2012 at 09:36:22AM +0800, Fengguang Wu wrote:
> On Wed, Sep 26, 2012 at 06:32:23PM -0700, Greg KH wrote:
> > On Thu, Sep 27, 2012 at 09:29:16AM +0800, Fengguang Wu wrote:
> > > Hi Anton,
> > > 
> > > FYI, there are new compile warnings show up in
> > > 
> > > tree:   git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-next
> > > head:   0c57dfcc6c1d037243c2f8fbf62eab3633326ec0
> > > commit: 729043e82cdd403a131127254528afea8031ebab [36/40] kdb: Turn KGDB_KDB=n stubs into static inlines
> > > config: cris-allyesconfig
> > 
> > Does the CRIS platform even support KDB?  Perhaps that is why this is
> > failing so badly?
> 
> Yes, I guess so.. Ignore it, or fix it by changing Kconfig to disable
> KDB in the unsupported archs?

Sounds like a good idea, Jason?

greg k-h
