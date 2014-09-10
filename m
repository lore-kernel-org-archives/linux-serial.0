From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 00/16 v9] omap 8250 based uart + DMA
Date: Wed, 10 Sep 2014 21:29:55 +0200
Message-ID: <1410377411-26656-1-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:35366 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750967AbaIJTaV (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 10 Sep 2014 15:30:21 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, balbi@ti.com, gregkh@linuxfoundation.org

the diff of v8=E2=80=A6v9 is small:
- rebased on top's of Greg's tty-next branch
- fixed #10 where we might have THRE interrupt enabled for longer than
  needed
- re-did register setup in #10. Before this "less file" could freeze th=
e
  am335x-evm.

Sebastian

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
