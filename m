From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2] pch_uart: Add uart device to irq name
Date: Tue, 25 Mar 2014 07:00:39 -0700
Message-ID: <20140325140039.GA16994@kroah.com>
References: <20140325125249.GA6360@kroah.com>
 <1395752708-3748-1-git-send-email-alexander.stein@systec-electronic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:44862 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752360AbaCYN7D (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 25 Mar 2014 09:59:03 -0400
Content-Disposition: inline
In-Reply-To: <1395752708-3748-1-git-send-email-alexander.stein@systec-electronic.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org

On Tue, Mar 25, 2014 at 02:05:08PM +0100, Alexander Stein wrote:
> This will additionally show the specific UART device instead of the
> general module name. This cames in handy so check for the interupts of
> a specific device if there are several of them.
> 
> Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
> ---
> Changes in v2:
> * Add actual commit message
> * Fix checkpatch errors

Hi,

This is the friendly semi-automated patch-bot of Greg Kroah-Hartman.
You have sent him a patch that has triggered this response.

Right now, the development tree you have sent a patch for is "closed"
due to the timing of the merge window.  Don't worry, the patch(es) you
have sent are not lost, and will be looked at after the merge window is
over (after the -rc1 kernel is released by Linus).

So thank you for your patience and your patches will be reviewed at this
later time, you do not have to do anything further, this is just a short
note to let you know the patch status and so you don't worry they didn't
make it through.

thanks,

greg k-h's patch email bot
