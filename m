From: Jeff <wd4nmq@comcast.net>
Subject: asychronous RTS/DCE/CD notification
Date: Mon, 08 Mar 2004 22:53:42 -0500
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <404D3FC6.80308@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:33689 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261500AbUCIDxm (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 8 Mar 2004 22:53:42 -0500
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Is it possible in th Linux serial driver to have the state change of 
serial control lines like CD notify a user space app rather then having 
to periodically poll?
I have an app that uses select() to wait for input from several 
different sources. Now, I also want to know when there is a state change 
in CD. Can the serial driver  do this on it's on, like say via a /proc 
file. Or, do I have to break out of the select() every so ofton and use 
ioctl() to test CD's state. God I hate polling.

Jeff

