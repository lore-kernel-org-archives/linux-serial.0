Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263F83D0BE5;
	Fri, 15 May 2026 03:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778816952; cv=none; b=bLy6vXBGs7TDlLNiuH8tgylpueV2x181AgIiHLX+t1YYEqi4yceZg1lMop+IwFckMsCYtmxY7AFzdItkTtZDGjRZI5AH0rnJxb/AWpEFlHTBXJUIuVjKJtiDLPRku77B/oIkpWPexocy6C5pDCId5sZ5ZjWRDYo4yTrSNPzkwMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778816952; c=relaxed/simple;
	bh=kqOWEUiWXJvyzFfgrt7gmN7zhBj4ZrZyjFhDk9Nk/j4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ngW0+1JoikwvRQYOhtwZmzhuAFxBKui17oP5wHErPGE9AzqAXW/gBu067PllGaCH5+AFSOOPWxMovk7jE/ny/MZHv2uZCcEysn7YbQ9wy50qZBPXURufwu0mOtb/iCu02Dz3mOunV6BgIwNOTeQvaDr6/NDX1WXqtTAhqb4AvFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=iTr60zGR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ObjG0DEh; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="iTr60zGR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ObjG0DEh"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id C5131EC011F;
	Thu, 14 May 2026 23:48:58 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 14 May 2026 23:48:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm3; t=1778816938; x=1778903338; bh=xK
	GJVMzUl0QrL34+U6OlaRuHL+umYRF1Z2gR5MImtqk=; b=iTr60zGRVSBoeTn9Mb
	DJrTvjrMnd5DdpJjV5AoYpY+pOBmeBpj0N7ownW3uGWPVbc22NdL56KX0WMAuDcD
	w4aXWLkNyovOgBsutFnZFjtJI82DBnHbbNrGrT7+Z3XLVeDXZBk5JpkNGWCgZANz
	QSjWwlkjMkqMy+eITwUPHOIiBEtU+IAMYCgUGjeP9/vYjsp2hhPOSMCM1Neu1VbK
	b/g8xUV41NdEc5Lu0bxUQVo2DpHDGSiY5fC9XKrwn3wHh8UEUDaMgZtuXkb1XFCK
	Rxnz7Ihgcr/YIwJAZzZS7JPUS9Ezz58v6kXLQe3c7gKivP6Hsz2AMDdplpilYowe
	yeAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1778816938; x=1778903338; bh=xKGJVMzUl0QrL34+U6OlaRuHL+um
	YRF1Z2gR5MImtqk=; b=ObjG0DEh9Le6L+m1Ge4aJExF/ndvGglU569x8HuVBK0w
	3FLywTV7HLK3G0hGqcfDCmpklJMBXLg3XrVnj8EBylzNM8kkkjNfkSMbOo5LYBex
	sW47LzzdN8GH4tRtK29RI69dn2ttnu57rBcgWaxSkpUTMPLM3gm8m7esW0NVVIKa
	WLhayHAo+yiqN/yqkqpKrmbIaj2gN3AfIz+ewZvzIfFSd7ZnydY9u3mBF6V89alf
	VrzQRqdoxbQPMKjmK3XNgQwLwtzzhB+Upq4T8IK5XBkg1sd0NswwrtTzqs4UcO+q
	uOMa87n8E8raXFHcdcJ05NgYU6UIMwL0KE+pjAM+QQ==
X-ME-Sender: <xms:qpcGai3z-p4OnNqtHQrBEHytfq1oR_Ifq9J7KIQse4JbsDHS_62dbQ>
    <xme:qpcGai4G8DOcX9o9ueoQb6BynAbVZOCh8IS09z2fk6_cIs520Z-Gz82zbqlhlUeSF
    SO7mljSZm1UVQuLSmtHk1ZlA0SXDWIs3J_HMZ--EHebMiFhiJe_>
X-ME-Received: <xmr:qpcGalUraQY0hNjo4TBoMSadnmbapitS2ZJOInM8lKoDKAg27V6JE8Uv1LpnsB4iQS2ZL0etjwGfMjDl7_DQRTdHH4gV3MEj0JVYg_Hc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvdelfeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofggtgfgsehtkeertdertdejnecuhfhrohhmpefpihgtohhlrghs
    ucfrihhtrhgvuceonhhitghosehflhhugihnihgtrdhnvghtqeenucggtffrrghtthgvrh
    hnpeeugfefjeduhfejteegtdeviefgfeehkeelhfelheevleetjeekudethfdugefhleen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnihgtoh
    esfhhluhignhhitgdrnhgvthdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtohepjhhirhhishhlrggshieskhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthht
    oheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htoheplhhinhhugidqshgvrhhirghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:qpcGahAfqC6zfN8lBT4G6Bp0D44CjofBj199aezOedPawOHHS4vETQ>
    <xmx:qpcGak6tKPQoXfaRA8eD8JeV_RqWFiNu9qs8G8cHsdPpCHypqKsehg>
    <xmx:qpcGaszEGgRgVl4KfZK5qSqn5n25c9c5WcXDDlVbCzAkN5S6eqeWvg>
    <xmx:qpcGarylV8MqD-b52m-i38pq-nHzU6atY9wC1FGmotk1jCBS-n3BWw>
    <xmx:qpcGalUHtDhyi_MvLdg_XSnYhRON7RpDfDBkIZfG96952MM7pOa3ez_v>
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 May 2026 23:48:58 -0400 (EDT)
Received: from xanadu.lan (_gateway [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 8B3491636399;
	Thu, 14 May 2026 23:48:57 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH] vt: merge ucs_is_zero_width()/ucs_is_double_width() into ucs_get_width()
Date: Thu, 14 May 2026 23:48:57 -0400
Message-ID: <20260515034857.2514225-1-nico@fluxnic.net>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The hot path in vc_process_ucs() asks two independent questions about the
same code point -- "is it double-width?" and "is it zero-width?" -- and
was answering each with its own bsearch over its own table. For anything
past the leading bounds check that meant two scans of the BMP width
tables back to back for what is logically a single lookup.

Replace both with one ucs_get_width(cp) returning 0, 1, or 2 in a single
bsearch, while keeping the total table footprint at the same 2384 B as
before.

To do so, merge the zero-width and double-width ranges per region into
one sorted-by-`first` table. BMP entries stay 4 bytes; per-entry width
is hosted in spare bits of the non-BMP table's `last` field. Non-BMP
code points use only 20 of 32 bits, so each u32 has 12 unused high bits.
Store first/last shifted left by 12 and use the low 12 bits of `last`
for metadata: bit 11 is this entry's own width flag, bits 0..7 host an
8-bit chunk of the BMP double-width bitmap. Because the metadata bits
sit strictly below the lowest cp-scale bit, the bsearch comparator
remains a plain u32 compare on shifted keys with no masking.

In vc_process_ucs() the overwhelmingly common single-width path now
collapses to a single predicted branch:

	if (likely(w == 1))
		return 1;

Note: scripts/checkpatch.pl complains about "Macros with complex values
      should be enclosed in parentheses" for the BMP_*WIDTH and
      RANGE_*WIDTH macros. They are deliberately defined to expand to a
      comma-separated (first, last) pair so they can populate the two
      adjacent fields of a struct initializer; wrapping them in
      parentheses would turn that into a comma-expression and defeat
      the whole construction. Please ignore.

Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
---
 drivers/tty/vt/gen_ucs_width_table.py    | 117 ++-
 drivers/tty/vt/ucs.c                     | 148 ++--
 drivers/tty/vt/ucs_width_table.h_shipped | 917 ++++++++++++-----------
 drivers/tty/vt/vt.c                      |  11 +-
 include/linux/consolemap.h               |  12 +-
 5 files changed, 663 insertions(+), 542 deletions(-)

diff --git a/drivers/tty/vt/gen_ucs_width_table.py b/drivers/tty/vt/gen_ucs_width_table.py
index 76e80ebeff13..4d2476842750 100755
--- a/drivers/tty/vt/gen_ucs_width_table.py
+++ b/drivers/tty/vt/gen_ucs_width_table.py
@@ -190,12 +190,23 @@ def write_tables(zero_width_ranges, double_width_ranges, out_file=DEFAULT_OUT_FI
     """
     Write the generated tables to C header file.
 
+    The output uses a single sorted-by-`first` table per region (BMP and
+    non-BMP), with zero-width and double-width ranges merged together. The
+    non-BMP table also hosts the BMP double-width bitmap in spare bits of
+    `last`. See the encoding comment at the top of ucs.c for the layout.
+
     Args:
         zero_width_ranges: List of (start, end) ranges for zero-width characters
         double_width_ranges: List of (start, end) ranges for double-width characters
         out_file: Output file name (default: DEFAULT_OUT_FILE)
     """
 
+    # Bits per BMP-bitmap chunk hosted in one non-BMP entry's `last` field.
+    # 8 bits makes `idx / BITS_PER_CHUNK` / `idx % BITS_PER_CHUNK` compile to
+    # a cheap shift+mask in the lookup. The chunk size is also emitted as
+    # UCS_NONBMP_BMP_BITS in the generated header so ucs.c stays in sync.
+    BITS_PER_CHUNK = 8
+
     # Function to split ranges into BMP (16-bit) and non-BMP (above 16-bit)
     def split_ranges_by_size(ranges):
         bmp_ranges = []
@@ -217,6 +228,40 @@ def write_tables(zero_width_ranges, double_width_ranges, out_file=DEFAULT_OUT_FI
     zero_width_bmp, zero_width_non_bmp = split_ranges_by_size(zero_width_ranges)
     double_width_bmp, double_width_non_bmp = split_ranges_by_size(double_width_ranges)
 
+    # Merge zero- and double-width ranges per region, tagging each with its
+    # width, then sort by `first` so binary search works on the union.
+    bmp_entries = sorted(
+        [(s, e, 0) for s, e in zero_width_bmp] +
+        [(s, e, 2) for s, e in double_width_bmp],
+        key=lambda t: t[0])
+    nonbmp_entries = sorted(
+        [(s, e, 0) for s, e in zero_width_non_bmp] +
+        [(s, e, 2) for s, e in double_width_non_bmp],
+        key=lambda t: t[0])
+
+    # Build the BMP double-width bitmap: one bit per BMP entry (in sort
+    # order), set iff that entry is double-width. Pack into BITS_PER_CHUNK-
+    # wide chunks, with bit j of the chunk corresponding to entry
+    # (chunk_index * BITS_PER_CHUNK + j).
+    bmp_w2_bits = [1 if w == 2 else 0 for _, _, w in bmp_entries]
+    n_chunks = (len(bmp_w2_bits) + BITS_PER_CHUNK - 1) // BITS_PER_CHUNK
+
+    if n_chunks > len(nonbmp_entries):
+        raise RuntimeError(
+            f"BMP bitmap needs {n_chunks} host entries, "
+            f"but only {len(nonbmp_entries)} non-BMP entries are available")
+
+    chunks = []  # list of (base_index, end_index, packed_value)
+    for c in range(n_chunks):
+        base = c * BITS_PER_CHUNK
+        end_idx = min(base + BITS_PER_CHUNK - 1, len(bmp_w2_bits) - 1)
+        value = 0
+        for j in range(BITS_PER_CHUNK):
+            k = base + j
+            if k < len(bmp_w2_bits) and bmp_w2_bits[k]:
+                value |= 1 << j
+        chunks.append((base, end_idx, value))
+
     # Function to generate code point description comments
     def get_code_point_comment(start, end):
         try:
@@ -242,48 +287,47 @@ def write_tables(zero_width_ranges, double_width_ranges, out_file=DEFAULT_OUT_FI
  * Auto-generated by {this_file}
  *
  * Unicode Version: {unicodedata.unidata_version}
+ *
+ * Zero-width and double-width ranges are merged into one sorted-by-`first`
+ * table per region. The non-BMP table additionally hosts the BMP
+ * double-width bitmap in the low {BITS_PER_CHUNK} bits of `last` of its
+ * first {n_chunks} entries (covering {len(bmp_w2_bits)} BMP entries).
+ * See ucs.c for the encoding details and the lookup code.
  */
 
-/* Zero-width character ranges (BMP - Basic Multilingual Plane, U+0000 to U+FFFF) */
-static const struct ucs_interval16 ucs_zero_width_bmp_ranges[] = {{
-""")
-
-        for start, end in zero_width_bmp:
-            comment = get_code_point_comment(start, end)
-            f.write(f"\t{{ 0x{start:04X}, 0x{end:04X} }}, {comment}\n")
-
-        f.write("""\
-};
+/* Bits per BMP-bitmap chunk hosted in one non-BMP entry's `last` field. */
+#define UCS_NONBMP_BMP_BITS {BITS_PER_CHUNK}
 
-/* Zero-width character ranges (non-BMP, U+10000 and above) */
-static const struct ucs_interval32 ucs_zero_width_non_bmp_ranges[] = {
+/* Combined zero- and double-width ranges
+ * (BMP - Basic Multilingual Plane, U+0000 to U+FFFF). */
+static const struct ucs_width16 ucs_bmp_ranges[] = {{
 """)
 
-        for start, end in zero_width_non_bmp:
-            comment = get_code_point_comment(start, end)
-            f.write(f"\t{{ 0x{start:05X}, 0x{end:05X} }}, {comment}\n")
+        for s, e, w in bmp_entries:
+            macro = "BMP_0WIDTH" if w == 0 else "BMP_2WIDTH"
+            comment = get_code_point_comment(s, e)
+            f.write(f"\t{{ {macro}(0x{s:04X}, 0x{e:04X}) }}, {comment}\n")
 
-        f.write("""\
-};
-
-/* Double-width character ranges (BMP - Basic Multilingual Plane, U+0000 to U+FFFF) */
-static const struct ucs_interval16 ucs_double_width_bmp_ranges[] = {
-""")
-
-        for start, end in double_width_bmp:
-            comment = get_code_point_comment(start, end)
-            f.write(f"\t{{ 0x{start:04X}, 0x{end:04X} }}, {comment}\n")
-
-        f.write("""\
-};
+        f.write(f"""\
+}};
 
-/* Double-width character ranges (non-BMP, U+10000 and above) */
-static const struct ucs_interval32 ucs_double_width_non_bmp_ranges[] = {
+/* Combined zero- and double-width ranges (non-BMP, U+10000 and above).
+ * The first {n_chunks} entries host the BMP double-width bitmap in the low
+ * {BITS_PER_CHUNK} bits of `last`. */
+static const struct ucs_width32 ucs_nonbmp_ranges[] = {{
 """)
 
-        for start, end in double_width_non_bmp:
-            comment = get_code_point_comment(start, end)
-            f.write(f"\t{{ 0x{start:05X}, 0x{end:05X} }}, {comment}\n")
+        for i, (s, e, w) in enumerate(nonbmp_entries):
+            macro = "RANGE_0WIDTH" if w == 0 else "RANGE_2WIDTH"
+            comment = get_code_point_comment(s, e)
+            if i < len(chunks):
+                base, end_idx, value = chunks[i]
+                f.write(
+                    f"\t{{ {macro}(0x{s:05X}, 0x{e:05X})   {comment}\n"
+                    f"\t  | BMP_2W_BITS(0b{value:0{BITS_PER_CHUNK}b}) }},"
+                    f" /* BMP entries [{base:>3}..{end_idx:>3}] */\n")
+            else:
+                f.write(f"\t{{ {macro}(0x{s:05X}, 0x{e:05X}) }}, {comment}\n")
 
         f.write("};\n")
 
@@ -301,7 +345,10 @@ if __name__ == "__main__":
     # Print summary
     zero_width_count = sum(end - start + 1 for start, end in zero_width_ranges)
     double_width_count = sum(end - start + 1 for start, end in double_width_ranges)
+    n_zero = len(zero_width_ranges)
+    n_double = len(double_width_ranges)
     print(f"Generated {args.output_file} with:")
-    print(f"- {len(zero_width_ranges)} zero-width ranges covering ~{zero_width_count} code points")
-    print(f"- {len(double_width_ranges)} double-width ranges covering ~{double_width_count} code points")
+    print(f"- {n_zero} zero-width ranges covering ~{zero_width_count} code points")
+    print(f"- {n_double} double-width ranges covering ~{double_width_count} code points")
+    print(f"- {n_zero + n_double} merged ranges total")
     print(f"- Unicode Version: {unicodedata.unidata_version}")
diff --git a/drivers/tty/vt/ucs.c b/drivers/tty/vt/ucs.c
index 03877485dfb7..fc41c0bb5d7b 100644
--- a/drivers/tty/vt/ucs.c
+++ b/drivers/tty/vt/ucs.c
@@ -4,26 +4,74 @@
  */
 
 #include <linux/array_size.h>
+#include <linux/build_bug.h>
 #include <linux/bsearch.h>
 #include <linux/consolemap.h>
-#include <linux/minmax.h>
+#include <linux/math.h>
 
-struct ucs_interval16 {
+struct ucs_width16 {
 	u16 first;
 	u16 last;
 };
 
-struct ucs_interval32 {
+struct ucs_width32 {
 	u32 first;
 	u32 last;
 };
 
+/*
+ * Width table encoding (consumed by ucs_width_table.h):
+ *
+ * Zero- and double-width ranges are merged into one sorted-by-`first` table
+ * per region (BMP / non-BMP). The BMP table stores plain (first, last)
+ * pairs; per-entry width lives in a packed bitmap *hosted by the non-BMP
+ * table*.
+ *
+ * That hosting is the whole point of the encoding. Non-BMP code points use
+ * only 20 bits, so each u32 has 12 spare high bits sitting around doing
+ * nothing — we'd rather use them than spend a separate parallel array for
+ * width and BMP-bitmap bits. So we move the cp value up by UCS_CP_SHIFT
+ * and stash metadata in the now-free low bits of `last`:
+ *   - bit UCS_NONBMP_W2_FLAG_BIT: this entry's own width (0=zero, 1=double),
+ *   - bits 0..UCS_NONBMP_BMP_BITS-1: a chunk of the BMP double-width
+ *     bitmap. Bit `j` of the chunk in non-BMP entry `c` is set iff BMP
+ *     entry (c * UCS_NONBMP_BMP_BITS + j) is double-width. The first
+ *     ceil(N_BMP / UCS_NONBMP_BMP_BITS) non-BMP entries carry the bitmap;
+ *     the rest leave these bits zero.
+ *
+ * Because the metadata bits sit strictly below the lowest cp-scale bit,
+ * the bsearch comparator does plain u32 comparison on the shifted key and
+ * stored values without masking — ordering between distinct code points is
+ * undisturbed.
+ */
+#define UCS_CP_SHIFT           12
+#define UCS_NONBMP_W2_FLAG_BIT 11
+#define UCS_NONBMP_W2_FLAG     (1u << UCS_NONBMP_W2_FLAG_BIT)
+
+#define BMP_0WIDTH(first, last)   first, last
+#define BMP_2WIDTH(first, last)   first, last
+#define RANGE_0WIDTH(first, last) \
+	(u32)(first) << UCS_CP_SHIFT,  (u32)(last) << UCS_CP_SHIFT
+#define RANGE_2WIDTH(first, last) \
+	(u32)(first) << UCS_CP_SHIFT, ((u32)(last) << UCS_CP_SHIFT) | UCS_NONBMP_W2_FLAG
+#define BMP_2W_BITS(b)            (b)
+
 #include "ucs_width_table.h"
 
-static int interval16_cmp(const void *key, const void *element)
+static_assert(UCS_NONBMP_BMP_BITS <= UCS_NONBMP_W2_FLAG_BIT,
+	      "BMP bitmap chunk would overlap the per-entry width flag");
+static_assert(UCS_NONBMP_W2_FLAG_BIT < UCS_CP_SHIFT,
+	      "Metadata bits collide with the shifted cp value");
+static_assert(DIV_ROUND_UP(ARRAY_SIZE(ucs_bmp_ranges), UCS_NONBMP_BMP_BITS)
+	      <= ARRAY_SIZE(ucs_nonbmp_ranges),
+	      "Not enough non-BMP entries to host the BMP width bitmap");
+
+#define UCS_IS_BMP(cp)	((cp) <= 0xffff)
+
+static int width16_cmp(const void *key, const void *element)
 {
 	u16 cp = *(u16 *)key;
-	const struct ucs_interval16 *entry = element;
+	const struct ucs_width16 *entry = element;
 
 	if (cp < entry->first)
 		return -1;
@@ -32,68 +80,62 @@ static int interval16_cmp(const void *key, const void *element)
 	return 0;
 }
 
-static int interval32_cmp(const void *key, const void *element)
+static int width32_cmp(const void *key, const void *element)
 {
-	u32 cp = *(u32 *)key;
-	const struct ucs_interval32 *entry = element;
+	u32 k = *(u32 *)key;
+	const struct ucs_width32 *entry = element;
 
-	if (cp < entry->first)
+	if (k < entry->first)
 		return -1;
-	if (cp > entry->last)
+	if (k > entry->last)
 		return 1;
 	return 0;
 }
 
-static bool cp_in_range16(u16 cp, const struct ucs_interval16 *ranges, size_t size)
+/**
+ * ucs_get_width() - Get the display width of a Unicode code point.
+ * @cp: Unicode code point (UCS-4)
+ *
+ * Return: 2 for double-width (East Asian Wide/Fullwidth, emoji, ...),
+ *         0 for zero-width (combining marks, format characters, ...),
+ *         1 for everything else (the common case).
+ */
+unsigned int ucs_get_width(u32 cp)
 {
-	if (cp < ranges[0].first || cp > ranges[size - 1].last)
-		return false;
+	const struct ucs_width16 *e16;
+	const struct ucs_width32 *e32;
+	unsigned int idx;
+	u32 k;
 
-	return __inline_bsearch(&cp, ranges, size, sizeof(*ranges),
-				interval16_cmp) != NULL;
-}
+	if (UCS_IS_BMP(cp)) {
+		u16 bmp = cp;
 
-static bool cp_in_range32(u32 cp, const struct ucs_interval32 *ranges, size_t size)
-{
-	if (cp < ranges[0].first || cp > ranges[size - 1].last)
-		return false;
+		if (bmp < ucs_bmp_ranges[0].first ||
+		    bmp > ucs_bmp_ranges[ARRAY_SIZE(ucs_bmp_ranges) - 1].last)
+			return 1;
 
-	return __inline_bsearch(&cp, ranges, size, sizeof(*ranges),
-				interval32_cmp) != NULL;
-}
+		e16 = __inline_bsearch(&bmp, ucs_bmp_ranges,
+				       ARRAY_SIZE(ucs_bmp_ranges),
+				       sizeof(*ucs_bmp_ranges), width16_cmp);
+		if (!e16)
+			return 1;
 
-#define UCS_IS_BMP(cp)	((cp) <= 0xffff)
+		idx = e16 - ucs_bmp_ranges;
+		return (ucs_nonbmp_ranges[idx / UCS_NONBMP_BMP_BITS].last
+			>> (idx % UCS_NONBMP_BMP_BITS)) & 1 ? 2 : 0;
+	}
 
-/**
- * ucs_is_zero_width() - Determine if a Unicode code point is zero-width.
- * @cp: Unicode code point (UCS-4)
- *
- * Return: true if the character is zero-width, false otherwise
- */
-bool ucs_is_zero_width(u32 cp)
-{
-	if (UCS_IS_BMP(cp))
-		return cp_in_range16(cp, ucs_zero_width_bmp_ranges,
-				     ARRAY_SIZE(ucs_zero_width_bmp_ranges));
-	else
-		return cp_in_range32(cp, ucs_zero_width_non_bmp_ranges,
-				     ARRAY_SIZE(ucs_zero_width_non_bmp_ranges));
-}
+	k = cp << UCS_CP_SHIFT;
+	if (k < ucs_nonbmp_ranges[0].first ||
+	    k > ucs_nonbmp_ranges[ARRAY_SIZE(ucs_nonbmp_ranges) - 1].last)
+		return 1;
 
-/**
- * ucs_is_double_width() - Determine if a Unicode code point is double-width.
- * @cp: Unicode code point (UCS-4)
- *
- * Return: true if the character is double-width, false otherwise
- */
-bool ucs_is_double_width(u32 cp)
-{
-	if (UCS_IS_BMP(cp))
-		return cp_in_range16(cp, ucs_double_width_bmp_ranges,
-				     ARRAY_SIZE(ucs_double_width_bmp_ranges));
-	else
-		return cp_in_range32(cp, ucs_double_width_non_bmp_ranges,
-				     ARRAY_SIZE(ucs_double_width_non_bmp_ranges));
+	e32 = __inline_bsearch(&k, ucs_nonbmp_ranges,
+			       ARRAY_SIZE(ucs_nonbmp_ranges),
+			       sizeof(*ucs_nonbmp_ranges), width32_cmp);
+	if (!e32)
+		return 1;
+	return (e32->last & UCS_NONBMP_W2_FLAG) ? 2 : 0;
 }
 
 /*
diff --git a/drivers/tty/vt/ucs_width_table.h_shipped b/drivers/tty/vt/ucs_width_table.h_shipped
index 6fcb8f1d577d..5cd6434bf329 100644
--- a/drivers/tty/vt/ucs_width_table.h_shipped
+++ b/drivers/tty/vt/ucs_width_table.h_shipped
@@ -5,449 +5,486 @@
  * Auto-generated by gen_ucs_width_table.py
  *
  * Unicode Version: 16.0.0
+ *
+ * Zero-width and double-width ranges are merged into one sorted-by-`first`
+ * table per region. The non-BMP table additionally hosts the BMP
+ * double-width bitmap in the low 8 bits of `last` of its
+ * first 33 entries (covering 262 BMP entries).
+ * See ucs.c for the encoding details and the lookup code.
  */
 
-/* Zero-width character ranges (BMP - Basic Multilingual Plane, U+0000 to U+FFFF) */
-static const struct ucs_interval16 ucs_zero_width_bmp_ranges[] = {
-	{ 0x00AD, 0x00AD }, /* SOFT HYPHEN */
-	{ 0x0300, 0x036F }, /* COMBINING GRAVE ACCENT - COMBINING LATIN SMALL LETTER X */
-	{ 0x0483, 0x0489 }, /* COMBINING CYRILLIC TITLO - COMBINING CYRILLIC MILLIONS SIGN */
-	{ 0x0591, 0x05BD }, /* HEBREW ACCENT ETNAHTA - HEBREW POINT METEG */
-	{ 0x05BF, 0x05BF }, /* HEBREW POINT RAFE */
-	{ 0x05C1, 0x05C2 }, /* HEBREW POINT SHIN DOT - HEBREW POINT SIN DOT */
-	{ 0x05C4, 0x05C5 }, /* HEBREW MARK UPPER DOT - HEBREW MARK LOWER DOT */
-	{ 0x05C7, 0x05C7 }, /* HEBREW POINT QAMATS QATAN */
-	{ 0x0600, 0x0605 }, /* ARABIC NUMBER SIGN - ARABIC NUMBER MARK ABOVE */
-	{ 0x0610, 0x061A }, /* ARABIC SIGN SALLALLAHOU ALAYHE WASSALLAM - ARABIC SMALL KASRA */
-	{ 0x061C, 0x061C }, /* ARABIC LETTER MARK */
-	{ 0x064B, 0x065F }, /* ARABIC FATHATAN - ARABIC WAVY HAMZA BELOW */
-	{ 0x0670, 0x0670 }, /* ARABIC LETTER SUPERSCRIPT ALEF */
-	{ 0x06D6, 0x06DD }, /* ARABIC SMALL HIGH LIGATURE SAD WITH LAM WITH ALEF MAKSURA - ARABIC END OF AYAH */
-	{ 0x06DF, 0x06E4 }, /* ARABIC SMALL HIGH ROUNDED ZERO - ARABIC SMALL HIGH MADDA */
-	{ 0x06E7, 0x06E8 }, /* ARABIC SMALL HIGH YEH - ARABIC SMALL HIGH NOON */
-	{ 0x06EA, 0x06ED }, /* ARABIC EMPTY CENTRE LOW STOP - ARABIC SMALL LOW MEEM */
-	{ 0x070F, 0x070F }, /* SYRIAC ABBREVIATION MARK */
-	{ 0x0711, 0x0711 }, /* SYRIAC LETTER SUPERSCRIPT ALAPH */
-	{ 0x0730, 0x074A }, /* SYRIAC PTHAHA ABOVE - SYRIAC BARREKH */
-	{ 0x07A6, 0x07B0 }, /* THAANA ABAFILI - THAANA SUKUN */
-	{ 0x07EB, 0x07F3 }, /* NKO COMBINING SHORT HIGH TONE - NKO COMBINING DOUBLE DOT ABOVE */
-	{ 0x07FD, 0x07FD }, /* NKO DANTAYALAN */
-	{ 0x0816, 0x0819 }, /* SAMARITAN MARK IN - SAMARITAN MARK DAGESH */
-	{ 0x081B, 0x0823 }, /* SAMARITAN MARK EPENTHETIC YUT - SAMARITAN VOWEL SIGN A */
-	{ 0x0825, 0x0827 }, /* SAMARITAN VOWEL SIGN SHORT A - SAMARITAN VOWEL SIGN U */
-	{ 0x0829, 0x082D }, /* SAMARITAN VOWEL SIGN LONG I - SAMARITAN MARK NEQUDAA */
-	{ 0x0859, 0x085B }, /* MANDAIC AFFRICATION MARK - MANDAIC GEMINATION MARK */
-	{ 0x0890, 0x0891 }, /* ARABIC POUND MARK ABOVE - ARABIC PIASTRE MARK ABOVE */
-	{ 0x0897, 0x089F }, /* ARABIC PEPET - ARABIC HALF MADDA OVER MADDA */
-	{ 0x08CA, 0x0903 }, /* ARABIC SMALL HIGH FARSI YEH - DEVANAGARI SIGN VISARGA */
-	{ 0x093A, 0x093C }, /* DEVANAGARI VOWEL SIGN OE - DEVANAGARI SIGN NUKTA */
-	{ 0x093E, 0x094F }, /* DEVANAGARI VOWEL SIGN AA - DEVANAGARI VOWEL SIGN AW */
-	{ 0x0951, 0x0957 }, /* DEVANAGARI STRESS SIGN UDATTA - DEVANAGARI VOWEL SIGN UUE */
-	{ 0x0962, 0x0963 }, /* DEVANAGARI VOWEL SIGN VOCALIC L - DEVANAGARI VOWEL SIGN VOCALIC LL */
-	{ 0x0981, 0x0983 }, /* BENGALI SIGN CANDRABINDU - BENGALI SIGN VISARGA */
-	{ 0x09BC, 0x09BC }, /* BENGALI SIGN NUKTA */
-	{ 0x09BE, 0x09C4 }, /* BENGALI VOWEL SIGN AA - BENGALI VOWEL SIGN VOCALIC RR */
-	{ 0x09C7, 0x09C8 }, /* BENGALI VOWEL SIGN E - BENGALI VOWEL SIGN AI */
-	{ 0x09CB, 0x09CD }, /* BENGALI VOWEL SIGN O - BENGALI SIGN VIRAMA */
-	{ 0x09D7, 0x09D7 }, /* BENGALI AU LENGTH MARK */
-	{ 0x09E2, 0x09E3 }, /* BENGALI VOWEL SIGN VOCALIC L - BENGALI VOWEL SIGN VOCALIC LL */
-	{ 0x09FE, 0x09FE }, /* BENGALI SANDHI MARK */
-	{ 0x0A01, 0x0A03 }, /* GURMUKHI SIGN ADAK BINDI - GURMUKHI SIGN VISARGA */
-	{ 0x0A3C, 0x0A3C }, /* GURMUKHI SIGN NUKTA */
-	{ 0x0A3E, 0x0A42 }, /* GURMUKHI VOWEL SIGN AA - GURMUKHI VOWEL SIGN UU */
-	{ 0x0A47, 0x0A48 }, /* GURMUKHI VOWEL SIGN EE - GURMUKHI VOWEL SIGN AI */
-	{ 0x0A4B, 0x0A4D }, /* GURMUKHI VOWEL SIGN OO - GURMUKHI SIGN VIRAMA */
-	{ 0x0A51, 0x0A51 }, /* GURMUKHI SIGN UDAAT */
-	{ 0x0A70, 0x0A71 }, /* GURMUKHI TIPPI - GURMUKHI ADDAK */
-	{ 0x0A75, 0x0A75 }, /* GURMUKHI SIGN YAKASH */
-	{ 0x0A81, 0x0A83 }, /* GUJARATI SIGN CANDRABINDU - GUJARATI SIGN VISARGA */
-	{ 0x0ABC, 0x0ABC }, /* GUJARATI SIGN NUKTA */
-	{ 0x0ABE, 0x0AC5 }, /* GUJARATI VOWEL SIGN AA - GUJARATI VOWEL SIGN CANDRA E */
-	{ 0x0AC7, 0x0AC9 }, /* GUJARATI VOWEL SIGN E - GUJARATI VOWEL SIGN CANDRA O */
-	{ 0x0ACB, 0x0ACD }, /* GUJARATI VOWEL SIGN O - GUJARATI SIGN VIRAMA */
-	{ 0x0AE2, 0x0AE3 }, /* GUJARATI VOWEL SIGN VOCALIC L - GUJARATI VOWEL SIGN VOCALIC LL */
-	{ 0x0AFA, 0x0AFF }, /* GUJARATI SIGN SUKUN - GUJARATI SIGN TWO-CIRCLE NUKTA ABOVE */
-	{ 0x0B01, 0x0B03 }, /* ORIYA SIGN CANDRABINDU - ORIYA SIGN VISARGA */
-	{ 0x0B3C, 0x0B3C }, /* ORIYA SIGN NUKTA */
-	{ 0x0B3E, 0x0B44 }, /* ORIYA VOWEL SIGN AA - ORIYA VOWEL SIGN VOCALIC RR */
-	{ 0x0B47, 0x0B48 }, /* ORIYA VOWEL SIGN E - ORIYA VOWEL SIGN AI */
-	{ 0x0B4B, 0x0B4D }, /* ORIYA VOWEL SIGN O - ORIYA SIGN VIRAMA */
-	{ 0x0B55, 0x0B57 }, /* ORIYA SIGN OVERLINE - ORIYA AU LENGTH MARK */
-	{ 0x0B62, 0x0B63 }, /* ORIYA VOWEL SIGN VOCALIC L - ORIYA VOWEL SIGN VOCALIC LL */
-	{ 0x0B82, 0x0B82 }, /* TAMIL SIGN ANUSVARA */
-	{ 0x0BBE, 0x0BC2 }, /* TAMIL VOWEL SIGN AA - TAMIL VOWEL SIGN UU */
-	{ 0x0BC6, 0x0BC8 }, /* TAMIL VOWEL SIGN E - TAMIL VOWEL SIGN AI */
-	{ 0x0BCA, 0x0BCD }, /* TAMIL VOWEL SIGN O - TAMIL SIGN VIRAMA */
-	{ 0x0BD7, 0x0BD7 }, /* TAMIL AU LENGTH MARK */
-	{ 0x0C00, 0x0C04 }, /* TELUGU SIGN COMBINING CANDRABINDU ABOVE - TELUGU SIGN COMBINING ANUSVARA ABOVE */
-	{ 0x0C3C, 0x0C3C }, /* TELUGU SIGN NUKTA */
-	{ 0x0C3E, 0x0C44 }, /* TELUGU VOWEL SIGN AA - TELUGU VOWEL SIGN VOCALIC RR */
-	{ 0x0C46, 0x0C48 }, /* TELUGU VOWEL SIGN E - TELUGU VOWEL SIGN AI */
-	{ 0x0C4A, 0x0C4D }, /* TELUGU VOWEL SIGN O - TELUGU SIGN VIRAMA */
-	{ 0x0C55, 0x0C56 }, /* TELUGU LENGTH MARK - TELUGU AI LENGTH MARK */
-	{ 0x0C62, 0x0C63 }, /* TELUGU VOWEL SIGN VOCALIC L - TELUGU VOWEL SIGN VOCALIC LL */
-	{ 0x0C81, 0x0C83 }, /* KANNADA SIGN CANDRABINDU - KANNADA SIGN VISARGA */
-	{ 0x0CBC, 0x0CBC }, /* KANNADA SIGN NUKTA */
-	{ 0x0CBE, 0x0CC4 }, /* KANNADA VOWEL SIGN AA - KANNADA VOWEL SIGN VOCALIC RR */
-	{ 0x0CC6, 0x0CC8 }, /* KANNADA VOWEL SIGN E - KANNADA VOWEL SIGN AI */
-	{ 0x0CCA, 0x0CCD }, /* KANNADA VOWEL SIGN O - KANNADA SIGN VIRAMA */
-	{ 0x0CD5, 0x0CD6 }, /* KANNADA LENGTH MARK - KANNADA AI LENGTH MARK */
-	{ 0x0CE2, 0x0CE3 }, /* KANNADA VOWEL SIGN VOCALIC L - KANNADA VOWEL SIGN VOCALIC LL */
-	{ 0x0CF3, 0x0CF3 }, /* KANNADA SIGN COMBINING ANUSVARA ABOVE RIGHT */
-	{ 0x0D00, 0x0D03 }, /* MALAYALAM SIGN COMBINING ANUSVARA ABOVE - MALAYALAM SIGN VISARGA */
-	{ 0x0D3B, 0x0D3C }, /* MALAYALAM SIGN VERTICAL BAR VIRAMA - MALAYALAM SIGN CIRCULAR VIRAMA */
-	{ 0x0D3E, 0x0D44 }, /* MALAYALAM VOWEL SIGN AA - MALAYALAM VOWEL SIGN VOCALIC RR */
-	{ 0x0D46, 0x0D48 }, /* MALAYALAM VOWEL SIGN E - MALAYALAM VOWEL SIGN AI */
-	{ 0x0D4A, 0x0D4D }, /* MALAYALAM VOWEL SIGN O - MALAYALAM SIGN VIRAMA */
-	{ 0x0D57, 0x0D57 }, /* MALAYALAM AU LENGTH MARK */
-	{ 0x0D62, 0x0D63 }, /* MALAYALAM VOWEL SIGN VOCALIC L - MALAYALAM VOWEL SIGN VOCALIC LL */
-	{ 0x0D81, 0x0D83 }, /* SINHALA SIGN CANDRABINDU - SINHALA SIGN VISARGAYA */
-	{ 0x0DCA, 0x0DCA }, /* SINHALA SIGN AL-LAKUNA */
-	{ 0x0DCF, 0x0DD4 }, /* SINHALA VOWEL SIGN AELA-PILLA - SINHALA VOWEL SIGN KETTI PAA-PILLA */
-	{ 0x0DD6, 0x0DD6 }, /* SINHALA VOWEL SIGN DIGA PAA-PILLA */
-	{ 0x0DD8, 0x0DDF }, /* SINHALA VOWEL SIGN GAETTA-PILLA - SINHALA VOWEL SIGN GAYANUKITTA */
-	{ 0x0DF2, 0x0DF3 }, /* SINHALA VOWEL SIGN DIGA GAETTA-PILLA - SINHALA VOWEL SIGN DIGA GAYANUKITTA */
-	{ 0x0E31, 0x0E31 }, /* THAI CHARACTER MAI HAN-AKAT */
-	{ 0x0E34, 0x0E3A }, /* THAI CHARACTER SARA I - THAI CHARACTER PHINTHU */
-	{ 0x0E47, 0x0E4E }, /* THAI CHARACTER MAITAIKHU - THAI CHARACTER YAMAKKAN */
-	{ 0x0EB1, 0x0EB1 }, /* LAO VOWEL SIGN MAI KAN */
-	{ 0x0EB4, 0x0EBC }, /* LAO VOWEL SIGN I - LAO SEMIVOWEL SIGN LO */
-	{ 0x0EC8, 0x0ECE }, /* LAO TONE MAI EK - LAO YAMAKKAN */
-	{ 0x0F18, 0x0F19 }, /* TIBETAN ASTROLOGICAL SIGN -KHYUD PA - TIBETAN ASTROLOGICAL SIGN SDONG TSHUGS */
-	{ 0x0F35, 0x0F35 }, /* TIBETAN MARK NGAS BZUNG NYI ZLA */
-	{ 0x0F37, 0x0F37 }, /* TIBETAN MARK NGAS BZUNG SGOR RTAGS */
-	{ 0x0F39, 0x0F39 }, /* TIBETAN MARK TSA -PHRU */
-	{ 0x0F3E, 0x0F3F }, /* TIBETAN SIGN YAR TSHES - TIBETAN SIGN MAR TSHES */
-	{ 0x0F71, 0x0F84 }, /* TIBETAN VOWEL SIGN AA - TIBETAN MARK HALANTA */
-	{ 0x0F86, 0x0F87 }, /* TIBETAN SIGN LCI RTAGS - TIBETAN SIGN YANG RTAGS */
-	{ 0x0F8D, 0x0F97 }, /* TIBETAN SUBJOINED SIGN LCE TSA CAN - TIBETAN SUBJOINED LETTER JA */
-	{ 0x0F99, 0x0FBC }, /* TIBETAN SUBJOINED LETTER NYA - TIBETAN SUBJOINED LETTER FIXED-FORM RA */
-	{ 0x0FC6, 0x0FC6 }, /* TIBETAN SYMBOL PADMA GDAN */
-	{ 0x102B, 0x103E }, /* MYANMAR VOWEL SIGN TALL AA - MYANMAR CONSONANT SIGN MEDIAL HA */
-	{ 0x1056, 0x1059 }, /* MYANMAR VOWEL SIGN VOCALIC R - MYANMAR VOWEL SIGN VOCALIC LL */
-	{ 0x105E, 0x1060 }, /* MYANMAR CONSONANT SIGN MON MEDIAL NA - MYANMAR CONSONANT SIGN MON MEDIAL LA */
-	{ 0x1062, 0x1064 }, /* MYANMAR VOWEL SIGN SGAW KAREN EU - MYANMAR TONE MARK SGAW KAREN KE PHO */
-	{ 0x1067, 0x106D }, /* MYANMAR VOWEL SIGN WESTERN PWO KAREN EU - MYANMAR SIGN WESTERN PWO KAREN TONE-5 */
-	{ 0x1071, 0x1074 }, /* MYANMAR VOWEL SIGN GEBA KAREN I - MYANMAR VOWEL SIGN KAYAH EE */
-	{ 0x1082, 0x108D }, /* MYANMAR CONSONANT SIGN SHAN MEDIAL WA - MYANMAR SIGN SHAN COUNCIL EMPHATIC TONE */
-	{ 0x108F, 0x108F }, /* MYANMAR SIGN RUMAI PALAUNG TONE-5 */
-	{ 0x109A, 0x109D }, /* MYANMAR SIGN KHAMTI TONE-1 - MYANMAR VOWEL SIGN AITON AI */
-	{ 0x135D, 0x135F }, /* ETHIOPIC COMBINING GEMINATION AND VOWEL LENGTH MARK - ETHIOPIC COMBINING GEMINATION MARK */
-	{ 0x1712, 0x1715 }, /* TAGALOG VOWEL SIGN I - TAGALOG SIGN PAMUDPOD */
-	{ 0x1732, 0x1734 }, /* HANUNOO VOWEL SIGN I - HANUNOO SIGN PAMUDPOD */
-	{ 0x1752, 0x1753 }, /* BUHID VOWEL SIGN I - BUHID VOWEL SIGN U */
-	{ 0x1772, 0x1773 }, /* TAGBANWA VOWEL SIGN I - TAGBANWA VOWEL SIGN U */
-	{ 0x17B4, 0x17D3 }, /* KHMER VOWEL INHERENT AQ - KHMER SIGN BATHAMASAT */
-	{ 0x17DD, 0x17DD }, /* KHMER SIGN ATTHACAN */
-	{ 0x180B, 0x180F }, /* MONGOLIAN FREE VARIATION SELECTOR ONE - MONGOLIAN FREE VARIATION SELECTOR FOUR */
-	{ 0x1885, 0x1886 }, /* MONGOLIAN LETTER ALI GALI BALUDA - MONGOLIAN LETTER ALI GALI THREE BALUDA */
-	{ 0x18A9, 0x18A9 }, /* MONGOLIAN LETTER ALI GALI DAGALGA */
-	{ 0x1920, 0x192B }, /* LIMBU VOWEL SIGN A - LIMBU SUBJOINED LETTER WA */
-	{ 0x1930, 0x193B }, /* LIMBU SMALL LETTER KA - LIMBU SIGN SA-I */
-	{ 0x1A17, 0x1A1B }, /* BUGINESE VOWEL SIGN I - BUGINESE VOWEL SIGN AE */
-	{ 0x1A55, 0x1A5E }, /* TAI THAM CONSONANT SIGN MEDIAL RA - TAI THAM CONSONANT SIGN SA */
-	{ 0x1A60, 0x1A7C }, /* TAI THAM SIGN SAKOT - TAI THAM SIGN KHUEN-LUE KARAN */
-	{ 0x1A7F, 0x1A7F }, /* TAI THAM COMBINING CRYPTOGRAMMIC DOT */
-	{ 0x1AB0, 0x1ACE }, /* COMBINING DOUBLED CIRCUMFLEX ACCENT - COMBINING LATIN SMALL LETTER INSULAR T */
-	{ 0x1B00, 0x1B04 }, /* BALINESE SIGN ULU RICEM - BALINESE SIGN BISAH */
-	{ 0x1B34, 0x1B44 }, /* BALINESE SIGN REREKAN - BALINESE ADEG ADEG */
-	{ 0x1B6B, 0x1B73 }, /* BALINESE MUSICAL SYMBOL COMBINING TEGEH - BALINESE MUSICAL SYMBOL COMBINING GONG */
-	{ 0x1B80, 0x1B82 }, /* SUNDANESE SIGN PANYECEK - SUNDANESE SIGN PANGWISAD */
-	{ 0x1BA1, 0x1BAD }, /* SUNDANESE CONSONANT SIGN PAMINGKAL - SUNDANESE CONSONANT SIGN PASANGAN WA */
-	{ 0x1BE6, 0x1BF3 }, /* BATAK SIGN TOMPI - BATAK PANONGONAN */
-	{ 0x1C24, 0x1C37 }, /* LEPCHA SUBJOINED LETTER YA - LEPCHA SIGN NUKTA */
-	{ 0x1CD0, 0x1CD2 }, /* VEDIC TONE KARSHANA - VEDIC TONE PRENKHA */
-	{ 0x1CD4, 0x1CE8 }, /* VEDIC SIGN YAJURVEDIC MIDLINE SVARITA - VEDIC SIGN VISARGA ANUDATTA WITH TAIL */
-	{ 0x1CED, 0x1CED }, /* VEDIC SIGN TIRYAK */
-	{ 0x1CF4, 0x1CF4 }, /* VEDIC TONE CANDRA ABOVE */
-	{ 0x1CF7, 0x1CF9 }, /* VEDIC SIGN ATIKRAMA - VEDIC TONE DOUBLE RING ABOVE */
-	{ 0x1DC0, 0x1DFF }, /* COMBINING DOTTED GRAVE ACCENT - COMBINING RIGHT ARROWHEAD AND DOWN ARROWHEAD BELOW */
-	{ 0x200B, 0x200F }, /* ZERO WIDTH SPACE - RIGHT-TO-LEFT MARK */
-	{ 0x202A, 0x202E }, /* LEFT-TO-RIGHT EMBEDDING - RIGHT-TO-LEFT OVERRIDE */
-	{ 0x2060, 0x2064 }, /* WORD JOINER - INVISIBLE PLUS */
-	{ 0x2066, 0x206F }, /* LEFT-TO-RIGHT ISOLATE - NOMINAL DIGIT SHAPES */
-	{ 0x20D0, 0x20F0 }, /* COMBINING LEFT HARPOON ABOVE - COMBINING ASTERISK ABOVE */
-	{ 0x2640, 0x2640 }, /* FEMALE SIGN */
-	{ 0x2642, 0x2642 }, /* MALE SIGN */
-	{ 0x26A7, 0x26A7 }, /* MALE WITH STROKE AND MALE AND FEMALE SIGN */
-	{ 0x2CEF, 0x2CF1 }, /* COPTIC COMBINING NI ABOVE - COPTIC COMBINING SPIRITUS LENIS */
-	{ 0x2D7F, 0x2D7F }, /* TIFINAGH CONSONANT JOINER */
-	{ 0x2DE0, 0x2DFF }, /* COMBINING CYRILLIC LETTER BE - COMBINING CYRILLIC LETTER IOTIFIED BIG YUS */
-	{ 0x302A, 0x302F }, /* IDEOGRAPHIC LEVEL TONE MARK - HANGUL DOUBLE DOT TONE MARK */
-	{ 0x3099, 0x309A }, /* COMBINING KATAKANA-HIRAGANA VOICED SOUND MARK - COMBINING KATAKANA-HIRAGANA SEMI-VOICED SOUND MARK */
-	{ 0xA66F, 0xA672 }, /* COMBINING CYRILLIC VZMET - COMBINING CYRILLIC THOUSAND MILLIONS SIGN */
-	{ 0xA674, 0xA67D }, /* COMBINING CYRILLIC LETTER UKRAINIAN IE - COMBINING CYRILLIC PAYEROK */
-	{ 0xA69E, 0xA69F }, /* COMBINING CYRILLIC LETTER EF - COMBINING CYRILLIC LETTER IOTIFIED E */
-	{ 0xA6F0, 0xA6F1 }, /* BAMUM COMBINING MARK KOQNDON - BAMUM COMBINING MARK TUKWENTIS */
-	{ 0xA802, 0xA802 }, /* SYLOTI NAGRI SIGN DVISVARA */
-	{ 0xA806, 0xA806 }, /* SYLOTI NAGRI SIGN HASANTA */
-	{ 0xA80B, 0xA80B }, /* SYLOTI NAGRI SIGN ANUSVARA */
-	{ 0xA823, 0xA827 }, /* SYLOTI NAGRI VOWEL SIGN A - SYLOTI NAGRI VOWEL SIGN OO */
-	{ 0xA82C, 0xA82C }, /* SYLOTI NAGRI SIGN ALTERNATE HASANTA */
-	{ 0xA880, 0xA881 }, /* SAURASHTRA SIGN ANUSVARA - SAURASHTRA SIGN VISARGA */
-	{ 0xA8B4, 0xA8C5 }, /* SAURASHTRA CONSONANT SIGN HAARU - SAURASHTRA SIGN CANDRABINDU */
-	{ 0xA8E0, 0xA8F1 }, /* COMBINING DEVANAGARI DIGIT ZERO - COMBINING DEVANAGARI SIGN AVAGRAHA */
-	{ 0xA8FF, 0xA8FF }, /* DEVANAGARI VOWEL SIGN AY */
-	{ 0xA926, 0xA92D }, /* KAYAH LI VOWEL UE - KAYAH LI TONE CALYA PLOPHU */
-	{ 0xA947, 0xA953 }, /* REJANG VOWEL SIGN I - REJANG VIRAMA */
-	{ 0xA980, 0xA983 }, /* JAVANESE SIGN PANYANGGA - JAVANESE SIGN WIGNYAN */
-	{ 0xA9B3, 0xA9C0 }, /* JAVANESE SIGN CECAK TELU - JAVANESE PANGKON */
-	{ 0xA9E5, 0xA9E5 }, /* MYANMAR SIGN SHAN SAW */
-	{ 0xAA29, 0xAA36 }, /* CHAM VOWEL SIGN AA - CHAM CONSONANT SIGN WA */
-	{ 0xAA43, 0xAA43 }, /* CHAM CONSONANT SIGN FINAL NG */
-	{ 0xAA4C, 0xAA4D }, /* CHAM CONSONANT SIGN FINAL M - CHAM CONSONANT SIGN FINAL H */
-	{ 0xAA7B, 0xAA7D }, /* MYANMAR SIGN PAO KAREN TONE - MYANMAR SIGN TAI LAING TONE-5 */
-	{ 0xAAB0, 0xAAB0 }, /* TAI VIET MAI KANG */
-	{ 0xAAB2, 0xAAB4 }, /* TAI VIET VOWEL I - TAI VIET VOWEL U */
-	{ 0xAAB7, 0xAAB8 }, /* TAI VIET MAI KHIT - TAI VIET VOWEL IA */
-	{ 0xAABE, 0xAABF }, /* TAI VIET VOWEL AM - TAI VIET TONE MAI EK */
-	{ 0xAAC1, 0xAAC1 }, /* TAI VIET TONE MAI THO */
-	{ 0xAAEB, 0xAAEF }, /* MEETEI MAYEK VOWEL SIGN II - MEETEI MAYEK VOWEL SIGN AAU */
-	{ 0xAAF5, 0xAAF6 }, /* MEETEI MAYEK VOWEL SIGN VISARGA - MEETEI MAYEK VIRAMA */
-	{ 0xABE3, 0xABEA }, /* MEETEI MAYEK VOWEL SIGN ONAP - MEETEI MAYEK VOWEL SIGN NUNG */
-	{ 0xABEC, 0xABED }, /* MEETEI MAYEK LUM IYEK - MEETEI MAYEK APUN IYEK */
-	{ 0xFB1E, 0xFB1E }, /* HEBREW POINT JUDEO-SPANISH VARIKA */
-	{ 0xFE00, 0xFE0F }, /* VARIATION SELECTOR-1 - VARIATION SELECTOR-16 */
-	{ 0xFE20, 0xFE2F }, /* COMBINING LIGATURE LEFT HALF - COMBINING CYRILLIC TITLO RIGHT HALF */
-	{ 0xFEFF, 0xFEFF }, /* ZERO WIDTH NO-BREAK SPACE */
-	{ 0xFFF9, 0xFFFB }, /* INTERLINEAR ANNOTATION ANCHOR - INTERLINEAR ANNOTATION TERMINATOR */
-};
-
-/* Zero-width character ranges (non-BMP, U+10000 and above) */
-static const struct ucs_interval32 ucs_zero_width_non_bmp_ranges[] = {
-	{ 0x101FD, 0x101FD }, /* PHAISTOS DISC SIGN COMBINING OBLIQUE STROKE */
-	{ 0x102E0, 0x102E0 }, /* COPTIC EPACT THOUSANDS MARK */
-	{ 0x10376, 0x1037A }, /* COMBINING OLD PERMIC LETTER AN - COMBINING OLD PERMIC LETTER SII */
-	{ 0x10A01, 0x10A03 }, /* KHAROSHTHI VOWEL SIGN I - KHAROSHTHI VOWEL SIGN VOCALIC R */
-	{ 0x10A05, 0x10A06 }, /* KHAROSHTHI VOWEL SIGN E - KHAROSHTHI VOWEL SIGN O */
-	{ 0x10A0C, 0x10A0F }, /* KHAROSHTHI VOWEL LENGTH MARK - KHAROSHTHI SIGN VISARGA */
-	{ 0x10A38, 0x10A3A }, /* KHAROSHTHI SIGN BAR ABOVE - KHAROSHTHI SIGN DOT BELOW */
-	{ 0x10A3F, 0x10A3F }, /* KHAROSHTHI VIRAMA */
-	{ 0x10AE5, 0x10AE6 }, /* MANICHAEAN ABBREVIATION MARK ABOVE - MANICHAEAN ABBREVIATION MARK BELOW */
-	{ 0x10D24, 0x10D27 }, /* HANIFI ROHINGYA SIGN HARBAHAY - HANIFI ROHINGYA SIGN TASSI */
-	{ 0x10D69, 0x10D6D }, /* GARAY VOWEL SIGN E - GARAY CONSONANT NASALIZATION MARK */
-	{ 0x10EAB, 0x10EAC }, /* YEZIDI COMBINING HAMZA MARK - YEZIDI COMBINING MADDA MARK */
-	{ 0x10EFC, 0x10EFF }, /* ARABIC COMBINING ALEF OVERLAY - ARABIC SMALL LOW WORD MADDA */
-	{ 0x10F46, 0x10F50 }, /* SOGDIAN COMBINING DOT BELOW - SOGDIAN COMBINING STROKE BELOW */
-	{ 0x10F82, 0x10F85 }, /* OLD UYGHUR COMBINING DOT ABOVE - OLD UYGHUR COMBINING TWO DOTS BELOW */
-	{ 0x11000, 0x11002 }, /* BRAHMI SIGN CANDRABINDU - BRAHMI SIGN VISARGA */
-	{ 0x11038, 0x11046 }, /* BRAHMI VOWEL SIGN AA - BRAHMI VIRAMA */
-	{ 0x11070, 0x11070 }, /* BRAHMI SIGN OLD TAMIL VIRAMA */
-	{ 0x11073, 0x11074 }, /* BRAHMI VOWEL SIGN OLD TAMIL SHORT E - BRAHMI VOWEL SIGN OLD TAMIL SHORT O */
-	{ 0x1107F, 0x11082 }, /* BRAHMI NUMBER JOINER - KAITHI SIGN VISARGA */
-	{ 0x110B0, 0x110BA }, /* KAITHI VOWEL SIGN AA - KAITHI SIGN NUKTA */
-	{ 0x110BD, 0x110BD }, /* KAITHI NUMBER SIGN */
-	{ 0x110C2, 0x110C2 }, /* KAITHI VOWEL SIGN VOCALIC R */
-	{ 0x110CD, 0x110CD }, /* KAITHI NUMBER SIGN ABOVE */
-	{ 0x11100, 0x11102 }, /* CHAKMA SIGN CANDRABINDU - CHAKMA SIGN VISARGA */
-	{ 0x11127, 0x11134 }, /* CHAKMA VOWEL SIGN A - CHAKMA MAAYYAA */
-	{ 0x11145, 0x11146 }, /* CHAKMA VOWEL SIGN AA - CHAKMA VOWEL SIGN EI */
-	{ 0x11173, 0x11173 }, /* MAHAJANI SIGN NUKTA */
-	{ 0x11180, 0x11182 }, /* SHARADA SIGN CANDRABINDU - SHARADA SIGN VISARGA */
-	{ 0x111B3, 0x111C0 }, /* SHARADA VOWEL SIGN AA - SHARADA SIGN VIRAMA */
-	{ 0x111C9, 0x111CC }, /* SHARADA SANDHI MARK - SHARADA EXTRA SHORT VOWEL MARK */
-	{ 0x111CE, 0x111CF }, /* SHARADA VOWEL SIGN PRISHTHAMATRA E - SHARADA SIGN INVERTED CANDRABINDU */
-	{ 0x1122C, 0x11237 }, /* KHOJKI VOWEL SIGN AA - KHOJKI SIGN SHADDA */
-	{ 0x1123E, 0x1123E }, /* KHOJKI SIGN SUKUN */
-	{ 0x11241, 0x11241 }, /* KHOJKI VOWEL SIGN VOCALIC R */
-	{ 0x112DF, 0x112EA }, /* KHUDAWADI SIGN ANUSVARA - KHUDAWADI SIGN VIRAMA */
-	{ 0x11300, 0x11303 }, /* GRANTHA SIGN COMBINING ANUSVARA ABOVE - GRANTHA SIGN VISARGA */
-	{ 0x1133B, 0x1133C }, /* COMBINING BINDU BELOW - GRANTHA SIGN NUKTA */
-	{ 0x1133E, 0x11344 }, /* GRANTHA VOWEL SIGN AA - GRANTHA VOWEL SIGN VOCALIC RR */
-	{ 0x11347, 0x11348 }, /* GRANTHA VOWEL SIGN EE - GRANTHA VOWEL SIGN AI */
-	{ 0x1134B, 0x1134D }, /* GRANTHA VOWEL SIGN OO - GRANTHA SIGN VIRAMA */
-	{ 0x11357, 0x11357 }, /* GRANTHA AU LENGTH MARK */
-	{ 0x11362, 0x11363 }, /* GRANTHA VOWEL SIGN VOCALIC L - GRANTHA VOWEL SIGN VOCALIC LL */
-	{ 0x11366, 0x1136C }, /* COMBINING GRANTHA DIGIT ZERO - COMBINING GRANTHA DIGIT SIX */
-	{ 0x11370, 0x11374 }, /* COMBINING GRANTHA LETTER A - COMBINING GRANTHA LETTER PA */
-	{ 0x113B8, 0x113C0 }, /* TULU-TIGALARI VOWEL SIGN AA - TULU-TIGALARI VOWEL SIGN VOCALIC LL */
-	{ 0x113C2, 0x113C2 }, /* TULU-TIGALARI VOWEL SIGN EE */
-	{ 0x113C5, 0x113C5 }, /* TULU-TIGALARI VOWEL SIGN AI */
-	{ 0x113C7, 0x113CA }, /* TULU-TIGALARI VOWEL SIGN OO - TULU-TIGALARI SIGN CANDRA ANUNASIKA */
-	{ 0x113CC, 0x113D0 }, /* TULU-TIGALARI SIGN ANUSVARA - TULU-TIGALARI CONJOINER */
-	{ 0x113D2, 0x113D2 }, /* TULU-TIGALARI GEMINATION MARK */
-	{ 0x113E1, 0x113E2 }, /* TULU-TIGALARI VEDIC TONE SVARITA - TULU-TIGALARI VEDIC TONE ANUDATTA */
-	{ 0x11435, 0x11446 }, /* NEWA VOWEL SIGN AA - NEWA SIGN NUKTA */
-	{ 0x1145E, 0x1145E }, /* NEWA SANDHI MARK */
-	{ 0x114B0, 0x114C3 }, /* TIRHUTA VOWEL SIGN AA - TIRHUTA SIGN NUKTA */
-	{ 0x115AF, 0x115B5 }, /* SIDDHAM VOWEL SIGN AA - SIDDHAM VOWEL SIGN VOCALIC RR */
-	{ 0x115B8, 0x115C0 }, /* SIDDHAM VOWEL SIGN E - SIDDHAM SIGN NUKTA */
-	{ 0x115DC, 0x115DD }, /* SIDDHAM VOWEL SIGN ALTERNATE U - SIDDHAM VOWEL SIGN ALTERNATE UU */
-	{ 0x11630, 0x11640 }, /* MODI VOWEL SIGN AA - MODI SIGN ARDHACANDRA */
-	{ 0x116AB, 0x116B7 }, /* TAKRI SIGN ANUSVARA - TAKRI SIGN NUKTA */
-	{ 0x1171D, 0x1172B }, /* AHOM CONSONANT SIGN MEDIAL LA - AHOM SIGN KILLER */
-	{ 0x1182C, 0x1183A }, /* DOGRA VOWEL SIGN AA - DOGRA SIGN NUKTA */
-	{ 0x11930, 0x11935 }, /* DIVES AKURU VOWEL SIGN AA - DIVES AKURU VOWEL SIGN E */
-	{ 0x11937, 0x11938 }, /* DIVES AKURU VOWEL SIGN AI - DIVES AKURU VOWEL SIGN O */
-	{ 0x1193B, 0x1193E }, /* DIVES AKURU SIGN ANUSVARA - DIVES AKURU VIRAMA */
-	{ 0x11940, 0x11940 }, /* DIVES AKURU MEDIAL YA */
-	{ 0x11942, 0x11943 }, /* DIVES AKURU MEDIAL RA - DIVES AKURU SIGN NUKTA */
-	{ 0x119D1, 0x119D7 }, /* NANDINAGARI VOWEL SIGN AA - NANDINAGARI VOWEL SIGN VOCALIC RR */
-	{ 0x119DA, 0x119E0 }, /* NANDINAGARI VOWEL SIGN E - NANDINAGARI SIGN VIRAMA */
-	{ 0x119E4, 0x119E4 }, /* NANDINAGARI VOWEL SIGN PRISHTHAMATRA E */
-	{ 0x11A01, 0x11A0A }, /* ZANABAZAR SQUARE VOWEL SIGN I - ZANABAZAR SQUARE VOWEL LENGTH MARK */
-	{ 0x11A33, 0x11A39 }, /* ZANABAZAR SQUARE FINAL CONSONANT MARK - ZANABAZAR SQUARE SIGN VISARGA */
-	{ 0x11A3B, 0x11A3E }, /* ZANABAZAR SQUARE CLUSTER-FINAL LETTER YA - ZANABAZAR SQUARE CLUSTER-FINAL LETTER VA */
-	{ 0x11A47, 0x11A47 }, /* ZANABAZAR SQUARE SUBJOINER */
-	{ 0x11A51, 0x11A5B }, /* SOYOMBO VOWEL SIGN I - SOYOMBO VOWEL LENGTH MARK */
-	{ 0x11A8A, 0x11A99 }, /* SOYOMBO FINAL CONSONANT SIGN G - SOYOMBO SUBJOINER */
-	{ 0x11C2F, 0x11C36 }, /* BHAIKSUKI VOWEL SIGN AA - BHAIKSUKI VOWEL SIGN VOCALIC L */
-	{ 0x11C38, 0x11C3F }, /* BHAIKSUKI VOWEL SIGN E - BHAIKSUKI SIGN VIRAMA */
-	{ 0x11C92, 0x11CA7 }, /* MARCHEN SUBJOINED LETTER KA - MARCHEN SUBJOINED LETTER ZA */
-	{ 0x11CA9, 0x11CB6 }, /* MARCHEN SUBJOINED LETTER YA - MARCHEN SIGN CANDRABINDU */
-	{ 0x11D31, 0x11D36 }, /* MASARAM GONDI VOWEL SIGN AA - MASARAM GONDI VOWEL SIGN VOCALIC R */
-	{ 0x11D3A, 0x11D3A }, /* MASARAM GONDI VOWEL SIGN E */
-	{ 0x11D3C, 0x11D3D }, /* MASARAM GONDI VOWEL SIGN AI - MASARAM GONDI VOWEL SIGN O */
-	{ 0x11D3F, 0x11D45 }, /* MASARAM GONDI VOWEL SIGN AU - MASARAM GONDI VIRAMA */
-	{ 0x11D47, 0x11D47 }, /* MASARAM GONDI RA-KARA */
-	{ 0x11D8A, 0x11D8E }, /* GUNJALA GONDI VOWEL SIGN AA - GUNJALA GONDI VOWEL SIGN UU */
-	{ 0x11D90, 0x11D91 }, /* GUNJALA GONDI VOWEL SIGN EE - GUNJALA GONDI VOWEL SIGN AI */
-	{ 0x11D93, 0x11D97 }, /* GUNJALA GONDI VOWEL SIGN OO - GUNJALA GONDI VIRAMA */
-	{ 0x11EF3, 0x11EF6 }, /* MAKASAR VOWEL SIGN I - MAKASAR VOWEL SIGN O */
-	{ 0x11F00, 0x11F01 }, /* KAWI SIGN CANDRABINDU - KAWI SIGN ANUSVARA */
-	{ 0x11F03, 0x11F03 }, /* KAWI SIGN VISARGA */
-	{ 0x11F34, 0x11F3A }, /* KAWI VOWEL SIGN AA - KAWI VOWEL SIGN VOCALIC R */
-	{ 0x11F3E, 0x11F42 }, /* KAWI VOWEL SIGN E - KAWI CONJOINER */
-	{ 0x11F5A, 0x11F5A }, /* KAWI SIGN NUKTA */
-	{ 0x13430, 0x13440 }, /* EGYPTIAN HIEROGLYPH VERTICAL JOINER - EGYPTIAN HIEROGLYPH MIRROR HORIZONTALLY */
-	{ 0x13447, 0x13455 }, /* EGYPTIAN HIEROGLYPH MODIFIER DAMAGED AT TOP START - EGYPTIAN HIEROGLYPH MODIFIER DAMAGED */
-	{ 0x1611E, 0x1612F }, /* GURUNG KHEMA VOWEL SIGN AA - GURUNG KHEMA SIGN THOLHOMA */
-	{ 0x16AF0, 0x16AF4 }, /* BASSA VAH COMBINING HIGH TONE - BASSA VAH COMBINING HIGH-LOW TONE */
-	{ 0x16B30, 0x16B36 }, /* PAHAWH HMONG MARK CIM TUB - PAHAWH HMONG MARK CIM TAUM */
-	{ 0x16F4F, 0x16F4F }, /* MIAO SIGN CONSONANT MODIFIER BAR */
-	{ 0x16F51, 0x16F87 }, /* MIAO SIGN ASPIRATION - MIAO VOWEL SIGN UI */
-	{ 0x16F8F, 0x16F92 }, /* MIAO TONE RIGHT - MIAO TONE BELOW */
-	{ 0x16FE4, 0x16FE4 }, /* KHITAN SMALL SCRIPT FILLER */
-	{ 0x16FF0, 0x16FF1 }, /* VIETNAMESE ALTERNATE READING MARK CA - VIETNAMESE ALTERNATE READING MARK NHAY */
-	{ 0x1BC9D, 0x1BC9E }, /* DUPLOYAN THICK LETTER SELECTOR - DUPLOYAN DOUBLE MARK */
-	{ 0x1BCA0, 0x1BCA3 }, /* SHORTHAND FORMAT LETTER OVERLAP - SHORTHAND FORMAT UP STEP */
-	{ 0x1CF00, 0x1CF2D }, /* ZNAMENNY COMBINING MARK GORAZDO NIZKO S KRYZHEM ON LEFT - ZNAMENNY COMBINING MARK KRYZH ON LEFT */
-	{ 0x1CF30, 0x1CF46 }, /* ZNAMENNY COMBINING TONAL RANGE MARK MRACHNO - ZNAMENNY PRIZNAK MODIFIER ROG */
-	{ 0x1D165, 0x1D169 }, /* MUSICAL SYMBOL COMBINING STEM - MUSICAL SYMBOL COMBINING TREMOLO-3 */
-	{ 0x1D16D, 0x1D182 }, /* MUSICAL SYMBOL COMBINING AUGMENTATION DOT - MUSICAL SYMBOL COMBINING LOURE */
-	{ 0x1D185, 0x1D18B }, /* MUSICAL SYMBOL COMBINING DOIT - MUSICAL SYMBOL COMBINING TRIPLE TONGUE */
-	{ 0x1D1AA, 0x1D1AD }, /* MUSICAL SYMBOL COMBINING DOWN BOW - MUSICAL SYMBOL COMBINING SNAP PIZZICATO */
-	{ 0x1D242, 0x1D244 }, /* COMBINING GREEK MUSICAL TRISEME - COMBINING GREEK MUSICAL PENTASEME */
-	{ 0x1DA00, 0x1DA36 }, /* SIGNWRITING HEAD RIM - SIGNWRITING AIR SUCKING IN */
-	{ 0x1DA3B, 0x1DA6C }, /* SIGNWRITING MOUTH CLOSED NEUTRAL - SIGNWRITING EXCITEMENT */
-	{ 0x1DA75, 0x1DA75 }, /* SIGNWRITING UPPER BODY TILTING FROM HIP JOINTS */
-	{ 0x1DA84, 0x1DA84 }, /* SIGNWRITING LOCATION HEAD NECK */
-	{ 0x1DA9B, 0x1DA9F }, /* SIGNWRITING FILL MODIFIER-2 - SIGNWRITING FILL MODIFIER-6 */
-	{ 0x1DAA1, 0x1DAAF }, /* SIGNWRITING ROTATION MODIFIER-2 - SIGNWRITING ROTATION MODIFIER-16 */
-	{ 0x1E000, 0x1E006 }, /* COMBINING GLAGOLITIC LETTER AZU - COMBINING GLAGOLITIC LETTER ZHIVETE */
-	{ 0x1E008, 0x1E018 }, /* COMBINING GLAGOLITIC LETTER ZEMLJA - COMBINING GLAGOLITIC LETTER HERU */
-	{ 0x1E01B, 0x1E021 }, /* COMBINING GLAGOLITIC LETTER SHTA - COMBINING GLAGOLITIC LETTER YATI */
-	{ 0x1E023, 0x1E024 }, /* COMBINING GLAGOLITIC LETTER YU - COMBINING GLAGOLITIC LETTER SMALL YUS */
-	{ 0x1E026, 0x1E02A }, /* COMBINING GLAGOLITIC LETTER YO - COMBINING GLAGOLITIC LETTER FITA */
-	{ 0x1E08F, 0x1E08F }, /* COMBINING CYRILLIC SMALL LETTER BYELORUSSIAN-UKRAINIAN I */
-	{ 0x1E130, 0x1E136 }, /* NYIAKENG PUACHUE HMONG TONE-B - NYIAKENG PUACHUE HMONG TONE-D */
-	{ 0x1E2AE, 0x1E2AE }, /* TOTO SIGN RISING TONE */
-	{ 0x1E2EC, 0x1E2EF }, /* WANCHO TONE TUP - WANCHO TONE KOINI */
-	{ 0x1E4EC, 0x1E4EF }, /* NAG MUNDARI SIGN MUHOR - NAG MUNDARI SIGN SUTUH */
-	{ 0x1E5EE, 0x1E5EF }, /* OL ONAL SIGN MU - OL ONAL SIGN IKIR */
-	{ 0x1E8D0, 0x1E8D6 }, /* MENDE KIKAKUI COMBINING NUMBER TEENS - MENDE KIKAKUI COMBINING NUMBER MILLIONS */
-	{ 0x1E944, 0x1E94A }, /* ADLAM ALIF LENGTHENER - ADLAM NUKTA */
-	{ 0x1F3FB, 0x1F3FF }, /* EMOJI MODIFIER FITZPATRICK TYPE-1-2 - EMOJI MODIFIER FITZPATRICK TYPE-6 */
-	{ 0x1F9B0, 0x1F9B3 }, /* EMOJI COMPONENT RED HAIR - EMOJI COMPONENT WHITE HAIR */
-	{ 0xE0001, 0xE0001 }, /* LANGUAGE TAG */
-	{ 0xE0020, 0xE007F }, /* TAG SPACE - CANCEL TAG */
-	{ 0xE0100, 0xE01EF }, /* VARIATION SELECTOR-17 - VARIATION SELECTOR-256 */
-};
+/* Bits per BMP-bitmap chunk hosted in one non-BMP entry's `last` field. */
+#define UCS_NONBMP_BMP_BITS 8
 
-/* Double-width character ranges (BMP - Basic Multilingual Plane, U+0000 to U+FFFF) */
-static const struct ucs_interval16 ucs_double_width_bmp_ranges[] = {
-	{ 0x1100, 0x115F }, /* HANGUL CHOSEONG KIYEOK - HANGUL CHOSEONG FILLER */
-	{ 0x231A, 0x231B }, /* WATCH - HOURGLASS */
-	{ 0x2329, 0x232A }, /* LEFT-POINTING ANGLE BRACKET - RIGHT-POINTING ANGLE BRACKET */
-	{ 0x23E9, 0x23EC }, /* BLACK RIGHT-POINTING DOUBLE TRIANGLE - BLACK DOWN-POINTING DOUBLE TRIANGLE */
-	{ 0x23F0, 0x23F0 }, /* ALARM CLOCK */
-	{ 0x23F3, 0x23F3 }, /* HOURGLASS WITH FLOWING SAND */
-	{ 0x25FD, 0x25FE }, /* WHITE MEDIUM SMALL SQUARE - BLACK MEDIUM SMALL SQUARE */
-	{ 0x2614, 0x2615 }, /* UMBRELLA WITH RAIN DROPS - HOT BEVERAGE */
-	{ 0x2630, 0x2637 }, /* TRIGRAM FOR HEAVEN - TRIGRAM FOR EARTH */
-	{ 0x2648, 0x2653 }, /* ARIES - PISCES */
-	{ 0x267F, 0x267F }, /* WHEELCHAIR SYMBOL */
-	{ 0x268A, 0x268F }, /* MONOGRAM FOR YANG - DIGRAM FOR GREATER YIN */
-	{ 0x2693, 0x2693 }, /* ANCHOR */
-	{ 0x26A1, 0x26A1 }, /* HIGH VOLTAGE SIGN */
-	{ 0x26AA, 0x26AB }, /* MEDIUM WHITE CIRCLE - MEDIUM BLACK CIRCLE */
-	{ 0x26BD, 0x26BE }, /* SOCCER BALL - BASEBALL */
-	{ 0x26C4, 0x26C5 }, /* SNOWMAN WITHOUT SNOW - SUN BEHIND CLOUD */
-	{ 0x26CE, 0x26CE }, /* OPHIUCHUS */
-	{ 0x26D4, 0x26D4 }, /* NO ENTRY */
-	{ 0x26EA, 0x26EA }, /* CHURCH */
-	{ 0x26F2, 0x26F3 }, /* FOUNTAIN - FLAG IN HOLE */
-	{ 0x26F5, 0x26F5 }, /* SAILBOAT */
-	{ 0x26FA, 0x26FA }, /* TENT */
-	{ 0x26FD, 0x26FD }, /* FUEL PUMP */
-	{ 0x2705, 0x2705 }, /* WHITE HEAVY CHECK MARK */
-	{ 0x270A, 0x270B }, /* RAISED FIST - RAISED HAND */
-	{ 0x2728, 0x2728 }, /* SPARKLES */
-	{ 0x274C, 0x274C }, /* CROSS MARK */
-	{ 0x274E, 0x274E }, /* NEGATIVE SQUARED CROSS MARK */
-	{ 0x2753, 0x2755 }, /* BLACK QUESTION MARK ORNAMENT - WHITE EXCLAMATION MARK ORNAMENT */
-	{ 0x2757, 0x2757 }, /* HEAVY EXCLAMATION MARK SYMBOL */
-	{ 0x2795, 0x2797 }, /* HEAVY PLUS SIGN - HEAVY DIVISION SIGN */
-	{ 0x27B0, 0x27B0 }, /* CURLY LOOP */
-	{ 0x27BF, 0x27BF }, /* DOUBLE CURLY LOOP */
-	{ 0x2B1B, 0x2B1C }, /* BLACK LARGE SQUARE - WHITE LARGE SQUARE */
-	{ 0x2B50, 0x2B50 }, /* WHITE MEDIUM STAR */
-	{ 0x2B55, 0x2B55 }, /* HEAVY LARGE CIRCLE */
-	{ 0x2E80, 0x2E99 }, /* CJK RADICAL REPEAT - CJK RADICAL RAP */
-	{ 0x2E9B, 0x2EF3 }, /* CJK RADICAL CHOKE - CJK RADICAL C-SIMPLIFIED TURTLE */
-	{ 0x2F00, 0x2FD5 }, /* KANGXI RADICAL ONE - KANGXI RADICAL FLUTE */
-	{ 0x2FF0, 0x3029 }, /* IDEOGRAPHIC DESCRIPTION CHARACTER LEFT TO RIGHT - HANGZHOU NUMERAL NINE */
-	{ 0x3030, 0x303E }, /* WAVY DASH - IDEOGRAPHIC VARIATION INDICATOR */
-	{ 0x3041, 0x3096 }, /* HIRAGANA LETTER SMALL A - HIRAGANA LETTER SMALL KE */
-	{ 0x309B, 0x30FF }, /* KATAKANA-HIRAGANA VOICED SOUND MARK - KATAKANA DIGRAPH KOTO */
-	{ 0x3105, 0x312F }, /* BOPOMOFO LETTER B - BOPOMOFO LETTER NN */
-	{ 0x3131, 0x318E }, /* HANGUL LETTER KIYEOK - HANGUL LETTER ARAEAE */
-	{ 0x3190, 0x31E5 }, /* IDEOGRAPHIC ANNOTATION LINKING MARK - CJK STROKE SZP */
-	{ 0x31EF, 0x321E }, /* IDEOGRAPHIC DESCRIPTION CHARACTER SUBTRACTION - PARENTHESIZED KOREAN CHARACTER O HU */
-	{ 0x3220, 0x3247 }, /* PARENTHESIZED IDEOGRAPH ONE - CIRCLED IDEOGRAPH KOTO */
-	{ 0x3250, 0xA48C }, /* PARTNERSHIP SIGN - YI SYLLABLE YYR */
-	{ 0xA490, 0xA4C6 }, /* YI RADICAL QOT - YI RADICAL KE */
-	{ 0xA960, 0xA97C }, /* HANGUL CHOSEONG TIKEUT-MIEUM - HANGUL CHOSEONG SSANGYEORINHIEUH */
-	{ 0xAC00, 0xD7A3 }, /* HANGUL SYLLABLE GA - HANGUL SYLLABLE HIH */
-	{ 0xF900, 0xFAFF }, /* U+F900 - U+FAFF */
-	{ 0xFE10, 0xFE19 }, /* PRESENTATION FORM FOR VERTICAL COMMA - PRESENTATION FORM FOR VERTICAL HORIZONTAL ELLIPSIS */
-	{ 0xFE30, 0xFE52 }, /* PRESENTATION FORM FOR VERTICAL TWO DOT LEADER - SMALL FULL STOP */
-	{ 0xFE54, 0xFE66 }, /* SMALL SEMICOLON - SMALL EQUALS SIGN */
-	{ 0xFE68, 0xFE6B }, /* SMALL REVERSE SOLIDUS - SMALL COMMERCIAL AT */
-	{ 0xFF01, 0xFF60 }, /* FULLWIDTH EXCLAMATION MARK - FULLWIDTH RIGHT WHITE PARENTHESIS */
-	{ 0xFFE0, 0xFFE6 }, /* FULLWIDTH CENT SIGN - FULLWIDTH WON SIGN */
+/* Combined zero- and double-width ranges
+ * (BMP - Basic Multilingual Plane, U+0000 to U+FFFF). */
+static const struct ucs_width16 ucs_bmp_ranges[] = {
+	{ BMP_0WIDTH(0x00AD, 0x00AD) }, /* SOFT HYPHEN */
+	{ BMP_0WIDTH(0x0300, 0x036F) }, /* COMBINING GRAVE ACCENT - COMBINING LATIN SMALL LETTER X */
+	{ BMP_0WIDTH(0x0483, 0x0489) }, /* COMBINING CYRILLIC TITLO - COMBINING CYRILLIC MILLIONS SIGN */
+	{ BMP_0WIDTH(0x0591, 0x05BD) }, /* HEBREW ACCENT ETNAHTA - HEBREW POINT METEG */
+	{ BMP_0WIDTH(0x05BF, 0x05BF) }, /* HEBREW POINT RAFE */
+	{ BMP_0WIDTH(0x05C1, 0x05C2) }, /* HEBREW POINT SHIN DOT - HEBREW POINT SIN DOT */
+	{ BMP_0WIDTH(0x05C4, 0x05C5) }, /* HEBREW MARK UPPER DOT - HEBREW MARK LOWER DOT */
+	{ BMP_0WIDTH(0x05C7, 0x05C7) }, /* HEBREW POINT QAMATS QATAN */
+	{ BMP_0WIDTH(0x0600, 0x0605) }, /* ARABIC NUMBER SIGN - ARABIC NUMBER MARK ABOVE */
+	{ BMP_0WIDTH(0x0610, 0x061A) }, /* ARABIC SIGN SALLALLAHOU ALAYHE WASSALLAM - ARABIC SMALL KASRA */
+	{ BMP_0WIDTH(0x061C, 0x061C) }, /* ARABIC LETTER MARK */
+	{ BMP_0WIDTH(0x064B, 0x065F) }, /* ARABIC FATHATAN - ARABIC WAVY HAMZA BELOW */
+	{ BMP_0WIDTH(0x0670, 0x0670) }, /* ARABIC LETTER SUPERSCRIPT ALEF */
+	{ BMP_0WIDTH(0x06D6, 0x06DD) }, /* ARABIC SMALL HIGH LIGATURE SAD WITH LAM WITH ALEF MAKSURA - ARABIC END OF AYAH */
+	{ BMP_0WIDTH(0x06DF, 0x06E4) }, /* ARABIC SMALL HIGH ROUNDED ZERO - ARABIC SMALL HIGH MADDA */
+	{ BMP_0WIDTH(0x06E7, 0x06E8) }, /* ARABIC SMALL HIGH YEH - ARABIC SMALL HIGH NOON */
+	{ BMP_0WIDTH(0x06EA, 0x06ED) }, /* ARABIC EMPTY CENTRE LOW STOP - ARABIC SMALL LOW MEEM */
+	{ BMP_0WIDTH(0x070F, 0x070F) }, /* SYRIAC ABBREVIATION MARK */
+	{ BMP_0WIDTH(0x0711, 0x0711) }, /* SYRIAC LETTER SUPERSCRIPT ALAPH */
+	{ BMP_0WIDTH(0x0730, 0x074A) }, /* SYRIAC PTHAHA ABOVE - SYRIAC BARREKH */
+	{ BMP_0WIDTH(0x07A6, 0x07B0) }, /* THAANA ABAFILI - THAANA SUKUN */
+	{ BMP_0WIDTH(0x07EB, 0x07F3) }, /* NKO COMBINING SHORT HIGH TONE - NKO COMBINING DOUBLE DOT ABOVE */
+	{ BMP_0WIDTH(0x07FD, 0x07FD) }, /* NKO DANTAYALAN */
+	{ BMP_0WIDTH(0x0816, 0x0819) }, /* SAMARITAN MARK IN - SAMARITAN MARK DAGESH */
+	{ BMP_0WIDTH(0x081B, 0x0823) }, /* SAMARITAN MARK EPENTHETIC YUT - SAMARITAN VOWEL SIGN A */
+	{ BMP_0WIDTH(0x0825, 0x0827) }, /* SAMARITAN VOWEL SIGN SHORT A - SAMARITAN VOWEL SIGN U */
+	{ BMP_0WIDTH(0x0829, 0x082D) }, /* SAMARITAN VOWEL SIGN LONG I - SAMARITAN MARK NEQUDAA */
+	{ BMP_0WIDTH(0x0859, 0x085B) }, /* MANDAIC AFFRICATION MARK - MANDAIC GEMINATION MARK */
+	{ BMP_0WIDTH(0x0890, 0x0891) }, /* ARABIC POUND MARK ABOVE - ARABIC PIASTRE MARK ABOVE */
+	{ BMP_0WIDTH(0x0897, 0x089F) }, /* ARABIC PEPET - ARABIC HALF MADDA OVER MADDA */
+	{ BMP_0WIDTH(0x08CA, 0x0903) }, /* ARABIC SMALL HIGH FARSI YEH - DEVANAGARI SIGN VISARGA */
+	{ BMP_0WIDTH(0x093A, 0x093C) }, /* DEVANAGARI VOWEL SIGN OE - DEVANAGARI SIGN NUKTA */
+	{ BMP_0WIDTH(0x093E, 0x094F) }, /* DEVANAGARI VOWEL SIGN AA - DEVANAGARI VOWEL SIGN AW */
+	{ BMP_0WIDTH(0x0951, 0x0957) }, /* DEVANAGARI STRESS SIGN UDATTA - DEVANAGARI VOWEL SIGN UUE */
+	{ BMP_0WIDTH(0x0962, 0x0963) }, /* DEVANAGARI VOWEL SIGN VOCALIC L - DEVANAGARI VOWEL SIGN VOCALIC LL */
+	{ BMP_0WIDTH(0x0981, 0x0983) }, /* BENGALI SIGN CANDRABINDU - BENGALI SIGN VISARGA */
+	{ BMP_0WIDTH(0x09BC, 0x09BC) }, /* BENGALI SIGN NUKTA */
+	{ BMP_0WIDTH(0x09BE, 0x09C4) }, /* BENGALI VOWEL SIGN AA - BENGALI VOWEL SIGN VOCALIC RR */
+	{ BMP_0WIDTH(0x09C7, 0x09C8) }, /* BENGALI VOWEL SIGN E - BENGALI VOWEL SIGN AI */
+	{ BMP_0WIDTH(0x09CB, 0x09CD) }, /* BENGALI VOWEL SIGN O - BENGALI SIGN VIRAMA */
+	{ BMP_0WIDTH(0x09D7, 0x09D7) }, /* BENGALI AU LENGTH MARK */
+	{ BMP_0WIDTH(0x09E2, 0x09E3) }, /* BENGALI VOWEL SIGN VOCALIC L - BENGALI VOWEL SIGN VOCALIC LL */
+	{ BMP_0WIDTH(0x09FE, 0x09FE) }, /* BENGALI SANDHI MARK */
+	{ BMP_0WIDTH(0x0A01, 0x0A03) }, /* GURMUKHI SIGN ADAK BINDI - GURMUKHI SIGN VISARGA */
+	{ BMP_0WIDTH(0x0A3C, 0x0A3C) }, /* GURMUKHI SIGN NUKTA */
+	{ BMP_0WIDTH(0x0A3E, 0x0A42) }, /* GURMUKHI VOWEL SIGN AA - GURMUKHI VOWEL SIGN UU */
+	{ BMP_0WIDTH(0x0A47, 0x0A48) }, /* GURMUKHI VOWEL SIGN EE - GURMUKHI VOWEL SIGN AI */
+	{ BMP_0WIDTH(0x0A4B, 0x0A4D) }, /* GURMUKHI VOWEL SIGN OO - GURMUKHI SIGN VIRAMA */
+	{ BMP_0WIDTH(0x0A51, 0x0A51) }, /* GURMUKHI SIGN UDAAT */
+	{ BMP_0WIDTH(0x0A70, 0x0A71) }, /* GURMUKHI TIPPI - GURMUKHI ADDAK */
+	{ BMP_0WIDTH(0x0A75, 0x0A75) }, /* GURMUKHI SIGN YAKASH */
+	{ BMP_0WIDTH(0x0A81, 0x0A83) }, /* GUJARATI SIGN CANDRABINDU - GUJARATI SIGN VISARGA */
+	{ BMP_0WIDTH(0x0ABC, 0x0ABC) }, /* GUJARATI SIGN NUKTA */
+	{ BMP_0WIDTH(0x0ABE, 0x0AC5) }, /* GUJARATI VOWEL SIGN AA - GUJARATI VOWEL SIGN CANDRA E */
+	{ BMP_0WIDTH(0x0AC7, 0x0AC9) }, /* GUJARATI VOWEL SIGN E - GUJARATI VOWEL SIGN CANDRA O */
+	{ BMP_0WIDTH(0x0ACB, 0x0ACD) }, /* GUJARATI VOWEL SIGN O - GUJARATI SIGN VIRAMA */
+	{ BMP_0WIDTH(0x0AE2, 0x0AE3) }, /* GUJARATI VOWEL SIGN VOCALIC L - GUJARATI VOWEL SIGN VOCALIC LL */
+	{ BMP_0WIDTH(0x0AFA, 0x0AFF) }, /* GUJARATI SIGN SUKUN - GUJARATI SIGN TWO-CIRCLE NUKTA ABOVE */
+	{ BMP_0WIDTH(0x0B01, 0x0B03) }, /* ORIYA SIGN CANDRABINDU - ORIYA SIGN VISARGA */
+	{ BMP_0WIDTH(0x0B3C, 0x0B3C) }, /* ORIYA SIGN NUKTA */
+	{ BMP_0WIDTH(0x0B3E, 0x0B44) }, /* ORIYA VOWEL SIGN AA - ORIYA VOWEL SIGN VOCALIC RR */
+	{ BMP_0WIDTH(0x0B47, 0x0B48) }, /* ORIYA VOWEL SIGN E - ORIYA VOWEL SIGN AI */
+	{ BMP_0WIDTH(0x0B4B, 0x0B4D) }, /* ORIYA VOWEL SIGN O - ORIYA SIGN VIRAMA */
+	{ BMP_0WIDTH(0x0B55, 0x0B57) }, /* ORIYA SIGN OVERLINE - ORIYA AU LENGTH MARK */
+	{ BMP_0WIDTH(0x0B62, 0x0B63) }, /* ORIYA VOWEL SIGN VOCALIC L - ORIYA VOWEL SIGN VOCALIC LL */
+	{ BMP_0WIDTH(0x0B82, 0x0B82) }, /* TAMIL SIGN ANUSVARA */
+	{ BMP_0WIDTH(0x0BBE, 0x0BC2) }, /* TAMIL VOWEL SIGN AA - TAMIL VOWEL SIGN UU */
+	{ BMP_0WIDTH(0x0BC6, 0x0BC8) }, /* TAMIL VOWEL SIGN E - TAMIL VOWEL SIGN AI */
+	{ BMP_0WIDTH(0x0BCA, 0x0BCD) }, /* TAMIL VOWEL SIGN O - TAMIL SIGN VIRAMA */
+	{ BMP_0WIDTH(0x0BD7, 0x0BD7) }, /* TAMIL AU LENGTH MARK */
+	{ BMP_0WIDTH(0x0C00, 0x0C04) }, /* TELUGU SIGN COMBINING CANDRABINDU ABOVE - TELUGU SIGN COMBINING ANUSVARA ABOVE */
+	{ BMP_0WIDTH(0x0C3C, 0x0C3C) }, /* TELUGU SIGN NUKTA */
+	{ BMP_0WIDTH(0x0C3E, 0x0C44) }, /* TELUGU VOWEL SIGN AA - TELUGU VOWEL SIGN VOCALIC RR */
+	{ BMP_0WIDTH(0x0C46, 0x0C48) }, /* TELUGU VOWEL SIGN E - TELUGU VOWEL SIGN AI */
+	{ BMP_0WIDTH(0x0C4A, 0x0C4D) }, /* TELUGU VOWEL SIGN O - TELUGU SIGN VIRAMA */
+	{ BMP_0WIDTH(0x0C55, 0x0C56) }, /* TELUGU LENGTH MARK - TELUGU AI LENGTH MARK */
+	{ BMP_0WIDTH(0x0C62, 0x0C63) }, /* TELUGU VOWEL SIGN VOCALIC L - TELUGU VOWEL SIGN VOCALIC LL */
+	{ BMP_0WIDTH(0x0C81, 0x0C83) }, /* KANNADA SIGN CANDRABINDU - KANNADA SIGN VISARGA */
+	{ BMP_0WIDTH(0x0CBC, 0x0CBC) }, /* KANNADA SIGN NUKTA */
+	{ BMP_0WIDTH(0x0CBE, 0x0CC4) }, /* KANNADA VOWEL SIGN AA - KANNADA VOWEL SIGN VOCALIC RR */
+	{ BMP_0WIDTH(0x0CC6, 0x0CC8) }, /* KANNADA VOWEL SIGN E - KANNADA VOWEL SIGN AI */
+	{ BMP_0WIDTH(0x0CCA, 0x0CCD) }, /* KANNADA VOWEL SIGN O - KANNADA SIGN VIRAMA */
+	{ BMP_0WIDTH(0x0CD5, 0x0CD6) }, /* KANNADA LENGTH MARK - KANNADA AI LENGTH MARK */
+	{ BMP_0WIDTH(0x0CE2, 0x0CE3) }, /* KANNADA VOWEL SIGN VOCALIC L - KANNADA VOWEL SIGN VOCALIC LL */
+	{ BMP_0WIDTH(0x0CF3, 0x0CF3) }, /* KANNADA SIGN COMBINING ANUSVARA ABOVE RIGHT */
+	{ BMP_0WIDTH(0x0D00, 0x0D03) }, /* MALAYALAM SIGN COMBINING ANUSVARA ABOVE - MALAYALAM SIGN VISARGA */
+	{ BMP_0WIDTH(0x0D3B, 0x0D3C) }, /* MALAYALAM SIGN VERTICAL BAR VIRAMA - MALAYALAM SIGN CIRCULAR VIRAMA */
+	{ BMP_0WIDTH(0x0D3E, 0x0D44) }, /* MALAYALAM VOWEL SIGN AA - MALAYALAM VOWEL SIGN VOCALIC RR */
+	{ BMP_0WIDTH(0x0D46, 0x0D48) }, /* MALAYALAM VOWEL SIGN E - MALAYALAM VOWEL SIGN AI */
+	{ BMP_0WIDTH(0x0D4A, 0x0D4D) }, /* MALAYALAM VOWEL SIGN O - MALAYALAM SIGN VIRAMA */
+	{ BMP_0WIDTH(0x0D57, 0x0D57) }, /* MALAYALAM AU LENGTH MARK */
+	{ BMP_0WIDTH(0x0D62, 0x0D63) }, /* MALAYALAM VOWEL SIGN VOCALIC L - MALAYALAM VOWEL SIGN VOCALIC LL */
+	{ BMP_0WIDTH(0x0D81, 0x0D83) }, /* SINHALA SIGN CANDRABINDU - SINHALA SIGN VISARGAYA */
+	{ BMP_0WIDTH(0x0DCA, 0x0DCA) }, /* SINHALA SIGN AL-LAKUNA */
+	{ BMP_0WIDTH(0x0DCF, 0x0DD4) }, /* SINHALA VOWEL SIGN AELA-PILLA - SINHALA VOWEL SIGN KETTI PAA-PILLA */
+	{ BMP_0WIDTH(0x0DD6, 0x0DD6) }, /* SINHALA VOWEL SIGN DIGA PAA-PILLA */
+	{ BMP_0WIDTH(0x0DD8, 0x0DDF) }, /* SINHALA VOWEL SIGN GAETTA-PILLA - SINHALA VOWEL SIGN GAYANUKITTA */
+	{ BMP_0WIDTH(0x0DF2, 0x0DF3) }, /* SINHALA VOWEL SIGN DIGA GAETTA-PILLA - SINHALA VOWEL SIGN DIGA GAYANUKITTA */
+	{ BMP_0WIDTH(0x0E31, 0x0E31) }, /* THAI CHARACTER MAI HAN-AKAT */
+	{ BMP_0WIDTH(0x0E34, 0x0E3A) }, /* THAI CHARACTER SARA I - THAI CHARACTER PHINTHU */
+	{ BMP_0WIDTH(0x0E47, 0x0E4E) }, /* THAI CHARACTER MAITAIKHU - THAI CHARACTER YAMAKKAN */
+	{ BMP_0WIDTH(0x0EB1, 0x0EB1) }, /* LAO VOWEL SIGN MAI KAN */
+	{ BMP_0WIDTH(0x0EB4, 0x0EBC) }, /* LAO VOWEL SIGN I - LAO SEMIVOWEL SIGN LO */
+	{ BMP_0WIDTH(0x0EC8, 0x0ECE) }, /* LAO TONE MAI EK - LAO YAMAKKAN */
+	{ BMP_0WIDTH(0x0F18, 0x0F19) }, /* TIBETAN ASTROLOGICAL SIGN -KHYUD PA - TIBETAN ASTROLOGICAL SIGN SDONG TSHUGS */
+	{ BMP_0WIDTH(0x0F35, 0x0F35) }, /* TIBETAN MARK NGAS BZUNG NYI ZLA */
+	{ BMP_0WIDTH(0x0F37, 0x0F37) }, /* TIBETAN MARK NGAS BZUNG SGOR RTAGS */
+	{ BMP_0WIDTH(0x0F39, 0x0F39) }, /* TIBETAN MARK TSA -PHRU */
+	{ BMP_0WIDTH(0x0F3E, 0x0F3F) }, /* TIBETAN SIGN YAR TSHES - TIBETAN SIGN MAR TSHES */
+	{ BMP_0WIDTH(0x0F71, 0x0F84) }, /* TIBETAN VOWEL SIGN AA - TIBETAN MARK HALANTA */
+	{ BMP_0WIDTH(0x0F86, 0x0F87) }, /* TIBETAN SIGN LCI RTAGS - TIBETAN SIGN YANG RTAGS */
+	{ BMP_0WIDTH(0x0F8D, 0x0F97) }, /* TIBETAN SUBJOINED SIGN LCE TSA CAN - TIBETAN SUBJOINED LETTER JA */
+	{ BMP_0WIDTH(0x0F99, 0x0FBC) }, /* TIBETAN SUBJOINED LETTER NYA - TIBETAN SUBJOINED LETTER FIXED-FORM RA */
+	{ BMP_0WIDTH(0x0FC6, 0x0FC6) }, /* TIBETAN SYMBOL PADMA GDAN */
+	{ BMP_0WIDTH(0x102B, 0x103E) }, /* MYANMAR VOWEL SIGN TALL AA - MYANMAR CONSONANT SIGN MEDIAL HA */
+	{ BMP_0WIDTH(0x1056, 0x1059) }, /* MYANMAR VOWEL SIGN VOCALIC R - MYANMAR VOWEL SIGN VOCALIC LL */
+	{ BMP_0WIDTH(0x105E, 0x1060) }, /* MYANMAR CONSONANT SIGN MON MEDIAL NA - MYANMAR CONSONANT SIGN MON MEDIAL LA */
+	{ BMP_0WIDTH(0x1062, 0x1064) }, /* MYANMAR VOWEL SIGN SGAW KAREN EU - MYANMAR TONE MARK SGAW KAREN KE PHO */
+	{ BMP_0WIDTH(0x1067, 0x106D) }, /* MYANMAR VOWEL SIGN WESTERN PWO KAREN EU - MYANMAR SIGN WESTERN PWO KAREN TONE-5 */
+	{ BMP_0WIDTH(0x1071, 0x1074) }, /* MYANMAR VOWEL SIGN GEBA KAREN I - MYANMAR VOWEL SIGN KAYAH EE */
+	{ BMP_0WIDTH(0x1082, 0x108D) }, /* MYANMAR CONSONANT SIGN SHAN MEDIAL WA - MYANMAR SIGN SHAN COUNCIL EMPHATIC TONE */
+	{ BMP_0WIDTH(0x108F, 0x108F) }, /* MYANMAR SIGN RUMAI PALAUNG TONE-5 */
+	{ BMP_0WIDTH(0x109A, 0x109D) }, /* MYANMAR SIGN KHAMTI TONE-1 - MYANMAR VOWEL SIGN AITON AI */
+	{ BMP_2WIDTH(0x1100, 0x115F) }, /* HANGUL CHOSEONG KIYEOK - HANGUL CHOSEONG FILLER */
+	{ BMP_0WIDTH(0x135D, 0x135F) }, /* ETHIOPIC COMBINING GEMINATION AND VOWEL LENGTH MARK - ETHIOPIC COMBINING GEMINATION MARK */
+	{ BMP_0WIDTH(0x1712, 0x1715) }, /* TAGALOG VOWEL SIGN I - TAGALOG SIGN PAMUDPOD */
+	{ BMP_0WIDTH(0x1732, 0x1734) }, /* HANUNOO VOWEL SIGN I - HANUNOO SIGN PAMUDPOD */
+	{ BMP_0WIDTH(0x1752, 0x1753) }, /* BUHID VOWEL SIGN I - BUHID VOWEL SIGN U */
+	{ BMP_0WIDTH(0x1772, 0x1773) }, /* TAGBANWA VOWEL SIGN I - TAGBANWA VOWEL SIGN U */
+	{ BMP_0WIDTH(0x17B4, 0x17D3) }, /* KHMER VOWEL INHERENT AQ - KHMER SIGN BATHAMASAT */
+	{ BMP_0WIDTH(0x17DD, 0x17DD) }, /* KHMER SIGN ATTHACAN */
+	{ BMP_0WIDTH(0x180B, 0x180F) }, /* MONGOLIAN FREE VARIATION SELECTOR ONE - MONGOLIAN FREE VARIATION SELECTOR FOUR */
+	{ BMP_0WIDTH(0x1885, 0x1886) }, /* MONGOLIAN LETTER ALI GALI BALUDA - MONGOLIAN LETTER ALI GALI THREE BALUDA */
+	{ BMP_0WIDTH(0x18A9, 0x18A9) }, /* MONGOLIAN LETTER ALI GALI DAGALGA */
+	{ BMP_0WIDTH(0x1920, 0x192B) }, /* LIMBU VOWEL SIGN A - LIMBU SUBJOINED LETTER WA */
+	{ BMP_0WIDTH(0x1930, 0x193B) }, /* LIMBU SMALL LETTER KA - LIMBU SIGN SA-I */
+	{ BMP_0WIDTH(0x1A17, 0x1A1B) }, /* BUGINESE VOWEL SIGN I - BUGINESE VOWEL SIGN AE */
+	{ BMP_0WIDTH(0x1A55, 0x1A5E) }, /* TAI THAM CONSONANT SIGN MEDIAL RA - TAI THAM CONSONANT SIGN SA */
+	{ BMP_0WIDTH(0x1A60, 0x1A7C) }, /* TAI THAM SIGN SAKOT - TAI THAM SIGN KHUEN-LUE KARAN */
+	{ BMP_0WIDTH(0x1A7F, 0x1A7F) }, /* TAI THAM COMBINING CRYPTOGRAMMIC DOT */
+	{ BMP_0WIDTH(0x1AB0, 0x1ACE) }, /* COMBINING DOUBLED CIRCUMFLEX ACCENT - COMBINING LATIN SMALL LETTER INSULAR T */
+	{ BMP_0WIDTH(0x1B00, 0x1B04) }, /* BALINESE SIGN ULU RICEM - BALINESE SIGN BISAH */
+	{ BMP_0WIDTH(0x1B34, 0x1B44) }, /* BALINESE SIGN REREKAN - BALINESE ADEG ADEG */
+	{ BMP_0WIDTH(0x1B6B, 0x1B73) }, /* BALINESE MUSICAL SYMBOL COMBINING TEGEH - BALINESE MUSICAL SYMBOL COMBINING GONG */
+	{ BMP_0WIDTH(0x1B80, 0x1B82) }, /* SUNDANESE SIGN PANYECEK - SUNDANESE SIGN PANGWISAD */
+	{ BMP_0WIDTH(0x1BA1, 0x1BAD) }, /* SUNDANESE CONSONANT SIGN PAMINGKAL - SUNDANESE CONSONANT SIGN PASANGAN WA */
+	{ BMP_0WIDTH(0x1BE6, 0x1BF3) }, /* BATAK SIGN TOMPI - BATAK PANONGONAN */
+	{ BMP_0WIDTH(0x1C24, 0x1C37) }, /* LEPCHA SUBJOINED LETTER YA - LEPCHA SIGN NUKTA */
+	{ BMP_0WIDTH(0x1CD0, 0x1CD2) }, /* VEDIC TONE KARSHANA - VEDIC TONE PRENKHA */
+	{ BMP_0WIDTH(0x1CD4, 0x1CE8) }, /* VEDIC SIGN YAJURVEDIC MIDLINE SVARITA - VEDIC SIGN VISARGA ANUDATTA WITH TAIL */
+	{ BMP_0WIDTH(0x1CED, 0x1CED) }, /* VEDIC SIGN TIRYAK */
+	{ BMP_0WIDTH(0x1CF4, 0x1CF4) }, /* VEDIC TONE CANDRA ABOVE */
+	{ BMP_0WIDTH(0x1CF7, 0x1CF9) }, /* VEDIC SIGN ATIKRAMA - VEDIC TONE DOUBLE RING ABOVE */
+	{ BMP_0WIDTH(0x1DC0, 0x1DFF) }, /* COMBINING DOTTED GRAVE ACCENT - COMBINING RIGHT ARROWHEAD AND DOWN ARROWHEAD BELOW */
+	{ BMP_0WIDTH(0x200B, 0x200F) }, /* ZERO WIDTH SPACE - RIGHT-TO-LEFT MARK */
+	{ BMP_0WIDTH(0x202A, 0x202E) }, /* LEFT-TO-RIGHT EMBEDDING - RIGHT-TO-LEFT OVERRIDE */
+	{ BMP_0WIDTH(0x2060, 0x2064) }, /* WORD JOINER - INVISIBLE PLUS */
+	{ BMP_0WIDTH(0x2066, 0x206F) }, /* LEFT-TO-RIGHT ISOLATE - NOMINAL DIGIT SHAPES */
+	{ BMP_0WIDTH(0x20D0, 0x20F0) }, /* COMBINING LEFT HARPOON ABOVE - COMBINING ASTERISK ABOVE */
+	{ BMP_2WIDTH(0x231A, 0x231B) }, /* WATCH - HOURGLASS */
+	{ BMP_2WIDTH(0x2329, 0x232A) }, /* LEFT-POINTING ANGLE BRACKET - RIGHT-POINTING ANGLE BRACKET */
+	{ BMP_2WIDTH(0x23E9, 0x23EC) }, /* BLACK RIGHT-POINTING DOUBLE TRIANGLE - BLACK DOWN-POINTING DOUBLE TRIANGLE */
+	{ BMP_2WIDTH(0x23F0, 0x23F0) }, /* ALARM CLOCK */
+	{ BMP_2WIDTH(0x23F3, 0x23F3) }, /* HOURGLASS WITH FLOWING SAND */
+	{ BMP_2WIDTH(0x25FD, 0x25FE) }, /* WHITE MEDIUM SMALL SQUARE - BLACK MEDIUM SMALL SQUARE */
+	{ BMP_2WIDTH(0x2614, 0x2615) }, /* UMBRELLA WITH RAIN DROPS - HOT BEVERAGE */
+	{ BMP_2WIDTH(0x2630, 0x2637) }, /* TRIGRAM FOR HEAVEN - TRIGRAM FOR EARTH */
+	{ BMP_0WIDTH(0x2640, 0x2640) }, /* FEMALE SIGN */
+	{ BMP_0WIDTH(0x2642, 0x2642) }, /* MALE SIGN */
+	{ BMP_2WIDTH(0x2648, 0x2653) }, /* ARIES - PISCES */
+	{ BMP_2WIDTH(0x267F, 0x267F) }, /* WHEELCHAIR SYMBOL */
+	{ BMP_2WIDTH(0x268A, 0x268F) }, /* MONOGRAM FOR YANG - DIGRAM FOR GREATER YIN */
+	{ BMP_2WIDTH(0x2693, 0x2693) }, /* ANCHOR */
+	{ BMP_2WIDTH(0x26A1, 0x26A1) }, /* HIGH VOLTAGE SIGN */
+	{ BMP_0WIDTH(0x26A7, 0x26A7) }, /* MALE WITH STROKE AND MALE AND FEMALE SIGN */
+	{ BMP_2WIDTH(0x26AA, 0x26AB) }, /* MEDIUM WHITE CIRCLE - MEDIUM BLACK CIRCLE */
+	{ BMP_2WIDTH(0x26BD, 0x26BE) }, /* SOCCER BALL - BASEBALL */
+	{ BMP_2WIDTH(0x26C4, 0x26C5) }, /* SNOWMAN WITHOUT SNOW - SUN BEHIND CLOUD */
+	{ BMP_2WIDTH(0x26CE, 0x26CE) }, /* OPHIUCHUS */
+	{ BMP_2WIDTH(0x26D4, 0x26D4) }, /* NO ENTRY */
+	{ BMP_2WIDTH(0x26EA, 0x26EA) }, /* CHURCH */
+	{ BMP_2WIDTH(0x26F2, 0x26F3) }, /* FOUNTAIN - FLAG IN HOLE */
+	{ BMP_2WIDTH(0x26F5, 0x26F5) }, /* SAILBOAT */
+	{ BMP_2WIDTH(0x26FA, 0x26FA) }, /* TENT */
+	{ BMP_2WIDTH(0x26FD, 0x26FD) }, /* FUEL PUMP */
+	{ BMP_2WIDTH(0x2705, 0x2705) }, /* WHITE HEAVY CHECK MARK */
+	{ BMP_2WIDTH(0x270A, 0x270B) }, /* RAISED FIST - RAISED HAND */
+	{ BMP_2WIDTH(0x2728, 0x2728) }, /* SPARKLES */
+	{ BMP_2WIDTH(0x274C, 0x274C) }, /* CROSS MARK */
+	{ BMP_2WIDTH(0x274E, 0x274E) }, /* NEGATIVE SQUARED CROSS MARK */
+	{ BMP_2WIDTH(0x2753, 0x2755) }, /* BLACK QUESTION MARK ORNAMENT - WHITE EXCLAMATION MARK ORNAMENT */
+	{ BMP_2WIDTH(0x2757, 0x2757) }, /* HEAVY EXCLAMATION MARK SYMBOL */
+	{ BMP_2WIDTH(0x2795, 0x2797) }, /* HEAVY PLUS SIGN - HEAVY DIVISION SIGN */
+	{ BMP_2WIDTH(0x27B0, 0x27B0) }, /* CURLY LOOP */
+	{ BMP_2WIDTH(0x27BF, 0x27BF) }, /* DOUBLE CURLY LOOP */
+	{ BMP_2WIDTH(0x2B1B, 0x2B1C) }, /* BLACK LARGE SQUARE - WHITE LARGE SQUARE */
+	{ BMP_2WIDTH(0x2B50, 0x2B50) }, /* WHITE MEDIUM STAR */
+	{ BMP_2WIDTH(0x2B55, 0x2B55) }, /* HEAVY LARGE CIRCLE */
+	{ BMP_0WIDTH(0x2CEF, 0x2CF1) }, /* COPTIC COMBINING NI ABOVE - COPTIC COMBINING SPIRITUS LENIS */
+	{ BMP_0WIDTH(0x2D7F, 0x2D7F) }, /* TIFINAGH CONSONANT JOINER */
+	{ BMP_0WIDTH(0x2DE0, 0x2DFF) }, /* COMBINING CYRILLIC LETTER BE - COMBINING CYRILLIC LETTER IOTIFIED BIG YUS */
+	{ BMP_2WIDTH(0x2E80, 0x2E99) }, /* CJK RADICAL REPEAT - CJK RADICAL RAP */
+	{ BMP_2WIDTH(0x2E9B, 0x2EF3) }, /* CJK RADICAL CHOKE - CJK RADICAL C-SIMPLIFIED TURTLE */
+	{ BMP_2WIDTH(0x2F00, 0x2FD5) }, /* KANGXI RADICAL ONE - KANGXI RADICAL FLUTE */
+	{ BMP_2WIDTH(0x2FF0, 0x3029) }, /* IDEOGRAPHIC DESCRIPTION CHARACTER LEFT TO RIGHT - HANGZHOU NUMERAL NINE */
+	{ BMP_0WIDTH(0x302A, 0x302F) }, /* IDEOGRAPHIC LEVEL TONE MARK - HANGUL DOUBLE DOT TONE MARK */
+	{ BMP_2WIDTH(0x3030, 0x303E) }, /* WAVY DASH - IDEOGRAPHIC VARIATION INDICATOR */
+	{ BMP_2WIDTH(0x3041, 0x3096) }, /* HIRAGANA LETTER SMALL A - HIRAGANA LETTER SMALL KE */
+	{ BMP_0WIDTH(0x3099, 0x309A) }, /* COMBINING KATAKANA-HIRAGANA VOICED SOUND MARK - COMBINING KATAKANA-HIRAGANA SEMI-VOICED SOUND MARK */
+	{ BMP_2WIDTH(0x309B, 0x30FF) }, /* KATAKANA-HIRAGANA VOICED SOUND MARK - KATAKANA DIGRAPH KOTO */
+	{ BMP_2WIDTH(0x3105, 0x312F) }, /* BOPOMOFO LETTER B - BOPOMOFO LETTER NN */
+	{ BMP_2WIDTH(0x3131, 0x318E) }, /* HANGUL LETTER KIYEOK - HANGUL LETTER ARAEAE */
+	{ BMP_2WIDTH(0x3190, 0x31E5) }, /* IDEOGRAPHIC ANNOTATION LINKING MARK - CJK STROKE SZP */
+	{ BMP_2WIDTH(0x31EF, 0x321E) }, /* IDEOGRAPHIC DESCRIPTION CHARACTER SUBTRACTION - PARENTHESIZED KOREAN CHARACTER O HU */
+	{ BMP_2WIDTH(0x3220, 0x3247) }, /* PARENTHESIZED IDEOGRAPH ONE - CIRCLED IDEOGRAPH KOTO */
+	{ BMP_2WIDTH(0x3250, 0xA48C) }, /* PARTNERSHIP SIGN - YI SYLLABLE YYR */
+	{ BMP_2WIDTH(0xA490, 0xA4C6) }, /* YI RADICAL QOT - YI RADICAL KE */
+	{ BMP_0WIDTH(0xA66F, 0xA672) }, /* COMBINING CYRILLIC VZMET - COMBINING CYRILLIC THOUSAND MILLIONS SIGN */
+	{ BMP_0WIDTH(0xA674, 0xA67D) }, /* COMBINING CYRILLIC LETTER UKRAINIAN IE - COMBINING CYRILLIC PAYEROK */
+	{ BMP_0WIDTH(0xA69E, 0xA69F) }, /* COMBINING CYRILLIC LETTER EF - COMBINING CYRILLIC LETTER IOTIFIED E */
+	{ BMP_0WIDTH(0xA6F0, 0xA6F1) }, /* BAMUM COMBINING MARK KOQNDON - BAMUM COMBINING MARK TUKWENTIS */
+	{ BMP_0WIDTH(0xA802, 0xA802) }, /* SYLOTI NAGRI SIGN DVISVARA */
+	{ BMP_0WIDTH(0xA806, 0xA806) }, /* SYLOTI NAGRI SIGN HASANTA */
+	{ BMP_0WIDTH(0xA80B, 0xA80B) }, /* SYLOTI NAGRI SIGN ANUSVARA */
+	{ BMP_0WIDTH(0xA823, 0xA827) }, /* SYLOTI NAGRI VOWEL SIGN A - SYLOTI NAGRI VOWEL SIGN OO */
+	{ BMP_0WIDTH(0xA82C, 0xA82C) }, /* SYLOTI NAGRI SIGN ALTERNATE HASANTA */
+	{ BMP_0WIDTH(0xA880, 0xA881) }, /* SAURASHTRA SIGN ANUSVARA - SAURASHTRA SIGN VISARGA */
+	{ BMP_0WIDTH(0xA8B4, 0xA8C5) }, /* SAURASHTRA CONSONANT SIGN HAARU - SAURASHTRA SIGN CANDRABINDU */
+	{ BMP_0WIDTH(0xA8E0, 0xA8F1) }, /* COMBINING DEVANAGARI DIGIT ZERO - COMBINING DEVANAGARI SIGN AVAGRAHA */
+	{ BMP_0WIDTH(0xA8FF, 0xA8FF) }, /* DEVANAGARI VOWEL SIGN AY */
+	{ BMP_0WIDTH(0xA926, 0xA92D) }, /* KAYAH LI VOWEL UE - KAYAH LI TONE CALYA PLOPHU */
+	{ BMP_0WIDTH(0xA947, 0xA953) }, /* REJANG VOWEL SIGN I - REJANG VIRAMA */
+	{ BMP_2WIDTH(0xA960, 0xA97C) }, /* HANGUL CHOSEONG TIKEUT-MIEUM - HANGUL CHOSEONG SSANGYEORINHIEUH */
+	{ BMP_0WIDTH(0xA980, 0xA983) }, /* JAVANESE SIGN PANYANGGA - JAVANESE SIGN WIGNYAN */
+	{ BMP_0WIDTH(0xA9B3, 0xA9C0) }, /* JAVANESE SIGN CECAK TELU - JAVANESE PANGKON */
+	{ BMP_0WIDTH(0xA9E5, 0xA9E5) }, /* MYANMAR SIGN SHAN SAW */
+	{ BMP_0WIDTH(0xAA29, 0xAA36) }, /* CHAM VOWEL SIGN AA - CHAM CONSONANT SIGN WA */
+	{ BMP_0WIDTH(0xAA43, 0xAA43) }, /* CHAM CONSONANT SIGN FINAL NG */
+	{ BMP_0WIDTH(0xAA4C, 0xAA4D) }, /* CHAM CONSONANT SIGN FINAL M - CHAM CONSONANT SIGN FINAL H */
+	{ BMP_0WIDTH(0xAA7B, 0xAA7D) }, /* MYANMAR SIGN PAO KAREN TONE - MYANMAR SIGN TAI LAING TONE-5 */
+	{ BMP_0WIDTH(0xAAB0, 0xAAB0) }, /* TAI VIET MAI KANG */
+	{ BMP_0WIDTH(0xAAB2, 0xAAB4) }, /* TAI VIET VOWEL I - TAI VIET VOWEL U */
+	{ BMP_0WIDTH(0xAAB7, 0xAAB8) }, /* TAI VIET MAI KHIT - TAI VIET VOWEL IA */
+	{ BMP_0WIDTH(0xAABE, 0xAABF) }, /* TAI VIET VOWEL AM - TAI VIET TONE MAI EK */
+	{ BMP_0WIDTH(0xAAC1, 0xAAC1) }, /* TAI VIET TONE MAI THO */
+	{ BMP_0WIDTH(0xAAEB, 0xAAEF) }, /* MEETEI MAYEK VOWEL SIGN II - MEETEI MAYEK VOWEL SIGN AAU */
+	{ BMP_0WIDTH(0xAAF5, 0xAAF6) }, /* MEETEI MAYEK VOWEL SIGN VISARGA - MEETEI MAYEK VIRAMA */
+	{ BMP_0WIDTH(0xABE3, 0xABEA) }, /* MEETEI MAYEK VOWEL SIGN ONAP - MEETEI MAYEK VOWEL SIGN NUNG */
+	{ BMP_0WIDTH(0xABEC, 0xABED) }, /* MEETEI MAYEK LUM IYEK - MEETEI MAYEK APUN IYEK */
+	{ BMP_2WIDTH(0xAC00, 0xD7A3) }, /* HANGUL SYLLABLE GA - HANGUL SYLLABLE HIH */
+	{ BMP_2WIDTH(0xF900, 0xFAFF) }, /* U+F900 - U+FAFF */
+	{ BMP_0WIDTH(0xFB1E, 0xFB1E) }, /* HEBREW POINT JUDEO-SPANISH VARIKA */
+	{ BMP_0WIDTH(0xFE00, 0xFE0F) }, /* VARIATION SELECTOR-1 - VARIATION SELECTOR-16 */
+	{ BMP_2WIDTH(0xFE10, 0xFE19) }, /* PRESENTATION FORM FOR VERTICAL COMMA - PRESENTATION FORM FOR VERTICAL HORIZONTAL ELLIPSIS */
+	{ BMP_0WIDTH(0xFE20, 0xFE2F) }, /* COMBINING LIGATURE LEFT HALF - COMBINING CYRILLIC TITLO RIGHT HALF */
+	{ BMP_2WIDTH(0xFE30, 0xFE52) }, /* PRESENTATION FORM FOR VERTICAL TWO DOT LEADER - SMALL FULL STOP */
+	{ BMP_2WIDTH(0xFE54, 0xFE66) }, /* SMALL SEMICOLON - SMALL EQUALS SIGN */
+	{ BMP_2WIDTH(0xFE68, 0xFE6B) }, /* SMALL REVERSE SOLIDUS - SMALL COMMERCIAL AT */
+	{ BMP_0WIDTH(0xFEFF, 0xFEFF) }, /* ZERO WIDTH NO-BREAK SPACE */
+	{ BMP_2WIDTH(0xFF01, 0xFF60) }, /* FULLWIDTH EXCLAMATION MARK - FULLWIDTH RIGHT WHITE PARENTHESIS */
+	{ BMP_2WIDTH(0xFFE0, 0xFFE6) }, /* FULLWIDTH CENT SIGN - FULLWIDTH WON SIGN */
+	{ BMP_0WIDTH(0xFFF9, 0xFFFB) }, /* INTERLINEAR ANNOTATION ANCHOR - INTERLINEAR ANNOTATION TERMINATOR */
 };
 
-/* Double-width character ranges (non-BMP, U+10000 and above) */
-static const struct ucs_interval32 ucs_double_width_non_bmp_ranges[] = {
-	{ 0x16FE0, 0x16FE3 }, /* TANGUT ITERATION MARK - OLD CHINESE ITERATION MARK */
-	{ 0x17000, 0x187F7 }, /* U+17000 - U+187F7 */
-	{ 0x18800, 0x18CD5 }, /* TANGUT COMPONENT-001 - KHITAN SMALL SCRIPT CHARACTER-18CD5 */
-	{ 0x18CFF, 0x18D08 }, /* U+18CFF - U+18D08 */
-	{ 0x1AFF0, 0x1AFF3 }, /* KATAKANA LETTER MINNAN TONE-2 - KATAKANA LETTER MINNAN TONE-5 */
-	{ 0x1AFF5, 0x1AFFB }, /* KATAKANA LETTER MINNAN TONE-7 - KATAKANA LETTER MINNAN NASALIZED TONE-5 */
-	{ 0x1AFFD, 0x1AFFE }, /* KATAKANA LETTER MINNAN NASALIZED TONE-7 - KATAKANA LETTER MINNAN NASALIZED TONE-8 */
-	{ 0x1B000, 0x1B122 }, /* KATAKANA LETTER ARCHAIC E - KATAKANA LETTER ARCHAIC WU */
-	{ 0x1B132, 0x1B132 }, /* HIRAGANA LETTER SMALL KO */
-	{ 0x1B150, 0x1B152 }, /* HIRAGANA LETTER SMALL WI - HIRAGANA LETTER SMALL WO */
-	{ 0x1B155, 0x1B155 }, /* KATAKANA LETTER SMALL KO */
-	{ 0x1B164, 0x1B167 }, /* KATAKANA LETTER SMALL WI - KATAKANA LETTER SMALL N */
-	{ 0x1B170, 0x1B2FB }, /* NUSHU CHARACTER-1B170 - NUSHU CHARACTER-1B2FB */
-	{ 0x1D300, 0x1D356 }, /* MONOGRAM FOR EARTH - TETRAGRAM FOR FOSTERING */
-	{ 0x1D360, 0x1D376 }, /* COUNTING ROD UNIT DIGIT ONE - IDEOGRAPHIC TALLY MARK FIVE */
-	{ 0x1F000, 0x1F02F }, /* U+1F000 - U+1F02F */
-	{ 0x1F0A0, 0x1F0FF }, /* U+1F0A0 - U+1F0FF */
-	{ 0x1F18E, 0x1F18E }, /* NEGATIVE SQUARED AB */
-	{ 0x1F191, 0x1F19A }, /* SQUARED CL - SQUARED VS */
-	{ 0x1F200, 0x1F202 }, /* SQUARE HIRAGANA HOKA - SQUARED KATAKANA SA */
-	{ 0x1F210, 0x1F23B }, /* SQUARED CJK UNIFIED IDEOGRAPH-624B - SQUARED CJK UNIFIED IDEOGRAPH-914D */
-	{ 0x1F240, 0x1F248 }, /* TORTOISE SHELL BRACKETED CJK UNIFIED IDEOGRAPH-672C - TORTOISE SHELL BRACKETED CJK UNIFIED IDEOGRAPH-6557 */
-	{ 0x1F250, 0x1F251 }, /* CIRCLED IDEOGRAPH ADVANTAGE - CIRCLED IDEOGRAPH ACCEPT */
-	{ 0x1F260, 0x1F265 }, /* ROUNDED SYMBOL FOR FU - ROUNDED SYMBOL FOR CAI */
-	{ 0x1F300, 0x1F3FA }, /* CYCLONE - AMPHORA */
-	{ 0x1F400, 0x1F64F }, /* RAT - PERSON WITH FOLDED HANDS */
-	{ 0x1F680, 0x1F9AF }, /* ROCKET - PROBING CANE */
-	{ 0x1F9B4, 0x1FAFF }, /* U+1F9B4 - U+1FAFF */
-	{ 0x20000, 0x2FFFD }, /* U+20000 - U+2FFFD */
-	{ 0x30000, 0x3FFFD }, /* U+30000 - U+3FFFD */
+/* Combined zero- and double-width ranges (non-BMP, U+10000 and above).
+ * The first 33 entries host the BMP double-width bitmap in the low
+ * 8 bits of `last`. */
+static const struct ucs_width32 ucs_nonbmp_ranges[] = {
+	{ RANGE_0WIDTH(0x101FD, 0x101FD)   /* PHAISTOS DISC SIGN COMBINING OBLIQUE STROKE */
+	  | BMP_2W_BITS(0b00000000) }, /* BMP entries [  0..  7] */
+	{ RANGE_0WIDTH(0x102E0, 0x102E0)   /* COPTIC EPACT THOUSANDS MARK */
+	  | BMP_2W_BITS(0b00000000) }, /* BMP entries [  8.. 15] */
+	{ RANGE_0WIDTH(0x10376, 0x1037A)   /* COMBINING OLD PERMIC LETTER AN - COMBINING OLD PERMIC LETTER SII */
+	  | BMP_2W_BITS(0b00000000) }, /* BMP entries [ 16.. 23] */
+	{ RANGE_0WIDTH(0x10A01, 0x10A03)   /* KHAROSHTHI VOWEL SIGN I - KHAROSHTHI VOWEL SIGN VOCALIC R */
+	  | BMP_2W_BITS(0b00000000) }, /* BMP entries [ 24.. 31] */
+	{ RANGE_0WIDTH(0x10A05, 0x10A06)   /* KHAROSHTHI VOWEL SIGN E - KHAROSHTHI VOWEL SIGN O */
+	  | BMP_2W_BITS(0b00000000) }, /* BMP entries [ 32.. 39] */
+	{ RANGE_0WIDTH(0x10A0C, 0x10A0F)   /* KHAROSHTHI VOWEL LENGTH MARK - KHAROSHTHI SIGN VISARGA */
+	  | BMP_2W_BITS(0b00000000) }, /* BMP entries [ 40.. 47] */
+	{ RANGE_0WIDTH(0x10A38, 0x10A3A)   /* KHAROSHTHI SIGN BAR ABOVE - KHAROSHTHI SIGN DOT BELOW */
+	  | BMP_2W_BITS(0b00000000) }, /* BMP entries [ 48.. 55] */
+	{ RANGE_0WIDTH(0x10A3F, 0x10A3F)   /* KHAROSHTHI VIRAMA */
+	  | BMP_2W_BITS(0b00000000) }, /* BMP entries [ 56.. 63] */
+	{ RANGE_0WIDTH(0x10AE5, 0x10AE6)   /* MANICHAEAN ABBREVIATION MARK ABOVE - MANICHAEAN ABBREVIATION MARK BELOW */
+	  | BMP_2W_BITS(0b00000000) }, /* BMP entries [ 64.. 71] */
+	{ RANGE_0WIDTH(0x10D24, 0x10D27)   /* HANIFI ROHINGYA SIGN HARBAHAY - HANIFI ROHINGYA SIGN TASSI */
+	  | BMP_2W_BITS(0b00000000) }, /* BMP entries [ 72.. 79] */
+	{ RANGE_0WIDTH(0x10D69, 0x10D6D)   /* GARAY VOWEL SIGN E - GARAY CONSONANT NASALIZATION MARK */
+	  | BMP_2W_BITS(0b00000000) }, /* BMP entries [ 80.. 87] */
+	{ RANGE_0WIDTH(0x10EAB, 0x10EAC)   /* YEZIDI COMBINING HAMZA MARK - YEZIDI COMBINING MADDA MARK */
+	  | BMP_2W_BITS(0b00000000) }, /* BMP entries [ 88.. 95] */
+	{ RANGE_0WIDTH(0x10EFC, 0x10EFF)   /* ARABIC COMBINING ALEF OVERLAY - ARABIC SMALL LOW WORD MADDA */
+	  | BMP_2W_BITS(0b00000000) }, /* BMP entries [ 96..103] */
+	{ RANGE_0WIDTH(0x10F46, 0x10F50)   /* SOGDIAN COMBINING DOT BELOW - SOGDIAN COMBINING STROKE BELOW */
+	  | BMP_2W_BITS(0b00000000) }, /* BMP entries [104..111] */
+	{ RANGE_0WIDTH(0x10F82, 0x10F85)   /* OLD UYGHUR COMBINING DOT ABOVE - OLD UYGHUR COMBINING TWO DOTS BELOW */
+	  | BMP_2W_BITS(0b00000000) }, /* BMP entries [112..119] */
+	{ RANGE_0WIDTH(0x11000, 0x11002)   /* BRAHMI SIGN CANDRABINDU - BRAHMI SIGN VISARGA */
+	  | BMP_2W_BITS(0b00001000) }, /* BMP entries [120..127] */
+	{ RANGE_0WIDTH(0x11038, 0x11046)   /* BRAHMI VOWEL SIGN AA - BRAHMI VIRAMA */
+	  | BMP_2W_BITS(0b00000000) }, /* BMP entries [128..135] */
+	{ RANGE_0WIDTH(0x11070, 0x11070)   /* BRAHMI SIGN OLD TAMIL VIRAMA */
+	  | BMP_2W_BITS(0b00000000) }, /* BMP entries [136..143] */
+	{ RANGE_0WIDTH(0x11073, 0x11074)   /* BRAHMI VOWEL SIGN OLD TAMIL SHORT E - BRAHMI VOWEL SIGN OLD TAMIL SHORT O */
+	  | BMP_2W_BITS(0b00000000) }, /* BMP entries [144..151] */
+	{ RANGE_0WIDTH(0x1107F, 0x11082)   /* BRAHMI NUMBER JOINER - KAITHI SIGN VISARGA */
+	  | BMP_2W_BITS(0b10000000) }, /* BMP entries [152..159] */
+	{ RANGE_0WIDTH(0x110B0, 0x110BA)   /* KAITHI VOWEL SIGN AA - KAITHI SIGN NUKTA */
+	  | BMP_2W_BITS(0b01111111) }, /* BMP entries [160..167] */
+	{ RANGE_0WIDTH(0x110BD, 0x110BD)   /* KAITHI NUMBER SIGN */
+	  | BMP_2W_BITS(0b10111110) }, /* BMP entries [168..175] */
+	{ RANGE_0WIDTH(0x110C2, 0x110C2)   /* KAITHI VOWEL SIGN VOCALIC R */
+	  | BMP_2W_BITS(0b11111111) }, /* BMP entries [176..183] */
+	{ RANGE_0WIDTH(0x110CD, 0x110CD)   /* KAITHI NUMBER SIGN ABOVE */
+	  | BMP_2W_BITS(0b11111111) }, /* BMP entries [184..191] */
+	{ RANGE_0WIDTH(0x11100, 0x11102)   /* CHAKMA SIGN CANDRABINDU - CHAKMA SIGN VISARGA */
+	  | BMP_2W_BITS(0b00111111) }, /* BMP entries [192..199] */
+	{ RANGE_0WIDTH(0x11127, 0x11134)   /* CHAKMA VOWEL SIGN A - CHAKMA MAAYYAA */
+	  | BMP_2W_BITS(0b11011110) }, /* BMP entries [200..207] */
+	{ RANGE_0WIDTH(0x11145, 0x11146)   /* CHAKMA VOWEL SIGN AA - CHAKMA VOWEL SIGN EI */
+	  | BMP_2W_BITS(0b11111110) }, /* BMP entries [208..215] */
+	{ RANGE_0WIDTH(0x11173, 0x11173)   /* MAHAJANI SIGN NUKTA */
+	  | BMP_2W_BITS(0b00000001) }, /* BMP entries [216..223] */
+	{ RANGE_0WIDTH(0x11180, 0x11182)   /* SHARADA SIGN CANDRABINDU - SHARADA SIGN VISARGA */
+	  | BMP_2W_BITS(0b00000000) }, /* BMP entries [224..231] */
+	{ RANGE_0WIDTH(0x111B3, 0x111C0)   /* SHARADA VOWEL SIGN AA - SHARADA SIGN VIRAMA */
+	  | BMP_2W_BITS(0b00000001) }, /* BMP entries [232..239] */
+	{ RANGE_0WIDTH(0x111C9, 0x111CC)   /* SHARADA SANDHI MARK - SHARADA EXTRA SHORT VOWEL MARK */
+	  | BMP_2W_BITS(0b00000000) }, /* BMP entries [240..247] */
+	{ RANGE_0WIDTH(0x111CE, 0x111CF)   /* SHARADA VOWEL SIGN PRISHTHAMATRA E - SHARADA SIGN INVERTED CANDRABINDU */
+	  | BMP_2W_BITS(0b10100110) }, /* BMP entries [248..255] */
+	{ RANGE_0WIDTH(0x1122C, 0x11237)   /* KHOJKI VOWEL SIGN AA - KHOJKI SIGN SHADDA */
+	  | BMP_2W_BITS(0b00011011) }, /* BMP entries [256..261] */
+	{ RANGE_0WIDTH(0x1123E, 0x1123E) }, /* KHOJKI SIGN SUKUN */
+	{ RANGE_0WIDTH(0x11241, 0x11241) }, /* KHOJKI VOWEL SIGN VOCALIC R */
+	{ RANGE_0WIDTH(0x112DF, 0x112EA) }, /* KHUDAWADI SIGN ANUSVARA - KHUDAWADI SIGN VIRAMA */
+	{ RANGE_0WIDTH(0x11300, 0x11303) }, /* GRANTHA SIGN COMBINING ANUSVARA ABOVE - GRANTHA SIGN VISARGA */
+	{ RANGE_0WIDTH(0x1133B, 0x1133C) }, /* COMBINING BINDU BELOW - GRANTHA SIGN NUKTA */
+	{ RANGE_0WIDTH(0x1133E, 0x11344) }, /* GRANTHA VOWEL SIGN AA - GRANTHA VOWEL SIGN VOCALIC RR */
+	{ RANGE_0WIDTH(0x11347, 0x11348) }, /* GRANTHA VOWEL SIGN EE - GRANTHA VOWEL SIGN AI */
+	{ RANGE_0WIDTH(0x1134B, 0x1134D) }, /* GRANTHA VOWEL SIGN OO - GRANTHA SIGN VIRAMA */
+	{ RANGE_0WIDTH(0x11357, 0x11357) }, /* GRANTHA AU LENGTH MARK */
+	{ RANGE_0WIDTH(0x11362, 0x11363) }, /* GRANTHA VOWEL SIGN VOCALIC L - GRANTHA VOWEL SIGN VOCALIC LL */
+	{ RANGE_0WIDTH(0x11366, 0x1136C) }, /* COMBINING GRANTHA DIGIT ZERO - COMBINING GRANTHA DIGIT SIX */
+	{ RANGE_0WIDTH(0x11370, 0x11374) }, /* COMBINING GRANTHA LETTER A - COMBINING GRANTHA LETTER PA */
+	{ RANGE_0WIDTH(0x113B8, 0x113C0) }, /* TULU-TIGALARI VOWEL SIGN AA - TULU-TIGALARI VOWEL SIGN VOCALIC LL */
+	{ RANGE_0WIDTH(0x113C2, 0x113C2) }, /* TULU-TIGALARI VOWEL SIGN EE */
+	{ RANGE_0WIDTH(0x113C5, 0x113C5) }, /* TULU-TIGALARI VOWEL SIGN AI */
+	{ RANGE_0WIDTH(0x113C7, 0x113CA) }, /* TULU-TIGALARI VOWEL SIGN OO - TULU-TIGALARI SIGN CANDRA ANUNASIKA */
+	{ RANGE_0WIDTH(0x113CC, 0x113D0) }, /* TULU-TIGALARI SIGN ANUSVARA - TULU-TIGALARI CONJOINER */
+	{ RANGE_0WIDTH(0x113D2, 0x113D2) }, /* TULU-TIGALARI GEMINATION MARK */
+	{ RANGE_0WIDTH(0x113E1, 0x113E2) }, /* TULU-TIGALARI VEDIC TONE SVARITA - TULU-TIGALARI VEDIC TONE ANUDATTA */
+	{ RANGE_0WIDTH(0x11435, 0x11446) }, /* NEWA VOWEL SIGN AA - NEWA SIGN NUKTA */
+	{ RANGE_0WIDTH(0x1145E, 0x1145E) }, /* NEWA SANDHI MARK */
+	{ RANGE_0WIDTH(0x114B0, 0x114C3) }, /* TIRHUTA VOWEL SIGN AA - TIRHUTA SIGN NUKTA */
+	{ RANGE_0WIDTH(0x115AF, 0x115B5) }, /* SIDDHAM VOWEL SIGN AA - SIDDHAM VOWEL SIGN VOCALIC RR */
+	{ RANGE_0WIDTH(0x115B8, 0x115C0) }, /* SIDDHAM VOWEL SIGN E - SIDDHAM SIGN NUKTA */
+	{ RANGE_0WIDTH(0x115DC, 0x115DD) }, /* SIDDHAM VOWEL SIGN ALTERNATE U - SIDDHAM VOWEL SIGN ALTERNATE UU */
+	{ RANGE_0WIDTH(0x11630, 0x11640) }, /* MODI VOWEL SIGN AA - MODI SIGN ARDHACANDRA */
+	{ RANGE_0WIDTH(0x116AB, 0x116B7) }, /* TAKRI SIGN ANUSVARA - TAKRI SIGN NUKTA */
+	{ RANGE_0WIDTH(0x1171D, 0x1172B) }, /* AHOM CONSONANT SIGN MEDIAL LA - AHOM SIGN KILLER */
+	{ RANGE_0WIDTH(0x1182C, 0x1183A) }, /* DOGRA VOWEL SIGN AA - DOGRA SIGN NUKTA */
+	{ RANGE_0WIDTH(0x11930, 0x11935) }, /* DIVES AKURU VOWEL SIGN AA - DIVES AKURU VOWEL SIGN E */
+	{ RANGE_0WIDTH(0x11937, 0x11938) }, /* DIVES AKURU VOWEL SIGN AI - DIVES AKURU VOWEL SIGN O */
+	{ RANGE_0WIDTH(0x1193B, 0x1193E) }, /* DIVES AKURU SIGN ANUSVARA - DIVES AKURU VIRAMA */
+	{ RANGE_0WIDTH(0x11940, 0x11940) }, /* DIVES AKURU MEDIAL YA */
+	{ RANGE_0WIDTH(0x11942, 0x11943) }, /* DIVES AKURU MEDIAL RA - DIVES AKURU SIGN NUKTA */
+	{ RANGE_0WIDTH(0x119D1, 0x119D7) }, /* NANDINAGARI VOWEL SIGN AA - NANDINAGARI VOWEL SIGN VOCALIC RR */
+	{ RANGE_0WIDTH(0x119DA, 0x119E0) }, /* NANDINAGARI VOWEL SIGN E - NANDINAGARI SIGN VIRAMA */
+	{ RANGE_0WIDTH(0x119E4, 0x119E4) }, /* NANDINAGARI VOWEL SIGN PRISHTHAMATRA E */
+	{ RANGE_0WIDTH(0x11A01, 0x11A0A) }, /* ZANABAZAR SQUARE VOWEL SIGN I - ZANABAZAR SQUARE VOWEL LENGTH MARK */
+	{ RANGE_0WIDTH(0x11A33, 0x11A39) }, /* ZANABAZAR SQUARE FINAL CONSONANT MARK - ZANABAZAR SQUARE SIGN VISARGA */
+	{ RANGE_0WIDTH(0x11A3B, 0x11A3E) }, /* ZANABAZAR SQUARE CLUSTER-FINAL LETTER YA - ZANABAZAR SQUARE CLUSTER-FINAL LETTER VA */
+	{ RANGE_0WIDTH(0x11A47, 0x11A47) }, /* ZANABAZAR SQUARE SUBJOINER */
+	{ RANGE_0WIDTH(0x11A51, 0x11A5B) }, /* SOYOMBO VOWEL SIGN I - SOYOMBO VOWEL LENGTH MARK */
+	{ RANGE_0WIDTH(0x11A8A, 0x11A99) }, /* SOYOMBO FINAL CONSONANT SIGN G - SOYOMBO SUBJOINER */
+	{ RANGE_0WIDTH(0x11C2F, 0x11C36) }, /* BHAIKSUKI VOWEL SIGN AA - BHAIKSUKI VOWEL SIGN VOCALIC L */
+	{ RANGE_0WIDTH(0x11C38, 0x11C3F) }, /* BHAIKSUKI VOWEL SIGN E - BHAIKSUKI SIGN VIRAMA */
+	{ RANGE_0WIDTH(0x11C92, 0x11CA7) }, /* MARCHEN SUBJOINED LETTER KA - MARCHEN SUBJOINED LETTER ZA */
+	{ RANGE_0WIDTH(0x11CA9, 0x11CB6) }, /* MARCHEN SUBJOINED LETTER YA - MARCHEN SIGN CANDRABINDU */
+	{ RANGE_0WIDTH(0x11D31, 0x11D36) }, /* MASARAM GONDI VOWEL SIGN AA - MASARAM GONDI VOWEL SIGN VOCALIC R */
+	{ RANGE_0WIDTH(0x11D3A, 0x11D3A) }, /* MASARAM GONDI VOWEL SIGN E */
+	{ RANGE_0WIDTH(0x11D3C, 0x11D3D) }, /* MASARAM GONDI VOWEL SIGN AI - MASARAM GONDI VOWEL SIGN O */
+	{ RANGE_0WIDTH(0x11D3F, 0x11D45) }, /* MASARAM GONDI VOWEL SIGN AU - MASARAM GONDI VIRAMA */
+	{ RANGE_0WIDTH(0x11D47, 0x11D47) }, /* MASARAM GONDI RA-KARA */
+	{ RANGE_0WIDTH(0x11D8A, 0x11D8E) }, /* GUNJALA GONDI VOWEL SIGN AA - GUNJALA GONDI VOWEL SIGN UU */
+	{ RANGE_0WIDTH(0x11D90, 0x11D91) }, /* GUNJALA GONDI VOWEL SIGN EE - GUNJALA GONDI VOWEL SIGN AI */
+	{ RANGE_0WIDTH(0x11D93, 0x11D97) }, /* GUNJALA GONDI VOWEL SIGN OO - GUNJALA GONDI VIRAMA */
+	{ RANGE_0WIDTH(0x11EF3, 0x11EF6) }, /* MAKASAR VOWEL SIGN I - MAKASAR VOWEL SIGN O */
+	{ RANGE_0WIDTH(0x11F00, 0x11F01) }, /* KAWI SIGN CANDRABINDU - KAWI SIGN ANUSVARA */
+	{ RANGE_0WIDTH(0x11F03, 0x11F03) }, /* KAWI SIGN VISARGA */
+	{ RANGE_0WIDTH(0x11F34, 0x11F3A) }, /* KAWI VOWEL SIGN AA - KAWI VOWEL SIGN VOCALIC R */
+	{ RANGE_0WIDTH(0x11F3E, 0x11F42) }, /* KAWI VOWEL SIGN E - KAWI CONJOINER */
+	{ RANGE_0WIDTH(0x11F5A, 0x11F5A) }, /* KAWI SIGN NUKTA */
+	{ RANGE_0WIDTH(0x13430, 0x13440) }, /* EGYPTIAN HIEROGLYPH VERTICAL JOINER - EGYPTIAN HIEROGLYPH MIRROR HORIZONTALLY */
+	{ RANGE_0WIDTH(0x13447, 0x13455) }, /* EGYPTIAN HIEROGLYPH MODIFIER DAMAGED AT TOP START - EGYPTIAN HIEROGLYPH MODIFIER DAMAGED */
+	{ RANGE_0WIDTH(0x1611E, 0x1612F) }, /* GURUNG KHEMA VOWEL SIGN AA - GURUNG KHEMA SIGN THOLHOMA */
+	{ RANGE_0WIDTH(0x16AF0, 0x16AF4) }, /* BASSA VAH COMBINING HIGH TONE - BASSA VAH COMBINING HIGH-LOW TONE */
+	{ RANGE_0WIDTH(0x16B30, 0x16B36) }, /* PAHAWH HMONG MARK CIM TUB - PAHAWH HMONG MARK CIM TAUM */
+	{ RANGE_0WIDTH(0x16F4F, 0x16F4F) }, /* MIAO SIGN CONSONANT MODIFIER BAR */
+	{ RANGE_0WIDTH(0x16F51, 0x16F87) }, /* MIAO SIGN ASPIRATION - MIAO VOWEL SIGN UI */
+	{ RANGE_0WIDTH(0x16F8F, 0x16F92) }, /* MIAO TONE RIGHT - MIAO TONE BELOW */
+	{ RANGE_2WIDTH(0x16FE0, 0x16FE3) }, /* TANGUT ITERATION MARK - OLD CHINESE ITERATION MARK */
+	{ RANGE_0WIDTH(0x16FE4, 0x16FE4) }, /* KHITAN SMALL SCRIPT FILLER */
+	{ RANGE_0WIDTH(0x16FF0, 0x16FF1) }, /* VIETNAMESE ALTERNATE READING MARK CA - VIETNAMESE ALTERNATE READING MARK NHAY */
+	{ RANGE_2WIDTH(0x17000, 0x187F7) }, /* U+17000 - U+187F7 */
+	{ RANGE_2WIDTH(0x18800, 0x18CD5) }, /* TANGUT COMPONENT-001 - KHITAN SMALL SCRIPT CHARACTER-18CD5 */
+	{ RANGE_2WIDTH(0x18CFF, 0x18D08) }, /* U+18CFF - U+18D08 */
+	{ RANGE_2WIDTH(0x1AFF0, 0x1AFF3) }, /* KATAKANA LETTER MINNAN TONE-2 - KATAKANA LETTER MINNAN TONE-5 */
+	{ RANGE_2WIDTH(0x1AFF5, 0x1AFFB) }, /* KATAKANA LETTER MINNAN TONE-7 - KATAKANA LETTER MINNAN NASALIZED TONE-5 */
+	{ RANGE_2WIDTH(0x1AFFD, 0x1AFFE) }, /* KATAKANA LETTER MINNAN NASALIZED TONE-7 - KATAKANA LETTER MINNAN NASALIZED TONE-8 */
+	{ RANGE_2WIDTH(0x1B000, 0x1B122) }, /* KATAKANA LETTER ARCHAIC E - KATAKANA LETTER ARCHAIC WU */
+	{ RANGE_2WIDTH(0x1B132, 0x1B132) }, /* HIRAGANA LETTER SMALL KO */
+	{ RANGE_2WIDTH(0x1B150, 0x1B152) }, /* HIRAGANA LETTER SMALL WI - HIRAGANA LETTER SMALL WO */
+	{ RANGE_2WIDTH(0x1B155, 0x1B155) }, /* KATAKANA LETTER SMALL KO */
+	{ RANGE_2WIDTH(0x1B164, 0x1B167) }, /* KATAKANA LETTER SMALL WI - KATAKANA LETTER SMALL N */
+	{ RANGE_2WIDTH(0x1B170, 0x1B2FB) }, /* NUSHU CHARACTER-1B170 - NUSHU CHARACTER-1B2FB */
+	{ RANGE_0WIDTH(0x1BC9D, 0x1BC9E) }, /* DUPLOYAN THICK LETTER SELECTOR - DUPLOYAN DOUBLE MARK */
+	{ RANGE_0WIDTH(0x1BCA0, 0x1BCA3) }, /* SHORTHAND FORMAT LETTER OVERLAP - SHORTHAND FORMAT UP STEP */
+	{ RANGE_0WIDTH(0x1CF00, 0x1CF2D) }, /* ZNAMENNY COMBINING MARK GORAZDO NIZKO S KRYZHEM ON LEFT - ZNAMENNY COMBINING MARK KRYZH ON LEFT */
+	{ RANGE_0WIDTH(0x1CF30, 0x1CF46) }, /* ZNAMENNY COMBINING TONAL RANGE MARK MRACHNO - ZNAMENNY PRIZNAK MODIFIER ROG */
+	{ RANGE_0WIDTH(0x1D165, 0x1D169) }, /* MUSICAL SYMBOL COMBINING STEM - MUSICAL SYMBOL COMBINING TREMOLO-3 */
+	{ RANGE_0WIDTH(0x1D16D, 0x1D182) }, /* MUSICAL SYMBOL COMBINING AUGMENTATION DOT - MUSICAL SYMBOL COMBINING LOURE */
+	{ RANGE_0WIDTH(0x1D185, 0x1D18B) }, /* MUSICAL SYMBOL COMBINING DOIT - MUSICAL SYMBOL COMBINING TRIPLE TONGUE */
+	{ RANGE_0WIDTH(0x1D1AA, 0x1D1AD) }, /* MUSICAL SYMBOL COMBINING DOWN BOW - MUSICAL SYMBOL COMBINING SNAP PIZZICATO */
+	{ RANGE_0WIDTH(0x1D242, 0x1D244) }, /* COMBINING GREEK MUSICAL TRISEME - COMBINING GREEK MUSICAL PENTASEME */
+	{ RANGE_2WIDTH(0x1D300, 0x1D356) }, /* MONOGRAM FOR EARTH - TETRAGRAM FOR FOSTERING */
+	{ RANGE_2WIDTH(0x1D360, 0x1D376) }, /* COUNTING ROD UNIT DIGIT ONE - IDEOGRAPHIC TALLY MARK FIVE */
+	{ RANGE_0WIDTH(0x1DA00, 0x1DA36) }, /* SIGNWRITING HEAD RIM - SIGNWRITING AIR SUCKING IN */
+	{ RANGE_0WIDTH(0x1DA3B, 0x1DA6C) }, /* SIGNWRITING MOUTH CLOSED NEUTRAL - SIGNWRITING EXCITEMENT */
+	{ RANGE_0WIDTH(0x1DA75, 0x1DA75) }, /* SIGNWRITING UPPER BODY TILTING FROM HIP JOINTS */
+	{ RANGE_0WIDTH(0x1DA84, 0x1DA84) }, /* SIGNWRITING LOCATION HEAD NECK */
+	{ RANGE_0WIDTH(0x1DA9B, 0x1DA9F) }, /* SIGNWRITING FILL MODIFIER-2 - SIGNWRITING FILL MODIFIER-6 */
+	{ RANGE_0WIDTH(0x1DAA1, 0x1DAAF) }, /* SIGNWRITING ROTATION MODIFIER-2 - SIGNWRITING ROTATION MODIFIER-16 */
+	{ RANGE_0WIDTH(0x1E000, 0x1E006) }, /* COMBINING GLAGOLITIC LETTER AZU - COMBINING GLAGOLITIC LETTER ZHIVETE */
+	{ RANGE_0WIDTH(0x1E008, 0x1E018) }, /* COMBINING GLAGOLITIC LETTER ZEMLJA - COMBINING GLAGOLITIC LETTER HERU */
+	{ RANGE_0WIDTH(0x1E01B, 0x1E021) }, /* COMBINING GLAGOLITIC LETTER SHTA - COMBINING GLAGOLITIC LETTER YATI */
+	{ RANGE_0WIDTH(0x1E023, 0x1E024) }, /* COMBINING GLAGOLITIC LETTER YU - COMBINING GLAGOLITIC LETTER SMALL YUS */
+	{ RANGE_0WIDTH(0x1E026, 0x1E02A) }, /* COMBINING GLAGOLITIC LETTER YO - COMBINING GLAGOLITIC LETTER FITA */
+	{ RANGE_0WIDTH(0x1E08F, 0x1E08F) }, /* COMBINING CYRILLIC SMALL LETTER BYELORUSSIAN-UKRAINIAN I */
+	{ RANGE_0WIDTH(0x1E130, 0x1E136) }, /* NYIAKENG PUACHUE HMONG TONE-B - NYIAKENG PUACHUE HMONG TONE-D */
+	{ RANGE_0WIDTH(0x1E2AE, 0x1E2AE) }, /* TOTO SIGN RISING TONE */
+	{ RANGE_0WIDTH(0x1E2EC, 0x1E2EF) }, /* WANCHO TONE TUP - WANCHO TONE KOINI */
+	{ RANGE_0WIDTH(0x1E4EC, 0x1E4EF) }, /* NAG MUNDARI SIGN MUHOR - NAG MUNDARI SIGN SUTUH */
+	{ RANGE_0WIDTH(0x1E5EE, 0x1E5EF) }, /* OL ONAL SIGN MU - OL ONAL SIGN IKIR */
+	{ RANGE_0WIDTH(0x1E8D0, 0x1E8D6) }, /* MENDE KIKAKUI COMBINING NUMBER TEENS - MENDE KIKAKUI COMBINING NUMBER MILLIONS */
+	{ RANGE_0WIDTH(0x1E944, 0x1E94A) }, /* ADLAM ALIF LENGTHENER - ADLAM NUKTA */
+	{ RANGE_2WIDTH(0x1F000, 0x1F02F) }, /* U+1F000 - U+1F02F */
+	{ RANGE_2WIDTH(0x1F0A0, 0x1F0FF) }, /* U+1F0A0 - U+1F0FF */
+	{ RANGE_2WIDTH(0x1F18E, 0x1F18E) }, /* NEGATIVE SQUARED AB */
+	{ RANGE_2WIDTH(0x1F191, 0x1F19A) }, /* SQUARED CL - SQUARED VS */
+	{ RANGE_2WIDTH(0x1F200, 0x1F202) }, /* SQUARE HIRAGANA HOKA - SQUARED KATAKANA SA */
+	{ RANGE_2WIDTH(0x1F210, 0x1F23B) }, /* SQUARED CJK UNIFIED IDEOGRAPH-624B - SQUARED CJK UNIFIED IDEOGRAPH-914D */
+	{ RANGE_2WIDTH(0x1F240, 0x1F248) }, /* TORTOISE SHELL BRACKETED CJK UNIFIED IDEOGRAPH-672C - TORTOISE SHELL BRACKETED CJK UNIFIED IDEOGRAPH-6557 */
+	{ RANGE_2WIDTH(0x1F250, 0x1F251) }, /* CIRCLED IDEOGRAPH ADVANTAGE - CIRCLED IDEOGRAPH ACCEPT */
+	{ RANGE_2WIDTH(0x1F260, 0x1F265) }, /* ROUNDED SYMBOL FOR FU - ROUNDED SYMBOL FOR CAI */
+	{ RANGE_2WIDTH(0x1F300, 0x1F3FA) }, /* CYCLONE - AMPHORA */
+	{ RANGE_0WIDTH(0x1F3FB, 0x1F3FF) }, /* EMOJI MODIFIER FITZPATRICK TYPE-1-2 - EMOJI MODIFIER FITZPATRICK TYPE-6 */
+	{ RANGE_2WIDTH(0x1F400, 0x1F64F) }, /* RAT - PERSON WITH FOLDED HANDS */
+	{ RANGE_2WIDTH(0x1F680, 0x1F9AF) }, /* ROCKET - PROBING CANE */
+	{ RANGE_0WIDTH(0x1F9B0, 0x1F9B3) }, /* EMOJI COMPONENT RED HAIR - EMOJI COMPONENT WHITE HAIR */
+	{ RANGE_2WIDTH(0x1F9B4, 0x1FAFF) }, /* U+1F9B4 - U+1FAFF */
+	{ RANGE_2WIDTH(0x20000, 0x2FFFD) }, /* U+20000 - U+2FFFD */
+	{ RANGE_2WIDTH(0x30000, 0x3FFFD) }, /* U+30000 - U+3FFFD */
+	{ RANGE_0WIDTH(0xE0001, 0xE0001) }, /* LANGUAGE TAG */
+	{ RANGE_0WIDTH(0xE0020, 0xE007F) }, /* TAG SPACE - CANCEL TAG */
+	{ RANGE_0WIDTH(0xE0100, 0xE01EF) }, /* VARIATION SELECTOR-17 - VARIATION SELECTOR-256 */
 };
diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index e99636ab9db5..cf26fb8f6545 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -3094,8 +3094,12 @@ static void vc_con_rewind(struct vc_data *vc)
 static int vc_process_ucs(struct vc_data *vc, int *c, int *tc)
 {
 	u32 prev_c, curr_c = *c;
+	unsigned int w = ucs_get_width(curr_c);
 
-	if (ucs_is_double_width(curr_c)) {
+	if (likely(w == 1))
+		return 1;
+
+	if (w == 2) {
 		/*
 		 * The Unicode screen memory is allocated only when
 		 * required. This is one such case as we need to remember
@@ -3105,12 +3109,9 @@ static int vc_process_ucs(struct vc_data *vc, int *c, int *tc)
 		return 2;
 	}
 
-	if (!ucs_is_zero_width(curr_c))
-		return 1;
-
 	/* From here curr_c is known to be zero-width. */
 
-	if (ucs_is_double_width(vc_uniscr_getc(vc, -2))) {
+	if (ucs_get_width(vc_uniscr_getc(vc, -2)) == 2) {
 		/*
 		 * Let's merge this zero-width code point with the preceding
 		 * double-width code point by replacing the existing
diff --git a/include/linux/consolemap.h b/include/linux/consolemap.h
index 6180b803795c..539d488fdc03 100644
--- a/include/linux/consolemap.h
+++ b/include/linux/consolemap.h
@@ -28,8 +28,7 @@ int conv_uni_to_pc(struct vc_data *conp, long ucs);
 u32 conv_8bit_to_uni(unsigned char c);
 int conv_uni_to_8bit(u32 uni);
 void console_map_init(void);
-bool ucs_is_double_width(uint32_t cp);
-bool ucs_is_zero_width(uint32_t cp);
+unsigned int ucs_get_width(uint32_t cp);
 u32 ucs_recompose(u32 base, u32 mark);
 u32 ucs_get_fallback(u32 cp);
 #else
@@ -62,14 +61,9 @@ static inline int conv_uni_to_8bit(u32 uni)
 
 static inline void console_map_init(void) { }
 
-static inline bool ucs_is_double_width(uint32_t cp)
+static inline unsigned int ucs_get_width(uint32_t cp)
 {
-	return false;
-}
-
-static inline bool ucs_is_zero_width(uint32_t cp)
-{
-	return false;
+	return 1;
 }
 
 static inline u32 ucs_recompose(u32 base, u32 mark)
-- 
2.54.0

