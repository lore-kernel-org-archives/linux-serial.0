From: =?ISO-8859-1?Q?Eric_B=E9nard?= <eric@eukrea.com>
Subject: serial/imx.c : wrong baudrate at resume if console is on UART
Date: Thu, 27 May 2010 23:02:08 +0200
Message-ID: <4BFEDDD0.8000607@eukrea.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from 29.mail-out.ovh.net ([87.98.216.213]:38482 "HELO
	29.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756683Ab0E0VCL (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 27 May 2010 17:02:11 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hi,

while testing suspend/resume on i.MX27, I meet a problem on resume : if 
the console is on the UART the baudrate it not restored properly (I get 
random bitrate between 50 to 2Mbps). Here is a patch to add pm to the 
uart_ops (but the problem occurs also without this patch) :
http://lists.infradead.org/pipermail/linux-arm-kernel/2010-May/016495.html

What is strange is that giving wrong structures (platform_device instead 
of device) in suspend/resume functions as in following patch "fix" the 
problem :
http://lists.infradead.org/pipermail/linux-arm-kernel/2010-May/015985.html

Do you have any idea of what could be wrong there ?

Many thanks,
Eric
