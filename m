From: =?iso-8859-1?q?suresh=20shenoy?= <msureshshenoy@yahoo.co.in>
Subject: serial port read working but not write
Date: Sat, 24 Jul 2004 15:39:49 +0100 (BST)
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <20040724143949.21583.qmail@web8204.mail.in.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from web8204.mail.in.yahoo.com ([203.199.70.124]:65436 "HELO
	web8204.mail.in.yahoo.com") by vger.kernel.org with SMTP
	id S268647AbUGXOmh (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sat, 24 Jul 2004 10:42:37 -0400
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hi all,

  Firstly vijay's answer:
  
     The hardware has a firmware on it which is given
by the company which manufactured it.

     The system works fine in Windows. i.e i can make
the motor run in windows. The software was provided by
the company.

  Secondly

     After I run my read program i checked the port
settings.

     $ stty -F /dev/ttyS0 -a
       speed 115200 baud; rows 0; columns 0; line =0;
       .....................
       .....................
       flush = ^M; min = 200; time =0;
       -parenb -parodd CS8 -hupcl -cstopb cread clocal
       -crtscts 
       -ignbrk -brkint ignpar.....
       .....................
 
   Thirdly, 
  
      I ran the program to check the output buffer
[buffer sniffing]. 

       When i ran the read program the output was
always 0.

       When i ran the write program the output
increased to 1500-1900 and stayed there. 

    Lastly,

       I am yet to check the results of the port as
told by Frank. I will post it very soon.


Any suggestions.

Ciao
Suresh
 



________________________________________________________________________
Yahoo! India Careers: Over 65,000 jobs online
Go to: http://yahoo.naukri.com/
