From: Felicitus <felicitus@felicitus.org>
Subject: OXPCIe952: Kernel doesn't output messages to the serial port
Date: Wed, 06 Nov 2013 14:19:21 +0100
Message-ID: <527A41D9.5010906@felicitus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.felicitus.org ([5.9.234.88]:39853 "EHLO mail.felicitus.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932382Ab3KFNZF (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 6 Nov 2013 08:25:05 -0500
Received: from localhost (localhost [127.0.0.1])
	by mail.felicitus.org (Postfix) with ESMTP id 11C281BF828
	for <linux-serial@vger.kernel.org>; Wed,  6 Nov 2013 14:19:22 +0100 (CET)
Received: from mail.felicitus.org ([127.0.0.1])
	by localhost (mail.felicitus.org [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id ZNiYylDoxBMN for <linux-serial@vger.kernel.org>;
	Wed,  6 Nov 2013 14:19:21 +0100 (CET)
Received: from [IPv6:2a01:1e8:e100:8323:beae:c5ff:fe0a:5c6c] (unknown [IPv6:2a01:1e8:e100:8323:beae:c5ff:fe0a:5c6c])
	by mail.felicitus.org (Postfix) with ESMTPSA id 561891BF52F
	for <linux-serial@vger.kernel.org>; Wed,  6 Nov 2013 14:19:21 +0100 (CET)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hi,

I'm currently debugging broken kernel message output support for the
OXPCIe952 Serial Card.

My ticket is at [1], and I'm now stuck realizing what's actually going
on. Summary: The kernel doesn't output any messages via the serial
port, unless I invoke GNU screen on that port, after which the kernel
outputs messages nicely. The stty settings for /dev/ttyS1 are the
following after bootup:

stty -F /dev/ttyS1
speed 115200 baud; line = 0;
-brkint -imaxbel

After invoking screen with "screen /dev/ttyS1 115200", the stty
settings show up like this (and the kernel outputs messages nicely):

stty -F /dev/ttyS1
speed 115200 baud; line = 0;
kill = ^H; min = 100; time = 2;
-icrnl -imaxbel
-opost -onlcr
-isig -icanon -echo

Manually reverting to the original stty settings makes no difference
at that point; the kernel still happily outputs messages to the serial
port.

I'm a bit puzzled on where to start debugging; any pointers are
appreciated.

Regards
Felicitus

[1] https://bugzilla.kernel.org/show_bug.cgi?id=56941

