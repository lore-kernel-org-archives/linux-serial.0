From: Stefan Wahren <info@lategoodbye.de>
Subject: serial/mxs-auart: Unable to get interrupt counter from user space
Date: Sat, 23 Jun 2012 21:19:40 +0200
Message-ID: <4FE616CC.9000709@lategoodbye.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from www.augenpunkt.de ([213.239.207.9]:46970 "EHLO
	www.augenpunkt.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755107Ab2FWTkz (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 23 Jun 2012 15:40:55 -0400
Received: from [192.168.1.2] (178-25-74-249-dynip.superkabel.de [178.25.74.249])
	by www.augenpunkt.de (Postfix) with ESMTP id 957C49190F
	for <linux-serial@vger.kernel.org>; Sat, 23 Jun 2012 21:16:02 +0200 (CEST)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hello,

i'm using Linux 2.6.35 at ARM and i experience the following issue with 
the mxs-auart (App UART). If i transmit and receive data over the serial 
port (using mxs-auart), all the interrupt counter (RX, TX, frame, 
parity, break) accessed from user space (ioctl with TIOCGICOUNT or 
/proc/tty/driver/auart) are zero.

Here is the scenario to reproduce the problem:

1. echoing some characters to the uart device
2. fetch the statistics from proc-Filesystem

Expected results: transmit counter greater than zero

Observed results: transmit counter is always zero

The same szenario on the mxs-duart (Debug UART) doesn't show this problem.

Is this a bug in mxs-auart or just not implemented?


Best Regards
Stefan
