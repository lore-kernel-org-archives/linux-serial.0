From: Larry Baker <baker@usgs.gov>
Subject: How can I help?
Date: Fri, 18 Apr 2014 14:53:35 -0700
Message-ID: <8A1E86F6-47F2-44A7-A8DB-8A643FE9796B@usgs.gov>
Mime-Version: 1.0 (Apple Message framework v1085)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from SMTP3.doi.gov ([137.227.82.13]:9469 "EHLO smtp3.doi.gov"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754392AbaDRV7J convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 18 Apr 2014 17:59:09 -0400
Received: by mail-pd0-f178.google.com with SMTP id x10so1794508pdj.37
        for <linux-serial@vger.kernel.org>; Fri, 18 Apr 2014 14:53:41 -0700
 (PDT)
Received: from savaii.wr.usgs.gov (u-130-118-45-7.xr.usgs.gov. [130.118.45.7])
        by mx.google.com with ESMTPSA id
 vg1sm61930297pbc.44.2014.04.18.14.53.39        for
 <linux-serial@vger.kernel.org>        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA
 bits=128/128);        Fri, 18 Apr 2014 14:53:40 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Greg and Johan (via linux-serial@vger.kernel.org),

I am hoping you will have some good advice for me, and maybe I can help you.

I am migrating a serial data acquisition app from a PC platform to a lower cost/lower power ARM SoC platform.  The data come from the instrument over an RS-232 link that requires RTS/CTS handshaking.  It also uses a packet-based handshaking protocol in software.  Serial ports with hardware handshaking have been difficult to find on the SoC platforms I'm experimenting with, so I bought a USB-to-Serial adapter.  The one I bought is identified as an FTDI FT232RL.  It sort of works.  What happens is, after about 8 or 9 hours, the RX to the TTY port times out.  Sometimes it happens in only an hour, other times it takes about 14 hours.  After about 10 seconds, it seems to recover.  Too late, though, for the application; it has already started its abort sequence by then.

On the ARM SoC platform (CompuLab Utilite, Linux utilite 3.0.35-cm-fx6-5.5-rtscts-00002-g39389d3 #102 SMP Tue Apr 1 18:52:11 IDT 2014 armv7l armv7l armv7l GNU/Linux), the ftdi_sio driver is v1.6.0. To eliminate the possibility it was a Linux ARM bug, I ran the same setup on an AtomPC.  I got the same result.  The AtomPC runs CentOS 6.5 (CompuLab fit-PC2i, Linux fit-pc2i.wr.usgs.gov 2.6.32-431.5.1.el6.i686 #1 SMP Tue Feb 11 21:56:33 UTC 2014 i686 i686 i386 GNU/Linux), which has ftdi_sio driver v1.5.0.  I was blaming the instrument, until I hooked it up to the COM1 port on the AtomPC and everything ran fine.  (The full software handshaking protocol handling in my app is new; the other mode of operation is the device continuously streams its data.  This last test confirmed that my software ha
 ndshaking was not at fault.)

I have seen people complain about problems using FTDI chips and questions about ARM compatibility.  I think those were either pilot error or have been fixed by now.  (Though, I was surprised by a very recent post and a patch as a result to add parity support to one of the non-FTDI drivers.  I would have taken parity support for granted -- it seems pretty fundamental to serial data comm.)  The FTDI-based adapters seem to be the ones that most people like.  I just ordered a couple adapters with Prolific chips to try.

Your names are at the top of the ftdi_sio driver source in the latest Linux kernel source tree, and I've seen Greg's name in several e-mail exchanges about Linux USB-to-Serial drivers, e.g., the Prolific driver.  I'd like your advice about the best choice of chip on Linux.  From what Greg has written, some of the drivers were written based on reverse engineering of the vendor's Windows drivers and trial-and-error.  Are there any Linux drivers supplied by and/or supported by the chip vendors?  Are those any better?  I've had the general impression that FTDI is supposed to be a good choice.  If that it what you would recommend, then I should help you figure out how to fix the bug I'm running into.  I see the debugging code removed in the latest Linux ftdi_sio drivers.  But, I think the v1.5.
 0 and v1.6.0 drivers still support debugging.  I could enable that and hope my little 4GB SD card rootfs does not overflow.  I also added a TX/RX packet header capture queue with time-stamps to my app.  When I get a failure, I print out the last 20 TTY transactions.

If you would kindly point me to the correct web page or e-mail address to participate in debugging the FTDI or other USB-to-Serial drivers, I will help a much as I can.  I am suspicious, for example, that the CTS grant is getting lost.  When data starts to flow again after the timeout (there are shutdown commands being sent to the instrument), I see correctly formed packets (the ones that timed out earlier -- they were already in the device transmit queue); no runts, no checksum errors.  That fits with the scenario that CTS is not always being seen by the requester.  I don't have hardware like a logic analyzer; just an RS-232 break-out box.  I plan to try wiring RTS to CTS on the sender side, disable RTS/CTS flow control on the app side (I don't know how much the device driver vs. the chip
  is involved in the RTS/CTS handshaking; I want to disable any RTS/CTS state transitions all the way out to the chip, if the driver will do that), and see if the RX timeouts go away.  If so, that is a valuable data point and gives me a place to start probing in the driver (assuming it is not the chip itself that is the problem).

Thank you in advance for your advice.

Larry Baker
US Geological Survey
650-329-5608
baker@usgs.gov



