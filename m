Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0AB220680;
	Mon, 17 Mar 2025 07:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742194873; cv=none; b=kcVGWvwuw2PfFGHqkdZaf1tXjyyJJhOjrEHGmYZXHkCYCz1Wv09paHMnVWu3ZWI5KdI8cxXRSHLC2WNOJxA6UUNh9H84ZQTHTAr1OSjhGfo18HeGCezsg4OizSEK06aWbMj5QZ+PclYHNNv/Js6X9ts9JLeyMSJVmd4JIsTsWhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742194873; c=relaxed/simple;
	bh=BwMqY4GhVZC/Tg+ai7GbA+iNWvaoAB6mjbKe0KEA5tc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LCfUxMJ8fvVq6skZJViphQTG5higcC0Ddv3zomCjybTR3Lp3yYo1EbXH/8usE+zUTqfzMcAhKgKqDN7qss0rTFifkm6lEY/y2dP8VDDsS51f8SGPh96WJ9GA41cT9gHpqSm+oh+sIwD/6fgoZD4OGNwpXq05WdbvRaBjD+kOomE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BJgJ2aij; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BJgJ2aij"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5385FC4CEEE;
	Mon, 17 Mar 2025 07:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742194873;
	bh=BwMqY4GhVZC/Tg+ai7GbA+iNWvaoAB6mjbKe0KEA5tc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BJgJ2aijIZ4aRlCL/pSg/mGKtfqIjjl7LbUNEi1CHDW3JqKUMxXy1TgOvSs1bn1qS
	 d3IYMs1+Q7M2Hvg1C+gDEL8hirAOetlk1RhbHjXBmfdeyhNZTL+rby/uFdZjQ66UHv
	 Dldi1W6qEfVWjmgolI5Ip8CmrJ+CIoUUFdTy78N9GoBugU0TU9C4Od/5zKcsv8bcQs
	 mxMkRE7X7XsKtXkwnXadwxdAsAGi6c/8hwkJKoPyKKNSGU/xZRsqy+iKaddLB+fBUK
	 OSecr4XZ1nhuQz+y6D16FUt6sITU3u4R+fcihjueMqpWBtpjBN0B4s5idngccTaWBV
	 EkJqCw0h1EWrA==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH v2 15/31] tty: tty_driver: introduce TTY driver sub/types enums
Date: Mon, 17 Mar 2025 08:00:30 +0100
Message-ID: <20250317070046.24386-16-jirislaby@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250317070046.24386-1-jirislaby@kernel.org>
References: <20250317070046.24386-1-jirislaby@kernel.org>
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
2.49.0

