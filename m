From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] serial: PL011: move interrupt clearing
Date: Thu, 29 Mar 2012 14:33:33 -0700
Message-ID: <20120329213333.GA15231@kroah.com>
References: <1332357318-8017-1-git-send-email-linus.walleij@linaro.org>
 <CACxGe6u+KeYzWwiJ7MK7pWG444Y99CQ1LLCZP4m3R=zdYFR_pg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:36071 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760074Ab2C2Vdi (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 29 Mar 2012 17:33:38 -0400
Received: by pbcun15 with SMTP id un15so655987pbc.19
        for <linux-serial@vger.kernel.org>; Thu, 29 Mar 2012 14:33:37 -0700 (PDT)
In-Reply-To: <CACxGe6u+KeYzWwiJ7MK7pWG444Y99CQ1LLCZP4m3R=zdYFR_pg@mail.gmail.com>
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-serial@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, Jong-Sung Kim <neidhard.kim@lge.com>, stable <stable@vger.kernel.org>, Chanho Min <chanho0207@gmail.com>, linux-arm-kernel@lists.infradead.org, Shreshtha Kumar Sahu <shreshthakumar.sahu@stericsson.com>

On Thu, Mar 29, 2012 at 02:49:37PM -0600, Grant Likely wrote:
> On Wed, Mar 21, 2012 at 1:15 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> > Commit 360f748b204275229f8398cb2f9f53955db1503b
> > "serial: PL011: clear pending interrupts"
> > attempts to clear interrupts by writing to a
> > yet-unassigned memory address. This fixes the issue.
> >
> > The breaking patch is marked for stable so should be
> > carried along with the other patch.
> >
> > Cc: Shreshtha Kumar Sahu <shreshthakumar.sahu@stericsson.com>
> > Cc: Russell King <linux@arm.linux.org.uk>
> > Cc: stable <stable@vger.kernel.org>
> > Reported-by: Viresh Kumar <viresh.kumar@st.com>
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Ugh; the original patch is obviously broken.  How did it get applied
> without testing?
> 
> Greg, can you get this out to Linus ASAP please?  I have one comment
> below, but I don't think it should block merging this patch.
> 
> Tested-by: Grant Likely <grant.likely@secretlab.ca>

Thanks, I'll get it to him after 3.4-rc1 is out, in a few days, along
with other tty fixes being queued up.

greg k-h
