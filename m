Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7C3329383
	for <linux-serial@vger.kernel.org>; Sat, 27 Dec 2025 12:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766837987; cv=none; b=XCe1Cprz5K+oS5XJJ02smXhh2/G6MRZh4T/0ZnHF24h8X/iFzFFpJN64T0BTQdVr+WXehjAxOWYtpCRi/Sl+x6gWwwB93Ab2GhwngNNBhEcevTC5qQGxS6TSSAPZL7AB6jFFFiWWvTdADakKB5P2iT2hoYW/ZYQZP39FFFTT6Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766837987; c=relaxed/simple;
	bh=jfxXivsE45EkgkvCbI8I2BEVFtLSwL83e0mmBVPuH+w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YvGOI+Vjy9ocZlFxrM14P8UvI4LIknROWSzW70is54e+VH/JIfbGPmWjGcXx2XM2qId9vp1k9/m4zucWevDR2Fal5fs6XRn1kRl60LzDMRNgGIgag26StNs1oZDwJ/YKymA/9mMI0usMZvjbitTm7A/DR+qd6hFWD9v1zv2Cj/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Y2jxOsoA; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Y2jxOsoA"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-47aa03d3326so49893805e9.3
        for <linux-serial@vger.kernel.org>; Sat, 27 Dec 2025 04:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1766837983; x=1767442783; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xV/54pzRS8Etay7a+DmZn75b0ho6rdI/NPswC/OMCoI=;
        b=Y2jxOsoAqRMTW++xm1Ay/yJuOOy1RSw0vAWWwUTSoUdqeEIwZSjwXqHgWVjjub24Xt
         tvEle8RLwQq+JVMFzL2UdOd39wmI2bQPQB/y7ZCPP5/qPa08n3JBtR7hf9NZwKtyMEId
         VP6fkG41KKpMrDeK3NBqOietavOHxnvDbCiiXwiJNAp8W5QcMSdkmn6eOFGuPCrdo4AI
         gdT3+a4IdhDS3EqM4Qo+VK1RbtzGLkZ+zEjadZix0mfjy9qZVtQ+5StVGaM5rUepKSH2
         dGcBC7BKh2ZqIAEOYoAZVj949A89y+06+4DQVOA2+IQHfSf6hf2P4WdYkJCU1zsH5RaT
         Wteg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766837983; x=1767442783;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xV/54pzRS8Etay7a+DmZn75b0ho6rdI/NPswC/OMCoI=;
        b=ts+Qv7dujNVq/EVElhhBQfLVb4308fCtz/t+KaXzMM6YVGYo1bvNYio6KpIQdFTH7i
         Rfuu2fqGsgO6bhvPX+tqSwqcUI021gURSTeElf0k5KDtIDc4iv4u3yyXt2Am7HQDLsFy
         hmyhjFaAVE1G2u9OX98HvDP4MgNYYwNYnzPEq+7JJ/SyUC7tstlXEve/vrKITArdP8Z7
         OvlKYwSl89l9ZEgad54Dzn3zb0o9yOkUuj7kq0l+Hwnbe2/vmGe0X1ERKpSrfhV9hvBV
         F0ySO6/CR1aL1cK9gZ2/SoLvXNjOKWUPq2XSa4wx69bU2unZCfmC/4OhHXLjgsGyncy2
         tq6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWA7SgKtjs/ThwOrpr3eVAxPtPAm9qGEQd6Tw7pb0QN7E4XPQKIt2vnf5UlZfEJRSUWLMJ6+YUKu1IFFKc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHrVaXDpkJTYsCrwLFR2QTkvAWo/9JSBLdWGJyUTtVwrkgvWp1
	Uz9SAfFZwzPIEhnP+CbNTViT1bLjiYvG7mwo3zoId0PXQfdqDzJljOyivTYguN1oSLw=
X-Gm-Gg: AY/fxX4OtVu6MqP5q2D0OvpEEZuKPNawOyccBA7cyw0jynXvuKguP3xnWH+pNBr41oA
	lAV+dgfBA96z//6NZoYBdg/KuUM/JP1kPlbU8od49hhHIQ61M2/BIDGbR1ooqClRGbj5VRpory/
	4g+OP0/zR2rJr8CO8C0aGP+TCFBl2dc4NSSjBftEF3ZVb2AKi4y/M1DPBzuLfXqn9MZm9foi7f9
	gwhObODT8IXJl+gebqbJFdWQl7StMP3z6NA8fvEuY5xPhKcdPZPRuwxmUQSXa1Es5NOUuMOcUDk
	iNr9KIPBjJhunAVOABR0gLmUV7i9kLL9+5QGUj55UortqbYxAG+D7N1h92Q2z8s70iO7oMrnIFR
	bXKHM/fU7HdnEADE86Mca5nVpHSWLNtOqB3rKIJjJIRAccz5Daqk+uHQyDCN01cUn1BTrwhemZq
	FAhcBzXqi5gZd1Bw/EYCY=
X-Google-Smtp-Source: AGHT+IH8iMWTGKOo0ODMODi1rEzmJGgWpFcndwFU+BLf6Q6Oiy3SLl7fhkZeY72om2wNWMGGrFeTWQ==
X-Received: by 2002:a05:600d:8:b0:477:5897:a0c4 with SMTP id 5b1f17b1804b1-47d1c13fcfdmr225764485e9.4.1766837983269;
        Sat, 27 Dec 2025 04:19:43 -0800 (PST)
Received: from [127.0.0.1] ([2804:5078:811:d400:58f2:fc97:371f:2])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724cfdd0sm97940127c88.4.2025.12.27.04.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Dec 2025 04:19:42 -0800 (PST)
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Date: Sat, 27 Dec 2025 09:16:26 -0300
Subject: [PATCH 19/19] printk: Remove CON_ENABLED flag
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251227-printk-cleanup-part3-v1-19-21a291bcf197@suse.com>
References: <20251227-printk-cleanup-part3-v1-0-21a291bcf197@suse.com>
In-Reply-To: <20251227-printk-cleanup-part3-v1-0-21a291bcf197@suse.com>
To: Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jason Wessel <jason.wessel@windriver.com>, 
 Daniel Thompson <danielt@kernel.org>, 
 Douglas Anderson <dianders@chromium.org>, Petr Mladek <pmladek@suse.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 John Ogness <john.ogness@linutronix.de>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Breno Leitao <leitao@debian.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, Kees Cook <kees@kernel.org>, 
 Tony Luck <tony.luck@intel.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Andreas Larsson <andreas@gaisler.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Jacky Huang <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>, 
 Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, 
 kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org, 
 netdev@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
 linux-hardening@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 sparclinux@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
 Marcos Paulo de Souza <mpdesouza@suse.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766837798; l=5342;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=jfxXivsE45EkgkvCbI8I2BEVFtLSwL83e0mmBVPuH+w=;
 b=L4bmhgBbhK4MabaljXOFYoWoPA/F2Ms1Hw5KRZJ0wiLbS51oCxDTE2j2nmUG21whYB1lNSvfW
 KXB3PChlBf2AMEmTwaAmskLdw1SadRBF3zXvV826sJWL27JOeadfagz
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=

All remaining usages of CON_ENABLED were removed from console drivers
that were being registered without being specified on boot using console=
argument.

The usefulness of the flag was questionable since at first it meant that
the console was ready to print records. Later on, console drivers started
to set the flag when registering the console to make sure that the
console would be registered even without being specified by a kernel
argument.

With the inclusion a global state for system wide suspend/resume
in place, with console_{suspend,resume} handling CON_SUSPEND, and with
console_is_usable helper being more used, the CON_ENABLED flag can be
safely removed.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 fs/proc/consoles.c      |  1 -
 include/linux/console.h | 27 ++++++++++-----------------
 kernel/printk/printk.c  | 15 ++-------------
 3 files changed, 12 insertions(+), 31 deletions(-)

diff --git a/fs/proc/consoles.c b/fs/proc/consoles.c
index b7cab1ad990d..b6916ed7957b 100644
--- a/fs/proc/consoles.c
+++ b/fs/proc/consoles.c
@@ -18,7 +18,6 @@ static int show_console_dev(struct seq_file *m, void *v)
 		short flag;
 		char name;
 	} con_flags[] = {
-		{ CON_ENABLED,		'E' },
 		{ CON_CONSDEV,		'C' },
 		{ CON_BOOT,		'B' },
 		{ CON_NBCON,		'N' },
diff --git a/include/linux/console.h b/include/linux/console.h
index 7d374a29a625..0ab02f7ba307 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -164,9 +164,6 @@ static inline void con_debug_leave(void) { }
  *			consoles or read by userspace via syslog() syscall.
  * @CON_CONSDEV:	Indicates that the console driver is backing
  *			/dev/console.
- * @CON_ENABLED:	Indicates if a console is allowed to print records. If
- *			false, the console also will not advance to later
- *			records.
  * @CON_BOOT:		Marks the console driver as early console driver which
  *			is used during boot before the real driver becomes
  *			available. It will be automatically unregistered
@@ -192,14 +189,13 @@ static inline void con_debug_leave(void) { }
 enum cons_flags {
 	CON_PRINTBUFFER		= BIT(0),
 	CON_CONSDEV		= BIT(1),
-	CON_ENABLED		= BIT(2),
-	CON_BOOT		= BIT(3),
-	CON_ANYTIME		= BIT(4),
-	CON_BRL			= BIT(5),
-	CON_EXTENDED		= BIT(6),
-	CON_SUSPENDED		= BIT(7),
-	CON_NBCON		= BIT(8),
-	CON_NBCON_ATOMIC_UNSAFE	= BIT(9),
+	CON_BOOT		= BIT(2),
+	CON_ANYTIME		= BIT(3),
+	CON_BRL			= BIT(4),
+	CON_EXTENDED		= BIT(5),
+	CON_SUSPENDED		= BIT(6),
+	CON_NBCON		= BIT(7),
+	CON_NBCON_ATOMIC_UNSAFE	= BIT(8),
 };
 
 /**
@@ -522,9 +518,9 @@ extern bool consoles_suspended;
  *
  * Requires console_srcu_read_lock to be held, which implies that @con might
  * be a registered console. The purpose of holding console_srcu_read_lock is
- * to guarantee that the console state is valid (CON_SUSPENDED/CON_ENABLED)
- * and that no exit/cleanup routines will run if the console is currently
- * undergoing unregistration.
+ * to guarantee that the console state is valid (CON_SUSPENDED) and that no
+ * exit/cleanup routines will run if the console is currently undergoing
+ * unregistration.
  *
  * If the caller is holding the console_list_lock or it is _certain_ that
  * @con is not and will not become registered, the caller may read
@@ -706,9 +702,6 @@ static inline bool __console_is_usable(struct console *con, short flags,
 	if (all_suspended)
 		return false;
 
-	if (!(flags & CON_ENABLED))
-		return false;
-
 	if ((flags & CON_SUSPENDED))
 		return false;
 
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index c5c05e4d0a67..9cb0911997e5 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3890,21 +3890,17 @@ static int try_enable_preferred_console(struct console *newcon,
 			if (err)
 				return err;
 		}
-		newcon->flags |= CON_ENABLED;
 		if (i == preferred_console)
 			newcon->flags |= CON_CONSDEV;
 		return 0;
 	}
 
-	if (force)
-		newcon->flags |= CON_ENABLED;
-
 	/*
 	 * Some consoles, such as pstore and netconsole, can be enabled even
 	 * without matching. Accept the pre-enabled consoles only when match()
 	 * and setup() had a chance to be called.
 	 */
-	if (newcon->flags & CON_ENABLED && c->user_specified == user_specified)
+	if (force && c->user_specified == user_specified)
 		return 0;
 
 	return -ENOENT;
@@ -3919,8 +3915,6 @@ static void try_enable_default_console(struct console *newcon)
 	if (console_call_setup(newcon, NULL) != 0)
 		return;
 
-	newcon->flags |= CON_ENABLED;
-
 	if (newcon->device)
 		newcon->flags |= CON_CONSDEV;
 }
@@ -3977,10 +3971,8 @@ static u64 get_init_console_seq(struct console *newcon, bool bootcon_registered)
 				for_each_console(con) {
 					u64 seq;
 
-					if (!(con->flags & CON_BOOT) ||
-					    !(con->flags & CON_ENABLED)) {
+					if (!(con->flags & CON_BOOT))
 						continue;
-					}
 
 					if (con->flags & CON_NBCON)
 						seq = nbcon_seq_read(con);
@@ -4233,9 +4225,6 @@ static int unregister_console_locked(struct console *console)
 				     consoles_suspended, NBCON_USE_ATOMIC))
 		__pr_flush(console, 1000, true);
 
-	/* Disable it unconditionally */
-	console_srcu_write_flags(console, console->flags & ~CON_ENABLED);
-
 	if (res < 0)
 		return res;
 

-- 
2.52.0

