From: Richard Genoud <richard.genoud@gmail.com>
Subject: Re: [PATCH] tty/serial: atmel: use port->name as name in request_irq()
Date: Fri, 27 Apr 2018 12:31:52 +0200
Message-ID: <0dbf4a4c-71d4-6456-67b9-d4d202acffb7@sorico.fr>
References: <20180426150625.q5tqcb7fzchvkb5d@linutronix.de>
 <20180426151222.6vw67lwqmu6ffgnw@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180426151222.6vw67lwqmu6ffgnw@linutronix.de>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-serial@vger.kernel.org
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, Peter Hurley <peter@hurleysoftware.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Hi Sebastian,

On 26/04/2018 17:12, Sebastian Andrzej Siewior wrote:
> On 2018-04-26 17:06:25 [+0200], To linux-serial@vger.kernel.org wrote:
>> It seems not to happen in v4.1.51 but it happens in v4.9 and v4.17-rc2
>> so if it broke accidentally it was not recently.
> 
> This is what I used to check:
> 
> diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
> --- a/drivers/tty/tty_io.c
> +++ b/drivers/tty/tty_io.c
> @@ -170,7 +170,7 @@ void free_tty_struct(struct tty_struct *tty)
>  	put_device(tty->dev);
>  	kfree(tty->write_buf);
>  	tty->magic = 0xDEADDEAD;
> -	kfree(tty);
> +	strcpy(tty->name, "GONE");
>  }
>  
>  static inline struct tty_struct *file_tty(struct file *file)
> 
> If this is unknown and a bisect is requested, please let me know.
Indeed, this will be appreciated.
I'm quite curious to find the commit that led to this.

Thanks !

> 
> Sebastian
> 

Richard
