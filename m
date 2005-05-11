From: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>
Subject: abusing early serial console init for resume
Date: Wed, 11 May 2005 05:15:36 +0200
Message-ID: <428178D8.3040302@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from pop.gmx.de ([213.165.64.20]:62392 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261890AbVEKDPk (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 10 May 2005 23:15:40 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hi,

is it possible to use the code from drivers/serial/8250_early.c
to make the serial console work again during resume from
suspend-to-RAM? It seems my serial port loses its state during
suspend and for debugging poweron crashes having a working
serial console is absolutely essential.

Having working suspend/resume in the generic serial driver
would be great, too, but I'm not demanding that. I'll settle
for any hackish solution which brings my serial console back
before the system has a chance to commit suicide.

At a first glance, it seems removing __init from all
functions in 8250_early.c and calling early_uart_setup during
resume could work just fine.

Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/
