From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH tty-next 4/4] n_tty: Flush echoes for signal chars
Date: Mon,  2 Dec 2013 16:12:05 -0500
Message-ID: <1386018725-4781-5-git-send-email-peter@hurleysoftware.com>
References: <1386018725-4781-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1386018725-4781-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>, stable@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Since echoes are batched and only flushed when completing the
current input processing, signal chars may appear in subsequent
output rather than trailing current output. Although the echo byte
code is immediately added to the echo buffer, the echo buffer
processing may be deferred. Also, because the signal is sent before
the echo buffer is processed, the tty state may change before the
echo buffer is flushed.

Preserve observed order; flush echoes before signalling.

Cc: <stable@vger.kernel.org> # 3.12.x
Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/n_tty.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 72a5c32..2c9dc7b 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -1278,7 +1278,9 @@ n_tty_receive_signal_char(struct tty_struct *tty, int signal, unsigned char c)
 		start_tty(tty);
 	if (L_ECHO(tty)) {
 		echo_char(c, tty);
-		commit_echoes(tty);
+		flush_echoes(tty);
+		if (tty->ops->flush_chars)
+			tty->ops->flush_chars(tty);
 	}
 	isig(signal, tty);
 	return;
-- 
1.8.1.2
