Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCB321D590;
	Mon, 17 Mar 2025 07:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742194872; cv=none; b=QPrcaJsNTblWvV59R/Q1n5V4vIxUg7TIJuuDYHrZdqu5t9qAoKr4WA76+4mjORwazYnsC+UxctHS1ivGhcLA2ECN4T2hvYxWbb2HLvd/Zmor9qfK5UHnUSwCXCm4ntpWEJpakGqGAH9tmYjV2KjaLaL5xkcV62HHrV3Y12/zpDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742194872; c=relaxed/simple;
	bh=2OUdKeoS1PZwCLWjaedD25YBR9wFEyiGne6/TIX6YJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fPh/uK7HrWBI4m843CjSz9cQrkmSd7js44Myu/lIsnLRKBqznLq5mfYNwx2U/ehigAgKujAXIShUDjhOi/Uuv7XJb5U/82O5CCQyCet3v74qKmMgFPmBNHTnEOWW3KcZ7MdURm+vEzKAlvZpo/ng17Fns4hAkI5JYAcTfHQ5YdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dnZ8MXuE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dnZ8MXuE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA8B0C4CEE3;
	Mon, 17 Mar 2025 07:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742194871;
	bh=2OUdKeoS1PZwCLWjaedD25YBR9wFEyiGne6/TIX6YJ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dnZ8MXuElHzhTKquQN5wHu05FQfzoR05W5IAGCJcugoniXS1bN0xhb1uAzK7YovAf
	 h3fQ5Dn+ou7chZP0gB3IxZBexchcRvSxmuhHAsAE20ZWsanqqPVfJ1O8yhbD/o/imh
	 9mkass7GKoKs8XCvWwfkyxrHSXOZU9O7CX0moQlw9qD58EpsiZ/3+/+mwb65OpbpFJ
	 3bCv/+Dh7UnXN5CZZF7sFs2COcb55rdG16W2PqtqL3D127Ge+h04UVtNXOcEisImWQ
	 i3SK0O5EleFTYDlsioJBB/w7Zzfbqs/3CFhOTr93oTIFgD62q2gN4T7tjqVqhV29WW
	 C0heEiDGfzS7Q==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH v2 14/31] tty: tty_driver: document both {,__}tty_alloc_driver() properly
Date: Mon, 17 Mar 2025 08:00:29 +0100
Message-ID: <20250317070046.24386-15-jirislaby@kernel.org>
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

__tty_alloc_driver()'s kernel-doc needed some care: describe the return
value using the standard "Returns:", and use the new enum tty_driver_flag
for @flags.

Then, the tty_alloc_driver() macro was undocumented, but referenced many
times in the docs. Copy the docs from the above (except the @owner
parameter, obviously).

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 Documentation/driver-api/tty/tty_driver.rst | 2 ++
 drivers/tty/tty_io.c                        | 8 +++++---
 include/linux/tty_driver.h                  | 8 +++++++-
 3 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/Documentation/driver-api/tty/tty_driver.rst b/Documentation/driver-api/tty/tty_driver.rst
index f6cbffdb6e01..7138222a70f2 100644
--- a/Documentation/driver-api/tty/tty_driver.rst
+++ b/Documentation/driver-api/tty/tty_driver.rst
@@ -25,6 +25,8 @@ freed.
 For reference, both allocation and deallocation functions are explained here in
 detail:
 
+.. kernel-doc:: include/linux/tty_driver.h
+   :identifiers: tty_alloc_driver
 .. kernel-doc:: drivers/tty/tty_io.c
    :identifiers: __tty_alloc_driver tty_driver_kref_put
 
diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 449dbd216460..ca9b7d7bad2b 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -3329,10 +3329,12 @@ EXPORT_SYMBOL(tty_unregister_device);
  * __tty_alloc_driver - allocate tty driver
  * @lines: count of lines this driver can handle at most
  * @owner: module which is responsible for this driver
- * @flags: some of %TTY_DRIVER_ flags, will be set in driver->flags
+ * @flags: some of enum tty_driver_flag, will be set in driver->flags
  *
- * This should not be called directly, some of the provided macros should be
- * used instead. Use IS_ERR() and friends on @retval.
+ * This should not be called directly, tty_alloc_driver() should be used
+ * instead.
+ *
+ * Returns: struct tty_driver or a PTR-encoded error (use IS_ERR() and friends).
  */
 struct tty_driver *__tty_alloc_driver(unsigned int lines, struct module *owner,
 		unsigned long flags)
diff --git a/include/linux/tty_driver.h b/include/linux/tty_driver.h
index d0d940236580..0fe38befa1b8 100644
--- a/include/linux/tty_driver.h
+++ b/include/linux/tty_driver.h
@@ -564,7 +564,13 @@ struct tty_driver *tty_find_polling_driver(char *name, int *line);
 
 void tty_driver_kref_put(struct tty_driver *driver);
 
-/* Use TTY_DRIVER_* flags below */
+/**
+ * tty_alloc_driver - allocate tty driver
+ * @lines: count of lines this driver can handle at most
+ * @flags: some of enum tty_driver_flag, will be set in driver->flags
+ *
+ * Returns: struct tty_driver or a PTR-encoded error (use IS_ERR() and friends).
+ */
 #define tty_alloc_driver(lines, flags) \
 		__tty_alloc_driver(lines, THIS_MODULE, flags)
 
-- 
2.49.0

