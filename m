From: henrique <henrique@cyclades.com>
Subject: Re: A new serial baud rate
Date: Fri, 26 Jul 2002 10:14:45 -0300
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <200207260921.20600.henrique@cyclades.com>
References: <1779CCD227485B49A825718AAAA90E3E406CD4@tpsmail01.turbopower.net>
Reply-To: henrique@cyclades.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from henrique (henrique.cyclades.com.br [200.246.93.86])
	by firewall.cyclades.com.br (8.9.3/8.9.3) with ESMTP id KAA14521
	for <linux-serial@vger.kernel.org>; Fri, 26 Jul 2002 10:32:49 -0300
In-Reply-To: <1779CCD227485B49A825718AAAA90E3E406CD4@tpsmail01.turbopower.net>
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hello !!!

After the last e-mails about this issue I've checked the equipment. I am not 
actually dealing with a modem, I'm dealing with a mux/demux which is 
connected to a modem. The demux has 20 ports and 5 of these ports have the
mentioned speed. I have a multi-serial board that uses the UART 16550A.

I plan to make this implementation, firstly using a ioctl as suggested by  
Matti Aarnio, and afterwards changing the termios.h, task that I believe to 
be harder than the first one.

Ed, unfortunately my equipment uses the 2.2.14 kernel. Does your suggestion 
work in such kernel ? It would be the easiest way to solve this.

regards
Henrique

On Thursday 25 July 2002 05:26 pm, Gary Frerking wrote:
> Henrique,
>
> >> That's the problem. I can't change the modem configuration cause this
>
> modem are provided by the Telco. I have to use this baud rate. And I
> wanna use it with Linux. <<
>
> I've never run across a modem that requires a 14400 baud rate on the
> serial line. I *have* run across many, many people *thinking* they need
> 14400 on the serial line because it's a 14400 modem (is this for faxing?
> 14400 often comes up in relation to faxing).
>
> We obviously have no way of knowing more about what you're dealing with
> than what you're able/willing to tell us -- but based on past
> experience, I'm skeptical about the fact that you need 14400 on the
> serial line.
>
> Can you provide more details about the modem itself? Do you have a model
> number? What are you using it for?
>
> -- Gary

-- 
---
Henrique Gobbi
Software Engineer
+55 11 50333339
Cyclades Corporation - The Leader in Linux Connectivity
