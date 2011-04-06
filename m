From: Grant Edwards <grant.b.edwards@gmail.com>
Subject: Add new ASYNC_SPD_WARP13?
Date: Wed, 6 Apr 2011 16:48:49 +0000 (UTC)
Message-ID: <ini5hh$7s3$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:33087 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755291Ab1DFQtH (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 6 Apr 2011 12:49:07 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <lnx-linux-serial@m.gmane.org>)
	id 1Q7Vue-0004Dv-RF
	for linux-serial@vger.kernel.org; Wed, 06 Apr 2011 18:49:00 +0200
Received: from dsl.comtrol.com ([64.122.56.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Wed, 06 Apr 2011 18:49:00 +0200
Received: from grant.b.edwards by dsl.comtrol.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Wed, 06 Apr 2011 18:49:00 +0200
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

I'm working on a driver for a serial board that supports 921600 bps,
and it would be awfully nice if there was a way to specify that using
the ASYNC_SPD_xxxxx mechanism.  Is there any reason why this wouldn't
work?


  #define ASYNC_SPD_HI         (1U << ASYNCB_SPD_HI)
  #define ASYNC_SPD_VHI        (1U << ASYNCB_SPD_VHI)
  #define ASYNC_SPD_SHI        (1U << ASYNCB_SPD_SHI)
  #define ASYNC_SPD_CUST       (ASYNC_SPD_HI|ASYNC_SPD_VHI)
  #define ASYNC_SPD_WARP       (ASYNC_SPD_HI|ASYNC_SPD_SHI)
+ #define ASYNC_SPD_WARP13     (ASYNC_SPD_HI|ASYNC_SPD_SHI|ASYNC_SPD_SHI)

  #define ASYNC_SPD_MASK       (ASYNC_SPD_HI|ASYNC_SPD_VHI|ASYNC_SPD_SHI)

  
-- 
Grant Edwards               grant.b.edwards        Yow! I'm wearing PAMPERS!!
                                  at               
                              gmail.com            

