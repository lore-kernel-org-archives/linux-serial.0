From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v5 28/44] tty: Remove ldsem recursion support
Date: Mon, 18 Mar 2013 16:59:40 -0700
Message-ID: <20130318235940.GB5320@kroah.com>
References: <1361390599-15195-1-git-send-email-peter@hurleysoftware.com>
 <1363034704-28036-1-git-send-email-peter@hurleysoftware.com>
 <1363034704-28036-29-git-send-email-peter@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-da0-f43.google.com ([209.85.210.43]:61096 "EHLO
	mail-da0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756425Ab3CRX6Y (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 18 Mar 2013 19:58:24 -0400
Received: by mail-da0-f43.google.com with SMTP id u36so1642667dak.2
        for <linux-serial@vger.kernel.org>; Mon, 18 Mar 2013 16:58:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1363034704-28036-29-git-send-email-peter@hurleysoftware.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Jiri Slaby <jslaby@suse.cz>, Sasha Levin <levinsasha928@gmail.com>, Dave Jones <davej@redhat.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Shawn Guo <shawn.guo@linaro.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

On Mon, Mar 11, 2013 at 04:44:48PM -0400, Peter Hurley wrote:
> Read lock recursion is no longer required for ldisc references;
> remove mechanism.
> 
> Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
> ---
>  drivers/tty/tty_ldsem.c   | 83 +++++------------------------------------------
>  include/linux/tty_ldisc.h |  2 --
>  2 files changed, 8 insertions(+), 77 deletions(-)

Wait, why did you add something 3 patches ago, only to remove it here?
Why not just smush these patches together in the first place?

greg k-h
