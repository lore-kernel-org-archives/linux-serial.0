Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800FC26C3BF;
	Thu, 14 Aug 2025 07:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755156301; cv=none; b=NNFdFrZU+MUH7wQk1c7flrwg6bdk+yEvd27mqAzLdILtvy9Wvi/D7DtdGugej9zymNKiwmTxPsoGFJVUQAW/tTqSggM+7Ur+bfnrNC181zcMju+VBRSBhv83W7X29huQkH/ngR8VWwz48BV4tiXoU59n1hk3yH8X3PLWr/zBFBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755156301; c=relaxed/simple;
	bh=QhsAJGg4mwcRyJtNu+7ib9GBTrB5jjTqiaf6YrykiPc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qxYRjTv60p+84iUoubmmy+cUsPY61gtDUlRPRk7WvTFMViHCmgOsFR4GkMeG99JOBMhFkiVNpJxkHNt5xCa9cW48VWIApMDgXG+6PuaUbx9r7dbsqa2J2O8yD7yx0u/olCe+ny43ju1SLZ+Qlto4xCusbuQbxhWqpOFtB18Yd3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QcDoDHga; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QcDoDHga"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFB1AC4CEEF;
	Thu, 14 Aug 2025 07:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755156301;
	bh=QhsAJGg4mwcRyJtNu+7ib9GBTrB5jjTqiaf6YrykiPc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QcDoDHgaDBzpiZp+U9lIGsJP+PEk8NFwY32z33/dqTI6pXw6MmkMZrRKglhnH0Ibn
	 6Dz0itjV7bu5BB1CrTTkSlGKT0zIo007lBDKfpB2Zm/odHe7F+qN9X/BH8bPH85L2Z
	 MJFry6z+FS2vRN13MQdFYh/dLu/wt+IiDe0eewWJRlZwjqnJxh+osjOXyOrqTuOIjk
	 BRvdep4RWg4K63v5YhdhlyggNkKW1ORCOA6UHfrp3QnJmf8+0OA8lh3ExPXwqoUF3l
	 C41TKeq29FXG36aTP8o9vL47QxnLYMYY9J49obdcgUrAC5hmOfkgMqqo7lTIYS/Rw9
	 r+XjH627LrZ+A==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 01/16] console: introduce console_lock guard()s
Date: Thu, 14 Aug 2025 09:24:41 +0200
Message-ID: <20250814072456.182853-2-jirislaby@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814072456.182853-1-jirislaby@kernel.org>
References: <20250814072456.182853-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Having this, guards like these work:
  guard(console_lock)();
or
  scoped_guard(console_lock) {
    ...
  }

See e.g. "vc_screen: use guard()s" later in this series.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 include/linux/console.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/console.h b/include/linux/console.h
index 8f10d0a85bb4..031a58dc2b91 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -666,6 +666,8 @@ void vcs_remove_sysfs(int index);
  */
 extern atomic_t ignore_console_lock_warning;
 
+DEFINE_LOCK_GUARD_0(console_lock, console_lock(), console_unlock());
+
 extern void console_init(void);
 
 /* For deferred console takeover */
-- 
2.50.1

