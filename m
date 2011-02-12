From: Richard Zhao <linuxzsc@gmail.com>
Subject: uart ops tx_empty lock
Date: Sat, 12 Feb 2011 21:16:45 +0800
Message-ID: <AANLkTimpEcfmJ5SF_YpG1mE0eBiARQ7L17Pd+ay_OQoV@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:38958 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751640Ab1BLNQr (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 12 Feb 2011 08:16:47 -0500
Received: by wyb28 with SMTP id 28so3378051wyb.19
        for <linux-serial@vger.kernel.org>; Sat, 12 Feb 2011 05:16:45 -0800 (PST)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@suse.de>
Cc: linux-serial@vger.kernel.org

Hi Greg,

Does uart_ops.tx_empty need to hold port->lock?
I find some drivers hold the lock in tx_empty hook, for example 8250.
But many more drivers don't hold it, for example imx.c, sh-sci.c.

Thanks
Richard
