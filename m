From: "Stuart MacDonald" <stuartm@connecttech.com>
Subject: Re: RS485 communicatio
Date: Sun, 16 Mar 2003 18:47:02 -0500
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <070201c2ec16$586a6ac0$294b82ce@connecttech.com>
References: <20030313061505.5944.qmail@indiainfo.com>
Return-path: <linux-serial-owner@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org
To: Linux PPP <linuxppp@indiainfo.com>, linux-serial@vger.kernel.org

From: "Linux PPP" <linuxppp@indiainfo.com>
> am currently working on PPP over serial interface (RS485) in linux
2.4.2-2. I believe RS485 half duplex system and hence only one can transmit
at a time. And for RS485 we basicaly use Master-Slave or Primary-Secondary
kind of communication. I don't know how to achieve the
[snip]
> This point to point communication worked fine with RS485 interface. If i
had to connect one more node what i need to do. Please clarify with the
following
>
> i) Whether the existing pppd takes care of the RS485 with multi node , if
so how do i manage giving commands

PPP is designed to connect two logical endpoints together. 485
multidrop is a one to many setup, which seems to me is logically
incompatible with PPP. At least, simultaneously.

..Stu

--
We make multiport serial boards.
<http://www.connecttech.com>
(800) 426-8979


