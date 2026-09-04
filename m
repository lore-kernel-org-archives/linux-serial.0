Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A363E7BCA;
	Fri,  4 Sep 2026 15:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788537260; cv=none; b=HHwu1nuBalrsrvgbz3CBKfW+JC5MwL0VLpRezOw89lJPf66GmtKuZav/O+H3gGLjqAkCsc7sqQU9syr3OGP7UsdPXI0QBFtBrJojgHeUVdPcR629XpZVQl77ap2dZLorTYSr3kZfymOuPJrbWe2cvyCm4PTFjqaTzI9dI6+tJXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788537260; c=relaxed/simple;
	bh=Db/H1J5LgduKWdirU8xNYv0jlLbnZ0Dkq1s6liPHw3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=szVE+yU7RQ/8B2tzARB1JFIbkU+dc1IBon1oEzav75aSIwG2a1PlRVlqWeprNrmIzvH2+NOQD5Y42Y+0Yf0uWx/LaOui0eyzY0q9cBjjGfQCK7gZUcENxugP6cbPeAlQYrPVa66rDw+JzM6nfsQSVgIdg24SCW1vudhc91sXO6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZEaOJR4V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZEaOJR4V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4DBB1F00A3D;
	Fri,  4 Sep 2026 15:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788537259;
	bh=NI//CgyNJIZgw5DrLwccrAF7jwMkLJ+p2H4mqaJGRDo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ZEaOJR4VAhqULjqK8sdtEgrVYMCyV5uwwmL1ATjccvWm1dtrMj2iObFDfAfwmcP1o
	 lY1cFVG5wXJKOTYpKV9Jw8PsaS1b3i8X1ZP+tHcgWnYUf0ic24gfx9zbexBjZ4ml/2
	 eF/zNNDbMbMHlTEv22/+dIjLdyM/yTZ416LezFlWnD9fMlI8WPMWUMIl0/Gah50PsD
	 cksJmXEac/UUPsHTU8IInqKc0Qtidcjm/+oJ0FjI6jStjlJElbBHzlkIjRysWdJ/uJ
	 gGyG14oKOJquclPdnZWm8sSnapxTtk0+fBA+4C1QdvOl9kWIbn2UT00SXFLpVkLG79
	 r3G50C8ITSL8w==
Date: Fri, 4 Sep 2026 08:54:18 -0700
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
Message-ID: <20260904085418.50d66b34@kernel.org>
In-Reply-To: <cover.1788513591.git.brads@mainlining.org>
References: <cover.1788513591.git.brads@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  4 Sep 2026 09:37:21 +0000 Bradley Morgan wrote:
>   media: ivtv: convert to kthread_run_worker
>   net: encx24j600: convert to kthread_run_worker
>   tty: sc16is7xx: convert to kthread_run_worker
>   cpufreq: schedutil: convert to kthread_create_worker

Please send these 4 to appropriate subsystems

>   kthread: remove worker->task self assignment

Then after the next merge window when trees converge send this one out
