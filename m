Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625E61946BC;
	Thu,  3 Apr 2025 07:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743664563; cv=none; b=NmqfG248Cedi5TmLq6aixcQ5K99n7wHkrWINzwUwrDtvjZAaUzfVDT9RUZLttqVbnenl08Tlm/0wVTgset10NCPXa0nH1+jrvU6C7dQR+EiQDO0c3mZfZY3pwm5UiP3FkYs1QIMeb/Hn+1ULVtP2uvMXColZ0UearRryY3QaBJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743664563; c=relaxed/simple;
	bh=K0Yhj0kHWCJy2QZvkioCvW20xVjGpk+iPJxmc6rZ/94=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=mbTSGSbySgFhfiPBfM5o1AOQ7mUFZOUKpRIbhWwK1xk/x1lfFNIrJ852hMNJp8V8m2hCxBQWq8ma8qnDqYw6tSMjDVgggA7+amGnZpRo9LolE19feYgfdKhmbnlyhlh98+KEIltlSmbK8eNidyO3LlX1PuRdng41zPHHfyReyRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=N2gRGs9t; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="N2gRGs9t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1743664546;
	bh=Df9njtkH1JSNBBK8rp95HhPu9sctWdzoUtlDNBr3agk=;
	h=From:To:Cc:Subject:Date;
	b=N2gRGs9tZGQicgte5dEgn2E9GzMeECmeyAmUJJod5O/cdqISEVZswZsuZRwNXouaw
	 LxYl09n48aG/Iz/KP2PXqz7WpfITD6b6XFtctjgTrsWIZNjGHgwVpcOYyWM740wWa/
	 bVraIokDzMVPgEQX4So4c4FeiYlGlzY0PQsp0y9E=
Received: from localhost.localdomain ([116.128.244.169])
	by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
	id 3ED024CE; Thu, 03 Apr 2025 15:15:45 +0800
X-QQ-mid: xmsmtpt1743664545tkeksybyy
Message-ID: <tencent_F413E4391B578208516E16AA0FC81F2FEC07@qq.com>
X-QQ-XMAILINFO: NY3HYYTs4gYSHWmsnrcq2YOx1KjBIPkmtpVRB2Yw68AVjyQstEDqcBy9P6s1/h
	 9Ukx8ClnJBg6RVt1ejgloYWd+RpHWzJJ9OH38TCuQSxPjZHOeTrLlIJRcwZ7Juk7xavApgfLlXHv
	 +wzPZDfGJ9XR5G1uX0AkitcODn32MiK4sGFQEwD9/q7QBDl5UQ3a7HiTrus/dn1xRT4iJru5mgN7
	 B1D3WmvcaBH3DuaEJDYdYYXvlKty5PqlQypqQ/+5sOQGnJ+rU73TCoFQYXAXXIWbAjxXbnjg132z
	 Ro1jAgKExAG2G6bbjLpC+o4xoHwQrw1mj7JL9dpPKEEpsIVmC3yKd/dSOBxiY59sXoNcqSydR74F
	 9DP6hbZZkr67Rj/pR6zH7nHljnbKd/KsSEIXOTBOq1xj4fKZtAiXGQH072T3is/R61cUVcsu9xqa
	 s1hTGe1YBJmP0/tgcn0Mv/H3xgdGK0Mv703C7/GMkdd3j58T2v6uzKwscGEK8yj2uXwFfBe0PojB
	 jwaJyHwOI6p3+XTkKyE9m/vx0iPgIu+ElzTq4bRR/cER1RJTCBXCAOc4aF1/CRf8HYYNmLasLi7f
	 +uubWlUSR6qd8TBTHYQawc5Hk9pUq62U+oXJ12i+/7cuCMIUiGewQHzpCGZCX2BhbnjnUUF0vrXh
	 Sb2RVthFz6P2s61EZ6DZRGv6gijDspQ8/xjMrUuKjwn4LRmb8uiqgKKPkKmlo/oWNqbtg5hN1kdv
	 zTNJUdIq2B3HiYzHcYeADJZPBcoNBjAMpcn5Ci5bkQd10JKtzpFUxe1EakB4Rlu8baG0ViWhs4JF
	 0HMUiEJshxu3sjnDvMK8grRZWzXt4dJMZflm4c7Uj7ZjXnm/i7UZDNuEl6R+XvLqbd1qfjdEN11P
	 j8RqNyHrZDszcGphXDogloJcghFOmYAiYj/19jHUqO+OOoEtaZ2HKDaf2LcN2hmQq/kKuahkoC8Y
	 8ehKgp5IcgIeM7WkXXyVZPhQ8ZSJf8
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: xiaopeitux@foxmail.com
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Pei Xiao <xiaopei01@kylinos.cn>
Subject: [PATCH] tty/sysrq: make sysrq_replay_logs_op const and refactor sysrq_mask()
Date: Thu,  3 Apr 2025 15:15:35 +0800
X-OQ-MSGID: <5e39e113db01a7ddbdeb01631c6d9f8acdb82fd2.1743664449.git.xiaopei01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pei Xiao <xiaopei01@kylinos.cn>

Mark sysrq_replay_logs_op as const and simplify sysrq_mask().

Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
---
 drivers/tty/sysrq.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index f85ce02e4725..c2a26abcb8cd 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -71,9 +71,7 @@ static bool sysrq_on(void)
  */
 int sysrq_mask(void)
 {
-	if (sysrq_always_enabled)
-		return 1;
-	return sysrq_enabled;
+	return sysrq_always_enabled ? 1 : sysrq_enabled;
 }
 EXPORT_SYMBOL_GPL(sysrq_mask);
 
@@ -454,7 +452,7 @@ static void sysrq_handle_replay_logs(u8 key)
 {
 	console_try_replay_all();
 }
-static struct sysrq_key_op sysrq_replay_logs_op = {
+static const struct sysrq_key_op sysrq_replay_logs_op = {
 	.handler        = sysrq_handle_replay_logs,
 	.help_msg       = "replay-kernel-logs(R)",
 	.action_msg     = "Replay kernel logs on consoles",
-- 
2.25.1

