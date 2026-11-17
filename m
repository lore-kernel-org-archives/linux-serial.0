Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794906758;
	b=On5/cuIEToOw9Yr8ixu99pb7qyQVgUmwl9A7j2Ar5PSjAFBa1iryYIHV+wWlLjM/PRJ2
	 WyS38uoB+gxttBVbcSAH2tPsE/F6V7QR3z+4DkVCSOBpPWVTp0m2vg70Dj+LVwVTaxGJc
	 Oe02VgmZTHNmXFtgfrU8tL03tR7416FWrZ/CRFTyhAtVd3aTHbF8wMlQakHnxRQjUfKwH
	 Y5ru0U4TCDMVSw7kZ8feO3wy3+lDCQhZQdjEWpuxOV60vllgAtq9fHFfPUIbMVmBwbUEE
	 1J84Q/ZSsZMENt7BmcehJj9OniDepJBtgey1gUV18+KajjmL18kBLY2tJ24NnNL7rnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794906758;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=z8hDHvdaTIwLdEqLBOLWaztzJQugW8MazJQFSuSlBig=;
	b=ln7RlMMqIql16xM3BRMyRu8iMDbILPAorGYATzUM8ke1vX/Y4lgiXZooyzQ782gE//HG
	 4Q8P3x69awHxxqeaN6yvR9/AZ+uimV7WG+b8VqygccMeI+JtYQIKRMPJaMHgiPsJOmfFc
	 CfN0+uNp2MPMV8/sXqXnDElsnYffjy353wXJeLS9EUtsz3F4NulL5o5/KrgkLKDFOzhls
	 vse1maReM6qCWql+0uoQ2SrbJCI1qdRwWVnqBUpP8TFlxuDtWlNzd63i+a9tXNlgzmKh2
	 nCjQffX05W+viGxJhHA3t3JVSIOYPeIhxWPNbx8J4VD+at91E+FZ1bHJnbgz+py308Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D58606A31C;
	Tue, 17 Nov 2026 09:12:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 13D58606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:MIME-Version:Content-Transfer-Encoding; bh=z8hDHvdaTI
	wLdEqLBOLWaztzJQugW8MazJQFSuSlBig=; b=vHbqfclV0bubiCjIZ2FfsLzUHc
	YcS/9vE0LvAEzvvCC9zq9p36IFDizNdLOtP5bUSbk8PFq8C0GcPX7V2vYJD8jE43
	BLlkrGDn4SL91kmjO6t6c5HMUGE/k4hSdRa39SyF/eAzKkYlpVhvMenLWluvwWQe
	on/cliDaZ2yZExay0=
Received: from LAPTOP-FRMFRHCN.localdomain (unknown [240e:456:1000:aaf5:8952:40b1:8a4c:314f])
	by hzbj-edu-front-3.icoremail.net (Coremail) with UTF8SMTPA id BbQMCkCGifxqGvxqsGDEAQ--.58980S2;
	Tue, 17 Nov 2026 17:12:11 +0800 (CST)
From: Haoli Zhang <26031212468@stu.xidian.edu.cn>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	syzbot+2932e8970a6398db95c3@syzkaller.appspotmail.com,
	25031212117@stu.xidian.edu.cn,
	byu@xidian.edu.cn,
	Haoli Zhang <26031212468@stu.xidian.edu.cn>
Subject: [PATCH] tty: vt: protect tty lifetime in keyboard path
Date: Tue, 17 Nov 2026 17:12:07 +0800
Message-Id: <20261117091207.3950936-1-26031212468@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:BbQMCkCGifxqGvxqsGDEAQ--.58980S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAr1fZw15Jw1xArWxCw18AFb_yoW5XF43pF
	43Gr9ava98tF4DWFs0kr43XFWav3Z3tay7KryYy3s5uFn0vr1rCw43K39Y9Fn8ZrykAry5
	JF1UKrW5uF47XrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9K14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
	1j6F4UJwAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
	FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr
	0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8v
	x2IErcIFxwCY1x0262kKe7AKxVWUAVWUtwCY02Avz4vEIxC_GFWl42xK82IYc2Ij64vIr4
	1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK
	67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI
	8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAv
	wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14
	v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU1FApUUUUU
X-CM-SenderInfo: yswqjiasrskluy6v33wo0lvxldqovvfxof0/1tbiAgUAEWr7HsjakQAAsa

The KASAN report reaches stop_tty() through fn_hold(). That handler
reads vc->port.tty and uses it without holding a tty reference. It runs
under kbd_event_lock, while con_shutdown() clears the port association
under console_lock; these locks do not protect the tty lifetime.

Use the tty_port_tty guard in fn_hold() and keep the reference until
start_tty() or stop_tty() returns. Keep kbd_keycode()'s existing tty
reference interval unchanged.

Use tty_port_tty_set() when installing and clearing the association so
that updates use the same port lock as guarded reads and the port holds a
tty reference while the association is active. A keyboard operation
that already obtained a reference can then finish safely after shutdown
clears the association.

Reported-by: syzbot+2932e8970a6398db95c3@syzkaller.appspotmail.com
Closes: https://syzbot.org/bug?extid=2932e8970a6398db95c3
Co-developed-by: Jinning Zhang <25031212117@stu.xidian.edu.cn>
Signed-off-by: Jinning Zhang <25031212117@stu.xidian.edu.cn>
Co-developed-by: Bin Yu <byu@xidian.edu.cn>
Signed-off-by: Bin Yu <byu@xidian.edu.cn>
Signed-off-by: Haoli Zhang <26031212468@stu.xidian.edu.cn>

---
 drivers/tty/vt/keyboard.c | 34 ++++++++++++++++++++--------------
 drivers/tty/vt/vt.c       |  4 ++--
 2 files changed, 22 insertions(+), 16 deletions(-)

--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -509,20 +509,26 @@
 
 static void fn_hold(struct vc_data *vc)
 {
-	struct tty_struct *tty = vc->port.tty;
-
-	if (rep || !tty)
-		return;
-
-	/*
-	 * Note: SCROLLOCK will be set (cleared) by stop_tty (start_tty);
-	 * these routines are also activated by ^S/^Q.
-	 * (And SCROLLOCK can also be set by the ioctl KDSKBLED.)
-	 */
-	if (tty->flow.stopped)
-		start_tty(tty);
-	else
-		stop_tty(tty);
+	struct tty_struct *tty;
+
+	if (rep)
+		return;
+
+	scoped_guard(tty_port_tty, &vc->port) {
+		tty = scoped_tty();
+		if (!tty)
+			return;
+
+		/*
+		 * Note: SCROLLOCK will be set (cleared) by stop_tty (start_tty);
+		 * these routines are also activated by ^S/^Q.
+		 * (And SCROLLOCK can also be set by the ioctl KDSKBLED.)
+		 */
+		if (tty->flow.stopped)
+			start_tty(tty);
+		else
+			stop_tty(tty);
+	}
 }
 
 static void fn_num(struct vc_data *vc)
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -3756,7 +3756,7 @@
 		return ret;
 
 	tty->driver_data = vc;
-	vc->port.tty = tty;
+	tty_port_tty_set(&vc->port, tty);
 	tty_port_get(&vc->port);
 
 	if (!tty->winsize.ws_row && !tty->winsize.ws_col) {
@@ -3789,7 +3789,7 @@
 	BUG_ON(vc == NULL);
 
 	guard(console_lock)();
-	vc->port.tty = NULL;
+	tty_port_tty_set(&vc->port, NULL);
 }
 
 static void con_cleanup(struct tty_struct *tty)

