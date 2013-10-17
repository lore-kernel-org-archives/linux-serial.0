From: Randy Witt <rewitt@declaratino.com>
Subject: serial_core: deadlock when configuring kgdboc on ttyS0
Date: Thu, 17 Oct 2013 16:56:46 -0400
Message-ID: <1382043407-2699-1-git-send-email-rewitt@declaratino.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from p3plsmtpa08-09.prod.phx3.secureserver.net ([173.201.193.110]:47613
	"EHLO p3plsmtpa08-09.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1762260Ab3JQVDb (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 17 Oct 2013 17:03:31 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org

If I configure kgdboc to use ttyS0 while writing to the console on ttyS0, I
sometimes get a deadlock. This using 3.11.5 on x86_64.

The way to most easily reproduce the deadlock is to set "console=ttyS0" on the
kernel command line, run a shell on ttyS0, and also run the following
script.

    #!/bin/sh
    sh -c 'i=0; while true; do echo $i; i=$((i+1)); done' &
    sh -c 'while true; do echo "ttyS0,38400" > /sys/module/kgdboc/parameters/kgdboc; done'

It should deadlock fairly quickly. The following email is a potential patch
that seems to prevent the deadlock, but my knowledge of the inner workings
of tty is limited. Please let me know if you need more information to reproduce
the deadlock.
