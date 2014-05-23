From: Prasad Koya <prasad.koya@gmail.com>
Subject: UART_IIR_BUSY set for 16550A
Date: Fri, 23 May 2014 10:08:49 -0700
Message-ID: <CAGXD9Ocoo_sUnFmd-pfU52yUQ5oPjWxAHXjvP8facuMiOSUn5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ve0-f178.google.com ([209.85.128.178]:56838 "EHLO
	mail-ve0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752533AbaEWRIu (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 23 May 2014 13:08:50 -0400
Received: by mail-ve0-f178.google.com with SMTP id sa20so6645916veb.37
        for <linux-serial@vger.kernel.org>; Fri, 23 May 2014 10:08:49 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: gregkh@linuxfoundation.org

Hi

I don't see anyone in kernel using UART_IIR_BUSY bit except Designware
serial driver. We are using 8250 driver for our 16550A and
occasionally we see UART_IIR_BUSY set and soon after that console is
hosed. In what situations is this bit set? I don't see much
documentation for this.

Appreciate any help.

thank you.
