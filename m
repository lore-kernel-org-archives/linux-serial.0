From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: modem multiplexing mode?
Date: Tue, 19 Aug 2003 09:43:13 -0400
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <20030819134313.GC4698@think>
References: <1061286695.1312.172.camel@dalibork.ultra.si>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from zeus.kernel.org ([204.152.189.113]:53499 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S270858AbTHSQNV (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 19 Aug 2003 12:13:21 -0400
Received: from thunker.thunk.org (thunk.org [140.239.227.29])
	by zeus.kernel.org (8.11.6/8.11.6) with ESMTP id h7JDmm626035
	for <linux-serial@vger.kernel.org>; Tue, 19 Aug 2003 06:48:48 -0700
Content-Disposition: inline
In-Reply-To: <1061286695.1312.172.camel@dalibork.ultra.si>
List-Id: linux-serial@vger.kernel.org
To: Dalibor Kranjcic <dalibor.kranjcic@ultra.si>
Cc: linux-serial@vger.kernel.org

On Tue, Aug 19, 2003 at 11:51:32AM +0200, Dalibor Kranjcic wrote:
> Is there any way to send addtional traffic (AT commands) to serial port 
> (/dev/ttyS1 (COM2) in my example) when ppp is atached to it, thus
> providing something as a modem 
> multiplexing mode/protocol (Wavecom GPRS modem), since /dev/ttyS1 is
> locked by pppd and used by ppp modules. 

This is actually a very hard problem, since there's a fundamental race
condition --- you need to at the kernel level, block off access to the
ppp port while your user space application sends commands to the
modem, and the kernel would have to send +++ to put the modem into
command mode, which means the kernel would need to know about the
modem command sequences.  Worse yet, there is no way of know whether
or not the "OK\n" printed after you send the +++ sequence is the
response from the modem, or part of an incoming PPP packet that was
sent just as you were trying to put the modem into command mode.

> Is it possible to send AT commands when ppp traffic is running on serial
> port?

It's possible, but it would require a lot of kernel hacking, not only
in the serial driver (and putting carnal knowledge about modems into
the serial driver where it has no place belonging), but also in the
PPP driver, in order to intercept the return messages from the modem.
It would be a very, very, very, very hard thing to do.  And probably
not worth it.  Why would you want to do such a thing, anyway?

						- Ted
