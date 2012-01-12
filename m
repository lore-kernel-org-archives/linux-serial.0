From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] TTY: fix UV serial console regression
Date: Thu, 12 Jan 2012 23:41:32 +0000
Message-ID: <20120112234132.0a973cb9@pyramind.ukuu.org.uk>
References: <4EDE988B.6010501@suse.cz>
	<1326405315-6601-1-git-send-email-jslaby@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:45114 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756087Ab2ALXkj (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 12 Jan 2012 18:40:39 -0500
In-Reply-To: <1326405315-6601-1-git-send-email-jslaby@suse.cz>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: gregkh@suse.de, Arnd Bergmann <arnd@arndb.de>, alan@linux.intel.com, linux-serial@vger.kernel.org, jirislaby@gmail.com, linux-kernel@vger.kernel.org, "3.0 3.1 3.2" <stable@vger.kernel.org>

> Unless there is some bad race in the code, the hardware seems to be
> pretty broken. Otherwise pure MSR read should not cause such a bug,
> or?

UV serial being what actual hardware and system ?

> So to prevent the bug, revert to the old behavior. I.e. read modem
> status only if we really have to -- for non-CLOCAL set serials.
> Non-CLOCAL works on this hardware OK, I tried. See? I don't.

The old behaviour is rather driver dependant eg whether it used
serial_core or not.

Doesn't look an unreasonable change though.

Alan
