From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH][serial-next] serial: 8250: don't dereference em485
 until it has been null checked
Date: Tue, 29 Aug 2017 22:57:37 +0300
Message-ID: <1504036657.25945.153.camel@linux.intel.com>
References: <20170829165815.23429-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <20170829165815.23429-1-colin.king@canonical.com>
Sender: kernel-janitors-owner@vger.kernel.org
To: Colin King <colin.king@canonical.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Phil Elwell <phil@raspberrypi.org>, Jan Kiszka <jan.kiszka@siemens.com>, Eric Anholt <eric@anholt.net>, Thor Thayer <tthayer@opensource.altera.com>, Rafael Gago <rafael.gago@gmail.com>, David Lechner <david@lechnology.com>, linux-serial@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Tue, 2017-08-29 at 17:58 +0100, Colin King wrote:

> Currently, the pointer em485 is dereferenced to get p and then later
> em485 is checked to see if it is null before calling __start_tx. In
> the case where em485 is null, we get a null pointer dereference. Fix
> this by moving the deference and the associated spinlock/unlocks on
> p to the code block where em485 is known to be not null.

>  static enum hrtimer_restart serial8250_em485_handle_start_tx(struct
> hrtimer *t)
>  {
>  	struct uart_8250_em485 *em485;
> -	struct uart_8250_port *p;
>  	unsigned long flags;
>  	em485 = container_of(t, struct uart_8250_em485,
> start_tx_timer);
> -	p = em485->port;
>  
> -	spin_lock_irqsave(&p->port.lock, flags);
>  	if (em485 &&
>  	    em485->active_timer == &em485->start_tx_timer) {
> +		struct uart_8250_port *p = em485->port;
> +
> +		spin_lock_irqsave(&p->port.lock, flags);

Can you describe, please, what on your opinion is protected by this
lock?

>  		__start_tx(&p->port);
>  		em485->active_timer = NULL;
> +		spin_unlock_irqrestore(&p->port.lock, flags);
>  	}
> -	spin_unlock_irqrestore(&p->port.lock, flags);
>  	return HRTIMER_NORESTART;
>  }
>  

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
