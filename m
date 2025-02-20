Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A07C1FECD1;
	Thu, 20 Feb 2025 11:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740050197; cv=none; b=TBzdJGeh3HPfMEMe8pHp053+6UXq7BzhbqOyUL2FQX1FVBotOVs2N2IAChUVEA5Ngc6IjcX9J+M9VzC9UTWRLnBdZgF/oyFGx7NJkMcytXv2u7K3M75zX36TQETSYLmt490AUNj5nPPqpG+gTekcsKzxTS5oNGL9ORvwMCQ4l84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740050197; c=relaxed/simple;
	bh=eym0iQyZ+wC53dbebkT2FnQUWTN2XX6Qz6fKjwQmFOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RpLF3kq0bBvTLrHLnCXzChDDTP/ZouZl588TQTpTDTp6Na1ZUCT4/VrGkwCc4n4+mWdXaGTc7wkhEjL3eAI1c93KfDOQBLGlreD9yyrQp9SCnYG6kF0lFaRSm9rA4ncrU1eeiV3TEPT4VxrNRCz4ih7kYGYZamTZvwuersO7orU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uGLp12yw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uGLp12yw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F068FC4CED1;
	Thu, 20 Feb 2025 11:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740050197;
	bh=eym0iQyZ+wC53dbebkT2FnQUWTN2XX6Qz6fKjwQmFOQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uGLp12ywQpgZg5ui/tq14M64m7BPtmF4oidyguOsr2I2tOh/VQdmR5Z105lSCleDB
	 e71P7Ye/HJ0FikeRAfheun9nEbjK+OgK0D3UUUKvtLoQ0dMW13CrfolDa9Woqa/Z4I
	 /GsnBLMJ+Hh5p6ZBx4wdsk8WfRQkSirwwZBTE2rKE8/5irt7vQo7MwFAG3itRMlcY8
	 mdUTGVXAdJoQ9e2JUrM25NAncmKV+tvzAA9uKoyhwunpSXndV3pJQ7tVzUo9AOkRgy
	 VXBFtvZ22UtNm3zIdrNuxfZWx32CUjUPIpMQgTabIyFGOR7c0gidiMdBm58cPw+7ol
	 YgRZqU1GYxzhA==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 15/29] tty: tty_driver: introduce TTY driver sub/types enums
Date: Thu, 20 Feb 2025 12:15:52 +0100
Message-ID: <20250220111606.138045-16-jirislaby@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250220111606.138045-1-jirislaby@kernel.org>
References: <20250220111606.138045-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert TTY_DRIVER_TYPE_*, and subtype macros to two enums:
tty_driver_type and tty_driver_subtype. This allows for easier
kernel-doc (later), grouping of these nicely, and proper checking.

The tty_driver's ::type and ::subtype now use these enums instead of
bare "short".

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 include/linux/tty_driver.h | 42 +++++++++++++++++++-------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/include/linux/tty_driver.h b/include/linux/tty_driver.h
index 0fe38befa1b8..188ee9b768eb 100644
--- a/include/linux/tty_driver.h
+++ b/include/linux/tty_driver.h
@@ -81,26 +81,26 @@ enum tty_driver_flag {
 	TTY_DRIVER_UNNUMBERED_NODE	= BIT(7),
 };
 
-/* tty driver types */
-#define TTY_DRIVER_TYPE_SYSTEM		0x0001
-#define TTY_DRIVER_TYPE_CONSOLE		0x0002
-#define TTY_DRIVER_TYPE_SERIAL		0x0003
-#define TTY_DRIVER_TYPE_PTY		0x0004
-#define TTY_DRIVER_TYPE_SCC		0x0005	/* scc driver */
-#define TTY_DRIVER_TYPE_SYSCONS		0x0006
+enum tty_driver_type {
+	TTY_DRIVER_TYPE_SYSTEM,
+	TTY_DRIVER_TYPE_CONSOLE,
+	TTY_DRIVER_TYPE_SERIAL,
+	TTY_DRIVER_TYPE_PTY,
+	TTY_DRIVER_TYPE_SCC,
+	TTY_DRIVER_TYPE_SYSCONS,
+};
 
-/* system subtypes (magic, used by tty_io.c) */
-#define SYSTEM_TYPE_TTY			0x0001
-#define SYSTEM_TYPE_CONSOLE		0x0002
-#define SYSTEM_TYPE_SYSCONS		0x0003
-#define SYSTEM_TYPE_SYSPTMX		0x0004
+enum tty_driver_subtype {
+	SYSTEM_TYPE_TTY = 1,
+	SYSTEM_TYPE_CONSOLE,
+	SYSTEM_TYPE_SYSCONS,
+	SYSTEM_TYPE_SYSPTMX,
 
-/* pty subtypes (magic, used by tty_io.c) */
-#define PTY_TYPE_MASTER			0x0001
-#define PTY_TYPE_SLAVE			0x0002
+	PTY_TYPE_MASTER = 1,
+	PTY_TYPE_SLAVE,
 
-/* serial subtype definitions */
-#define SERIAL_TYPE_NORMAL	1
+	SERIAL_TYPE_NORMAL = 1,
+};
 
 /**
  * struct tty_operations -- interface between driver and tty
@@ -500,8 +500,8 @@ struct tty_operations {
  * @major: major /dev device number (zero for autoassignment)
  * @minor_start: the first minor /dev device number
  * @num: number of devices allocated
- * @type: type of tty driver (%TTY_DRIVER_TYPE_)
- * @subtype: subtype of tty driver (%SYSTEM_TYPE_, %PTY_TYPE_, %SERIAL_TYPE_)
+ * @type: type of tty driver (enum tty_driver_type)
+ * @subtype: subtype of tty driver (enum tty_driver_subtype)
  * @init_termios: termios to set to each tty initially (e.g. %tty_std_termios)
  * @flags: tty driver flags (%TTY_DRIVER_)
  * @proc_entry: proc fs entry, used internally
@@ -533,8 +533,8 @@ struct tty_driver {
 	int	major;
 	int	minor_start;
 	unsigned int	num;
-	short	type;
-	short	subtype;
+	enum tty_driver_type type;
+	enum tty_driver_subtype subtype;
 	struct ktermios init_termios;
 	unsigned long	flags;
 	struct proc_dir_entry *proc_entry;
-- 
2.48.1

