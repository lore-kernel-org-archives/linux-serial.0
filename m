Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922312D46C0;
	Wed, 18 Feb 2026 00:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771375912; cv=none; b=WhyATi2m6dQR0LYHmiZsZuazLdXf7fSZMrjqTdITN2aBKGHnBU5oMxkHosDqNYGLZptJ2a5o9k0QQniWCqPh+AeYRgIKI78Zxlvy/pPodj6rIFUTxK8KPGeqE8QvYr25BvJyEXYOZ7psw4/z3ZvXPR8rN/3bKpzNhb15uEfLSps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771375912; c=relaxed/simple;
	bh=AmVKqftKxu5uvL9ClowvVPiZNCpMA6/iCt9WE0nw7+o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SqAmhxaKqUUthSlfpGSTeMQXXb1vjiIlFdrscEDVIwx/NBIcfJGTcEYazMdAtLSPUPLrvyqGjfQpB2V3STrB6uPmHGB48r2YWcb4NfZ12GAoO1tiloiWBBeJScNb31c9nYoiHS//HfyM+dFE4+Zve6G4K+Xar32qRkFrKk8jJJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vvocbs58; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PZrxNVmW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vvocbs58";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PZrxNVmW"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1771375907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AmVKqftKxu5uvL9ClowvVPiZNCpMA6/iCt9WE0nw7+o=;
	b=vvocbs58yRwdU+eHXt8COU+Uz9n5mw5Z2kzCyfcel5zOhsn/p+co3fdssNMOkmpsK6uajc
	s3TclyMSkmhKl4J2QVQWeyBFcUxQnisI3wRyd9pUzLjb/2SXkbN0V+j7/z35PFmTTb9gVc
	fECZ2Ts2dHIaGhqheFeAzHYFQrHjIA69cDfrq+VKqlKJJP7gd27jAZsbq5Pg9TYg1vQE0E
	HWbg4yL5NudpZ8GQRoSQb8Or2IXQ+V7uLMPMWnjLTY24Pl5bj4GGxlX181YzpKsEV91S87
	0IRpwMaiDduC8CKqs2caz6NzZteIhxw+mukkQuT8OxTbG0h8BBkbv0yr5uvubQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1771375907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AmVKqftKxu5uvL9ClowvVPiZNCpMA6/iCt9WE0nw7+o=;
	b=PZrxNVmWwEg4oRZ3VvFtTRVuPJnmw2UNm6iATr9iYt/9rM3KDBSEr16ein9llCIJmg+2Wz
	VjlpSIQKbFWGO6Cg==
To: Petr Mladek <pmladek@suse.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, Nicolas Pitre <npitre@baylibre.com>, Calixte
 Pernot <calixte.pernot@grenoble-inp.org>, Steven Rostedt
 <rostedt@goodmis.org>, John Ogness <john.ogness@linutronix.de>, Sergey
 Senozhatsky <senozhatsky@chromium.org>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>,
 linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
Subject: Re: printk, vt: sleep from invalid context bug
In-Reply-To: <aZQs0WYk262ZNybc@pathway.suse.cz>
References: <87v7fwdsln.fsf@yellow.woof> <aZQs0WYk262ZNybc@pathway.suse.cz>
Date: Wed, 18 Feb 2026 07:51:35 +0700
Message-ID: <877bsaeuw8.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Petr Mladek <pmladek@suse.com> writes:
> Sebastian has recently sent a patch which should remove the
> cond_resched(), see
> https://lore.kernel.org/all/20260126180836.SNCdMW2f@linutronix.de
>
> It seems that the patch has made it upstream in this merge window
> for 7.0, see the commit 8e9bf8b9e8c0 ("printk, vt, fbcon: Remove
> console_conditional_schedule()").

Pulled and the problem goes away. Thanks Sebastian.

Nam
