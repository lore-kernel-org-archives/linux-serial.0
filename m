From: Tomas Lastovicka <tomas.lastovicka@gmail.com>
Subject: RS-485 automatic RTS toggle in Linux (on Winbond W83627UHG)
Date: Tue, 29 Nov 2011 12:20:01 -0500
Message-ID: <CAFnDbmD-LG1O45d9s8GPxcbmjeFJ=vSp450oJ_75ooxBMtZFCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-qw0-f53.google.com ([209.85.216.53]:53681 "EHLO
	mail-qw0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751944Ab1K2RUD (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 29 Nov 2011 12:20:03 -0500
Received: by qao25 with SMTP id 25so524776qao.19
        for <linux-serial@vger.kernel.org>; Tue, 29 Nov 2011 09:20:02 -0800 (PST)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hi,

i am trying to use a Linux running embedded PC with built-it RS-485
port as a master to control one slave device. My problem is the usual
one, i can not figure out how to perform an automatic RTS toggle. I.e.
to send data to 485 and after the last byte was sent, quickly switch
to the read mode (but not from my code in the user space). The Linux
kernel is 2.6.32 and an automatic RTS toggle is not natively
supported. Googling this issue around, i found a couple of suggestions
but no solution (except drivers for Atmel and Etrax since kernel
2.6.38).

Does anyone has experience with RS-485 in embedded real-time Linux
PCs? The chip used is Winbond W83627UHG and looking into its
documentation, it is not obvious to me how to handle the RTS toggle
properly. I can write and read to/from 485 but i have to toggle RTS by
hand from my code, which is not what i want to do and it does not
quite work with the slave device either.

Cheers,

Tomas
