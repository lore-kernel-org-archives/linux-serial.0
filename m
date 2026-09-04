Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DD82FFFA4;
	Fri,  4 Sep 2026 21:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788556237; cv=none; b=jFOMkhBpU7p4qI9lcjdfjkaOzOoqa7q3vFvSVQjQ8qJ80Fge1gBuMUz3FPsPgWM/2j508MBGq1hSbeWTlicz0FbKf7YGEVmveHmdAJrqSvx3XDJxUjQOm42z39rOsx5jy82WFYCTe84bdB+Q54I7W0KtK/401hKXHWGiCQYf5l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788556237; c=relaxed/simple;
	bh=YaCXYoUUaTLUhORks4A1xiY+YQU65F5kG6iXf4O7ATw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FxopxPPXJTV2zQyISP+FnQnb5bGwZvEQA0AYfHeEEGKak3Kth2bl2zQj2jf9JE7VJBf5E0JCvydKNurWSY/i+b8gSqusFgnwSGSCNVscdHanYurDQO0CztWMWp6Ppr4WlL/gc82JVS+dKeDBFEbxWzPcwFrxCXMf4tAKt8Q3HpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DbTOO8g2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DbTOO8g2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ED681F00A3D;
	Fri,  4 Sep 2026 21:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788556234;
	bh=WyBWSLKIM1UOA8SLLHDv9QxxorSYv6s6LZzcrhmVid8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=DbTOO8g2umtsXv8AzOlXYkgUH40JRcYEP9cxg04pwLBx/ujdUnOLLMmaB6MAch/Fr
	 DByeg4UHuSFroIblj8JhC3TM4ULBaphvpmp4A1mOXJJS63ODV+n9PHQO187GsZZ5JY
	 2f+QW43SRdUeTlCQ6VxrHznqh0BKy6JsZknYSzUh4ZoZ4iJO6qTI+yMVYWbjSkMnPd
	 g2x4ieBOKNvsOTqpahOF61zgC5dErIkTTmWTw3r1aaIeSRoZUI5fMgM+MuDg/xmivd
	 5Q/uSQF8yYOBBPjje9L8BmzcQoeLaquy7BuWv7veo560l+9G0VnJgVB0PJqrxfFoiW
	 c2Fs7xrQGUkaA==
Date: Fri, 4 Sep 2026 14:10:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Bradley Morgan <brads@mainlining.org>
Cc: linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>, Frederic
 Weisbecker <frederic@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Waiman Long <longman@redhat.com>, Christian Brauner <brauner@kernel.org>,
 Kees Cook <kees@kernel.org>, Andy Walls <awalls@md.metrocast.net>, Mauro
 Carvalho Chehab <mchehab@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, "Rafael J
 . Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 Ingo Molnar <mingo@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, linux-media@vger.kernel.org,
 netdev@vger.kernel.org, linux-serial@vger.kernel.org,
 linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 0/5] kthread: convert remaining users to
 kthread_create_worker
Message-ID: <20260904141032.34f7ed1b@kernel.org>
In-Reply-To: <84548BCE-377E-4900-A2EF-177B0CC1B0D0@mainlining.org>
References: <cover.1788513591.git.brads@mainlining.org>
	<20260904085418.50d66b34@kernel.org>
	<84548BCE-377E-4900-A2EF-177B0CC1B0D0@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 04 Sep 2026 16:56:30 +0100 Bradley Morgan wrote:
> On 4 September 2026 16:54:18 BST, Jakub Kicinski <kuba@kernel.org> wrote:
> >On Fri,  4 Sep 2026 09:37:21 +0000 Bradley Morgan wrote:  
> >>   media: ivtv: convert to kthread_run_worker
> >>   net: encx24j600: convert to kthread_run_worker
> >>   tty: sc16is7xx: convert to kthread_run_worker
> >>   cpufreq: schedutil: convert to kthread_create_worker  
> >
> >Please send these 4 to appropriate subsystems
> >  
> >>   kthread: remove worker->task self assignment  
> >
> >Then after the next merge window when trees converge send this one out  
> 
> hi, I was hoping one person could merge it with acks from all subsystems

Not how this works.
