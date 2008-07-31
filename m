From: Federico Tula Rovaletti <fedetula@gmail.com>
Subject: function read() isn't quick enough for reading in ttyS*
Date: Thu, 31 Jul 2008 03:17:21 -0300
Message-ID: <489158F1.2030402@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.28]:62399 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751915AbYGaGR1 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 31 Jul 2008 02:17:27 -0400
Received: by yw-out-2324.google.com with SMTP id 9so213613ywe.1
        for <linux-serial@vger.kernel.org>; Wed, 30 Jul 2008 23:17:25 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: alan@lxorguk.ukuu.org.uk

Hi all! I'm a novice in Linux

In a program I'm writing in c and, when I use the read() function for 
reading a byte in the port serial with a configuration: 115200 bps, 8N2

takes from 2ms to 6ms (aleatory, even if a read up to 10 bytes takes the 
same time), which is  too long.
(ioctl(fd, FIONREAD, &bytes) last the same)

This is the time is suppose to last:
8 bits: data
2 bits: stop
1 bit: start
time = ((8+2+1)bits/115200bps) = 0.095ms,

then when I read the byte with the function inb_p() takes ~ 0.1ms which 
is perfect, what I'm needing for my project.

The problem I'm having is that I use signals (with fcntl(fd, F_SETFL, 
O_ASYNC) ) but this signals last the same time in occur that the read() 
(unacceptable) so I guess that this is a problem of the driver that is 
to slow.

So the question is, is there any way to improve the performance of the 
driver or using read? (doing inb_p is very nasty). Do I'm doing 
something wrong?

Thanks in advance!, I expect as soon as possible any answer

PD: sorry for my English,
