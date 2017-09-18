From: Jiri Slaby <jslaby@suse.cz>
Subject: Re: [PATCH] tty fix oops when rmmod 8250
Date: Mon, 18 Sep 2017 10:43:12 +0200
Message-ID: <c18e422a-00fe-00bd-75ba-384f67c4f241@suse.cz>
References: <20170915094556.55384-1-nixiaoming@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170915094556.55384-1-nixiaoming@huawei.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: nixiaoming <nixiaoming@huawei.com>, adobriyan@gmail.com, torvalds@linux-foundation.org, gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 09/15/2017, 11:45 AM, nixiaoming wrote:
> After rmmod 8250.ko
> tty_kref_put starts kwork (release_one_tty) to release proc interface

I believe you wanted to add a period here.

> oops when accessing driver->driver_name in proc_tty_unregister_driver

"The kernel oopses when"... ?

> Use jprobe, found driver->driver_name point to 8250.ko
> static static struct uart_driver serial8250_reg
> .driver_name= serial,
> 
> Use name in proc_dir_entry instead of driver->driver_name to fix oops
> 
> test on linux 4.1.12:
...
> @@ -164,7 +165,7 @@ void proc_tty_unregister_driver(struct tty_driver *driver)
>  	if (!ent)
>  		return;
>  		
> -	remove_proc_entry(driver->driver_name, proc_tty_driver);
> +	remove_proc_entry(ent->name, proc_tty_driver);

Yes, that makes sense. Using possibly stale driver_name cannot really
work out. I only wonder why nobody noticed until now...

So, can you reproduce also on 4.13 or something newer like that?

thanks,
-- 
js
suse labs
