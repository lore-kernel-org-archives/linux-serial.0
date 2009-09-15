From: Dick Hollenbeck <dick@softplc.com>
Subject: remapping advice sought
Date: Tue, 15 Sep 2009 16:35:44 -0500
Message-ID: <4AB008B0.1020402@softplc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kcmailp02.birch.net ([216.212.0.97]:51188 "EHLO mx01.birch.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1758680AbZIOVmW (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 15 Sep 2009 17:42:22 -0400
Received: from unknown (HELO [192.100.100.10]) ([65.16.135.194])
          (envelope-sender <dick@softplc.com>)
          by mx01.birch.net (qmail-ldap-1.03) with SMTP
          for <linux-serial@vger.kernel.org>; 15 Sep 2009 21:35:45 -0000
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org


I made an ARM board with 6 serial ports.  One port comes out on 
/dev/ttyAM0 and 5 others come out on /dev/ttyS0 through /dev/ttyS4.

The ttyAM0 is implemented by an ARM CPU specific driver, while the ttyS* 
ports are implemented in an FPGA and use the 8250.c driver in a 
multi-port fashion with a shared IRQ.

Our userspace code likes to think of serial ports being at /dev/ttyS0 
through /dev/ttyS5 but this naming convention has not yet been achieved.


(1) Are there any good reason why not to do this:

(A) change my copy of the kernel code so that 8250.c exposes its serial 
ports at some other name than "ttyS".

(B) use symlinks in /dev/ to map ttyS0 through ttyS5 onto ttyAM0 
followed by the 8250 FPGA ports.



(2) How hard and fast is the relationship between the name used in the 
driver 8250.c, to the name in the /dev/ directory? Can they be different 
without changing 8250.c source?



(3) Is there a better way?



Thanks,

Dick


