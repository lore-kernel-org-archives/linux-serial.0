Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4784A1E03;
	Fri,  4 Sep 2026 15:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788537437; cv=none; b=VNKZ3lffvHNB5zZ+XMLzxSEwY20eqdLgIx7584Y9pAMuFZMaEwWwdEnYmyeM/rhmAZdb7u+ZaZ1dOWVnrvVH3rD1EHOj4bpNjBTBFDO1UY68J2BJvmsgdWHf6xvlq5P/YoDdWG95LLMu9feg4SucgfevBUcZBQbwWfCK+sYmDwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788537437; c=relaxed/simple;
	bh=MZnLCYn9Paf+msDfA0RdYT+yDKCT4ZWySc6m0noNLY4=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=lXMpfvETzELRl4waeuwIuC6//tNtberCJftXEdT8DoHnmtj6SJyXIMBiUx6N4oswknyAoME5YJpAeLJGWuz6n3vg6oIdTRoiAw1cS/Xc33XP31+KUBF6bmeuo6WWP4QQZcmGEDU64eO0a7fYbFBS9mxz1BDZm0I3r4Oqn9wt9+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=jttH8H9O; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=k7Ne67V7; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="jttH8H9O";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="k7Ne67V7"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1788537392; bh=VQ914RWSBB6yqw4ly+f3nmt
	B5GW4+oAJjq1hzmCgO8s=; b=jttH8H9OwhJ71AnUK0OSNeAGUmPJW9kTdaSVmfa9Hjv8ePKyQF
	3qoNMNuudB+nbF7CzN36VUFO1vab+LOm+IqVvy+5Ax24cE8RPUVYYgYme4agjjR81qwSmSQRvsY
	ul7Lzpn6LMP+aGjDHc6tiDN+Sd4Oh+cMxnhoUSHGXgHtWZu+YPaBbj3sFXjDSNardCZX5eYf+rL
	YRxYBXO19Bd4LnR4XmaOW3NAxM1SVPAOEUAlDjGGuPYmBsDOjtQFWnHwMqOuFoMZFdCYMRDcQ6E
	QXnsNKfqgYocxJp6iFiV6WMa7Y97pDy/YhxE/397ng/l/MTFwWnTxNaJIhYx8BX0M6Q==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1788537392; bh=VQ914RWSBB6yqw4ly+f3nmt
	B5GW4+oAJjq1hzmCgO8s=; b=k7Ne67V78CdSFlEz++WTBLciMlx0ZFbRlE84iStVVjsYLjGoGK
	+mP3mgl8/v9fIADXAi5xwBJIxjJE8xyCtWAQ==;
Date: Fri, 04 Sep 2026 16:56:30 +0100
From: Bradley Morgan <brads@mainlining.org>
To: Jakub Kicinski <kuba@kernel.org>
CC: linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Waiman Long <longman@redhat.com>,
 Christian Brauner <brauner@kernel.org>, Kees Cook <kees@kernel.org>,
 Andy Walls <awalls@md.metrocast.net>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Ingo Molnar <mingo@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, linux-media@vger.kernel.org,
 netdev@vger.kernel.org, linux-serial@vger.kernel.org,
 linux-pm@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_0/5=5D_kthread=3A_convert_re?=
 =?US-ASCII?Q?maining_users_to_kthread=5Fcreate=5Fworker?=
In-Reply-To: <20260904085418.50d66b34@kernel.org>
References: <cover.1788513591.git.brads@mainlining.org> <20260904085418.50d66b34@kernel.org>
Message-ID: <84548BCE-377E-4900-A2EF-177B0CC1B0D0@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 4 September 2026 16:54:18 BST, Jakub Kicinski <kuba@kernel.org> wrote:
>On Fri,  4 Sep 2026 09:37:21 +0000 Bradley Morgan wrote:
>>   media: ivtv: convert to kthread_run_worker
>>   net: encx24j600: convert to kthread_run_worker
>>   tty: sc16is7xx: convert to kthread_run_worker
>>   cpufreq: schedutil: convert to kthread_create_worker
>
>Please send these 4 to appropriate subsystems
>
>>   kthread: remove worker->task self assignment
>
>Then after the next merge window when trees converge send this one out

hi, I was hoping one person could merge it with acks from all subsystems

--- Thanks!
https://lore.kernel.org/all/EE579805-42F2-4C58-B752-F28779EEB717@grrlz.net/
