From: Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH] serial: fix kernel-doc warnings in 8250.c
Date: Sat, 9 Jun 2012 11:59:02 +0100
Message-ID: <20120609115902.65fe131e@bob.linux.org.uk>
References: <4FD2AC1B.6070500@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4FD2AC1B.6070500@xenotime.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-serial@vger.kernel.org

On Fri, 08 Jun 2012 18:51:23 -0700
Randy Dunlap <rdunlap@xenotime.net> wrote:

> From: Randy Dunlap <rdunlap@xenotime.net>
> 
> Fix kernel-doc warnings in drivers/tty/serial/8250/8250.c:
> 
> Warning(drivers/tty/serial/8250/8250.c:3128): No description found
> for parameter 'up' Warning(drivers/tty/serial/8250/8250.c:3128):
> Excess function parameter 'port' description in
> 'serial8250_register_8250_port'
> 
> Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>

Acked-by: Alan Cox <alan@linux.intel.com>
