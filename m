From: Subodh Nijsure <nijsure.subodh@gmail.com>
Subject: bad serial port count when trying to login
Date: Wed, 7 Mar 2012 11:48:29 -0800
Message-ID: <CAMFeL9+jmN9GWfrhkbd+VP-CWH2VjHpUcWr4Sw4TOv+3YRKC7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:51624 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760026Ab2CGTs3 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 7 Mar 2012 14:48:29 -0500
Received: by iagz16 with SMTP id z16so9043842iag.19
        for <linux-serial@vger.kernel.org>; Wed, 07 Mar 2012 11:48:29 -0800 (PST)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hello,

I have ARM based board (iMX28 processor) that has two serial ports one
of them runs console on port /dev/ttyAMA0 and I am able to login and
everything works fine.

However when I try to manually run getty on other serial port, using command:

nohup getty -l "/bin/login" 9600 /dev/ttyAPP3 &

my current login session on /dev/ttyAMA0 gets terminated  I see following error,

uart_close: bad serial port count; tty->count is 1, port->count is 2
uart_close: bad serial port count; tty->count is 1, port->count is 0


I am running 3.1.0-rc5 kernel.

Can someone give me clues as to why this might be and clues on fixing it.

Thanks!

-Subodh
