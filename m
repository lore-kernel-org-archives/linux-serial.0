From: Tomas D <u0giene@yahoo.com>
Subject: rs232 line splitting
Date: Thu, 25 May 2006 09:03:52 -0700 (PDT)
Message-ID: <20060525160352.56997.qmail@web34508.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from web34508.mail.mud.yahoo.com ([66.163.178.174]:30119 "HELO
	web34508.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030237AbWEYQDx (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 25 May 2006 12:03:53 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hi, I need general help with rs232, sharing serial cable in particular. I have one of systems
connected to pager system using rs232 I want to connect another system to pager system too but
there's only one rs232 input to it. I was thinking about splitting cable and connecting existing
and new systems to paging system my question is what would happen if both systems tried to send
data over serial connection at the same time? my guess is that messages would get corrupted and
nothing would go to the pagers if that's the case is there a device that would buffer message in
case if messages would arrive on rs232 input ports 1 and 2? I know that it takes like 1second to
send the message but I really need to make sure that everything is delivered.

thanks all for your help!

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
