From: Amit Kucheria <akucheria@metricsystems.com>
Subject: access to RS-232 signals from user-space?
Date: Wed, 26 Mar 2003 12:41:04 -0800
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <1048711267.1460.9.camel@amit.metricsystems.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from amit.metricsystems.com
 (ip67-89-211-170.z211-89-67.customer.algx.net [67.89.211.170])
 by chimmx02.algx.net
 (iPlanet Messaging Server 5.2 HotFix 1.10 (built Jan 23 2003))
 with ESMTP id <0HCD0015MISFQF@chimmx02.algx.net> for
 linux-serial@vger.kernel.org; Wed, 26 Mar 2003 14:41:06 -0600 (CST)
List-Id: linux-serial@vger.kernel.org
To: linux-serial <linux-serial@vger.kernel.org>

Hi all,

I have successfully run a SLIP link between two machines over their
serial ports. We now want to replace the null-modem cable with a radio
at each end connected to the serial port. We also want the ability to
"drive" the radio i.e. use flow-control based on the modem signals on
the radio.

Can anyone enlighten me about the facilities offered by the kernel to
control the various RS-232 lines from kernel-space or user-space? Any
pointers would be helpful.

Regards,
Amit

-- 
----------------------------------------------------------------------------
Amit Kucheria                akucheria@NOSPAMmetricsystems.com
Metric Systems Corporation   2320 Cousteau Court, Suite 201, Vista, CA
92083
----------------------------------------------------------------------------

