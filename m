From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] USB: serial: fix null-pointer dereferences on disconnect
Date: Wed, 13 Feb 2013 08:41:30 -0800
Message-ID: <20130213164130.GA8371@kroah.com>
References: <20130213142513.GA21078@localhost>
 <1360765731-23164-1-git-send-email-jhovold@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-da0-f50.google.com ([209.85.210.50]:50623 "EHLO
	mail-da0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964783Ab3BMQld (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 13 Feb 2013 11:41:33 -0500
Received: by mail-da0-f50.google.com with SMTP id h15so653644dan.9
        for <linux-serial@vger.kernel.org>; Wed, 13 Feb 2013 08:41:32 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1360765731-23164-1-git-send-email-jhovold@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Johan Hovold <jhovold@gmail.com>
Cc: Chris Ruehl <chris.ruehl@gtsys.com.hk>, Alan Stern <stern@rowland.harvard.edu>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-usb@vger.kernel.org, linux-serial@vger.kernel.org, Alan Cox <alan@linux.intel.com>, stable@vger.kernel.org

On Wed, Feb 13, 2013 at 03:28:51PM +0100, Johan Hovold wrote:
> Make sure serial-driver dtr_rts is called with disc_mutex held after
> checking the disconnected flag.
> 
> Due to a bug in the tty layer, dtr_rts may get called after a device has
> been disconnected and the tty-device unregistered. Some drivers have had
> individual checks for disconnect to make sure the disconnected interface
> was not accessed, but this should really be handled in usb-serial core
> (at least until the long-standing tty-bug has been fixed).
> 
> Note that the problem has been made more acute with commit 0998d0631001
> ("device-core: Ensure drvdata = NULL when no driver is bound") as the
> port data is now also NULL when dtr_rts is called resulting in further
> oopses.
> 
> Reported-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>
> Cc: stable@vger.kernel.org
> ---

Any reason you didn't sign-off on this patch?

I can't really apply it without that :(

