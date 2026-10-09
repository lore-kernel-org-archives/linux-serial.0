Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FA74E0B6F;
	Fri,  9 Oct 2026 13:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791552517; cv=none; b=tot9OCbxl23R2OvqzIKlYHB4vuQCkMD2ioV96JoW/2fXc1zFg1pv8qK/TqsRtjzSV5nt6T+03CBI7JL0vk4/AmaoqQFFMXUM/9O0agU0z5g9dKFsNaSnsYDksPBz9M/PfPxsIqb8v1YEpXO0zh+Xm6NOZzrn76IgdhV17ceZvyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791552517; c=relaxed/simple;
	bh=y630XFwaVq8fqyb4CaFWQ5+Z6Dk7Xz9k+6pLUlhvk7Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uLq4wmzYmMLT1CORgikisutQD+qDU+Ar7c0T9H4eeM3EH85A72Gc67O/IPw/Zp/grdPt6eCfy8GWYG2YFKS9J6NaX/0xElCl6WqZ2ufd9xbZ/5+P7UTPXDvMxWjjjGYezguLVkFoyVFWXp21akA3LrsKTlWhyKcRnhg6gBSUgoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AfWrqWv/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aQ/pDhQi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AfWrqWv/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aQ/pDhQi"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1791552510;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y630XFwaVq8fqyb4CaFWQ5+Z6Dk7Xz9k+6pLUlhvk7Y=;
	b=AfWrqWv/kn1V+yxFZkeyw+4kzga2Jzjxiu9Eb7MeWcC8SZ2EY+mtXAylyNebAksZZJMD/y
	udP4Ox/j5HME0NrDCc5TJw8M9q/SgeEUvC4XDF+SZvUDHPuc/ry66fdRqlOJ/+j50gAgdp
	+d04cuAQv9uWhQTs8Asc6v6T+IfcN/ffj11vLEf+UrFJRZg4GDcDdLTbe77tqmfgBo4SZz
	URrf3nrGDuevnmpAW/eLdL+zrhOj6TlkJzd4TrCiX2t3ELOqigLeJudDTx9dFtNL/O0f9y
	CQT+QY65CUiL40AoA3VqlMvNlLPjODgYKST2xtEXeUBUlGFTpH4b6OQbhQwS7g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1791552510;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y630XFwaVq8fqyb4CaFWQ5+Z6Dk7Xz9k+6pLUlhvk7Y=;
	b=aQ/pDhQibbn93TFWmghqfNViH1ueOCkPYWijtlSSg+8AAYxVPmFzK1kGzB5DqKzH2BwJfN
	HWB5FsBgsXM1arAw==
To: Petr Mladek <pmladek@suse.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, Steven Rostedt
 <rostedt@goodmis.org>, Pavel Tikhomirov <ptikhomirov@virtuozzo.com>, Oleg
 Nesterov <oleg@redhat.com>, Christian Brauner <brauner@kernel.org>,
 oe-lkp@lists.linux.dev, lkp@intel.com, linux-serial@vger.kernel.org,
 oliver.sang@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nbcon/reboot: Flush nbcon consoles synchronously on reboot
In-Reply-To: <asiu8orjDvRJMKuX@pathway.suse.cz>
References: <20261008150852.8286-1-pmladek@suse.com>
 <20261009065152.udyfFRHx@linutronix.de> <asiu8orjDvRJMKuX@pathway.suse.cz>
Date: Fri, 09 Oct 2026 15:34:30 +0206
Message-ID: <87qzhzxatd.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2026-10-09, Petr Mladek <pmladek@suse.com> wrote:
> Anyway, IMHO, we should switch to NBCON_PRIO_EMERGENCY for the post-running
> states and flush the pending messages immediately. It is more
> reliable. It is easy to find the locations when system_state() is set.
> And all follow-up printk() calls will try the direct flush so that
> they won't rely on an explicit flush.

We need to be careful about abusing CPU state in order to get certain
functionality. We already have things in place to gracefully switch to
atomic after shutting down the printing kthreads.

I will not have a chance to seriously look at this until I get back next
week. But at a quick glance, it looks like a roll of duct tape.

John
