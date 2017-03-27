From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCHv2] braille-console: Fix value returned by
 _braille_console_setup
Date: Tue, 28 Mar 2017 00:43:41 +0900
Message-ID: <20170327154341.GA996@tigerII.localdomain>
References: <20170326204736.65jjbfrfvammgxqy@var.youpi.perso.aquilenet.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170326204736.65jjbfrfvammgxqy@var.youpi.perso.aquilenet.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Samuel Thibault <samuel.thibault@ens-lyon.org>, Petr Mladek <pmladek@suse.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Ming Lei <ming.lei@canonical.com>, Aleksey Makarov <aleksey.makarov@linaro.org>, linux-serial@vger.kernel.org, Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
List-Id: linux-serial@vger.kernel.org

On (03/26/17 22:47), Samuel Thibault wrote:
> commit bbeddf52adc1 ("printk: move braille console support into
> separate braille.[ch] files") introduced _braille_console_setup()
> to outline the braille initialization code.  There was however some
> confusion over the value it was supposed to return. commit 2cfe6c4ac7ee
> ("printk: Fix return of braille_register_console()") tried to fix it
> but failed to.
> 
> This fixes and documents the returned value according to the use
> in printk.c: non-zero return means a parsing error, and thus this
> console configuration should be ignored.

I just found this patch in my gmail "spam" folder.

sorry.


the patch looks OK to me.

btw, is there any reason why _braille_console_setup() and
_braille_register_console()/_braille_unregister_console()
names start with a dash? do we also want to "clean this up"?
well since we are at it.

	-ss
