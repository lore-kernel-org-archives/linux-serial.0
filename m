Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5778F290DBB
	for <linux-serial@vger.kernel.org>; Sat, 13 Jun 2026 05:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781329411; cv=none; b=NuL11qEPudes2QcuZoH2X5726sF8LgwsS51yOyTXvvApv/YNx/OVwvBhnN09GMnizTA1n+SrQJz+0oe6GtYujtpKSjdo7/G80Japjn9KfgTEwjmqPxw1qSgpE2EUY7aewMtz9oy9uDF009M9jRjvMTkx5elnxpII6qjAJcSqWyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781329411; c=relaxed/simple;
	bh=KFN+03r8HJskf+Xt8e44KNgP3u5FoSvvHd1gKLLSIS0=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=M1Mba5g3ateM0HcYIROrP0jlntvSsqKIYbRjccUQVkPcVluCcUcQSnGxQH6Xi6EiDmig3WLFKhQKjaHpW99mmJsWau9LB2Zl57lYX5bh2sKdYY3gb7rEHHlZk0omh5GUkC95ISMhFCweCiPbVph2ZyDNtTpUCVmE5tMhK6eXwLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OCOuMwIh; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OCOuMwIh"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-3078e0dcd67so1969056eec.0
        for <linux-serial@vger.kernel.org>; Fri, 12 Jun 2026 22:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781329408; x=1781934208; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GSXxMphT9k8xLWbEOV7HUKMZyyID30KfpWFlHiMIVG0=;
        b=OCOuMwIh6tiYNtEx+H/jL0N7B3gJoONAuMYq+hXQ8seEORL4Ext76RNHk7g6A5+p0H
         DqBhi10GgkwhkVSU95xpNAg7/3vYlkdfNqcwCE3m6RkC2HCFD1ZM13yy4SQ28u27FxV8
         6/7YUKPVG8l6l6mib+DtCGgDgkpe+np4jwsc7kcZr/39YQA5WsokYn/AAV3OWec8wKlF
         jaoyE0Kv/DvYCqQPFTW2168liHGUfpt8rcMRW8oFhv21p0Bds3DpmIHVukJSDeoJizl3
         WKmMrjiciJIIHn59Y2d5nW2K6SCAjTXBMvuT/ZwB6HL8e+Guj/feM+BYNAHE0rzWpMYf
         1/QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781329408; x=1781934208;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GSXxMphT9k8xLWbEOV7HUKMZyyID30KfpWFlHiMIVG0=;
        b=nYd9X6SqUmtlfWlrmtQrYwnBW93ahgPvV2UUU7NjZaqjPnBhxC4Ti99I3woGSqh+NX
         +zVI673jdZNppVIfl4dDaRje75usuSoq+sVQENAlYssK4cqNZi9XU39yiq0oW8ZSHPNA
         dn3nRNeXEbAhiYdEm1wecQFkduibBClom0lMSYHWuZTtEwDQ4TCWENfsq2g3llX/yurE
         zzN04hhC6mjjlKlAK1poep9eWqO4IJS92g6G9abOwDp4r/EifxpgRsoSOoa891JMw0OW
         NTghGI7OnCQCgtFE4uS4XcbOdOcvuFYU8YnSK1pB1atuklQm6KPIRsG1cZ1vpPOJ0wzA
         te3g==
X-Forwarded-Encrypted: i=1; AFNElJ/vCRtktbxIX+OtdgMgT4HkUUwl+5njkoQ00b2J8cHUNZlELv+HjIFbKu/3ZUCE8w4snK1ptHy+VmxUuRo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCdU3qPZ6HYyx887iVbOX2FXtZ2AAYFt5E3EZHF+oDQDTBIhSV
	59/6524s3gZHXkdg4cB/NWRHHX/zuEJ1MAbE+KOR0AXExvxRdtCtYNFVym8LQQ==
X-Gm-Gg: Acq92OH3r2yXzqsdnnl1MhlR7HHCOhwAqhk/b6UuqpESYRCOzFMx+ZxIp3YUzznESHA
	7g4HmuzT4t71gpHPt+lD6zZvysxmTXW11QsqqCWyCcnVNti5G0u08K5uCAs8WF69JfoTlWpfXXN
	lZ2zljPYWhxvNwkk7ey129qlX610p31eyHMSZwK463TTZFR331U9uYcV1nSmb5ZoNkXw/RwWVkb
	n/Zl4HhQHNubbWwVoHRfngk0UR8wIY4mbk71ds4rRxnjGIx2fSo0fVVuXooLqc/JR0xI8xS58Zw
	rPv8KdscvRaYUjOCVGLuEOHz2EaqR/JmYAnILsHTTCvcZX1XmnqQ3YmUhdFKZYq1hyhNkSFWY1B
	TT7u+j69Yg6riGQSCS0SY60qZ3jnQB1s2+meLebbsCdETqXDDKfEGzYBkC4XEGys11ei3EbDe+n
	FzuLuN6C+H9vrE99Q28Lkp+iO7RneJCqjqoVqxPO6UjHxKTWjceec=
X-Received: by 2002:a05:7301:19ac:b0:2ea:c085:44b1 with SMTP id 5a478bee46e88-3093b944381mr1279035eec.19.1781329408334;
        Fri, 12 Jun 2026 22:43:28 -0700 (PDT)
Received: from localhost ([198.176.50.157])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e91f8b5sm6152938eec.19.2026.06.12.22.43.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jun 2026 22:43:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 13 Jun 2026 13:43:24 +0800
Message-Id: <DJ7OKN8EMAK8.22CE0B8NZXD73@gmail.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Weiming Shi"
 <bestswngs@gmail.com>
Cc: "Jiri Slaby" <jirislaby@kernel.org>, "Daniel Starke"
 <daniel.starke@siemens.com>, <linux-kernel@vger.kernel.org>,
 <linux-serial@vger.kernel.org>, "Xiang Mei" <xmei5@asu.edu>
Subject: Re: [PATCH] tty: n_gsm: fix NULL deref of gsm->dlci[0] in control
 message handlers
From: "Weiming Shi" <bestswngs@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260611183217.2488508-2-bestswngs@gmail.com>
 <2026061101-hanky-uninstall-da53@gregkh>
 <DJ74X3U3L9DZ.3RMWZCB0O5ZCE@gmail.com>
 <2026061228-scrubber-cosmetics-c77a@gregkh>
In-Reply-To: <2026061228-scrubber-cosmetics-c77a@gregkh>

On Fri Jun 12, 2026 at 10:28 PM CST, Greg Kroah-Hartman wrote:
> On Fri, Jun 12, 2026 at 10:19:18PM +0800, Weiming Shi wrote:
>> On Fri Jun 12, 2026 at 2:50 AM CST, Greg Kroah-Hartman wrote:
>> > On Thu, Jun 11, 2026 at 11:32:18AM -0700, Weiming Shi wrote:
>> >> gsm_control_command() and gsm_control_reply() load gsm->dlci[0] and
>> >> immediately dereference dlci->ftype without checking it for NULL.
>> >>=20
>> >> On the receive path, gsm_queue() validates that gsm->dlci[0] is non-N=
ULL
>> >> and DLCI_OPEN before invoking the control handler, but the value is n=
ot
>> >> held across that check: the receive worker runs from flush_to_ldisc()
>> >> without taking gsm->mutex, while a concurrent GSMIOC_SETCONF ioctl ca=
n
>> >> enter gsm_cleanup_mux(), which takes gsm->mutex, releases gsm->dlci[0=
]
>> >> and sets it to NULL. If the mux is torn down between gsm_queue()'s ch=
eck
>> >> and the re-load inside gsm_control_command()/gsm_control_reply(), the
>> >> handler dereferences a NULL dlci.
>> >>=20
>> >> A peer that drives DLCI 0 control frames (e.g. CMD_TEST) while the mu=
x
>> >> owner reconfigures the line discipline can therefore crash the kernel
>> >> (line numbers from decode_stacktrace.sh against the crashing build):
>> >>=20
>> >>  Oops: general protection fault, probably for non-canonical address
>> >>  KASAN: null-ptr-deref in range [0x0000000000000208-0x000000000000020=
f]
>> >>  RIP: 0010:gsm_control_reply (drivers/tty/n_gsm.c:1497)
>> >>  Call Trace:
>> >>   gsm_dlci_command (drivers/tty/n_gsm.c:2482)
>> >>   gsm_queue.part.0 (drivers/tty/n_gsm.c:2852)
>> >>   gsm0_receive (drivers/tty/n_gsm.c:2972)
>> >>   gsmld_receive_buf (drivers/tty/n_gsm.c:3629)
>> >>   tty_ldisc_receive_buf (drivers/tty/tty_buffer.c:391)
>> >>   tty_port_default_receive_buf (drivers/tty/tty_port.c:39)
>> >>   flush_to_ldisc (drivers/tty/tty_buffer.c:495)
>> >>   process_one_work
>> >>   worker_thread
>> >>   kthread
>> >>=20
>> >> The other callers of these helpers (the keep-alive and negotiation ti=
mer
>> >> paths) already guard the gsm->dlci[0] access; only the receive path i=
s
>> >> unguarded. The CMD_CLD handler in the same switch already checks the
>> >> loaded dlci for NULL for the very same reason. Bail out early when
>> >> gsm->dlci[0] has been cleared instead of dereferencing it.
>> >>=20
>> >> Triggering this requires CAP_NET_ADMIN to attach the n_gsm line
>> >> discipline (gsmld_open() uses capable(), not ns_capable()), so it is =
a
>> >> local denial of service for a privileged mux owner racing its own
>> >> control channel; harden the handlers regardless.
>> >>=20
>> >> Fixes: 5767712668b8 ("tty: n_gsm: cleanup gsm_control_command and gsm=
_control_reply")
>> >> Reported-by: Xiang Mei <xmei5@asu.edu>
>> >> Assisted-by: Claude:claude-opus-4-8
>> >> Signed-off-by: Weiming Shi <bestswngs@gmail.com>
>> >> ---
>> >>  drivers/tty/n_gsm.c | 6 ++++++
>> >>  1 file changed, 6 insertions(+)
>> >>=20
>> >> diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
>> >> index 214abeb89aaa..860cfb91d510 100644
>> >> --- a/drivers/tty/n_gsm.c
>> >> +++ b/drivers/tty/n_gsm.c
>> >> @@ -1457,6 +1457,9 @@ static int gsm_control_command(struct gsm_mux *=
gsm, int cmd, const u8 *data,
>> >>  	struct gsm_msg *msg;
>> >>  	struct gsm_dlci *dlci =3D gsm->dlci[0];
>> >> =20
>> >> +	if (!dlci)
>> >> +		return -EINVAL;
>> >
>> > What precents dlci from being NULL right after you check this?
>> >
>> > thanks,
>> >
>> > greg k-h
>>=20
>> Hi greg,
>>=20
>> I'm sorry for taking so long to respond.
>>=20
>> After a closer look I think your review is correct.
>>=20
>> The real problem is that the receive path touches gsm->dlci[] with no
>> lock. The teardown side holds gsm->mutex while it releases and frees the
>> dlci, but the receive worker does not: gsm_queue() loads
>> dlci =3D gsm->dlci[address] while it is still valid and passes it down
>> through dlci->data() to gsm_control_command()/gsm_control_reply(), which
>> also re-read gsm->dlci[0] and dereference dlci->ftype.
>>=20
>> Meanwhile GSMIOC_SETCONF -> gsm_cleanup_mux() takes gsm->mutex, closes
>> DLCI0 and drops its reference via gsm_dlci_release(); the final
>> tty_port_put() runs the gsm_dlci_free() destructor, which clears the slo=
t
>> and frees the object:
>>=20
>> ```
>>   dlci->gsm->dlci[dlci->addr] =3D NULL;
>>   kfree(dlci);
>> ```
>> If that happens while the worker is still in the dispatch above, it ends
>> up dereferencing the freed dlci. I can reproduce this as a use-after-fre=
e:
>>=20
>> ```
>> [  997.227486][   T46] BUG: KASAN: slab-use-after-free in gsm_control_re=
ply.isra.0 (drivers/tty/n_gsm.c:1162 drivers/tty/n_gsm.c:1494)
>> [  997.229052][   T46] Read of size 8 at addr ffff888029ae9000 by task k=
worker/u16:2/46
>> [  997.230517][   T46]
>> [  997.230952][   T46] CPU: 1 UID: 0 PID: 46 Comm: kworker/u16:2 Not tai=
nted 7.1.0-rc7 #1 PREEMPT(full)
>> [  997.230958][   T46] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + =
PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-4
>> [  997.230961][   T46] Workqueue: events_unbound flush_to_ldisc
>> [  997.230969][   T46] Call Trace:
>> [  997.230972][   T46]  <TASK>
>> [  997.230974][   T46]  dump_stack_lvl (lib/dump_stack.c:94 lib/dump_sta=
ck.c:120)
>> [  997.230990][   T46]  print_report (mm/kasan/report.c:378 mm/kasan/rep=
ort.c:482)
>> [  997.231008][   T46]  kasan_report (mm/kasan/report.c:595)
>> [  997.231016][   T46]  gsm_control_reply.isra.0 (drivers/tty/n_gsm.c:11=
62 drivers/tty/n_gsm.c:1494)
>> [  997.231020][   T46]  gsm_dlci_command (drivers/tty/n_gsm.c:1873 drive=
rs/tty/n_gsm.c:2477)
>> [  997.231036][   T46]  gsmld_receive_buf (drivers/tty/n_gsm.c:3616)
>> [  997.231044][   T46]  tty_ldisc_receive_buf (drivers/tty/tty_buffer.c:=
398)
>> [  997.231052][   T46]  tty_port_default_receive_buf (drivers/tty/tty_po=
rt.c:37)
>> [  997.231056][   T46]  flush_to_ldisc (drivers/tty/tty_buffer.c:452 dri=
vers/tty/tty_buffer.c:502)
>> [  997.231066][   T46]  process_one_work (kernel/workqueue.c:3314)
>> [  997.231082][   T46]  worker_thread (kernel/workqueue.c:3397 kernel/wo=
rkqueue.c:3478)
>> [  997.231091][   T46]  kthread (kernel/kthread.c:436)
>> [  997.231103][   T46]  ret_from_fork (arch/x86/kernel/process.c:158)
>> [  997.231120][   T46]  ret_from_fork_asm (arch/x86/entry/entry_64.S:245=
)
>> [  997.231128][   T46]  </TASK>
>> [  997.231130][   T46]
>> [  997.267905][   T46] Allocated by task 5110:
>> [  997.268716][   T46]  kasan_save_stack (mm/kasan/common.c:57)
>> [  997.269595][   T46]  kasan_save_track (mm/kasan/common.c:78)
>> [  997.270483][   T46]  __kasan_kmalloc (mm/kasan/common.c:398 mm/kasan/=
common.c:415)
>> [  997.271353][   T46]  gsm_dlci_alloc (./include/linux/slab.h:950 ./inc=
lude/linux/slab.h:1188 drivers/tty/n_gsm.c:2648)
>> [  997.272203][   T46]  gsm_activate_mux (drivers/tty/n_gsm.c:3189)
>> [  997.273109][   T46]  gsmld_ioctl (drivers/tty/n_gsm.c:3443 drivers/tt=
y/n_gsm.c:3846)
>> [  997.273981][   T46]  tty_ioctl (drivers/tty/tty_io.c:2801)
>> [  997.274789][   T46]  __x64_sys_ioctl (fs/ioctl.c:51 fs/ioctl.c:597 fs=
/ioctl.c:583 fs/ioctl.c:583)
>> [  997.275682][   T46]  do_syscall_64 (arch/x86/entry/syscall_64.c:63 ar=
ch/x86/entry/syscall_64.c:94)
>> [  997.276544][   T46]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/e=
ntry_64.S:121)
>> [  997.277658][   T46]
>> [  997.278108][   T46] Freed by task 5110:
>> [  997.278865][   T46]  kasan_save_stack (mm/kasan/common.c:57)
>> [  997.279740][   T46]  kasan_save_track (mm/kasan/common.c:78)
>> [  997.280615][   T46]  kasan_save_free_info (mm/kasan/generic.c:584)
>> [  997.281554][   T46]  __kasan_slab_free (mm/kasan/common.c:253 mm/kasa=
n/common.c:285)
>> [  997.282435][   T46]  kfree (./include/linux/kasan.h:235 mm/slub.c:268=
9 mm/slub.c:6251 mm/slub.c:6566)
>> [  997.283159][   T46]  gsm_cleanup_mux (drivers/tty/n_gsm.c:2711 driver=
s/tty/n_gsm.c:2744 drivers/tty/n_gsm.c:3161)
>> [  997.284050][   T46]  gsmld_ioctl (drivers/tty/n_gsm.c:3415 drivers/tt=
y/n_gsm.c:3846)
>> [  997.284928][   T46]  tty_ioctl (drivers/tty/tty_io.c:2801)
>> [  997.285746][   T46]  __x64_sys_ioctl (fs/ioctl.c:51 fs/ioctl.c:597 fs=
/ioctl.c:583 fs/ioctl.c:583)
>> [  997.286653][   T46]  do_syscall_64 (arch/x86/entry/syscall_64.c:63 ar=
ch/x86/entry/syscall_64.c:94)
>> [  997.287526][   T46]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/e=
ntry_64.S:121)
>> [  997.288639][   T46]
>>=20
>> ```
>>=20
>> The NULL deref I reported  is the same unguarded access on the same
>> path, just hitting the window after the slot is already cleared. Either
>> way a NULL check in the handlers can't fix it, since in the UAF case dlc=
i
>> isn't NULL.
>>=20
>> I think the fix should serialize the receive side against
>> gsm_cleanup_mux() instead of checking in the handlers. Two ways I can se=
e:
>>=20
>>   1. take gsm->mutex around the dlci lookup and dispatch in gsm_queue(),=
 or
>>   2. pin the dlci across the dispatch using its existing tty_port ref
>>     (dlci_get/dlci_put), so gsm_dlci_free() can't run while it's in use.
>>=20
>> Do you have a preference, or is there a pattern in n_gsm you'd rather I
>> use? I'll respin v2 once I know which way to go.
>
> The bigger issue here is that almost no one has this hardware.  And
> those that do, don't care about these types of issues as they do not
> have untrusted data or untrusted users, so be careful when changing
> things that you aren't able to test.
>
> I think that option 2 would probably be best, as that should not affect
> any fast code paths, right?
>
>> And I'll send the reproducer and the config to trigger it in a separate =
mail.
>
> Can you turn that into a real test to be added to the tree in the
> correct location?  I think we need to start adding these so that we get
> a base regression test for people to be able to run as all the LLM tools
> seem to love the broken code in this file :)
>
> thanks,
>
> greg k-h

Hi greg,

I'll try to write a base regression test and sent it together with the v2.

Best,
Weiming Shi
