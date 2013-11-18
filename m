From: Heorhi Valakhanovich <valahanovich@tut.by>
Subject: Re: [PATCH] tty: Only hangup once
Date: Tue, 19 Nov 2013 00:09:23 +0300
Message-ID: <20131119000923.5ca40e51@tormoz-pc>
References: <1375293945-4087-1-git-send-email-peter@hurleysoftware.com>
	<20131117203850.46df2124@tormoz-pc>
	<20131118134211.17861db3@alan.etchedpixels.co.uk>
	<528A5043.6030901@hurleysoftware.com>
	<528A797B.6020807@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-bk0-f53.google.com ([209.85.214.53]:37155 "EHLO
	mail-bk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751286Ab3KRVJ3 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 18 Nov 2013 16:09:29 -0500
Received: by mail-bk0-f53.google.com with SMTP id na10so2733300bkb.26
        for <linux-serial@vger.kernel.org>; Mon, 18 Nov 2013 13:09:28 -0800 (PST)
In-Reply-To: <528A797B.6020807@hurleysoftware.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, gregkh@linuxfoundation.org

On Mon, 18 Nov 2013 15:32:59 -0500
Peter Hurley <peter@hurleysoftware.com> wrote:

> On 11/18/2013 12:37 PM, Peter Hurley wrote:
> > On 11/18/2013 08:42 AM, One Thousand Gnomes wrote:
> >>> After upgrading to kernel 3.12 I noticed one issue with tmux
> >>> software. The easiest way to reproduce will be:
> >>> 1. Start tmux session as root.
> >>> 2. Connect via ssh and use "tmux attach" to attach to the running
> >>> session.
> >>> 3. Kill ssh client.
> >
> > Heorhi,
> >
> > Thanks for the report.
> >
> >>> You can notice that shell (zsh in my case) and "tmux attach" are
> >>> still remains in process' list. That didn't happen in previous
> >>> kernels.
> 
> Heorhi,
> 
> I could not reproduce this behavior with zsh or bash.
> 
> In case I misunderstood, the steps I took to reproduce were,
> 
> [On ssh server machine running 3.12]
> 1.  Add 'set-option -g default-shell /usr/bin/zsh' to /etc/tmux.conf

This is really not necessary. I also reproduced it with bash.

> 2a. In terminal window, 'sudo tmux'
>        - also tried -
> 2b. At root login on tty2, 'tmux'
> 
> Successfully starts tmux session. Then,
> 
> [On ssh client machine]
> 1. 'ssh user@server'
> 2. 'sudo tmux attach'
> 3. Switch to 2nd terminal window,
> 4. ps -ef | grep ssh
> 5. kill $pid_from_step4
> 
> This *did not* leave the 'tmux attach' process alive.
> 
> Is zsh your login shell as well? Maybe that's the required
> component to reproduce the behavior you've observed.
> 
> Regards,
> Peter Hurley

Thank you for your attention.
I tried to reproduce it exactly as you did and notice strange thing.
You use "sudo tmux attach" and tmux client uses the terminal created
for regular user and those works good.

But if you will use "ssh root@server" (you can use localhost too) the
"tmux attach" will use terminal created from root (i checked this with
lsof and ls -al /dev/pts) and behavior is different. Are terminals
created for root is somehow different from those created for regular
users?

If you can't use root ssh login I will try to reproduce it's for sudo by
mixing some kind of dtach and tmux but it will be very unclear at the
end.

Heorhi 
