From: Manuel Jander <manuel.jander@gmail.com>
Subject: Serial buffer question
Date: Sun, 18 Jul 2010 21:36:05 +0200
Message-ID: <AANLkTin5vNE41jUX4m-sdc4L31I8D5m1UJnDNp1sL2ld@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:41152 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757153Ab0GRTgH (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 18 Jul 2010 15:36:07 -0400
Received: by ewy23 with SMTP id 23so1134521ewy.19
        for <linux-serial@vger.kernel.org>; Sun, 18 Jul 2010 12:36:05 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hi there,

some time ago I wrote a serial loop back driver which creates serial
port pairs, which sent its data to the other, thus like acting like a
cable, but with the possibilty to listen what is being transmitted :)
It also supports local echo, to simulate single wire (ODB) interfaces.

Until linux 2.6.24 it worked well, know running 2.6.33.2 somehow the
flip buffer contents somehow grow in an uncontrolled way.

Below, the main part of the driver. For one virtual loop serial port
pair this function is called twice using a timer. tty_xmit and
tty_recv are the serial port pair, exchanged accordingly to which port
turn it is to be served.

  while (!uart_circ_empty(xmit) && lifeboat < 100)
  {
    char ch;

    ch = xmit->buf[xmit->tail];

    dbg("tx(%d) %02x\n", i, ch);

    if ( do_rx & (1<<ii) && tty_recv != NULL ) {
      /* TX to counterpart port */
      rport->icount.rx++;
      tty_insert_flip_char(tty_recv, ch, TTY_NORMAL);
      rxpush = 1;
    }

    if (do_echo && (do_rx & (1<<i)) ) {
      xport->icount.rx++;
      tty_insert_flip_char(tty_xmit, ch, TTY_NORMAL);
      echo_push = 1;
    }

    xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
    xport->icount.tx++;

    lifeboat++;
  }

The problem: the flip buffer of "xmit" grows all the time until
"lifeboat" terminates the while loop. Could it be that
tty_insert_flip_char() now affects inmediately the fill level of the
xmit circular buffer and for earlier kernel versions this was somehow
delayed ? Should I buffer the local echo char somewhere (when do_echo
== 1) and call tty_insert_flip_char() outside the while loop ?

I would be really glad if somebody could explain what happen from
2.6.24 to 2.6.33.2 Thanks a lot in advance.

Cheers,
Manuel
