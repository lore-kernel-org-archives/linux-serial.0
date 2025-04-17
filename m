Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C7C2566DB;
	Thu, 17 Apr 2025 18:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744915752; cv=none; b=Px9hVwq/fwyWXYEPuS7RZC4bbKj5km1/QISduz6IXDVaZVQICuCfAd3hu7RSTm4jzcT9mXWUufstJyM+j/uRUFJVA10E+Id8MqDxIa8P8vRT/U/MfR8lWoyEwJI1DpCxC6FjKeBRHrhsz+HpPLb475bRyREK7iDbxNANv8SJN8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744915752; c=relaxed/simple;
	bh=uezFIhfmKfdonztMkPdc4kz6VRL4v9ZhDRwCH/I+CVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sl9jJJa0QpcmrMFa1zdwZBB39ksbeaeutTn2mFzj0adtCtoAgYSwpBhOOtorOEPoMeL2yo35btjRfK3ANxNhP/jvPZo9GFo611eZJ/XSY9dBpZ3hOrMGyW7oaJZPxAcX81zEt4ydJ/RBLdX1afLeMq+1Akzd9V3qkLcPTDhDs1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=JzkxByUY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lXzqOYmi; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="JzkxByUY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lXzqOYmi"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 64C1F2540139;
	Thu, 17 Apr 2025 14:49:08 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Thu, 17 Apr 2025 14:49:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1744915748; x=
	1745002148; bh=7Hr6IGeH7WvHW1qFqnGy/DLPEWJorcGg4zCXmQZgeoQ=; b=J
	zkxByUYf1nRQPwyS7iIPlb3fpvC9g9RDgbpBWhQW50O7Ip8pPQstsDfcpk5t7YKE
	alB6Z4tHx9HzeOkGyFd6ZY2A8U+l+mlKsahI2FFyOzKsrcJqGi0RQXSTMFk1aO+7
	/pPhxrpkuk7T9+54xYG8taTkCRI2UhXar1k1umY+ku0xNi08rPCN+mJXe8BRcjdE
	KdysJvDfQ+iQBTOTgUluG5f5I5gjLWV/sIdWJgVB4dXBUGnlo8ZcLcLwUINpTCdD
	woUr3vbGSNhyERVGe1BmBf6MRD11vJk+UUZ1NmPwQ5afPPegcimVMoVz2jtg8FVz
	P4Ju11F2Y6UETpOViZQdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1744915748; x=1745002148; bh=7
	Hr6IGeH7WvHW1qFqnGy/DLPEWJorcGg4zCXmQZgeoQ=; b=lXzqOYmi1iwV1pncl
	A8TzZY/pNChOFPMd/5bt7J+53WnhAnZR2daMhFP9EZ63oVA6O9uOsSKpKZvwubNN
	C9zgePQhaajyEd1Agvd/NLb4zYKQ/VcdipuUG9xnqTJ9Veg9fEmeqySzai7VTos8
	SPxuRc5Zev+RYvwHoCBcPHEU86YCvzNkLw7ZcOotA1lvNhGJJKCYkmmmU0zvpmr9
	2Sk4o5PJ+5uE2MtooOVOTULgzt+N5C82dASc/B6l8aHWewy4uB9pHl6c1vylenqQ
	W/EPqT3rBIYzwE1ZKG/DzmXabmAD8Ub6ENEZ9srJjRnSB6SMTkGaSmWdZ+5wJGuV
	/3eiw==
X-ME-Sender: <xms:I00BaDwy9tQoDuaValifdsr8uypkQ1d2E_RldkJWBZ2QqGMUF54j5w>
    <xme:I00BaLRnO30igMqY_jdQMnyDpGxGF9p5yS9ddQ_cytx0LlHOUjMbl8Ba4LegQ25of
    a-UGgFjexlc8njwuBI>
X-ME-Received: <xmr:I00BaNU3x1r8Et0BM_-UxLkXpynk42HQLpCr2ho_6vQzEWJUIW5fI7EI8GyBB10YBxTYMinRQtgC9PXQRnuBM-YdKjp8Dmdx2YciU0_RDNnqVSXcMg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvfedttddvucetufdoteggodetrf
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
X-ME-Proxy: <xmx:I00BaNiPOxZtYgZZQRc8r_akqyrDmJcFWI-S-NvTjYgntzUl5NK_kg>
    <xmx:I00BaFAT_CHGcOb3HdjyaasV5M6ZYmOebUvGi84xcJOz9XaUgxlZ0g>
    <xmx:I00BaGK1VKCRSF2iWTzBIOaxqsvYQOMQSmepiVcil1VAUHBYSMD0gg>
    <xmx:I00BaEDY_AN-Ep1CaQzL6parrmKBB0fEIfqrdiT_PF3OarX3ORm2Cg>
    <xmx:JE0BaKy3jE3Eg-dBscybKTZdBz36cSL0gs0j0y9hwdmhNit9MIdP9Lig>
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Apr 2025 14:49:07 -0400 (EDT)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 3F50111443CD;
	Thu, 17 Apr 2025 14:49:07 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Nicolas Pitre <npitre@baylibre.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 04/14] vt: introduce gen_ucs_width_table.py to create ucs_width_table.h
Date: Thu, 17 Apr 2025 14:45:06 -0400
Message-ID: <20250417184849.475581-5-nico@fluxnic.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250417184849.475581-1-nico@fluxnic.net>
References: <20250417184849.475581-1-nico@fluxnic.net>
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
Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
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

