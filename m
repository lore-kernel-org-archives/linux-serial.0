From: Grant Edwards <grant.b.edwards@gmail.com>
Subject: Problem with tcflush() and RTS/CTS flow control?
Date: Wed, 23 Jan 2013 21:03:23 +0000 (UTC)
Message-ID: <kdpj6q$nos$1@ger.gmane.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:58167 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751167Ab3AWVDn (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 23 Jan 2013 16:03:43 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <lnx-linux-serial@m.gmane.org>)
	id 1Ty7UD-0005Rp-P4
	for linux-serial@vger.kernel.org; Wed, 23 Jan 2013 22:03:57 +0100
Received: from dsl.comtrol.com ([64.122.56.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Wed, 23 Jan 2013 22:03:57 +0100
Received: from grant.b.edwards by dsl.comtrol.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Wed, 23 Jan 2013 22:03:57 +0100
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

I've been writing serial port regression test programs to test the
serial drivers I maintain.  I occasionally run them on "standard"
16x50 serial ports for comparison purposes.  My flow control
regression test passes with my driver and fails with 16x50 serial
ports (some are Moschip parallel-serial port boards, some are Oxford
multi-port serial boards).  At the moment, I don't have any
motherboards with serial ports that I can test on.  I've tested under
3.5 and 3.8 kernels so far.

Here's the test scenario:

 1) Port is in "raw" mode with rtscts flow control enabled.

 2) Send receive data to port until RTS goes off (receive ~3968
    bytes).

 3) Make read() calls on port until RTS comes back on (read ~3840
    bytes).

 4) Send receive data to port until RTS goes off again (receive ~3968
    bytes).

so far, everything's working fine...
    
 5) Call tcflush(TCIFLUSH).

RTS should go back on at this point, since the receive buffer is
now empty and there's plenty of room to receive more data.

RTS does not come back on: it stays off (forever, AFAICT).

If you read() the port in non-blocking mode it returns EAGAIN. A
read() in blocking mode will block.  The receive buffer is empty and
incoming data is throttled off, so a blocking read() never returns.

This seems like a bug to me.

Calling tcflow(TCION) once it's in this state does nothing.  [I guess
it's not supposed to since it's only intended to be used in XON/XOFF
mode.]

With my driver, calling tcflush(TCIFLUSH) causes RTS to come back on
again and incoming data resumes.  Why isn't this the right thing to
do?

-- 
Grant Edwards               grant.b.edwards        Yow! PUNK ROCK!!  DISCO
                                  at               DUCK!!  BIRTH CONTROL!!
                              gmail.com            

