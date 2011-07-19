From: Andreas Bombe <aeb@debian.org>
Subject: Re: [PATCH v2 1/6] TTY: serial, remove BTM from wait_until_sent
Date: Tue, 19 Jul 2011 02:35:04 +0200
Message-ID: <20110719003503.GA4138@amos.fritz.box>
References: <1310646915-3032-1-git-send-email-jslaby@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from infernal.debian.net ([87.230.26.131]:53427 "EHLO
	infernal.debian.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750983Ab1GSBMs (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 18 Jul 2011 21:12:48 -0400
Content-Disposition: inline
In-Reply-To: <1310646915-3032-1-git-send-email-jslaby@suse.cz>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: gregkh@suse.de, jirislaby@gmail.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Alan Cox <alan@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>

On Thu, Jul 14, 2011 at 02:35:10PM +0200, Jiri Slaby wrote:
> This should also fix the issue Andreas is seeing (BTM in comparison to
> BKL doesn't have any hidden functionality like unlocking during
> sleeping).

I tested the patch series and it does not appear to make a difference
for the internal (16550A) serial ports on my system. Also, I am still
unclear on why it freezes the X display during the timeout period.

The other serial port device I have at hand is a FTDI USB->Dual UART
which appears to not have a timeout at all, but then that shows no
difference whether your patches are applied or not. I don't remember if
it was always that way, at least 2.6.39 also acts identically.

-- 
Andreas Bombe
