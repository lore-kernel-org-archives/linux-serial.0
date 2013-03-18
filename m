From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v5 00/44] ldisc patchset
Date: Mon, 18 Mar 2013 16:54:02 -0700
Message-ID: <20130318235402.GA1937@kroah.com>
References: <1361390599-15195-1-git-send-email-peter@hurleysoftware.com>
 <1363034704-28036-1-git-send-email-peter@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pb0-f44.google.com ([209.85.160.44]:58906 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753624Ab3CRXwr (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 18 Mar 2013 19:52:47 -0400
Received: by mail-pb0-f44.google.com with SMTP id wz12so6827328pbc.31
        for <linux-serial@vger.kernel.org>; Mon, 18 Mar 2013 16:52:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1363034704-28036-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Jiri Slaby <jslaby@suse.cz>, Sasha Levin <levinsasha928@gmail.com>, Dave Jones <davej@redhat.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Shawn Guo <shawn.guo@linaro.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

On Mon, Mar 11, 2013 at 04:44:20PM -0400, Peter Hurley wrote:
> Greg,
> This patchset includes
>   'tty: Drop lock contention stat from ldsem trylocks'
> so no need to apply that on this series. Also, I noticed you
> kept the 'tty is NULL' removal on a different branch so I left
> my patch in this series that removes it.
> 
> This series applies cleanly to tty-next.

I've applied the first 25 patches, right up to the "create a new lock"
patch.  I'll comment on that one next.

thanks,

greg k-h
