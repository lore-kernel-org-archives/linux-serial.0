From: Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH] tty/serial: do not free trasnmit buffer page under port
 lock
Date: Thu, 13 Dec 2018 10:42:33 +0100
Message-ID: <20181213094233.4nr2pa25tlczpvft@pathway.suse.cz>
References: <20181213045839.9692-1-sergey.senozhatsky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181213045839.9692-1-sergey.senozhatsky@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Waiman Long <longman@redhat.com>, Dmitry Safonov <dima@arista.com>, Steven Rostedt <rostedt@goodmis.org>
List-Id: linux-serial@vger.kernel.org

On Thu 2018-12-13 13:58:39, Sergey Senozhatsky wrote:
> LKP has hit yet another circular locking dependency between uart
> console drivers and debugobjects [1]:
> 
> The patch fixes transmit buffer page free() in uart_shutdown() and,
> additionally, in uart_port_startup() (as was suggested by Dmitry Safonov).
> 
> [1] https://lore.kernel.org/lkml/20181211091154.GL23332@shao2-debian/T/#u
> Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
