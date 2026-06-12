Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3AB384CD6;
	Fri, 12 Jun 2026 14:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781274566; cv=none; b=b5wOf8ZxhBHshSQokuby750EY1nUwYmtj2GM7LlmZD6Rr0iC7qLO33tWmAFJlrg8OgNwLbCDaBAQFrz2e+DwSqxYR9GcywKRoMpI6VMUtH38PT+JDm+IewxlX2lMmhKkvb+dvq+QBGRC6BvmF0JasdAmPh5/jSzUK0Db4ncDYk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781274566; c=relaxed/simple;
	bh=6lFgxIQzmV+PACg/gAQarABFXMGB8cB/1EtLLRS2VQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XXSnUiJVgKcTGauU3H86BKmUXZwq3NVwQuJF7LtOauFzPN+7zdAgR6qHEAK59SGOSnwAqRFluueZ6lZcEIdOR3xxVIT1fRO3SDvpKyLwlh7rhi+lBxlRbL2f2GV4vifoGDYwdm5RLSkM1nsA5aDp455IH2DMZZvagV7M45o+sT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=d/hptFRe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="d/hptFRe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA1721F000E9;
	Fri, 12 Jun 2026 14:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781274564;
	bh=MjZKC8AVLnQ/8fEQWv4YPmiBFIZF1bjXR2R46TUXNwg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=d/hptFReW5W6JyFUBjxXk6ZDKQDL8EzQi2MTrGVmeha09jo4hgWVQYAQGtmTq4FmN
	 u9gX8ONbbcc6VzFj+GI7coIVCBLbR22IeOjNBPwvQzCOS6gbD75A6KUA0VXVuc6Plt
	 zOsiGCyXDTHaW3agVgQjBhSC2ODYnoBHoiELpVO4=
Date: Fri, 12 Jun 2026 16:28:23 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Weiming Shi <bestswngs@gmail.com>
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Daniel Starke <daniel.starke@siemens.com>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>
Subject: Re: [PATCH] tty: n_gsm: fix NULL deref of gsm->dlci[0] in control
 message handlers
Message-ID: <2026061228-scrubber-cosmetics-c77a@gregkh>
References: <20260611183217.2488508-2-bestswngs@gmail.com>
 <2026061101-hanky-uninstall-da53@gregkh>
 <DJ74X3U3L9DZ.3RMWZCB0O5ZCE@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DJ74X3U3L9DZ.3RMWZCB0O5ZCE@gmail.com>

On Fri, Jun 12, 2026 at 10:19:18PM +0800, Weiming Shi wrote:
> On Fri Jun 12, 2026 at 2:50 AM CST, Greg Kroah-Hartman wrote:
> > On Thu, Jun 11, 2026 at 11:32:18AM -0700, Weiming Shi wrote:
> >> gsm_control_command() and gsm_control_reply() load gsm->dlci[0] and
> >> immediately dereference dlci->ftype without checking it for NULL.
> >> 
> >> On the receive path, gsm_queue() validates that gsm->dlci[0] is non-NULL
> >> and DLCI_OPEN before invoking the control handler, but the value is not
> >> held across that check: the receive worker runs from flush_to_ldisc()
> >> without taking gsm->mutex, while a concurrent GSMIOC_SETCONF ioctl can
> >> enter gsm_cleanup_mux(), which takes gsm->mutex, releases gsm->dlci[0]
> >> and sets it to NULL. If the mux is torn down between gsm_queue()'s check
> >> and the re-load inside gsm_control_command()/gsm_control_reply(), the
> >> handler dereferences a NULL dlci.
> >> 
> >> A peer that drives DLCI 0 control frames (e.g. CMD_TEST) while the mux
> >> owner reconfigures the line discipline can therefore crash the kernel
> >> (line numbers from decode_stacktrace.sh against the crashing build):
> >> 
> >>  Oops: general protection fault, probably for non-canonical address
> >>  KASAN: null-ptr-deref in range [0x0000000000000208-0x000000000000020f]
> >>  RIP: 0010:gsm_control_reply (drivers/tty/n_gsm.c:1497)
> >>  Call Trace:
> >>   gsm_dlci_command (drivers/tty/n_gsm.c:2482)
> >>   gsm_queue.part.0 (drivers/tty/n_gsm.c:2852)
> >>   gsm0_receive (drivers/tty/n_gsm.c:2972)
> >>   gsmld_receive_buf (drivers/tty/n_gsm.c:3629)
> >>   tty_ldisc_receive_buf (drivers/tty/tty_buffer.c:391)
> >>   tty_port_default_receive_buf (drivers/tty/tty_port.c:39)
> >>   flush_to_ldisc (drivers/tty/tty_buffer.c:495)
> >>   process_one_work
> >>   worker_thread
> >>   kthread
> >> 
> >> The other callers of these helpers (the keep-alive and negotiation timer
> >> paths) already guard the gsm->dlci[0] access; only the receive path is
> >> unguarded. The CMD_CLD handler in the same switch already checks the
> >> loaded dlci for NULL for the very same reason. Bail out early when
> >> gsm->dlci[0] has been cleared instead of dereferencing it.
> >> 
> >> Triggering this requires CAP_NET_ADMIN to attach the n_gsm line
> >> discipline (gsmld_open() uses capable(), not ns_capable()), so it is a
> >> local denial of service for a privileged mux owner racing its own
> >> control channel; harden the handlers regardless.
> >> 
> >> Fixes: 5767712668b8 ("tty: n_gsm: cleanup gsm_control_command and gsm_control_reply")
> >> Reported-by: Xiang Mei <xmei5@asu.edu>
> >> Assisted-by: Claude:claude-opus-4-8
> >> Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> >> ---
> >>  drivers/tty/n_gsm.c | 6 ++++++
> >>  1 file changed, 6 insertions(+)
> >> 
> >> diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
> >> index 214abeb89aaa..860cfb91d510 100644
> >> --- a/drivers/tty/n_gsm.c
> >> +++ b/drivers/tty/n_gsm.c
> >> @@ -1457,6 +1457,9 @@ static int gsm_control_command(struct gsm_mux *gsm, int cmd, const u8 *data,
> >>  	struct gsm_msg *msg;
> >>  	struct gsm_dlci *dlci = gsm->dlci[0];
> >>  
> >> +	if (!dlci)
> >> +		return -EINVAL;
> >
> > What precents dlci from being NULL right after you check this?
> >
> > thanks,
> >
> > greg k-h
> 
> Hi greg,
> 
> I'm sorry for taking so long to respond.
> 
> After a closer look I think your review is correct.
> 
> The real problem is that the receive path touches gsm->dlci[] with no
> lock. The teardown side holds gsm->mutex while it releases and frees the
> dlci, but the receive worker does not: gsm_queue() loads
> dlci = gsm->dlci[address] while it is still valid and passes it down
> through dlci->data() to gsm_control_command()/gsm_control_reply(), which
> also re-read gsm->dlci[0] and dereference dlci->ftype.
> 
> Meanwhile GSMIOC_SETCONF -> gsm_cleanup_mux() takes gsm->mutex, closes
> DLCI0 and drops its reference via gsm_dlci_release(); the final
> tty_port_put() runs the gsm_dlci_free() destructor, which clears the slot
> and frees the object:
> 
> ```
>   dlci->gsm->dlci[dlci->addr] = NULL;
>   kfree(dlci);
> ```
> If that happens while the worker is still in the dispatch above, it ends
> up dereferencing the freed dlci. I can reproduce this as a use-after-free:
> 
> ```
> [  997.227486][   T46] BUG: KASAN: slab-use-after-free in gsm_control_reply.isra.0 (drivers/tty/n_gsm.c:1162 drivers/tty/n_gsm.c:1494)
> [  997.229052][   T46] Read of size 8 at addr ffff888029ae9000 by task kworker/u16:2/46
> [  997.230517][   T46]
> [  997.230952][   T46] CPU: 1 UID: 0 PID: 46 Comm: kworker/u16:2 Not tainted 7.1.0-rc7 #1 PREEMPT(full)
> [  997.230958][   T46] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-4
> [  997.230961][   T46] Workqueue: events_unbound flush_to_ldisc
> [  997.230969][   T46] Call Trace:
> [  997.230972][   T46]  <TASK>
> [  997.230974][   T46]  dump_stack_lvl (lib/dump_stack.c:94 lib/dump_stack.c:120)
> [  997.230990][   T46]  print_report (mm/kasan/report.c:378 mm/kasan/report.c:482)
> [  997.231008][   T46]  kasan_report (mm/kasan/report.c:595)
> [  997.231016][   T46]  gsm_control_reply.isra.0 (drivers/tty/n_gsm.c:1162 drivers/tty/n_gsm.c:1494)
> [  997.231020][   T46]  gsm_dlci_command (drivers/tty/n_gsm.c:1873 drivers/tty/n_gsm.c:2477)
> [  997.231036][   T46]  gsmld_receive_buf (drivers/tty/n_gsm.c:3616)
> [  997.231044][   T46]  tty_ldisc_receive_buf (drivers/tty/tty_buffer.c:398)
> [  997.231052][   T46]  tty_port_default_receive_buf (drivers/tty/tty_port.c:37)
> [  997.231056][   T46]  flush_to_ldisc (drivers/tty/tty_buffer.c:452 drivers/tty/tty_buffer.c:502)
> [  997.231066][   T46]  process_one_work (kernel/workqueue.c:3314)
> [  997.231082][   T46]  worker_thread (kernel/workqueue.c:3397 kernel/workqueue.c:3478)
> [  997.231091][   T46]  kthread (kernel/kthread.c:436)
> [  997.231103][   T46]  ret_from_fork (arch/x86/kernel/process.c:158)
> [  997.231120][   T46]  ret_from_fork_asm (arch/x86/entry/entry_64.S:245)
> [  997.231128][   T46]  </TASK>
> [  997.231130][   T46]
> [  997.267905][   T46] Allocated by task 5110:
> [  997.268716][   T46]  kasan_save_stack (mm/kasan/common.c:57)
> [  997.269595][   T46]  kasan_save_track (mm/kasan/common.c:78)
> [  997.270483][   T46]  __kasan_kmalloc (mm/kasan/common.c:398 mm/kasan/common.c:415)
> [  997.271353][   T46]  gsm_dlci_alloc (./include/linux/slab.h:950 ./include/linux/slab.h:1188 drivers/tty/n_gsm.c:2648)
> [  997.272203][   T46]  gsm_activate_mux (drivers/tty/n_gsm.c:3189)
> [  997.273109][   T46]  gsmld_ioctl (drivers/tty/n_gsm.c:3443 drivers/tty/n_gsm.c:3846)
> [  997.273981][   T46]  tty_ioctl (drivers/tty/tty_io.c:2801)
> [  997.274789][   T46]  __x64_sys_ioctl (fs/ioctl.c:51 fs/ioctl.c:597 fs/ioctl.c:583 fs/ioctl.c:583)
> [  997.275682][   T46]  do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:94)
> [  997.276544][   T46]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
> [  997.277658][   T46]
> [  997.278108][   T46] Freed by task 5110:
> [  997.278865][   T46]  kasan_save_stack (mm/kasan/common.c:57)
> [  997.279740][   T46]  kasan_save_track (mm/kasan/common.c:78)
> [  997.280615][   T46]  kasan_save_free_info (mm/kasan/generic.c:584)
> [  997.281554][   T46]  __kasan_slab_free (mm/kasan/common.c:253 mm/kasan/common.c:285)
> [  997.282435][   T46]  kfree (./include/linux/kasan.h:235 mm/slub.c:2689 mm/slub.c:6251 mm/slub.c:6566)
> [  997.283159][   T46]  gsm_cleanup_mux (drivers/tty/n_gsm.c:2711 drivers/tty/n_gsm.c:2744 drivers/tty/n_gsm.c:3161)
> [  997.284050][   T46]  gsmld_ioctl (drivers/tty/n_gsm.c:3415 drivers/tty/n_gsm.c:3846)
> [  997.284928][   T46]  tty_ioctl (drivers/tty/tty_io.c:2801)
> [  997.285746][   T46]  __x64_sys_ioctl (fs/ioctl.c:51 fs/ioctl.c:597 fs/ioctl.c:583 fs/ioctl.c:583)
> [  997.286653][   T46]  do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:94)
> [  997.287526][   T46]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
> [  997.288639][   T46]
> 
> ```
> 
> The NULL deref I reported  is the same unguarded access on the same
> path, just hitting the window after the slot is already cleared. Either
> way a NULL check in the handlers can't fix it, since in the UAF case dlci
> isn't NULL.
> 
> I think the fix should serialize the receive side against
> gsm_cleanup_mux() instead of checking in the handlers. Two ways I can see:
> 
>   1. take gsm->mutex around the dlci lookup and dispatch in gsm_queue(), or
>   2. pin the dlci across the dispatch using its existing tty_port ref
>     (dlci_get/dlci_put), so gsm_dlci_free() can't run while it's in use.
> 
> Do you have a preference, or is there a pattern in n_gsm you'd rather I
> use? I'll respin v2 once I know which way to go.

The bigger issue here is that almost no one has this hardware.  And
those that do, don't care about these types of issues as they do not
have untrusted data or untrusted users, so be careful when changing
things that you aren't able to test.

I think that option 2 would probably be best, as that should not affect
any fast code paths, right?

> And I'll send the reproducer and the config to trigger it in a separate mail.

Can you turn that into a real test to be added to the tree in the
correct location?  I think we need to start adding these so that we get
a base regression test for people to be able to run as all the LLM tools
seem to love the broken code in this file :)

thanks,

greg k-h
