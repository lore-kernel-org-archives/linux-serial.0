From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] serial: 8250_dw: Avoid overflow in dw8250_set_termios
Date: Mon, 15 Jan 2018 22:30:32 +0200
Message-ID: <CAHp75VfBCTFcO=bysUQBaN-6sYa_1LO8XSzc4WY+X0_M_SZwsQ@mail.gmail.com>
References: <20180112134507.9030-1-ed.blake@sondrel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180112134507.9030-1-ed.blake@sondrel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ed Blake <ed.blake@sondrel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, nunojpg@gmail.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Fri, Jan 12, 2018 at 3:45 PM, Ed Blake <ed.blake@sondrel.com> wrote:
> When searching for an achievable input clock rate that is within
> +/-1.6% of an integer multiple of the target baudx16 rate, there is the
> potential to overflow the i * rate calculations.
>
> For example, on a 32-bit system with a baud rate of 4000000, the
> i * max_rate calculation will overflow if i reaches 67 without finding
> an acceptable rate.
>
> Fix this by setting the upper boundary of the loop appropriately to
> avoid overflow.
>

It seems the change broke Bluetooth on some Intel platforms. I'm not
sure yet, but
see here:

https://github.com/Dunedan/mbp-2016-linux/issues/29#issuecomment-357583782

And for me the change is odd.

Why by the way neither Heikki, nor me had been Cc'ed with the change?

Perhaps I need to submit something to maintainer data base.

For now I would rather revert it and give another try.

-- 
With Best Regards,
Andy Shevchenko
