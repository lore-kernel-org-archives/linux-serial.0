Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0599F1F9F7A;
	Tue, 25 Nov 2025 22:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764111286; cv=none; b=s7PfnRvNyyAhMk0ywwWr9YRCu0reqBXw1dtAIF4OvdfqKxwEwri5ZN8H9y4szNwfaCqpDZ7rnPlMeBINtZZBm6MA6cJJCvW1NViHM32sRuADwXapbppXPcYavIibQM1Rb5C92lrwiaG0RMqc36I4fn4MwhZem/OiQPwN8lkKOlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764111286; c=relaxed/simple;
	bh=S9CohV3WfyjsUpzsiQrOOpbeG/bubQXmxtesOUEle0s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=WflK5QXyiiXeaRkaQpmvDqpXgrFhjz6iO3cJg9wlgjbnaRVFH/pHcMQ9TFtx8MbKNOoydhBdCEBnsMscGcWABmomAp3pr42rjBVa/Iakwi7Qv1zRe2NMGu27GO/rxDjEOvetNStBuS7/7C2DzyaIc0M7sU/IUjzmjvy/+Fj/5xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cviqIa9B; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cviqIa9B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84D9FC4CEF1;
	Tue, 25 Nov 2025 22:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764111285;
	bh=S9CohV3WfyjsUpzsiQrOOpbeG/bubQXmxtesOUEle0s=;
	h=From:Date:Subject:To:Cc:From;
	b=cviqIa9BGbcTWPGqY8LQMxLy+m+tweNHvZXJOmvezINxxUmi3NJ7v2hNyW4fGGipG
	 i1kZrZsk/7pMZ/2G7bDuARXmZAyTlwMEKK8rUtrXo9JjBTfpgceEkHjrH5OBVz0SSv
	 D5lhIb7wQPf96YnvP+DuZbYQSdoTqHv0lCbo0ntBPvbDaJDrB693dsZu0Zchtc6Icr
	 6TvwN6eYjzu9GB0zT2aznwanfrtTZKKj6nyO8BHQA3LcFvwqQMrPyXFasdqy5pqMPS
	 urZklCN6o+ecXkZ3jjzgEknrWyvEEfs4Y9cc8vgSk73nqpkiK/a+hZG44KfzGzrcqF
	 qlUV+jL1iAm1g==
From: Nathan Chancellor <nathan@kernel.org>
Date: Tue, 25 Nov 2025 15:54:37 -0700
Subject: [PATCH] tty: vt/keyboard: Split apart vt_do_diacrit()
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251125-tty-vt-keyboard-wa-clang-scope-check-error-v1-1-f5a5ea55c578@kernel.org>
X-B4-Tracking: v=1; b=H4sIAKwzJmkC/yXNUQrCMBCE4auUfXbBBIPgVcSHdDO1sdKUTVotp
 Xc36uMHw/wbZWhEpkuzkWKJOaaxwhwakt6Pd3AM1WSP1hljHZey8lJ4wNomr4FfnuVZh5wlTWD
 pIQNDNSm3OAUXzsF1FlQPJ0UX37/Y9fZ3ntsHpHwLtO8f2SuI9Y4AAAA=
X-Change-ID: 20251125-tty-vt-keyboard-wa-clang-scope-check-error-be4d5d7d5f2e
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 llvm@lists.linux.dev, kernel test robot <lkp@intel.com>, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=9562; i=nathan@kernel.org;
 h=from:subject:message-id; bh=S9CohV3WfyjsUpzsiQrOOpbeG/bubQXmxtesOUEle0s=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDJlqxptd9p7+2rdcVDrOs9rtWRl78QTd3eKM7SdOppz1u
 l/9YX5dRykLgxgXg6yYIkv1Y9XjhoZzzjLeODUJZg4rE8gQBi5OAZjI7jeMDL0n/kkcXuDxQ/v4
 86WTjZwr15xKLUtbtuVgTEtWdqx+RQ8jw9q0nKXp9SqmO2Y0+Vdoxcz3OOZhtvaFjeicfUsdcxl
 S+AA=
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

After commit bfb24564b5fd ("tty: vt/keyboard: use __free()"), builds
using asm goto for put_user() and get_user() with a version of clang
older than 17 error with:

  drivers/tty/vt/keyboard.c:1709:7: error: cannot jump from this asm goto statement to one of its possible targets
                  if (put_user(asize, &a->kb_cnt))
                      ^
  ...
  arch/arm64/include/asm/uaccess.h:298:2: note: expanded from macro '__put_mem_asm'
          asm goto(                                                       \
          ^
  drivers/tty/vt/keyboard.c:1687:7: note: possible target of asm goto statement
                  if (put_user(asize, &a->kb_cnt))
                      ^
  ...
  arch/arm64/include/asm/uaccess.h:342:2: note: expanded from macro '__raw_put_user'
          __rpu_failed:                                                   \
          ^
  drivers/tty/vt/keyboard.c:1697:23: note: jump exits scope of variable with __attribute__((cleanup))
                  void __free(kfree) *buf = kmalloc_array(MAX_DIACR, sizeof(struct kbdiacruc),
                                      ^
  drivers/tty/vt/keyboard.c:1671:33: note: jump bypasses initialization of variable with __attribute__((cleanup))
                  struct kbdiacr __free(kfree) *dia = kmalloc_array(MAX_DIACR, sizeof(struct kbdiacr),
                                                ^

Prior to a fix to clang's scope checker in clang 17 [1], all labels in a
function were validated as potential targets of all asm gotos in a
function, regardless of whether they actually were a target of an asm
goto call, resulting in false positive errors about skipping over
variables marked with the cleanup attribute.

To workaround this error, split up the bodies of the case statements in
vt_do_diacrit() into their own functions so that the scope checker does
not trip up on the multiple instances of __free().

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202509091702.Oc7eCRDw-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202511241835.EA8lShgH-lkp@intel.com/
Link: https://github.com/llvm/llvm-project/commit/f023f5cdb2e6c19026f04a15b5a935c041835d14 [1]
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 drivers/tty/vt/keyboard.c | 221 ++++++++++++++++++++++++----------------------
 1 file changed, 115 insertions(+), 106 deletions(-)

diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index d65fc60dd7be..3538d54d6a6a 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -1649,134 +1649,143 @@ int __init kbd_init(void)
 
 /* Ioctl support code */
 
-/**
- *	vt_do_diacrit		-	diacritical table updates
- *	@cmd: ioctl request
- *	@udp: pointer to user data for ioctl
- *	@perm: permissions check computed by caller
- *
- *	Update the diacritical tables atomically and safely. Lock them
- *	against simultaneous keypresses
- */
-int vt_do_diacrit(unsigned int cmd, void __user *udp, int perm)
+static int vt_do_kdgkbdiacr(void __user *udp)
 {
-	int asize;
-
-	switch (cmd) {
-	case KDGKBDIACR:
-	{
-		struct kbdiacrs __user *a = udp;
-		int i;
+	struct kbdiacrs __user *a = udp;
+	int i, asize;
 
-		struct kbdiacr __free(kfree) *dia = kmalloc_array(MAX_DIACR, sizeof(struct kbdiacr),
-								  GFP_KERNEL);
-		if (!dia)
-			return -ENOMEM;
+	struct kbdiacr __free(kfree) *dia = kmalloc_array(MAX_DIACR, sizeof(struct kbdiacr),
+							  GFP_KERNEL);
+	if (!dia)
+		return -ENOMEM;
 
-		/* Lock the diacriticals table, make a copy and then
-		   copy it after we unlock */
-		scoped_guard(spinlock_irqsave, &kbd_event_lock) {
-			asize = accent_table_size;
-			for (i = 0; i < asize; i++) {
-				dia[i].diacr = conv_uni_to_8bit(accent_table[i].diacr);
-				dia[i].base = conv_uni_to_8bit(accent_table[i].base);
-				dia[i].result = conv_uni_to_8bit(accent_table[i].result);
-			}
+	/* Lock the diacriticals table, make a copy and then
+	   copy it after we unlock */
+	scoped_guard(spinlock_irqsave, &kbd_event_lock) {
+		asize = accent_table_size;
+		for (i = 0; i < asize; i++) {
+			dia[i].diacr = conv_uni_to_8bit(accent_table[i].diacr);
+			dia[i].base = conv_uni_to_8bit(accent_table[i].base);
+			dia[i].result = conv_uni_to_8bit(accent_table[i].result);
 		}
-
-		if (put_user(asize, &a->kb_cnt))
-			return -EFAULT;
-		if (copy_to_user(a->kbdiacr, dia, asize * sizeof(struct kbdiacr)))
-			return -EFAULT;
-		return 0;
 	}
-	case KDGKBDIACRUC:
-	{
-		struct kbdiacrsuc __user *a = udp;
 
-		void __free(kfree) *buf = kmalloc_array(MAX_DIACR, sizeof(struct kbdiacruc),
-							GFP_KERNEL);
-		if (buf == NULL)
-			return -ENOMEM;
+	if (put_user(asize, &a->kb_cnt))
+		return -EFAULT;
+	if (copy_to_user(a->kbdiacr, dia, asize * sizeof(struct kbdiacr)))
+		return -EFAULT;
+	return 0;
+}
 
-		/* Lock the diacriticals table, make a copy and then
-		   copy it after we unlock */
-		scoped_guard(spinlock_irqsave, &kbd_event_lock) {
-			asize = accent_table_size;
-			memcpy(buf, accent_table, asize * sizeof(struct kbdiacruc));
-		}
+static int vt_do_kdgkbdiacruc(void __user *udp)
+{
+	struct kbdiacrsuc __user *a = udp;
+	int asize;
 
-		if (put_user(asize, &a->kb_cnt))
-			return -EFAULT;
-		if (copy_to_user(a->kbdiacruc, buf, asize * sizeof(struct kbdiacruc)))
-			return -EFAULT;
+	void __free(kfree) *buf = kmalloc_array(MAX_DIACR, sizeof(struct kbdiacruc),
+						GFP_KERNEL);
+	if (buf == NULL)
+		return -ENOMEM;
 
-		return 0;
+	/* Lock the diacriticals table, make a copy and then
+	   copy it after we unlock */
+	scoped_guard(spinlock_irqsave, &kbd_event_lock) {
+		asize = accent_table_size;
+		memcpy(buf, accent_table, asize * sizeof(struct kbdiacruc));
 	}
 
-	case KDSKBDIACR:
-	{
-		struct kbdiacrs __user *a = udp;
-		struct kbdiacr __free(kfree) *dia = NULL;
-		unsigned int ct;
-		int i;
+	if (put_user(asize, &a->kb_cnt))
+		return -EFAULT;
+	if (copy_to_user(a->kbdiacruc, buf, asize * sizeof(struct kbdiacruc)))
+		return -EFAULT;
 
-		if (!perm)
-			return -EPERM;
-		if (get_user(ct, &a->kb_cnt))
-			return -EFAULT;
-		if (ct >= MAX_DIACR)
-			return -EINVAL;
+	return 0;
+}
 
-		if (ct) {
-			dia = memdup_array_user(a->kbdiacr,
-						ct, sizeof(struct kbdiacr));
-			if (IS_ERR(dia))
-				return PTR_ERR(dia);
-		}
+static int vt_do_kdskbdiacr(void __user *udp, int perm)
+{
+	struct kbdiacrs __user *a = udp;
+	struct kbdiacr __free(kfree) *dia = NULL;
+	unsigned int ct;
+	int i;
 
-		guard(spinlock_irqsave)(&kbd_event_lock);
-		accent_table_size = ct;
-		for (i = 0; i < ct; i++) {
-			accent_table[i].diacr =
-					conv_8bit_to_uni(dia[i].diacr);
-			accent_table[i].base =
-					conv_8bit_to_uni(dia[i].base);
-			accent_table[i].result =
-					conv_8bit_to_uni(dia[i].result);
-		}
+	if (!perm)
+		return -EPERM;
+	if (get_user(ct, &a->kb_cnt))
+		return -EFAULT;
+	if (ct >= MAX_DIACR)
+		return -EINVAL;
 
-		return 0;
+	if (ct) {
+		dia = memdup_array_user(a->kbdiacr,
+					ct, sizeof(struct kbdiacr));
+		if (IS_ERR(dia))
+			return PTR_ERR(dia);
 	}
 
-	case KDSKBDIACRUC:
-	{
-		struct kbdiacrsuc __user *a = udp;
-		unsigned int ct;
-		void __free(kfree) *buf = NULL;
+	guard(spinlock_irqsave)(&kbd_event_lock);
+	accent_table_size = ct;
+	for (i = 0; i < ct; i++) {
+		accent_table[i].diacr =
+				conv_8bit_to_uni(dia[i].diacr);
+		accent_table[i].base =
+				conv_8bit_to_uni(dia[i].base);
+		accent_table[i].result =
+				conv_8bit_to_uni(dia[i].result);
+	}
 
-		if (!perm)
-			return -EPERM;
+	return 0;
+}
 
-		if (get_user(ct, &a->kb_cnt))
-			return -EFAULT;
+static int vt_do_kdskbdiacruc(void __user *udp, int perm)
+{
+	struct kbdiacrsuc __user *a = udp;
+	unsigned int ct;
+	void __free(kfree) *buf = NULL;
 
-		if (ct >= MAX_DIACR)
-			return -EINVAL;
+	if (!perm)
+		return -EPERM;
 
-		if (ct) {
-			buf = memdup_array_user(a->kbdiacruc,
-						ct, sizeof(struct kbdiacruc));
-			if (IS_ERR(buf))
-				return PTR_ERR(buf);
-		}
-		guard(spinlock_irqsave)(&kbd_event_lock);
-		if (ct)
-			memcpy(accent_table, buf,
-					ct * sizeof(struct kbdiacruc));
-		accent_table_size = ct;
-		return 0;
+	if (get_user(ct, &a->kb_cnt))
+		return -EFAULT;
+
+	if (ct >= MAX_DIACR)
+		return -EINVAL;
+
+	if (ct) {
+		buf = memdup_array_user(a->kbdiacruc,
+					ct, sizeof(struct kbdiacruc));
+		if (IS_ERR(buf))
+			return PTR_ERR(buf);
 	}
+	guard(spinlock_irqsave)(&kbd_event_lock);
+	if (ct)
+		memcpy(accent_table, buf,
+				ct * sizeof(struct kbdiacruc));
+	accent_table_size = ct;
+	return 0;
+}
+
+/**
+ *	vt_do_diacrit		-	diacritical table updates
+ *	@cmd: ioctl request
+ *	@udp: pointer to user data for ioctl
+ *	@perm: permissions check computed by caller
+ *
+ *	Update the diacritical tables atomically and safely. Lock them
+ *	against simultaneous keypresses
+ */
+int vt_do_diacrit(unsigned int cmd, void __user *udp, int perm)
+{
+	switch (cmd) {
+	case KDGKBDIACR:
+		return vt_do_kdgkbdiacr(udp);
+	case KDGKBDIACRUC:
+		return vt_do_kdgkbdiacruc(udp);
+	case KDSKBDIACR:
+		return vt_do_kdskbdiacr(udp, perm);
+	case KDSKBDIACRUC:
+		return vt_do_kdskbdiacruc(udp, perm);
 	}
 	return 0;
 }

---
base-commit: da218406dd50e0ac96bb383de4edd208286efe70
change-id: 20251125-tty-vt-keyboard-wa-clang-scope-check-error-be4d5d7d5f2e

Best regards,
--  
Nathan Chancellor <nathan@kernel.org>

