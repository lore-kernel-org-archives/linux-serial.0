Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCD125A324;
	Fri, 17 Oct 2025 07:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760687830; cv=none; b=ls1s/FB82HxdumD6pryaFmPDyI4fyn4E+1Wh2R8Vp72z3RB4D+2qqeocgCe5bcD57CYKmrkwwAIH5xhoxbPR8P8sqd+5lxKLQvYR28MNCnWiq962UM3CeyN1vOsHq5rSkyRl3i0LufPc41B9CrZa+wx0pUKXcYUIHfA4e/q1U/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760687830; c=relaxed/simple;
	bh=04WdpqAHHBESmwX84fCl/DLXMd5UNFF0XZeankQ6mG0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ppMGt5Dh5/uOAwizQm4Hw8D6t5VHBG2nmIozVr8R2cJP+qgUGcD6wQv+d+z2ZdLNWmZiMsyS0ttxL3oGG3cHlRviN/CnQeQUOgnf3yBuECWiixMPUwwxSiEO/lUwBVHcnxO2hhdldGpCKqvZZiykLPlJ2RW6a001kQEshJPehq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: dcb5b78aab2e11f0a38c85956e01ac42-20251017
X-CID-CACHE: Type:Local,Time:202510171554+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:00906c65-4c51-445f-b49b-df5eb5628976,IP:0,UR
	L:0,TC:0,Content:-25,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:242744f724db5f2861f1a6757faf0424,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|850,TC:nil,Content:0|50,EDM:5,
	IP:nil,URL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:
	0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: dcb5b78aab2e11f0a38c85956e01ac42-20251017
Received: from localhost [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <pengyu@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 416228460; Fri, 17 Oct 2025 15:57:00 +0800
From: Yu Peng <pengyu@kylinos.cn>
To: tj@kernel.org
Cc: changlianzhi@uniontech.com,
	dmitry.torokhov@gmail.com,
	gregkh@linuxfoundation.org,
	jiangshanlai@gmail.com,
	jirislaby@kernel.org,
	legion@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	lkp@intel.com,
	mingo@kernel.org,
	myrrhperiwinkle@qtmlabs.xyz,
	oe-lkp@lists.linux.dev,
	oliver.sang@intel.com,
	pengyu@kylinos.cn,
	syzbot+79c403850e6816dc39cf@syzkaller.appspotmail.com,
	tglx@linutronix.de
Subject: [PATCH v3 2/2] tty/vt: Fix possible deadlock in input_inject_event
Date: Fri, 17 Oct 2025 15:56:55 +0800
Message-Id: <20251017075655.3781522-2-pengyu@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251017075655.3781522-1-pengyu@kylinos.cn>
References: <aOVnoCnHa2vzB54g@slm.duckdns.org>
 <20251017075655.3781522-1-pengyu@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzkaller testing revealed a potential deadlock involving keyboard
handling:

CPU0                       CPU1                      CPU2
----                       ----                      ----
read_lock(tasklist_lock);  evdev_write
                          input_inject_event     write_lock(tasklist_lock);
                         lock(&dev->event_lock);
                        read_lock(tasklist_lock);
<Interrupt>
kbd_bh() / kd_sound_helper()
input_inject_event
lock(&dev->event_lock); // Deadlock risk

The deadlock occurs because:
1. Both kbd_bh and kd_sound_helper run in interrupt context
2. tasklist_lock is interrupt-unsafe
3. When evdev_write holds both dev->event_lock and tasklist_lock,
   interrupt context attempts to acquire dev->event_lock create deadlock
   risks

Convert both kbd_bh and kd_sound_helper to use workqueues. This moves
input_inject_event execution to process context, where it's safe to
acquire locks that may be held by code using interrupt-unsafe locks.

Reported-by: syzbot+79c403850e6816dc39cf@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/66f6c8ce.050a0220.46d20.001c.GAE@google.com/T/#u
Fixes: fb09d0ac0772 ("tty: Fix the keyboard led light display problem")

Signed-off-by: Yu Peng <pengyu@kylinos.cn>
---
Hi, tejun
Thank you for pointing that out. I'll make sure to use the proper format in 
future submissions.
---
Changes in v3:
  - use the correct signature format.
Changes in v2:
  - enable_work needs to be used in pairs with disable_work_sync,
    not with cancel_work_sync.
---
 drivers/tty/vt/keyboard.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index ee1d9c448c7e..d3d9c2fda467 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -131,8 +131,8 @@ static const unsigned char max_vals[] = {
 
 static const int NR_TYPES = ARRAY_SIZE(max_vals);
 
-static void kbd_bh(struct tasklet_struct *unused);
-static DECLARE_TASKLET_DISABLED(keyboard_tasklet, kbd_bh);
+static void kbd_bh(struct work_struct *unused);
+static DECLARE_WORK_DISABLED(keyboard_work, kbd_bh);
 
 static struct input_handler kbd_handler;
 static DEFINE_SPINLOCK(kbd_event_lock);
@@ -264,23 +264,23 @@ static int kd_sound_helper(struct input_handle *handle, void *data)
 	return 0;
 }
 
-static void kd_nosound(struct timer_list *unused)
+static void kd_nosound(struct work_struct *unused)
 {
 	static unsigned int zero;
 
 	input_handler_for_each_handle(&kbd_handler, &zero, kd_sound_helper);
 }
 
-static DEFINE_TIMER(kd_mksound_timer, kd_nosound);
+static DECLARE_DELAYED_WORK(kd_mksound_worker, kd_nosound);
 
 void kd_mksound(unsigned int hz, unsigned int ticks)
 {
-	timer_delete_sync(&kd_mksound_timer);
+	cancel_delayed_work_sync(&kd_mksound_worker);
 
 	input_handler_for_each_handle(&kbd_handler, &hz, kd_sound_helper);
 
 	if (hz && ticks)
-		mod_timer(&kd_mksound_timer, jiffies + ticks);
+		schedule_delayed_work(&kd_mksound_worker, ticks);
 }
 EXPORT_SYMBOL(kd_mksound);
 
@@ -390,7 +390,7 @@ static void put_queue_utf8(struct vc_data *vc, u32 value)
 /* FIXME: review locking for vt.c callers */
 static void set_leds(void)
 {
-	tasklet_schedule(&keyboard_tasklet);
+	schedule_work(&keyboard_work);
 }
 
 /*
@@ -1024,10 +1024,10 @@ static int kbd_led_trigger_activate(struct led_classdev *cdev)
 	struct kbd_led_trigger *trigger =
 		container_of(cdev->trigger, struct kbd_led_trigger, trigger);
 
-	tasklet_disable(&keyboard_tasklet);
+	disable_work_sync(&keyboard_work);
 	if (ledstate != -1U)
 		led_set_brightness(cdev, ledstate & trigger->mask ? LED_FULL : LED_OFF);
-	tasklet_enable(&keyboard_tasklet);
+	enable_work(&keyboard_work);
 
 	return 0;
 }
@@ -1243,7 +1243,7 @@ void vt_kbd_con_stop(unsigned int console)
  * handle the scenario when keyboard handler is not registered yet
  * but we already getting updates from the VT to update led state.
  */
-static void kbd_bh(struct tasklet_struct *unused)
+static void kbd_bh(struct work_struct *unused)
 {
 	unsigned int leds;
 	unsigned long flags;
@@ -1535,7 +1535,7 @@ static void kbd_event(struct input_handle *handle, unsigned int event_type,
 
 	spin_unlock(&kbd_event_lock);
 
-	tasklet_schedule(&keyboard_tasklet);
+	schedule_work(&keyboard_work);
 	do_poke_blanked_console = 1;
 	schedule_console_callback();
 }
@@ -1607,12 +1607,12 @@ static void kbd_disconnect(struct input_handle *handle)
  */
 static void kbd_start(struct input_handle *handle)
 {
-	tasklet_disable(&keyboard_tasklet);
+	disable_work_sync(&keyboard_work);
 
 	if (ledstate != -1U)
 		kbd_update_leds_helper(handle, &ledstate);
 
-	tasklet_enable(&keyboard_tasklet);
+	enable_work(&keyboard_work);
 }
 
 static const struct input_device_id kbd_ids[] = {
@@ -1662,8 +1662,8 @@ int __init kbd_init(void)
 	if (error)
 		return error;
 
-	tasklet_enable(&keyboard_tasklet);
-	tasklet_schedule(&keyboard_tasklet);
+	enable_work(&keyboard_work);
+	schedule_work(&keyboard_work);
 
 	return 0;
 }
-- 
2.25.1

