From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 00/68] TTY buffer in tty_port -- prep no. 1
Date: Thu, 8 Mar 2012 12:51:46 -0800
Message-ID: <20120308205146.GA16194@kroah.com>
References: <1330955575-26641-1-git-send-email-jslaby@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:61900 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751905Ab2CHUvw (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 8 Mar 2012 15:51:52 -0500
Received: by yhmm54 with SMTP id m54so521938yhm.19
        for <linux-serial@vger.kernel.org>; Thu, 08 Mar 2012 12:51:50 -0800 (PST)
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

Very nice work, all queued up now.

greg k-h
