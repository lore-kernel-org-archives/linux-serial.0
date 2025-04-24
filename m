Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAC87081C
	for <linux-serial@vger.kernel.org>; Thu, 24 Apr 2025 09:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745485227; cv=none; b=ADmDlBpDHNv1KUhwGOs2jn+28S7eWuQXfbFxsoZS7HOVxE4SLV79EyT0PvOMW589rnIW/BYHkuh26TeSkFlaCDh4Gh6GgNEVlmUIVETvfMeJ+aFULoiKh3HVveZk5o6tY4jDyymUZApVXz6ysWcaKn78w8m75vQTCLbtNU8l3cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745485227; c=relaxed/simple;
	bh=Wj0uOJNzwu4ai9LJgzhUJL/ZlzvJD6Urk8u0o7dP6ec=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oOnhH8m/aSq4chksziumNEiHBdK7aZv3nbq7TFZEeDJGVDr5kcqlJ+C0x/tt81F/XQIGXlsHtowoXnzIS3KfFjFeM0VlEkfGdFvSXcda+N8tYZYD14VLylC4glvuMcQfTcBOrwHzMoF7qfabyEeDBNGzmvD27b/ndGDWs04okJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0uJinCCj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FgQckNtS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0uJinCCj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FgQckNtS"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1745485224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Wj0uOJNzwu4ai9LJgzhUJL/ZlzvJD6Urk8u0o7dP6ec=;
	b=0uJinCCjLcql9hPOVZ1SX6i1XomN2HRlOVTbN3u7VHmpGlvCZudBdGBiO+XAuIJU4OcszQ
	l6VuClosH+0CvuSqeH36AFbbRuMoovJuS9Ys+rJWe7djZydwvS8h8aZ2pi0ZaN5CxARonp
	hX1ZI94XdqcU5isGmYl/XjFGgNtA8fRjDW3V3mVByLzeDxpai+a1boImNMV4bMcSOXoXfW
	hYH5QLNKVs+8tFsR+R1d3CHPcKob17Dr753tLFPCrK3RjmjgaNt87M6vmKgzDareC7sh7Q
	uVm/vuaTT/vfnqoItBjMyTuIAeS5xl7fVR95uXAntO98rIjZfqSR5Id9oBHKsQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1745485224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Wj0uOJNzwu4ai9LJgzhUJL/ZlzvJD6Urk8u0o7dP6ec=;
	b=FgQckNtS8DNn7lr2CBj3tsQEZcmUSWre188sr8m+OUxY4wzDDkx9gmZU37drfvFP4fvBUh
	+h9AZHjxkEEQ9gBA==
To: Ryo Takakura <ryotkkr98@gmail.com>, pmladek@suse.com
Cc: Jason@zx2c4.com, gregkh@linuxfoundation.org,
 linux-serial@vger.kernel.org, lkp@intel.com, oe-lkp@lists.linux.dev,
 oliver.sang@intel.com, ryotkkr98@gmail.com
Subject: Re: [linux-next:master] [serial]  b63e6f60ea:
 BUG:soft_lockup-CPU##stuck_for#s![modprobe:#]
In-Reply-To: <20250424081101.110914-1-ryotkkr98@gmail.com>
References: <aAeIRZH_VD0mai0V@pathway.suse.cz>
 <20250424081101.110914-1-ryotkkr98@gmail.com>
Date: Thu, 24 Apr 2025 11:06:23 +0206
Message-ID: <84r01i0w9k.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-04-24, Ryo Takakura <ryotkkr98@gmail.com> wrote:
>> By other words, the rslib test should get fixed by adding
>> cond_resched(). And the conversion of the 8250 serial console
>> driver to nbcon is correct.
>
> I see, and agree! I'll test what's discussed here so that we can say
> the above statement is true and the John's series can be brought back.

I'm looking forward to seeing your test results. Note there is also 2
more issues blocking the series:

https://lore.kernel.org/linux-serial/80b020fc-c18a-4da4-b222-16da1cab2f4c@nvidia.com/

and an offlist report from NXP relating to not being able to suspend on
ARMv8 due to printk irq work IPIs.

John
