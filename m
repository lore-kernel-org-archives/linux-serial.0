Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF55027A929;
	Wed,  1 Oct 2025 10:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759314879; cv=none; b=p4/ej6oCdo1q6LIoMAnZuW3TEt8hlh4E3FY2Nd1TcLEJxzsllKjaeRupBveK+o7FXWlZTId3NncqZxJfhjgoxjxjCFmHbAFnGn/aXmxqpB81Lxwltatvaa6Z+QlX9A/0iZfvAZMN5VBmCvwvrf7j06wMZCliPPMdnCPs+s616Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759314879; c=relaxed/simple;
	bh=lKdaz9q1JFh4bXm3l97Sf4Qg7aug3hR12RVq2G5OTiA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bXe0hRhCAdCyu/7IaYnkYii1pDv8nfwdo5+bkqwoT2QbZGL6rrfXrgpI3CIoLapGhesYFzmmp/Zwebfnrco6sUuRB3GQhUaG3NV6gLSaBUZKSyvnrFdGX3Wq26hWOpFOqRWF0EkY5W3WzwKmNyGwVMcXCYD5p2ic4jqvgPsETxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 371b79289eb211f08b9f7d2eb6caa7cf-20251001
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:fe6b01bf-8da6-4de7-ad45-fca75cffa32c,IP:0,U
	RL:0,TC:0,Content:-25,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:e47dc93ee60088aa448e99338edafe6d,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|850,TC:nil,Content:0|50,EDM:5,
	IP:nil,URL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:
	0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 371b79289eb211f08b9f7d2eb6caa7cf-20251001
Received: from localhost [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <pengyu@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 558221402; Wed, 01 Oct 2025 18:34:31 +0800
From: pengyu <pengyu@kylinos.cn>
To: tj@kernel.org,
	jiangshanlai@gmail.com,
	oliver.sang@intel.com
Cc: changlianzhi@uniontech.com,
	dmitry.torokhov@gmail.com,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	legion@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	lkp@intel.com,
	mingo@kernel.org,
	myrrhperiwinkle@qtmlabs.xyz,
	oe-lkp@lists.linux.dev,
	pengyu@kylinos.cn,
	syzbot+79c403850e6816dc39cf@syzkaller.appspotmail.com,
	tglx@linutronix.de
Subject: [PATCH v2 2/2] tty/vt: Fix possible deadlock in input_inject_event
Date: Wed,  1 Oct 2025 18:23:41 +0800
Message-Id: <20251001102341.600251-2-pengyu@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251001102341.600251-1-pengyu@kylinos.cn>
References: <202509301323.34d956e1-lkp@intel.com>
 <20251001102341.600251-1-pengyu@kylinos.cn>
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

Signed-off-by: pengyu <pengyu@kylinos.cn>
---
Changes in v2:
  - enable_work needs to be used in pairs with disable_work_sync,
    not with cancel_work_sync.
  - use work items that diabled by default.
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

