From: Dalibor Kranjcic <dalibor.kranjcic@ultra.si>
Subject: modem multiplexing mode?
Date: 21 Aug 2003 09:28:18 +0200
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <1061450898.1315.16.camel@dalibork.ultra.si>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from naomi.triera.net ([213.161.0.25]:40340 "EHLO naomi.triera.net")
	by vger.kernel.org with ESMTP id S262485AbTHUH2O (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 21 Aug 2003 03:28:14 -0400
Received: from dalibork.ultra.si (cpe1-7-75.cable.triera.net [213.161.7.75])
	by naomi.triera.net (Postfix) with ESMTP id F12331775A
	for <linux-serial@vger.kernel.org>; Thu, 21 Aug 2003 09:29:20 +0200 (CEST)
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org



Hi,

I have managed to modify serial driver for the Wavecom modem in order to
send AT commands and
PPP traffic separately with use of external fifo:

When traffic comes to the serial driver I check if it is AT or DATA. If
DATA (PPP) traffic comes to serial I proceed it normally, if AT traffic
comes I write it to the external fifo (let's say /dev/ATtraffic).

Sending traffic to serial driver is a little bit tricky. After writing
to fifo I need an entry point to the driver. 
Driver must know that something was written to fifo. So I open an
'dummy' device for example /dev/ttyS12. This allows me to jump into
driver's rs_open method. From there I can read AT commands written to
fifo previously and proceed them to the TX line. Of course this traffic
must be multiplexed before coming to TX lines and I also have to watch
out not to break ppp packets in the middle. 

This works well and I'm really able to send/receive AT packets while ppp
is up, but maybe there is better way to do it?

What do you think about this solution?
Thanks for any advice...


Dalibor.



