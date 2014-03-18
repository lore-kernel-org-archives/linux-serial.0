From: "Valerio Vanni" <valerio@valeriovanni.com>
Subject: serial console does not wake from S3 suspend
Date: Tue, 18 Mar 2014 13:41:30 +0100
Message-ID: <lg9etc$9fl$1@ger.gmane.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:47223 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752454AbaCRMpM (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 18 Mar 2014 08:45:12 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <lnx-linux-serial@m.gmane.org>)
	id 1WPtOC-00052S-20
	for linux-serial@vger.kernel.org; Tue, 18 Mar 2014 13:45:04 +0100
Received: from 88-149-211-113.v4.ngi.it ([88.149.211.113])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Tue, 18 Mar 2014 13:45:04 +0100
Received: from valerio by 88-149-211-113.v4.ngi.it with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Tue, 18 Mar 2014 13:45:04 +0100
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

When resuming from S3 suspend, serial console starts sending garbage on 
the serial port.
Not continuously, it sends garbage only when in local console prints a 
text.
It stops only when the (sending) machine is shut down, or if some text is 
sent manually (i.e. with "cat txtfile > /dev/ttyS0").

Full details are here:
https://bugzilla.kernel.org/show_bug.cgi?id=69751




