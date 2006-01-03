From: Jaroslaw Tabor <jarek@srv.pl>
Subject: Strange behaviour of serial port
Date: Tue, 03 Jan 2006 23:53:25 +0100
Message-ID: <1136328806.3487.7.camel@tower.int-srv.pl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from beret.waw.pdi.net ([213.241.71.70]:61963 "EHLO beret.srv.pl")
	by vger.kernel.org with ESMTP id S1751063AbWACWxa (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 3 Jan 2006 17:53:30 -0500
Received: from (tower.int-srv.pl) [83.31.73.168]
	by beret.srv.pl with asmtp (Exim 3.36 #1 (Debian))
	id 1Etv1z-0005ph-00
	for linux-serial@vger.kernel.org; Tue, 03 Jan 2006 23:53:27 +0100
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hello!

	I've discovered that file system errors on /var partition leads to
non-working serial port.
	I've confirmed few times, that after power failure without fsck on /var
serial port was in strange state: it was possible to write but not to
read.
	Can anyone explain this ?
-- 
Jaroslaw Tabor <jarek@srv.pl>

