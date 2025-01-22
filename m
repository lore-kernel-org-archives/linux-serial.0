Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1191CEE8D
	for <linux-serial@vger.kernel.org>; Wed, 22 Jan 2025 08:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737535264; cv=none; b=VZ+NYrj6q+EMpI59D05XsduVFdiF4kO5APsowOBSSj5NKmzPmc/P10W9uNePXcKSbY8/9lJ8a7J46d5/fZzQYLcRvDYOJWNZL1E+cqphiNfUxZp3moNV2h8W6VDfYCy4xsCn6DA56PDVspxWGyJRkThVQXz9P2tudETTMfDLGqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737535264; c=relaxed/simple;
	bh=DxqxFlNjSqfO5D3qxHjXOZzU140FT5LBpu/PJ/tNN4M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=btl2xsFJ7ggIpOlImGMus7SFRYSaJ1yjZMA4qVR3t97M4Q4/N0liLJtdPV6fcfcM900EtLoVs0M8smKFoIcxeVqKn3wMa3iqQtheyFD6dREejlS4KcHWZy2WIHm0dZaiQRs/wlYah8FFpYy3IROso0YM92k/IBsIKE18v4f9Mgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sABIb/bA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3ELhmLar; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sABIb/bA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3ELhmLar"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1737535261;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DxqxFlNjSqfO5D3qxHjXOZzU140FT5LBpu/PJ/tNN4M=;
	b=sABIb/bAMZM+i8kQPcO0BAml/yB9djMxLu8JKyg4gc9eqOexqFWwZUKBRWUcNGEvIN+QNF
	PWDL45uYcOju8rEHy1C6AGF1/8VFXSJszXuulkwG6UV05D/wua/1Gluda2BtBFSUbv/P+D
	nEqmmM0gOaweHKILdiNa01n6g3nyxjbRclsCdO/ICtS6iI3DbJkwJr/fueM920fqj0rIUJ
	tRqLqdPisy/NdYnuoLR7mTB6mO9tCjKYLNUwWN0tYUAM2o6l1j9HD/w2v5/xQMj7EEz6+d
	EJMqpl1YogJMkuwqHJKVKVe4ZqrajKLc0alAGpElA1uK6YG8V85jtkI8lqtFrw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1737535261;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DxqxFlNjSqfO5D3qxHjXOZzU140FT5LBpu/PJ/tNN4M=;
	b=3ELhmLar8AFEM/wUxCXrFZIffq8RdHuMdWF6lprmhFAwF1RkqsAdThX7RPr2OGhqgYwLvI
	tkkXWT9+W2d6ChBQ==
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Petr Mladek <pmladek@suse.com>,
 linux-serial@vger.kernel.org, oliver.sang@intel.com
Subject: Re: [linux-next:master] [serial]  b63e6f60ea:
 BUG:soft_lockup-CPU##stuck_for#s![modprobe:#]
In-Reply-To: <202501221029.fb0d574d-lkp@intel.com>
References: <202501221029.fb0d574d-lkp@intel.com>
Date: Wed, 22 Jan 2025 09:47:00 +0106
Message-ID: <84wmenqm03.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Greg,

On 2025-01-22, kernel test robot <oliver.sang@intel.com> wrote:
> kernel test robot noticed "BUG:soft_lockup-CPU##stuck_for#s![modprobe:#]" on:
>
> commit: b63e6f60eab45b16a1bf734fef9035a4c4187cd5 ("serial: 8250: Switch to nbcon console")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

It looks like we need to revert this commit (and the one after it) until
I can find out what is going on here.

From linux-next they are:

b63e6f60eab4 serial: 8250: Switch to nbcon console

422c9727b07f serial: 8250: Revert "drop lockdep annotation from serial8250_clear_IER()"

I hope to get this solved soon, but I am currently taking part in a Rust
training, which does not leave me many extra brain cycles at the moment.

John Ogness
