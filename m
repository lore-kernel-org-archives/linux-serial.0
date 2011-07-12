From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 3/3] TTY: serial, remove tasklet for tty_wakeup
Date: Tue, 12 Jul 2011 23:08:25 +0200
Message-ID: <201107122308.26080.arnd@arndb.de>
References: <1310503400-28447-1-git-send-email-jslaby@suse.cz> <1310503400-28447-3-git-send-email-jslaby@suse.cz>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:60519 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752624Ab1GLVJq (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 12 Jul 2011 17:09:46 -0400
In-Reply-To: <1310503400-28447-3-git-send-email-jslaby@suse.cz>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: gregkh@suse.de, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, jirislaby@gmail.com, Alan Cox <alan@linux.intel.com>

On Tuesday 12 July 2011 22:43:20 Jiri Slaby wrote:
> tty_wakeup can be called from any context. So there is no need to have
> an extra tasklet for calling that. Hence save some space and remove
> the tasklet completely.
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: Greg Kroah-Hartman <gregkh@suse.de>
> Cc: Alan Cox <alan@linux.intel.com>

This is probably ok, but strictly speaking, we we cannot call 
tty_wakeup from any context: not while holding the ldisc_mutex,
i.e. from  ld->ops->{open,close}.

I don't see a reason why we would ever do that, but it's the
only explanation I have why the tasklet was introduced intially.

	Arnd
