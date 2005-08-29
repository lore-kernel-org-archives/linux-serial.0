From: =?iso-8859-2?Q?Horv=E1th_=C1kos_P=E9ter?= <maxx@inf.bme.hu>
Subject: 16550a baud_base < 9600 ???
Date: Mon, 29 Aug 2005 15:05:56 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0508291501020.26828@mj.opentvnet.hu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from ip33-200.covysoft.net ([217.13.33.200]:2767 "EHLO
	mj.opentvnet.hu") by vger.kernel.org with ESMTP id S1750936AbVH2NGP
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 29 Aug 2005 09:06:15 -0400
Received: from localhost (localhost [127.0.0.1])
	by mj.opentvnet.hu (Postfix) with ESMTP id D55F75000
	for <linux-serial@vger.kernel.org>; Mon, 29 Aug 2005 15:05:56 +0200 (CEST)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hi all,

I need to use serial communication with baud rates under 9600. I tried the 
uart 16550a linux driver, but found that setserial gives back invalid 
argument. The cause is that serial_core.c and 8250.c explicitly disallow 
these settings. Why?

The quick & dirty solution (simply eliminating these limit checks in 
serial_core.c and 8250.c) does GPF. Ok :)

Is it possible now to do serial communication with a device which can only 
1200 baud?

thanks,

MaXX
