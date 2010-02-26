From: Dan Carpenter <error27@gmail.com>
Subject: Re: [RESEND PATCH 2/2] serial: Add driver for the Altera UART
Date: Fri, 26 Feb 2010 22:50:22 +0300
Message-ID: <20100226195022.GF8417@bicker>
References: <1267108523-32767-1-git-send-email-tklauser@distanz.ch> <1267109261-752-1-git-send-email-tklauser@distanz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pz0-f172.google.com ([209.85.222.172]:40331 "EHLO
	mail-pz0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965902Ab0BZT6s (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 26 Feb 2010 14:58:48 -0500
Content-Disposition: inline
In-Reply-To: <1267109261-752-1-git-send-email-tklauser@distanz.ch>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Tobias Klauser <tklauser@distanz.ch>
Cc: linux-serial@vger.kernel.org, nios2-dev@sopc.et.ntust.edu.tw, linux-kernel@vger.kernel.org

A couple smatch complaints.

drivers/serial/altera_jtaguart.c
   380          if (co->index >= 0 && co->index <= ALTERA_JTAGUART_MAXPORTS)
   381                  co->index = 0;
   382          port = &altera_jtaguart_ports[co->index].port;

This test seems backward.  co->index == -1 would be a buffer underflow.

drivers/serial/altera_uart.c
   455          if ((co->index >= 0)
   456              && (co->index <= CONFIG_SERIAL_ALTERA_UART_MAXPORTS))
   457                  co->index = 0;
   458          port = &altera_uart_ports[co->index].port;

Same here.

regards,
dan carpenter
