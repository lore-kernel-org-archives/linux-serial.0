From: Alan Cox <alan@redhat.com>
Subject: [PATCH 21/27] audit: Handle embedded NUL in TTY input auditing
Date: Fri, 10 Oct 2008 11:50:47 +0100
Message-ID: <20081010105042.31597.81024.stgit@localhost.localdomain>
References: <20081010103447.31597.42992.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:47601 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759546AbYJJKuu (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 10 Oct 2008 06:50:50 -0400
In-Reply-To: <20081010103447.31597.42992.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: torvalds@osdl.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

From: Miloslav Trmac <mitr@redhat.com>

Data read from a TTY can contain an embedded NUL byte (e.g. after
pressing Ctrl-2, or sent to a PTY).  After the previous patch, the data
would be logged only up to the first NUL.

This patch modifies the AUDIT_TTY record to always use the hexadecimal
format, which does not terminate at the first NUL byte.  The vast
majority of recorded TTY input data will contain either ' ' or '\n', so
the hexadecimal format would have been used anyway.

Signed-off-by: Miloslav Trmac <mitr@redhat.com>
Signed-off-by: Alan Cox <alan@redhat.com>
---

 drivers/char/tty_audit.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/char/tty_audit.c b/drivers/char/tty_audit.c
index 3582f43..5787249 100644
--- a/drivers/char/tty_audit.c
+++ b/drivers/char/tty_audit.c
@@ -93,7 +93,7 @@ static void tty_audit_buf_push(struct task_struct *tsk, uid_t loginuid,
 		get_task_comm(name, tsk);
 		audit_log_untrustedstring(ab, name);
 		audit_log_format(ab, " data=");
-		audit_log_n_untrustedstring(ab, buf->data, buf->valid);
+		audit_log_n_hex(ab, buf->data, buf->valid);
 		audit_log_end(ab);
 	}
 	buf->valid = 0;

