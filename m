Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB794165F1A;
	Thu,  2 Oct 2025 14:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759417076; cv=none; b=AOjkRHMIJI2cnId1sWPkJISpiyMEq9b7AOyybQi3fOFypcVMQBvRCo851L8LO+PGu7DTCoBf7eIGJJYmqbjiy1X2AfTsh5/P46G796zWGvnt31QbdmhMveuO9xUA2TP+xGRenyAkomAj3UDgwb49HoE2e4APpm5XaE5ux4JoqLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759417076; c=relaxed/simple;
	bh=u6Lx9QF35BQSo458PLEIGbTD/o5v3/ya3P+BZHwKBfM=;
	h=From:To:Cc:Date:Message-Id:In-Reply-To:References:MIME-Version:
	 Subject; b=W65ISpRvlxIoKDOtquoDZ6jcf8PmRQMBgFfzUw49QSSAP+zUruSJoNACVNAjpqzdi74pQ0KY7NhuFjVvoaEPRKd2rGCPug6MnygX375/x46sWISaGlRcQa/wRpyqKcbr8kwJjIHyitiRRiqgBfvRucrYqOg9HqVNAYYuvCz+E/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=U9J5poAp; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="U9J5poAp"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=04i7Sp88FFJOPgnn3H/zi1ltQiHU4cbmVZhpQuluM14=; b=U9J5poAp5GRqSRpYU24jLj5zTq
	IE7x8hFcHkm37r1YMgHkpJIIeh5Q42jMArUHxGRobkHfNI7yXMLfGKCfYVrURM0GC0SODG9WBLQlt
	57WYETtY0ArhXwkrUytqGpNL4iwfvbb3zgnsCcygd62X2HJWG6Ya/obPd8lvwNbdXEdc=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:59004 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1v4Kkd-0005hy-Ti; Thu, 02 Oct 2025 10:57:48 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	fvallee@eukrea.fr
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	hugo@hugovil.com,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Date: Thu,  2 Oct 2025 10:57:28 -0400
Message-Id: <20251002145738.3250272-6-hugo@hugovil.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251002145738.3250272-1-hugo@hugovil.com>
References: <20251002145738.3250272-1-hugo@hugovil.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
Subject: [PATCH v2 05/15] serial: sc16is7xx: remove unnecessary pointer cast
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

There is no need to cast from a void * pointer, so remove this cast.

Also remove empty line inavertently added in commit d5078509c8b0
("serial: sc16is7xx: improve do/while loop in sc16is7xx_irq()") and
change variables order to follow reversed xmas tree.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/tty/serial/sc16is7xx.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 72e4c4f80f7f5..335695d0e7aa7 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -837,10 +837,9 @@ static bool sc16is7xx_port_irq(struct sc16is7xx_port *s, int portno)
 
 static irqreturn_t sc16is7xx_irq(int irq, void *dev_id)
 {
+	struct sc16is7xx_port *s = dev_id;
 	bool keep_polling;
 
-	struct sc16is7xx_port *s = (struct sc16is7xx_port *)dev_id;
-
 	do {
 		int i;
 
-- 
2.39.5

