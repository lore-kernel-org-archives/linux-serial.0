Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA0F36998C
	for <linux-serial@vger.kernel.org>; Fri, 12 Jun 2026 14:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781273967; cv=none; b=Rd/IhdBLMaucBzpeqK8y+bh0hnlbr9Rzlug6FRbOaTQVrikibLEph/W/30w1nPuxR+Jg8C3+VPOpYepK3S34esAea0SsN1+Mo2Jy7xAV0SmZNtaac7F61tnSZLKPIZJ2McBn1O++WlgvWQ0G41HDURSyU2XcP5rr7toiCzTgz8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781273967; c=relaxed/simple;
	bh=3VKywyEoqxtZzApdQaD3c9iuvzeMGux5OK5oVq7gg5M=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=ao5jHuyVaxN+EBUO+lAgXyokJCGiJ5AFixRy6kPcvflystyZf+PGuRhiRVI59esVaCC0tUTdkoR7sDiF7VG5WOzGDyU8hdRxhyb8IxJmqaHg/IZr2wtZOcMkbopfNY3zWSNfFFf2QfUgIRvNINeccw6WurWNt3bA2AoVhCcODzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NRMMaDaB; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NRMMaDaB"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1384f8ee710so702167c88.1
        for <linux-serial@vger.kernel.org>; Fri, 12 Jun 2026 07:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781273965; x=1781878765; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rs3feogwBK+hnLq8HXXkCEHxMzerJZZCxFI3RMt4WSQ=;
        b=NRMMaDaBAeP4rFYSsLikAwuiJZtudAXnj8hrumr0+Iz2lw+D/050h/su3gjbzo0v5N
         oiPYGz8vj2rnfIKPatpJ09fj86O/h3xPilXFpyiY/u3KwsIwDvIQN1X2kHK+4UPzp6qr
         uOJjCZL6yGnnfNNCir/plj/dT5AOnDi+QOBRQE3nM44HUlnyW/z0gZVamPjXPDhiTngM
         +SIOT7YWYdxXVaACenMPX6ikb/Pi1GmAkQsAxY5mfcWrcMq9/uF3KtmKuGLatxECWonq
         bXIp+3i7FaQvPKFIOB9ju6Eg+4K1CRI8sqct+kg+pW9cwaW3TOuQ/pTenolaujFH7hp8
         O50w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781273965; x=1781878765;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rs3feogwBK+hnLq8HXXkCEHxMzerJZZCxFI3RMt4WSQ=;
        b=PHvl1q9lRVpktxPbcxyXGB31AL+6oOrM6kE8lIVCheBmrvWdDHDwIvDkkvDPGMNYK1
         3hMv7eWh75YFj4VErP2vIEGusNqrZixW8LBuhkvjtZMQVHuAA1Vs5s8vEdzFTqw9o+ZI
         h7dooPzCKP/1c1zpZmyMTtCtopqOTm1nmQXQXsKBJAJ55IPfIVqFt94XyLh5iCSsM32s
         ed6vvNGVU0wCgLqo07XdvMK+dv7AHgnK0EsJie5PHaBKVxyeG0bmwH6OTd3R8JQrjyj9
         Y/piyOW6R5f/s/PsLQ5PhsNmiuOq0HnOcJkrdZfSpqfEFIyoXyEgGEWuZdlFFe8hhsFu
         gYrg==
X-Forwarded-Encrypted: i=1; AFNElJ9PmrkHv4dDCQmihgV/16vFHSoG7YAQ0BIzRaw4B5ycuQ/t3Piy9qNBletRAWBgXjbKRWLDrBWJ7+hGPSE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAVhhyn9ECzAtfBS/to4ZSc+vBRj7EHPSRVVq5WA/sMa8dIjVe
	tQF6XAkNxpj8usEaJwlXu8erinMH5Y56faAIL07RtEg2I7MjGRK2D+ng
X-Gm-Gg: Acq92OGL+qdYGcWKtM4PxquzRzfVCnC4f5hTEek/N6whqSmBBPvQqd9W3gmEbrb1Qqt
	vhODFW+XjZBKOtSecrdys65T/z0zUrWGorovdfbx57GBXlKCwIBp95MInHFExfp6NDrPx4B13y7
	WscKhvfdG+NUtPfdu0NzjgCLLn3j+iZqExfYJ+w78AhGDfS3GCrR9kb1EZweXmT4JgKvCxfCxsH
	5vAScYHV6CIGSIvrKJ9jI2VgMEfV7CmU8BvbT7LVXRe8vZef2VUJXtEpDps5KbOwmVmpLbv3Kld
	yYpAavrqrk+CQ8X5B77IH1eC4Eulv92lkGI2gp2brykl878A1AWg4ICTg9hSE7tM4XBC/5yVkgg
	t7IsoKck2lvl3K6jLVe1ctkLNbqMXgTn/PzuNqlZA6CsdC5yT3EXpah3yKnCMt53DacgykFhxz+
	qQOgBa2oaxwFU4y8Z9IQyA5pzlGmwazLgHOU9MT+F2GoFp0Zgr3uo=
X-Received: by 2002:a05:7022:f8b:b0:138:364e:3213 with SMTP id a92af1059eb24-1384bafee7bmr1466724c88.14.1781273964411;
        Fri, 12 Jun 2026 07:19:24 -0700 (PDT)
Received: from localhost ([198.176.50.157])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1384b964862sm2370179c88.10.2026.06.12.07.19.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jun 2026 07:19:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 12 Jun 2026 22:19:18 +0800
Message-Id: <DJ74X3U3L9DZ.3RMWZCB0O5ZCE@gmail.com>
Cc: "Jiri Slaby" <jirislaby@kernel.org>, "Daniel Starke"
 <daniel.starke@siemens.com>, <linux-kernel@vger.kernel.org>,
 <linux-serial@vger.kernel.org>, "Xiang Mei" <xmei5@asu.edu>
Subject: Re: [PATCH] tty: n_gsm: fix NULL deref of gsm->dlci[0] in control
 message handlers
From: "Weiming Shi" <bestswngs@gmail.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Weiming Shi"
 <bestswngs@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260611183217.2488508-2-bestswngs@gmail.com>
 <2026061101-hanky-uninstall-da53@gregkh>
In-Reply-To: <2026061101-hanky-uninstall-da53@gregkh>

On Fri Jun 12, 2026 at 2:50 AM CST, Greg Kroah-Hartman wrote:
> On Thu, Jun 11, 2026 at 11:32:18AM -0700, Weiming Shi wrote:
>> gsm_control_command() and gsm_control_reply() load gsm->dlci[0] and
>> immediately dereference dlci->ftype without checking it for NULL.
>>=20
>> On the receive path, gsm_queue() validates that gsm->dlci[0] is non-NULL
>> and DLCI_OPEN before invoking the control handler, but the value is not
>> held across that check: the receive worker runs from flush_to_ldisc()
>> without taking gsm->mutex, while a concurrent GSMIOC_SETCONF ioctl can
>> enter gsm_cleanup_mux(), which takes gsm->mutex, releases gsm->dlci[0]
>> and sets it to NULL. If the mux is torn down between gsm_queue()'s check
>> and the re-load inside gsm_control_command()/gsm_control_reply(), the
>> handler dereferences a NULL dlci.
>>=20
>> A peer that drives DLCI 0 control frames (e.g. CMD_TEST) while the mux
>> owner reconfigures the line discipline can therefore crash the kernel
>> (line numbers from decode_stacktrace.sh against the crashing build):
>>=20
>>  Oops: general protection fault, probably for non-canonical address
>>  KASAN: null-ptr-deref in range [0x0000000000000208-0x000000000000020f]
>>  RIP: 0010:gsm_control_reply (drivers/tty/n_gsm.c:1497)
>>  Call Trace:
>>   gsm_dlci_command (drivers/tty/n_gsm.c:2482)
>>   gsm_queue.part.0 (drivers/tty/n_gsm.c:2852)
>>   gsm0_receive (drivers/tty/n_gsm.c:2972)
>>   gsmld_receive_buf (drivers/tty/n_gsm.c:3629)
>>   tty_ldisc_receive_buf (drivers/tty/tty_buffer.c:391)
>>   tty_port_default_receive_buf (drivers/tty/tty_port.c:39)
>>   flush_to_ldisc (drivers/tty/tty_buffer.c:495)
>>   process_one_work
>>   worker_thread
>>   kthread
>>=20
>> The other callers of these helpers (the keep-alive and negotiation timer
>> paths) already guard the gsm->dlci[0] access; only the receive path is
>> unguarded. The CMD_CLD handler in the same switch already checks the
>> loaded dlci for NULL for the very same reason. Bail out early when
>> gsm->dlci[0] has been cleared instead of dereferencing it.
>>=20
>> Triggering this requires CAP_NET_ADMIN to attach the n_gsm line
>> discipline (gsmld_open() uses capable(), not ns_capable()), so it is a
>> local denial of service for a privileged mux owner racing its own
>> control channel; harden the handlers regardless.
>>=20
>> Fixes: 5767712668b8 ("tty: n_gsm: cleanup gsm_control_command and gsm_co=
ntrol_reply")
>> Reported-by: Xiang Mei <xmei5@asu.edu>
>> Assisted-by: Claude:claude-opus-4-8
>> Signed-off-by: Weiming Shi <bestswngs@gmail.com>
>> ---
>>  drivers/tty/n_gsm.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>=20
>> diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
>> index 214abeb89aaa..860cfb91d510 100644
>> --- a/drivers/tty/n_gsm.c
>> +++ b/drivers/tty/n_gsm.c
>> @@ -1457,6 +1457,9 @@ static int gsm_control_command(struct gsm_mux *gsm=
, int cmd, const u8 *data,
>>  	struct gsm_msg *msg;
>>  	struct gsm_dlci *dlci =3D gsm->dlci[0];
>> =20
>> +	if (!dlci)
>> +		return -EINVAL;
>
> What precents dlci from being NULL right after you check this?
>
> thanks,
>
> greg k-h

Hi greg,

I'm sorry for taking so long to respond.

After a closer look I think your review is correct.

The real problem is that the receive path touches gsm->dlci[] with no
lock. The teardown side holds gsm->mutex while it releases and frees the
dlci, but the receive worker does not: gsm_queue() loads
dlci =3D gsm->dlci[address] while it is still valid and passes it down
through dlci->data() to gsm_control_command()/gsm_control_reply(), which
also re-read gsm->dlci[0] and dereference dlci->ftype.

Meanwhile GSMIOC_SETCONF -> gsm_cleanup_mux() takes gsm->mutex, closes
DLCI0 and drops its reference via gsm_dlci_release(); the final
tty_port_put() runs the gsm_dlci_free() destructor, which clears the slot
and frees the object:

```
  dlci->gsm->dlci[dlci->addr] =3D NULL;
  kfree(dlci);
```
If that happens while the worker is still in the dispatch above, it ends
up dereferencing the freed dlci. I can reproduce this as a use-after-free:

```
[  997.227486][   T46] BUG: KASAN: slab-use-after-free in gsm_control_reply=
.isra.0 (drivers/tty/n_gsm.c:1162 drivers/tty/n_gsm.c:1494)
[  997.229052][   T46] Read of size 8 at addr ffff888029ae9000 by task kwor=
ker/u16:2/46
[  997.230517][   T46]
[  997.230952][   T46] CPU: 1 UID: 0 PID: 46 Comm: kworker/u16:2 Not tainte=
d 7.1.0-rc7 #1 PREEMPT(full)
[  997.230958][   T46] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PII=
X, arch_caps fix, 1996), BIOS 1.16.3-debian-4
[  997.230961][   T46] Workqueue: events_unbound flush_to_ldisc
[  997.230969][   T46] Call Trace:
[  997.230972][   T46]  <TASK>
[  997.230974][   T46]  dump_stack_lvl (lib/dump_stack.c:94 lib/dump_stack.=
c:120)
[  997.230990][   T46]  print_report (mm/kasan/report.c:378 mm/kasan/report=
.c:482)
[  997.231008][   T46]  kasan_report (mm/kasan/report.c:595)
[  997.231016][   T46]  gsm_control_reply.isra.0 (drivers/tty/n_gsm.c:1162 =
drivers/tty/n_gsm.c:1494)
[  997.231020][   T46]  gsm_dlci_command (drivers/tty/n_gsm.c:1873 drivers/=
tty/n_gsm.c:2477)
[  997.231036][   T46]  gsmld_receive_buf (drivers/tty/n_gsm.c:3616)
[  997.231044][   T46]  tty_ldisc_receive_buf (drivers/tty/tty_buffer.c:398=
)
[  997.231052][   T46]  tty_port_default_receive_buf (drivers/tty/tty_port.=
c:37)
[  997.231056][   T46]  flush_to_ldisc (drivers/tty/tty_buffer.c:452 driver=
s/tty/tty_buffer.c:502)
[  997.231066][   T46]  process_one_work (kernel/workqueue.c:3314)
[  997.231082][   T46]  worker_thread (kernel/workqueue.c:3397 kernel/workq=
ueue.c:3478)
[  997.231091][   T46]  kthread (kernel/kthread.c:436)
[  997.231103][   T46]  ret_from_fork (arch/x86/kernel/process.c:158)
[  997.231120][   T46]  ret_from_fork_asm (arch/x86/entry/entry_64.S:245)
[  997.231128][   T46]  </TASK>
[  997.231130][   T46]
[  997.267905][   T46] Allocated by task 5110:
[  997.268716][   T46]  kasan_save_stack (mm/kasan/common.c:57)
[  997.269595][   T46]  kasan_save_track (mm/kasan/common.c:78)
[  997.270483][   T46]  __kasan_kmalloc (mm/kasan/common.c:398 mm/kasan/com=
mon.c:415)
[  997.271353][   T46]  gsm_dlci_alloc (./include/linux/slab.h:950 ./includ=
e/linux/slab.h:1188 drivers/tty/n_gsm.c:2648)
[  997.272203][   T46]  gsm_activate_mux (drivers/tty/n_gsm.c:3189)
[  997.273109][   T46]  gsmld_ioctl (drivers/tty/n_gsm.c:3443 drivers/tty/n=
_gsm.c:3846)
[  997.273981][   T46]  tty_ioctl (drivers/tty/tty_io.c:2801)
[  997.274789][   T46]  __x64_sys_ioctl (fs/ioctl.c:51 fs/ioctl.c:597 fs/io=
ctl.c:583 fs/ioctl.c:583)
[  997.275682][   T46]  do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/=
x86/entry/syscall_64.c:94)
[  997.276544][   T46]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entr=
y_64.S:121)
[  997.277658][   T46]
[  997.278108][   T46] Freed by task 5110:
[  997.278865][   T46]  kasan_save_stack (mm/kasan/common.c:57)
[  997.279740][   T46]  kasan_save_track (mm/kasan/common.c:78)
[  997.280615][   T46]  kasan_save_free_info (mm/kasan/generic.c:584)
[  997.281554][   T46]  __kasan_slab_free (mm/kasan/common.c:253 mm/kasan/c=
ommon.c:285)
[  997.282435][   T46]  kfree (./include/linux/kasan.h:235 mm/slub.c:2689 m=
m/slub.c:6251 mm/slub.c:6566)
[  997.283159][   T46]  gsm_cleanup_mux (drivers/tty/n_gsm.c:2711 drivers/t=
ty/n_gsm.c:2744 drivers/tty/n_gsm.c:3161)
[  997.284050][   T46]  gsmld_ioctl (drivers/tty/n_gsm.c:3415 drivers/tty/n=
_gsm.c:3846)
[  997.284928][   T46]  tty_ioctl (drivers/tty/tty_io.c:2801)
[  997.285746][   T46]  __x64_sys_ioctl (fs/ioctl.c:51 fs/ioctl.c:597 fs/io=
ctl.c:583 fs/ioctl.c:583)
[  997.286653][   T46]  do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/=
x86/entry/syscall_64.c:94)
[  997.287526][   T46]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entr=
y_64.S:121)
[  997.288639][   T46]

```

The NULL deref I reported  is the same unguarded access on the same
path, just hitting the window after the slot is already cleared. Either
way a NULL check in the handlers can't fix it, since in the UAF case dlci
isn't NULL.

I think the fix should serialize the receive side against
gsm_cleanup_mux() instead of checking in the handlers. Two ways I can see:

  1. take gsm->mutex around the dlci lookup and dispatch in gsm_queue(), or
  2. pin the dlci across the dispatch using its existing tty_port ref
    (dlci_get/dlci_put), so gsm_dlci_free() can't run while it's in use.

Do you have a preference, or is there a pattern in n_gsm you'd rather I
use? I'll respin v2 once I know which way to go.

And I'll send the reproducer and the config to trigger it in a separate mai=
l.

Thanks,
Weiming



