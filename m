From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 1/4] serial: doc: Re-add paragraph documenting uart_console_write()
Date: Thu, 14 Apr 2016 11:08:08 +0200
Message-ID: <1460624891-8389-2-git-send-email-geert+renesas@glider.be>
References: <1460624891-8389-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1460624891-8389-1-git-send-email-geert+renesas@glider.be>
Sender: linux-doc-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Jonathan Corbet <corbet@lwn.net>, Peter Hurley <peter@hurleysoftware.com>, Russell King <rmk@arm.linux.org.uk>
Cc: linux-serial@vger.kernel.org, linux-doc@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

Commit 834392a7d92677ff ("serial: doc: Un-document non-existing
uart_write_console()") removed a paragraph about a helper function that
seemed to never exist.

Peter Hurley pointed out that the function does exist, but is called
differently. Re-add the paragraph, with the function name corrected.

Fixes: 834392a7d92677ff ("serial: doc: Un-document non-existing uart_write_console()")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/serial/driver | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/serial/driver b/Documentation/serial/driver
index 65de49a4b39e5baf..03369d076ca20a98 100644
--- a/Documentation/serial/driver
+++ b/Documentation/serial/driver
@@ -28,6 +28,11 @@ The serial core provides a few helper functions.  This includes identifing
 the correct port structure (via uart_get_console) and decoding command line
 arguments (uart_parse_options).
 
+There is also a helper function (uart_console_write) which performs a
+character by character write, translating newlines to CRLF sequences.
+Driver writers are recommended to use this function rather than implementing
+their own version.
+
 
 Locking
 -------
-- 
1.9.1

