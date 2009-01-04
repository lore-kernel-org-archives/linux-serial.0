From: Wolfgang Rosner <wrosner@tirnet.de>
Subject: CMUX / ts710 serial multiplex driver for x86_64 architecture
Date: Sun, 4 Jan 2009 23:10:21 +0100
Message-ID: <200901042310.22171.wrosner@tirnet.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.tirnet.de ([217.7.138.221]:15461 "EHLO romolus.tirnet.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750929AbZADW1e (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sun, 4 Jan 2009 17:27:34 -0500
Received: from [192.168.0.50] (ip-90-186-228-17.web.vodafone.de [90.186.228.17])
	by romolus.tirnet.de (mailserver tirnet.de) with ESMTP id D467927C5CB1
	for <linux-serial@vger.kernel.org>; Sun,  4 Jan 2009 23:10:19 +0100 (CET)
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Dear kernel professionals,

I'm dealing with a mobile unit development kit that requires multiplexing of 
several virtual serial lines over one single physical serial.
The protocol is supposed to follow GSM 07.10 standard and outlined in detail 
here:
http://www.roundsolutions.com/techdocs/docs/30268st10299a_CMUX_User_Guide_r2.pdf

The supplier only supports WIN :-( drivers.
There appear to be kernel modules around for embedded linux.
I tried to download one
http://svn.openezx.org/trunk/src/kernel-2.6/mux/
but could not manage to build it in my x86_64 environment.

At the moment, I have no idea whether this module might fulfil my purpose at 
all.
Maybe it only implements the module side (i.e. pretending a mobile device), 
not the application side (the controlling PC).
What I expect is to load this (presumably with some userspace action and 
synchronisation commands to the controlled device) ontop of an existing 
serial connection. As a result, there should be some additional serial 
devices, where the demux'ed traffic can be piped in and out.

I find clues that this type of multiplexing is done e.g in some mobile connect 
utilities, but nowhere (apart from the link given above) I find a dedicated 
kernel module for right that purpose.


So here my questions:
- Is there a version of the above mentioned mux / mux_river / ts0710 / mux_cli 
for x86_64 available?
- or could this one from be adapted?
- is there another implementation of GSM 07.10 MUXing?
- is there any documentation around?

Although the issue is not core critical for my project, I'd like to contribute 
if I can. No problem with testing and supplying docs, I think.
Simple userspace config tool (e.g. some perl script writing/reading some bits 
to /proc/whats/o/ever) should still be within my capabilities.

In some ancient time (2.0 or 2.2 kernel as far as I can remember) I have even 
managed to adopt and build a kernel module for some LC display from a book 
template, but that's years ago. But I'm not really firm in C, and things 
might not have become less complex since that days... 
But if I get help (some pointers where to start, caveats to look for) I might 
try it, provided there is a chance of success.

Any help appreciated.

Yours
Wolfgang Rosner


