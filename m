From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2] serial: 8250: convert to threaded IRQ
Date: Tue, 28 Nov 2017 15:26:27 +0100
Message-ID: <20171128142627.GB17797@kroah.com>
References: <20171115124002.32039-1-dzagorui@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171115124002.32039-1-dzagorui@cisco.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Denys Zagorui <dzagorui@cisco.com>
Cc: jslaby@suse.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Wed, Nov 15, 2017 at 02:40:02PM +0200, Denys Zagorui wrote:
> During using virtualization it is common to see
> many "too much work for irq*" messages.
> 
> There are fixes proposed erlier:
> -  e7328ae1848966181a7ac47e8ae6cddbd2cf55f3 (serial:
>    8250, increase PASS_LIMIT)
> -  f4f653e9875e573860e783fecbebde284a8626f5 (serial:
>    8250, disable "too much work" messages
> 
> First one doesn't help now, last one was reverted
> (12de375ec493ab1767d4a07dde823e63ae5edc21) in fact
> it doesn't fix anything. So procesing interrupts in
> kthread give us an opportunity to perform rescheduling
> periodically.
> 
> Cc: Jiri Slaby <jslaby@suse.com>
> Signed-off-by: Denys Zagorui <dzagorui@cisco.com>
> ---
>  drivers/tty/serial/8250/8250_core.c | 28 +++++++++++++++++++++-------
>  1 file changed, 21 insertions(+), 7 deletions(-)

Always say what changed from v1 below the --- line, otherwise we have no
idea.

v3?
