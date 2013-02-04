From: "George Spelvin" <linux@horizon.com>
Subject: Re: 3.8-rc regression with pps-ldisc due to 70ece7a731
Date: 4 Feb 2013 02:08:05 -0500
Message-ID: <20130204070805.28980.qmail@science.horizon.com>
References: <20130204041857.12347.qmail@science.horizon.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from science.horizon.com ([71.41.210.146]:59845 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751428Ab3BDHIH (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 4 Feb 2013 02:08:07 -0500
In-Reply-To: <20130204041857.12347.qmail@science.horizon.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: jslaby@suse.cz, linux-serial@vger.kernel.org
Cc: giometti@linux.it, lasaine@lvk.cs.msu.su, linux-kernel@vger.kernel.org, linux@horizon.com

Just a quick update: the previously posted patch *does* work;
the crash I was experiencing was pilot error.

My NTP server is running a 3.8.0-rc6-dirty kernel right now.

I'll research whether that race I talk about in pps_tty_dcd_change
is actually possible or not (can interrupts start arriving before the
->open() method returns?) and work out a finished minimal bugfix patch
if nobody else finds a better solution.

Sorry for the delay tracking this down; I've known about the crash
for a week or so now, but was short of around tuitts to track it down.

(Have I mentioned how ANNOYING it is when the kernel dumps more than
50 lines of crash message to the console screen and then locks
the keyboard so I can't scroll back?)
