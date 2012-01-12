From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH] TTY: fix UV serial console regression
Date: Thu, 12 Jan 2012 14:00:17 -0800
Message-ID: <20120112220017.GA1440@suse.de>
References: <4EDE988B.6010501@suse.cz>
 <1326405315-6601-1-git-send-email-jslaby@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:53683 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755804Ab2ALWA0 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 12 Jan 2012 17:00:26 -0500
Content-Disposition: inline
In-Reply-To: <1326405315-6601-1-git-send-email-jslaby@suse.cz>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: Arnd Bergmann <arnd@arndb.de>, alan@linux.intel.com, linux-serial@vger.kernel.org, jirislaby@gmail.com, linux-kernel@vger.kernel.org, "3.0 3.1 3.2" <stable@vger.kernel.org>

On Thu, Jan 12, 2012 at 10:55:15PM +0100, Jiri Slaby wrote:
> Commit 74c2107759d (serial: Use block_til_ready helper) and its fixup
> 3f582b8c110 (serial: fix termios settings in open) introduced a
> regression on UV systems. The serial eventually freezes while being
> used. It's completely unpredictable and sometimes needs a heap of
> traffic to happen first.
> 
> To reproduce this, yast installation was used as it turned out to be
> pretty reliable in reproducing. Especially during installation process
> where one doesn't have an SSH daemon running. And no monitor as the HW
> is completely headless. So this was fun to find. Given the machine
> doesn't boot on vanilla before 2.6.36 final. (And the commits above
> are older.)
> 
> Unless there is some bad race in the code, the hardware seems to be
> pretty broken. Otherwise pure MSR read should not cause such a bug,
> or?
> 
> So to prevent the bug, revert to the old behavior. I.e. read modem
> status only if we really have to -- for non-CLOCAL set serials.
> Non-CLOCAL works on this hardware OK, I tried. See? I don't.
> 
> And document that shit.

Thanks for tracking this down, I'll queue it up and get it to Linus
after 3.3-rc1 is out.

greg k-h
