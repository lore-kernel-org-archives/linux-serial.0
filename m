From: Karthik Manamcheri <karthik.manamcheri@gmail.com>
Subject: What's the rationale behind sending a Xoff character when the port is
 stopped ?
Date: Mon, 7 May 2012 15:00:50 -0500
Message-ID: <CAES2cWwz=JJY14rCX8_GwnD7Mgmweiz9xSUsw6z08YZ2zNHkqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:50031 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757566Ab2EGUBL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 7 May 2012 16:01:11 -0400
Received: by lbbgm6 with SMTP id gm6so3713475lbb.19
        for <linux-serial@vger.kernel.org>; Mon, 07 May 2012 13:01:10 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hi,

I noticed in drivers/tty/serial/8250.c that when we transmit
characters (by calling transmit_chars), we check for uart_tx_stopped
only after sending the x_char (if any). What's the rationale behind
this ? I would expect the uart not to send ANY characters (including a
Xoff character) if its throttled (or stopped).

--=20
Karthik Manamcheri
Software R&D=A0|=A0Instrument Control Products=A0|=A0National Instrumen=
ts
http://www.linkedin.com/in/kmanamcheri
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
