From: Grant Edwards <grant.b.edwards@gmail.com>
Subject: Re: Handling of automatic flow control in UART drivers
Date: Mon, 13 Oct 2014 17:09:21 +0000 (UTC)
Message-ID: <m1h101$tr5$1@ger.gmane.org>
References: <20141013144831.GA8409@jtlinux>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:51224 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751710AbaJMRJe (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 13 Oct 2014 13:09:34 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <lnx-linux-serial@m.gmane.org>)
	id 1Xdj7k-0002Dj-Lr
	for linux-serial@vger.kernel.org; Mon, 13 Oct 2014 19:09:32 +0200
Received: from dsl.comtrol.com ([64.122.56.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Mon, 13 Oct 2014 19:09:32 +0200
Received: from grant.b.edwards by dsl.comtrol.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Mon, 13 Oct 2014 19:09:32 +0200
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

On 2014-10-13, Johannes Thumshirn <johannes.thumshirn@men.de> wrote:

> I active the hardware auto flow control feature on the CRTSCTS flag
> in my uart_ops->set_termios() function. But then the RTS flag is set
> on every call of the uart_ops->set_mctrl() function, this seems to
> confuse the hardware.

Perhaps in that situation you should ignore the RTS setting in
set_mctrl() if CRTSCTS is enabled.

-- 
Grant Edwards               grant.b.edwards        Yow! Zippy's brain cells
                                  at               are straining to bridge
                              gmail.com            synapses ...

