Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D8F3B6C0F;
	Tue, 17 Mar 2026 11:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773748708; cv=none; b=pmQdJEuG4jSkJdN9Gj6FQ0gUy5s4+evcoC7N+lC9qU9EOWFOBEd0G4b1K0hgJ5N3WcAqr2MkYDqyf+sdZbIHnlv4IkOyAyYB88IgF/qZWOcUWpJuJTJ/pggvfOhrCo+FURLU6pj0QZwNrdN0fL4891SLkm1RwvkWjp0X8orBeKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773748708; c=relaxed/simple;
	bh=elXTYw/RtQD1/bel5xY7v/8nSloETnAG/Khw92+WYvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SR1WgJBPQAGQEeykK24sBMlzM3g0vvoXXXd6mCPyu3VjEugCUdvNHStHn0ME0oyjbXsmNzahICXkgVSU7o3fAz16b8irIYTd6rbDeM62fSPet1eN2lMw5QFZmuAUuoxZLCK6U0IVFzeCHvhD4S/Zicfq/EX/t76tLgLPVpWZRNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0eezA0TP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0eezA0TP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B65C0C4CEF7;
	Tue, 17 Mar 2026 11:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773748708;
	bh=elXTYw/RtQD1/bel5xY7v/8nSloETnAG/Khw92+WYvU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0eezA0TPdfGYTP9+GdH9++R7ebz5ho9fepZwwsLmGDIo8C/ClvM7UC9lmjeTcvhcn
	 nz36/oajhZAziflYvO8rDRsJDh4VA9gpFTJg9XybZ2MUA4diPlrf4iY9d+csOa6kup
	 oRDnkXFqO/hzvx71P+QZndGq78tcxNO/gC/FAEvk=
Date: Tue, 17 Mar 2026 12:58:24 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: ziyu zhang <ziyuzhang201@gmail.com>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, baijiaju1990@gmail.com,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] tty: n_tty: annotate lockless read of ldata->icanon
 in input_available_p()
Message-ID: <2026031709-stiffness-edging-8792@gregkh>
References: <20260317081911.24390-1-ziyuzhang201@gmail.com>
 <2026031702-unsheathe-gizmo-6851@gregkh>
 <CACPoYJweQ8iKp+zKNZ1nre22rq4JGNn7xqJ2TSzDSLtKMPoybw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACPoYJweQ8iKp+zKNZ1nre22rq4JGNn7xqJ2TSzDSLtKMPoybw@mail.gmail.com>

On Tue, Mar 17, 2026 at 07:45:44PM +0800, ziyu zhang wrote:
> > Given that the previous patch was not even tested, how was this found
> > and most importantly, tested?
> 
> My apologies for sending the v1 patch without properly compile-testing
> it first.
> It is a data race found by our testing tool. The detailed report is
> showed below.

As per our documentation, you MUST document what type of tool you are
using when you find stuff like this, so we can push back and say "hey,
your tool is broken!"  :)

And as you never actually tested this, I'm kind of thinking that your
tool is broken...

> Kernel panic: ============ DATARACE ============
> VarName 11902078599461647536, BlockLineNumber 36, IrLineNumber 3, is write 1
> Function: found_watchpoint kernel/kccwf/wp_checker.c:126 [inline]
> Function: watchpoints_monitor+0x1ac2/0x22a0 kernel/kccwf/wp_checker.c:217
> Function: kccwf_rec_mem_access+0x275e/0x2b70
> Function: n_tty_set_termios+0x5d1/0x37a0 drivers/tty/n_tty.c:1793
> Function: tty_set_termios+0x112d/0x1b80 drivers/tty/tty_ioctl.c:348
> Function: set_termios+0xc1b/0xca0 drivers/tty/tty_ioctl.c:512
> Function: tty_mode_ioctl+0x5e5/0x9d0
> Function: n_tty_ioctl_helper+0xe5/0x8f0 drivers/tty/tty_ioctl.c:982
> Function: n_tty_ioctl+0x253/0x730 drivers/tty/n_tty.c:2509
> Function: tty_ioctl+0x1cfb/0x3070 drivers/tty/tty_io.c:2801
> Function: vfs_ioctl fs/ioctl.c:51 [inline]
> Function: __do_sys_ioctl fs/ioctl.c:598 [inline]
> Function: __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:584
> Function: do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> Function: do_syscall_64+0xd2/0x200 arch/x86/entry/syscall_64.c:94
> Function: entry_SYSCALL_64_after_hwframe+0x77/0x7f
> Function: 0x0

What is panicing here?

> ============OTHER_INFO============
> VarName 16560329611981062523, BlockLineNumber 32, IrLineNumber 1,
> watchpoint index 38236
> Function: set_report_info+0xbd/0x2c0 kernel/kccwf/report.c:57
> Function: setup_watchpoint kernel/kccwf/wp_checker.c:158 [inline]
> Function: watchpoints_monitor+0xe0e/0x22a0 kernel/kccwf/wp_checker.c:239
> Function: kccwf_rec_mem_access+0x275e/0x2b70
> Function: input_available_p drivers/tty/n_tty.c:1923 [inline]
> Function: n_tty_poll+0x3f5/0x16b0 drivers/tty/n_tty.c:2452
> Function: tty_poll+0x224/0x4a0 drivers/tty/tty_io.c:2199
> Function: vfs_poll include/linux/poll.h:82 [inline]
> Function: select_poll_one fs/select.c:480 [inline]
> Function: do_select+0xce7/0x13d0 fs/select.c:536
> Function: core_sys_select+0x3e8/0x5d0 fs/select.c:677
> Function: do_pselect fs/select.c:759 [inline]
> Function: __do_sys_pselect6 fs/select.c:802 [inline]
> Function: __se_sys_pselect6+0x1d8/0x240 fs/select.c:793
> Function: do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> Function: do_syscall_64+0xd2/0x200 arch/x86/entry/syscall_64.c:94
> Function: entry_SYSCALL_64_after_hwframe+0x77/0x7f
> =================END==============
> 
> > What error was reported that this now
> > fixes?
> 
> Error: cannot pass bit-field as __auto_type initializer in C.
> The detailed error is showed below.
> 
> drivers/tty/n_tty.c:1913:6: error: cannot pass bit-field as
> __auto_type initializer in C
>     1913 |         if (data_race(ldata->icanon) && !L_EXTPROC(tty))
>          |             ^
>    include/linux/compiler.h:194:13: note: expanded from macro 'data_race'
>      194 |         auto __v = (expr);
>             \
>          |                    ^
>    1 error generated.

That is the error that the first version of your patch generated when
you actually built it, which proves you never actually tested it!

Always test your changes, ESPECIALLY for core portions of the kernel
that everyone relies on.

> > What changed to cause this to now be needed?
> 
> In my initial v1 patch, I carelessly wrapped the bit-field directly in
> the data_race() macro without locally compile-testing it.
> The data_race(expr) macro internally utilizes __auto_type (or typeof).
> And the C standard strictly prohibits passing a bit-field directly as
> an initializer for __auto_type.
> Adding !! forces the bit-field to be evaluated as a standard
> boolean/integer expression, which bypasses this compiler restriction.
> I sincerely apologize for the oversight in my initial patch and any
> extra work it may have caused.
> Thank you for your time and patience. I will submit a v3 patch if necessary.

Your v1 patch was wrong, and not tested, and I'm asking what changed to
require any of this?  What is wrong with the original code, and what
changed to cause it to suddenly be wrong as this is probably one of the
oldest parts of the kernel still in active use today.

thanks,

greg k-h
