From: Pascal JEAN <epsilonrt@gmail.com>
Subject: sc16is7xx: fix RTS/CTS implementation and add reading CTS
Date: Wed, 27 Jul 2016 22:58:41 +0200
Message-ID: <1469653123-21867-1-git-send-email-epsilonrt@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: jslaby@suse.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi Greg,

Here are explanations of the two patches:

0001-sc16is7xx-fix-RTS-CTS-implementation.patch:
RTS/CTS handshaking for sc16is7xx driver does not work, no character is sent 
regardless of the state of CTS.

This test was done on a raspberry pi 2:

1- sc16is7xx_set_baud() overwrites the flow control configuration bits in EFR. 
Writing in EFR has been replaced by an update.
2- As noted in the file Documentation/serial/driver, 
get_mctrl() should return an active state for unsupported entries.

0002-sc16is7xx-add-reading-CTS.patch:
This patch adds the possibility to read the actual status of the CTS input when
 RTS/CTS handshaking is not activated.

After those changes everything works.

Thank you for your hard work.
Have a nice day.
Pascal
