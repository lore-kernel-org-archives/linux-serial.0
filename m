From: Jiri Slaby <jslaby@suse.cz>
Subject: Re: [tty:tty-next 17/23] drivers/staging/dgrp/dgrp_net_ops.c:229:8:
 error: 'struct tty_struct' has no member named 'read_cnt'
Date: Sat, 27 Oct 2012 14:20:28 +0200
Message-ID: <508BD18C.4070602@suse.cz>
References: <20121023023054.GI6830@localhost> <20121023105330.13d31938@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:43671 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751388Ab2J0MUd (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 27 Oct 2012 08:20:33 -0400
Received: by mail-ee0-f46.google.com with SMTP id b15so1423165eek.19
        for <linux-serial@vger.kernel.org>; Sat, 27 Oct 2012 05:20:31 -0700 (PDT)
In-Reply-To: <20121023105330.13d31938@pyramind.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Fengguang Wu <fengguang.wu@intel.com>, Yuanhan Liu <yuanhan.liu@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, Bill Pemberton <wfp5p@virginia.edu>

On 10/23/2012 11:53 AM, Alan Cox wrote:
> On Tue, 23 Oct 2012 10:30:54 +0800
> Fengguang Wu <fengguang.wu@intel.com> wrote:
> 
>> Hi Jiri,
>>
>> FYI, kernel build failed on
>>
>> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-next
>> head:   ecbbfd44a08fa80e0d664814efd4c187721b85f6
>> commit: ba2e68ac6157004ee4922fb39ebd9459bbae883e [17/23] TTY: move ldisc data from tty_struct: read_* and echo_* and canon_* stuff
>> config: x86_64-allmodconfig # make ARCH=x86_64 allmodconfig
>>
>> All error/warnings:
>>
>> drivers/staging/dgrp/dgrp_net_ops.c: In function 'dgrp_input':
>> drivers/staging/dgrp/dgrp_net_ops.c:216:27: error: 'struct tty_struct' has no member named 'real_raw'
>> drivers/staging/dgrp/dgrp_net_ops.c:229:8: error: 'struct tty_struct' has no member named 'read_cnt'
>> drivers/staging/dgrp/dgrp_net_ops.c:229:8: error: 'struct tty_struct' has no member named 'read_cnt'
>> drivers/staging/dgrp/dgrp_net_ops.c:261:30: error: 'struct tty_struct' has no member named 'real_raw'
>> drivers/staging/dgrp/dgrp_net_ops.c:276:28: error: 'struct tty_struct' has no member named 'real_raw'
>>
>> vim +229 drivers/staging/dgrp/dgrp_net_ops.c
>>
>> 0b52b749 Bill Pemberton 2012-09-20  228  	/* take into consideration length of ldisc */
>> 0b52b749 Bill Pemberton 2012-09-20 @229  	len = min(len, (N_TTY_BUF_SIZE - 1) - tty->read_cnt);
> 
> This is broken and unsafe. It's always been broken and unsafe. Probably
> the report wants directing to whoever signed up to fix it all in staging.

And that function looks strange alltogether. It's like it's trying to
optimize in case of raw TTY by sending the data directly to ldisc. In a
completely racy way. I think that it should remain marked as BROKEN
until this is converted to tty_prepare_flip_string.

Or is there any use-case this optimization makes a difference?

thanks,
-- 
js
suse labs
