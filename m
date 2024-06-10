Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CFBA55
	for <linux-serial@vger.kernel.org>; Mon, 10 Jun 2024 00:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717980440; cv=none; b=uVttUGUP/rkK9HwsYQT3gMlxWmVbDWPClm+9MZl/IGSr9PbUipzuW3KLaU+0OWWTdBjPhR5Fpr9EQX0g+uvuoK3uhWqrxDyf9N8Rr1KJT0Ei3mSDVNTDKTiOHZ9tIOeJkyzRrScD/OHii+IcIDMDHMQ+cPiTsRyYoJ0kvbWB7Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717980440; c=relaxed/simple;
	bh=NpwO0u4kgbIw0YHoRJSAFkTvUC9/Z0Uusx6P4p/6mhY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DHaRsWD7A19qaFPE7HowCXPkcTCqJC836XjEF4vrshdmsgAl6yS3guSVy51v3zorgykSgqGKRrziosRGFXeK/FyZbYTWzzmkGMiYsOqSM1Cr3Ls45RxsVrWmPiOQS6deUhyxAWx/HeSo7bIoRkBBFlPopXcnudLNgVJw/Xy5qiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav414.sakura.ne.jp (fsav414.sakura.ne.jp [133.242.250.113])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 45A0kjjL008317;
	Mon, 10 Jun 2024 09:46:45 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav414.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav414.sakura.ne.jp);
 Mon, 10 Jun 2024 09:46:45 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav414.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 45A0kiuS008314
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 10 Jun 2024 09:46:44 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <d9c11abd-03a6-466f-bfdc-ee9a57ad881c@I-love.SAKURA.ne.jp>
Date: Mon, 10 Jun 2024 09:46:44 +0900
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [serial?] possible deadlock in
 console_lock_spinning_enable (4)
To: Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+0f558b549182d2711c75@syzkaller.appspotmail.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org,
        Boqun Feng <boqun.feng@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
References: <20240610001914.2081-1-hdanton@sina.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20240610001914.2081-1-hdanton@sina.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/06/10 9:19, Hillf Danton wrote:
> On Sun, 09 Jun 2024 08:24:24 -0700
>> Hello,
>>
>> syzbot found the following issue on:
>>
>> HEAD commit:    8867bbd4a056 mm: arm64: Fix the out-of-bounds issue in con..
>> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
>> console output: https://syzkaller.appspot.com/x/log.txt?x=14d199ce980000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=3b4350cf56c61c80
>> dashboard link: https://syzkaller.appspot.com/bug?extid=0f558b549182d2711c75
>> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
>> userspace arch: arm64
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11493bc2980000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=146cff16980000

#syz dup: possible deadlock in console_flush_all (2)

>> -> #0 (console_owner){....}-{0:0}:
>>        check_prev_add kernel/locking/lockdep.c:3134 [inline]
>>        check_prevs_add kernel/locking/lockdep.c:3253 [inline]
>>        validate_chain kernel/locking/lockdep.c:3869 [inline]
>>        __lock_acquire+0x3384/0x763c kernel/locking/lockdep.c:5137
>>        lock_acquire+0x248/0x73c kernel/locking/lockdep.c:5754
>>        console_lock_spinning_enable+0xb4/0xec kernel/printk/printk.c:1870
>>        console_emit_next_record kernel/printk/printk.c:2922 [inline]
>>        console_flush_all+0x58c/0xb74 kernel/printk/printk.c:2994
>>        console_unlock+0xec/0x3d4 kernel/printk/printk.c:3063
>>        vprintk_emit+0x1ec/0x350 kernel/printk/printk.c:2345
>>        vprintk_default+0xa0/0xe4 kernel/printk/printk.c:2360
>>        vprintk+0x200/0x2d4 kernel/printk/printk_safe.c:45
>>        _printk+0xdc/0x128 kernel/printk/printk.c:2370
>>        __report_bug lib/bug.c:195 [inline]
>>        report_bug+0x3b8/0x5b0 lib/bug.c:219
>>        bug_handler+0x50/0x1fc arch/arm64/kernel/traps.c:978
>>        call_break_hook arch/arm64/kernel/debug-monitors.c:321 [inline]
>>        brk_handler+0x17c/0x2e0 arch/arm64/kernel/debug-monitors.c:328
>>        do_debug_exception+0x1e4/0x398 arch/arm64/mm/fault.c:909
>>        el1_dbg+0x64/0x80 arch/arm64/kernel/entry-common.c:472
>>        el1h_64_sync_handler+0x40/0xac arch/arm64/kernel/entry-common.c:512
>>        el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:593
>>        spin_unlock_irqrestore include/linux/spinlock.h:406 [inline]
>>        uart_port_unlock_irqrestore include/linux/serial_core.h:669 [inline]
> 
> in include/linux/spinlock_api_smp.h
> static inline void __raw_spin_unlock_irqrestore(raw_spinlock_t *lock, unsigned long flags)
> {
> 	spin_release(&lock->dep_map, _RET_IP_);
> 	do_raw_spin_unlock(lock);
> 	local_irq_restore(flags);
> 	preempt_enable();
> }
> 
> Because spin_release() goes before restoring local irq, the port_lock
> should have been ruled out of lockdep that triggered this report. But
> it was delivered to lore.

This report is just an yet another instance of trying to printk()
while holding port_lock. Like I mentioned at
https://lkml.kernel.org/r/acfef6bc-08eb-4ab6-b6d4-9ad03c714517@kernel.org ,
we might want to guard uart_port_lock'ed section using
printk_deferred_enter()/printk_deferred_exit().


