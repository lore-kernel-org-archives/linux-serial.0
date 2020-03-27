Return-Path: <SRS0=8UUK=5M=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03288C2D0E8
	for <linux-serial@archiver.kernel.org>; Fri, 27 Mar 2020 10:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D392A208E0
	for <linux-serial@archiver.kernel.org>; Fri, 27 Mar 2020 10:30:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgC0KaQ (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 27 Mar 2020 06:30:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:35526 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726698AbgC0KaQ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 27 Mar 2020 06:30:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 2CDF6AE07;
        Fri, 27 Mar 2020 10:30:13 +0000 (UTC)
Subject: Re: [PATCH v3 2/2] vt: vt_ioctl: fix use-after-free in vt_in_use()
To:     Eric Biggers <ebiggers@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        Eric Dumazet <edumazet@google.com>,
        Nicolas Pitre <nico@fluxnic.net>
References: <20200320193424.GM851@sol.localdomain>
 <20200322034305.210082-1-ebiggers@kernel.org>
 <20200322034305.210082-3-ebiggers@kernel.org>
From:   Jiri Slaby <jslaby@suse.cz>
Autocrypt: addr=jslaby@suse.cz; prefer-encrypt=mutual; keydata=
 mQINBE6S54YBEACzzjLwDUbU5elY4GTg/NdotjA0jyyJtYI86wdKraekbNE0bC4zV+ryvH4j
 rrcDwGs6tFVrAHvdHeIdI07s1iIx5R/ndcHwt4fvI8CL5PzPmn5J+h0WERR5rFprRh6axhOk
 rSD5CwQl19fm4AJCS6A9GJtOoiLpWn2/IbogPc71jQVrupZYYx51rAaHZ0D2KYK/uhfc6neJ
 i0WqPlbtIlIrpvWxckucNu6ZwXjFY0f3qIRg3Vqh5QxPkojGsq9tXVFVLEkSVz6FoqCHrUTx
 wr+aw6qqQVgvT/McQtsI0S66uIkQjzPUrgAEtWUv76rM4ekqL9stHyvTGw0Fjsualwb0Gwdx
 ReTZzMgheAyoy/umIOKrSEpWouVoBt5FFSZUyjuDdlPPYyPav+hpI6ggmCTld3u2hyiHji2H
 cDpcLM2LMhlHBipu80s9anNeZhCANDhbC5E+NZmuwgzHBcan8WC7xsPXPaiZSIm7TKaVoOcL
 9tE5aN3jQmIlrT7ZUX52Ff/hSdx/JKDP3YMNtt4B0cH6ejIjtqTd+Ge8sSttsnNM0CQUkXps
 w98jwz+Lxw/bKMr3NSnnFpUZaxwji3BC9vYyxKMAwNelBCHEgS/OAa3EJoTfuYOK6wT6nadm
 YqYjwYbZE5V/SwzMbpWu7Jwlvuwyfo5mh7w5iMfnZE+vHFwp/wARAQABtBtKaXJpIFNsYWJ5
 IDxqc2xhYnlAc3VzZS5jej6JAjgEEwECACIFAk6S6NgCGwMGCwkIBwMCBhUIAgkKCwQWAgMB
 Ah4BAheAAAoJEL0lsQQGtHBJgDsP/j9wh0vzWXsOPO3rDpHjeC3BT5DKwjVN/KtP7uZttlkB
 duReCYMTZGzSrmK27QhCflZ7Tw0Naq4FtmQSH8dkqVFugirhlCOGSnDYiZAAubjTrNLTqf7e
 5poQxE8mmniH/Asg4KufD9bpxSIi7gYIzaY3hqvYbVF1vYwaMTujojlixvesf0AFlE4x8WKs
 wpk43fmo0ZLcwObTnC3Hl1JBsPujCVY8t4E7zmLm7kOB+8EHaHiRZ4fFDWweuTzRDIJtVmrH
 LWvRDAYg+IH3SoxtdJe28xD9KoJw4jOX1URuzIU6dklQAnsKVqxz/rpp1+UVV6Ky6OBEFuoR
 613qxHCFuPbkRdpKmHyE0UzmniJgMif3v0zm/+1A/VIxpyN74cgwxjhxhj/XZWN/LnFuER1W
 zTHcwaQNjq/I62AiPec5KgxtDeV+VllpKmFOtJ194nm9QM9oDSRBMzrG/2AY/6GgOdZ0+qe+
 4BpXyt8TmqkWHIsVpE7I5zVDgKE/YTyhDuqYUaWMoI19bUlBBUQfdgdgSKRMJX4vE72dl8BZ
 +/ONKWECTQ0hYntShkmdczcUEsWjtIwZvFOqgGDbev46skyakWyod6vSbOJtEHmEq04NegUD
 al3W7Y/FKSO8NqcfrsRNFWHZ3bZ2Q5X0tR6fc6gnZkNEtOm5fcWLY+NVz4HLaKrJuQINBE6S
 54YBEADPnA1iy/lr3PXC4QNjl2f4DJruzW2Co37YdVMjrgXeXpiDvneEXxTNNlxUyLeDMcIQ
 K8obCkEHAOIkDZXZG8nr4mKzyloy040V0+XA9paVs6/ice5l+yJ1eSTs9UKvj/pyVmCAY1Co
 SNN7sfPaefAmIpduGacp9heXF+1Pop2PJSSAcCzwZ3PWdAJ/w1Z1Dg/tMCHGFZ2QCg4iFzg5
 Bqk4N34WcG24vigIbRzxTNnxsNlU1H+tiB81fngUp2pszzgXNV7CWCkaNxRzXi7kvH+MFHu2
 1m/TuujzxSv0ZHqjV+mpJBQX/VX62da0xCgMidrqn9RCNaJWJxDZOPtNCAWvgWrxkPFFvXRl
 t52z637jleVFL257EkMI+u6UnawUKopa+Tf+R/c+1Qg0NHYbiTbbw0pU39olBQaoJN7JpZ99
 T1GIlT6zD9FeI2tIvarTv0wdNa0308l00bas+d6juXRrGIpYiTuWlJofLMFaaLYCuP+e4d8x
 rGlzvTxoJ5wHanilSE2hUy2NSEoPj7W+CqJYojo6wTJkFEiVbZFFzKwjAnrjwxh6O9/V3O+Z
 XB5RrjN8hAf/4bSo8qa2y3i39cuMT8k3nhec4P9M7UWTSmYnIBJsclDQRx5wSh0Mc9Y/psx9
 B42WbV4xrtiiydfBtO6tH6c9mT5Ng+d1sN/VTSPyfQARAQABiQIfBBgBAgAJBQJOkueGAhsM
 AAoJEL0lsQQGtHBJN7UQAIDvgxaW8iGuEZZ36XFtewH56WYvVUefs6+Pep9ox/9ZXcETv0vk
 DUgPKnQAajG/ViOATWqADYHINAEuNvTKtLWmlipAI5JBgE+5g9UOT4i69OmP/is3a/dHlFZ3
 qjNk1EEGyvioeycJhla0RjakKw5PoETbypxsBTXk5EyrSdD/I2Hez9YGW/RcI/WC8Y4Z/7FS
 ITZhASwaCOzy/vX2yC6iTx4AMFt+a6Z6uH/xGE8pG5NbGtd02r+m7SfuEDoG3Hs1iMGecPyV
 XxCVvSV6dwRQFc0UOZ1a6ywwCWfGOYqFnJvfSbUiCMV8bfRSWhnNQYLIuSv/nckyi8CzCYIg
 c21cfBvnwiSfWLZTTj1oWyj5a0PPgGOdgGoIvVjYXul3yXYeYOqbYjiC5t99JpEeIFupxIGV
 ciMk6t3pDrq7n7Vi/faqT+c4vnjazJi0UMfYnnAzYBa9+NkfW0w5W9Uy7kW/v7SffH/2yFiK
 9HKkJqkN9xYEYaxtfl5pelF8idoxMZpTvCZY7jhnl2IemZCBMs6s338wS12Qro5WEAxV6cjD
 VSdmcD5l9plhKGLmgVNCTe8DPv81oDn9s0cIRLg9wNnDtj8aIiH8lBHwfUkpn32iv0uMV6Ae
 sLxhDWfOR4N+wu1gzXWgLel4drkCJcuYK5IL1qaZDcuGR8RPo3jbFO7Y
Message-ID: <38de9a73-9321-09ba-6ef8-023a64c3c023@suse.cz>
Date:   Fri, 27 Mar 2020 11:30:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200322034305.210082-3-ebiggers@kernel.org>
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
> vt_in_use() dereferences console_driver->ttys[i] without proper locking.
> This is broken because the tty can be closed and freed concurrently.
> 
> We could fix this by using 'READ_ONCE(console_driver->ttys[i]) != NULL'
> and skipping the check of tty_struct::count.  But, looking at
> console_driver->ttys[i] isn't really appropriate anyway because even if
> it is NULL the tty can still be in the process of being closed.
> 
> Instead, fix it by making vt_in_use() require console_lock() and check
> whether the vt is allocated and has port refcount > 1.  This works since
> following the patch "vt: vt_ioctl: fix VT_DISALLOCATE freeing in-use
> virtual console" the port refcount is incremented while the vt is open.
> 
> Reproducer (very unreliable, but it worked for me after a few minutes):
> 
> 	#include <fcntl.h>
> 	#include <linux/vt.h>
> 
> 	int main()
> 	{
> 		int fd, nproc;
> 		struct vt_stat state;
> 		char ttyname[16];
> 
> 		fd = open("/dev/tty10", O_RDONLY);
> 		for (nproc = 1; nproc < 8; nproc *= 2)
> 			fork();
> 		for (;;) {
> 			sprintf(ttyname, "/dev/tty%d", rand() % 8);
> 			close(open(ttyname, O_RDONLY));
> 			ioctl(fd, VT_GETSTATE, &state);
> 		}
> 	}
> 
> KASAN report:
> 
> 	BUG: KASAN: use-after-free in vt_in_use drivers/tty/vt/vt_ioctl.c:48 [inline]
> 	BUG: KASAN: use-after-free in vt_ioctl+0x1ad3/0x1d70 drivers/tty/vt/vt_ioctl.c:657
> 	Read of size 4 at addr ffff888065722468 by task syz-vt2/132
> 
> 	CPU: 0 PID: 132 Comm: syz-vt2 Not tainted 5.6.0-rc5-00130-g089b6d3654916 #13
> 	Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS ?-20191223_100556-anatol 04/01/2014
> 	Call Trace:
> 	 [...]
> 	 vt_in_use drivers/tty/vt/vt_ioctl.c:48 [inline]
> 	 vt_ioctl+0x1ad3/0x1d70 drivers/tty/vt/vt_ioctl.c:657
> 	 tty_ioctl+0x9db/0x11b0 drivers/tty/tty_io.c:2660
> 	 [...]
> 
> 	Allocated by task 136:
> 	 [...]
> 	 kzalloc include/linux/slab.h:669 [inline]
> 	 alloc_tty_struct+0x96/0x8a0 drivers/tty/tty_io.c:2982
> 	 tty_init_dev+0x23/0x350 drivers/tty/tty_io.c:1334
> 	 tty_open_by_driver drivers/tty/tty_io.c:1987 [inline]
> 	 tty_open+0x3ca/0xb30 drivers/tty/tty_io.c:2035
> 	 [...]
> 
> 	Freed by task 41:
> 	 [...]
> 	 kfree+0xbf/0x200 mm/slab.c:3757
> 	 free_tty_struct+0x8d/0xb0 drivers/tty/tty_io.c:177
> 	 release_one_tty+0x22d/0x2f0 drivers/tty/tty_io.c:1468
> 	 process_one_work+0x7f1/0x14b0 kernel/workqueue.c:2264
> 	 worker_thread+0x8b/0xc80 kernel/workqueue.c:2410
> 	 [...]
> 
> Fixes: 4001d7b7fc27 ("vt: push down the tty lock so we can see what is left to tackle")
> Cc: <stable@vger.kernel.org> # v3.4+
> Signed-off-by: Eric Biggers <ebiggers@google.com>

I cannot think of anything better with the current poor code state, so:

Acked-by: Jiri Slaby <jslaby@suse.cz>

thanks,
-- 
-- 
js
suse labs
