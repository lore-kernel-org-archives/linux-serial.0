From: Andreas Stricker <andreas.stricker@fela.ch>
Subject: Re: Help:Serial / Parallel Port Control Under Linux
Date: Mon, 06 Oct 2008 11:12:34 +0200
Message-ID: <48E9D682.3030204@fela.ch>
References: <709406A39EA948FCB5AE537FF0873FAD@johnny> <gc5a30$lup$1@ger.gmane.org> <4C87D88DE2D24B98846B72330EAE7229@johnny>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from ni.fela.ch ([87.245.122.82]:26064 "EHLO ni.fela.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752718AbYJFJoj (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 6 Oct 2008 05:44:39 -0400
Received: from localhost (ni.fela.ch [127.0.0.1])
	by ni.fela.ch (Postfix) with ESMTP id 3F0945E002
	for <linux-serial@vger.kernel.org>; Mon,  6 Oct 2008 11:12:46 +0200 (CEST)
Received: from ni.fela.ch ([127.0.0.1])
	by localhost (ni.fela.ch [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 08762-06-3 for <linux-serial@vger.kernel.org>;
	Mon, 6 Oct 2008 11:12:35 +0200 (CEST)
Received: from [192.168.139.198] (unknown [192.168.139.198])
	by ni.fela.ch (Postfix) with ESMTP id 1136F5E001
	for <linux-serial@vger.kernel.org>; Mon,  6 Oct 2008 11:12:35 +0200 (CEST)
In-Reply-To: <4C87D88DE2D24B98846B72330EAE7229@johnny>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

johnny schrieb:
> serialIO.c:195: error: `TIOCMGET' undeclared (first use in this function)

Did you include termios.h? (See `man ioctl_list`)

Regards,
Andy
