From: Luis Henriques <luis.henriques@canonical.com>
Subject: Re: request for stable inclusion
Date: Fri, 28 Jun 2013 16:29:27 +0100
Message-ID: <871u7m8d9k.fsf@canonical.com>
References: <51CD518B.2050106@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <51CD518B.2050106@huawei.com> (Yijing Wang's message of "Fri, 28
	Jun 2013 17:04:11 +0800")
Sender: stable-owner@vger.kernel.org
To: Yijing Wang <wangyijing@huawei.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org, Liang Li <liang.li@windriver.com>, Li Zefan <lizefan@huawei.com>
List-Id: linux-serial@vger.kernel.org

Yijing Wang <wangyijing@huawei.com> writes:

> Hi Greg, Jiri or Liang Li
>
> 384e301e3519599b000c1a2ecd938b533fc15d85
> pch_uart: fix a deadlock when pch_uart as console
>
> This looks applicable to stable-3.4, and it
> was built successful for me. What do you think?
>
> Thanks!
> Yijing.
>
> --
> To unsubscribe from this list: send the line "unsubscribe stable" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

I'm queuing it for the 3.5 as well.

Also, this seems to be applicable to older kernels as well.

Cheers,
-- 
Luis
