From: "Valerio Vanni" <valerio@valeriovanni.com>
Subject: Re: serial console does not wake from S3 suspend
Date: Thu, 3 Apr 2014 13:47:43 +0200
Message-ID: <lhjhpg$o2e$1@ger.gmane.org>
References: <lg9etc$9fl$1@ger.gmane.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:34665 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751634AbaDCM5s (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 3 Apr 2014 08:57:48 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <lnx-linux-serial@m.gmane.org>)
	id 1WVgQr-0005EZ-JR
	for linux-serial@vger.kernel.org; Thu, 03 Apr 2014 14:07:45 +0200
Received: from 88-149-162-166.v4.ngi.it ([88.149.162.166])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Thu, 03 Apr 2014 14:07:45 +0200
Received: from valerio by 88-149-162-166.v4.ngi.it with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Thu, 03 Apr 2014 14:07:45 +0200
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-pm@vger.kernel.org

"Valerio Vanni" <valerio@valeriovanni.com> ha scritto nel messaggio
news:lg9etc$9fl$1@ger.gmane.org
> When resuming from S3 suspend, serial console starts sending garbage
> on the serial port.
> Not continuously, it sends garbage only when in local console prints a
> text.
> It stops only when the (sending) machine is shut down, or if some
> text is sent manually (i.e. with "cat txtfile > /dev/ttyS0").
>
> Full details are here:
> https://bugzilla.kernel.org/show_bug.cgi?id=69751

The problem is still present in final 3.14 (and in linux-next).



