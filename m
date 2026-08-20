Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07C23FDBE8
	for <linux-serial@vger.kernel.org>; Thu, 20 Aug 2026 12:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787230630; cv=none; b=phR2I4LkWB0kbUZkqFglrh1BokI4yR2F4dE3wbwqY2e/gkfaUJo/gTLvf8k8YTQlAAn5GZKZvq3yFGA2B/o+zkJ4kd4yfOztJ7UeDL+XSxEypR56ZfrFYFVoYZ4AHrme2YWLmJBsh5aPTx9B53CZmq2TQA1ym3qIabh7X/fKjjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787230630; c=relaxed/simple;
	bh=sNIyHeXJIudD37ymvCDhwAdu3YYAOP+5oIm4rgTL67A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T1nyFbTswJOoFo0uFjWmepRV9BG6WaAq42wVXEY5kEg2uHw/Y503DQUp/BNFTV34RGD7maNvPubvHp6h2HC79SwdfRhsdxNcc/gPw22vYE0vscmfzD4VhYWJyeT3sngMHMSBQDrZWQK0Zp09zbQXLeMPWSSnAskGHeI/5qIJU/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NM8M7DcD; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NM8M7DcD"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-499b02fc590so9248705e9.2
        for <linux-serial@vger.kernel.org>; Thu, 20 Aug 2026 05:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1787230627; x=1787835427; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5FQOdWV8uuYPHZruYYC2UaU3mzYkHKqzVCAV7kcJnP8=;
        b=NM8M7DcD/maAMNt6/cB2xoB+JoB4vhYQFbPp0zhwqnyik8CX6UR01JdNf2te25miZQ
         cdhjE6msdYFu7n97g90SsjqFGd81Q0Xg3Tu8S6HlIO9ZNVuhqzJP5aH5CIsZL059hqWR
         nH2CmsMgdXKU48fqDddNKbwXL54B3JbW3HHJC9BY+iz6iq0KjF88kNyFlJ0kKQRrVYF7
         /iSUsJy/90mANpOfX/3NTyP+7pd25EwqDefFQa0nIToObLukphp5t1xogwAHXChQDy6L
         8AsETEHx7kvL+LeeEcjnMeXIPn2AnQWrhSkjk/htmsRmBknytwp9XtivLnkw1OSC6Z1B
         BV1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787230627; x=1787835427;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5FQOdWV8uuYPHZruYYC2UaU3mzYkHKqzVCAV7kcJnP8=;
        b=mPmLp/d3rXBz7i9vAlAdVTdWG3EtvbK1kGpI67pjDCtrFXnDtQmz9ktooyrYDH92m1
         R6jJpqFi6Z0v7kp8x6sH8Cl7IEsUpvmQwykcyjPpyfbRj98LAadLsJNssWsrziLIQ1WU
         tLlCVnx8NynJlNjKB6omULLGJgjeI+klATLXiTXFQ4rdErCSI6Ym84rh5L1+TvopKB33
         Vl9R0dHTo/lWobL5bKoCpyISOZwkKN7znDCVAt/fG90NG3i/utOa6Afyf5q2TZ2ioJ6D
         NpD6XPfq7lD2lRiTTbDwuokp7ioOoXjcdrNPAql6ZOb/oPyXNklzVMcaaKhuCJot3ScJ
         /iKw==
X-Forwarded-Encrypted: i=1; AHgh+RoWW4ag+9f7bVThTFfrJBktt+QFsOmylO3VtjmnCypqrUOBvekPu9B9zsa5G4VY/iDI8yT4ppcVzfrXMkE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI7SBXQ3yXFC/WCZlVDytc83B5F37S5VQkBdizkjWwe7df07gz
	/YOAMhBMiEV2HiAvSKY+ayBmIgZQe8rSsic0YV+qSHq9iKnC44ZAM2A2GqG+GkLYi6Y=
X-Gm-Gg: AR+sD133CW99IOF3wq41NDFJmMtxQAdvV10YCoH4Pxprz0j+mzDtMHTHD5Gj8YgQ7Su
	iPDh0NDMhHYH4K9fiIR4+Zr5sVhe/DMa6jQuJVrl5CXtjId2I+t9Sw8EjB4I9OwaZn2ZumTuJsy
	fkyG2FB1jUIL0QpzWpCQ+MvTWHySv3DmChtF1msDEwx+Cxg2drTUoXofTytVYDN7l2+4OK+cFYA
	NDQ/gzryl+cnwrOjNrDymevlNZYgBe6qM7wOUXoDrnCk+OmMSaZW1rsp871nvl0JTYLInhzMThz
	1WE99R0nsxRAaoGq2biD9TwQUM+J5HYjpKusMas3+xDP/ZkXNzo75CGOa3wEa4+SGY7kVrObh5Z
	rmP8nbzyW2cBfWEpMWQjEsWTvWpexz7MF3718Gl+LcuuRyBp11GIB83UCMCBZMZNnn7v2cRTfEO
	Cx9K1supubutpY02OlYmatZIEoeVZENAdA4itM5k9/TB+MaWpjZAkYzvA9tyQldnLEqOIJtB30
X-Received: by 2002:a05:600c:8b27:b0:499:7024:9d4a with SMTP id 5b1f17b1804b1-499aa16a958mr246348125e9.8.1787230626796;
        Thu, 20 Aug 2026 05:57:06 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499aca21c63sm158029965e9.0.2026.08.20.05.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 05:57:06 -0700 (PDT)
Date: Thu, 20 Aug 2026 14:57:04 +0200
From: Petr Mladek <pmladek@suse.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andreas Schwab <schwab@linux-m68k.org>, linux-m68k@vger.kernel.org,
	John Ogness <john.ogness@linutronix.de>,
	"open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>
Subject: Re: [PATCH] m68k: nfcon: don't call console_is_registered in
 nfcon_device
Message-ID: <aob5oO_7qxII_qTB@pathway.suse.cz>
References: <87ecfzsv6h.fsf@igel.home>
 <CAMuHMdU4C+W6Tpsn3Vr_kqmuU2Vzg7ExXhspmB5qNWMZ3Wnfeg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdU4C+W6Tpsn3Vr_kqmuU2Vzg7ExXhspmB5qNWMZ3Wnfeg@mail.gmail.com>

On Mon 2026-08-17 11:26:57, Geert Uytterhoeven wrote:
> Hi Andreas,
> 
> CC john, petr, serial
> 
> Thanks for your patch!
> 
> On Sat, 15 Aug 2026 at 09:33, Andreas Schwab <schwab@linux-m68k.org> wrote:
> > Since 7c2af0f634f1 ("tty: tty_io: use console_list_lock for list
> > synchronization") show_cons_active calls the device method under the
> > console_list_lock, but console_is_registered tries to acquire
> > console_list_lock as well, causing a deadlock.  It should not be necessary
> > to check console_is_registered here since the function should not be
> > called in the fist place when the console is not registered.
> 
> Nice catch!

+1

> > Fixes: 7c2af0f634f1 ("tty: tty_io: use console_list_lock for list synchronization")
> > Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>
> 
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
> i.e. will queue in the m68k tree for v7.3.
> 
> > --- a/arch/m68k/emu/nfcon.c
> > +++ b/arch/m68k/emu/nfcon.c
> > @@ -49,7 +49,7 @@ static void nfcon_write(struct console *con, const char *str,
> >  static struct tty_driver *nfcon_device(struct console *con, int *index)
> >  {
> >         *index = 0;
> > -       return console_is_registered(con) ? nfcon_tty_driver : NULL;
> 
> Interestingly, that call to console_is_registered() was added in
> commit de61a1a3a0830710 ("tty: nfcon: use console_is_registered()"),
> i.e. in the same series that added the extra locking...

Sigh, we clearly did not check the callers of this function properly
at that time :/

> > +       return nfcon_tty_driver;

Honestly, I do not feel comfortable with removing the check
completely.

The commit de61a1a3a083071 ("tty: nfcon: use console_is_registered()"
used console_is_registered() instead of (con->flags & CON_ENABLED).
And CON_ENABLED is historically cleared when the console is suspended,
see console_suspend().

Is is OK to return a valid struct tty_driver for a non-registered
or suspended console for all con->device() callers?

I have found only 4 callers:

  $> git grep "\->device("
  drivers/tty/serial/kgdboc.c:            if (cons->device && cons->device(cons, &idx) == p &&
  drivers/tty/tty_io.c:           struct tty_driver *drv = cs[i]->device(cs[i], &index);
  fs/proc/consoles.c:             driver = con->device(con, &index);
  kernel/printk/printk.c:         driver = c->device(c, index);

These are:

  + configure_kgdboc() in drivers/tty/serial/kgdboc.c
  + show_cons_active() in drivers/tty/tty_io.c
  + show_console_dev() in fs/proc/consoles.c
  + console_device() in kernel/printk/printk.c

, where

  + configure_kgdboc() is used during the system initialization
    when the console should not be suspended

  + show_cons_active() and show_console_dev() are questionable.
    Maybe, we should not advertise the device to the userspace
    when it is suspended.

  + console_device() is used in tty_kopen() -> tty_lookup_driver().
    Also here we likely should not allow to open a suspended device.

Let's take a step back:

We should define the locking context for con->device() callback.
It seems that it is called under console_lock() and
console_srcu_read_lock() in:

  + configure_kgdboc()
  + console_device()

and under console_list_lock() and console_lock() in

  + show_console_dev()
  + show_cons_active()

I would put aside the console_lock(). We are trying to obsolete it.
So it is down to

   console_srcu_read_lock() vs console_list_lock()

Both of them look reasonable. So, I think about adding a variant
of console_is_registered_srcu_read_locked() which would work
with both locking. Something like:

diff --git a/arch/m68k/emu/nfcon.c b/arch/m68k/emu/nfcon.c
index d41260672e24..d211b6c4da26 100644
--- a/arch/m68k/emu/nfcon.c
+++ b/arch/m68k/emu/nfcon.c
@@ -49,7 +49,7 @@ static void nfcon_write(struct console *con, const char *str,
 static struct tty_driver *nfcon_device(struct console *con, int *index)
 {
 	*index = 0;
-	return console_is_registered(con) ? nfcon_tty_driver : NULL;
+	return console_is_registered_srcu_read_locked(con) ? nfcon_tty_driver : NULL;
 }
 
 static struct console nf_console = {
diff --git a/include/linux/console.h b/include/linux/console.h
index d624200cfc17..b90527db4eca 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -311,7 +311,7 @@ struct nbcon_write_context {
  * @name:		The name of the console driver
  * @write:		Legacy write callback to output messages (Optional)
  * @read:		Read callback for console input (Optional)
- * @device:		The underlying TTY device driver (Optional)
+ * @device:		The underlying TTY device driver (Optional) [1]
  * @unblank:		Callback to unblank the console (Optional)
  * @setup:		Callback for initializing the console (Optional)
  * @exit:		Callback for teardown of the console (Optional)
@@ -334,6 +334,9 @@ struct nbcon_write_context {
  * @kthread:		Printer kthread for this console
  * @rcuwait:		RCU-safe wait object for @kthread waking
  * @irq_work:		Defer @kthread waking to IRQ work context
+ *
+ * [1] The @device callback must be called under either console_list_lock()
+ *     or console_srcu_read_lock().
  */
 struct console {
 	char			name[16];
@@ -473,8 +476,13 @@ struct console {
 };
 
 #ifdef CONFIG_LOCKDEP
+extern bool console_list_lock_is_held(void);
 extern void lockdep_assert_console_list_lock_held(void);
 #else
+static inline bool console_list_lock_is_held(void)
+{
+	return 1;
+}
 static inline void lockdep_assert_console_list_lock_held(void)
 {
 }
@@ -555,6 +563,16 @@ static inline bool console_is_registered_locked(const struct console *con)
 	return !hlist_unhashed(&con->node);
 }
 
+/*
+ * Variant of console_is_registered() when either the console_srcu_read_lock
+ * or console_list_lock is held.
+*/
+static inline bool console_is_registered_srcu_read_locked(const struct console *con)
+{
+	lockdep_assert(console_srcu_read_lock_is_held() || console_list_lock_is_held());
+	return !hlist_unhashed(&con->node);
+}
+
 /*
  * console_is_registered - Check if the console is registered
  * @con:	struct console pointer of console to check
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 2fe9a963c823..9b632b91f096 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -109,6 +109,12 @@ static struct lockdep_map console_lock_dep_map = {
 	.name = "console_lock"
 };
 
+bool console_list_lock_is_held(void)
+{
+	return lockdep_is_held(&console_mutex);
+}
+EXPORT_SYMBOL(console_list_lock_is_held);
+
 void lockdep_assert_console_list_lock_held(void)
 {
 	lockdep_assert_held(&console_mutex);


Alternative solution would be to require the srcu locking.
IMHO, it should be perfectly fine to use the srcu_read_lock in
both show_console_dev() and show_cons_active().

What do you think, please?
John?

Best Regards,
Petr
