From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 1/2] tty: wipe buffer.
Date: Thu,  4 Oct 2018 11:06:13 -0700
Message-ID: <20181004180614.25619-2-gregkh@linuxfoundation.org>
References: <20181004180614.25619-1-gregkh@linuxfoundation.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181004180614.25619-1-gregkh@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, jslaby@suse.com, aszlig@nix.build, gmazyland@gmail.com, torvalds@linux-foundation.org, w@1wt.eu, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-serial@vger.kernel.org

From: Linus Torvalds <torvalds@linux-foundation.org>

After we are done with the tty buffer, zero it out.

Reported-by: aszlig <aszlig@nix.build>
Tested-by: Milan Broz <gmazyland@gmail.com>
Tested-by: aszlig <aszlig@nix.build>
Cc: Willy Tarreau <w@1wt.eu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
v2 - no change

 drivers/tty/tty_buffer.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
index c996b6859c5e..ae3ce330200e 100644
--- a/drivers/tty/tty_buffer.c
+++ b/drivers/tty/tty_buffer.c
@@ -468,11 +468,15 @@ receive_buf(struct tty_port *port, struct tty_buffer *head, int count)
 {
 	unsigned char *p = char_buf_ptr(head, head->read);
 	char	      *f = NULL;
+	int n;
 
 	if (~head->flags & TTYB_NORMAL)
 		f = flag_buf_ptr(head, head->read);
 
-	return port->client_ops->receive_buf(port, p, f, count);
+	n = port->client_ops->receive_buf(port, p, f, count);
+	if (n > 0)
+		memset(p, 0, n);
+	return n;
 }
 
 /**
-- 
2.19.0
