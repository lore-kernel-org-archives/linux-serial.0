Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE931298CC4
	for <linux-serial@vger.kernel.org>; Tue,  4 Nov 2025 10:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762253702; cv=none; b=ZaHRmwHAfamVA14XIbbnFp3SoniA/FasYT23YiyW1y6r8FS0i2h9pkE6Gj7ICKsDUfb6m0gjXkmi4tGYBARuN2RcVN0ipoBYQJfvjM68TitKPT2gLwUAE1V86XByXxSspi4ThrLIyESl5lkKktOmgy0ts74gZQTAPBdfH146eFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762253702; c=relaxed/simple;
	bh=R1jeV3wiv8DXKujJVS3YRokbucemxRcp2L9aU/+ZO2A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XQlFNwdCyWPFGVIPZFV/fsuquKUCGebAoCH8B6qiUIVT9jVPIw4oPOeKDwPo/uEhgPnKNNuPj+/nEDevbR6s7sY7SIqh5iXHkyeSQdQybb8fzL/fCbeGi1CGUjf7q16KQYBbFT18HmwGv1RPQPTWH12PikkUjH5pXRdK556b8Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KgD/oN9w; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KgD/oN9w"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b6d4e44c54aso705306066b.2
        for <linux-serial@vger.kernel.org>; Tue, 04 Nov 2025 02:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762253698; x=1762858498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h68+BzrgDoWnKcF5o/ojKkTPKX3UizaTNvfX1EgB8Ec=;
        b=KgD/oN9wnLB688glrZk0raXjwK+UyQBMBVNFeNjb1sg2zB7iVlEe5UafQ5Gbi0lNCk
         OE+Bxfa2l9XjZ2ayQBe3LZZFrOggrMJ4pSVGB3OeyYlWEd8fmIeAS5Drup+YLWB22T53
         GQbA5E09/Emi8980QyyeGv8ahduJwEykJxYEUAQX14FzH0x5le5JfOkqreE/QOLGu0r3
         kgMJyOK2iGdmcw/MQsOfR/99OXElPDDUlNt3kpGg1iEiwiReG+uj17aDGywz6ooh8sJy
         UNUcr3ihLg0jrX80lhDt1Lahkc/+w6nigZi0fTCZ84NoxqqcXLVqGYD+pvXTtE+sldwx
         Bu1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762253698; x=1762858498;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h68+BzrgDoWnKcF5o/ojKkTPKX3UizaTNvfX1EgB8Ec=;
        b=wzfaj5Qv7eUafTrA+rVh5qyJPVul4nF+VQKD2vz33LU4tMJIRtHF5PcMMn8OWx7vgg
         rBubkHz808xN5wJljGaMUwsVLIsmngW/19NaoCQGWvjdNcohCqXQLfRLK3CtU82AgIh7
         NRJq8noq9vVKoIhcDNw/YX6b84cr6k5T7+qSrxlf3A3nb4JPT/RQ3gwWqBVZ3oY/VlUn
         AYZ5AU49FSUCQu59PZmbxE3qXWYVRYDrnCvhR9HA+L+GFgfsbtTuIx5A6Nkv7XDLVs7S
         JsE1nMbeTj79+yFlT/pYV5JaIQ2hFh8RB3aihGAIeyko/HNcWfO5S7TCHqzIcfqoUN/n
         exCw==
X-Forwarded-Encrypted: i=1; AJvYcCW+EWQwUebl+lbtIFpcWnFBpy41pspajorZAgKVe9I/9+wEXD1N1gYvbiZEXnjoc1X+0CeeX1SIwLeBRvI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHVDqRcI2HVQmEnsjt9jRnMbaVD5TnShx7NF1IwXjHsRb119FV
	wne+sGlV7xF/dPikeIhu7dFD4JfpWKfW7uWJSIaqJT5oAt2Yi4ljhc1bdJR3tCOJxvQ=
X-Gm-Gg: ASbGncsD5Ut8jnq4g3O6gnKTn/Kdk2BLTu8e6eAz4t0URR86C3o6BcuK1lZEdz+zGxz
	+Tw2jqPSPpklVVkMEHrty89pkgYwlT2ia4IiIZ/335c5DFBXp//7GmuwZUgLEKlm2fRNDbY/zeX
	i5fs33hX4gW6guiTiBf3gdXcyymzjp2wMKzNeDmysE2VjCxf7V6Tpt3hOtOPulhJZzAAi7f5BXr
	2opl+aNIpcMq6aSiZjYSQz2b+vL3faOvmVHawTxGTMMhpkPbDfIEYfLiEM3pz7bQNVPl0cJ/wfa
	TjDDjlqqByJsnSg6AANTm5K90VPlrdgjyRtJu7cRxyYXJsmyitFSsf+JNSUg8hqVx4UZCKT4yMd
	R2gYcyLlKNmwPWAuoskLgxoHNh9aJ3QLBt9XPYCDBhyr79jm7sOVS/UnGSrHqMMNwAoKlh9RLjg
	HUiYMfXUNM33Ks8A==
X-Google-Smtp-Source: AGHT+IHfPN6V1Gb0/vnW2BNSqlXyl8GiEmiehj7J7xXiDDPdmxVdlwQ2TmXH/z4ECTJFaHlBm/ipbw==
X-Received: by 2002:a17:907:7256:b0:b72:5983:db20 with SMTP id a640c23a62f3a-b725983dfdamr87995466b.32.1762253698012;
        Tue, 04 Nov 2025 02:54:58 -0800 (PST)
Received: from linux ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b723d3a3d4asm180927566b.2.2025.11.04.02.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 02:54:57 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH] tty: replace use of system_unbound_wq with system_dfl_wq
Date: Tue,  4 Nov 2025 11:54:46 +0100
Message-ID: <20251104105446.110884-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently if a user enqueue a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.

This lack of consistentcy cannot be addressed without refactoring the API.

This patch continues the effort to refactor worqueue APIs, which has begun
with the change introducing new workqueues and a new alloc_workqueue flag:

commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

system_dfl_wq should be the default workqueue so as not to enforce
locality constraints for random work whenever it's not required.

The old system_unbound_wq will be kept for a few release cycles.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/tty/serial/8250/8250_dw.c | 4 ++--
 drivers/tty/tty_buffer.c          | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 710ae4d40aec..27af83f0ff46 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -361,7 +361,7 @@ static int dw8250_clk_notifier_cb(struct notifier_block *nb,
 	 * deferred event handling complication.
 	 */
 	if (event == POST_RATE_CHANGE) {
-		queue_work(system_unbound_wq, &d->clk_work);
+		queue_work(system_dfl_wq, &d->clk_work);
 		return NOTIFY_OK;
 	}
 
@@ -680,7 +680,7 @@ static int dw8250_probe(struct platform_device *pdev)
 		err = clk_notifier_register(data->clk, &data->clk_notifier);
 		if (err)
 			return dev_err_probe(dev, err, "Failed to set the clock notifier\n");
-		queue_work(system_unbound_wq, &data->clk_work);
+		queue_work(system_dfl_wq, &data->clk_work);
 	}
 
 	platform_set_drvdata(pdev, data);
diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
index 67271fc0b223..1a5673acd9b1 100644
--- a/drivers/tty/tty_buffer.c
+++ b/drivers/tty/tty_buffer.c
@@ -76,7 +76,7 @@ void tty_buffer_unlock_exclusive(struct tty_port *port)
 	mutex_unlock(&buf->lock);
 
 	if (restart)
-		queue_work(system_unbound_wq, &buf->work);
+		queue_work(system_dfl_wq, &buf->work);
 }
 EXPORT_SYMBOL_GPL(tty_buffer_unlock_exclusive);
 
@@ -530,7 +530,7 @@ void tty_flip_buffer_push(struct tty_port *port)
 	struct tty_bufhead *buf = &port->buf;
 
 	tty_flip_buffer_commit(buf->tail);
-	queue_work(system_unbound_wq, &buf->work);
+	queue_work(system_dfl_wq, &buf->work);
 }
 EXPORT_SYMBOL(tty_flip_buffer_push);
 
@@ -560,7 +560,7 @@ int tty_insert_flip_string_and_push_buffer(struct tty_port *port,
 		tty_flip_buffer_commit(buf->tail);
 	spin_unlock_irqrestore(&port->lock, flags);
 
-	queue_work(system_unbound_wq, &buf->work);
+	queue_work(system_dfl_wq, &buf->work);
 
 	return size;
 }
@@ -613,7 +613,7 @@ void tty_buffer_set_lock_subclass(struct tty_port *port)
 
 bool tty_buffer_restart_work(struct tty_port *port)
 {
-	return queue_work(system_unbound_wq, &port->buf.work);
+	return queue_work(system_dfl_wq, &port->buf.work);
 }
 
 bool tty_buffer_cancel_work(struct tty_port *port)
-- 
2.51.1

