From: rogerx@sdf.org
Subject: Re: 'struct uart_port' has no member named 'info
Date: Wed, 10 Mar 2010 15:49:32 -0900
Message-ID: <20100311004932.GD7377@localhost2.local>
References: <20100310113347.GA8342@localhost2.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from denali.acsalaska.net ([209.112.173.242]:25512 "EHLO
	denali.acsalaska.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932973Ab0CKAtf (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 10 Mar 2010 19:49:35 -0500
Received: from localhost2.local (66-230-101-204-rb1.fai.dsl.dynamic.acsalaska.net [66.230.101.204])
	by denali.acsalaska.net (8.14.3/8.14.3) with ESMTP id o2B0nW3x048080
	for <linux-serial@vger.kernel.org>; Wed, 10 Mar 2010 15:49:33 -0900 (AKST)
	(envelope-from rogerx@sdf.org)
Content-Disposition: inline
In-Reply-To: <20100310113347.GA8342@localhost2.local>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

On Wed, Mar 10, 2010 at 02:33:47AM -0900, rogerx@sdf.org wrote:
>Upgraded from kernel-2.6.32 to kernel-2.6.33, and now get the following
>error when compiling ltmodem.
>
>/var/tmp/portage/net-dialup/ltmodem-20090420/work/ltmodem/v8250.c: In
>function 'receive_chars':
>/var/tmp/portage/net-dialup/ltmodem-20090420/work/ltmodem/v8250.c:181:
>error: 'struct uart_port' has no member named 'info'

Sorry.  These changes were already found and patched for kernel-2.6.32!

I just happened to spend the last 12 hours finding all the new variable
names and writing a new patch -- while the patch was already written.
:-/


For reference for those doing a Google search:

-   struct tty_struct *tty = up->port.info->port.tty;
+   struct tty_struct *tty = up->port.state->port.tty

-   struct circ_buf *xmit = &up->port.info->xmit;
+   struct circ_buf *xmit = &up->port.state->xmit;

-       wake_up_interruptible(&up->port.info->delta_msr_wait);
+       wake_up_interruptible(&up->port.state->port.delta_msr_wait)

-- 
Roger
http://rogerx.freeshell.org/
