From: "Sayang Oin" <sayangoin@hotmail.com>
Subject: Re: interrupt programming
Date: Mon, 26 Jul 2004 09:24:42 +0200
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <BAY15-F21ZXn97cvZvK00022be7@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from bay15-f21.bay15.hotmail.com ([65.54.185.21]:38928 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S264965AbUGZHYn
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 26 Jul 2004 03:24:43 -0400
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org


Hallo,

I have to use timer because I have to communicate with other programm via 
filestream
and I use this timer also for scheduling the time that I have to send data 
to my device.

people said if I use interrupt so I can be sure I will not lose my datas.


here is my routine
....

  while(1)
  {
		res=select(fd+1, &rfds, NULL, NULL, &tv);
		if(res==0)
		{
		 tries++;
		 if(tries==8)
		  return 0;
		}

      		n = read (fd, p, 1);
		if(n>0)
		{

		 printf(" %X \n", buffer[rd]);
		 p++;
		 rd++;

		}

                // up here I analyze my datas.

                // if everythings ok I jump out of the while


  return rd;
}

....


best regards
sayangoin

_________________________________________________________________
Wußten Sie, daß Sie Ihren Hotmail-Posteingang auch über den MSN Messenger 
abrufen können? http://www.msn.de/messenger Jetzt kostenlos downloaden und 
einfach testen!

