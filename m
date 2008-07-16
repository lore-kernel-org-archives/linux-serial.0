From: Paul Fulghum <paulkf@microgate.com>
Subject: Re: Line disciplines.
Date: Tue, 15 Jul 2008 21:10:31 -0500
Message-ID: <487D5897.8010807@microgate.com>
References: <1216152625.11481.38.camel@wirenth>	 <487D18A9.20304@microgate.com> <1216162679.11481.47.camel@wirenth>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:37561
	"EHLO gw.microgate.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754952AbYGPCLZ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 15 Jul 2008 22:11:25 -0400
In-Reply-To: <1216162679.11481.47.camel@wirenth>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: ian <spyro@f2s.com>
Cc: linux-serial@vger.kernel.org

ian wrote:
> On Tue, 2008-07-15 at 15:37 -0600, Paul Fulghum wrote:
>> If so, what is the return value from tty_register_ldisc()?

Never mind, that function always returns 0 unless an
invalid ldisc number is specified.

> Offhand I cant recall (several days ago) but since the ldisc appeared
> in /proc/tty/ldiscs I would have thought this succeded?

OK, since your open method is not being called I would
try placing some strategic printks in
drivers/char/tty_io.c:tty_set_ldisc()
to trace the path taken when the line discipline is selected.
That is where the open() method should be called.

--
Paul
