Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB2C55C0F
	for <linux-serial@vger.kernel.org>; Wed, 14 Feb 2024 13:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707919124; cv=none; b=MCwe25lL1IAwl4CZ4Rh/gcHzSLeXOWPBWjAkXfXZl/F2g2J1cX4QsgDY2gEt0kYnC9d0A1VcuV2Id8mqzezHsBE3O3Cg778a73lAsH+gGWIzMFbBbpxY8KzaAGcw/QbNWAfbLHcweLM5uCxuQSNWYeHiUZ9eMTNkcV3QEQxd8Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707919124; c=relaxed/simple;
	bh=4Pe3vIExJ+Y/9rR3njvA6HmgozyDPDe8r2isi4PolHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l5k2rQOvrnqv2+nExvl7jBPV+E9mUaLpSsWGjQ71cB7MJHgyuywD3oWd2NxyTeyJ1KcirztGxHTCOz/MwkrCz3t9FMBMQuSAzIEFLZVgrYMzHg9/lJHqNFs5lhG7gX1dbn3ue171RfpYWn/W+4H+hd9d6C87DRmMVDu/y1novHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Nw+6JRlp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YTGhmh0l; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Nw+6JRlp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YTGhmh0l"
Date: Wed, 14 Feb 2024 14:58:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707919121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dIh2qhbjv3JqO52zURCag5iB3IvkUymbfocfibrq3fY=;
	b=Nw+6JRlpE3lQzGQ1ve5p7fgMU4zcFf+gaqxrzraL8uV3i0ocicttV6HoMsRUjgWU4bgEpM
	5RLm/VE7uNEROKyLpPBjhq6BKDJ+FQpxYtns8YkvuajeO6wAxFKXKAsU2OMM7FklaK98Xw
	AY1rRv9mHNhoY8WTXd+M/6ZFySSoDodz1Zuid4WmmNu3a2J3P+G0vwwogWOD2KcGPCDW6L
	qP4XJf7aDv6BjsChfBZ/rn6ZFzTYpblFadUP8mln94/gP4BCJBIL6tmdkttat7OpE+hxhA
	shgfsscdLJUDhuFmx3YJLr7XgYlykVZAvaQCANF4eFqWkex0wTU2xouImRy+wg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707919121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dIh2qhbjv3JqO52zURCag5iB3IvkUymbfocfibrq3fY=;
	b=YTGhmh0lGpnGF7yjPwvvxTo7uf+CjAVn7jLqBlLeuDeqJXOWcqdusoaJTeJ+6zk8InTSXd
	n3Ghm3gBKT4a1vBg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: kernel test robot <oliver.sang@intel.com>
Cc: John Ogness <john.ogness@linutronix.de>, oe-lkp@lists.linux.dev,
	lkp@intel.com, linux-serial@vger.kernel.org
Subject: Re: [rt-devel:linux-6.8.y-rt] [serial]  0a81ac5ba5:
 Kernel_panic-not_syncing:No_working_init_found
Message-ID: <20240214135839.2Dr1E3JM@linutronix.de>
References: <202402052207.a61afe51-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <202402052207.a61afe51-lkp@intel.com>

On 2024-02-05 22:23:16 [+0800], kernel test robot wrote:
> kernel test robot noticed "Kernel_panic-not_syncing:No_working_init_found=
" on:
=E2=80=A6
> ---------------- ---------------------------
>        fail:runs  %reproduction    fail:runs
>            |             |             |
>            :20          75%          15:20    dmesg.Kernel_panic-not_sync=
ing:No_working_init_found
>            :20          75%          15:20    dmesg.boot_failures
=E2=80=A6
> [  217.931991][    T1] Kernel panic - not syncing: No working init found.=
  Try passing init=3D option to kernel. See Linux Documentation/admin-guide=
/init.rst for guidance.

Before that, there is:
| [  201.601164][  T219] request_module: modprobe binfmt-464c cannot be pro=
cessed, kmod busy with 50 threads for more than 5 seconds now
| [  201.790029][    T1] Failed to execute /init (error -8)
| [  217.930082][    T1] Starting init: /bin/sh exists but couldn't execute=
 it (error -8)

I *think* there is some kind of memory corruption and the init-ELF file
isn't recognized. I don't think this related to printk.
Did you see similar reports to this one? This is -rc1 based. I'm going
to release rc4 based something today with printk mostly unchanged. Will
be interesting to see if this comes back or not.

Sebastian
