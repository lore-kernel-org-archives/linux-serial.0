From: "Jim Deas" <jdeas@jadsystems.com>
Subject: async structure for serial.c
Date: Sat, 26 Oct 2002 14:59:00 -0700
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <000701c27d3a$e4c50ed0$0264a8c0@jadp4>
Reply-To: "Jim Deas" <jdeas@jadsystems.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from jadp4 ([24.130.96.51]) by rwcrmhc52.attbi.com
          (InterMail vM.4.01.03.27 201-229-121-127-20010626) with SMTP
          id <20021026215053.INES13658.rwcrmhc52.attbi.com@jadp4>
          for <linux-serial@vger.kernel.org>;
          Sat, 26 Oct 2002 21:50:53 +0000
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

I have just upgraded my kernel from 2.4.7 to 2.4.18
After the upgrade I started having problems with
my "signal_handler_IO".
 In the old version, this seemed to trigger only when
bytes were waiting on the serial port. It now seems
to trigger on send as well as receive increasing my 
overhead.
 I saw where TTY_DO_WRITE_WAKEUP was
added to kernel/serial.c.
Was this to create the action I am seeing? If so,
is there a way that only received characters can
trigger SIGIO and not a Tx ready or Tx send?

Regards,
J. Deas


