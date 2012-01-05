From: Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH] serial: relocate remaining serial drivers from tty/ to
 tty/serial/
Date: Thu, 5 Jan 2012 12:45:05 +0000
Message-ID: <20120105124505.73c88f2c@bob.linux.org.uk>
References: <1325707287-31038-1-git-send-email-paul.gortmaker@windriver.com>
	<4F04BFA8.9010100@windriver.com>
	<20120104220332.GA22985@suse.de>
	<201201042327.33739.arnd@arndb.de>
	<20120105054240.GA9093@merkur.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:7548 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755248Ab2AEMcJ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 5 Jan 2012 07:32:09 -0500
In-Reply-To: <20120105054240.GA9093@merkur.ravnborg.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Greg KH <gregkh@suse.de>, Paul Gortmaker <paul.gortmaker@windriver.com>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jirislaby@gmail.com>

> drivers/tty/serial_core  <= drivers based on SERIAL_CORE
> drivers/tty/serial       <= the rest
> 
> This makes it obvious that one directory is for drivers based on
> SERIAL_CORE - and the other is sort of the "rest".
> 
> I know this imply moving files around again :-(

And putting one lot where the other were. Merge time is closed so we've
got plenty of time to sort this right. For the moment can we just tidy
up 8250, then think about it in more detail rather than play musical
chairs ?

Alan
