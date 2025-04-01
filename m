Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A091DED72;
	Tue,  1 Apr 2025 08:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743494677; cv=none; b=ow/sHMKYVlxFPNr9angb+o/GbQ32nJIBRvNdFHanhqOJwNL6xbpYcQicj9qpLhCycOLalsvHlcOyNoGys+lAlNmhVRk9JuUj6AOXeroNioB5EcIK9lbFEt8+3fK1hkV9GGVk0K58ahmEUsd54m/CeI+EHKtAR+tU65jRy9/bUPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743494677; c=relaxed/simple;
	bh=DVLlLbfeotFU8qB5CxtUAkVjIGiFbSUTgWIjBFU/ias=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PcORg7ckVEXmTXdEYf9sLu7lO3L1bbVL8rJNqi9Ii+N/OQq+vMJcXwc5bYexyy5Z5S88HdWgZEiCzgVopgswcSiFvKmGQPD7rz+UFQErLyA+/0gp8veCR6KMJBqF27r+fCpaIwAYyxtwf+aoVCsrKozx2N+HIU+iGx8em/NKFg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-01 (Coremail) with SMTP id qwCowAB3IAEEnutn9MenBA--.60S2;
	Tue, 01 Apr 2025 16:04:20 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	u.kleine-koenig@baylibre.com
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] serial: lantiq: Remove unnecessary print function dev_err()
Date: Tue,  1 Apr 2025 16:03:37 +0800
Message-Id: <20250401080337.2187400-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAB3IAEEnutn9MenBA--.60S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZrWrWF43Xw48tF18AF18Xwb_yoW3XwcEk3
	WkCasFgr4rCrs5tw1Ut3y3uFy2v3WDZF4ruF1vqa93X34UAFWkXryqvFnrXw4kW3yUAry3
	Grnrur1akF4SkjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbskFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s
	1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0
	cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r4UJVWxJr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	AVWUtwCY02Avz4vE14v_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
	1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
	14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
	IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E
	87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73Uj
	IFyTuYvjfU00eHDUUUU
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

Function dev_err() is redundant because platform_get_irq()
already prints an error.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 drivers/tty/serial/lantiq.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/tty/serial/lantiq.c b/drivers/tty/serial/lantiq.c
index 58a3ab030d67..62cd9e0bb377 100644
--- a/drivers/tty/serial/lantiq.c
+++ b/drivers/tty/serial/lantiq.c
@@ -773,10 +773,8 @@ static int fetch_irq_intel(struct device *dev, struct ltq_uart_port *ltq_port)
 	int ret;
 
 	ret = platform_get_irq(to_platform_device(dev), 0);
-	if (ret < 0) {
-		dev_err(dev, "failed to fetch IRQ for serial port\n");
+	if (ret < 0)
 		return ret;
-	}
 	ltq_port->common_irq = ret;
 	port->irq = ret;
 
-- 
2.25.1

