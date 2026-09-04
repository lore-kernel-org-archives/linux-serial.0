Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78DC4503E0;
	Fri,  4 Sep 2026 09:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788514831; cv=none; b=oqT7jA7GrdsFZYR9ITCLjhaJXScit1gbYZqGCDg+qUB4wUe239ZHTrN5Rpd2FeSDtkvQ1Io0IMrsUxbi/xBcyfGAGZsSP3jGkG3qrFRibSAZiIN2gT+4hkrA3spFvy9oK6BdauhDTeGWgSzFMtObRZ+t5fSQiwEV+R0YDPOpTh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788514831; c=relaxed/simple;
	bh=u6ku6jmRU/n0Rn1nBuL9IyYY8MhYBi0W4eF2S7GbeAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=flYOaweWNLuRDiKLDlHakG83NPKZMrHp33uzogFKXOMwlR+AsiaEQ1GaharTmCbKpzAy34W2V4pbF2il1zxVbQ+/QiLEhHO+1PSzGF5lstoOzTWHbTwvmdwNBg4Eo9drvWX0UOyp+msvggz54gW6yExUTdaGrevf+/iWgMArNbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=A+5ohxxj; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=sMJzH2hO; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="A+5ohxxj";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="sMJzH2hO"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1788514808; bh=GtJwjFEqunLh1MR0EZ6sNcj
	Za1VU1Os+aybsH6L/GRo=; b=A+5ohxxjWovfA/Jszg0LKGD19mUbaRyfuhRuFjeJn7QC3ibqjW
	5Rh9xeozv4vhGDqg1fB5/MGu98y1iSxr901lIN5B6Cdq1Y1LqjYGWbiyJTjL6ENCeUx6/6xebEa
	SlIAe1mR8ROXdZVMvV/vMEZDiYEWG5oXObabAG18ordSMMLUaGuof1Db7FMSNxWL8YUIUya5Dc7
	t1fA0vyWHcqlS6ism4B82kwpG420LIiNEfezI0pB/kWtfoawe9uDFSIs79JFETCjAyMPIj3ecLs
	K4vmiRZFsF3pjFwMhW7DLKNbLleYpD2yfbaaaJC3ie4qn6/EKcqIAV3tP/sU9M1aZpg==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1788514808; bh=GtJwjFEqunLh1MR0EZ6sNcj
	Za1VU1Os+aybsH6L/GRo=; b=sMJzH2hOxCH9rBrCsj3cncajJ8ouO/wru6NMrciL5e44LGZc1X
	gLeUe2PnXkrBcrfFsTX74E9czQ9HO51bEtAA==;
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
Subject: [PATCH v2 5/5] kthread: remove worker->task self assignment
Date: Fri,  4 Sep 2026 09:40:08 +0000
Message-ID: <c925e99c73bea9e0cdab656ba09453df7e81dcb2.1788513591.git.brads@mainlining.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1788513591.git.brads@mainlining.org>
References: <cover.1788513591.git.brads@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All kthread worker users now create their workers with
kthread_create_worker*(), which sets worker->task before the worker
starts. The self assignment in kthread_worker_fn() is dead code now.

Remove the assignment but keep the WARN_ON() as a sanity check for
any OOT users still using the old API.

Suggested-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Bradley Morgan <brads@mainlining.org>
---
 kernel/kthread.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/kernel/kthread.c b/kernel/kthread.c
index 63beb59b7a3d..643407647e79 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -987,12 +987,10 @@ int kthread_worker_fn(void *worker_ptr)
 	struct kthread_worker *worker = worker_ptr;
 	struct kthread_work *work;
 
-	/*
-	 * FIXME: Update the check and remove the assignment when all kthread
-	 * worker users are created using kthread_create_worker*() functions.
+	/* All workers are created with worker->task set. If this fires,
+	 * the caller is broken.
 	 */
-	WARN_ON(worker->task && worker->task != current);
-	worker->task = current;
+	WARN_ON(worker->task != current);
 
 	if (worker->flags & KTW_FREEZABLE)
 		set_freezable();
-- 
2.47.3

