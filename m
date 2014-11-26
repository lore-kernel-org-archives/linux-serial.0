From: Guoqing Liu <lgqgood@gmail.com>
Subject: Uart2 can't work well after the system goto standby and then resume
 at csr primaII platform
Date: Wed, 26 Nov 2014 14:17:06 +0800
Message-ID: <CAMLw+SEMavUKc1-9mZA+-UJ=UJiBhBp=7=srNNqg-W74C=BLSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-qa0-f42.google.com ([209.85.216.42]:46130 "EHLO
	mail-qa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751245AbaKZGRH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 26 Nov 2014 01:17:07 -0500
Received: by mail-qa0-f42.google.com with SMTP id j7so1513146qaq.29
        for <linux-serial@vger.kernel.org>; Tue, 25 Nov 2014 22:17:06 -0800 (PST)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Daer Sir,
=E3=80=80=E3=80=80 I'm very sorry to trouble you.
     Recently I found the uart2 at csr primaII platform can't work
well after the system  goto standby and then resume.

My test environment is as follows=EF=BC=9A
     kernel:   3.10.16
     cpu:  csr primaII

 My test process is as follows :
   1> create a thread ,looped transmit data via uart2 every 3s.
   2>primaII goto  standby mode.
   3>primaII=E3=80=80goto  resume.
   4>capture the data at uart2 tx pin by the logic analyzer. you will
found  the data is error.
    =E3=80=80for example when looped send a test frame  : 5A A5 05 FA 1=
A 00 00
00 05 E2 A3 3A AA 55 77
        you will got : 5A A5 1A 00 00 00 05 E2 A3 3A AA 55 5C E0 77
or  5A A5 05 00 00 00 05 E2 A3 3A AA 55 77 E8 8B
        the result is not fixed.

 I also tried some tests  as follows:
   1> looped send data and do not goto  standby, the result is right.
   2> disable the uart2 dma at prima2.dtsi, the result is right.
   3> when the frame length is 4*n, the result is right. (for example
16, 20,24)

I also add some log at sirfsoc_uart.c:
  print the xmit buffer at  sirfsoc_uart_pio_rx_chars and
sirfsoc_uart_tx_with_dma.
  I found the data is right at uart driver. I also found that the
wrong data is  transmitted by the dma.


Thank you.
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
