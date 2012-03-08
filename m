From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 00/68] TTY buffer in tty_port -- prep no. 1
Date: Thu, 8 Mar 2012 11:50:28 -0800
Message-ID: <20120308195028.GA17564@kroah.com>
References: <1330955575-26641-1-git-send-email-jslaby@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:43827 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758436Ab2CHTuc (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 8 Mar 2012 14:50:32 -0500
Received: by iagz16 with SMTP id z16so1121059iag.19
        for <linux-serial@vger.kernel.org>; Thu, 08 Mar 2012 11:50:32 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1330955575-26641-1-git-send-email-jslaby@suse.cz>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: alan@linux.intel.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, jirislaby@gmail.com

On Mon, Mar 05, 2012 at 02:51:47PM +0100, Jiri Slaby wrote:
> Hi,
> 								      
> this is the first series of patches which allow tty buffers to be
> moved from tty_struct (present from open to close/hangup) to tty_port
> (present as long as the device). This will allow us to get rid of the
> tty refcounting in the interrupt service routines and other hot paths
> after we are done. This is because we won't need to handle races among
> ISRs, timers, hangups and others, because tty_port lives as long as an
> interrupt/timer tick may occur. Unlike tty_struct.
> 
> In this series, only first few drivers are converted to use
> tty_port. The rest is to come later.
> 
> The first few patches are simple fixes/cleanups which emerged during
> the code investigation here and there. Further serialP header removal
> happens there. Finally, some drivers are forced to use tty_port, which
> will become a necessity in the future.
> 
> Simserial (ia64) and standard x86 stuff were runtime-tested. The rest
> is only checked to be compilation-errors free.
> 
> Final remark: simserial stuff depends on 4 patches sent to Tony Luck
> last week. They are in hist tree and -next already.

Where are those patches at specifically?  Can you send them to me so I
could include them in my tree?  Otherwise I can only apply the first 27
of these patches (which I have now done.)

thanks,

greg k-h
