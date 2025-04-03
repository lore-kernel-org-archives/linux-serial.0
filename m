Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE191A23B6;
	Thu,  3 Apr 2025 08:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743669886; cv=none; b=cqDIh067mCC2cDaBHDH+SPm5Zw/dMgfali6Vf1RD5Jfu/v3gdCQA6DLV6amXTfBRYJeg2HBM3koi1TOzFgaHNtyLzS2PHwThbGgWkx4PcL9Zbtni+WW7S/KmYanJqniOAiwREeTxvwJE1zGnpA43cnp2TAuoArguqB708tiKMzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743669886; c=relaxed/simple;
	bh=QdeE6MJ7SU9GvUDYa+6b65DIUOKC9Rx0PxFPH/MaNO0=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=bIVQs2E7hCV5cKmAhv2HSeiOXgrb0in3fKTUPk8xf9Xo43asK8/NwuiiBbrk7gxVZhBqdf8sUgZthoUb3xJL/YHBxo9lgP7z3j+J4rOXGII4+XcE+nC+iSliHWSFyzWELlnwm1NBSzdG5nCmhU7gvKML4+dWCc6IWH1fACBU+Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=AvOGk1ew; arc=none smtp.client-ip=162.62.57.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="AvOGk1ew"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1743669875;
	bh=W9wjJT3SCICmQEgqiDLb/3PohfQqeJ8uNC2KVvteB+w=;
	h=From:To:Cc:Subject:Date;
	b=AvOGk1ews/r+tfo3Ixyr34+oqmcZfzYaX45fzJda5Bk9ShxvXQTtPBaWjzVRINtMF
	 tcGms7jjI9J07AQ7cHBoyoo7U2sQCmrzAI8ZWM4g6KOMrB51QX4R+l0noWMoHchBB6
	 tR3/YeZvC/1rsWoJOOa2lPcc/H9Z9PoTF4+ymluU=
Received: from localhost.localdomain ([116.128.244.169])
	by newxmesmtplogicsvrszb20-0.qq.com (NewEsmtp) with SMTP
	id 9941704F; Thu, 03 Apr 2025 16:38:20 +0800
X-QQ-mid: xmsmtpt1743669500t1zvf1zoo
Message-ID: <tencent_E7CD9DB87A448073E350F9400678ED9F9C0A@qq.com>
X-QQ-XMAILINFO: OATpkVjS499uGCFxI0GCmM/xkHeprXISujenAhEOkd7actLH/w73EMjOwKmJD5
	 wxPNEhCxKOwmEO9WCd1p24NXZS2N1Oiyz2jKzz0aB/0mTRZI2dgSKLy8d/I7/SsdsEm2SmEKAxxY
	 pmadLpMK8xeiRyM1b0XqD1fnulunPM7iDWhRypqdznmv+ZQn+sU4xOai8319h6wMmnK0DCMf+2w4
	 PxssBR1G2oXr6HXD+D+TZ4ltfgH7gDdoNtldI0ih3mnI4mfZy1hwrmYZFFg1qj/L9mAUQMBXBR1e
	 4JJcoRfTJZXQ3ITvOxK82djACCpvcYwQj9vOdDa6sFEusEqANN7wx6J9GtLNz/t6ReFN/HmSiiq8
	 cOA4xKnbzp7UjR8qbhW3NU3iK58JSWRZk/eQwyM6kVn+siV4g5KzKWTRuIoewT3yHC2tnaD4xlVp
	 S4zAEqMKl9rOgTrCXvkWvTzHFO/p9Xae5mXbsIdUy5Ait76icUHg63kKbYSIeWqq7PZaT9v2KvG0
	 JoQ0zF3iJ7t0L4rFa9vaO+iV8R6UmvxPvZgDZta8XAogtxl+lPLLzuieLUwWPdKr0i15H4GF4jcV
	 +S96nDOWMmjzTkNPaSxaF439cUh/l2aNClSE+yBnqmeE9ekEnTqFyIwPbhc1xiWi9Bwf4PkfZXwo
	 lsZYTn2+9MngT21riifFiu9cVnLuYjgNx8OpayvwGLzQBjfofAkeZut9plETwds7wdlOzG+dzo4j
	 rFYs+Mdn9pjcy3ahnwFSigjDl0h/MrT6J1gsipUCF1brQob5x2MBL3deU9Ga9B3f16R15mEIdcIr
	 SCS5JvTgGthPHHqi9tSXaJFB+ctXuz4I98bYxA0vXpyBoMmgqLJw+OfN0JH0MVgsU7xD3jKvAIJ5
	 C9iCExKTyz6cjyDRxbnHk4wfNcIGS+UEp9Jbio746rW94KC7b6ifHtW1zSN7Gp1OefyYggMdkm8g
	 AnR+yjFs9G6B4f1Tg2zB3gu97AWZV9IZ33pJ7ShjUTnbOn97BriWRL2FcOAlFCoGN33C9uH//ogI
	 0Wwchqew==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: xiaopeitux@foxmail.com
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Pei Xiao <xiaopei01@kylinos.cn>
Subject: [PATCH] tty/sysrq: make sysrq_replay_logs_op const
Date: Thu,  3 Apr 2025 16:38:18 +0800
X-OQ-MSGID: <b79e3d2d35679b5c38a3afe53e3cc93e0adc4413.1743669351.git.xiaopei01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pei Xiao <xiaopei01@kylinos.cn>

Mark sysrq_replay_logs_op as const, preventing accidental modification.

Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
---
 drivers/tty/sysrq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index f85ce02e4725..e9ada1c14e26 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -454,7 +454,7 @@ static void sysrq_handle_replay_logs(u8 key)
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

