From: Jiri Slaby <jslaby@suse.cz>
Subject: Re: [PATCH -repost] kgdb: depends on VT
Date: Mon, 9 May 2016 09:10:07 +0200
Message-ID: <573037CF.9080005@suse.cz>
References: <1459412955-4696-1-git-send-email-jslaby@suse.cz>
 <56FD11A9.1060305@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56FD11A9.1060305@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jason Wessel <jason.wessel@windriver.com>, Jiri Slaby <jslaby@suse.cz>, akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 03/31/2016, 02:01 PM, Jason Wessel wrote:
> On 03/31/2016 03:29 AM, Jiri Slaby wrote:
>> With VT=n, the kernel build fails with:
>> drivers/built-in.o: In function `kgdboc_pre_exp_handler':
>> kgdboc.c:(.text+0x7b5aa): undefined reference to `fg_console'
>> kgdboc.c:(.text+0x7b5ce): undefined reference to `vc_cons'
>> kgdboc.c:(.text+0x7b5d5): undefined reference to `vc_cons'
>>
>> kgdboc.o is built when KGDB_SERIAL_CONSOLE is set. So make
>> KGDB_SERIAL_CONSOLE depend on HW_CONSOLE which includes those symbols.
> 
> Acked-by: Jason Wessel <jason.wessel@windriver.com>
> 
> 
> I'll put this in the kgdb-next branch and submit it to the upstream,
> unless it gets merged in another queue.

Nobody else seemed to put it in any queue. And since it haven't appeared
in -next, it seems neither you did?

thanks,
-- 
js
suse labs
