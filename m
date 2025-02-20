Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2031F2382;
	Thu, 20 Feb 2025 11:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740050195; cv=none; b=EBZ0YdwTpmF4t0H7AQskllz9D5Y7jjRlPDooM1O91ms28lXizO1I+xcW6n5wuealSQbdYOc7UZ7f6vlttDrTcGcq4CxdXAfKKgasPSGBZOIghJj47Hgpe4V+Pite39LQaM9IKNCdNlZ0I6ZDw8KxX0JKTsCfV6UTV/f2aO8XXlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740050195; c=relaxed/simple;
	bh=Bl6yKET3mu+yr5UFjN4IPYvSxd4VgCuhhypyQxdUI4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y7axDehc0yaMpR8m8XtuRu9zLM/Dv8seMnfqagoDjPFrWoS1gvUqrhSPZj/Ev4QA/gbcNOkXVBWA/z8eaUKqR15j97so5N8Y3tDAjZb9Qdi4Z2xXeNXk1Gv+U/I8M4sdt5gZhXv22wynKeQo71jMFch/mJ0RGCFivre/1ndoUBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U6cLyFmW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U6cLyFmW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7106DC4CED1;
	Thu, 20 Feb 2025 11:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740050195;
	bh=Bl6yKET3mu+yr5UFjN4IPYvSxd4VgCuhhypyQxdUI4w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U6cLyFmWDOMjVJzHPMWBkCmwJQhQFxQugTQilkUWS7Ffvj5t1SSRqrpd6RtxGFThr
	 nOFuYkS07cI87dnV4RISYcQ3tV44Kt9gfrTvLd8R071SHgT1PFYpdB1UhzBKZtuN4B
	 JqrTWrXyhgDlyESu+9KP4fYpGdu7NIatPnsyq5c1Md84M3I2sBcKC+gBGFR0wHWN8U
	 LswZqUAD/nKGJDWDjdAsg2J97LAs/1MwTHN6ur9N4qhe5yyBw0d2tb2sk+lpm/aljo
	 e/D+0XlzgWO2norAZ2kK1Ee04Ee1DwIbOR9WcY6spsZylVToV0ZNhmyKM+eqbwtMj4
	 miHom5GsHalxw==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 14/29] tty: tty_driver: document both {,__}tty_alloc_driver() properly
Date: Thu, 20 Feb 2025 12:15:51 +0100
Message-ID: <20250220111606.138045-15-jirislaby@kernel.org>
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
2.48.1

