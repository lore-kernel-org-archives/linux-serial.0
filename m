Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE721E0DFE
	for <linux-serial@vger.kernel.org>; Wed, 18 Jun 2025 04:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750221745; cv=none; b=YezJeLUSLIjtGa8WLwSWwl6sU2aQIyetW0vqz4pI6pcEEfNXca7q+Zco9OAPLzcDpReWkeOFf9Cs5S0Q4g91E1Xk/3gEKAoIVPuNNTK8Mw5hyIySmdCWov+8pG5pFZrcQjHQ1uJdN7OCK7lBvgjCWcI4flEma2T2b2UdSzdgC2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750221745; c=relaxed/simple;
	bh=/V+tYyEXAT2YSm154FNcH3MZXFw1XT+XX5Gv6Ey5gNY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WqiDzehoOk36Ts5m1kR9EH4YjkxmOaYS2BHFJsQGnV+iC9XI4Wb0kfSCrbm7gEvRfXKrd3EtsC/CW4urfHdWa7Dh5VF8syoOuDh82cAnyzlBe4ynaQt0MG71akewWydP31jz+EiIKjZDVS1M3tmDxd1g6AODAdKVsaljfXjpj+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=O/pli8+6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jHhLwp2N; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="O/pli8+6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jHhLwp2N"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750221741;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gCkN1UaeGSgMvS52kXxBzHCLhstjH4vMb9KGD7dp2JI=;
	b=O/pli8+6rQ+r/rk73LpotBMFbSHNDFZsSjceRn0jgkRBPdOBRAeoTIkH0sdPP4xJ0Ih6dZ
	uzv4mbBYJ/o1FLK0zQeqB1U52Z6zy1hWsOA3CT0YZ5NUb6+TaFUU3tO/OHTxdXLDT96Tr7
	hiXWJMO5Sap8IsQXrzx+9Oz0ZxWhzdg84QCq+69wjqpl0OMQ5usAff9r4ZHfLP5sshf/6s
	9C/mfrvOvGHGdl0gVqNO/ZHuSp8+JE17GCOuMTvCMrvwtinAb3gJbZnmIX/e3YOoSQ4qD0
	mehivAHz6YEUOjVLjHVbDZe69iYYJNGDPbX1mkyZqhYRZk/qJ6pPPBg7AJdURQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750221741;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gCkN1UaeGSgMvS52kXxBzHCLhstjH4vMb9KGD7dp2JI=;
	b=jHhLwp2NkczZH3wlj0H29ddiTa5duZeCqb2xrC8Wf1hfLyL/BfTNwE6N8ZLMm6QjoT21SK
	+BuCRz6s6c70FuAA==
To: Florian Bezdeka <florian.bezdeka@siemens.com>, Ryo Takakura
 <ryotkkr98@gmail.com>, pmladek@suse.com
Cc: Jason@zx2c4.com, gregkh@linuxfoundation.org,
 linux-serial@vger.kernel.org, lkp@intel.com, oe-lkp@lists.linux.dev,
 oliver.sang@intel.com, Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [linux-next:master] [serial]  b63e6f60ea:
 BUG:soft_lockup-CPU##stuck_for#s![modprobe:#]
In-Reply-To: <030bfa50783bc9f40ce3afd4e1f65da2a48322c1.camel@siemens.com>
References: <84y0vhodwy.fsf@jogness.linutronix.de>
 <20250501041055.6504-1-ryotkkr98@gmail.com>
 <030bfa50783bc9f40ce3afd4e1f65da2a48322c1.camel@siemens.com>
Date: Wed, 18 Jun 2025 06:48:20 +0206
Message-ID: <84cyb1vexf.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Florian,

On 2025-06-16, Florian Bezdeka <florian.bezdeka@siemens.com> wrote:
> With that it has been confirmed that the original test report [1] was
> wrong. It reported the trigger, not the root cause.
>
> b63e6f60eab4 ("serial: 8250: Switch to nbcon console")
>
> was / is correct but got reverted by Greg in mainline with 
>
> f79b163c4231 ("Revert "serial: 8250: Switch to nbcon console"")
>
> This leads to the situation that stable-rt branches still ship this
> patch while mainline and stable do not. John, is that intended or was
> mainline / stable never informed about that?

stable-rt carries the 8250-nbcon patches because we intend for them to
go mainline. Greg reverted them from mainline at my request because of 2
power management regression reports (related to suspending on arm32). I
do not believe 8250-nbcon is the real problem, but I need to determine
the root issue and offer a solution before sending the 8250-nbcon
patches to mainline again.

Regardless, the fix in this thread is still relevant for mainline now
because there are now other nbcon serial drivers mainline.

John
