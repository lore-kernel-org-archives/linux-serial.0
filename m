Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16157256C7A;
	Thu, 17 Apr 2025 18:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744915753; cv=none; b=tkkasimBcMqF7xLGtskWKkFHQMVhjsTx6w2HDvBKfkhMSSieRx6/SZ+UDed46tqumyZ0smhLQwksCBPYqxtUm5JlS22OExRM7EIJVAngx/DtjwY1poD89j9GTv8XGgiOVly3xVk72aJOas+OmS/d4kbfQBH6Bx2QsgYfxiRjvEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744915753; c=relaxed/simple;
	bh=nzSKtIa4u1TGC2uQylStJvP0dVcTdmzxtrj8cnztm8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pCE/TZNahX7pc4GMnv03zqaXVpM0UU9lcxDX3NRzpJPfYSLw3HuSy56YOfZl+Yxkk4lVvlvkfLBOPtELU1I8ZR7+Y+a+9EXejO1oum7RJdHhPoUtoKOpkXY2RADyMCZWfA8PupdAQBR821jKOlSFRyTFCj6fFAJQDBwXvVXSdVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=MUpRFsiE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=baK+xv9H; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="MUpRFsiE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="baK+xv9H"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 197E4254014C;
	Thu, 17 Apr 2025 14:49:09 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Thu, 17 Apr 2025 14:49:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1744915748;
	 x=1745002148; bh=Zam8T/hfZwh7IieY2W5OUB1kN/1OG90Gz8Agdh5Pe8Q=; b=
	MUpRFsiEHOqhrxX//rrtiSCNsKhOreCcIW5SPI83nQyb0rxEMUJO9aWkgbfrsy3U
	7tXMg/P/Okaz0BBYDWVeNkWhF9wpGxaQzcOdKLQlQm6c3/MZDiU9bsW0Pu96jB0V
	kuwZiJbcOX0H5GuS3vIi4zSfhtDZYM/a7ZCJlb5mLwvCJrkMyqsQ+sZRn+Al406W
	NVaQI6AJrQ794EswiSxqdUG4TcCnEhMPWBnL6m7HL2c6/8OHG47qDyscF8X/5mjk
	Bn2quEqxMZ6NrA+R08LfrIM50X8aF5aIR5TW0g1QLehDkEa6H2BkCHLu+yzru01F
	FPceiXMWuot7vGgU4pe1fQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744915748; x=
	1745002148; bh=Zam8T/hfZwh7IieY2W5OUB1kN/1OG90Gz8Agdh5Pe8Q=; b=b
	aK+xv9H0IxJfADAbqSXO8PY4n1fOKDhriRg0Puq0ohdDW7T3Hz83dFzuCmQiJ3zQ
	V23mu0cYavpbkHT+Cz4YDjekZ+auh4rzAcNKx0ihpnDxXy6EFOB/uQKRWehi5lS/
	3+wXPFmeU1IdUOPotHcorfEBsEZLhrDID2MBWLXywJGAbb5HhDic9uRX1NlFwSdR
	Ihq+XsQDpD1/BDJeU3r338RX+CAtYFX3RRj+aZGyNQ3S7VS3XqpqT0GPF4YpModx
	K/b4THNYuN7MaHhO5CXUPGG9p0v9k6/PkRh7kxK+mDui7mxbqNA5WxYMyURH5gAY
	pfaFubz3KIFlADVi2t1Ow==
X-ME-Sender: <xms:JE0BaCedKFdhA1dBnHA-X0H2KPPlqhX2JGyOzlAJl0iFgNGieFfs-g>
    <xme:JE0BaMMPZpPZ711sxtiCd3DSFFCqOOgtaJfjoi8qs0PWQK1aLn0xZ90drisjNPt0Z
    jDDKX5oPLkvXITzxls>
X-ME-Received: <xmr:JE0BaDhAwg2_rdWnKBhVn6vFHrblzOP3hwpJ44omdmiymYdOFLGAWe-Ou3J91-EASipFozFkSrNo_LLql7Tosx2CAWMlngIdpBRAurEfWgLwsMVrrA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvfedttddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhggtgfgsehtkeertder
    tdejnecuhfhrohhmpefpihgtohhlrghsucfrihhtrhgvuceonhhitghosehflhhugihnih
    gtrdhnvghtqeenucggtffrrghtthgvrhhnpedufedvleehffethffhffelkeekieekgeev
    ffelleejteehieeghfeluedvvdehieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehnihgtohesfhhluhignhhitgdrnhgvthdpnhgspghrtghp
    thhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepnhhpihhtrhgvsegsrg
    ihlhhisghrvgdrtghomhdprhgtphhtthhopehjihhrihhslhgrsgihsehkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehgrhgvghhkhheslhhinhhugihfohhunhgurghtihhonhdroh
    hrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehlihhnuhigqdhsvghrihgrlhesvhhgvghrrdhkvghrnhgvlh
    drohhrgh
X-ME-Proxy: <xmx:JE0BaP8T62l2umA5Ti50qtsPHpRzBKAifdbUlJ89SzhJAPh1MfJOkQ>
    <xmx:JE0BaOthZhpqF7JFd57l49bYkB2FdVHFRD3bwOCIWuJLpeAgUbaNJQ>
    <xmx:JE0BaGFvG8mmsaGZnBcAeHAsqaBYgkB7UESEoT5Rge-KlD9AtNrDjQ>
    <xmx:JE0BaNMjyYTwpZAQzNOJMMtE__s_fy4johh472Do4XPszo36Xl4Njg>
    <xmx:JE0BaCt0ruG7H_VByU4ZHu1OEkdd-k4VLGBcFJv5N4GuuXEvW8ikQk2i>
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Apr 2025 14:49:08 -0400 (EDT)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 9C60A11443D1;
	Thu, 17 Apr 2025 14:49:07 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Nicolas Pitre <npitre@baylibre.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 07/14] vt: introduce gen_ucs_recompose_table.py to create ucs_recompose_table.h
Date: Thu, 17 Apr 2025 14:45:09 -0400
Message-ID: <20250417184849.475581-8-nico@fluxnic.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250417184849.475581-1-nico@fluxnic.net>
References: <20250417184849.475581-1-nico@fluxnic.net>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Nicolas Pitre <npitre@baylibre.com>

The generated table maps base character + combining mark pairs to their
precomposed equivalents using Python's unicodedata module.

The default script behavior is to create a table with most commonly used
Latin, Greek, and Cyrillic recomposition pairs only. It is much smaller
than the table with all possible recomposition pairs (71 entries vs 1000
entries). But if one needs/wants the full table then simply running the
script with the --full argument will generate it.

Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
---
 drivers/tty/vt/gen_ucs_recompose_table.py | 255 ++++++++++++++++++++++
 1 file changed, 255 insertions(+)
 create mode 100755 drivers/tty/vt/gen_ucs_recompose_table.py

diff --git a/drivers/tty/vt/gen_ucs_recompose_table.py b/drivers/tty/vt/gen_ucs_recompose_table.py
new file mode 100755
index 0000000000..d30f8f5242
--- /dev/null
+++ b/drivers/tty/vt/gen_ucs_recompose_table.py
@@ -0,0 +1,255 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+#
+# Leverage Python's unicodedata module to generate ucs_recompose_table.h
+#
+# The generated table maps base character + combining mark pairs to their
+# precomposed equivalents.
+#
+# Usage:
+#   python3 gen_ucs_recompose_table.py         # Generate with common recomposition pairs
+#   python3 gen_ucs_recompose_table.py --full  # Generate with all recomposition pairs
+
+import unicodedata
+import sys
+import argparse
+import textwrap
+
+# This script's file name
+from pathlib import Path
+this_file = Path(__file__).name
+
+# Output file name
+out_file = "ucs_recompose_table.h"
+
+common_recompose_description = "most commonly used Latin, Greek, and Cyrillic recomposition pairs only"
+COMMON_RECOMPOSITION_PAIRS = [
+    # Latin letters with accents - uppercase
+    (0x0041, 0x0300, 0x00C0),  # A + COMBINING GRAVE ACCENT = LATIN CAPITAL LETTER A WITH GRAVE
+    (0x0041, 0x0301, 0x00C1),  # A + COMBINING ACUTE ACCENT = LATIN CAPITAL LETTER A WITH ACUTE
+    (0x0041, 0x0302, 0x00C2),  # A + COMBINING CIRCUMFLEX ACCENT = LATIN CAPITAL LETTER A WITH CIRCUMFLEX
+    (0x0041, 0x0303, 0x00C3),  # A + COMBINING TILDE = LATIN CAPITAL LETTER A WITH TILDE
+    (0x0041, 0x0308, 0x00C4),  # A + COMBINING DIAERESIS = LATIN CAPITAL LETTER A WITH DIAERESIS
+    (0x0041, 0x030A, 0x00C5),  # A + COMBINING RING ABOVE = LATIN CAPITAL LETTER A WITH RING ABOVE
+    (0x0043, 0x0327, 0x00C7),  # C + COMBINING CEDILLA = LATIN CAPITAL LETTER C WITH CEDILLA
+    (0x0045, 0x0300, 0x00C8),  # E + COMBINING GRAVE ACCENT = LATIN CAPITAL LETTER E WITH GRAVE
+    (0x0045, 0x0301, 0x00C9),  # E + COMBINING ACUTE ACCENT = LATIN CAPITAL LETTER E WITH ACUTE
+    (0x0045, 0x0302, 0x00CA),  # E + COMBINING CIRCUMFLEX ACCENT = LATIN CAPITAL LETTER E WITH CIRCUMFLEX
+    (0x0045, 0x0308, 0x00CB),  # E + COMBINING DIAERESIS = LATIN CAPITAL LETTER E WITH DIAERESIS
+    (0x0049, 0x0300, 0x00CC),  # I + COMBINING GRAVE ACCENT = LATIN CAPITAL LETTER I WITH GRAVE
+    (0x0049, 0x0301, 0x00CD),  # I + COMBINING ACUTE ACCENT = LATIN CAPITAL LETTER I WITH ACUTE
+    (0x0049, 0x0302, 0x00CE),  # I + COMBINING CIRCUMFLEX ACCENT = LATIN CAPITAL LETTER I WITH CIRCUMFLEX
+    (0x0049, 0x0308, 0x00CF),  # I + COMBINING DIAERESIS = LATIN CAPITAL LETTER I WITH DIAERESIS
+    (0x004E, 0x0303, 0x00D1),  # N + COMBINING TILDE = LATIN CAPITAL LETTER N WITH TILDE
+    (0x004F, 0x0300, 0x00D2),  # O + COMBINING GRAVE ACCENT = LATIN CAPITAL LETTER O WITH GRAVE
+    (0x004F, 0x0301, 0x00D3),  # O + COMBINING ACUTE ACCENT = LATIN CAPITAL LETTER O WITH ACUTE
+    (0x004F, 0x0302, 0x00D4),  # O + COMBINING CIRCUMFLEX ACCENT = LATIN CAPITAL LETTER O WITH CIRCUMFLEX
+    (0x004F, 0x0303, 0x00D5),  # O + COMBINING TILDE = LATIN CAPITAL LETTER O WITH TILDE
+    (0x004F, 0x0308, 0x00D6),  # O + COMBINING DIAERESIS = LATIN CAPITAL LETTER O WITH DIAERESIS
+    (0x0055, 0x0300, 0x00D9),  # U + COMBINING GRAVE ACCENT = LATIN CAPITAL LETTER U WITH GRAVE
+    (0x0055, 0x0301, 0x00DA),  # U + COMBINING ACUTE ACCENT = LATIN CAPITAL LETTER U WITH ACUTE
+    (0x0055, 0x0302, 0x00DB),  # U + COMBINING CIRCUMFLEX ACCENT = LATIN CAPITAL LETTER U WITH CIRCUMFLEX
+    (0x0055, 0x0308, 0x00DC),  # U + COMBINING DIAERESIS = LATIN CAPITAL LETTER U WITH DIAERESIS
+    (0x0059, 0x0301, 0x00DD),  # Y + COMBINING ACUTE ACCENT = LATIN CAPITAL LETTER Y WITH ACUTE
+
+    # Latin letters with accents - lowercase
+    (0x0061, 0x0300, 0x00E0),  # a + COMBINING GRAVE ACCENT = LATIN SMALL LETTER A WITH GRAVE
+    (0x0061, 0x0301, 0x00E1),  # a + COMBINING ACUTE ACCENT = LATIN SMALL LETTER A WITH ACUTE
+    (0x0061, 0x0302, 0x00E2),  # a + COMBINING CIRCUMFLEX ACCENT = LATIN SMALL LETTER A WITH CIRCUMFLEX
+    (0x0061, 0x0303, 0x00E3),  # a + COMBINING TILDE = LATIN SMALL LETTER A WITH TILDE
+    (0x0061, 0x0308, 0x00E4),  # a + COMBINING DIAERESIS = LATIN SMALL LETTER A WITH DIAERESIS
+    (0x0061, 0x030A, 0x00E5),  # a + COMBINING RING ABOVE = LATIN SMALL LETTER A WITH RING ABOVE
+    (0x0063, 0x0327, 0x00E7),  # c + COMBINING CEDILLA = LATIN SMALL LETTER C WITH CEDILLA
+    (0x0065, 0x0300, 0x00E8),  # e + COMBINING GRAVE ACCENT = LATIN SMALL LETTER E WITH GRAVE
+    (0x0065, 0x0301, 0x00E9),  # e + COMBINING ACUTE ACCENT = LATIN SMALL LETTER E WITH ACUTE
+    (0x0065, 0x0302, 0x00EA),  # e + COMBINING CIRCUMFLEX ACCENT = LATIN SMALL LETTER E WITH CIRCUMFLEX
+    (0x0065, 0x0308, 0x00EB),  # e + COMBINING DIAERESIS = LATIN SMALL LETTER E WITH DIAERESIS
+    (0x0069, 0x0300, 0x00EC),  # i + COMBINING GRAVE ACCENT = LATIN SMALL LETTER I WITH GRAVE
+    (0x0069, 0x0301, 0x00ED),  # i + COMBINING ACUTE ACCENT = LATIN SMALL LETTER I WITH ACUTE
+    (0x0069, 0x0302, 0x00EE),  # i + COMBINING CIRCUMFLEX ACCENT = LATIN SMALL LETTER I WITH CIRCUMFLEX
+    (0x0069, 0x0308, 0x00EF),  # i + COMBINING DIAERESIS = LATIN SMALL LETTER I WITH DIAERESIS
+    (0x006E, 0x0303, 0x00F1),  # n + COMBINING TILDE = LATIN SMALL LETTER N WITH TILDE
+    (0x006F, 0x0300, 0x00F2),  # o + COMBINING GRAVE ACCENT = LATIN SMALL LETTER O WITH GRAVE
+    (0x006F, 0x0301, 0x00F3),  # o + COMBINING ACUTE ACCENT = LATIN SMALL LETTER O WITH ACUTE
+    (0x006F, 0x0302, 0x00F4),  # o + COMBINING CIRCUMFLEX ACCENT = LATIN SMALL LETTER O WITH CIRCUMFLEX
+    (0x006F, 0x0303, 0x00F5),  # o + COMBINING TILDE = LATIN SMALL LETTER O WITH TILDE
+    (0x006F, 0x0308, 0x00F6),  # o + COMBINING DIAERESIS = LATIN SMALL LETTER O WITH DIAERESIS
+    (0x0075, 0x0300, 0x00F9),  # u + COMBINING GRAVE ACCENT = LATIN SMALL LETTER U WITH GRAVE
+    (0x0075, 0x0301, 0x00FA),  # u + COMBINING ACUTE ACCENT = LATIN SMALL LETTER U WITH ACUTE
+    (0x0075, 0x0302, 0x00FB),  # u + COMBINING CIRCUMFLEX ACCENT = LATIN SMALL LETTER U WITH CIRCUMFLEX
+    (0x0075, 0x0308, 0x00FC),  # u + COMBINING DIAERESIS = LATIN SMALL LETTER U WITH DIAERESIS
+    (0x0079, 0x0301, 0x00FD),  # y + COMBINING ACUTE ACCENT = LATIN SMALL LETTER Y WITH ACUTE
+    (0x0079, 0x0308, 0x00FF),  # y + COMBINING DIAERESIS = LATIN SMALL LETTER Y WITH DIAERESIS
+
+    # Common Greek characters
+    (0x0391, 0x0301, 0x0386),  # Α + COMBINING ACUTE ACCENT = GREEK CAPITAL LETTER ALPHA WITH TONOS
+    (0x0395, 0x0301, 0x0388),  # Ε + COMBINING ACUTE ACCENT = GREEK CAPITAL LETTER EPSILON WITH TONOS
+    (0x0397, 0x0301, 0x0389),  # Η + COMBINING ACUTE ACCENT = GREEK CAPITAL LETTER ETA WITH TONOS
+    (0x0399, 0x0301, 0x038A),  # Ι + COMBINING ACUTE ACCENT = GREEK CAPITAL LETTER IOTA WITH TONOS
+    (0x039F, 0x0301, 0x038C),  # Ο + COMBINING ACUTE ACCENT = GREEK CAPITAL LETTER OMICRON WITH TONOS
+    (0x03A5, 0x0301, 0x038E),  # Υ + COMBINING ACUTE ACCENT = GREEK CAPITAL LETTER UPSILON WITH TONOS
+    (0x03A9, 0x0301, 0x038F),  # Ω + COMBINING ACUTE ACCENT = GREEK CAPITAL LETTER OMEGA WITH TONOS
+    (0x03B1, 0x0301, 0x03AC),  # α + COMBINING ACUTE ACCENT = GREEK SMALL LETTER ALPHA WITH TONOS
+    (0x03B5, 0x0301, 0x03AD),  # ε + COMBINING ACUTE ACCENT = GREEK SMALL LETTER EPSILON WITH TONOS
+    (0x03B7, 0x0301, 0x03AE),  # η + COMBINING ACUTE ACCENT = GREEK SMALL LETTER ETA WITH TONOS
+    (0x03B9, 0x0301, 0x03AF),  # ι + COMBINING ACUTE ACCENT = GREEK SMALL LETTER IOTA WITH TONOS
+    (0x03BF, 0x0301, 0x03CC),  # ο + COMBINING ACUTE ACCENT = GREEK SMALL LETTER OMICRON WITH TONOS
+    (0x03C5, 0x0301, 0x03CD),  # υ + COMBINING ACUTE ACCENT = GREEK SMALL LETTER UPSILON WITH TONOS
+    (0x03C9, 0x0301, 0x03CE),  # ω + COMBINING ACUTE ACCENT = GREEK SMALL LETTER OMEGA WITH TONOS
+
+    # Common Cyrillic characters
+    (0x0418, 0x0306, 0x0419),  # И + COMBINING BREVE = CYRILLIC CAPITAL LETTER SHORT I
+    (0x0438, 0x0306, 0x0439),  # и + COMBINING BREVE = CYRILLIC SMALL LETTER SHORT I
+    (0x0423, 0x0306, 0x040E),  # У + COMBINING BREVE = CYRILLIC CAPITAL LETTER SHORT U
+    (0x0443, 0x0306, 0x045E),  # у + COMBINING BREVE = CYRILLIC SMALL LETTER SHORT U
+]
+
+full_recompose_description = "all possible recomposition pairs from the Unicode BMP"
+def collect_all_recomposition_pairs():
+    """Collect all possible recomposition pairs from the Unicode data."""
+    # Map to store recomposition pairs: (base, combining) -> recomposed
+    recompose_map = {}
+
+    # Process all assigned Unicode code points in BMP (Basic Multilingual Plane)
+    # We limit to BMP (0x0000-0xFFFF) to keep our table smaller with uint16_t
+    for cp in range(0, 0x10000):
+        try:
+            char = chr(cp)
+
+            # Skip unassigned or control characters
+            if not unicodedata.name(char, ''):
+                continue
+
+            # Find decomposition
+            decomp = unicodedata.decomposition(char)
+            if not decomp or '<' in decomp:  # Skip compatibility decompositions
+                continue
+
+            # Parse the decomposition
+            parts = decomp.split()
+            if len(parts) == 2:  # Simple base + combining mark
+                base = int(parts[0], 16)
+                combining = int(parts[1], 16)
+
+                # Only store if both are in BMP
+                if base < 0x10000 and combining < 0x10000:
+                    recompose_map[(base, combining)] = cp
+
+        except (ValueError, TypeError):
+            continue
+
+    # Convert to a list of tuples and sort for binary search
+    recompose_list = [(base, combining, recomposed)
+                     for (base, combining), recomposed in recompose_map.items()]
+    recompose_list.sort()
+
+    return recompose_list
+
+def validate_common_pairs(full_list):
+    """Validate that all common pairs are in the full list.
+
+    Raises:
+        ValueError: If any common pair is missing or has a different recomposition
+        value than what's in the full table.
+    """
+    full_pairs = {(base, combining): recomposed for base, combining, recomposed in full_list}
+    for base, combining, recomposed in COMMON_RECOMPOSITION_PAIRS:
+        full_recomposed = full_pairs.get((base, combining))
+        if full_recomposed is None:
+            error_msg = f"Error: Common pair (0x{base:04X}, 0x{combining:04X}) not found in full data"
+            print(error_msg)
+            raise ValueError(error_msg)
+        elif full_recomposed != recomposed:
+            error_msg = (f"Error: Common pair (0x{base:04X}, 0x{combining:04X}) has different recomposition: "
+                         f"0x{recomposed:04X} vs 0x{full_recomposed:04X}")
+            print(error_msg)
+            raise ValueError(error_msg)
+
+def generate_recomposition_table(use_full_list=False):
+    """Generate the recomposition C table."""
+
+    # Collect all recomposition pairs for validation
+    full_recompose_list = collect_all_recomposition_pairs()
+
+    # Decide which list to use
+    if use_full_list:
+        print("Using full recomposition list...")
+        recompose_list = full_recompose_list
+        table_description = full_recompose_description
+        alt_list = COMMON_RECOMPOSITION_PAIRS
+        alt_description = common_recompose_description
+    else:
+        print("Using common recomposition list...")
+        # Validate that all common pairs are in the full list
+        validate_common_pairs(full_recompose_list)
+        recompose_list = sorted(COMMON_RECOMPOSITION_PAIRS)
+        table_description = common_recompose_description
+        alt_list = full_recompose_list
+        alt_description = full_recompose_description
+    generation_mode = " --full" if use_full_list else ""
+    alternative_mode = " --full" if not use_full_list else ""
+    table_description_detail = f"{table_description} ({len(recompose_list)} entries)"
+    alt_description_detail = f"{alt_description} ({len(alt_list)} entries)"
+
+    # Calculate min/max values for boundary checks
+    min_base = min(base for base, _, _ in recompose_list)
+    max_base = max(base for base, _, _ in recompose_list)
+    min_combining = min(combining for _, combining, _ in recompose_list)
+    max_combining = max(combining for _, combining, _ in recompose_list)
+
+    # Generate implementation file
+    with open(out_file, 'w') as f:
+        f.write(f"""\
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * {out_file} - Unicode character recomposition
+ *
+ * Auto-generated by {this_file}{generation_mode}
+ *
+ * Unicode Version: {unicodedata.unidata_version}
+ *
+{textwrap.fill(
+    f"This file contains a table with {table_description_detail}. " +
+    f"To generate a table with {alt_description_detail} instead, run:",
+    width=75, initial_indent=" * ", subsequent_indent=" * ")}
+ *
+ *   python3 {this_file}{alternative_mode}
+ */
+
+/*
+ * Table of {table_description}
+ * Sorted by base character and then combining mark for binary search
+ */
+static const struct ucs_recomposition ucs_recomposition_table[] = {{
+""")
+
+        for base, combining, recomposed in recompose_list:
+            try:
+                base_name = unicodedata.name(chr(base))
+                combining_name = unicodedata.name(chr(combining))
+                recomposed_name = unicodedata.name(chr(recomposed))
+                comment = f"/* {base_name} + {combining_name} = {recomposed_name} */"
+            except ValueError:
+                comment = f"/* U+{base:04X} + U+{combining:04X} = U+{recomposed:04X} */"
+            f.write(f"\t{{ 0x{base:04X}, 0x{combining:04X}, 0x{recomposed:04X} }}, {comment}\n")
+
+        f.write(f"""\
+}};
+
+/*
+ * Boundary values for quick rejection
+ * These are calculated by analyzing the table during generation
+ */
+#define UCS_RECOMPOSE_MIN_BASE  0x{min_base:04X}
+#define UCS_RECOMPOSE_MAX_BASE  0x{max_base:04X}
+#define UCS_RECOMPOSE_MIN_MARK  0x{min_combining:04X}
+#define UCS_RECOMPOSE_MAX_MARK  0x{max_combining:04X}
+""")
+
+if __name__ == "__main__":
+    parser = argparse.ArgumentParser(description="Generate Unicode recomposition table")
+    parser.add_argument("--full", action="store_true",
+                        help="Generate a full recomposition table (default: common pairs only)")
+    args = parser.parse_args()
+
+    generate_recomposition_table(use_full_list=args.full)
-- 
2.49.0

