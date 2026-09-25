Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B9C3ABD9F;
	Fri, 25 Sep 2026 19:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790363145; cv=none; b=N1hOOqb74uzQ4O2TX6KdjB28jmc0OZkV93ZVl1W/iav1MH+otkCqhJUeKyOFJWNb9jk3UtxSkTp3OScZbRzsKvrfldAXevICYkkSM3uQRnOq7SNEfvjWsX2hulfFlYMSWTr8tflF5SsgthHQHnY9EcuFNFxAsEar8+DQlG3u3go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790363145; c=relaxed/simple;
	bh=elI3ndbbhBmvASENdTlkY+6JNvUJYZefSPOf7MVUxGU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZMKE94wkI89UWCpXW4j7iapROhGUxEPZo4OFxWzzqFQIU4uUUElTtuzy2tO5zhGdSn2alPjbY/svF7l7ZL9Pieu6G18+fNTJ9Zz+7HMhF4c+ChFbwaMoVQxO6v6IPv1maEpxzh4blSb5QZbR8ryBo5DRe93gzpA4RfHxcE/DLEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LLNi/p8V; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=urVUsIHD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LLNi/p8V";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="urVUsIHD"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1790363142;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lBxMnJ+dOew+Q/sTY5BE4f8DMTfXtPkBbGx83N82kOE=;
	b=LLNi/p8VmXKZOXhheB6RGP6zQiVRasPvxp+PEghhdLHwpjDpBcsy3/iB87SXE7m6/UZ7/f
	rMXjARjkfGGys6XB+kdyJnGK/BSVCTWEGPBCw3P57WZhmO3ENgmqNSOh66gwi++MvVke8Q
	A/ox/VDj01Sq7sQhlbpGA8BS3nm3r9CIzDRaeOvL7xHXtqH6o/yfUF5nz2zH9nFBCDZgST
	Gk+oYMxgHcHfdEG9V6RvD6Fsh4eMiP/RQCC0wWKeGRBbJDSJqCJ/amrNkK5BTH/HkrQp+U
	y+DjQe8EOyvOvYV1VLBKnauPX9e109KtdLQk+E0VxJAS/m3+DGAK+fa7TDx8OQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1790363142;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lBxMnJ+dOew+Q/sTY5BE4f8DMTfXtPkBbGx83N82kOE=;
	b=urVUsIHDkdrTbGZnIQ+79YCQ5HwEHVdL+/AmPPOjcPn1allodZw1bwEBneVi09nOqZyT8A
	RtvBhgDS+hkuqECA==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, Steven Rostedt
 <rostedt@goodmis.org>, Marcos Paulo de Souza <mpdesouza@suse.com>, Samuel
 Thibault <samuel.thibault@ens-lyon.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, Ilpo
 =?utf-8?Q?J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, Hugo Villeneuve
 <hvilleneuve@dimonoff.com>, Fushuai Wang <wangfushuai@baidu.com>, Kees
 Cook <kees@kernel.org>, Stepan Ionichev <sozdayvek@gmail.com>,
 linux-serial@vger.kernel.org, Manuel Lauss <manuel.lauss@gmail.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] braille: nbcon: Allow using a serial driver
 converted to nbcon API as a Braille console
In-Reply-To: <araWJhKdVZnfCQcg@pathway.suse.cz>
References: <20260922072558.98854-1-pmladek@suse.com>
 <87ik3tiim7.fsf@jogness.linutronix.de> <araAvkIB5XatHPNk@pathway.suse.cz>
 <87a4p5iejg.fsf@jogness.linutronix.de> <araJ-EBntyqOGPkT@pathway.suse.cz>
 <877bk9id6f.fsf@jogness.linutronix.de> <araWJhKdVZnfCQcg@pathway.suse.cz>
Date: Fri, 25 Sep 2026 21:11:41 +0206
Message-ID: <87ld8pp2wq.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2026-09-25, Petr Mladek <pmladek@suse.com> wrote:
> I used on the command line:
>
> 	console=brl,ttyS0,115200 console=tty0
>
> The serial console driver is not in console_list. But it shows
> all printk() messages because tty0 is in console_list and
> the messages are shown there.

Got it. So from the perspective of printk() we have a legacy
console. The legacy console is (mis)using the write callback of a
console driver to write to the underlying device. And since the driver
for the underlying device is NBCON, these contexts do not match. But
actually it is more complicated than that, because the console driver
callback is being used for all vt updates, not just those from printk().

Since the 8250 driver (and so far all NBCON UART drivers) use the port
lock for the ->device_lock() callback, it would be enough to do:

	con->device_lock();
	con->write_thread();
	con->device_unlock();

if it is NBCON. That would at least provide proper locking (port lock)
for the underlying device during runtime. The only downside is that
panic could deadlock if the panic occurred while a CPU is holding the
port lock.

John
