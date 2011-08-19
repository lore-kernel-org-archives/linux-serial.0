From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: tty_flip_buffer() from atomic context when low_latency==1
Date: Fri, 19 Aug 2011 22:31:41 +0100
Message-ID: <20110819223141.6250087c@lxorguk.ukuu.org.uk>
References: <j2med6$q2r$1@dough.gmane.org>
	<20110819212416.6f626852@lxorguk.ukuu.org.uk>
	<j2mhva$nmv$1@dough.gmane.org>
	<20110819220644.3166083d@lxorguk.ukuu.org.uk>
	<j2mkav$bat$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:37851 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753004Ab1HSVdD (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 19 Aug 2011 17:33:03 -0400
In-Reply-To: <j2mkav$bat$1@dough.gmane.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Grant Edwards <grant.b.edwards@gmail.com>
Cc: linux-serial@vger.kernel.org

> I don't understand why the low_latency flag even exists when setting
> it apparently breaks most all of the serial drivers.

Mostly history. I'd not realised random users could fiddle with it - they
shouldn't be able to do that so that wants fixing.

Historically it made sense as with a 100Hz clock some algorithms with
drivers that delayed stuff a lot got really slow (eg non windowed
versions of firmware download protocols, kermit, xmodem etc)

Nowdays the kernel is a bit more sophisticated and we should possibly
re-arrange it so that it selects different workqueues or similar -
low_latency meaning 'use a private hard rt work queue' perhaps.

Or indeed possibly making ttys use threaded IRQs
