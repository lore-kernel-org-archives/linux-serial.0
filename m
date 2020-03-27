Return-Path: <SRS0=8UUK=5M=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65CACC43331
	for <linux-serial@archiver.kernel.org>; Fri, 27 Mar 2020 10:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B33920705
	for <linux-serial@archiver.kernel.org>; Fri, 27 Mar 2020 10:28:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbgC0K2P (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 27 Mar 2020 06:28:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:34224 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726266AbgC0K2P (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 27 Mar 2020 06:28:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D5718AE07;
        Fri, 27 Mar 2020 10:28:12 +0000 (UTC)
Subject: Re: [PATCH v3 1/2] vt: vt_ioctl: fix VT_DISALLOCATE freeing in-use
 virtual console
To:     Eric Biggers <ebiggers@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        Eric Dumazet <edumazet@google.com>,
        Nicolas Pitre <nico@fluxnic.net>
References: <20200320193424.GM851@sol.localdomain>
 <20200322034305.210082-1-ebiggers@kernel.org>
 <20200322034305.210082-2-ebiggers@kernel.org>
From:   Jiri Slaby <jslaby@suse.cz>
Autocrypt: addr=jslaby@suse.cz; prefer-encrypt=mutual; keydata=
 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
Message-ID: <5a6a80e8-cf7f-dcfd-9cf4-afd3ee502220@suse.cz>
Date:   Fri, 27 Mar 2020 11:28:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200322034305.210082-2-ebiggers@kernel.org>
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 22. 03. 20, 4:43, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> The VT_DISALLOCATE ioctl can free a virtual console while tty_release()
> is still running, causing a use-after-free in con_shutdown().  This
> occurs because VT_DISALLOCATE considers a virtual console's
> 'struct vc_data' to be unused as soon as the corresponding tty's
> refcount hits 0.  But actually it may be still being closed.
> 
> Fix this by making vc_data be reference-counted via the embedded
> 'struct tty_port'.  A newly allocated virtual console has refcount 1.
> Opening it for the first time increments the refcount to 2.  Closing it
> for the last time decrements the refcount (in tty_operations::cleanup()
> so that it happens late enough), as does VT_DISALLOCATE.
> 
> Reproducer:
> 	#include <fcntl.h>
> 	#include <linux/vt.h>
> 	#include <sys/ioctl.h>
> 	#include <unistd.h>
> 
> 	int main()
> 	{
> 		if (fork()) {
> 			for (;;)
> 				close(open("/dev/tty5", O_RDWR));
> 		} else {
> 			int fd = open("/dev/tty10", O_RDWR);
> 
> 			for (;;)
> 				ioctl(fd, VT_DISALLOCATE, 5);
> 		}
> 	}
> 
> KASAN report:
> 	BUG: KASAN: use-after-free in con_shutdown+0x76/0x80 drivers/tty/vt/vt.c:3278
> 	Write of size 8 at addr ffff88806a4ec108 by task syz_vt/129
> 
> 	CPU: 0 PID: 129 Comm: syz_vt Not tainted 5.6.0-rc2 #11
> 	Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS ?-20191223_100556-anatol 04/01/2014
> 	Call Trace:
> 	 [...]
> 	 con_shutdown+0x76/0x80 drivers/tty/vt/vt.c:3278
> 	 release_tty+0xa8/0x410 drivers/tty/tty_io.c:1514
> 	 tty_release_struct+0x34/0x50 drivers/tty/tty_io.c:1629
> 	 tty_release+0x984/0xed0 drivers/tty/tty_io.c:1789
> 	 [...]
> 
> 	Allocated by task 129:
> 	 [...]
> 	 kzalloc include/linux/slab.h:669 [inline]
> 	 vc_allocate drivers/tty/vt/vt.c:1085 [inline]
> 	 vc_allocate+0x1ac/0x680 drivers/tty/vt/vt.c:1066
> 	 con_install+0x4d/0x3f0 drivers/tty/vt/vt.c:3229
> 	 tty_driver_install_tty drivers/tty/tty_io.c:1228 [inline]
> 	 tty_init_dev+0x94/0x350 drivers/tty/tty_io.c:1341
> 	 tty_open_by_driver drivers/tty/tty_io.c:1987 [inline]
> 	 tty_open+0x3ca/0xb30 drivers/tty/tty_io.c:2035
> 	 [...]
> 
> 	Freed by task 130:
> 	 [...]
> 	 kfree+0xbf/0x1e0 mm/slab.c:3757
> 	 vt_disallocate drivers/tty/vt/vt_ioctl.c:300 [inline]
> 	 vt_ioctl+0x16dc/0x1e30 drivers/tty/vt/vt_ioctl.c:818
> 	 tty_ioctl+0x9db/0x11b0 drivers/tty/tty_io.c:2660
> 	 [...]
> 
> Fixes: 4001d7b7fc27 ("vt: push down the tty lock so we can see what is left to tackle")
> Cc: <stable@vger.kernel.org> # v3.4+
> Reported-by: syzbot+522643ab5729b0421998@syzkaller.appspotmail.com
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Acked-by: Jiri Slaby <jslaby@suse.cz>

> ---
>  drivers/tty/vt/vt.c       | 23 ++++++++++++++++++++++-
>  drivers/tty/vt/vt_ioctl.c | 12 ++++--------
>  2 files changed, 26 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> index bbc26d73209a4..309a39197be0a 100644
> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c
> @@ -1075,6 +1075,17 @@ static void visual_deinit(struct vc_data *vc)
>  	module_put(vc->vc_sw->owner);
>  }
>  
> +static void vc_port_destruct(struct tty_port *port)
> +{
> +	struct vc_data *vc = container_of(port, struct vc_data, port);
> +
> +	kfree(vc);
> +}
> +
> +static const struct tty_port_operations vc_port_ops = {
> +	.destruct = vc_port_destruct,
> +};
> +
>  int vc_allocate(unsigned int currcons)	/* return 0 on success */
>  {
>  	struct vt_notifier_param param;
> @@ -1100,6 +1111,7 @@ int vc_allocate(unsigned int currcons)	/* return 0 on success */
>  
>  	vc_cons[currcons].d = vc;
>  	tty_port_init(&vc->port);
> +	vc->port.ops = &vc_port_ops;
>  	INIT_WORK(&vc_cons[currcons].SAK_work, vc_SAK);
>  
>  	visual_init(vc, currcons, 1);
> @@ -3250,6 +3262,7 @@ static int con_install(struct tty_driver *driver, struct tty_struct *tty)
>  
>  	tty->driver_data = vc;
>  	vc->port.tty = tty;
> +	tty_port_get(&vc->port);
>  
>  	if (!tty->winsize.ws_row && !tty->winsize.ws_col) {
>  		tty->winsize.ws_row = vc_cons[currcons].d->vc_rows;
> @@ -3285,6 +3298,13 @@ static void con_shutdown(struct tty_struct *tty)
>  	console_unlock();
>  }
>  
> +static void con_cleanup(struct tty_struct *tty)
> +{
> +	struct vc_data *vc = tty->driver_data;
> +
> +	tty_port_put(&vc->port);
> +}
> +
>  static int default_color           = 7; /* white */
>  static int default_italic_color    = 2; // green (ASCII)
>  static int default_underline_color = 3; // cyan (ASCII)
> @@ -3410,7 +3430,8 @@ static const struct tty_operations con_ops = {
>  	.throttle = con_throttle,
>  	.unthrottle = con_unthrottle,
>  	.resize = vt_resize,
> -	.shutdown = con_shutdown
> +	.shutdown = con_shutdown,
> +	.cleanup = con_cleanup,
>  };
>  
>  static struct cdev vc0_cdev;
> diff --git a/drivers/tty/vt/vt_ioctl.c b/drivers/tty/vt/vt_ioctl.c
> index 7297997fcf04c..f62f498f63c05 100644
> --- a/drivers/tty/vt/vt_ioctl.c
> +++ b/drivers/tty/vt/vt_ioctl.c
> @@ -310,10 +310,8 @@ static int vt_disallocate(unsigned int vc_num)
>  		vc = vc_deallocate(vc_num);
>  	console_unlock();
>  
> -	if (vc && vc_num >= MIN_NR_CONSOLES) {
> -		tty_port_destroy(&vc->port);
> -		kfree(vc);
> -	}
> +	if (vc && vc_num >= MIN_NR_CONSOLES)
> +		tty_port_put(&vc->port);
>  
>  	return ret;
>  }
> @@ -333,10 +331,8 @@ static void vt_disallocate_all(void)
>  	console_unlock();
>  
>  	for (i = 1; i < MAX_NR_CONSOLES; i++) {
> -		if (vc[i] && i >= MIN_NR_CONSOLES) {
> -			tty_port_destroy(&vc[i]->port);
> -			kfree(vc[i]);
> -		}
> +		if (vc[i] && i >= MIN_NR_CONSOLES)
> +			tty_port_put(&vc[i]->port);
>  	}
>  }
>  
> 


-- 
js
suse labs
