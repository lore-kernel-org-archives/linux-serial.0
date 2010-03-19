From: christian pellegrin <chripell@gmail.com>
Subject: [PATCH 0/3] max3100: improvements
Date: Fri, 19 Mar 2010 09:39:02 +0100
Message-ID: <cabda6421003190139h344bc172h3556fca78e4b25cb__16200.2097852112$1268987971$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-fx0-f219.google.com ([209.85.220.219]:45186 "EHLO
	mail-fx0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752971Ab0CSIjD (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 19 Mar 2010 04:39:03 -0400
Received: by fxm19 with SMTP id 19so374350fxm.21
        for <linux-serial@vger.kernel.org>; Fri, 19 Mar 2010 01:39:02 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Feng Tang <feng.tang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, Greg KH <greg@kroah.com>, David Brownell <david-b@pacbell.net>, Grant Likely <grant.likely@secretlab.ca>

Hi all,

first of all I'm sending this patch to all the people that were in CC
to the original Feng's email. Let me know if this bothers you.

This bunch of patches should solve the problems noted by Feng to the
max3100 driver. It was tested on an S3C2440 system which has a rather
bad SPI master controller. The efficiency is very good on zmodem
receive (near 100% at 115200) and not so bad on zmodem send (around
95% at 115200). I guess the reason is the TX buffer of the MAX3100
being just one byte deep. All the tests were done with two MAX3100
running on the same SPI bus: the first one as a console and under
test, the second one happily receiving a 4800 bit/s NMEA stream from a
GPS (with a process checking we don't get wrong sentences). I also did
the simple "cut&paste a screenful of charters" test and it worked! The
console was stressed as much I could (things like putting the S3C to
suspend during a zmodem transfer and checking it restarts after
resume).

-- 
Christian Pellegrin, see http://www.evolware.org/chri/
"Real Programmers don't play tennis, or any other sport which requires
you to change clothes. Mountain climbing is OK, and Real Programmers
wear their climbing boots to work in case a mountain should suddenly
spring up in the middle of the computer room."
