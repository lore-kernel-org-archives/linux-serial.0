From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: re: TTY: switch tty_insert_flip_char
Date: Mon, 16 Dec 2013 12:44:10 +0300
Message-ID: <20131216094410.GA13831@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:24263 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751112Ab3LPJoY (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 16 Dec 2013 04:44:24 -0500
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: jslaby@suse.cz
Cc: linux-serial@vger.kernel.org

Hello Jiri Slaby,

The patch 92a19f9cec9a: "TTY: switch tty_insert_flip_char" from
Jan 3, 2013, leads to the following static checker warning:
	drivers/tty/serial/sc26xx.c:189 receive_chars()
	error: potential NULL dereference 'tport'.

drivers/tty/serial/sc26xx.c
   139  static bool receive_chars(struct uart_port *port)
   140  {
   141          struct tty_port *tport = NULL;
   142          int limit = 10000;
   143          unsigned char ch;
   144          char flag;
   145          u8 status;
   146  
   147          /* FIXME what is this trying to achieve? */
   148          if (port->state != NULL)                /* Unopened serial console */
   149                  tport = &port->state->port;

"tport" can be NULL if port->state is NULL.  It's not clear if this is
actually possible.

   150  

[ snip ]

   182  
   183                  if (uart_handle_sysrq_char(port, ch))
   184                          continue;
   185  
   186                  if (status & port->ignore_status_mask)
   187                          continue;
   188  
   189                  tty_insert_flip_char(tport, ch, flag);
   190          }
   191          return !!tport;


regards,
dan carpenter

