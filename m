From: Amit Kucheria <akucheria@metricsystems.com>
Subject: RE: access to RS-232 signals from user-space?
Date: Thu, 27 Mar 2003 15:24:44 -0800
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <1048807485.1422.53.camel@amit.metricsystems.com>
References: <11E89240C407D311958800A0C9ACF7D1A33E02@EXCHANGE>
 <1048721530.1468.20.camel@amit.metricsystems.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from amit.metricsystems.com
 (ip67-89-211-170.z211-89-67.customer.algx.net [67.89.211.170])
 by chimmx05.algx.net
 (iPlanet Messaging Server 5.2 HotFix 1.10 (built Jan 23 2003))
 with ESMTP id <0HCF00ERIL0147@chimmx05.algx.net> for
 linux-serial@vger.kernel.org; Thu, 27 Mar 2003 17:24:02 -0600 (CST)
In-reply-to: <1048721530.1468.20.camel@amit.metricsystems.com>
List-Id: linux-serial@vger.kernel.org
To: linux-serial <linux-serial@vger.kernel.org>

Hi,

So I wrote some code which can get and set modem line status from
user-space using the TIOCM[S|G]ET ioctls.

I want to get a little more ambitious and do the following:

------|                                   |-------
      |    /                         \    |
Box 1 |====---                     ---====| Box2
      |    \                         /    |
  P1  |    Radio1                Radio2   |  P2
------|                                   |-------


1. Box1 and Box2 are connected to a radio thru the serial port. They are
communicating over the air. The serial ports on both sides are
configured as a SLIP link.

2. P1 and P2 are two processes generating traffic, they know nothing
about the SLIP link, they just generate IP traffic that is forwarded
over the SLIP link (radio) by the IP layer using the forwarding table.

3. I want to write a program that will get/set the status of RTS/CTS,
etc. depending on the load on the box, load on the link, etc. This will
turn on/off the radio.

So when I turnoff RTS on one side, the same program on the other side
will detect this and turn off the (traffic) tap from that side and
buffer the packets. And when I turn it back on the traffic starts
flowing again. 

4. I also want the ability to inject some "status/keep-alive" packets if
the link has been idle for a long time. Any suggestions regarding the
best way to do this?

Has anybody attempted this? Do you foresee any problems?

TIA.

Regards,
Amit

On Wed, 2003-03-26 at 15:32, Amit Kucheria wrote:

> Thanks Ed.
> 
> I have a few more doubts, but I will reserve them for until after I have
> written some code to test out the capabilities of serial port
> communications on Linux.
> 
> Regards,
> Amit

-- 
----------------------------------------------------------------------
Amit Kucheria          akucheria@NOSPAMmetricsystems.com
Metric Systems Corp.   2320 Cousteau Court, Suite 201, Vista, CA 92083
----------------------------------------------------------------------

