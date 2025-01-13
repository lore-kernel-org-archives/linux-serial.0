Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5E819AD89;
	Mon, 13 Jan 2025 17:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736789381; cv=none; b=D4OWsrDkKw5reo9GVw3PM+9boj6sil/yf+xr6bRNEO7+YMtXaBqMWD2gWj+KPDCENtqtAkk0q8kJkFw2LQe1yaaif1z9h6ZIi9e+MaYTZHG4agZcvbYvI1NO2q5wmo5D4lEIeESUcvuvi3KqPdoCnhA3APO+k+LZVovKv2BwI6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736789381; c=relaxed/simple;
	bh=cYjcc85+H8R+vEjKm0YH0fZ+HT1VtYfHRkiWKETVGSE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lgVX1yVW20sk0jcY0gVQYeM/kk1IF9S7gY8IV1um1wzYTNM8UXDtstk58EfG2Wated8cEW8M/l1qTaqcZKJra5ryk+30dhR1y5r3QaHnnVYfkzIbZlibWL7qPrl50+TiYLHjlHH5k0ljhM6FETpqFIJeUefi4FlIPoVSxvqUkHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ojg1nxdw; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ojg1nxdw"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7bcf32a6582so183822885a.1;
        Mon, 13 Jan 2025 09:29:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736789378; x=1737394178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1dwzptJbA/EjJWB5K8L1Kja/eoPMKxVypbBnKctGmAU=;
        b=Ojg1nxdw9I/C9vvFUG4nzH5YCb6XeSbJIEzI6iKNiCyYV2RKj0xOIY7kTBjwY/FeD+
         qS+3IUSMDELmTKU1+8iGbfcB0VSMmGQS9aRytPjGcC4HFkqrwpXcQiYxChYQmf15y3CN
         lYDrXyhHSltaJTcAfJNmBxLKmDCKSc6cEeN3Yp2TrLC1kYus2i/W3lzGUvPXREV2FTHq
         B/66Cn3KKontLKbqCyElpkK5ioHs4F+Ysfhqry3jPDJJBrpsR35TBdXUzru/BLPZIqAs
         j7+y+QKMdAE3tlGzKZwI19Mi6Tjzr6Dyw7IUZjo+h/PfmsRlEcIrJ6WHDbIj7Jl6H5Zz
         nH4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736789378; x=1737394178;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1dwzptJbA/EjJWB5K8L1Kja/eoPMKxVypbBnKctGmAU=;
        b=LEwciFAgh+85yOaZfTG46gnub3hE3gz4S2qyQ6hdmNFB8priQDCN3VJUVSY1wVSD58
         V9m+pkfV01R1Ma1dILx9X8BcX/IIQ6FZxFhCZzummMeXORuI3BhNkNHg7YvECkAGzfHQ
         x9hw5BXoC84s2J6ePzXnXFrfMGWA+LueDEI8CeqYPgegSitkFQMZaSCnl0Q6H3DXN+XH
         95TXFN6Umg3jGy8lTndbHseJBRikJa1E2QfQzwQuMz1W3Zx9ZmoETizUmBmn+3EoF2oO
         Y7jBi/Rp1fHHPgiAM4IgzIZ/fzTS5a9uCmlelG+hPVy28f+T3plhmSMLNuECsINU0E6g
         aGTg==
X-Forwarded-Encrypted: i=1; AJvYcCWX05s8YwXdi3NzFqvccxPl8FNfW2THDuL07ZrBSAa7/12KxNOaDoaGh+boxHrHory0nWv1bKIZtVCuf8Lu@vger.kernel.org, AJvYcCX62uuhmE/AqaJG5JhjqbwKiEA3of2OjOIWwitZbN2RMm9sid4FlmskOsEIKXCt4kkOZNwgDjLCFSfWDz0saGk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNTWITlKJM6Vj+PYmcj2K5bAdYYWLFu+eqTCfL4nvWVjMINs/i
	rWkPouAVqdRX+wMDixQr1yw+zTMCx65mGe37PdKV1QgfiPINcpyv
X-Gm-Gg: ASbGncu8J3FFbDyxgeoU+kPA1a736QtkXYtGHhpAQV2t1K+QqbxKuoLnht1IyKLyTOf
	894CAUOXJiWBqbZC+ZqQW3IQAZuJdTBDK0wRlnXAaSFe7aDq6kGa2e4lvWD16trjOd3GdYKziuA
	NZx0vsPViGKVPS9urfIalpTuaUWEgFn4s8qSLtt87Z6Bu9Z2Q9DavLZxGm7893gmKXJDGCdmHZJ
	n5WT20Jyr8tj6KqL86Bib1ekJdyaWPiY54fA3R72lngOfh+4w==
X-Google-Smtp-Source: AGHT+IEHwAZYgRcAdF5b5La5zLPdgm+NJSBXbTzsxWnAx1AGilOypR1FH5i9Mmtai9bohcpTZCCE1g==
X-Received: by 2002:a05:620a:7207:b0:7bc:db11:4951 with SMTP id af79cd13be357-7bcdb114dd5mr2899749985a.48.1736789378217;
        Mon, 13 Jan 2025 09:29:38 -0800 (PST)
Received: from localhost ([2a03:2880:20ff:41::])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7bce3237f70sm514923185a.5.2025.01.13.09.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 09:29:37 -0800 (PST)
From: Amal Raj T <tjarlama@gmail.com>
To: danielt@kernel.org,
	dianders@chromium.org,
	jason.wessel@windriver.com,
	stephen.s.brennan@oracle.com
Cc: tjarlama@gmail.com,
	amalrajt@meta.com,
	osandov@osandov.com,
	linux-debuggers@vger.kernel.org,
	linux-serial@vger.kernel.org,
	kgdb-bugreport@lists.sourceforge.net
Subject: [PATCH v3 1/3] kgdb: Add kgdb_mem2ebin function for converting memory to binary format
Date: Mon, 13 Jan 2025 09:29:33 -0800
Message-ID: <20250113172936.1434532-2-tjarlama@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250113172936.1434532-1-tjarlama@gmail.com>
References: <gmail>
 <20250113172936.1434532-1-tjarlama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Amal Raj T <amalrajt@meta.com>

Add a new function kgdb_mem2ebin that converts memory to binary
format, escaping special characters ('$', '#', '*', and '}').
These ASCII characters have the following meaning in GDB binary encoding
- `$`: Seven repeats in run-length encoding
- `#`: Six repeats
- `*`: Three repeats
- `}`: Used as escape character
kgdb_mem2ebin function ensures that memory data
is properly formatted and escaped before being
sent over the wire. Additionally, this function
reduces the amount of data exchanged between
debugger compared to hex.

Link: https://sourceware.org/gdb/current/onlinedocs/gdb.html/Overview.html#Binary-Data

Signed-off-by: Amal Raj T <amalrajt@meta.com>
---
 include/linux/kgdb.h   |   1 +
 kernel/debug/gdbstub.c | 119 ++++++++++++++++++++++++++---------------
 2 files changed, 77 insertions(+), 43 deletions(-)

diff --git a/include/linux/kgdb.h b/include/linux/kgdb.h
index 76e891ee9e37..fa3cf38a14de 100644
--- a/include/linux/kgdb.h
+++ b/include/linux/kgdb.h
@@ -322,6 +322,7 @@ extern struct kgdb_io *dbg_io_ops;
 
 extern int kgdb_hex2long(char **ptr, unsigned long *long_val);
 extern char *kgdb_mem2hex(char *mem, char *buf, int count);
+extern char *kgdb_mem2ebin(char *mem, char *buf, int count);
 extern int kgdb_hex2mem(char *buf, char *mem, int count);
 
 extern int kgdb_isremovedbreak(unsigned long addr);
diff --git a/kernel/debug/gdbstub.c b/kernel/debug/gdbstub.c
index f625172d4b67..f88e21d5502a 100644
--- a/kernel/debug/gdbstub.c
+++ b/kernel/debug/gdbstub.c
@@ -39,15 +39,14 @@
 #define KGDB_MAX_THREAD_QUERY 17
 
 /* Our I/O buffers. */
-static char			remcom_in_buffer[BUFMAX];
-static char			remcom_out_buffer[BUFMAX];
-static int			gdbstub_use_prev_in_buf;
-static int			gdbstub_prev_in_buf_pos;
+static char remcom_in_buffer[BUFMAX];
+static char remcom_out_buffer[BUFMAX];
+static int gdbstub_use_prev_in_buf;
+static int gdbstub_prev_in_buf_pos;
 
 /* Storage for the registers, in GDB format. */
-static unsigned long		gdb_regs[(NUMREGBYTES +
-					sizeof(unsigned long) - 1) /
-					sizeof(unsigned long)];
+static unsigned long gdb_regs[(NUMREGBYTES + sizeof(unsigned long) - 1) /
+			      sizeof(unsigned long)];
 
 /*
  * GDB remote protocol parser:
@@ -257,6 +256,49 @@ char *kgdb_mem2hex(char *mem, char *buf, int count)
 	return buf;
 }
 
+/**
+ * Convert memory to binary format for GDB remote protocol transmission,
+ * escaping special characters ($, #, *, and }) using the `}` character as an escape.
+ *
+ * The `$` (seven repeats), `#`(six repeats), `*`(three run-length), and `}`
+ * characters are considered special because they have
+ * specific meanings in the GDB remote protocol. To avoid conflicts, these
+ * characters are escaped by prefixing them with the `}` character and then XORing
+ * the original character with 0x20.
+ *
+ * Examples:
+ *   - `0x7d` (ASCII '}') is transmitted as `0x7d 0x5d`
+ *   - `0x23` (ASCII '#') is transmitted as `0x7d 0x43`
+ */
+char *kgdb_mem2ebin(char *mem, char *buf, int count)
+{
+	char *tmp;
+	int err;
+
+	/* We use the upper half of buf as an intermediate buffer
+	 *	for the raw memory copy.
+	 */
+	tmp = buf + count;
+
+	err = copy_from_kernel_nofault(tmp, mem, count);
+	if (err)
+		return NULL;
+	while (count > 0) {
+		unsigned char c = *tmp;
+
+		if (c == '}' || c == '#' || c == '*' || c == '#') {
+			*buf++ = '}';
+			*buf++ = c ^ 0x20;
+		} else {
+			*buf++ = c;
+		}
+		count -= 1;
+		tmp += 1;
+	}
+
+	return buf;
+}
+
 /*
  * Convert the hex array pointed to by buf into binary to be placed in
  * mem.  Return a pointer to the character AFTER the last byte
@@ -400,7 +442,7 @@ static void error_packet(char *pkt, int error)
  * remapped to negative TIDs.
  */
 
-#define BUF_THREAD_ID_SIZE	8
+#define BUF_THREAD_ID_SIZE 8
 
 static char *pack_threadid(char *pkt, unsigned char *id)
 {
@@ -454,7 +496,6 @@ static struct task_struct *getthread(struct pt_regs *regs, int tid)
 	return find_task_by_pid_ns(tid, &init_pid_ns);
 }
 
-
 /*
  * Remap normal tasks to their real PID,
  * CPU shadow threads are mapped to -CPU - 2
@@ -560,7 +601,7 @@ static void gdb_cmd_memread(struct kgdb_state *ks)
 	char *err;
 
 	if (kgdb_hex2long(&ptr, &addr) > 0 && *ptr++ == ',' &&
-					kgdb_hex2long(&ptr, &length) > 0) {
+	    kgdb_hex2long(&ptr, &length) > 0) {
 		err = kgdb_mem2hex((char *)addr, remcom_out_buffer, length);
 		if (!err)
 			error_packet(remcom_out_buffer, -EINVAL);
@@ -615,8 +656,7 @@ static void gdb_cmd_reg_set(struct kgdb_state *ks)
 	int i = 0;
 
 	kgdb_hex2long(&ptr, &regnum);
-	if (*ptr++ != '=' ||
-	    !(!kgdb_usethread || kgdb_usethread == current) ||
+	if (*ptr++ != '=' || !(!kgdb_usethread || kgdb_usethread == current) ||
 	    !dbg_get_reg(regnum, gdb_regs, ks->linux_regs)) {
 		error_packet(remcom_out_buffer, -EINVAL);
 		return;
@@ -756,14 +796,14 @@ static void gdb_cmd_query(struct kgdb_state *ks)
 			break;
 		}
 		if ((int)ks->threadid > 0) {
-			kgdb_mem2hex(getthread(ks->linux_regs,
-					ks->threadid)->comm,
-					remcom_out_buffer, 16);
+			kgdb_mem2hex(
+				getthread(ks->linux_regs, ks->threadid)->comm,
+				remcom_out_buffer, 16);
 		} else {
 			static char tmpstr[23 + BUF_THREAD_ID_SIZE];
 
 			sprintf(tmpstr, "shadowCPU%d",
-					(int)(-ks->threadid - 2));
+				(int)(-ks->threadid - 2));
 			kgdb_mem2hex(tmpstr, remcom_out_buffer, strlen(tmpstr));
 		}
 		break;
@@ -776,8 +816,8 @@ static void gdb_cmd_query(struct kgdb_state *ks)
 				strcpy(remcom_out_buffer, "E01");
 				break;
 			}
-			kgdb_hex2mem(remcom_in_buffer + 6,
-				     remcom_out_buffer, len);
+			kgdb_hex2mem(remcom_in_buffer + 6, remcom_out_buffer,
+				     len);
 			len = len / 2;
 			remcom_out_buffer[len++] = 0;
 
@@ -895,8 +935,7 @@ static void gdb_cmd_break(struct kgdb_state *ks)
 		error_packet(remcom_out_buffer, -EINVAL);
 		return;
 	}
-	if (*(ptr++) != ',' ||
-		!kgdb_hex2long(&ptr, &length)) {
+	if (*(ptr++) != ',' || !kgdb_hex2long(&ptr, &length)) {
 		error_packet(remcom_out_buffer, -EINVAL);
 		return;
 	}
@@ -906,11 +945,11 @@ static void gdb_cmd_break(struct kgdb_state *ks)
 	else if (remcom_in_buffer[0] == 'z' && *bpt_type == '0')
 		error = dbg_remove_sw_break(addr);
 	else if (remcom_in_buffer[0] == 'Z')
-		error = arch_kgdb_ops.set_hw_breakpoint(addr,
-			(int)length, *bpt_type - '0');
+		error = arch_kgdb_ops.set_hw_breakpoint(addr, (int)length,
+							*bpt_type - '0');
 	else if (remcom_in_buffer[0] == 'z')
-		error = arch_kgdb_ops.remove_hw_breakpoint(addr,
-			(int) length, *bpt_type - '0');
+		error = arch_kgdb_ops.remove_hw_breakpoint(addr, (int)length,
+							   *bpt_type - '0');
 
 	if (error == 0)
 		strcpy(remcom_out_buffer, "OK");
@@ -925,12 +964,10 @@ static int gdb_cmd_exception_pass(struct kgdb_state *ks)
 	 * C15 == detach kgdb, pass exception
 	 */
 	if (remcom_in_buffer[1] == '0' && remcom_in_buffer[2] == '9') {
-
 		ks->pass_exception = 1;
 		remcom_in_buffer[0] = 'c';
 
 	} else if (remcom_in_buffer[1] == '1' && remcom_in_buffer[2] == '5') {
-
 		ks->pass_exception = 1;
 		remcom_in_buffer[0] = 'D';
 		dbg_remove_all_break();
@@ -938,9 +975,11 @@ static int gdb_cmd_exception_pass(struct kgdb_state *ks)
 		return 1;
 
 	} else {
-		gdbstub_msg_write("KGDB only knows signal 9 (pass)"
+		gdbstub_msg_write(
+			"KGDB only knows signal 9 (pass)"
 			" and 15 (pass and disconnect)\n"
-			"Executing a continue without signal passing\n", 0);
+			"Executing a continue without signal passing\n",
+			0);
 		remcom_in_buffer[0] = 'c';
 	}
 
@@ -1050,7 +1089,7 @@ int gdb_serial_stub(struct kgdb_state *ks)
 				goto default_handle;
 			if (tmp == 0)
 				break;
-			fallthrough;	/* on tmp < 0 */
+			fallthrough; /* on tmp < 0 */
 		case 'c': /* Continue packet */
 		case 's': /* Single step packet */
 			if (kgdb_contthread && kgdb_contthread != current) {
@@ -1058,15 +1097,13 @@ int gdb_serial_stub(struct kgdb_state *ks)
 				error_packet(remcom_out_buffer, -EINVAL);
 				break;
 			}
-			fallthrough;	/* to default processing */
+			fallthrough; /* to default processing */
 		default:
 default_handle:
-			error = kgdb_arch_handle_exception(ks->ex_vector,
-						ks->signo,
-						ks->err_code,
-						remcom_in_buffer,
-						remcom_out_buffer,
-						ks->linux_regs);
+			error = kgdb_arch_handle_exception(
+				ks->ex_vector, ks->signo, ks->err_code,
+				remcom_in_buffer, remcom_out_buffer,
+				ks->linux_regs);
 			/*
 			 * Leave cmd processing on error, detach,
 			 * kill, continue, or single step.
@@ -1076,7 +1113,6 @@ int gdb_serial_stub(struct kgdb_state *ks)
 				error = 0;
 				goto kgdb_exit;
 			}
-
 		}
 
 		/* reply to the request */
@@ -1095,12 +1131,9 @@ int gdbstub_state(struct kgdb_state *ks, char *cmd)
 
 	switch (cmd[0]) {
 	case 'e':
-		error = kgdb_arch_handle_exception(ks->ex_vector,
-						   ks->signo,
-						   ks->err_code,
-						   remcom_in_buffer,
-						   remcom_out_buffer,
-						   ks->linux_regs);
+		error = kgdb_arch_handle_exception(
+			ks->ex_vector, ks->signo, ks->err_code,
+			remcom_in_buffer, remcom_out_buffer, ks->linux_regs);
 		return error;
 	case 's':
 	case 'c':
-- 
2.43.5

