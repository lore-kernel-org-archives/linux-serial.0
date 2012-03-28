From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] staging: evict abandoned 68360serial.c driver from 3.4
Date: Wed, 28 Mar 2012 08:05:28 -0700
Message-ID: <20120328150528.GD19862@kroah.com>
References: <1332889631-21316-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:36523 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755930Ab2C1PFc (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 28 Mar 2012 11:05:32 -0400
Received: by pbcun15 with SMTP id un15so1894820pbc.19
        for <linux-serial@vger.kernel.org>; Wed, 28 Mar 2012 08:05:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1332889631-21316-1-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, Geert Uytterhoeven <geert@linux-m68k.org>, Alan Cox <alan@linux.intel.com>

On Tue, Mar 27, 2012 at 07:07:11PM -0400, Paul Gortmaker wrote:
> commit 3a0db7215c88077b61a673215756ec4a0dc0c7a5
> 
>     "TTY: serial, move 68360 driver to staging"
> 
> did so because the driver had remained broken since 2008.  It also
> added this text to the TODO file:
> 
>    "If no one steps up to adopt any of these drivers, they will
>     be removed in the 3.4 release."
> 
> A quick search on the internet doesn't reveal anyone actively
> trying to update/fix this driver, so follow through on the above
> and remove it from the pending 3.4 release.
> 
> Cc: Jiri Slaby <jslaby@suse.cz>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Alan Cox <alan@linux.intel.com>
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

Thanks for this, but as I missed the merge window for 3.4, I'll queue it
up for 3.5 just to be safe.

greg k-h
