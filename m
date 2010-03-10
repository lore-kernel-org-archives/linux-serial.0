From: rogerx@sdf.org
Subject: 'struct uart_port' has no member named 'info
Date: Wed, 10 Mar 2010 02:33:47 -0900
Message-ID: <20100310113347.GA8342@localhost2.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from denali.acsalaska.net ([209.112.173.242]:54815 "EHLO
	denali.acsalaska.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755842Ab0CJLkA (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 10 Mar 2010 06:40:00 -0500
Received: from localhost2.local (66-230-101-204-rb1.fai.dsl.dynamic.acsalaska.net [66.230.101.204])
	by denali.acsalaska.net (8.14.3/8.14.3) with ESMTP id o2ABXlIl072518
	for <linux-serial@vger.kernel.org>; Wed, 10 Mar 2010 02:33:47 -0900 (AKST)
	(envelope-from rogerx@sdf.org)
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Upgraded from kernel-2.6.32 to kernel-2.6.33, and now get the following
error when compiling ltmodem.

/var/tmp/portage/net-dialup/ltmodem-20090420/work/ltmodem/v8250.c: In
function 'receive_chars':
/var/tmp/portage/net-dialup/ltmodem-20090420/work/ltmodem/v8250.c:181:
error: 'struct uart_port' has no member named 'info'
/var/tmp/portage/net-dialup/ltmodem-20090420/work/ltmodem/v8250.c: In
function 'transmit_chars':
/var/tmp/portage/net-dialup/ltmodem-20090420/work/ltmodem/v8250.c:243:
error: 'struct uart_port' has no member named 'info'
/var/tmp/portage/net-dialup/ltmodem-20090420/work/ltmodem/v8250.c: In
function 'check_modem_status':
/var/tmp/portage/net-dialup/ltmodem-20090420/work/ltmodem/v8250.c:284:
error: 'struct uart_port' has no member named 'info'
/var/tmp/portage/net-dialup/ltmodem-20090420/work/ltmodem/v8250.c:294:
error: 'struct uart_port' has no member named 'info'
make[2]: ***
[/var/tmp/portage/net-dialup/ltmodem-20090420/work/ltmodem/v8250.o]
Error 1


I checked for changes within drivers/serial/serial_core.c, but couldn't
find the specific change.  (I did verify ltmodem compiles fine without
error under 2.6.32.)

-- 
Roger
http://rogerx.freeshell.org/
