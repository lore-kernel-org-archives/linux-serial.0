Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795056144;
	b=gk7kSHPmJDiR/gKOn9RvBhrevlGV5Nj/f+21KQhjulhHD+Htji+Pe+cRy/cr+UKGojbW
	 2KAeJ7qVv49I4cMvd5qmSyfU2q0h7599G0qJSiR8E6CBlmaqI4n80UWBPo8kgr/Mxhi8M
	 t3I61dpnsN/G9rUC7e+6xZWLi8B5pmiZDXZnAsFdTi/J+/B9JdB2TW7hW+TY82sYF93kK
	 nCtTj1p2gVtcXVnrnKds5adQKAndAr8jKhLj3YYNB4DkWwHz9Ui4mSq4o/OVKLMUlfi3E
	 Nf2r1HYs9HSo+V3n9Ti1TnElzT+E3DdafVH0d5cDHwdpRw1CH88LK+rTPqtSaEoBF3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795056144;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=0UHONv6XZ5YVOH+emyeIk5Od/CX3XfUTlsIPPCzxbBA=;
	b=Jobi6tYdoL1KJNQYToCEYb9i+noqL4XbHp9ED4VayooBxXrvDseAkta9eBDCxeScxVMC
	 8u+LsuAqU8bNr1Ur0QpDtPWdUu2Y7nhatayBm+KYzafbainymyDlTgWKJ7a7XeDavssMg
	 45GOjS1rlBOaHA/FeytVmiXDokaffp/rGOifXyQ1WtG40rULuhXDFFOjpQZ0Q46T/+8s3
	 hrM6QWq0lha5IdVW/Q4GFq8O1NVgv1+Ug00PmufDal1crkpZO70FeDj/POxDu3qNXnXyR
	 ctpop/LDTMMi5+XD/RbgSAN7AVttn7VHchwo3srFn8tZcvrwtdnNfVfzMCqVt4n0b/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95E5606A31C;
	Thu, 19 Nov 2026 02:42:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A95E5606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:MIME-Version:Content-Transfer-Encoding; bh=0UHONv6XZ5
	YVOH+emyeIk5Od/CX3XfUTlsIPPCzxbBA=; b=WpHoVBS3R3OvUOQWMNN7UO2vfd
	g/0aEzEv1L30vHHRlFTlBQuVrm9+yhw8PYEf03mGkDL1RjGVvXv3+44mkgaPJMxi
	FFPrcM2+zusn3/62fUJ2NpfUzKtekZuz+FPxtta9dCpjzLjHZ0tYyXgscZ/i/3Kt
	dWCl+SNasB9uU/OJc=
Received: from LAPTOP-FRMFRHCN.localdomain (unknown [2408:8670:ae1:0:ec52:1f40:2f6a:587a])
	by hzbj-edu-front-2.icoremail.net (Coremail) with UTF8SMTPA id BLQMCkBGif4CYv5qtPDdAQ--.1654S2;
	Thu, 19 Nov 2026 10:42:12 +0800 (CST)
From: Haoli Zhang <26031212468@stu.xidian.edu.cn>
To: gregkh@linuxfoundation.org
Cc: jirislaby@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	syzbot+2932e8970a6398db95c3@syzkaller.appspotmail.com,
	25031212117@stu.xidian.edu.cn,
	byu@xidian.edu.cn,
	Haoli Zhang <26031212468@stu.xidian.edu.cn>
Subject: [PATCH v2] tty: vt: protect tty lifetime in keyboard path
Date: Thu, 19 Nov 2026 10:42:07 +0800
Message-Id: <20261119024207.4075962-1-26031212468@stu.xidian.edu.cn>
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
X-CM-TRANSID:BLQMCkBGif4CYv5qtPDdAQ--.1654S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWw13uF1kWF4DJF4rWFWrAFb_yoW5AFWUpF
	4UJr92va98tF4kXa1aqr15XFW3uan3Kay7Kry3A34rZrn0vryrCw4ft3yrurn8ZrZ5AFy5
	JFn8GrW5uF4xXrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8JV
	W8Jr1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
	F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
	4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I
	648v4I1lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
	v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
	1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
	AIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI
	42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxh
	VjvjDU0xZFpf9x0JUvg4fUUUUU=
X-CM-SenderInfo: yswqjiasrskluy6v33wo0lvxldqovvfxof0/1tbiAQUCEWr9v1huPgAAs3

I apologize for the v1 patch. It included a NULL check inside the
conditional tty_port_tty guard, even though the guard skips its body when
no tty is associated. That check was redundant and made the guard usage
unclear. I have removed it in this version.

fn_hold() reads vc->port.tty and calls start_tty() or stop_tty() without
holding a tty reference. kbd_event_lock serializes keyboard event
processing, but it does not protect the tty lifetime against
con_shutdown() clearing the port association.

Use the tty_port_tty guard in fn_hold() to obtain a reference and keep it
until start_tty() or stop_tty() returns. Use tty_port_tty_set() when
installing and clearing the association, so tty lookup and association
updates are serialized by the port lock. fn_hold() keeps the tty
reference until the start/stop operation completes.

Reported-by: syzbot+2932e8970a6398db95c3@syzkaller.appspotmail.com
Closes: https://syzbot.org/bug?extid=2932e8970a6398db95c3
Co-developed-by: Jinning Zhang <25031212117@stu.xidian.edu.cn>
Signed-off-by: Jinning Zhang <25031212117@stu.xidian.edu.cn>
Co-developed-by: Bin Yu <byu@xidian.edu.cn>
Signed-off-by: Bin Yu <byu@xidian.edu.cn>
Signed-off-by: Haoli Zhang <26031212468@stu.xidian.edu.cn>
---
Changes in v2:
- Remove the redundant NULL check inside the conditional tty_port_tty guard.

 drivers/tty/vt/keyboard.c | 26 ++++++++++++++------------
 drivers/tty/vt/vt.c       |  4 ++--
 2 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -510,17 +510,19 @@
 static void fn_hold(struct vc_data *vc)
 {
-	struct tty_struct *tty = vc->port.tty;
-
-	if (rep || !tty)
+	if (rep)
 		return;
 
-	/*
-	 * Note: SCROLLOCK will be set (cleared) by stop_tty (start_tty);
-	 * these routines are also activated by ^S/^Q.
-	 * (And SCROLLOCK can also be set by the ioctl KDSKBLED.)
-	 */
-	if (tty->flow.stopped)
-		start_tty(tty);
-	else
-		stop_tty(tty);
+	scoped_guard(tty_port_tty, &vc->port) {
+		struct tty_struct *tty = scoped_tty();
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
diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -3759,7 +3759,7 @@
 		return ret;
 
 	tty->driver_data = vc;
-	vc->port.tty = tty;
+	tty_port_tty_set(&vc->port, tty);
 	tty_port_get(&vc->port);
 
 	if (!tty->winsize.ws_row && !tty->winsize.ws_col) {
@@ -3792,7 +3792,7 @@
 	BUG_ON(vc == NULL);
 
 	guard(console_lock)();
-	vc->port.tty = NULL;
+	tty_port_tty_set(&vc->port, NULL);
 }
 
 static void con_cleanup(struct tty_struct *tty)

