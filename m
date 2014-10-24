From: Sifan Naeem <Sifan.Naeem@imgtec.com>
Subject: Synopsys DesignWare 8250 serial port driver, DMA issue
Date: Fri, 24 Oct 2014 15:53:00 +0000
Message-ID: <A0E307549471DA4DBAF2DE2DE6CBFB7E494E9C19@hhmail02.hh.imgtec.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailapp01.imgtec.com ([195.59.15.196]:29029 "EHLO
	mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756615AbaJXPxG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 24 Oct 2014 11:53:06 -0400
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
	by Websense Email Security Gateway with ESMTPS id 675FBBB2CBE0
	for <linux-serial@vger.kernel.org>; Fri, 24 Oct 2014 16:52:59 +0100 (IST)
Content-Language: en-US
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

Hi,

I'm trying to test the DMA capability of the UART Linux driver which was 
written by Synopsys (DesignWare 8250 driver) drivers/tty/serial/8250/

As it is even when the DMA capability for the UART driver is enabled by 
the Kernel, the driver does not initialize or try to use 
DMA mode. 

Did I miss something? do I have to enable something else?

Thanks,
Sifan

