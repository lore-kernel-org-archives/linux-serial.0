From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<ukleinek@informatik.uni-freiburg.de>
Subject: lalal
Date: Fri, 23 Mar 2007 10:03:48 +0100
Message-ID: <20070323090348.GA4194@lala>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:54593 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1422756AbXCWJxr (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 23 Mar 2007 05:53:47 -0400
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.66)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1HUfgi-00020Q-7e
	for linux-serial@vger.kernel.org; Fri, 23 Mar 2007 10:03:56 +0100
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11) with ESMTP id l2N93rXD006574
	for <linux-serial@vger.kernel.org>; Fri, 23 Mar 2007 10:03:53 +0100 (MET)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11/Submit) id l2N93rMC006573
	for linux-serial@vger.kernel.org; Fri, 23 Mar 2007 10:03:53 +0100 (MET)
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hello,

I'm reimplementing a driver for the serial ports of the NetSilicon 9360
processor and have a few questions concerning this.

=46or your information, I'm using v2.6.21-rc3 and if your interested in
the specs of the UART, you can find it at

	http://ftp1.digi.com/support/documentation/90000675_C.pdf

- I cannot find anything about out1 and out2 in the HRM.  Are these
  signals optional?  (set_mctrl)

- The UART has two different loopback modes.  Citing the HRM:

	- Remote loopback (RL)
	  Provides a remote loopback feature.  When RL is set to 1, the
	  TXD transmit output is connected to the RXD receive input. The
	  RL field immediately echoes receive data back as transmit
	  data.
	  This field is used primarily as a test vehicle for external
	  data equipment.

	- Local loopback (LL)
	  Provides an internal local loopback feature.  When LL is set
	  to 1, the internal receive data stream is connected to the TXD
	  output signal. LL connects the serial channel receiver
	  directly to the serial channel transmitter.
	  This field is used primarily as a test vehicle for the serial
	  channel driver firmware.

  I think I should set at least LL in set_mctrl, if mctrl has TIOCM_LOO=
P
  set.  What about RL, should I set that, too?

- Documentation/serial/driver lists the bits relevant for get_mctrl.
  One of them is TIOCM_DCD.  When grepping for that in the linux tree,
  the only match is Documentation/serial/driver itself.  The reference
  implementation (amba_pl011.c) uses TIOCM_CAR instead.  Probably the
  documentation should be fixed?

- grepping for TIOCM_RI shows that for all architectures this is define=
d
  as follows:

  	#define TIOCM_RI   TIOCM_RNG

  For me it looks as if TIOCM_RI were deprecated?  If so,
  Documentation/serial/driver should better use TIOCM_RNG?  amba_pl011.=
c
  uses TIOCM_RNG, too.

=46or now that's it, but I expect to have some more questions as the
driver is far from being complete.

Best regards
Uwe

--=20
Uwe Kleine-K=F6nig

http://www.google.com/search?q=3Dhalf+a+cup+in+teaspoons
-
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
