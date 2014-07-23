From: Dirk Behme <dirk.behme@gmail.com>
Subject: Mainline commit "serial: Test for no tx data on tx restart" not correct
 for i.MX6?
Date: Wed, 23 Jul 2014 06:10:01 +0200
Message-ID: <53CF3599.6040509@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:54820 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754537AbaGWEKI (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 23 Jul 2014 00:10:08 -0400
Received: by mail-wi0-f182.google.com with SMTP id d1so1466510wiv.15
        for <linux-serial@vger.kernel.org>; Tue, 22 Jul 2014 21:10:07 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>, Huang Shijie <b32955@freescale.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Wang, Jiada" <Jiada_Wang@mentor.com>, Dirk Behme <dirk.behme@de.bosch.com>

Hi,

this is a question regarding the i.MX6 part (drivers/tty/serial/imx.c) 
of the commit

serial: Test for no tx data on tx restart

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=c557d392fbf5badd693ea1946a4317c87a26a716

Talking with some i.MX6 experts about this, I've got the comment

-- cut --
The imx serial driver part of this commit isn't correct
as imx.c sends x_char in irq handler, not in imx_start_tx(),
-- cut --

What do you think?

Best regards

Dirk


P.S.: I don't have the initial post in my inbox, so sorry for the new 
thread.
