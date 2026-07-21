Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D7538D3E5;
	Tue, 21 Jul 2026 14:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784645073; cv=none; b=ZwpRHoo2GLvitTtDayGB63QRWNXy0KoTTkOJT4wuF7h3K491D2IZ5OWb2/nAy1KNgvKXHY+wua8phyzIh444+GmTPI0OArOXRVQpjB2BlZPO3WDh5EyVFvyj2I70OkI1+3uDSj/J+TtI3+TjAeT1+6Y54g1tq26V8aHyKZhqQYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784645073; c=relaxed/simple;
	bh=3K5JeMCkaD0ACmdutbLkLSj4m18l9QfGI4ANBpbaZfs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ih5CDZWQ7xdxqQh3t+uQ3Z9oqWHsmA2GYsbRATpEc5OgitKxYWzLTmGJIos9FsOHdsqBOiYMczf1k5nucJQn4a3OT93ZCkS/Cog0tU3t6j5Vn1Ga0ssInWITQDln7eLr60F6n409OtMARfISfJpM4HASdbxL2+IHgF6SdxyFpqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=GMruAK0+; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="GMruAK0+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject
	:Cc:To:From:subject:date:message-id:reply-to;
	bh=XQ4y9x+1joreqVcUaD5dm7l7EJYJqmH225zVoLPFldw=; b=GMruAK0+xtQkRs0ZAlqoFc3K9B
	DO6pBNJp7+jkQnYH/YBDqy+tKOhgTkbdYm+4ZFFn+m2B+stf3C5z8pp813Wc8adUTNa7rduhdgjvK
	CyScsNwE/n06q2GPL0/RLq7Uo9hCqxUVLiejerwkHU/c7OXaGjENwI9I/eEVvWfv6XyA=;
Received: from [184.161.19.61] (helo=pettiford.lan)
	by mail.hugovil.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1wmBhm-000000001oy-2ipb;
	Tue, 21 Jul 2026 10:44:22 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: hugo@hugovil.com,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH] serial: max310x: remove always included kconfig.h
Date: Tue, 21 Jul 2026 10:44:17 -0400
Message-ID: <20260721144420.3727708-1-hugo@hugovil.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam_score: -1.0
X-Spam_bar: -

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

The inclusion of <linux/kconfig.h> in commit f18643843bc6 ("serial:
max310x: fix compile errors if CONFIG_SPI_MASTER is disabled") is
unneeded as it's guaranteed by the build starting from the commit
2a11c8ea20bf ("kconfig: Introduce IS_ENABLED(), IS_BUILTIN() and
IS_MODULE()"). Remove it here.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/tty/serial/max310x.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 41a7bff941c17..9e62778e41913 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -16,7 +16,6 @@
 #include <linux/device.h>
 #include <linux/gpio/driver.h>
 #include <linux/i2c.h>
-#include <linux/kconfig.h>
 #include <linux/module.h>
 #include <linux/property.h>
 #include <linux/regmap.h>

base-commit: 782f4dbd1794b4f30dc116a7ca42c5962c409be8
-- 
2.47.3

