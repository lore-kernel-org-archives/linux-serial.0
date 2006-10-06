From: Jean-Baptiste Maneyrol <MANE@teamlog.com>
Subject: [PATCH] serial 8250.c: size_fifo tries to read write-only FCR register
Date: Fri, 6 Oct 2006 10:07:06 +0200
Message-ID: <49d7b13cc2d4e36b15e3f7f87ed46b5d@62.160.172.64>
Reply-To: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@teamlog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp-paris1.teamlog.com ([213.41.116.90]:53475 "EHLO
	au-ml2.teamlog.fr") by vger.kernel.org with ESMTP id S1750741AbWJFIDb
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 6 Oct 2006 04:03:31 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: rmk+serial@arm.linux.org.uk

The function size_fifo wants to backup the FCR register by reading it, but
it is a write-only register. A read to this adress returns the IIR register.
The size_fifo function is only used during autoconfig, and after autoconfig
the FIFO are cleared and deactivated, so we don't need to save FCR.

Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@teamlog.com>


________________________________________________
Message sent using UebiMiau 2.7.9


