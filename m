From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [RFC PATCH] vt:tackle kbd_table
Date: Mon, 27 Feb 2012 17:11:00 -0800
Message-ID: <20120228011100.GA18378@kroah.com>
References: <20120227160739.8711.95344.stgit@bob.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:57828 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965399Ab2B1BMt (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 27 Feb 2012 20:12:49 -0500
Received: by mail-pz0-f46.google.com with SMTP id d14so1723608dae.19
        for <linux-serial@vger.kernel.org>; Mon, 27 Feb 2012 17:12:49 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20120227160739.8711.95344.stgit@bob.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

On Mon, Feb 27, 2012 at 04:10:23PM +0000, Alan Cox wrote:
> This could do with some extra eyes and double checking. With this one out of
> the day we can start to make a dent in the console locking logic and thus
> eventually into tty_lock().
> 
> From: Alan Cox <alan@linux.intel.com>
> 
> Keyboard struct lifetime is easy, but the locking is not and is completely
> ignored by the existing code. Tackle this one head on
> 
> - Make the kbd_table private so we can run down all direct users
> - Hoick the relevant ioctl handlers into the keyboard layer
> - Lock them with the keyboard lock so they don't change mid keypress
> - Add helpers for things like console stop/start so we isolate the poking
>   around properly
> - Tweak the braille console so it still builds

The drivers/staging/speakup/main.c code also would need to be tweaked in
this same manner, but that's not a big deal.

Other than that, at first glance, this looks good, nice job.  Care to
make the speakup change and resend it so we can try it out in
linux-next?

greg k-h
