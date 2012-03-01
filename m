From: Jiri Slaby <jslaby@suse.cz>
Subject: Re: [PATCH 2/6] vt: push down the tty lock so we can see what is
 left to tackle
Date: Thu, 01 Mar 2012 21:31:11 +0100
Message-ID: <4F4FDC8F.2010300@suse.cz>
References: <20120301194831.11322.38295.stgit@bob.linux.org.uk> <20120301195005.11322.78572.stgit@bob.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:44749 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757334Ab2CAUbO (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 1 Mar 2012 15:31:14 -0500
In-Reply-To: <20120301195005.11322.78572.stgit@bob.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Jiri Slaby <jirislaby@gmail.com>

On 03/01/2012 08:50 PM, Alan Cox wrote:
> --- a/drivers/tty/vt/vt_ioctl.c
> +++ b/drivers/tty/vt/vt_ioctl.c
> @@ -281,7 +281,6 @@ int vt_ioctl(struct tty_struct *tty,
>  
>  	console = vc->vc_num;
>  
> -	tty_lock();

Note that this breaks bisection. Further in vt_ioctl, there is a call to
vt_event_wait_ioctl which calls vt_event_wait and that calls
wait_event_interruptible_tty which unlocks BTM.

You change wait_event_interruptible_tty to wait_event_interruptible even
in 4/6.

The VT_WAITEVENT case should have tty_lock until 4/6 (and not longer).

thanks,
-- 
js
suse labs
