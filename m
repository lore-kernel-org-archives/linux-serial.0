Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A013423E9E;
	Fri, 25 Sep 2026 13:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790341700; cv=none; b=LP+Sr4hpnA38jukqvfPSOh3UG5be2Qng47UKcwYY4I/VAsIYlBn2rWicm6UB19wmsx4AZNmmVKwdPiPuHU1rlEDFmmKH/yBKQaAeNwNtnkLa1rnOx7ljLeSB7WS2E3mC4YtsCuiEk/Q3enF1JAgE+NJWNhnHzzl9HD4VzY0UpoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790341700; c=relaxed/simple;
	bh=OOHQmuyrL25kqkCZqwa8qh0JcuLmeA8y4zINbr00OqQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DzP6LPu12Hp3WfDAzztWPt/xhnKc/4/+bUCpDq7EWkfFTlZZNS3m+0JkIoa3TAfBWGWYt2rNY8DcY0mzbBJ1Y/GHcETwPHyv2qKKJiQgWXPjdR1sNpZE/+SEsfKfWQzjvIgdwie0oqGSYcmBqhBxi/hj6a/vWB/mhi3vR83Vsc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sfqUjwlf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eortJuak; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sfqUjwlf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eortJuak"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1790341696;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Rq8dz6RxaneKO4tjFDWwQjCHeL3xL6UCFoY4Jf8dOSM=;
	b=sfqUjwlfUJX86woRUBAgZoqxPry0KcfURizFvLLSNRYT2azcKQR0Xyp69AooW6h8ABcd/0
	LTXWSibbFpPyOltKfUXVnrlwzLvdhXEWSOgDB+jk64driOiMDrxKvJTgayakC8ys2XYj0S
	GfMHJG94hRqnRPjTOxCINejAMSSTjDw4FFv3Z1Un8P/O2dYONaI8zuASEoAHBAgskOH9fs
	FGRLnOpjbd7ZnzVCNXHreYhhHBdfDL50M+NUHD/BuPYEZeiHey37spS0dIatTFqUeGT0wg
	8vBMueAPkaR4qmXUGfyLa8UQpm9r2cuE+Y8Rd4tlxrt0eF+u7cm008DUl0dcPA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1790341696;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Rq8dz6RxaneKO4tjFDWwQjCHeL3xL6UCFoY4Jf8dOSM=;
	b=eortJuakmNBtIDdy4AVTgMl7go5uBY9Q7Dut1Snt+twqGLFzL191I/zIjfxGrIVulEMItb
	NWBjd/zl8j2qFnAQ==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, Steven Rostedt
 <rostedt@goodmis.org>, Marcos Paulo de Souza <mpdesouza@suse.com>, Samuel
 Thibault <samuel.thibault@ens-lyon.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, Ilpo
 =?utf-8?Q?J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, Hugo Villeneuve
 <hvilleneuve@dimonoff.com>, Fushuai Wang <wangfushuai@baidu.com>, Kees
 Cook <kees@kernel.org>, Stepan Ionichev <sozdayvek@gmail.com>,
 linux-serial@vger.kernel.org, Manuel Lauss <manuel.lauss@gmail.com>,
 linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH 0/2] braille: nbcon: Allow using a serial driver
 converted to nbcon API as a Braille console
In-Reply-To: <20260922072558.98854-1-pmladek@suse.com>
References: <20260922072558.98854-1-pmladek@suse.com>
Date: Fri, 25 Sep 2026 15:14:16 +0206
Message-ID: <87ik3tiim7.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2026-09-22, Petr Mladek <pmladek@suse.com> wrote:
> I have been working on v5 [1] of the patchset cleaning console registration
> code and I found that the system did not boot when I selected a Braille
> on the command line, for example:
>
>      console=brl,ttyS0,115200 console=tty0
>
> Bisection went down to the commit d3539347022a ("serial: 8250: Switch to
> nbcon console, take 2"). I found that the Braille console driver called
> braille_co->write() internally where braille_co pointed to the uart
> 8250 driver.

The Braille console blindly calling (struct console).write() is
obviously bad. This needs to be fixed. And not just because of the
8250. Other NBCON drivers already exist mainline and have this same
issue.

> I added the support for the nbcon console API similar way as we did
> for kdb [2].

kdb does not need to care about latencies. The Braille consoles do. I
will comment more on this in the related patch.

> Note 1: I believe that we have a bug in the kdb patch because we call
>         con->write() atomic callback after entering the unsafe mode.
>         But we should do so in the default "safe" mode.

Why do you believe this? kdb operates within an unsafe section so that
other CPUs cannot take ownership. (BTW: For kdb the other CPUs are
supposed to be quiesced, so there should not be any ownership attempts
anyway. The unsafe section is just an extra precaution.)

> Note 2: I am not completely sure about the locking. It might be better
>         to use NBCON_PRIO_PANIC in panic().

Why does it matter? printk() is not trying to do any Braille printing
during panic, so it will not attempt to acquire the Braille console.

>       Also I thought about using con->write_thread(). But I think
> 	that we have to use the atomic variant because the Braille
> 	console can be called from printk() via the VT code, aka
> 	graphical console.

How can it be called from printk()? Even printk() writing to VT is only
if it is registered as a console. Braille consoles are not registered.
Please explain.

Note that ->write_thread() is the only NBCON callback guaranteed to
exist.

John
