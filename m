From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH][serial-next] serial: 8250: don't dereference em485
 until it has been null checked
Date: Tue, 29 Aug 2017 23:22:04 +0300
Message-ID: <1504038124.25945.155.camel@linux.intel.com>
References: <20170829165815.23429-1-colin.king@canonical.com>
         <20170829200411.wbqdsihcnhpg2gmr@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170829200411.wbqdsihcnhpg2gmr@mwanda>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>, Colin King <colin.king@canonical.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Phil Elwell <phil@raspberrypi.org>, Jan Kiszka <jan.kiszka@siemens.com>, Eric Anholt <eric@anholt.net>, Thor Thayer <tthayer@opensource.altera.com>, Rafael Gago <rafael.gago@gmail.com>, David Lechner <david@lechnology.com>, linux-serial@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Tue, 2017-08-29 at 23:04 +0300, Dan Carpenter wrote:
> On Tue, Aug 29, 2017 at 05:58:15PM +0100, Colin King wrote:
> > From: Colin Ian King <colin.king@canonical.com>
> > 
> > Currently, the pointer em485 is dereferenced to get p and then later
> > em485 is checked to see if it is null before calling __start_tx. In
> > the case where em485 is null, we get a null pointer dereference. Fix
> > this by moving the deference and the associated spinlock/unlocks on
> > p to the code block where em485 is known to be not null.
> > 
> > Detected by CoverityScan, CID#14555001 ("Dereference before null
> > check")
> > 
> > Fixes 6e0a5de2136b ("serial: 8250: Use hrtimers for rs485 delays")
> 
> I don't understand which tree this commit is from.  I have it fetched
> but when I do a git log on drivers/tty/serial/8250/8250_port.c then I
> don't see it.  I have today's linux-next.

I see it, though I have tty-next as well.


> I'm pretty sure "t" isn't ever NULL.

(I'm pretty sure there is a false positive, though code would be cleaned
to avoid such reports)

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
