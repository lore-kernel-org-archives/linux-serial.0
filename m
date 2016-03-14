From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 1/9] serial: doc: Un-document non-existing uart_write_console()
Date: Mon, 14 Mar 2016 16:16:09 +0100
Message-ID: <1457968577-22379-2-git-send-email-geert+renesas@glider.be>
References: <1457968577-22379-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1457968577-22379-1-git-send-email-geert+renesas@glider.be>
Sender: linux-doc-owner@vger.kernel.org
To: Russell King <rmk@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-serial@vger.kernel.org, linux-doc@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

uart_write_console() never existed, not even when the "new
uart_write_console function" was documented.

Fixes: 67ab7f596b6adbae ("[SERIAL] Update serial driver documentation")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/serial/driver | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/Documentation/serial/driver b/Documentation/serial/driver
index 379468e12680dbfb..e7c6f86ee06f9927 100644
--- a/Documentation/serial/driver
+++ b/Documentation/serial/driver
@@ -28,11 +28,6 @@ The serial core provides a few helper functions.  This includes identifing
 the correct port structure (via uart_get_console) and decoding command line
 arguments (uart_parse_options).
 
-There is also a helper function (uart_write_console) which performs a
-character by character write, translating newlines to CRLF sequences.
-Driver writers are recommended to use this function rather than implementing
-their own version.
-
 
 Locking
 -------
-- 
1.9.1

