From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: tty_flip_buffer() from atomic context when low_latency==1
Date: Fri, 19 Aug 2011 23:53:12 +0100
Message-ID: <20110819235312.017b7c3f@lxorguk.ukuu.org.uk>
References: <j2med6$q2r$1@dough.gmane.org>
	<20110819212416.6f626852@lxorguk.ukuu.org.uk>
	<j2mhva$nmv$1@dough.gmane.org>
	<20110819220644.3166083d@lxorguk.ukuu.org.uk>
	<j2mkav$bat$1@dough.gmane.org>
	<20110819223141.6250087c@lxorguk.ukuu.org.uk>
	<j2mlur$k3g$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:56704 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752685Ab1HSWyd (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 19 Aug 2011 18:54:33 -0400
In-Reply-To: <j2mlur$k3g$1@dough.gmane.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Grant Edwards <grant.b.edwards@gmail.com>
Cc: linux-serial@vger.kernel.org

> [Why this only became a problem recently, I don't know.]

In a word - multiprocessing. In 2.4 and 2.4 the tty layer locking was
very broken, in 2.6 its rather better but the side effect of that is all
the unsafe uses of low_latency now blow up and get caught instead of
working most of the time then going bang.

Alan
