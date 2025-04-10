Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D488915E5D4;
	Thu, 10 Apr 2025 01:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744247946; cv=none; b=bTsa9+PDc8nHpHhlO5TIRRXqdxiyKOp8Cr8t55dUfZ71a2R8gM2vM6y0+U9kto3h91oiGxwpCPPncp4pT+xNKRvrku3zwwF+M/R6eLGi+a6Cp95vx7dTWmJQMFyPlU9FfazyzPN2YTSyXcxM7cAfo/Rhyt0mBEXlZuWGEod28eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744247946; c=relaxed/simple;
	bh=JWVDkb37DmVyEIa4U1AGeH1RPcoUmuR/KvVZMgpL+So=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZcJiPbth9E+4Fr45Rg34MkXdXPXQa6du7k86GlwXSNgA2lb3pIkp1/CchBubY0Z5nfLLMxjmMGeodVS7bcy7MetAnYWcFE5PdGercicEBZG5GpDnzYj/kfLDFGi1sYQElVUV5NKr/n2xLWyyucXrFJ6lXxIo2UDh6mha7lOV5iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=O4LeSxL8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WsRvfgEm; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="O4LeSxL8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WsRvfgEm"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 03B9213801DD;
	Wed,  9 Apr 2025 21:19:03 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Wed, 09 Apr 2025 21:19:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1744247942; x=
	1744334342; bh=wOcZX8QRVBD6u9gZyTxUvB/nb1jqWPHTd6PJyhYwdEk=; b=O
	4LeSxL81KnSBlmRf0DP8UpV/abZ/eTVIOC0SqzqmfbL182DCWQhYK8TBeTMBClqL
	VZDhU42dO4HN9c9SRejzI3sxPAqrPKSplk0Q7I1dyHWZlLfcHY+wettcVbHQHK2V
	Zcfn/dQOkWZdVi3A1qJLyLIDetOotwoSzHRIt8j25ue80/qDnfjtlqVpWLo7cO3o
	EbV8Z5yxdqDJmQClwIfmuaos13+T/HrytXilk2uO3FENjD6CGRbK01/f9Iutuawo
	xfLWRKWqUakaRrezHyUcoX2rdkQTHLUnHB6bTZTDUHKvKCQ8zJH7S2zTSfJ92Wci
	HGrxyyumiU79IrM8grqqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1744247942; x=1744334342; bh=w
	OcZX8QRVBD6u9gZyTxUvB/nb1jqWPHTd6PJyhYwdEk=; b=WsRvfgEmTjOt9SxiF
	QjsAx3vVqRuETwjiTAZ0acrmi+ecUy/9tKewHLP+kTwT54buIMWPWW5P1+l8j3eH
	/qZInBUyKjye3Pa7v64AB6nu9gma64QZbkNUbe7eQ8Xl0agXaxhYZK8IoIfPQIG0
	pI67aRA7V/5U+hHGMb+tg2gznGpY6arsRsvR1P0U5aBKsJlceMuBZlYLh76roDQN
	649h9enPa7vaBNsT4C0F3qjNoTNaKIEFm4j3RxKWp+azszAapVK3wcIsQ0A4P1Xf
	lRHkBuGXW77sXI+NvIs1H1piQD6QRJPpWtVMMG2kVzKKU51ETr7y5w7Yel2GdzrF
	TO6dw==
X-ME-Sender: <xms:hhz3Zw3z6udDshe3Spsoz7lxSmGMensWYgCWQGzoMeMe4nhLr8mVfA>
    <xme:hhz3Z7FGWXNixX4hLumUUbVsUsLvnDYmcLqNGEn5StvwISESSj3PVf_miSwcn57Rv
    p-JB8cVl07meoqjciw>
X-ME-Received: <xmr:hhz3Z453EvMVw5xd8MVCAYGVMfAgD0PUlQiVdhUCgOu0pZqzcU3zn76LfjJIVNqqZ1BNE_NuT5-1Wn-Ilg-xD6azanO4wFu3q_2F6TfLg8qjNGU_Jw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdejheehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredt
    tdenucfhrhhomheppfhitgholhgrshcurfhithhrvgcuoehnihgtohesfhhluhignhhitg
    drnhgvtheqnecuggftrfgrthhtvghrnheptdejueeiieehieeuffduvdffleehkeelgeek
    udekfeffhfduffdugedvteeihfetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepnhhitghosehflhhugihnihgtrdhnvghtpdhnsggprhgtphht
    thhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehnphhithhrvgessggrhi
    hlihgsrhgvrdgtohhmpdhrtghpthhtohepjhhirhhishhlrggshieskhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorh
    hgpdhrtghpthhtohepuggrvhgvsehmihgvlhhkvgdrtggtpdhrtghpthhtoheplhhinhhu
    gidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinh
    hugidqshgvrhhirghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:hhz3Z53nEbYGEW3Y4Vg5NWmoxoxb3nwShBm79m7nMQIxoJRKxkGVEg>
    <xmx:hhz3ZzFwtoIOm_EDKp-8MxF_ilWNM-N7XFe2UWk8qFe2WAfTGrpj-Q>
    <xmx:hhz3Zy9njPwDBJ0y5DGoITAcTJnwHiQleiCrLeAYzC_Y8c37NrUoqw>
    <xmx:hhz3Z4m6bQCsnPY0eIpkHDCyC-mHgBaWcs7KRXtaEzkkZOmf44kLmQ>
    <xmx:hhz3Z0EdVhFOL3w3h29nsuY1KZTfChm2Am0OpvRkbMdHB5HrKXmbZyFz>
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Apr 2025 21:19:02 -0400 (EDT)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id C380410D8B73;
	Wed,  9 Apr 2025 21:19:01 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Nicolas Pitre <npitre@baylibre.com>,
	Dave Mielke <Dave@mielke.cc>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 04/11] vt: introduce gen_ucs_width.py to create ucs_width.c
Date: Wed,  9 Apr 2025 21:13:56 -0400
Message-ID: <20250410011839.64418-5-nico@fluxnic.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250410011839.64418-1-nico@fluxnic.net>
References: <20250410011839.64418-1-nico@fluxnic.net>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nicolas Pitre <npitre@baylibre.com>

The table in the current ucs_width.c is terribly out of date and
incomplete. We also need a second table to store zero-width code points.
Properly maintaining those tables manually is impossible. So here's a
script to automatically generate them.

Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
---
 drivers/tty/vt/gen_ucs_width.py | 264 ++++++++++++++++++++++++++++++++
 1 file changed, 264 insertions(+)
 create mode 100755 drivers/tty/vt/gen_ucs_width.py

diff --git a/drivers/tty/vt/gen_ucs_width.py b/drivers/tty/vt/gen_ucs_width.py
new file mode 100755
index 0000000000..41997fe001
--- /dev/null
+++ b/drivers/tty/vt/gen_ucs_width.py
@@ -0,0 +1,264 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+#
+# This script uses Python's unicodedata module to generate ucs_width.c
+
+import unicodedata
+import sys
+
+def generate_ucs_width():
+    # Output file name
+    c_file = "ucs_width.c"
+
+    # Width data mapping
+    width_map = {}  # Maps code points to width (0, 1, 2)
+
+    # Define emoji modifiers and components that should have zero width
+    emoji_zero_width = [
+        # Skin tone modifiers
+        (0x1F3FB, 0x1F3FF),  # Emoji modifiers (skin tones)
+
+        # Variation selectors (note: VS16 is treated specially in vt.c)
+        (0xFE00, 0xFE0F),    # Variation Selectors 1-16
+
+        # Gender and hair style modifiers
+        (0x2640, 0x2640),    # Female sign
+        (0x2642, 0x2642),    # Male sign
+        (0x26A7, 0x26A7),    # Transgender symbol
+        (0x1F9B0, 0x1F9B3),  # Hair components (red, curly, white, bald)
+
+        # Tag characters
+        (0xE0020, 0xE007E),  # Tags
+    ]
+
+    # Mark these emoji modifiers as zero-width
+    for start, end in emoji_zero_width:
+        for cp in range(start, end + 1):
+            try:
+                width_map[cp] = 0
+            except (ValueError, OverflowError):
+                continue
+
+    # Mark all regional indicators as single-width as they are usually paired
+    # providing a combined with of 2.
+    regional_indicators = (0x1F1E6, 0x1F1FF)  # Regional indicator symbols A-Z
+    start, end = regional_indicators
+    for cp in range(start, end + 1):
+        try:
+            width_map[cp] = 1
+        except (ValueError, OverflowError):
+            continue
+
+    # Process all assigned Unicode code points (Basic Multilingual Plane + Supplementary Planes)
+    # Range 0x0 to 0x10FFFF (the full Unicode range)
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
+                # Check if the character is a combining mark
+                category = unicodedata.category(char)
+
+                # Combining marks, format characters, zero-width characters
+                if (category.startswith('M') or  # Mark (combining)
+                    (category == 'Cf' and cp not in (0x061C, 0x06DD, 0x070F, 0x180E, 0x200F, 0x202E, 0x2066, 0x2067, 0x2068, 0x2069)) or
+                    cp in (0x200B, 0x200C, 0x200D, 0x2060, 0xFEFF)):  # Known zero-width characters
+                    width_map[cp] = 0
+                    continue
+
+                # Use East Asian Width property
+                eaw = unicodedata.east_asian_width(char)
+
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
+    # Ranges according to Unicode Emoji standard
+    emoji_ranges = [
+        (0x1F000, 0x1F02F),  # Mahjong Tiles
+        (0x1F0A0, 0x1F0FF),  # Playing Cards
+        (0x1F300, 0x1F5FF),  # Miscellaneous Symbols and Pictographs
+        (0x1F600, 0x1F64F),  # Emoticons
+        (0x1F680, 0x1F6FF),  # Transport and Map Symbols
+        (0x1F700, 0x1F77F),  # Alchemical Symbols
+        (0x1F780, 0x1F7FF),  # Geometric Shapes Extended
+        (0x1F800, 0x1F8FF),  # Supplemental Arrows-C
+        (0x1F900, 0x1F9FF),  # Supplemental Symbols and Pictographs
+        (0x1FA00, 0x1FA6F),  # Chess Symbols
+        (0x1FA70, 0x1FAFF),  # Symbols and Pictographs Extended-A
+    ]
+
+    for start, end in emoji_ranges:
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
+    # Get Unicode version information
+    unicode_version = unicodedata.unidata_version
+
+    # Generate C implementation file
+    with open(c_file, 'w') as f:
+        f.write(f"""\
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ucs_width.c - Unicode character width lookup
+ *
+ * Auto-generated by gen_ucs_width.py
+ *
+ * Unicode Version: {unicode_version}
+ */
+
+#include <linux/types.h>
+#include <linux/array_size.h>
+#include <linux/bsearch.h>
+#include <linux/consolemap.h>
+
+struct interval {{
+	uint32_t first;
+	uint32_t last;
+}};
+
+/* Zero-width character ranges */
+static const struct interval zero_width_ranges[] = {{
+""")
+
+        for start, end in zero_width_ranges:
+            try:
+                start_char_desc = unicodedata.name(chr(start)) if start < 0x10000 else f"U+{start:05X}"
+                if start == end:
+                    comment = f"/* {start_char_desc} */"
+                else:
+                    end_char_desc = unicodedata.name(chr(end)) if end < 0x10000 else f"U+{end:05X}"
+                    comment = f"/* {start_char_desc} - {end_char_desc} */"
+            except:
+                if start == end:
+                    comment = f"/* U+{start:05X} */"
+                else:
+                    comment = f"/* U+{start:05X} - U+{end:05X} */"
+
+            f.write(f"\t{{ 0x{start:05X}, 0x{end:05X} }}, {comment}\n")
+
+        f.write("""\
+};
+
+/* Double-width character ranges */
+static const struct interval double_width_ranges[] = {
+""")
+
+        for start, end in double_width_ranges:
+            try:
+                start_char_desc = unicodedata.name(chr(start)) if start < 0x10000 else f"U+{start:05X}"
+                if start == end:
+                    comment = f"/* {start_char_desc} */"
+                else:
+                    end_char_desc = unicodedata.name(chr(end)) if end < 0x10000 else f"U+{end:05X}"
+                    comment = f"/* {start_char_desc} - {end_char_desc} */"
+            except:
+                if start == end:
+                    comment = f"/* U+{start:05X} */"
+                else:
+                    comment = f"/* U+{start:05X} - U+{end:05X} */"
+
+            f.write(f"\t{{ 0x{start:05X}, 0x{end:05X} }}, {comment}\n")
+
+        f.write("""\
+};
+
+
+static int ucs_cmp(const void *key, const void *element)
+{
+	uint32_t cp = *(uint32_t *)key;
+	const struct interval *e = element;
+
+	if (cp > e->last)
+		return 1;
+	if (cp < e->first)
+		return -1;
+	return 0;
+}
+
+static bool is_in_interval(uint32_t cp, const struct interval *intervals, size_t count)
+{
+	if (cp < intervals[0].first || cp > intervals[count - 1].last)
+		return false;
+
+	return __inline_bsearch(&cp, intervals, count,
+				sizeof(*intervals), ucs_cmp) != NULL;
+}
+
+/**
+ * Determine if a Unicode code point is zero-width.
+ *
+ * @param ucs: Unicode code point (UCS-4)
+ * Return: true if the character is zero-width, false otherwise
+ */
+bool ucs_is_zero_width(uint32_t cp)
+{
+	return is_in_interval(cp, zero_width_ranges, ARRAY_SIZE(zero_width_ranges));
+}
+
+/**
+ * Determine if a Unicode code point is double-width.
+ *
+ * @param ucs: Unicode code point (UCS-4)
+ * Return: true if the character is double-width, false otherwise
+ */
+bool ucs_is_double_width(uint32_t cp)
+{
+	return is_in_interval(cp, double_width_ranges, ARRAY_SIZE(double_width_ranges));
+}
+""")
+
+    # Print summary
+    zero_width_count = sum(end - start + 1 for start, end in zero_width_ranges)
+    double_width_count = sum(end - start + 1 for start, end in double_width_ranges)
+
+    print(f"Generated {c_file} with:")
+    print(f"- {len(zero_width_ranges)} zero-width ranges covering ~{zero_width_count} code points")
+    print(f"- {len(double_width_ranges)} double-width ranges covering ~{double_width_count} code points")
+
+if __name__ == "__main__":
+    generate_ucs_width()
-- 
2.49.0

