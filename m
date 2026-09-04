Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FED6455172;
	Fri,  4 Sep 2026 09:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788514680; cv=none; b=J+hgWfqQYAMdl7PnkfgEpS34TN8UONp+uy5do52Fdd0mziRWFND+/fOQ6jNWCYbq18nZT35IckYNvmOiTmNoZc/O6h6NN03DZLitoMJokg6YtI/n/csZHJS1bdX1cEJVwRsRrm7j/F8rD9EBHoopmCmZAq1AXgBjgjvcA1keZSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788514680; c=relaxed/simple;
	bh=lp9enFYU5krWjxaOK6ZefJg4ga4jexPBLKbgpWh+lnE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OG5fHZouWOVptuj/FrtsxfEz4lWkGR0qhTlIqjxS8n0D23xA8ECteWd8pf5Li1OlucW1KIAJxuzH0C6vEBni4fs77YW5T4XtvfIz2JEhRyTbexF8q+2CNoXC3AyNavwE/LQPIwSxo8Pwk5Sw+nXJtCu42yEF+wdvkdkGUWaJACs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=Bj3VY8eN; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=ynytCk0E; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="Bj3VY8eN";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="ynytCk0E"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1788514641; bh=INADsmA2RXEyfejAaBH3lp2
	marJgyXuIIeN+mEfwxNU=; b=Bj3VY8eNFdMQCC0Y2TS3euJloxDvqOyCqKSsgB9t+mMpovuRwV
	tuQdH6DjcNGgiewaaiy7hMlfRLYg22RimHtn5hHO5Lw25EPJ182UXQcHRdq/LsXrQ+x2/qurgEh
	o77dpjoSsLxFcLbKV+YJLXfhYIhWiGN1/MG3YAeGED5wPmUKHH62SKR4aOqBHJ8aqj5fS12KeMH
	1AMINAyIX60/4e1gAZkPH5i3BXclXMYnAqK+wTG1hTPrW8dJtbQxhENsfkwlYRVrTi8PvpMUNRh
	0h2COy0BqVaJWqWC1Fkp76z+Y1H7CiH87Nr4bYJFg3vcbABmQgf7L9xtlVGFmNt4+mQ==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1788514641; bh=INADsmA2RXEyfejAaBH3lp2
	marJgyXuIIeN+mEfwxNU=; b=ynytCk0EcVKBKxFmO8j05rO7jUSPxV/IugZMPzjbsN+vYRNEJc
	vSqxhUbDGXIHm2QIbpzrqNV+i0zCYv1wjCAw==;
From: Bradley Morgan <brads@mainlining.org>
To: linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Waiman Long <longman@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Andy Walls <awalls@md.metrocast.net>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Bradley Morgan <brads@mainlining.org>,
	linux-media@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v2 0/5] kthread: convert remaining users to kthread_create_worker
Date: Fri,  4 Sep 2026 09:37:21 +0000
Message-ID: <cover.1788513591.git.brads@mainlining.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kthread_worker_fn() has carried a FIXME for a decade: it assigns
worker->task = current because the old kthread_run(kthread_worker_fn)
callers never told the worker what task it was. The new
kthread_create_worker*() API sets worker->task before the worker
starts, so the self assignment is dead code.

This series converts the four remaining users of the old pattern
(ivtv, encx24j600, sc16is7xx, cpufreq_schedutil) to the new API,
then removes the self assignment from kthread_worker_fn() while
keeping a WARN_ON() as a sanity check for any out-of-tree users.

v1 -> v2:
- Keep WARN_ON() as a bare sanity check (Frederic, Peter)
- Add comment explaining why the WARN_ON() is there
- Fix subject and changelog wording

Bradley Morgan (5):
  media: ivtv: convert to kthread_run_worker
  net: encx24j600: convert to kthread_run_worker
  tty: sc16is7xx: convert to kthread_run_worker
  cpufreq: schedutil: convert to kthread_create_worker
  kthread: remove worker->task self assignment

 drivers/media/pci/ivtv/ivtv-driver.c        | 14 ++++----
 drivers/media/pci/ivtv/ivtv-driver.h        |  3 +-
 drivers/net/ethernet/microchip/encx24j600.c | 20 +++++------
 drivers/tty/serial/sc16is7xx.c              | 39 ++++++++++-----------
 kernel/kthread.c                            |  8 ++---
 kernel/sched/cpufreq_schedutil.c            | 33 ++++++++---------
 6 files changed, 50 insertions(+), 67 deletions(-)

-- 
2.47.3
