From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/2]  8250_pci: Replace commits 448ac154 and e86ff4a
Date: Mon, 9 Apr 2012 09:47:59 -0700
Message-ID: <20120409164759.GA8800@kroah.com>
References: <4F7B52D8.101@fb.com>
 <20120403215832.0520f93d@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:52145 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751672Ab2DIQsE (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 9 Apr 2012 12:48:04 -0400
Received: by pbcun15 with SMTP id un15so5202521pbc.19
        for <linux-serial@vger.kernel.org>; Mon, 09 Apr 2012 09:48:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120403215832.0520f93d@pyramind.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: sudhakar <sudhakar@fb.com>, linux-serial@vger.kernel.org, alan@linux.intel.com, dan.j.williams@intel.com, nhan.h.mai@intel.com, linux-kernel@vger.kernel.org

On Tue, Apr 03, 2012 at 09:58:32PM +0100, Alan Cox wrote:
> On Tue, 3 Apr 2012 12:43:20 -0700
> sudhakar <sudhakar@fb.com> wrote:
> 
> > 
> > From: Sudhakar Mamillapalli <sudhakar@fb.com>
> > 
> > 
> > The following commits don't completely fix the KT serial missing
> > interrupt problems.  So they have been replaced instead by
> > enabling serial backup timer.  The iir-once + msi tried approach tried
> > to enforce one read of the iir per THRE event, but its defeated by any
> > other event occurring at the wrong time, particularly MSR events.
> > 
> > 448ac15 serial/8250_pci: setup-quirk workaround for the kt serial controller
> > e86ff4a serial/8250_pci: init-quirk msi support for kt serial controller
> 
> These are already in tree. If you are reversing them and adding a
> different fix then please post the series as
> 
> - two revert patches exactly reverting the two commits
> - a follow on patch or two adding the replacement
> 
> That makes it much easier to review and much more obvious. It also helps
> make testing simpler.

I agree, Sudhakar, can you please redo these 2 patches?

greg k-h
