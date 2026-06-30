Received: from mail-qv1-f65.google.com (mail-qv1-f65.google.com [209.85.219.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C4F1F3D56
	for <linux-serial@vger.kernel.org>; Tue, 30 Jun 2026 12:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782822650; cv=pass; b=RlW4uY2FHbBxtHSx3pVUEbcNvNkmeWENE5j7gMW9f83TYojeFiKszKMd0zx0I8UcQSblXzSf1nB2HUhU0Mw68BSlfFXyW2MAggdpyHiep9XTFLuyJYh4WJqrCopPAGjhSmKy0srZlvKEEycysFGevdZVvp9B2tdAR28UKfKUJdo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782822650; c=relaxed/simple;
	bh=oumyozVQCG24K55gEfwoh62//WjFyS6Z8wxrX5H0g/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rRzRQus+LfhpFZVA8+Aw2aUPG6Qidf6AtBhYz+iJlxwGpgZt3i9E27sAc4J4FUBmWK5RLAqf2uE2JwenU91/ujBzkbtetqiGmwtyU5EVijpIGVL+OrHqJn3hSmCe3GI5nRdn0N28HAxm5/OszMr7eKZIdTvJV2tC7lSgEDPCy7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=URcPrcPc; arc=pass smtp.client-ip=209.85.219.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="URcPrcPc"
Received: by mail-qv1-f65.google.com with SMTP id 6a1803df08f44-8f18d92172aso15228326d6.2
        for <linux-serial@vger.kernel.org>; Tue, 30 Jun 2026 05:30:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782822647; cv=none;
        d=google.com; s=arc-20260327;
        b=MiRIiPGGcG6OV8sk0BKXXLF3TysbZN2aILLa0En2Ufv5m5F3ordHW7X9C2SiB9BVvZ
         XB/oOTNl58ooy9nb0Wm+9CRoBFGcjP4XYtN79OJHPvOfpmaZJnaXPoE05Oz43rd3uy7l
         Ih3sfzx/O2ZWIb/5ym2eQH58y/RZvEk47MzfbtGxoEhUevTRssUPOHMnluP3LTUylZ73
         bNRookn69V/pwVf5JJNj00ulStKTDt3VlmwxMiwrx1SAKHBH7tKqzqEmc3B6+fmMACn0
         yy0jekr2OyKGO8Z9xWQONxs27WUG6cxJhBy5YcX96RtYOs2SeNPqYKunmCh3Sh4d9Bky
         SwNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ucdkN9KbADq5aSK9vHZ+c9M7EGCI0te0BcOx4sNFM1I=;
        fh=5Qb60PQjsfltR43e2z6T2J1N9/mTq5ehbusv1kD3r6I=;
        b=c1Foy53cpA8is0jCQhwE5MMEeGVfuEB1pdVpF1XMeQjoytn6doM8pBFOjT/7GP36LL
         aFS23YK0lpJq2jiIcErOa1vGED879OZfosgGPdtP3w1GHoPECeFiJFG5/h6Tb0pJYef8
         zy4AwG/isp8bUIiX8sRoZAiwLPDGCMIR6pBaULTSF9lbEdWwkqRNpUfGJV+1xSm+sze9
         XYcILTZ0+HZyiPdf7PDCAuQb0N1UOSjG/NQoWC/utD7DBjLBJ6cWcaJ+AwPSFOpDh/a8
         JOUykrGWCVosjdM9obe1HqseWMAGMHTlgdIf+wdqJKAjn1+o5kxr7RIeEMfBYe2H3d5j
         +tPg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782822647; x=1783427447; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ucdkN9KbADq5aSK9vHZ+c9M7EGCI0te0BcOx4sNFM1I=;
        b=URcPrcPcHj4FdPzYyBznacaDvuytRevrQce/SkksKMGK1gCVFWFsDsEebPnVcJ2aCq
         tydnbV6Sdql+MfWdc1yY6/1yLRPTjNr5ZvCBNfjt1aAMSS8DY7nsWjA5sxxqk21Y9SgR
         tJ0RLxxusit9hJe+XFZtgspTajznb6fNUXcNl+rIPMjhyaEq9D266kk0u71eSLL41Lq9
         Ux6PF4u8hMgKYMbuFHdK/Pby4QDjp26LSjS1ERLIuxmbgBnrR070PQDBeq+HYPzTa/3w
         9P+Ia9+iU0CHh1iF3zSI1PV/mx0p8UN5riNYeQAa95Si07SbYzU0DLQJPrqHc2gcrebO
         RVeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782822647; x=1783427447;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ucdkN9KbADq5aSK9vHZ+c9M7EGCI0te0BcOx4sNFM1I=;
        b=CYTeCwDcGLq++HPoslOTbOCmFGxeBklXi0uGuxq1jKV2YESnOqUtzrzBQXY6mdaxj8
         kByv7In+MDOGGp+LLTYSL6C9xdQdUe2xEZhZ53LceoV2yIm/6qkPOVA6nEVCh3uKnIna
         uDRvws9e8A7Oa8Z2YVu/9k1IRf76JwSqlKF9zHQMBbgLSZZzgtGfhRONVmVWVlLXFp5y
         RmhCoXDA72eNmk0F7p0PYDl2Fc7WhXHRoVjwmhlq+qsCr1nEqTI5oVPjufYEjVArRBMz
         RyZ9tl9358JgYCooDxoAmEE6P2ZnmGmKmyrLiRgvWIe3FNh3HA4wGs629BdJ4urBvROp
         7nTg==
X-Forwarded-Encrypted: i=1; AHgh+RpmcjyB+tJ891tSepUuPKHzj9WAr4CONwwJEg0InDyHG/udArTSgi/d1bKw6M4IxujoLJnkWqQMr5F0ZCo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywsdyf3nMADwIDSMqEIhTcTxPiDe7+jPGoIRBZmFE2UbA+rce3x
	DGazu7hfcvmpEktn1V8Efva4q0nqThzYWUG+YN/Vc5jz61wUqVJUggeN5ODjienzvpyd1Q4HeER
	GeFfmHS9Zbn+jIwpLwyajX1P1ef+HBzg=
X-Gm-Gg: AfdE7cmF3V/iXUgXVXlGO5TafarpjjeyEqKVCvBeo+QW7KNDWfwm5Rzw53pdKQqjYIx
	MYe0QIO2fiDGtaHD8w849SmAlM4KCa/bnGYeC7683TL9Dcvx0rOprjvSogDYaKvFAYM2Eo2ALLK
	PSnfIms70GMl44yz+U7pZVPS1nlDhwEPi16GXgHHnlOeobmvT1/gw5v1v/1EiFXpNjTcuMQFvoI
	K2ybOV7UwJ9inlj0e0L15/p7SMQMtXwqaVlpRigMsY18HeI0vP4K0XV9g/t6Ow10zSke3bTTQ/6
	0dONm8Ec
X-Received: by 2002:a05:6214:e4b:b0:8e7:efa5:31df with SMTP id
 6a1803df08f44-8f1bb32d34amr48767446d6.34.1782822647145; Tue, 30 Jun 2026
 05:30:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHPqNmzFQPFCom1Ng-FhbeRm=maLsKW1T4ZasGm40OkrxJfuwg@mail.gmail.com>
 <2026060919-unchanged-raking-9225@gregkh> <CAHPqNmztcnHLLEV0v8JK1zspgWqaveaTpDtEMh8ehuv-3hZPqA@mail.gmail.com>
 <2026062257-grading-remember-bfde@gregkh>
In-Reply-To: <2026062257-grading-remember-bfde@gregkh>
From: Longxing Li <coregee2000@gmail.com>
Date: Tue, 30 Jun 2026 20:30:39 +0800
X-Gm-Features: AVVi8Cf0hAgJtsZZ37J_bevFFZQd3PP0Zgg9NeyxXxNWFhDKRIxpq0E_4somcWY
Message-ID: <CAHPqNmxJfSC73Liogt=vr=YR_wX0VFTAMphejesodE=85Aeuvg@mail.gmail.com>
Subject: Re: [Kernel Bug] INFO: task hung in show_cons_active
To: Greg KH <gregkh@linuxfoundation.org>
Cc: syzkaller@googlegroups.com, jirislaby@kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000094f697065577be6d"

--00000000000094f697065577be6d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

 Dear maintainers,

Here's my fix and patch of the bug.

Fix Summary:

  The deadlock occurs because unregister_console() holds console_list_lock
  while __pr_flush() blocks on console_sem. show_cons_active() has the same
  lock -> sem ordering (holds mutex, waits for sem), creating a potential
  ABBA when any printer path needs the mutex.

  Fix: restructure unregister_console() into three phases:

    Phase 1 (list lock):   Disable console (clear CON_ENABLED).
    Phase 2 (NO lock):     __pr_flush() waits for pending output.
                           Safe because console is already disabled.
    Phase 3 (list lock):   Remove from list + cleanup.

  This ensures __pr_flush() is never called while holding console_list_lock=
,
  eliminating the lock inversion.

  Full patch is as follows and also attached in the link.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
From: Longxing Li <coregee2000@gmail.com>
Date: Tue, 30 Jun 2026
Subject: [PATCH] printk: fix potential deadlock in unregister_console()

unregister_console() holds console_list_lock while calling __pr_flush(),
which blocks on console_sem. show_cons_active() holds console_mutex (the
same lock) while also waiting for console_sem. This creates a potential
ABBA deadlock when any console output path needs console_mutex.

Fix by restructuring unregister_console() so __pr_flush() is called WITHOUT
holding console_list_lock:

  Phase 1 (list lock):    Disable console (clear CON_ENABLED).
  Phase 2 (no lock):      __pr_flush() drains pending output.
  Phase 3 (list lock):    Remove from list + cleanup.

Reported-by: Longxing Li
Suggested-by: Greg KH <gregkh@linuxfoundation.org>
Signed-off-by: Longxing Li <coregee2000@gmail.com>
---
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -4235,28 +4235,15 @@
  struct console *c;
  int res;

  lockdep_assert_console_list_lock_held();

- con_printk(KERN_INFO, console, "disabled\n");
-
- res =3D _braille_unregister_console(console);
- if (res < 0)
- return res;
- if (res > 0)
- return 0;
-
- if (!console_is_registered_locked(console))
- res =3D -ENODEV;
- else if (console_is_usable(console, console->flags, true))
- __pr_flush(console, 1000, true);
-
- /* Disable it unconditionally */
- console_srcu_write_flags(console, console->flags & ~CON_ENABLED);
-
- if (res < 0)
- return res;
+/*
+ * NOTE: The disable phase has been moved to
+ * __unregister_console_disable(). This function
+ * only handles list removal and cleanup (Phase 3).
+ */

  /*
  * Use the driver synchronization to ensure that the hardware is not
  * in use while this console transitions to being unregistered.
  */
@@ -4320,17 +4307,77 @@
  printk_kthreads_check_locked();

  return res;
 }

+
+/*
+ * __unregister_console_disable - Phase 1 of unregistration
+ * @console: console to disable
+ *
+ * Marks the console as disabled and prints the "disabled" message,
+ * both under console_list_lock().
+ *
+ * NOTE: This function does NOT call __pr_flush(). __pr_flush() blocks
+ * on console_sem. show_cons_active() holds console_mutex
+ * (=3D=3D console_list_lock) while waiting for console_sem.
+ *
+ * Holding console_list_lock while blocking for console_sem creates a
+ * classic ABBA deadlock. The flush is deferred to Phase 2.
+ *
+ * Returns 0 on success, negative errno on error (-ENODEV).
+ */
+static int __unregister_console_disable(struct console *console)
+{
+ int brl_res;
+
+ lockdep_assert_console_list_lock_held();
+
+ if (!console_is_registered_locked(console))
+ return -ENODEV;
+
+ con_printk(KERN_INFO, console, "disabled\n");
+
+ brl_res =3D _braille_unregister_console(console);
+ if (brl_res < 0)
+ return brl_res;
+ if (brl_res > 0)
+ return 0;
+
+ console_srcu_write_flags(console, console->flags & ~CON_ENABLED);
+
+ return 0;
+}
 int unregister_console(struct console *console)
 {
  int res;

+ /* Phase 1: disable console while holding list lock */
+ console_list_lock();
+ res =3D __unregister_console_disable(console);
+ console_list_unlock();
+ if (res)
+ return res;
+
+ /*
+ * Phase 2: flush WITHOUT holding console_list_lock.
+ *
+ * This is the key fix of the deadlock.
+ * __pr_flush() blocks on console_sem.
+ * Holding console_list_lock while blocking for
+ * console_sem creates an ABBA with show_cons_active().
+ *
+ * The console is already disabled in Phase 1 (CON_ENABLED=3D0),
+ * so no new printk output will be sent to it.
+ */
+ __pr_flush(console, 1000, true);
+
+ /* Phase 3: final removal and cleanup under list lock */
  console_list_lock();
  res =3D unregister_console_locked(console);
  console_list_unlock();
+
  return res;
 }
 EXPORT_SYMBOL(unregister_console);

 /**

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
https://drive.google.com/file/d/1PeNlaVVXwhgyc7ZU9CaQeUwOGbshOpc_/view?usp=
=3Ddrive_link


Greg KH <gregkh@linuxfoundation.org> =E4=BA=8E2026=E5=B9=B46=E6=9C=8822=E6=
=97=A5=E5=91=A8=E4=B8=80 22:02=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, Jun 22, 2026 at 09:53:02PM +0800, Longxing Li wrote:
> > Dear Linux kernel developers and maintainers,
> >
> > Thank you for the feedback. I've added some analysis on this bug, and
> > also added the original report, which is at the bottom of this email.
> >
> > Analysis Summary:
> >
> > The hang involves two tasks blocking on console_sem while holding
> > console_mutex, and a third task path (unregister_console) that
> > acquires console_mutex and then blocks on console_sem via
> > __pr_flush(). The core problem is a lock inversion: __pr_flush()
> > blocks on console_sem while holding console_list_lock (->
> > console_mutex).
> >
> > This can lead to a deadlock when any code path holds console_sem and
> > subsequently needs console_mutex.
>
> Great, can you create patches for this issue as you seem to be able to
> reproduce the issue well?  That way you get credit for the fix and we
> can understand the proposal here much better.
>
> thanks,
>
> greg k-h

--00000000000094f697065577be6d
Content-Type: text/plain; charset="US-ASCII"; name="bug-fix.patch.txt"
Content-Disposition: attachment; filename="bug-fix.patch.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_mr0mj73t0>
X-Attachment-Id: f_mr0mj73t0

RnJvbTogTG9uZ3hpbmcgTGkgPGNvcmVnZWUyMDAwQGdtYWlsLmNvbT4KRGF0ZTogVHVlLCAzMCBK
dW4gMjAyNgpTdWJqZWN0OiBbUEFUQ0hdIHByaW50azogZml4IHBvdGVudGlhbCBkZWFkbG9jayBp
biB1bnJlZ2lzdGVyX2NvbnNvbGUoKQoKdW5yZWdpc3Rlcl9jb25zb2xlKCkgaG9sZHMgY29uc29s
ZV9saXN0X2xvY2sgd2hpbGUgY2FsbGluZyBfX3ByX2ZsdXNoKCksCndoaWNoIGJsb2NrcyBvbiBj
b25zb2xlX3NlbS4gc2hvd19jb25zX2FjdGl2ZSgpIGhvbGRzIGNvbnNvbGVfbXV0ZXggKHRoZQpz
YW1lIGxvY2spIHdoaWxlIGFsc28gd2FpdGluZyBmb3IgY29uc29sZV9zZW0uIFRoaXMgY3JlYXRl
cyBhIHBvdGVudGlhbApBQkJBIGRlYWRsb2NrIHdoZW4gYW55IGNvbnNvbGUgb3V0cHV0IHBhdGgg
bmVlZHMgY29uc29sZV9tdXRleC4KCkZpeCBieSByZXN0cnVjdHVyaW5nIHVucmVnaXN0ZXJfY29u
c29sZSgpIHNvIF9fcHJfZmx1c2goKSBpcyBjYWxsZWQgV0lUSE9VVApob2xkaW5nIGNvbnNvbGVf
bGlzdF9sb2NrOgoKICBQaGFzZSAxIChsaXN0IGxvY2spOiAgICBEaXNhYmxlIGNvbnNvbGUgKGNs
ZWFyIENPTl9FTkFCTEVEKS4KICBQaGFzZSAyIChubyBsb2NrKTogICAgICBfX3ByX2ZsdXNoKCkg
ZHJhaW5zIHBlbmRpbmcgb3V0cHV0LgogIFBoYXNlIDMgKGxpc3QgbG9jayk6ICAgIFJlbW92ZSBm
cm9tIGxpc3QgKyBjbGVhbnVwLgoKUmVwb3J0ZWQtYnk6IExvbmd4aW5nIExpClN1Z2dlc3RlZC1i
eTogR3JlZyBLSCA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+ClNpZ25lZC1vZmYtYnk6IExv
bmd4aW5nIExpIDxjb3JlZ2VlMjAwMEBnbWFpbC5jb20+Ci0tLQotLS0gYS9rZXJuZWwvcHJpbnRr
L3ByaW50ay5jCisrKyBiL2tlcm5lbC9wcmludGsvcHJpbnRrLmMKQEAgLTQyMzUsMjggKzQyMzUs
MTUgQEAKIAlzdHJ1Y3QgY29uc29sZSAqYzsKIAlpbnQgcmVzOwogCiAJbG9ja2RlcF9hc3NlcnRf
Y29uc29sZV9saXN0X2xvY2tfaGVsZCgpOwogCi0JY29uX3ByaW50ayhLRVJOX0lORk8sIGNvbnNv
bGUsICJkaXNhYmxlZFxuIik7Ci0KLQlyZXMgPSBfYnJhaWxsZV91bnJlZ2lzdGVyX2NvbnNvbGUo
Y29uc29sZSk7Ci0JaWYgKHJlcyA8IDApCi0JCXJldHVybiByZXM7Ci0JaWYgKHJlcyA+IDApCi0J
CXJldHVybiAwOwotCi0JaWYgKCFjb25zb2xlX2lzX3JlZ2lzdGVyZWRfbG9ja2VkKGNvbnNvbGUp
KQotCQlyZXMgPSAtRU5PREVWOwotCWVsc2UgaWYgKGNvbnNvbGVfaXNfdXNhYmxlKGNvbnNvbGUs
IGNvbnNvbGUtPmZsYWdzLCB0cnVlKSkKLQkJX19wcl9mbHVzaChjb25zb2xlLCAxMDAwLCB0cnVl
KTsKLQotCS8qIERpc2FibGUgaXQgdW5jb25kaXRpb25hbGx5ICovCi0JY29uc29sZV9zcmN1X3dy
aXRlX2ZsYWdzKGNvbnNvbGUsIGNvbnNvbGUtPmZsYWdzICYgfkNPTl9FTkFCTEVEKTsKLQotCWlm
IChyZXMgPCAwKQotCQlyZXR1cm4gcmVzOworLyoKKyAqIE5PVEU6IFRoZSBkaXNhYmxlIHBoYXNl
IGhhcyBiZWVuIG1vdmVkIHRvCisgKiBfX3VucmVnaXN0ZXJfY29uc29sZV9kaXNhYmxlKCkuIFRo
aXMgZnVuY3Rpb24KKyAqIG9ubHkgaGFuZGxlcyBsaXN0IHJlbW92YWwgYW5kIGNsZWFudXAgKFBo
YXNlIDMpLgorICovCiAKIAkvKgogCSAqIFVzZSB0aGUgZHJpdmVyIHN5bmNocm9uaXphdGlvbiB0
byBlbnN1cmUgdGhhdCB0aGUgaGFyZHdhcmUgaXMgbm90CiAJICogaW4gdXNlIHdoaWxlIHRoaXMg
Y29uc29sZSB0cmFuc2l0aW9ucyB0byBiZWluZyB1bnJlZ2lzdGVyZWQuCiAJICovCkBAIC00MzIw
LDE3ICs0MzA3LDc3IEBACiAJcHJpbnRrX2t0aHJlYWRzX2NoZWNrX2xvY2tlZCgpOwogCiAJcmV0
dXJuIHJlczsKIH0KIAorCisvKgorICogX191bnJlZ2lzdGVyX2NvbnNvbGVfZGlzYWJsZSAtIFBo
YXNlIDEgb2YgdW5yZWdpc3RyYXRpb24KKyAqIEBjb25zb2xlOiBjb25zb2xlIHRvIGRpc2FibGUK
KyAqCisgKiBNYXJrcyB0aGUgY29uc29sZSBhcyBkaXNhYmxlZCBhbmQgcHJpbnRzIHRoZSAiZGlz
YWJsZWQiIG1lc3NhZ2UsCisgKiBib3RoIHVuZGVyIGNvbnNvbGVfbGlzdF9sb2NrKCkuCisgKgor
ICogTk9URTogVGhpcyBmdW5jdGlvbiBkb2VzIE5PVCBjYWxsIF9fcHJfZmx1c2goKS4gX19wcl9m
bHVzaCgpIGJsb2NrcworICogb24gY29uc29sZV9zZW0uIHNob3dfY29uc19hY3RpdmUoKSBob2xk
cyBjb25zb2xlX211dGV4CisgKiAoPT0gY29uc29sZV9saXN0X2xvY2spIHdoaWxlIHdhaXRpbmcg
Zm9yIGNvbnNvbGVfc2VtLgorICoKKyAqIEhvbGRpbmcgY29uc29sZV9saXN0X2xvY2sgd2hpbGUg
YmxvY2tpbmcgZm9yIGNvbnNvbGVfc2VtIGNyZWF0ZXMgYQorICogY2xhc3NpYyBBQkJBIGRlYWRs
b2NrLiBUaGUgZmx1c2ggaXMgZGVmZXJyZWQgdG8gUGhhc2UgMi4KKyAqCisgKiBSZXR1cm5zIDAg
b24gc3VjY2VzcywgbmVnYXRpdmUgZXJybm8gb24gZXJyb3IgKC1FTk9ERVYpLgorICovCitzdGF0
aWMgaW50IF9fdW5yZWdpc3Rlcl9jb25zb2xlX2Rpc2FibGUoc3RydWN0IGNvbnNvbGUgKmNvbnNv
bGUpCit7CisJaW50IGJybF9yZXM7CisKKwlsb2NrZGVwX2Fzc2VydF9jb25zb2xlX2xpc3RfbG9j
a19oZWxkKCk7CisKKwlpZiAoIWNvbnNvbGVfaXNfcmVnaXN0ZXJlZF9sb2NrZWQoY29uc29sZSkp
CisJCXJldHVybiAtRU5PREVWOworCisJY29uX3ByaW50ayhLRVJOX0lORk8sIGNvbnNvbGUsICJk
aXNhYmxlZFxuIik7CisKKwlicmxfcmVzID0gX2JyYWlsbGVfdW5yZWdpc3Rlcl9jb25zb2xlKGNv
bnNvbGUpOworCWlmIChicmxfcmVzIDwgMCkKKwkJcmV0dXJuIGJybF9yZXM7CisJaWYgKGJybF9y
ZXMgPiAwKQorCQlyZXR1cm4gMDsKKworCWNvbnNvbGVfc3JjdV93cml0ZV9mbGFncyhjb25zb2xl
LCBjb25zb2xlLT5mbGFncyAmIH5DT05fRU5BQkxFRCk7CisKKwlyZXR1cm4gMDsKK30KIGludCB1
bnJlZ2lzdGVyX2NvbnNvbGUoc3RydWN0IGNvbnNvbGUgKmNvbnNvbGUpCiB7CiAJaW50IHJlczsK
IAorCS8qIFBoYXNlIDE6IGRpc2FibGUgY29uc29sZSB3aGlsZSBob2xkaW5nIGxpc3QgbG9jayAq
LworCWNvbnNvbGVfbGlzdF9sb2NrKCk7CisJcmVzID0gX191bnJlZ2lzdGVyX2NvbnNvbGVfZGlz
YWJsZShjb25zb2xlKTsKKwljb25zb2xlX2xpc3RfdW5sb2NrKCk7CisJaWYgKHJlcykKKwkJcmV0
dXJuIHJlczsKKworCS8qCisJICogUGhhc2UgMjogZmx1c2ggV0lUSE9VVCBob2xkaW5nIGNvbnNv
bGVfbGlzdF9sb2NrLgorCSAqCisJICogVGhpcyBpcyB0aGUga2V5IGZpeCBvZiB0aGUgZGVhZGxv
Y2suCisJICogX19wcl9mbHVzaCgpIGJsb2NrcyBvbiBjb25zb2xlX3NlbS4KKwkgKiBIb2xkaW5n
IGNvbnNvbGVfbGlzdF9sb2NrIHdoaWxlIGJsb2NraW5nIGZvcgorCSAqIGNvbnNvbGVfc2VtIGNy
ZWF0ZXMgYW4gQUJCQSB3aXRoIHNob3dfY29uc19hY3RpdmUoKS4KKwkgKgorCSAqIFRoZSBjb25z
b2xlIGlzIGFscmVhZHkgZGlzYWJsZWQgaW4gUGhhc2UgMSAoQ09OX0VOQUJMRUQ9MCksCisJICog
c28gbm8gbmV3IHByaW50ayBvdXRwdXQgd2lsbCBiZSBzZW50IHRvIGl0LgorCSAqLworCV9fcHJf
Zmx1c2goY29uc29sZSwgMTAwMCwgdHJ1ZSk7CisKKwkvKiBQaGFzZSAzOiBmaW5hbCByZW1vdmFs
IGFuZCBjbGVhbnVwIHVuZGVyIGxpc3QgbG9jayAqLwogCWNvbnNvbGVfbGlzdF9sb2NrKCk7CiAJ
cmVzID0gdW5yZWdpc3Rlcl9jb25zb2xlX2xvY2tlZChjb25zb2xlKTsKIAljb25zb2xlX2xpc3Rf
dW5sb2NrKCk7CisKIAlyZXR1cm4gcmVzOwogfQogRVhQT1JUX1NZTUJPTCh1bnJlZ2lzdGVyX2Nv
bnNvbGUpOwogCiAvKioK
--00000000000094f697065577be6d--
