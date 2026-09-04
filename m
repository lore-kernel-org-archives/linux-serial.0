Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2958944C66B;
	Fri,  4 Sep 2026 09:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788514825; cv=none; b=IsfM8CQBaUA+oNVIL9ZUN7ADagGNNjQrK632xPXmdv8U0vCn9dU6G96mVG28u35QBW/9d8CoHfQqq9mNZqmTwTDHbW7cqHkxY7CvnOBCfWM+vcHqnTVbzMwjTKj1SUmzI+3isygm17pBvPJu32fN9Vj0jksRhYCNRwRGcOMajd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788514825; c=relaxed/simple;
	bh=F77njVnBvpwZk6BnrQfZT9AMKFdPuuVMV2iyZCHGOCw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jQWWDhieeV4buM0TDojr7jSXZCL3FaFj+9pZarqlZZGAdXDD8GxKN17v8IJeGexJpGaiDe8lDuo7k0nAr5QpIXWNIKZktJZwAMZmKheGdBBY+jrGt0b7HIkoUkUnFULpIBNQ8BZQFqwI649tXIgZoCwxBU+V+aiQ82+PhEBKgBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=i/cUg8QR; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=uJEzQI0m; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="i/cUg8QR";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="uJEzQI0m"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1788514806; bh=qx0JP8pv2SK72dhqWLFGYNf
	k+VCMUCgvowqOr6GdkxM=; b=i/cUg8QRZeFqIDqcaO3md4HeGZHTT5tuTqUS55xDbTN7x5FGtf
	dboejUh+sKai0kgBFuQPraOMmYvz3aCD3C6uXfvU59XchSKhGegVsRvMcYoqH0/yLyZrtU61oYz
	z0Rr5MWtJk1wKzWPD4/EJjZ2r0IaZM4GU98YSu5jZfqI8axRZxDF6E6eXf9gqEwswLMclfJ7XYz
	YQAYRzACxKNtwBnsj4Twf/W1YtnalcwIJzYd4yaK6H9Xx1hAyVZiK3Ri/5vNH5KN2sKiM8E6I5O
	7n2BI53rNOTo2oZdQK9iEcScBkCS6ls1G1xxOs0fOozZBOPehupEFJtpN8kLXvtfauA==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1788514806; bh=qx0JP8pv2SK72dhqWLFGYNf
	k+VCMUCgvowqOr6GdkxM=; b=uJEzQI0mwNO11hVz05y+5ej8b5wrVzhjXfrjGYXpubtcYwHP3g
	GNvVGQQrRDwTXGSo7BEhgOoZZAacGtGo51CA==;
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
Subject: [PATCH v2 2/5] net: encx24j600: convert to kthread_run_worker
Date: Fri,  4 Sep 2026 09:40:06 +0000
Message-ID: <ab6035a1d48109ba93fdb36d15d3306c46ab94b3.1788513591.git.brads@mainlining.org>
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

Convert encx24j600 to use kthread_run_worker() instead of the
deprecated kthread_run(kthread_worker_fn) pattern. The new API sets
worker->task before the worker starts.

Signed-off-by: Bradley Morgan <brads@mainlining.org>
---
 drivers/net/ethernet/microchip/encx24j600.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/microchip/encx24j600.c b/drivers/net/ethernet/microchip/encx24j600.c
index b011bf5c2305..460189064332 100644
--- a/drivers/net/ethernet/microchip/encx24j600.c
+++ b/drivers/net/ethernet/microchip/encx24j600.c
@@ -49,8 +49,7 @@ struct encx24j600_priv {
 	struct mutex              lock; /* device access lock */
 	struct encx24j600_context ctx;
 	struct sk_buff           *tx_skb;
-	struct task_struct       *kworker_task;
-	struct kthread_worker     kworker;
+	struct kthread_worker    *kworker;
 	struct kthread_work       tx_work;
 	struct kthread_work       setrx_work;
 	u16                       next_packet;
@@ -823,7 +822,7 @@ static void encx24j600_set_multicast_list(struct net_device *dev)
 	}
 
 	if (oldfilter != priv->rxfilter)
-		kthread_queue_work(&priv->kworker, &priv->setrx_work);
+		kthread_queue_work(priv->kworker, &priv->setrx_work);
 }
 
 static void encx24j600_hw_tx(struct encx24j600_priv *priv)
@@ -884,7 +883,7 @@ static netdev_tx_t encx24j600_tx(struct sk_buff *skb, struct net_device *dev)
 	/* Remember the skb for deferred processing */
 	priv->tx_skb = skb;
 
-	kthread_queue_work(&priv->kworker, &priv->tx_work);
+	kthread_queue_work(priv->kworker, &priv->tx_work);
 
 	return NETDEV_TX_OK;
 }
@@ -1046,15 +1045,12 @@ static int encx24j600_spi_probe(struct spi_device *spi)
 	/* Initialize the device HW to the consistent state */
 	encx24j600_hw_init(priv);
 
-	kthread_init_worker(&priv->kworker);
 	kthread_init_work(&priv->tx_work, encx24j600_tx_proc);
 	kthread_init_work(&priv->setrx_work, encx24j600_setrx_proc);
 
-	priv->kworker_task = kthread_run(kthread_worker_fn, &priv->kworker,
-					 "encx24j600");
-
-	if (IS_ERR(priv->kworker_task)) {
-		ret = PTR_ERR(priv->kworker_task);
+	priv->kworker = kthread_run_worker(0, "encx24j600");
+	if (IS_ERR(priv->kworker)) {
+		ret = PTR_ERR(priv->kworker);
 		goto out_free;
 	}
 
@@ -1087,7 +1083,7 @@ static int encx24j600_spi_probe(struct spi_device *spi)
 out_unregister:
 	unregister_netdev(priv->ndev);
 out_stop:
-	kthread_stop(priv->kworker_task);
+	kthread_destroy_worker(priv->kworker);
 out_free:
 	free_netdev(ndev);
 
@@ -1100,7 +1096,7 @@ static void encx24j600_spi_remove(struct spi_device *spi)
 	struct encx24j600_priv *priv = dev_get_drvdata(&spi->dev);
 
 	unregister_netdev(priv->ndev);
-	kthread_stop(priv->kworker_task);
+	kthread_destroy_worker(priv->kworker);
 
 	free_netdev(priv->ndev);
 }
-- 
2.47.3

