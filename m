From: Ubdfu <ubdfu@student.kit.edu>
Subject: Using the MAX3107
Date: Tue, 29 May 2012 17:02:41 +0200
Message-ID: <4FC4E511.7010501@student.kit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout.scc.kit.edu ([129.13.185.202]:35896 "EHLO
	mailout.scc.kit.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751989Ab2E2PSE (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 29 May 2012 11:18:04 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hello,

Please excuse my and be aware that I'm quite new to kernel hacking :-)

I'm currently trying to enable the RS485 support on the MAX3107 and 
continuously getting the error:
"max3107 spi2.0: interrup isn't serviced normally!"
Assuming it means interrupt it nevertheless does not help me to find the 
cause of the problem.

Added some patches form:
http://marc.info/?l=linux-serial&w=2&r=1&s=max3107&q=b

And changed the baudrate to the appropriate, set bit for rs458 mode.

Has anyone tried working with the MAX3107?

Thanks in advance
Marcel
