From: Eric Valette <eric.valette@free.fr>
Subject: ST16C554 Serial device driver
Date: Tue, 21 Sep 2004 12:40:08 +0200
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <41500508.9010004@free.fr>
Reply-To: eric.valette@free.fr
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from [217.167.0.1] ([217.167.0.1]:20111 "EHLO mail.basystemes.fr")
	by vger.kernel.org with ESMTP id S267551AbUIUKkJ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 21 Sep 2004 06:40:09 -0400
List-Id: linux-serial@vger.kernel.org
To: rmk+serial@arm.linux.org.uk
Cc: linux-serial@vger.kernel.org

Hi,

Sorry to annoy you with one small question : I'm currently working as a
contractor to port an application from LynxOS to linux 2.6 and I'm
annoyed with the serial driver code. I need to find a driver for a 
ST16C554 quad serial ISA board. I've tried to use setserial with the 
relevant IO ports and irq but cannot manage to output annything on the 
PC 104 board.

The setting multiplex the same IRQ (10) for the four ports. Do you have
any hint, advice.

Thanks for your help,


-- 
    __
   /  `                   	Eric Valette
  /--   __  o _.          	6 rue Paul Le Flem
(___, / (_(_(__         	35740 Pace

Tel: +33 (0)2 99 85 26 76	Fax: +33 (0)2 99 85 26 76
E-mail: eric.valette@free.fr

