Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1E047884D;
	Fri, 25 Sep 2026 09:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790329450; cv=none; b=qR6FdbP6NR7wP5BLx9tgPCe/CVP8bIfQfaAPBXxQSKRW6MAcRg0QbWxD3Ziha1huLjETjz8LsNkep0XtfZkml7uxaaL2au7CZz8NE8EmGdtVRmPh/bY2N+PaqrKFTE4AxVOWlFyqGTZlv2VGxvV93fMTKk/rlpT4YJTpDyu7M1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790329450; c=relaxed/simple;
	bh=+uGEF6cyfJn7ZvbN7VEIpK5iV5SqkmmzHZTYvxJYZdo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rh4xiPrO1QJEAXjoW/bzKBlhnIEgMvJpfwsS0ZeyLr09YcBmy1lVPKwO51v5NV4UmGNjjW8YIckisMgOlWW/9nFEUA16U9BtkrjggbeZT+th/uiMSZAJBJmTwfAVsICKowmyFGwwmxD9gjlzDaDfdmza2J1sGK/gQ82jiWSijxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WbWYKcvn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WbWYKcvn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 171DF1F000FF;
	Fri, 25 Sep 2026 09:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790329449;
	bh=YS8ouHTwp4S5wzYIznZ88aVy+hsr6GnxP3ITQR6cDs0=;
	h=From:To:Cc:Subject:Date;
	b=WbWYKcvnW5TS1O6+/xBGoURtyDC7fWtx4NckSzljYQyCm3b6brfHjQJ/3ZUKY5OQ5
	 ABWofpVmwlykTgTvozWt6GPltCLrHI/jlnaeiPGET1retxngRdVdPT9cKDYu+tGwRh
	 hAbJDXnZISX6r8ZxrG5ZfTdBIYJoXB+KhioOh3BqqcpHg/yTUpJSVcmDszzbmedqAS
	 sakttmckTI36x6joZem/P9vL/tx35Qn8aFeUSL+17xUFupjmJnwtIjVwppnClrynfq
	 Jri0IEX0rqQUZ3txUBpwUhT0iDe/Pe/R0XddYl6ykhNmzQKbhybKJW1VT3HxpH4ffp
	 DNCqBtL6oxn5Q==
Received: from johan by xi.lan with local (Exim 4.99.5)
	(envelope-from <johan@kernel.org>)
	id 1xA2TO-00000000DqJ-2X2B;
	Fri, 25 Sep 2026 11:44:06 +0200
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] tty: add break_wait kernel-doc
Date: Fri, 25 Sep 2026 11:42:22 +0200
Message-ID: <20260925094222.18303-1-johan@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the missing kernel-doc description for the new break_wait field in
struct tty_struct.

Fixes: c7e9bff9b4b3 ("tty: abort break signalling on hangup")
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Link: https://lore.kernel.org/20d75a7a-2e7a-484f-a267-c21db82dd922@infradead.org
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 include/linux/tty.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/tty.h b/include/linux/tty.h
index ad4e4a835f90..833bb7b97ceb 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -168,6 +168,7 @@ struct tty_operations;
  * @write_wait: concurrent writers are waiting in this queue until they are
  *		allowed to write
  * @read_wait: readers wait for data in this queue
+ * @break_wait: wait queue for timed breaks
  * @hangup_work: normally a work to perform a hangup (do_tty_hangup()); while
  *		 freeing the tty, (re)used to release_one_tty()
  * @disc_data: pointer to @ldisc's private data (e.g. to &struct n_tty_data)
-- 
2.55.0

