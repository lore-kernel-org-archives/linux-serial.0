Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E2D2C15BB;
	Sat,  5 Sep 2026 06:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788591051; cv=none; b=haawi3PzFT/h9wDUWEQzMafOijixOA5t6ouhGUsEmphz/Duw0sO++eIVCl/2DYf+LiSt36BBUQHDFtxqxHt/uQyJ/aXnOnW11SjthvtSDXvErMS8U96sh8l9JR4pEL15JRaYo+9MWhr6UOSxzE8/8Ul7xlF5Hq8O2VEUGvjJ5os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788591051; c=relaxed/simple;
	bh=9C1ZfOoC7dHlhjbpSr1qydCg/5uAk1aS02Q5yg74amE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BJfdWu1VaBRk5Za0d+mWdZ3zqsJezJDOExlfQq8qWhKGe8X6WRCP2C0CaRqdAphf84GH+uG27l5F2ZyYMBh22EzQHwC2BI6sJ9c3K/cY8GemZSqrV7M09G97k5O3jlgPvQ3tvkU+4TE0w6xcc2QjgD2PhqcIyrrSk6gpM/k7mxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hcP8W5fR4zKHMWJ;
	Sat,  5 Sep 2026 14:49:47 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 542A34058F;
	Sat,  5 Sep 2026 14:50:44 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP1 (Coremail) with UTF8SMTPSA id cCh0CgB3YAvCu5tqtCpEAw--.2810S4;
	Sat, 05 Sep 2026 14:50:44 +0800 (CST)
From: Zizhi Wo <wozizhi@huaweicloud.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	npitre@baylibre.com,
	linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	yangerkun@huawei.com,
	chengzhihao1@huawei.com,
	wozizhi@huawei.com
Subject: [PATCH] vt: skip screen update for DEC alignment test on backgroup consoles
Date: Sat,  5 Sep 2026 14:43:37 +0800
Message-ID: <20260905064337.3083103-1-wozizhi@huaweicloud.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgB3YAvCu5tqtCpEAw--.2810S4
X-Coremail-Antispam: 1UD129KBjvJXoWxArWkKw4DWF1Dtr1UtFWxCrg_yoW5WrWrp3
	yFkF1vvws2gr4kZa1qyw45ZFyrA39FqryUurZ3AF47ZF15ZrykWa47ta4kWrZ7XwsakryS
	y3WUZr9YvF1093DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyKb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF
	7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUwxhLUUUUU
X-CM-SenderInfo: pzr2x6tkl6x35dzhxuhorxvhhfrp/

From: Zizhi Wo <wozizhi@huawei.com>

[BUG]
Recently, we encountered a KASAN warning as follows:

BUG: KASAN: slab-out-of-bounds in fb_pad_aligned_buffer+0x11f/0x140
Read of size 1 at addr ff1100015fd9f6a4 by task tty_fbcon_oob/1239
CPU: 7 UID: 0 PID: 1239 Comm: tty_fbcon_oob Not tainted 7.3.0-rc1 #100 PREEMPT(full)
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-4.fc41 04/01/2014
Call Trace:
 <TASK>
 ...
 kasan_report+0xf0/0x120
 fb_pad_aligned_buffer+0x11f/0x140
 ccw_putcs+0x86c/0xa80
 fbcon_putcs+0x338/0x410
 do_update_region+0x21d/0x450
 do_con_write+0x1e0e/0x4880
 con_write+0x13/0x80
 n_tty_write+0x374/0x1010
 file_tty_write.isra.0+0x404/0x7a0
 ...

reproduce:
1) open /dev/tty0, set a KDFONTOP ioctl with op.op = KD_FONT_OP_SET,
op.width = 8 and op.height = 16 (visible VC1)
2) open /dev/tty1, set a KDFONTOP ioctl with op.op = KD_FONT_OP_SET,
op.width = 28 and op.height = 24 (invisible VC2)
3) echo 3 > /sys/devices/virtual/graphics/fbcon/rotate_all
4) write EShash8(esc hash8) to tty1

[CAUSE]
All VCs render to the framebuffer. setfont only modifies the target VC's
font without resizing the framebuffer backing buffer (par->rotated.buf);
the buffer is only resized for the visible VC
(fbcon_do_set_font -> ... -> vc_do_resize -> update_screen). This relies on
the con_should_update() check performed before every update_region().

However, the ESC # 8 path (do_con_trol -> do_update_region) omits the
con_should_update() check. After changing the font size of an invisible VC,
do_update_region() fills using the new font size against a buffer that was
never resized, causing an out-of-bounds access.

[FIX]
Only push the update when the console is visible and not blanked, add
the con_should_update() check in the do_con_trol() like every other call
site of do_update_region() (update_region(), invert_screen(), ...).

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
---
 drivers/tty/vt/vt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 8f467b22b799..901bb2ce01dc 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -2858,11 +2858,12 @@ static void do_con_trol(struct tty_struct *tty, struct vc_data *vc, u8 c)
 			vc->vc_video_erase_char =
 				(vc->vc_video_erase_char & 0xff00) | 'E';
 			csi_J(vc, CSI_J_VISIBLE);
 			vc->vc_video_erase_char =
 				(vc->vc_video_erase_char & 0xff00) | ' ';
-			do_update_region(vc, vc->vc_origin, vc->vc_screenbuf_size / 2);
+			if (con_should_update(vc))
+				do_update_region(vc, vc->vc_origin, vc->vc_screenbuf_size / 2);
 		}
 		return;
 	case ESsetG0:	/* ESC ( */
 		vc_setGx(vc, 0, c);
 		vc->vc_state = ESnormal;
-- 
2.52.0

