From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: Re: [PATCH] braille-console: Fix value returned by
 _braille_console_setup
Date: Sun, 19 Mar 2017 16:50:49 +0100
Message-ID: <20170319155049.ea7uau3gqkpnmemt@var.youpi.perso.aquilenet.fr>
References: <20170319143726.p6motwasbc2lfdao@var.youpi.perso.aquilenet.fr>
 <0e1043b5-c585-5f4a-cde7-1afd60c0db56@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <0e1043b5-c585-5f4a-cde7-1afd60c0db56@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Aleksey Makarov <aleksey.makarov@linaro.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Petr Mladek <pmladek@suse.com>, Ming Lei <ming.lei@canonical.com>, linux-serial@vger.kernel.org, Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Aleksey Makarov, on dim. 19 mars 2017 18:44:23 +0300, wrote:
> On 03/19/2017 05:37 PM, Samuel Thibault wrote:
> > commit bbeddf52adc1 ("printk: move braille console support into
> > separate braille.[ch] files") introduced _braille_console_setup()
> > to outline the braille initialization code.  There was however some
> > confusion over the value it was supposed to return. commit 2cfe6c4ac7ee
> > ("printk: Fix return of braille_register_console()") tried to fix it
> > but failed to.
> > 
> > This fixes and documents the returned value according to the use
> > in printk.c: non-zero return means a parsing error, and thus this
> > console configuration should be ignored.
> 
> Did you test the code on real braille hardware?

Not on actual hardware, but I checked that the output on the serial port
is what is expected.

> I am asking because there could also be other problems with the code
> that have not been run for 3 years since it was changed.

The code which actually implements the braille protocol has not changed
since it was tested.

Samuel
