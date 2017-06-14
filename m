From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [PATCH] tty/serial: remove AVR32 specific access wrappers
Date: Wed, 14 Jun 2017 15:32:59 +0200
Message-ID: <20170614133259.y6jjonyi66qeb7r2@piout.net>
References: <20170613202517.26558-1-alexandre.belloni@free-electrons.com>
 <20170614104929.GA11313@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170614104929.GA11313@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Richard Genoud <richard.genoud@gmail.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 14/06/2017 at 12:49:29 +0200, Greg Kroah-Hartman wrote:
> On Tue, Jun 13, 2017 at 10:25:17PM +0200, Alexandre Belloni wrote:
> > Now that AVR32 is gone, the specific wrappers for that architecture are
> > unnecessary and will not be compiled anymore.
> > 
> > Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> > ---
> >  drivers/tty/serial/atmel_serial.c | 17 -----------------
> >  1 file changed, 17 deletions(-)
> 
> Does not apply to my tty-next tree at all :(
> 

That's fine, as Andy pointed out, he did the job.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
