Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0E52AF10;
	Tue,  3 Sep 2024 02:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725331166; cv=none; b=SQonFGGTk6VQpHj96h6bzk7w9TVdm2o7m8oiIEPY6Agt1JOmVAraCYvyhi5rEM3LQu9V4zQU/Zh7maDy5u8Q4v5UMQ2JBV23lcoDGxqihpwkYqUqslbQu9PHkxGEu1g0uJCtAcH4Ld+joHtGpeHa1IJxVSzloweWNjpPBwI8HIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725331166; c=relaxed/simple;
	bh=9msTVneaFggEOnc0HgRFAawmBb/KlQYldhtAtEmevK0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cAWSU1Brr1qI2NdI2CMTsmeG6i5dnN7jOMD8ZgSSvqTMP1NkMDCFv/yPfpLeWJZjdPHvLxsMjVJpP/HXRAtABzdXEZNoMPU4oN0j/duEEoGVfNoR8lsqaqay9c2C7RtEWwQmZOR2GPIBj1Po5RpEaSGYAd5PCQ0on5z8lFvbxHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-01 (Coremail) with SMTP id qwCowABH+ajRdtZm+a60AA--.35457S2;
	Tue, 03 Sep 2024 10:39:14 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: jirislaby@kernel.org,
	gregkh@linuxfoundation.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] mxser: convert comma to semicolon
Date: Tue,  3 Sep 2024 10:37:54 +0800
Message-Id: <20240903023754.493568-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowABH+ajRdtZm+a60AA--.35457S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Jw4UZF15Zr47GrykKF4xtFb_yoWxuFg_C3
	4kGws2vF10kr1v9wn8J34rurySv34ruF4kX3Wv9FZ0kay7Aws5WrWkXrsrJr98urySkF9x
	Jr4DCryxXF47WjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbfkFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26F
	4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02
	628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE14v_Gr1l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUovtCDUUUU
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

Replace a comma between expression statements by a semicolon.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 drivers/tty/mxser.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index 6cfef88a18e3..4d45eca4929a 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -983,7 +983,7 @@ static int mxser_get_serial_info(struct tty_struct *tty,
 	ss->baud_base = MXSER_BAUD_BASE;
 	ss->close_delay = close_delay;
 	ss->closing_wait = closing_wait;
-	ss->custom_divisor = MXSER_CUSTOM_DIVISOR,
+	ss->custom_divisor = MXSER_CUSTOM_DIVISOR;
 	mutex_unlock(&port->mutex);
 	return 0;
 }
-- 
2.25.1

