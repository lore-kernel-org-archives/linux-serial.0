Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5F237BE9F;
	Thu,  7 May 2026 08:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778143619; cv=none; b=EllQLvEAts5AIhk16h95kiaiqH0DZqcUpcyB3JfqIIJM7Z8ed9kGgvUnfFQpG5/2yfvFuGwXdTfmTRb24lOroVHYcN2pLjGY2Yc/cjs1fvQRy355UM+QcT6e3Ba3hJWKczhvfDrthQQ/IRv0kgz/RgubGaWI+rFwiSLvPlRbrtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778143619; c=relaxed/simple;
	bh=q943uWD9uQdKiWHonP9cE498oVof4h6v+PdwSWtsKBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GygX2eKpcYpfeAj5UQJeEoEyxkghrV3esj7wGnXkF8fT8SFAuDOZD1DPO4rEaohQ9HQXly/AHBAQ+U1VIkQlJiAILymou5XclnAiKcq+JcmgLxlK9w2MQoNRD6BBDXK/0R8Nybg3Nnsf8qiVrF9neiiAgnpn1FXf0+gGRSWbhJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4hraY3Ym; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OMPnmoXo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4hraY3Ym";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OMPnmoXo"
Date: Thu, 7 May 2026 10:46:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1778143606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q943uWD9uQdKiWHonP9cE498oVof4h6v+PdwSWtsKBI=;
	b=4hraY3YmfGJcmmP6PPSUCViMGQyIqWoTQEsD2cVGzSQ/hZ4tNGy5QmNitlFr9s+ZPa9d1T
	OmsL+LAbBgWVw1eanWqAILxK9mRwZ29UYI6Ipi8WSTIwfbkKEmLsxqOoxlFL3VT2eWle9u
	q/p1Subk3DdwOEMi0XyeLetFMOXWS9pJs8sAbHBdeaG7wkZe/gJKF5axK9LfLz4MrnxvdU
	zAA9sry/cKpXOUszWfkvOJT/bMYCQGP5fTGCPVd7/7mQo7+ol4isy2lxDlkQTvgb3P1+v2
	WSYDHnBlEyNSa1UDaVDM1A0mGBCyOvPkN7Rc40yGjBkBBjxfco39ja/cS2i96Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1778143606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q943uWD9uQdKiWHonP9cE498oVof4h6v+PdwSWtsKBI=;
	b=OMPnmoXof2uijDCZiWcJlJTo3x94l6ORon5JJVe5rgyFvp5kQKPCq+/F0j22HMj7tP3+z7
	gtzFy64vCbFlT3DA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Qingfang Deng <qingfang.deng@linux.dev>
Cc: Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Jiri Kosina <jikos@kernel.org>,
	David Sterba <dsterba@suse.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Chas Williams <3chas3@gmail.com>,
	Simon Horman <horms@kernel.org>,
	James Chapman <jchapman@katalix.com>, Kees Cook <kees@kernel.org>,
	Taegu Ha <hataegu0826@gmail.com>,
	Guillaume Nault <gnault@redhat.com>,
	Eric Woudstra <ericwouds@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
	Dawid Osuchowski <dawid.osuchowski@linux.intel.com>,
	Breno Leitao <leitao@debian.org>, linux-ppp@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-atm-general@lists.sourceforge.net
Subject: Re: [PATCH net-next 2/3] ppp: unify two channel structs
Message-ID: <20260507084645.mpK7rdPn@linutronix.de>
References: <20260430090532.244758-1-qingfang.deng@linux.dev>
 <20260430090532.244758-2-qingfang.deng@linux.dev>
 <590d7931-02b0-45d6-8f43-ef909c9bde89@redhat.com>
 <c9993ee6-4023-4331-a1c1-4e30952146fe@linux.dev>
 <20260507074051.mqO5DaWL@linutronix.de>
 <a4216fa5-9576-4836-b202-d9c35f0e546a@linux.dev>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a4216fa5-9576-4836-b202-d9c35f0e546a@linux.dev>

On 2026-05-07 16:33:36 [+0800], Qingfang Deng wrote:
> On 2026/5/7 15:40, Sebastian Andrzej Siewior wrote:
> > On 2026-05-07 13:53:30 [+0800], Qingfang Deng wrote:
> > > > This patch is IMHO a bit too big and should be split. Also this kind of
> > > > refactor looks very invasive and potentially regression prone. I think
> > > > it should include a signficant self-test coverage increase.
> > > This is indeed too big. But how do I split it without breaking the build?
> > The current ppp tests would yell if you accidentally broke something?
> By "breaking the build" I meant compile-time errors (due to API changes).

If this change would flip the logic somewhere and as such break ppp at
runtime.
Would the existing test suite be able to catch it?

Sebastian
