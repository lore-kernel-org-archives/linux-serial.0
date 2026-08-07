Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B972A27A907;
	Fri,  7 Aug 2026 06:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786085154; cv=none; b=Cz0U4MpIVS2BIumDGAPET95Uxo9UPE2Dal6CIjxnpnsmudmyC0pF7QvbrxiNGpjNjuaq03RA9pxDkc0OUbOVDixdUyC/gIapLyMsDiPehAvw5zWdZAXTlGKiK7bE/mlQzdjXbHQn4JG9QJMsNOYbWy4SBgsKbR/TzpoAxGcl01c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786085154; c=relaxed/simple;
	bh=84cyBJf8fSQ/v8PtTSYSpvHiZ8RN0Zd04fYbHTpxMhc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=h/9n5Hx0bh68KIxzf1uwzTzo/z3dkDhdJu1PkCf7JYX2iZLFdHWOB7D4AmvMAAC3RqJnJHwsguaJeBllAB6zHkS+xyB/NoAERRQc3PHuVouKe+Na1ygMWw1jB2sqDi7UMUAXl5nRa2WNORil8GVcmL2fURQ4B2BJVO0K66V+A8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=buRjjZUy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="buRjjZUy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BBFD1F00A3A;
	Fri,  7 Aug 2026 06:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786085153;
	bh=GFp8IxywBCbWdweVabG/3grrD1nmpDk9rfvKiuf1E1w=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=buRjjZUy7afMVbBZcMrlhehQh27leSBNcFS0tCp80PVPqNW02H3WFLUQyrRD9i+3V
	 qcIsBQecHufSvhjDpPuHO7v/rREhdsOzfBoJ+BpLMIzUYY/uMSr5kOM3BGYLymNbuu
	 F6FKZufjXPHP0LFM5/UONMciIf57w1VZ3ITcQA709M8+RGmPU1BGYRWHOSUMRcuVjY
	 7H2EtiUqvaOq9V7TIZYBRiTkhb74np7M7w4+Iv6tWJNONouFV0dV0VkS/1T2Gl88eE
	 NMrJmwZa41U04eiNKTJsvXXlSdCcFMlL6cTU7xQwX9jvsUtThTj53yk0t1h4Pcj0xG
	 6VFJuSLV5z/FA==
Message-ID: <c60f8248-dbba-4a87-ab29-ab6315a9932a@kernel.org>
Date: Fri, 7 Aug 2026 08:45:50 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [serial?] WARNING in register_console
To: syzbot <syzbot+1ebbc20f223b99446034@syzkaller.appspotmail.com>,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <6a7411dd.9c11d2ce.289b96.0094.GAE@google.com>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <6a7411dd.9c11d2ce.289b96.0094.GAE@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06. 08. 26, 6:47, syzbot wrote:
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    0d8395707651 Merge tag 'soc-fixes-7.2-2' of git://git.kern..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=10883c99580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=cb17729fb04b1e3a
> dashboard link: https://syzkaller.appspot.com/bug?extid=1ebbc20f223b99446034
> compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15b1bbb9580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/14b35ca281d5/disk-0d839570.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/68c2ac2fdce0/vmlinux-0d839570.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/29bdd737b48f/bzImage-0d839570.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/cce97dbb2265/mount_0.gz
>    fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=11da8e49580000)
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+1ebbc20f223b99446034@syzkaller.appspotmail.com
> 
> printk: legacy console [ttyS0] enabled
> ------------[ cut here ]------------
> IS_ERR(kt)

Well, the creation of "pr/legacy" thread failed. Would be nice to see 
what is actual PTR_ERR(kt).

> WARNING: kernel/printk/printk.c:3728 at legacy_kthread_create kernel/printk/printk.c:3728 [inline], CPU#0: syz.4.49/6392
> WARNING: kernel/printk/printk.c:3728 at printk_kthreads_check_locked+0x2a7/0x3f0 kernel/printk/printk.c:3802, CPU#0: syz.4.49/6392
> Modules linked in:
> CPU: 0 UID: 0 PID: 6392 Comm: syz.4.49 Not tainted syzkaller #0 PREEMPT_{RT,(full)}
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
> RIP: 0010:legacy_kthread_create kernel/printk/printk.c:3728 [inline]
> RIP: 0010:printk_kthreads_check_locked+0x2a7/0x3f0 kernel/printk/printk.c:3802
> Code: fe c1 38 c1 7c 9a 4c 89 f7 e8 c5 85 8a 00 eb 90 e8 7e 12 21 00 eb 05 e8 77 12 21 00 b0 01 88 05 2f a4 08 18 e9 e2 00 00 00 90 <0f> 0b 90 48 c7 c7 80 bd 6d 8b e8 1a 9f 82 ff 48 8b 1d 93 9e 04 18
> RSP: 0018:ffffc9000509fa70 EFLAGS: 00010206
> RAX: fffffffffffffffc RBX: 0000000000000001 RCX: 10959546c0351c00
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: ffffc9000509fb70 R08: ffff888032eb2daf R09: 1ffff110065d65b5
> R10: dffffc0000000000 R11: ffffed10065d65b6 R12: 0000000000000000
> R13: dffffc0000000000 R14: 1ffff92000a13f5c R15: dffffc0000000000
> FS:  00007f7f4a99d6c0(0000) GS:ffff888125c3e000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fd99747f000 CR3: 000000003dd70000 CR4: 00000000003526f0
> Call Trace:
>   <TASK>
>   register_console+0xc19/0xfc0 kernel/printk/printk.c:4221
>   console_store+0x359/0x4f0 drivers/tty/serial/serial_core.c:2999

console_store() is serialized by a mutex. So this should not be a race. 
I cannot reproduce using:
while :; do
   echo 0 >/sys/class/tty/ttyS0/console
   echo 1 > /sys/class/tty/ttyS0/console
done

That's what the reproducer suggests is the cause.

thanks,
-- 
js
suse labs
