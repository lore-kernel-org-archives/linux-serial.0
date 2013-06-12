From: Grant Edwards <grant.b.edwards@gmail.com>
Subject: API to flush rx fifo?
Date: Wed, 12 Jun 2013 20:03:50 +0000 (UTC)
Message-ID: <kpak75$9ko$1@ger.gmane.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:41079 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755695Ab3FLUEJ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 12 Jun 2013 16:04:09 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <lnx-linux-serial@m.gmane.org>)
	id 1UmrH4-0007Bn-F8
	for linux-serial@vger.kernel.org; Wed, 12 Jun 2013 22:04:08 +0200
Received: from dsl.comtrol.com ([64.122.56.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Wed, 12 Jun 2013 22:04:06 +0200
Received: from grant.b.edwards by dsl.comtrol.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Wed, 12 Jun 2013 22:04:06 +0200
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

I see the uart_ops.flush_buffer method which is used to flush the
UART's tx fifo (presumably when the user calls tcflush(TCOFLUSH)).

How does the rx fifo get flushed when the user calls tcflush(TCIFLUSH)?

-- 
Grant Edwards               grant.b.edwards        Yow! I'm shaving!!
                                  at               I'M SHAVING!!
                              gmail.com            

