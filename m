Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348E180A;
	Mon, 15 Jan 2024 08:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iie.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iie.ac.cn
Received: from localhost.localdomain (unknown [159.226.43.30])
	by APP-01 (Coremail) with SMTP id qwCowACXnraT6qRlgmlRBw--.48870S2;
	Mon, 15 Jan 2024 16:19:32 +0800 (CST)
From: Jingzi Meng <mengjingzi@iie.ac.cn>
To: gregkh@linuxfoundation.org
Cc: jirislaby@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH] tty: change the privilege required for tty operarions
Date: Mon, 15 Jan 2024 16:24:20 +0800
Message-Id: <20240115082420.13372-1-mengjingzi@iie.ac.cn>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <2024010247-polio-brittle-1b23@gregkh>
References: <2024010247-polio-brittle-1b23@gregkh>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowACXnraT6qRlgmlRBw--.48870S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ur4rCrW3Gr1rZF15tF47Arb_yoW8AF1kpa
	1rCw4jyw45trW7GFn2ya9a9FyrXFZayF9rKa4rKayavFn8C34jk3s5Aryj9F1rJr4xGrnx
	A34q9Fy5X3ZFvwUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUk0b7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4
	A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
	w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r4j6F4UMc
	vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY02Avz4vE14v_GFyl42xK82IY
	c2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s
	026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF
	0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0x
	vE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
	6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUy_WFUUUUU
X-CM-SenderInfo: pphqwyxlqj6xo6llvhldfou0/1tbiDAYRE2Wk5CIZfAAAsq

Currently, CAP_SYS_ADMIN is responsible for tty-related functions in
tty_ioctl(): TIOCSTI, TIOCCONS, TIOCVHANGUP. CAP_SYS_ADMIN is already
overloaded, change it to CAP_SYS_TTY_CONFIG for a more fine-grained
and accurate access control.

Signed-off-by: Jingzi Meng <mengjingzi@iie.ac.cn>
---

The userland api affected by this change is the ioctl system call,
especially when the second argument is TIOCSTI, TIOCCONS, TIOCVHANGUP,
which now requires sys_tty_config instead of sys_admin. Tested on Debian
with kernel 6.7.0-rc5.

 drivers/tty/tty_io.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index f3ca2105b66d..c81479366317 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -2286,7 +2286,7 @@ static int tiocsti(struct tty_struct *tty, u8 __user *p)
 	if (!tty_legacy_tiocsti && !capable(CAP_SYS_ADMIN))
 		return -EIO;
 
-	if ((current->signal->tty != tty) && !capable(CAP_SYS_ADMIN))
+	if ((current->signal->tty != tty) && !capable(CAP_SYS_TTY_CONFIG))
 		return -EPERM;
 	if (get_user(ch, p))
 		return -EFAULT;
@@ -2390,7 +2390,7 @@ static int tiocswinsz(struct tty_struct *tty, struct winsize __user *arg)
  */
 static int tioccons(struct file *file)
 {
-	if (!capable(CAP_SYS_ADMIN))
+	if (!capable(CAP_SYS_TTY_CONFIG))
 		return -EPERM;
 	if (file->f_op->write_iter == redirected_tty_write) {
 		struct file *f;
@@ -2719,7 +2719,7 @@ long tty_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	case TIOCSETD:
 		return tiocsetd(tty, p);
 	case TIOCVHANGUP:
-		if (!capable(CAP_SYS_ADMIN))
+		if (!capable(CAP_SYS_TTY_CONFIG))
 			return -EPERM;
 		tty_vhangup(tty);
 		return 0;
-- 
2.20.1

