From: James Courtier-Dutton <james.dutton@gmail.com>
Subject: USB Smart Card reader
Date: Sat, 25 Feb 2012 10:01:17 +0000
Message-ID: <CAAMvbhFzJv4EpQt4LavFeFusJsCDrFQ1EGhCdvgPG9q63s2AyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:37918 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755310Ab2BYKBR (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 25 Feb 2012 05:01:17 -0500
Received: by qcqw6 with SMTP id w6so233681qcq.19
        for <linux-serial@vger.kernel.org>; Sat, 25 Feb 2012 02:01:17 -0800 (PST)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hi,

I have done some development work on the iuu_phoenix.c driver in the
Linux kernel.
The iuu_phoenix is a smart card reader.
The smart card reader can be given a unique identification string of
16 characters/hex bytes. This ID can be read when the card reader is
inserted into the USB port.
I would like to be able to set up device names in /dev so that when
inserting a card reader into the USB port, it always will appear with
the same unique name in /dev.
Similar to the by-uuid used for hard disk drives.
Can someone tell me how to do this, or probably better, point me to an
existing driver that does it within the linux/drivers/usb/serial tree.

Kind Regards

James
