From: Michael Williamson <michael.williamson@criticallink.com>
Subject: Need to disable MSR interrupts in 8250 driver.  Request for guidance...
Date: Mon, 03 Jan 2011 09:15:10 -0500
Message-ID: <4D21D9EE.7070503@criticallink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:33755 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754745Ab1ACOPR (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 3 Jan 2011 09:15:17 -0500
Received: by vws16 with SMTP id 16so5747721vws.19
        for <linux-serial@vger.kernel.org>; Mon, 03 Jan 2011 06:15:16 -0800 (PST)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>

Hello,

I am working on platform from the davinci architecture that uses the 8520 UART
driver.  However, there are some configurations that do not have a valid
CTS input pin (it is a multi-purpose pin on a SoC part, and it may be configured
for other functions).  These configurations can cause a pile of "false" 
MSR interrupts.  If, in 8250.c, I set the UART_BUG_NOMSR flag as part of
the up->bugs information, the problem clears up.

The problem is that there is no way to pass bugs information via platform data.  

The link (below) contains a work-around patch that I had submitted to the davinci
group.  It was suggested that I get guidance from the folks on the davinci-serial
list, and that I should consider figuring out a way to set the UART_BUG_NOMSR 
flag from the platform or initialization data.  The patch submission also has a 
more detailed description of the problem for anyone interested.

https://patchwork.kernel.org/patch/442671/

Should I create a new port type, add a new UPF_ flag in the flags field, figure 
out how to pass bugs information via platform data, or continue along the
work-around path?  

Thanks for any insight.

-Mike

