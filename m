From: "John D" <pappyd@spamcop.net>
Subject: Setserial and 16650 high-speed boards
Date: Wed, 26 Mar 2003 19:49:00 -0500
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <AHEOJPIJOGIHKMOBFLECOEMJEKAA.pappyd@spamcop.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from juju (A070-1030.CMB2.splitrock.net [64.197.163.14])
	by trinity.screaminetcorp.com (Postfix) with ESMTP id 9C2E262D81
	for <linux-serial@vger.kernel.org>; Wed, 26 Mar 2003 17:54:37 -0700 (MST)
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

I've come across a few Boca high-speed 16650-based boards which control the
clock with a port .. after playing around tracing the paths and
reconstructing the circuit, it appears that it's just a single bit which
chooses regular speed or a 4x clock.

I'm trying to figure out the right place to do the control for this board,
and it appears that that place would be setserial unless I'm mistaken. I
pulled the source deb and looked around, and I see no indication that
anything like this is implemented therein .. the only speed-related stuff I
could find appeared to write to a register in the uart rather than control
any board-level clock adjustment stuff.

Is this the right place to be asking about this stuff? These boards are
available on ebay very cheap, and they're handy for things like external
ISDN t/a connections (yes, some of us are still on ISDN :)

John D

