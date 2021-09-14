Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED0ACC4332F
	for <linux-serial@archiver.kernel.org>; Tue, 14 Sep 2021 09:11:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5E7F61108
	for <linux-serial@archiver.kernel.org>; Tue, 14 Sep 2021 09:11:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbhINJMy (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 14 Sep 2021 05:12:54 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:33652 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbhINJMx (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 14 Sep 2021 05:12:53 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 8C4BA21FAE;
        Tue, 14 Sep 2021 09:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1631610695; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cxDKGykKAu1PDTACMZpSs/9WeRFvhFKCZXYiul1wwKI=;
        b=GcY4IfKs+7FwieeslfgpMGnvVSPmqFYcSGxzLoiNvwg1tT7oNVXHXgAsddd3UkDQQK+7Qy
        N1dScIGYa+m+Ws4yIN9yVewGEqbz+96x17jjUNBS1l0nmX0U+ThcLHEXuowizCdnS2qTCa
        N6Rx5RS8O1mM2znxM4onuN9wkw3k+aI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1631610695;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cxDKGykKAu1PDTACMZpSs/9WeRFvhFKCZXYiul1wwKI=;
        b=3z4N+Tp6LyDYyi0HAzSFmVGbSHVp9ANIdERVasCjBYG3irVm+AtdKix4OxzbRaV+jpa5dn
        pfKGjiWbe/OeySDw==
Received: from localhost.localdomain (unknown [10.100.201.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 6A354A3B9C;
        Tue, 14 Sep 2021 09:11:35 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 03/16] tty: remove extern from functions in tty headers
Date:   Tue, 14 Sep 2021 11:11:21 +0200
Message-Id: <20210914091134.17426-3-jslaby@suse.cz>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210914091134.17426-1-jslaby@suse.cz>
References: <20210914091134.17426-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

After the recent headers cleanup, some function declarations still have
extern before them. It is superfluous (for function declarations), so
remove extern from those which still have it.

This unifies them with the rest of the files.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 include/linux/tty.h        | 139 ++++++++++++++++++-------------------
 include/linux/tty_driver.h |   8 +--
 include/linux/tty_flip.h   |  20 +++---
 include/linux/tty_ldisc.h  |  22 +++---
 4 files changed, 94 insertions(+), 95 deletions(-)

diff --git a/include/linux/tty.h b/include/linux/tty.h
index 168e57e40bbb..15453b0c4081 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -252,20 +252,20 @@ static inline bool tty_throttled(struct tty_struct *tty)
 }
 
 #ifdef CONFIG_TTY
-extern void tty_kref_put(struct tty_struct *tty);
-extern struct pid *tty_get_pgrp(struct tty_struct *tty);
-extern void tty_vhangup_self(void);
-extern void disassociate_ctty(int priv);
-extern dev_t tty_devnum(struct tty_struct *tty);
-extern void proc_clear_tty(struct task_struct *p);
-extern struct tty_struct *get_current_tty(void);
+void tty_kref_put(struct tty_struct *tty);
+struct pid *tty_get_pgrp(struct tty_struct *tty);
+void tty_vhangup_self(void);
+void disassociate_ctty(int priv);
+dev_t tty_devnum(struct tty_struct *tty);
+void proc_clear_tty(struct task_struct *p);
+struct tty_struct *get_current_tty(void);
 /* tty_io.c */
-extern int __init tty_init(void);
-extern const char *tty_name(const struct tty_struct *tty);
-extern struct tty_struct *tty_kopen_exclusive(dev_t device);
-extern struct tty_struct *tty_kopen_shared(dev_t device);
-extern void tty_kclose(struct tty_struct *tty);
-extern int tty_dev_name_to_number(const char *name, dev_t *number);
+int __init tty_init(void);
+const char *tty_name(const struct tty_struct *tty);
+struct tty_struct *tty_kopen_exclusive(dev_t device);
+struct tty_struct *tty_kopen_shared(dev_t device);
+void tty_kclose(struct tty_struct *tty);
+int tty_dev_name_to_number(const char *name, dev_t *number);
 #else
 static inline void tty_kref_put(struct tty_struct *tty)
 { }
@@ -296,7 +296,7 @@ static inline int tty_dev_name_to_number(const char *name, dev_t *number)
 
 extern struct ktermios tty_std_termios;
 
-extern int vcs_init(void);
+int vcs_init(void);
 
 extern struct class *tty_class;
 
@@ -316,34 +316,34 @@ static inline struct tty_struct *tty_kref_get(struct tty_struct *tty)
 	return tty;
 }
 
-extern const char *tty_driver_name(const struct tty_struct *tty);
-extern void tty_wait_until_sent(struct tty_struct *tty, long timeout);
-extern void stop_tty(struct tty_struct *tty);
-extern void start_tty(struct tty_struct *tty);
-extern void tty_write_message(struct tty_struct *tty, char *msg);
-extern int tty_send_xchar(struct tty_struct *tty, char ch);
-extern int tty_put_char(struct tty_struct *tty, unsigned char c);
-extern unsigned int tty_chars_in_buffer(struct tty_struct *tty);
-extern unsigned int tty_write_room(struct tty_struct *tty);
-extern void tty_driver_flush_buffer(struct tty_struct *tty);
-extern void tty_unthrottle(struct tty_struct *tty);
-extern int tty_throttle_safe(struct tty_struct *tty);
-extern int tty_unthrottle_safe(struct tty_struct *tty);
-extern int tty_do_resize(struct tty_struct *tty, struct winsize *ws);
-extern int tty_get_icount(struct tty_struct *tty,
-			  struct serial_icounter_struct *icount);
-extern int is_current_pgrp_orphaned(void);
-extern void tty_hangup(struct tty_struct *tty);
-extern void tty_vhangup(struct tty_struct *tty);
-extern int tty_hung_up_p(struct file *filp);
-extern void do_SAK(struct tty_struct *tty);
-extern void __do_SAK(struct tty_struct *tty);
-extern void no_tty(void);
-extern speed_t tty_termios_baud_rate(struct ktermios *termios);
-extern void tty_termios_encode_baud_rate(struct ktermios *termios,
-						speed_t ibaud, speed_t obaud);
-extern void tty_encode_baud_rate(struct tty_struct *tty,
-						speed_t ibaud, speed_t obaud);
+const char *tty_driver_name(const struct tty_struct *tty);
+void tty_wait_until_sent(struct tty_struct *tty, long timeout);
+void stop_tty(struct tty_struct *tty);
+void start_tty(struct tty_struct *tty);
+void tty_write_message(struct tty_struct *tty, char *msg);
+int tty_send_xchar(struct tty_struct *tty, char ch);
+int tty_put_char(struct tty_struct *tty, unsigned char c);
+unsigned int tty_chars_in_buffer(struct tty_struct *tty);
+unsigned int tty_write_room(struct tty_struct *tty);
+void tty_driver_flush_buffer(struct tty_struct *tty);
+void tty_unthrottle(struct tty_struct *tty);
+int tty_throttle_safe(struct tty_struct *tty);
+int tty_unthrottle_safe(struct tty_struct *tty);
+int tty_do_resize(struct tty_struct *tty, struct winsize *ws);
+int tty_get_icount(struct tty_struct *tty,
+		struct serial_icounter_struct *icount);
+int is_current_pgrp_orphaned(void);
+void tty_hangup(struct tty_struct *tty);
+void tty_vhangup(struct tty_struct *tty);
+int tty_hung_up_p(struct file *filp);
+void do_SAK(struct tty_struct *tty);
+void __do_SAK(struct tty_struct *tty);
+void no_tty(void);
+speed_t tty_termios_baud_rate(struct ktermios *termios);
+void tty_termios_encode_baud_rate(struct ktermios *termios, speed_t ibaud,
+		speed_t obaud);
+void tty_encode_baud_rate(struct tty_struct *tty, speed_t ibaud,
+		speed_t obaud);
 
 /**
  *	tty_get_baud_rate	-	get tty bit rates
@@ -363,37 +363,37 @@ static inline speed_t tty_get_baud_rate(struct tty_struct *tty)
 unsigned char tty_get_char_size(unsigned int cflag);
 unsigned char tty_get_frame_size(unsigned int cflag);
 
-extern void tty_termios_copy_hw(struct ktermios *new, struct ktermios *old);
-extern int tty_termios_hw_change(const struct ktermios *a, const struct ktermios *b);
-extern int tty_set_termios(struct tty_struct *tty, struct ktermios *kt);
+void tty_termios_copy_hw(struct ktermios *new, struct ktermios *old);
+int tty_termios_hw_change(const struct ktermios *a, const struct ktermios *b);
+int tty_set_termios(struct tty_struct *tty, struct ktermios *kt);
 
-extern void tty_wakeup(struct tty_struct *tty);
+void tty_wakeup(struct tty_struct *tty);
 
-extern int tty_mode_ioctl(struct tty_struct *tty, struct file *file,
+int tty_mode_ioctl(struct tty_struct *tty, struct file *file,
 			unsigned int cmd, unsigned long arg);
-extern int tty_perform_flush(struct tty_struct *tty, unsigned long arg);
-extern struct tty_struct *tty_init_dev(struct tty_driver *driver, int idx);
-extern void tty_release_struct(struct tty_struct *tty, int idx);
-extern void tty_init_termios(struct tty_struct *tty);
-extern void tty_save_termios(struct tty_struct *tty);
-extern int tty_standard_install(struct tty_driver *driver,
+int tty_perform_flush(struct tty_struct *tty, unsigned long arg);
+struct tty_struct *tty_init_dev(struct tty_driver *driver, int idx);
+void tty_release_struct(struct tty_struct *tty, int idx);
+void tty_init_termios(struct tty_struct *tty);
+void tty_save_termios(struct tty_struct *tty);
+int tty_standard_install(struct tty_driver *driver,
 		struct tty_struct *tty);
 
 extern struct mutex tty_mutex;
 
 /* n_tty.c */
-extern void n_tty_inherit_ops(struct tty_ldisc_ops *ops);
+void n_tty_inherit_ops(struct tty_ldisc_ops *ops);
 #ifdef CONFIG_TTY
-extern void __init n_tty_init(void);
+void __init n_tty_init(void);
 #else
 static inline void n_tty_init(void) { }
 #endif
 
 /* tty_audit.c */
 #ifdef CONFIG_AUDIT
-extern void tty_audit_exit(void);
-extern void tty_audit_fork(struct signal_struct *sig);
-extern int tty_audit_push(void);
+void tty_audit_exit(void);
+void tty_audit_fork(struct signal_struct *sig);
+int tty_audit_push(void);
 #else
 static inline void tty_audit_exit(void)
 {
@@ -408,24 +408,23 @@ static inline int tty_audit_push(void)
 #endif
 
 /* tty_ioctl.c */
-extern int n_tty_ioctl_helper(struct tty_struct *tty, struct file *file,
-		       unsigned int cmd, unsigned long arg);
+int n_tty_ioctl_helper(struct tty_struct *tty, struct file *file,
+		unsigned int cmd, unsigned long arg);
 
 /* vt.c */
 
-extern int vt_ioctl(struct tty_struct *tty,
-		    unsigned int cmd, unsigned long arg);
+int vt_ioctl(struct tty_struct *tty, unsigned int cmd, unsigned long arg);
 
-extern long vt_compat_ioctl(struct tty_struct *tty,
-		     unsigned int cmd, unsigned long arg);
+long vt_compat_ioctl(struct tty_struct *tty, unsigned int cmd,
+		unsigned long arg);
 
 /* tty_mutex.c */
 /* functions for preparation of BKL removal */
-extern void tty_lock(struct tty_struct *tty);
-extern int  tty_lock_interruptible(struct tty_struct *tty);
-extern void tty_unlock(struct tty_struct *tty);
-extern void tty_lock_slave(struct tty_struct *tty);
-extern void tty_unlock_slave(struct tty_struct *tty);
-extern void tty_set_lock_subclass(struct tty_struct *tty);
+void tty_lock(struct tty_struct *tty);
+int  tty_lock_interruptible(struct tty_struct *tty);
+void tty_unlock(struct tty_struct *tty);
+void tty_lock_slave(struct tty_struct *tty);
+void tty_unlock_slave(struct tty_struct *tty);
+void tty_set_lock_subclass(struct tty_struct *tty);
 
 #endif
diff --git a/include/linux/tty_driver.h b/include/linux/tty_driver.h
index c20431d8def8..29e1cf178afb 100644
--- a/include/linux/tty_driver.h
+++ b/include/linux/tty_driver.h
@@ -327,11 +327,11 @@ struct tty_driver {
 
 extern struct list_head tty_drivers;
 
-extern struct tty_driver *__tty_alloc_driver(unsigned int lines,
-		struct module *owner, unsigned long flags);
-extern struct tty_driver *tty_find_polling_driver(char *name, int *line);
+struct tty_driver *__tty_alloc_driver(unsigned int lines, struct module *owner,
+		unsigned long flags);
+struct tty_driver *tty_find_polling_driver(char *name, int *line);
 
-extern void tty_driver_kref_put(struct tty_driver *driver);
+void tty_driver_kref_put(struct tty_driver *driver);
 
 /* Use TTY_DRIVER_* flags below */
 #define tty_alloc_driver(lines, flags) \
diff --git a/include/linux/tty_flip.h b/include/linux/tty_flip.h
index 32284992b31a..9916acb5de49 100644
--- a/include/linux/tty_flip.h
+++ b/include/linux/tty_flip.h
@@ -7,16 +7,16 @@
 
 struct tty_ldisc;
 
-extern int tty_buffer_set_limit(struct tty_port *port, int limit);
-extern unsigned int tty_buffer_space_avail(struct tty_port *port);
-extern int tty_buffer_request_room(struct tty_port *port, size_t size);
-extern int tty_insert_flip_string_flags(struct tty_port *port,
+int tty_buffer_set_limit(struct tty_port *port, int limit);
+unsigned int tty_buffer_space_avail(struct tty_port *port);
+int tty_buffer_request_room(struct tty_port *port, size_t size);
+int tty_insert_flip_string_flags(struct tty_port *port,
 		const unsigned char *chars, const char *flags, size_t size);
-extern int tty_insert_flip_string_fixed_flag(struct tty_port *port,
+int tty_insert_flip_string_fixed_flag(struct tty_port *port,
 		const unsigned char *chars, char flag, size_t size);
-extern int tty_prepare_flip_string(struct tty_port *port,
-		unsigned char **chars, size_t size);
-extern void tty_flip_buffer_push(struct tty_port *port);
+int tty_prepare_flip_string(struct tty_port *port, unsigned char **chars,
+		size_t size);
+void tty_flip_buffer_push(struct tty_port *port);
 void tty_schedule_flip(struct tty_port *port);
 int __tty_insert_flip_char(struct tty_port *port, unsigned char ch, char flag);
 
@@ -45,7 +45,7 @@ static inline int tty_insert_flip_string(struct tty_port *port,
 int tty_ldisc_receive_buf(struct tty_ldisc *ld, const unsigned char *p,
 		const char *f, int count);
 
-extern void tty_buffer_lock_exclusive(struct tty_port *port);
-extern void tty_buffer_unlock_exclusive(struct tty_port *port);
+void tty_buffer_lock_exclusive(struct tty_port *port);
+void tty_buffer_unlock_exclusive(struct tty_port *port);
 
 #endif /* _LINUX_TTY_FLIP_H */
diff --git a/include/linux/tty_ldisc.h b/include/linux/tty_ldisc.h
index 1f37184eee63..4d1c128afbfa 100644
--- a/include/linux/tty_ldisc.h
+++ b/include/linux/tty_ldisc.h
@@ -146,7 +146,7 @@ struct ld_semaphore {
 #endif
 };
 
-extern void __init_ldsem(struct ld_semaphore *sem, const char *name,
+void __init_ldsem(struct ld_semaphore *sem, const char *name,
 			 struct lock_class_key *key);
 
 #define init_ldsem(sem)						\
@@ -157,18 +157,18 @@ do {								\
 } while (0)
 
 
-extern int ldsem_down_read(struct ld_semaphore *sem, long timeout);
-extern int ldsem_down_read_trylock(struct ld_semaphore *sem);
-extern int ldsem_down_write(struct ld_semaphore *sem, long timeout);
-extern int ldsem_down_write_trylock(struct ld_semaphore *sem);
-extern void ldsem_up_read(struct ld_semaphore *sem);
-extern void ldsem_up_write(struct ld_semaphore *sem);
+int ldsem_down_read(struct ld_semaphore *sem, long timeout);
+int ldsem_down_read_trylock(struct ld_semaphore *sem);
+int ldsem_down_write(struct ld_semaphore *sem, long timeout);
+int ldsem_down_write_trylock(struct ld_semaphore *sem);
+void ldsem_up_read(struct ld_semaphore *sem);
+void ldsem_up_write(struct ld_semaphore *sem);
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
-extern int ldsem_down_read_nested(struct ld_semaphore *sem, int subclass,
-				  long timeout);
-extern int ldsem_down_write_nested(struct ld_semaphore *sem, int subclass,
-				   long timeout);
+int ldsem_down_read_nested(struct ld_semaphore *sem, int subclass,
+		long timeout);
+int ldsem_down_write_nested(struct ld_semaphore *sem, int subclass,
+		long timeout);
 #else
 # define ldsem_down_read_nested(sem, subclass, timeout)		\
 		ldsem_down_read(sem, timeout)
-- 
2.33.0

