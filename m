From: Eric Valette <eric.valette@free.fr>
Subject: Re: ST16C554 Serial device driver
Date: Wed, 22 Sep 2004 13:51:59 +0200
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <4151675F.3040901@free.fr>
References: <41500508.9010004@free.fr> <20040921130957.B16836@flint.arm.linux.org.uk> <4150200F.7020407@free.fr>
Reply-To: eric.valette@free.fr
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from [217.167.0.1] ([217.167.0.1]:25237 "EHLO mail.basystemes.fr")
	by vger.kernel.org with ESMTP id S264704AbUIVLv7 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 22 Sep 2004 07:51:59 -0400
In-Reply-To: <4150200F.7020407@free.fr>
List-Id: linux-serial@vger.kernel.org
To: eric.valette@free.fr
Cc: Russell King <rmk@arm.linux.org.uk>, linux-serial@vger.kernel.org


> What is more suspect is the 0x287 (0x2a7) and register address that is 
> described in the manufacturer documentation of the PC104 board that says 
> : "When the same IRQ is shared by the 4 ports, the card uses 2 registers 
> at 287H, one to valid the interrupts and the other to read back the 4 
> interrupt status". The attached pictures gives the signification of the 

Enabling the IRQ via the additionnal 0x287 port, makes the driver 
receive interrupt and work. I have added a samm program that is called 
at the end of init setserial command...

-- 
    __
   /  `                   	Eric Valette
  /--   __  o _.          	6 rue Paul Le Flem
(___, / (_(_(__         	35740 Pace

Tel: +33 (0)2 99 85 26 76	Fax: +33 (0)2 99 85 26 76
E-mail: eric.valette@free.fr
