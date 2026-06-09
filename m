Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948CA3ADB98
	for <linux-serial@vger.kernel.org>; Tue,  9 Jun 2026 22:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781044661; cv=none; b=PgcS6UaJNdhgjJTLR/iZ5HjQDCBXYfm6DpjH1YFKG5DCw1RQU7BQogs2yGkuxqRPB9DQjGUqMLOSLuqz0g3/wNhKoRda9i+cvwM1pRbgIdIn8GUCv4jFgY0Q7nYa+6fJXDAkuFrP+Ur0E4gBqTUZbRS2KVbxrdu+WCJhxskz3HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781044661; c=relaxed/simple;
	bh=p6T47j0sgurR4ZBcE//kHSmTLcJbYcotQm4TC59HSdg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ufvubHhE2yn5LAoAThu81J2fTKLakR7k1dirov4tp8/kMdWVjFKrP5ZkTf5k1zIdpUsmjVjSVuYOhBDgUnSDdxKqYTEHCINv2mLiVGS+6DWCg2WPH9qhlssnJd9jGiD4MCiIPiS2enGMYAsuF6FlrLq9enM6XSDs+pmQiGZfDuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PJAKcgjD; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PJAKcgjD"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2c0aa420401so47201935ad.3
        for <linux-serial@vger.kernel.org>; Tue, 09 Jun 2026 15:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781044656; x=1781649456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VyOCvdsh8YypBK5E0bOL+yIMik+oVX3UIIjhIbRiDp8=;
        b=PJAKcgjD2BqclLkR7GIS5RN55MbKh/wk35IS6oxvTszVb+xZxlPJ6Z1KKkQxDYhkUp
         4CNOmobXC7mSMF5Zb2Ob5ZpvzkzBHgBAZFxrrGQS/GTjYdQFW+f3JJCYG3cfMi5oFJhC
         VA39BujhfiT6yI0lZcsl+yl8sVRMpsjOCO+QNNTINr7D6f0fAm+rEmLBCJ6a0EgPNR5X
         OYAw9rvTfy+761mHfKKr5OTMKKGWVIH6yesO0+JK0nUHn7gFMmd6sGLHQdJbW7BZQXd6
         MykondYFI55lFQIyPl+pqoE+VwkPhHrtW9AeHvgQxcJ29vwvob1hIfwD8VbkLiSIkXrU
         lKBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781044656; x=1781649456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VyOCvdsh8YypBK5E0bOL+yIMik+oVX3UIIjhIbRiDp8=;
        b=W4OOUVh89Ix2sIn6R9FT+W+OvdgRr0ahhW4U7ELcmEzCnN3C+ujcvCfeD5BqSI8C9U
         uLhHVHt82gB4AQtTLrCTzs0/kO37xZjaFEAvw/AON6zpo6Ue7ITOhFAc+s0G6YYaLWd2
         /l+knYwn8AQn67koPURcFdxGPNj/BGyzKvTir1J0vhN7sub1s9nsPbLoWUNWHW8rwRyY
         zw7CsvlfILZUNlF9VZRkrUV2hXveXdormmSLq8rVppMfIA/ChlweaBl9KcGSXSD5DB9N
         CX+QAe7gCAtdruYYyjTaS8YwT9IaSTFotfYDThhTHA/OZFAoZsH7JvyQtvGNrWZT0geM
         JOzA==
X-Gm-Message-State: AOJu0YwDkOPjXgbBw3HS3VwLvvlFKx5g4uPkPzq+/N66TZeuPfyTajah
	/6TazL2rjl753WA+8YlG3MLEGxCThzSVYMHL4YGujO765GzcVMLuKDKULN0D4r9f
X-Gm-Gg: Acq92OH8P6NpHq4EVw8KXmr5sb+zAviCS8fBiwwZpG9NNX7aXOHIpVi+/LbKW6mvWut
	mHAas8pkKizt9+D5574Nx0lAXhkAFybPELRgUQBX0KV+EoRyZ01ln3wE995Y++qHOl5YVWSYsqA
	hrfHZpOrdKcWNO5ZwKDha22gx1M/FvoJ9xRdezC14MMy5RcLCRdAMJ/qjZpzo3XfNMtIweSxr4j
	asSO5VUyAvjVpU4sW4eXXm9+KLJOX4UApH85KS+2N/pxs9BGllzlpoLe1rx9XDG55QWYMcpG6WE
	Nr5Mc6sSpKd/zmWhuGgTr9STRtctL8mnrSl6Hht8OC2mQuP4Tof/fuqYSGW2kxQaud90cZqU7Jh
	MrYX5xwRuDXZESCsuVfhK4l4hIedaZPdOZwfkbn2ExVXX81J9qpBR2AJTZ7lyuDGnJqM2Uw9ApP
	j5ku17caN35/ElO8QcHxWPiwL5e6nXzGpgbc53bQ4PdVd6xpfrL0Uezen3QxTUhnY/FoiSrVfda
	PyYLF2chl4/0qxPSiRoGUn8fpKKbxaD9i215XIIRF6ePhwwrTHICXdF
X-Received: by 2002:a17:903:19ef:b0:2c1:5667:2740 with SMTP id d9443c01a7336-2c1e810bd1fmr283197445ad.21.1781044655930;
        Tue, 09 Jun 2026 15:37:35 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f6d37esm293750655ad.9.2026.06.09.15.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 15:37:35 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	linux-kernel@vger.kernel.org (open list:TTY LAYER AND SERIAL DRIVERS),
	imx@lists.linux.dev (open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE)
Subject: [PATCHv2 1/4] serial: mxs-auart: fix cast type for of_device_get_match_data
Date: Tue,  9 Jun 2026 15:37:14 -0700
Message-ID: <20260609223717.41670-2-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260609223717.41670-1-rosenp@gmail.com>
References: <20260609223717.41670-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

of_device_get_match_data returns const void*. Cast to unsigned long to
avoid implicit integer truncation warnings. All the data parameters are
correct anyway.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/tty/serial/mxs-auart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index 697318dbb146..de97c0f74e7d 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -1598,7 +1598,7 @@ static int mxs_auart_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	s->devtype = (enum mxs_auart_type)of_device_get_match_data(&pdev->dev);
+	s->devtype = (unsigned long)of_device_get_match_data(&pdev->dev);
 
 	ret = mxs_get_clks(s, pdev);
 	if (ret)
-- 
2.54.0

