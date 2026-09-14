Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1AE941378D
	for <linux-serial@vger.kernel.org>; Mon, 14 Sep 2026 09:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789378473; cv=none; b=FX64pVOTej7N7G5U2vZ/U2gkwBsSma01FHkwtpuMR0KC+XvZC5478LV03k1u42W6rXIHHrtA6ELBmk19n2tLEQRAqISkG3ip5Gj+sgngpqX/J99rJC8kfDFNu+X4OxfzPoSVOAzZitOPkqPqr0JEkuHwcc0AWcJqA6Tfi3nSwWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789378473; c=relaxed/simple;
	bh=F9kREIRf3Ig9UgSB4LaiZ0uAxLqbvVsx82KJvon0pPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FVI0+rK8WdOLcCc+tID1RKNgipIIc5Z3UP6CoZabrDawDv7sQ5WYl8TN8jENFBfHKVtDgd8NYIFc1gQXuttv/hTGySRadJcu+L/YGEGdawvF2A/mpoXojIphf5ESSwdhN0hW0Yf7x3Ph6+4gepqdAjZc9OEJklzf61OuVaPPzS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qQhRIrby; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qQhRIrby"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-49e6deb520eso23039895e9.0
        for <linux-serial@vger.kernel.org>; Mon, 14 Sep 2026 02:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789378470; x=1789983270; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qhpKpTgQJRnbW6lGpwxnwI5Tq36h+wEsmUTgFxtkd1g=;
        b=qQhRIrbyhJDbMjxJCDYWfa8dclFTfZ/PTd6ToHcD1oaLjrx8n4LQisfy5uO3stUMAV
         Fbg/91Zb0RaLPbAeH1Vp9CcbPsSbt3aSLPg5HtxUiTmKKI2YsI+OWEvWbEq/dWGi2w6/
         487elbLNXJ1njGjrZi09CcHJeUAm545UZ9Eqbzf5pDsTuSxuQ7EJJsN5xkA5dc1WH6av
         FOrTbaCfKtRnndOHl2XWLHivGrBiR+i1P8rfAZZFNLCQpynsZHtPGmuuXA/Ov88LGXtS
         W8QFl0VKnD8azHW1+3iSl027xZeVKM7Eko65p0pPqlIgLQKB8Ob4XQ1DmPJ+qIT5+X1r
         wDHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789378470; x=1789983270;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=qhpKpTgQJRnbW6lGpwxnwI5Tq36h+wEsmUTgFxtkd1g=;
        b=SqRXrCHiIuTLEtrb9S3f/NtFEF0scPQpPnfRvsfFV8yz7CzLVsrwz8cnR7bD1E00KX
         LlU9YPjLWU/nPxEQhcs5lvjaPTtjC2Q5MyZaa1RbYvqEK3KLqFbq7tl+gLyTM5XqySFb
         O0YEOQFQg8Vmc9zQUbgNkd/C4TiQIKqfZGVHNh6of7I2eaS2IFC64SLXII9rbF0UWxJx
         qysJb6vmTCRr8DuCpQ0dxQaSOpG6TbecfaANfVtTRwDOrFkc0WpdHAguU/FZVP2JeXSQ
         /sfyDRdojoOfj3Gbs8F4A1eTMpiKoz4fkRYqntJvuwjj16r3BiVW2DW8miG81G3Qc0lT
         BlsA==
X-Forwarded-Encrypted: i=1; AKwUvBwDtbNTEORc+bBdB/MYuLdAZvICTuevQ46lLXEZksHOhH0o8es6nl7HmTFPGxPCsXu7oCx9XWzhIU443rU=@vger.kernel.org
X-Gm-Message-State: AFuF++nbq6W7TmYSDKyt/amLsFTzvpBDF55lvB4MhG9nsqtPS1zxAaJ0
	ledBP1XF4JIXqfmWOHygXVrhTZxgZRXLRb+9muO7Xwp+8t6ic/rcl01Z
X-Gm-Gg: AYBFou3Wl6FJnis/i9lDQu+66TtOIRhFwWIiaHldyt2osWdmIbZ75LhKEKkHIWIFn9x
	NfsBmVGSIiY1NRfjJKnp1mNqZ44XOzPq2Oi+taQkEdftqZ3dbIbevbLBXacUu1p/Uz2R0zfaljk
	wfS0KUrtXZKYaxf/LfPhFr1XF7zkO184Yt1dL7X2JdVfHoZku8UR9WjAa38hRcVm/fGbR6V0Pf6
	gfRv4F98Arf7t6o6fbqJCXgV+pL85KS7/2/bu3mPH+rHnp67PWIlSTL90CBApVOk06xCNzYdr7z
	8M5B/vvpORWuUqGJumyfAtvEmEkaRzWU1L2MQ4TWbMpLWIS8VFp+2Lpu5fn2MRuKBEXglwY8vgi
	7IUS6kSv1KyQprsbGkPQ9v35U5krqH3yjcS4xOsBPkhSVmDYwcp3amwVdFs18ZMM/sh4yjl301O
	nISTqhJ0YkwPVhfAGYCrNIaPzBXYPmPDl6oJBfxr2Lai8C2DlvDy5eMqvrZW6DEDUt8R6gTn6i8
	92tg6P0oR2fuQVVWF3Yl5PjjfNCcOxqWgtT
X-Received: by 2002:a05:600c:1c19:b0:49e:6cc1:14d9 with SMTP id 5b1f17b1804b1-49e7a691ad9mr22121805e9.32.1789378469602;
        Mon, 14 Sep 2026 02:34:29 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e63c9a7c9sm509436105e9.13.2026.09.14.02.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 02:34:29 -0700 (PDT)
Date: Mon, 14 Sep 2026 11:34:23 +0200
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: Christopher Lusk <clusk@northecho.dev>
Cc: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Oleg Nesterov <oleg@redhat.com>, Jiri Slaby <jirislaby@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	Paul Moore <paul@paul-moore.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	John Johansen <john.johansen@canonical.com>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] Landlock signal scope and TIOCSIG
Message-ID: <20260914.b8a029f9abb8@gnoack.org>
References: <20260913221958.839429-1-clusk@northecho.dev>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260913221958.839429-1-clusk@northecho.dev>

Hello Christopher!

On Sun, Sep 13, 2026 at 06:19:56PM -0400, Christopher Lusk wrote:
> Landlock documents LANDLOCK_SCOPE_SIGNAL as limiting signal delivery to
> processes in the same or a nested Landlock domain.  A retained PTY master
> can currently use TIOCSIG to deliver SIGINT, SIGQUIT, or SIGTSTP to an
> out-of-domain slave foreground process group because the privileged TTY
> signal path never reaches security_task_kill().
> 
> This RFC asks two questions before proposing a final interface.
> 
> First, should this be classified as SCOPE_SIGNAL under-enforcement, or as
> part of Landlock's documented inherited-TTY limitation?  The "Current
> limitations / IOCTL support" section says that IOCTL_DEV does not affect
> pre-existing descriptors, names TIOCSTI and TIOCLINUX, and recommends
> closing inherited TTY descriptors.  That text discusses the filesystem
> IOCTL_DEV right rather than SCOPE_SIGNAL, and unlike the two named ioctls,
> TIOCSIG is not CAP_SYS_ADMIN-gated.  Commit 4b80320ca7ed fixed the same
> effect-level class for SIGIO rather than treating the retained signal
> source as exempt.
> 
> Second, if this is a bug, should TIOCSIG use the existing task_kill hook as
> patch 1 demonstrates, or should it gain a dedicated TTY-signal hook which
> Landlock can implement without changing other LSM policies?  The prototype
> is atomic with process-group delivery and behaviorally narrow to TIOCSIG,
> but calling task_kill means SELinux, Smack, AppArmor, BPF LSM programs, and
> future implementations also mediate this operation.  The series does not
> claim that cross-LSM policy change is settled.

Thank you for bringing this up; I was not aware of this code path and
researched it a bit.

Let me try to paraphrase the issue to make sure I understand:

1. A process creates a PTY device and acquires the PTY master FD.
2. The process then restricts itself into a signal-scoped Landlock domain.
3. Processes outside of the domain are attached to the terminal
4. Through the PTY master FD, the master process emulates a terminal
   to the attached processes.  One of the commands it can issue is
   TIOCSIG, allowing the PTY master process to send SIGINT ("Ctrl-C"),
   SIGQUIT ("Ctrl-\") or SIGTSTP ("Ctrl-Z") to TTY-attached processes,
   which may live *outside* the Landlock domain.  (source:
   pty_signal() in drivers/tty/pty.c)

TIOCSIG was introduced in 2010 in Linux [1] and in 1989 in BSD (quoted
in the Linux patch).  According to the patch, it is only required in a
special terminal mode where the mapping of signals is disabled.

In more normal operation modes, the terminal interprets these keyboard
shortcuts sent as characters.  This is implemented in
n_tty_receive_char_special() when you write() the characters '\x03'
(Ctrl-C), '\x1c' (Ctrl-\) or '\x1a' (Ctrl-Z) to the PTY master FD.
(Your proposed patch does not fix this either, even though it sends
the same signals.)

Additionally, PTYs can send:

* SIGWINCH (when you do ioctl(TIOCSWINSZ) on the master FD)
* SIGHUP and SIGCONT

[1] https://lore.kernel.org/all/E1OR73h-0004VN-JE@lirone.symas.net/


In summary:

* Sending signals to attached processes is a very normal way how PTYs
  interact with the attached processes, and TIOCSIG is not the only
  cause for it.
* Processes are attached to a PTY because they were started on that
  PTY or they have voluntarily attached to it.

With these two points in mind, I am leaning towards treating access to
the PTY master FD as a "capability" whose acquisition can already be
adequately restricted with existing Landlock controls.  Like
socketpair(), which Landlock also don't restrict, the creation of a
new PTY always returns a new master and client side TTY FD and it
feels to me more effective to control who attaches to these than to
control the TTY-internal communication protocols itself.

Maybe the way to think about this is to say that it is the *TTY
driver* which is sending these signals in response to the PTY master
FD receiving a TIOCSIG or having a Ctrl-C written to it.  This is
similar to a SSH or Telnet daemon which can also trigger signals for
the attached processes on the other end of the terminal by sending the
right commands over the wire, and I also don't see an issue with that,
because in the same way as here, the client programs have voluntarily
attached to the TTY. 🤔

Does that seem reasonable?  I am happy to be corrected if this
analysis is wrong.

If you agree, I think the best path forward might be to document it
more clearly that TTY interactions are not part of the SCOPE_SIGNAL
guarantees.

–Günther

> The demonstrated generic impact is low:
> CVSS:3.1/AV:L/AC:L/PR:L/UI:N/S:C/C:N/I:N/A:L = 3.8.  Scope is changed
> because the effect reaches a process outside the sandbox authority, but
> the primitive is limited to three job-control signals and no independent
> integrity impact has been reproduced.
> 
> Patch 1 is the behaviorally validated proof-of-concept fix.  Patch 2 is a
> minimal regression test; further test polishing should follow the chosen
> interface direction.
> 
> Validation used the same userspace image against the affected and patched
> kernels.  Across three boots per image and 32 iterations per cell:
> 
>   affected: 96/96 cross-domain TIOCSIG deliveries
>   patched:  96/96 cross-domain TIOCSIG denials
>   both:     96/96 unconfined deliveries
>             96/96 same-domain deliveries
>             96/96 scoped direct-kill denials
> 
> The regression test separately fails on the affected image and passes on
> the patched image, with exactly one TAP test executed in each run.
> 
> No external report or patch has been sent before this RFC.  Guidance on
> both classification and hook direction would be appreciated.
> 
> Christopher Lusk (2):
>   tty: mediate TIOCSIG through task_kill LSM hooks
>   selftests/landlock: cover TIOCSIG signal scoping
> 
>  drivers/tty/pty.c                             |   8 +-
>  include/linux/sched/signal.h                  |   1 +
>  kernel/signal.c                               |  30 +++-
>  .../selftests/landlock/scoped_signal_test.c   | 142 ++++++++++++++++++
>  4 files changed, 177 insertions(+), 4 deletions(-)
> 
> -- 
> 2.55.0
