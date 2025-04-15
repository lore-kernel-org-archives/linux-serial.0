Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADAFF2459DB;
	Tue, 15 Apr 2025 19:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744744944; cv=none; b=ON/Ozo8/ipxZDog7y8Zkfq9x0ZsCwCtZIunwNnlyxo8eWpGCde8PvUdcR5uAfhrZBK0yBWHuxgR5TzJc09/PX9YKSiFnjRLfq898E7PCNuxbZfx20q+eqhjYbS5uWPg8A9tAfzID5QmlwYXVUipmAba96VI6CArI5d2Qh4MxPvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744744944; c=relaxed/simple;
	bh=5zyTJY20PNZZfXt0Iyj0gmngEbYnPqxuuzrKWaxHZDA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GF77eqCUoaUgsrLzcbWUmPZOW3iEtlUJhglIdUevlhM5DVllURHuA2a/XA4vDZltxB+WFRCPlvLvMmtnaRVaKMVfaa/vluUrv0R9LQwQnwtOoM5DUl3hTGzghAmPvls9OEqpeB4Xf3+18Txi4EgI9cFjkTcjWh8xSwl3pSy26Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=KW445fu6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YikXAjv1; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="KW445fu6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YikXAjv1"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2211F11401F4;
	Tue, 15 Apr 2025 15:22:19 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Tue, 15 Apr 2025 15:22:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1744744939; x=
	1744831339; bh=PtkP7nsces5fASeuyalKBh5gJxPb0dmR19dtFfMxFjo=; b=K
	W445fu60pnCQCY6NXk7bv0j1ToR+qR8sv0yo2yp36GAvydRqGjUAoxHwoMpclG+O
	EzAhngXw5R+G0neAoXN3stLVUCDC5VuJw264DaqnR0J4Kxkcy3hvbqhkOcME56UP
	nIYTJNyeP5PEaBQRg+Blyi57MoRumH8vCiwQbxtwuNkrTUWaajsm4/5h1jN5O4Cv
	cUmVe6b0gkkZcrreDeXt8pSL1wutkXFHJXKfBGD/LKCiO3K2NOTU/UCti4sdV56t
	ZQMZ/OqriDkKZR1eZaekyS2IvQyfAFyP9dowFz9QwZgIxtQq5LSNxiI5PWER+rAN
	HqU6O0Q0W3pP+QYEs0+hg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1744744939; x=1744831339; bh=P
	tkP7nsces5fASeuyalKBh5gJxPb0dmR19dtFfMxFjo=; b=YikXAjv1d3U8bNxI6
	QYi3Crk58Gvw8+Fbtg+YScBQIgVY6X0HSaq8fzFYeLjfWAOtNqxkVV8koMXamkix
	Sw/ai8NxI/wo8TJJ95G3XMdDmggChHDcuNh+7AcIqMq9ekRLdQM3B6ryer5Maid9
	wUHm6c6/PuOMdSHkHWHKCzyPBE7RpbnGV/Gedg3EP3nSDwO4AwfQPLlzCfAp0xxH
	33shFuVNq2ct97Qv8k7fiT9VQ2Ci+Mi276VZvZUtdqRN5tStdGp2Bs+BzCyCpWB3
	w9cenq0S7+6EvaLMlQtxs5OVInHUjubxTfKmBwRHUfiz5RqHjrtk1kGc5khTd2ls
	ruzpQ==
X-ME-Sender: <xms:6rH-Z5aE_ypjUoaVgwBDlOtuOn2IOX5p9t9bQ_TYz4Bgcllb8h4Giw>
    <xme:6rH-ZwZUKHYScd0Yk6Jw8JBx9rW6oa6R7hsUbt3krDxlfjT3ZCtKRllGXIaxgcGFT
    L1apWWNttqGYGmfbnc>
X-ME-Received: <xmr:6rH-Z7-CkSvKGh5oX0ikeOa_YXG0aM5KmJ9KL5p8GmWpLegSPIPUK6bFiX1IEHqMk1wLx3aNSUDZXgzhj27e2m6Jyi2jYyBbtakPA-OwDYNHtJMbpg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdegfedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredt
    tdenucfhrhhomheppfhitgholhgrshcurfhithhrvgcuoehnihgtohesfhhluhignhhitg
    drnhgvtheqnecuggftrfgrthhtvghrnhepfedutdfhfffgleeugfeileevkeeukeejtdff
    leeklefhgfdttdekgfelheevhfdunecuffhomhgrihhnpehunhhitghouggvrdhorhhgpd
    gtshhsfihgrdhorhhgpdiffedrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehnihgtohesfhhluhignhhitgdrnhgvthdpnhgspghrtg
    hpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepnhhpihhtrhgvsegs
    rgihlhhisghrvgdrtghomhdprhgtphhtthhopehjihhrihhslhgrsgihsehkvghrnhgvlh
    drohhrghdprhgtphhtthhopehgrhgvghhkhheslhhinhhugihfohhunhgurghtihhonhdr
    ohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehlihhnuhigqdhsvghrihgrlhesvhhgvghrrdhkvghrnhgv
    lhdrohhrgh
X-ME-Proxy: <xmx:6rH-Z3qxY7e0zaP58RgB-StJvb0FhIDhieqaoEATQ3GhIH2eXr2fBw>
    <xmx:6rH-Z0rxoUuWU5cGrkMrfInZLQ1Q0sRpjqsLnL_tRkkyIEZrchxKFA>
    <xmx:6rH-Z9TU2s-McKOC2B0CFonzanRsmySefvm4Y9HlWEmu2e0yCEEhRw>
    <xmx:6rH-Z8qncJm1-vDc94DnMfPmtxsoK3cSiDRb6Sa1JuDytP-FGhSi7Q>
    <xmx:67H-Z0cSZ6Cuin5DJbTo8epHF294B2Sr8OSs6ajpG2EGsIu6T7w7uF_M>
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Apr 2025 15:22:18 -0400 (EDT)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 3DCC8111660C;
	Tue, 15 Apr 2025 15:22:18 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Nicolas Pitre <npitre@baylibre.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 04/13] vt: introduce gen_ucs_width_table.py to create ucs_width_table.h
Date: Tue, 15 Apr 2025 15:17:53 -0400
Message-ID: <20250415192212.33949-5-nico@fluxnic.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250415192212.33949-1-nico@fluxnic.net>
References: <20250415192212.33949-1-nico@fluxnic.net>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nicolas Pitre <npitre@baylibre.com>

The table in ucs.c is terribly out of date and incomplete. We also need a
second table to store zero-width code points. Properly maintaining those
tables manually is impossible. So here's a script to generate them.

Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
---
 drivers/tty/vt/gen_ucs_width_table.py | 256 ++++++++++++++++++++++++++
 1 file changed, 256 insertions(+)
 create mode 100755 drivers/tty/vt/gen_ucs_width_table.py

diff --git a/drivers/tty/vt/gen_ucs_width_table.py b/drivers/tty/vt/gen_ucs_width_table.py
new file mode 100755
index 0000000000..00510444a7
--- /dev/null
+++ b/drivers/tty/vt/gen_ucs_width_table.py
@@ -0,0 +1,256 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+#
+# Leverage Python's unicodedata module to generate ucs_width_table.h
+
+import unicodedata
+import sys
+
+# This script's file name
+from pathlib import Path
+this_file = Path(__file__).name
+
+# Output file name
+out_file = "ucs_width_table.h"
+
+# --- Global Constants for Width Assignments ---
+
+# Known zero-width characters
+KNOWN_ZERO_WIDTH = (
+    0x200B,  # ZERO WIDTH SPACE
+    0x200C,  # ZERO WIDTH NON-JOINER
+    0x200D,  # ZERO WIDTH JOINER
+    0x2060,  # WORD JOINER
+    0xFEFF   # ZERO WIDTH NO-BREAK SPACE (BOM)
+)
+
+# Zero-width emoji modifiers and components
+# NOTE: Some of these characters would normally be single-width according to
+# East Asian Width properties, but we deliberately override them to be
+# zero-width because they function as modifiers in emoji sequences.
+EMOJI_ZERO_WIDTH = [
+    # Skin tone modifiers
+    (0x1F3FB, 0x1F3FF),  # Emoji modifiers (skin tones)
+
+    # Variation selectors (note: VS16 is treated specially in vt.c)
+    (0xFE00, 0xFE0F),    # Variation Selectors 1-16
+
+    # Gender and hair style modifiers
+    # These would be single-width by Unicode properties, but are zero-width
+    # when part of emoji
+    (0x2640, 0x2640),    # Female sign
+    (0x2642, 0x2642),    # Male sign
+    (0x26A7, 0x26A7),    # Transgender symbol
+    (0x1F9B0, 0x1F9B3),  # Hair components (red, curly, white, bald)
+
+    # Tag characters
+    (0xE0020, 0xE007E),  # Tags
+]
+
+# Regional indicators (flag components)
+REGIONAL_INDICATORS = (0x1F1E6, 0x1F1FF)  # Regional indicator symbols A-Z
+
+# Double-width emoji ranges
+#
+# Many emoji characters are classified as single-width according to Unicode
+# Standard Annex #11 East Asian Width property (N or Neutral), but we
+# deliberately override them to be double-width. References:
+# 1. Unicode Technical Standard #51: Unicode Emoji
+#    (https://www.unicode.org/reports/tr51/)
+# 2. Principle of "emoji presentation" in WHATWG CSS Text specification
+#    (https://drafts.csswg.org/css-text-3/#character-properties)
+# 3. Terminal emulator implementations (iTerm2, Windows Terminal, etc.) which
+#    universally render emoji as double-width characters regardless of their
+#    Unicode EAW property
+# 4. W3C Work Item: Requirements for Japanese Text Layout - Section 3.8.1
+#    Emoji width (https://www.w3.org/TR/jlreq/)
+EMOJI_RANGES = [
+    (0x1F000, 0x1F02F),  # Mahjong Tiles (EAW: N, but displayed as double-width)
+    (0x1F0A0, 0x1F0FF),  # Playing Cards (EAW: N, but displayed as double-width)
+    (0x1F300, 0x1F5FF),  # Miscellaneous Symbols and Pictographs
+    (0x1F600, 0x1F64F),  # Emoticons
+    (0x1F680, 0x1F6FF),  # Transport and Map Symbols
+    (0x1F700, 0x1F77F),  # Alchemical Symbols
+    (0x1F780, 0x1F7FF),  # Geometric Shapes Extended
+    (0x1F800, 0x1F8FF),  # Supplemental Arrows-C
+    (0x1F900, 0x1F9FF),  # Supplemental Symbols and Pictographs
+    (0x1FA00, 0x1FA6F),  # Chess Symbols
+    (0x1FA70, 0x1FAFF),  # Symbols and Pictographs Extended-A
+]
+
+def create_width_tables():
+    """
+    Creates Unicode character width tables and returns the data structures.
+
+    Returns:
+        tuple: (zero_width_ranges, double_width_ranges)
+    """
+
+    # Width data mapping
+    width_map = {}  # Maps code points to width (0, 1, 2)
+
+    # Mark emoji modifiers as zero-width
+    for start, end in EMOJI_ZERO_WIDTH:
+        for cp in range(start, end + 1):
+            width_map[cp] = 0
+
+    # Mark all regional indicators as single-width as they are usually paired
+    # providing a combined width of 2 when displayed together.
+    start, end = REGIONAL_INDICATORS
+    for cp in range(start, end + 1):
+        width_map[cp] = 1
+
+    # Process all assigned Unicode code points (Basic Multilingual Plane +
+    # Supplementary Planes) Range 0x0 to 0x10FFFF (the full Unicode range)
+    for block_start in range(0, 0x110000, 0x1000):
+        block_end = block_start + 0x1000
+        for cp in range(block_start, block_end):
+            try:
+                char = chr(cp)
+
+                # Skip if already processed
+                if cp in width_map:
+                    continue
+
+                # Check for combining marks and a format characters
+                category = unicodedata.category(char)
+
+                # Combining marks
+                if category.startswith('M'):
+                    width_map[cp] = 0
+                    continue
+
+                # Format characters
+                # Since we have no support for bidirectional text, all format
+                # characters (category Cf) can be treated with width 0 (zero)
+                # for simplicity, as they don't need to occupy visual space
+                # in a non-bidirectional text environment.
+                if category == 'Cf':
+                    width_map[cp] = 0
+                    continue
+
+                # Known zero-width characters
+                if cp in KNOWN_ZERO_WIDTH:
+                    width_map[cp] = 0
+                    continue
+
+                # Use East Asian Width property
+                eaw = unicodedata.east_asian_width(char)
+                if eaw in ('F', 'W'):  # Fullwidth or Wide
+                    width_map[cp] = 2
+                elif eaw in ('Na', 'H', 'N', 'A'):  # Narrow, Halfwidth, Neutral, Ambiguous
+                    width_map[cp] = 1
+                else:
+                    # Default to single-width for unknown
+                    width_map[cp] = 1
+
+            except (ValueError, OverflowError):
+                # Skip invalid code points
+                continue
+
+    # Process Emoji - generally double-width
+    for start, end in EMOJI_RANGES:
+        for cp in range(start, end + 1):
+            if cp not in width_map or width_map[cp] != 0:  # Don't override zero-width
+                try:
+                    char = chr(cp)
+                    width_map[cp] = 2
+                except (ValueError, OverflowError):
+                    continue
+
+    # Optimize to create range tables
+    def ranges_optimize(width_data, target_width):
+        points = sorted([cp for cp, width in width_data.items() if width == target_width])
+        if not points:
+            return []
+
+        # Group consecutive code points into ranges
+        ranges = []
+        start = points[0]
+        prev = start
+
+        for cp in points[1:]:
+            if cp > prev + 1:
+                ranges.append((start, prev))
+                start = cp
+            prev = cp
+
+        # Add the last range
+        ranges.append((start, prev))
+        return ranges
+
+    # Extract ranges for each width
+    zero_width_ranges = ranges_optimize(width_map, 0)
+    double_width_ranges = ranges_optimize(width_map, 2)
+
+    return zero_width_ranges, double_width_ranges
+
+def write_tables(zero_width_ranges, double_width_ranges):
+    """
+    Write the generated tables to C header file.
+
+    Args:
+        zero_width_ranges: List of (start, end) ranges for zero-width characters
+        double_width_ranges: List of (start, end) ranges for double-width characters
+    """
+
+    # Function to generate code point description comments
+    def get_code_point_comment(start, end):
+        try:
+            start_char_desc = unicodedata.name(chr(start))
+            if start == end:
+                return f"/* {start_char_desc} */"
+            else:
+                end_char_desc = unicodedata.name(chr(end))
+                return f"/* {start_char_desc} - {end_char_desc} */"
+        except:
+            if start == end:
+                return f"/* U+{start:04X} */"
+            else:
+                return f"/* U+{start:04X} - U+{end:04X} */"
+
+    # Generate C tables
+    with open(out_file, 'w') as f:
+        f.write(f"""\
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * {out_file} - Unicode character width
+ *
+ * Auto-generated by {this_file}
+ *
+ * Unicode Version: {unicodedata.unidata_version}
+ */
+
+/* Zero-width character ranges */
+static const struct ucs_interval ucs_zero_width_ranges[] = {{
+""")
+
+        for start, end in zero_width_ranges:
+            comment = get_code_point_comment(start, end)
+            f.write(f"\t{{ 0x{start:05X}, 0x{end:05X} }}, {comment}\n")
+
+        f.write("""\
+};
+
+/* Double-width character ranges */
+static const struct ucs_interval ucs_double_width_ranges[] = {
+""")
+
+        for start, end in double_width_ranges:
+            comment = get_code_point_comment(start, end)
+            f.write(f"\t{{ 0x{start:05X}, 0x{end:05X} }}, {comment}\n")
+
+        f.write("};\n")
+
+if __name__ == "__main__":
+    # Write tables to header file
+    zero_width_ranges, double_width_ranges = create_width_tables()
+    write_tables(zero_width_ranges, double_width_ranges)
+
+    # Print summary
+    zero_width_count = sum(end - start + 1 for start, end in zero_width_ranges)
+    double_width_count = sum(end - start + 1 for start, end in double_width_ranges)
+    print(f"Generated {out_file} with:")
+    print(f"- {len(zero_width_ranges)} zero-width ranges covering ~{zero_width_count} code points")
+    print(f"- {len(double_width_ranges)} double-width ranges covering ~{double_width_count} code points")
+    print(f"- Unicode Version: {unicodedata.unidata_version}")
-- 
2.49.0

