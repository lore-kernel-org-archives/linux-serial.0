From: "Robert P. J. Day" <rpjday@crashcourse.ca>
Subject: a couple unused serial config vars?
Date: Sat, 18 Apr 2009 08:54:59 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0904180854040.30846@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from astoria.ccjclearline.com ([64.235.106.9]:53499 "EHLO
	astoria.ccjclearline.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753795AbZDRNPh (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 18 Apr 2009 09:15:37 -0400
Received: from [174.113.191.234] (helo=crashcourse.ca)
	by astoria.ccjclearline.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <rpjday@crashcourse.ca>)
	id 1LvA5J-000472-FY
	for linux-serial@vger.kernel.org; Sat, 18 Apr 2009 08:55:53 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org


===== UART3_CTS_PIN
drivers/serial/Kconfig:818:config UART3_CTS_PIN
===== UART3_RTS_PIN
drivers/serial/Kconfig:825:config UART3_RTS_PIN

  neither of these appear to be referenced from anywhere.

rday
--

========================================================================
Robert P. J. Day                               Waterloo, Ontario, CANADA

        Linux Consulting, Training and Annoying Kernel Pedantry.

Web page:                                          http://crashcourse.ca
Linked In:                             http://www.linkedin.com/in/rpjday
Twitter:                                       http://twitter.com/rpjday
========================================================================
