Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4200202C26;
	Tue,  4 Mar 2025 08:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741078424; cv=none; b=iC7d9dXEN1c1Nw87qHZowIJqwQEhe1gtbv5dXQb+uDYtpaYqQxuIbo5SK3VN9RReWsNUYZgs9BquOxPyFH8hs7yvNuAPhA7nAYOHMKMGgpK8RiQmTfOqzzvPtpubJFo0ba1Yxq8E4S5buGtJ4D53WwjDmMQty6QU1V7axaRonpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741078424; c=relaxed/simple;
	bh=zx08JlhKjrFwsrf/XDyp6dzWEcCyaloMaRtsrUaoJsA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kunqcCXyOwk5d5HnsWLvyx1CHJl+ihdYRkx2ofytB6iZVhI6EVjKiLBdLmKYtCdd+cKqGUrCq+oz9TDj8shxv4sK2K7MqYrTAiOiQRdH6/CjXRDfx0r1YrAtZMvqreJyEPAN8At3VrMYPbXENzaPjBTj9OkaVoVP49OiXWH7QjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SLdT4Yjd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=//VXU9BA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SLdT4Yjd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="//VXU9BA"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741078421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zx08JlhKjrFwsrf/XDyp6dzWEcCyaloMaRtsrUaoJsA=;
	b=SLdT4YjdxvKUkLjwHTEBmgyxJWT791d8naE4uAmFCLJuBLO/c8S192hs/XmCSxRuXSgNU4
	6TFejMw1gmEspL04koFc1ypwL3PUqb9308ZrvZu4ZF4hvbx54Jbl7xQ9eZ0iL7501kUwXe
	ZPmPubhY5xIgmxpJIVFkdEkeTjO58Lu5yHq14cd/VwwS6OAf3lsyUC1og0HklcKgDyw1yi
	WJDvmDGwl1eE82b6KeQHkv3wfKxBFwloeOHTKqId3HluKuR+0GfvM05aV8ToMGVaj4wP5I
	MJ2E2rbDUud9p9n5hVmGrBsAl9MGyFSc3nHcEjrUMYg/y6M0CDqo/P0k811+bg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741078421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zx08JlhKjrFwsrf/XDyp6dzWEcCyaloMaRtsrUaoJsA=;
	b=//VXU9BABL7dHWyTLfyblLI4UlVfBvCqwmQQ/BcIUNbp/rzz3TSX7WLgeSjBkdrn5X+kav
	EbJHScsItXx5gdBg==
To: Andy Shevchenko <andy.shevchenko@gmail.com>, adamsimonelli@gmail.com
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby
 <jirislaby@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky
 <senozhatsky@chromium.org>, Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v6 1/3] ttynull: Always initialize console index to -1
In-Reply-To: <CAHp75VdYOWkDj0VTa5H9V7jV=Sr5O4=L-1TN55MJU=ownOAJ1Q@mail.gmail.com>
References: <20250304035447.3138221-1-adamsimonelli@gmail.com>
 <20250304035447.3138221-2-adamsimonelli@gmail.com>
 <CAHp75VdYOWkDj0VTa5H9V7jV=Sr5O4=L-1TN55MJU=ownOAJ1Q@mail.gmail.com>
Date: Tue, 04 Mar 2025 09:59:41 +0106
Message-ID: <84tt89qiqy.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-03-04, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> In general we do not accept empty commit messages (yes, it was done in
> the past and in some exceptional cases, but should be taken as a very
> bad practice).

It would also be nice if the commit message explained _why_ the change
is done and how it affects the driver behavior as opposed to previously.

John Ogness
