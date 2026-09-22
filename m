Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E0E3F4DD2
	for <linux-serial@vger.kernel.org>; Tue, 22 Sep 2026 07:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790061994; cv=none; b=rWPHMxfw4qidP2WHDoAfms9nJCQEX71hmcGFbHIHTjCF5BXfqSqmCA5EgqNTXpBMtrK5/UcmHVNIsbz/mGZOYjSoAdy2vR60zaQcBYjK4IZBSntAVXORLt54tHkVSaJJ3LGodKHm5jnQdaPqrb261j55huORsd5uExuiABVZUSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790061994; c=relaxed/simple;
	bh=UIeHGzko9PNGSAFX4WTjAsYcLZre5mbCyVd5/P2jJGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sF4D1MwWqesVvDW7iHOa7plgSNAh0S+naccfz6bdt8J271tkt6clnMKdd2hGIMkVTzI4zigZcAucLKeRUZ7xVKkEfprZRUDF9CLKer+UFvcfKZ0cqy6labDOTVFDDJQlaXygGUQyfSKvu2Di8spd3mGkChnWqmLQYA7ZkQKjf7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EqBghxV6; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EqBghxV6"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49b912d37b5so22181815e9.2
        for <linux-serial@vger.kernel.org>; Tue, 22 Sep 2026 00:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1790061990; x=1790666790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fnhbPdt7hfIV/6LXnAHz3D7CDaGQANxV0Uyd8rSU9Jg=;
        b=EqBghxV6CGX4X/gdDMrUese0eongaoXz+uf4DrLhsIvF+D9cbZwCWREx8a4SyotJh/
         T6T5jAhCrxi9/hg4CYrTaz1hNKeKkARMmHLk+aZ2WrIz23DqGMt0yQO7PEuYIzRfXKJR
         jKIZ9zuXsUQhjtlfCc/TUOp4xYeklNMzQv2c/Qxv8GD2bSHt6vaD6ZhhwYpcVb5UOR2b
         8zrMV+/8SZX1DbkGHYZz5dg/kcr90DPTV+w9+3+j07j0O5QCt9G1YfklsOBknRXTQREY
         yIBxIBA0GWV6eCI/crWOZJ0+63Dw/cvTxf2mRsNJuS9n1P+yQ43Y1HzHxE2MXaT0n/93
         issw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790061990; x=1790666790;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fnhbPdt7hfIV/6LXnAHz3D7CDaGQANxV0Uyd8rSU9Jg=;
        b=ttHJo844ANSFIyN8VB5CBXOq5mbIG69dONTrOaPgN53RaLfevNL2Jw5BMMGkHbwF/F
         AfVmwM0Ibo+946gjpRE6Qa2/F0SIc12WwRCOJ0lAushXO6DmK/zdMzMh94vHz9SAGxIe
         HLPiqnJ86jAW3k5TZhs26XVblWaUtR9+/Zma4Sz40ilMvw1huUEenBUtIsoZ6kLawA1v
         LT+LYDQw6SVEpfcykRgm4A4UjNiAdcCb8BM0OMhlCFMbknrFxMwzg6A9xD5rRJY1iAVT
         A2sk2WVCd8npJVYCnK+C0R4sKRKnC8vuSZJ8SWT2oVs4dhVT/bNFIn/OJePTfOTRCR75
         ey4w==
X-Forwarded-Encrypted: i=1; AKwUvBx6SPsAgnpfpc3rxnc/2+u42UiuoVJMv9bSlkhsL2l71dqnEYDQ7dFvDMOfRk79dD9cVlD5hoEtQP7MkGE=@vger.kernel.org
X-Gm-Message-State: AFuF++mXJj7TDGBYSH6iityfqBtv7p/uZtqHKD56BK8NYiAbN6/cLu3x
	JwzhucoCojwGbe004DPJBeKTb6KikyosTqgYnxT5rCxkTQ5qt/8GM+I+rOgBRtqYFyo=
X-Gm-Gg: AYBFou1aq1pfr3RAZzfuYqHHScpZ+JgnfyslqMsJozoBIes4VxWgnGjGldCXWv+EE/x
	UuAPX2rlwQ3BvYrXAkdppnKCfy4tM+LkgJG5rqbqLjPTecnHuO5jJyR+E1ARJmJdDh1G4VdjpoC
	sgxVTJnBXJz/4hQG/TzMLEp0jHxBvMh87Z+xyjgF5GLhEEeEsRA1sm1qvRCgvZQx5qefZzPFBkY
	NAve7ChZWkppx8OVbXqnWrrW7GJK7iDjRr/wJYOUnvDpqBD/+oLGt78gO4iNd6OaLJfM8dKr0e2
	qPTwL727cqLpPTJXepoYO9vzFS2FoxfDDxg9VwKsGBMKKC2qalaXbSstMrER0m/aExJ8wX6IJk5
	jLdzRUh4QZ+rKjFpS0LcU7GnNvGPc4sEYduI/47xaK3psZTQnsRsooAy4Fcc3bnVGjkbUN1x3Hy
	+uvsXtbTPEf0H1M7qaXJW5r097iV0vpMj3q0lWfgFm6faeK7vo+uj/uf2kypfx1fk8+UBFNPmN
X-Received: by 2002:a05:600c:c0c3:10b0:49e:823a:9dec with SMTP id 5b1f17b1804b1-49fc5a10b5fmr167223725e9.3.1790061990534;
        Tue, 22 Sep 2026 00:26:30 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fd8cc05e9sm52966385e9.5.2026.09.22.00.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 00:26:30 -0700 (PDT)
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Marcos Paulo de Souza <mpdesouza@suse.com>,
	Samuel Thibault <samuel.thibault@ens-lyon.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Fushuai Wang <wangfushuai@baidu.com>,
	Kees Cook <kees@kernel.org>,
	Stepan Ionichev <sozdayvek@gmail.com>,
	linux-serial@vger.kernel.org,
	Manuel Lauss <manuel.lauss@gmail.com>,
	linux-kernel@vger.kernel.org,
	Petr Mladek <pmladek@suse.com>
Subject: [PATCH 1/2] printk: nbcon: Introduce Braille helpers
Date: Tue, 22 Sep 2026 09:25:57 +0200
Message-ID: <20260922072558.98854-2-pmladek@suse.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922072558.98854-1-pmladek@suse.com>
References: <20260922072558.98854-1-pmladek@suse.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These helpers will be used when calling console->write_atomic
in the Braille console driver.

The Braille console is not registered as a standard printk console.
Instead, it is integrated with the virtual terminal (VT) and writes
data using the legacy con->write() callback of the associated serial
console driver.

When the underlying console driver is converted to the NBCON API, the
Braille console needs to use the con->write_atomic() callback instead.
This callback must be synchronized by acquiring the nbcon console context.

Fixes: d3539347022a ("serial: 8250: Switch to nbcon console, take 2")
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 include/linux/console.h |  8 ++++++
 kernel/printk/nbcon.c   | 59 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+)

diff --git a/include/linux/console.h b/include/linux/console.h
index 502d1abe3f50..d780f6de303a 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -615,6 +615,10 @@ extern bool nbcon_allow_unsafe_takeover(void);
 extern bool nbcon_kdb_try_acquire(struct console *con,
 				  struct nbcon_write_context *wctxt);
 extern void nbcon_kdb_release(struct nbcon_write_context *wctxt);
+extern bool nbcon_is_braille(struct nbcon_write_context *wctxt);
+extern bool nbcon_braille_try_acquire(struct console *con,
+				      struct nbcon_write_context *wctxt);
+extern void nbcon_braille_release(struct nbcon_write_context *wctxt);
 
 /*
  * Check if the given console is currently capable and allowed to print
@@ -678,8 +682,12 @@ static inline void nbcon_reacquire_nobuf(struct nbcon_write_context *wctxt) { }
 static inline bool nbcon_kdb_try_acquire(struct console *con,
 					 struct nbcon_write_context *wctxt) { return false; }
 static inline void nbcon_kdb_release(struct nbcon_write_context *wctxt) { }
+static inline bool nbcon_is_braille(struct nbcon_write_context *wctxt) { return false; }
 static inline bool console_is_usable(struct console *con, short flags,
 				     bool use_atomic) { return false; }
+static inline bool nbcon_braille_try_acquire(struct console *con,
+					     struct nbcon_write_context *wctxt) { return false; }
+static inline void nbcon_braille_release(struct nbcon_write_context *wctxt) { }
 #endif
 
 extern int console_set_on_cmdline;
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index d17704fe93ae..a5e053ffe4da 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -2002,3 +2002,62 @@ void nbcon_kdb_release(struct nbcon_write_context *wctxt)
 	 */
 	__nbcon_atomic_flush_pending_con(ctxt->console, prb_next_reserve_seq(prb));
 }
+
+/**
+ * nbcon_is_braille - Checks whether the nbcon write context is using Braille console
+ *
+ * @wctxt:	checked nbcon write context
+ *
+ * Return: True when the write context is associated with a Braille console.
+ *	   Othrewise, return false.
+ *
+ * Context: Can be called in any context but only when Braille console is
+ *	registered and the struct console could not disappear.
+ */
+bool nbcon_is_braille(struct nbcon_write_context *wctxt)
+{
+	struct nbcon_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);
+	struct console *con = ctxt->console;
+
+	return con && con->flags & CON_BRL;
+}
+
+/**
+ * nbcon_braille_try_acquire - Try to acquire nbcon console for braille_write()
+ *
+ * @con:	The nbcon console to acquire
+ * @wctxt:	The nbcon write context to be used on success
+ *
+ * Context:	braille_write() for emitting a single buffer on Braille console.
+ *
+ * Return:	True if the console was acquired. False otherwise.
+ *
+ * Braille console is not registered as a proper printk consoles. Instead,
+ * it is integrated with the graphical virtual terminal.
+ *
+ * This function acquires the nbcon console using priority NBCON_PRIO_EMERGENCY.
+ */
+bool nbcon_braille_try_acquire(struct console *con,
+			   struct nbcon_write_context *wctxt)
+{
+	struct nbcon_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);
+
+	memset(ctxt, 0, sizeof(*ctxt));
+	ctxt->console = con;
+	ctxt->prio    = NBCON_PRIO_EMERGENCY;
+
+	return nbcon_context_try_acquire(ctxt, false);
+}
+
+/**
+ * nbcon_braille_release - Release the nbcon console
+ *
+ * @wctxt:	The nbcon write context initialized by a successful
+ *		nbcon_braille_try_acquire()
+ */
+void nbcon_braille_release(struct nbcon_write_context *wctxt)
+{
+	struct nbcon_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);
+
+	nbcon_context_release(ctxt);
+}
-- 
2.55.0

