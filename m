Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90803542F6;
	Mon, 27 Jul 2026 05:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785131748; cv=none; b=TS9dkv1k6Gh/Oxam8NQwnM9ZzDcoHshng0SFTSMA2Kt7qSiJwntCwPjxDWFGEKY7jizkFnXG6OYhI6gTnzonmmX7/xvfF8R+dZ4fh6dB8RFNNKN/RUQIFXYz6YnZxndaz40oYV5hE64rkW7pS9ksHglEFXpzcACyA6+g8C40mxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785131748; c=relaxed/simple;
	bh=Bqf+0+2Swy7wH+DS4LV2bxRHcdaHqUgJagNG6FOVP7s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=upYASIvg5s8Hdshvg+2ESkP22AQ6eVe7D12xUaIab9UWEwrkEepDX71eUEM+OXeAGDdwiZC7o311IS4U6gOaBzxZM+VLMZHKme5b8cwO5cl7qA7CthyI9WUz7sxYT5hmR3zg3J/bTdqxWhrMwXZGUsBTaodbBT7DyYq4lPyUBPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn; spf=pass smtp.mailfrom=stu.xidian.edu.cn; dkim=fail (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b=sY2A2Bn2 reason="key not found in DNS"; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b="sY2A2Bn2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:MIME-Version:Content-Transfer-Encoding; bh=1wC9AG3c4E
	BYGfI4u/tLs48fxXJA5aqqBYYksoe6MLk=; b=sY2A2Bn2gEj8V6EMnu0gySPXSQ
	vaeFJNrsh3mv0hnzwpgyRAfR6cBH1Z07UiG5ddgLk9fCwfJoyM2R/gibMBNtcPwx
	oEcNAqmKtBPtQhRGXLXkQ7VgojqO8toUMdmjX7ttVa/461BxeLqf3FXpYAa6dy7D
	9ev/VS8+YsurWuao8=
Received: from localhost (unknown [120.221.12.135])
	by hzbj-edu-front-2.icoremail.net (Coremail) with SMTP id BLQMCkBmrjPT8mZqMUeFAQ--.34785S2;
	Mon, 27 Jul 2026 13:55:32 +0800 (CST)
From: Xincheng Wang <22009200607@stu.xidian.edu.cn>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH] tty: limit TCSBRKP break duration
Date: Mon, 27 Jul 2026 13:55:25 +0800
Message-Id: <20260727055525.6170-1-22009200607@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:BLQMCkBmrjPT8mZqMUeFAQ--.34785S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uFy8XFykGFWfGw43Zw45Awb_yoW8ArW3pa
	n8KasIyr45tFW2y393Aan3ua1Fv3WfArWDKFW3K3yavas8Jryakr1fWFZ0qr4kWr4fuFy3
	XrWqqrn8CF17ur7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvab7Iv0xC_tr1lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
	C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq
	07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r
	18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vI
	r41lc2xSY4AK67AK6r4rMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI
	8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AK
	xVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI
	8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280
	aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyT
	uYvjxU4OJ5DUUUU
X-CM-SenderInfo: qssqimasqqliux6v33wo0lvxldqovvfxof0/

An RCU stall was observed while exercising tty ioctls on an
8250 Pericom PCI serial port.

The reproducer passed a very large argument to TCSBRKP. tty_ioctl()
multiplies the argument by 100 and forwards it to send_break(), whose
duration is an unsigned int. That can leave the serial break condition
asserted for an extremely long time and keep the IRQ line active on the
affected setup.

Clamp the duration before calling send_break() so normal values keep
their current behavior, while preventing excessively long break
intervals.

Signed-off-by: Xincheng Wang <22009200607@stu.xidian.edu.cn>
---
 drivers/tty/tty_io.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 6b283fd03..5872b2432 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -2454,6 +2454,21 @@ static int tiocgetd(struct tty_struct *tty, int __user *p)
 	return ret;
 }
 
+#define TTY_BREAK_DEFAULT_MS	250
+#define TTY_TCSBRKP_UNIT_MS	100
+#define TTY_TCSBRKP_MAX_MS	5000
+
+static unsigned int tcsbrkp_duration(unsigned long arg)
+{
+	if (!arg)
+		return TTY_BREAK_DEFAULT_MS;
+
+	if (arg > TTY_TCSBRKP_MAX_MS / TTY_TCSBRKP_UNIT_MS)
+		return TTY_TCSBRKP_MAX_MS;
+
+	return arg * TTY_TCSBRKP_UNIT_MS;
+}
+
 /**
  * send_break - performed time break
  * @tty: device to break on
@@ -2757,7 +2772,7 @@ long tty_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 			return send_break(tty, 250);
 		return 0;
 	case TCSBRKP:	/* support for POSIX tcsendbreak() */
-		return send_break(tty, arg ? arg*100 : 250);
+		return send_break(tty, tcsbrkp_duration(arg));
 
 	case TIOCMGET:
 		return tty_tiocmget(tty, p);
-- 
2.34.1

