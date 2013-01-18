From: Grant Edwards <grant.b.edwards@gmail.com>
Subject: Are calls to activate/shutdown a port serialized?
Date: Fri, 18 Jan 2013 18:04:47 +0000 (UTC)
Message-ID: <kdc2rv$m4g$1@ger.gmane.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:47657 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751572Ab3ARSFJ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 18 Jan 2013 13:05:09 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <lnx-linux-serial@m.gmane.org>)
	id 1TwGJc-0003TM-Is
	for linux-serial@vger.kernel.org; Fri, 18 Jan 2013 19:05:20 +0100
Received: from dsl.comtrol.com ([64.122.56.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Fri, 18 Jan 2013 19:05:20 +0100
Received: from grant.b.edwards by dsl.comtrol.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Fri, 18 Jan 2013 19:05:20 +0100
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

I ported an old tty driver to the new tty_port_ helper functions.  And
I'm trying to track down a couple of bugs in the new version of the
driver.

Are calls to the port's activate/shutdown methods serialized (either
globally or per-port)?
    
-- 
Grant Edwards               grant.b.edwards        Yow! My Aunt MAUREEN was a
                                  at               military advisor to IKE &
                              gmail.com            TINA TURNER!!

