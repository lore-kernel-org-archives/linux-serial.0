Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F3B189F5C;
	Thu, 10 Apr 2025 01:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744247946; cv=none; b=Zqn6fQEzrKEfwUPjhZQ+dea8DwpnVVUsShPINAQ59NYjoSWWC+CIc5vX/AOY7wHB47m3XwFs5DGchj8hKFGtJYwni+Prbw3K4TzNdTZIwCnQXm2cZBIry6SHjYADof+mICqStvm8uOmNmrcbat3uYGwokOMqS3IaI/vxMPKVd8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744247946; c=relaxed/simple;
	bh=tmnfp8FQyes4UwNmiDICLenwz4JDdWtdfJogWU6cNxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qBu8xl0Nbk5VWjGGO9QEAt7RXCyQtbAfz/amliW7lf4jqWkY9kPULcUvR9ulGGojyC4VTY8jmYBG+XDJPJAonrzTf5u4rO68g4mLZU/uR9i5XHWc3uNqf06Ap5ZTdZUcsKwoXY0yIpFY+N6TSBWGGgtanvycUefjpdcnypOWnzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=CkULa7kb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bIC/uEqs; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="CkULa7kb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bIC/uEqs"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B561A1140295;
	Wed,  9 Apr 2025 21:19:03 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Wed, 09 Apr 2025 21:19:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1744247943; x=
	1744334343; bh=qnKT4y+VqSv7GIH2zX73h94FGzDTN8DZlsY8YrX30t8=; b=C
	kULa7kbDhheaVWNtZ8gHDiKJvFYW3iFzQRwIlIiaooTY6jm+ONf5pQ4FYhiDYzr8
	/szP2YtrEsGdk/+n+tIDTMCldCvOi07/Sq7//As3qsnh0MDt+MFJaEA90FwFc+p6
	6iekap76sisdqm4hMhU3OEyNdJx8IOziTXZuksTJi9F0TB6JUf1YZhbZlcnUYy5x
	LDEgGTCcZ4mA25XC8gkbSB/HcKE8MmzBe6EyUHqW4GHZtpMIoAvhWbm5FqfOYw+5
	OjyHKrhp0yYqd0fCqQS/wAr8h5qG0MHK9mFd4nSjOlaYYd4Vv67gzs+m+/Nv+ZS5
	h39fJAJ9+S6BTQ8B8flTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1744247943; x=1744334343; bh=q
	nKT4y+VqSv7GIH2zX73h94FGzDTN8DZlsY8YrX30t8=; b=bIC/uEqs+IdbmJGLv
	Ld/StFzmcfootk9Yqe7r7l+t5Un4EOEjvWGO9613i3Fy6Ml+WMvGuBZ5mhWIRWNt
	R7sBB1hkKuIggI80WhAdOdQvUNUgiUVYMff1G52Tu4PF8tjmt+knZ9hJ4jXyKECY
	/Qyu0+GB73vkUiEa3IzxMkh1wOUtw7SVo1smyzxcYwdnpaDn/sEeyE7G8+DHMPEQ
	vMuBOU8002O68881k/vDQ670MM7XmF/F5Uqi0VfpH3d7WKE5/Y5z9zXWBmDoAFLA
	u8aP22Jr7P30bBnXRexaom3PQEunE2hzvRUtbeY0MbSzwfPLRsegdKEzpPiKAv7o
	RZaEQ==
X-ME-Sender: <xms:hxz3ZzWay6ah1dmd2QfcB8bKq-jlXp2lx4o9l6ePOHr4G9RHJ5SLGQ>
    <xme:hxz3Z7liDlhHMdGXfnDAwGCf_4EThX2_HtAlRvId36xWW0nmCuQ-qDiEVCc3Ji7Pi
    V9YoNIf5ACphqEppuQ>
X-ME-Received: <xmr:hxz3Z_aWvtIjcWTOmIhXt81lPCekX3VnHWcPj7AdWiQ42CjPpm812DLhhwsvJ8gH_My1ZAPlR5qaqQDGQBwEaYom7PXgVtQh-f-nrkOspD0jcL7z0w>
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
X-ME-Proxy: <xmx:hxz3Z-W2crr8p306FgCgIQ-22SpEMrqtJjAcMZVn0TPBwQsvCgvSAg>
    <xmx:hxz3Z9lhieCsDKtgKkqyeb09lnZhTg5LdVyFcKSYEJU1yNwv4D0BgA>
    <xmx:hxz3Z7c7WuuKBwCrC_Ca5VudhcmY9Y7WQ_S6uf6X6WY_2625BJhJWw>
    <xmx:hxz3Z3FoY3jAmJBGbBY5yhWgnPlQa4cqTW4draMPq7Jv2hxetF46yA>
    <xmx:hxz3Z5H0QGyS7OGTUDviWVGNWFVBHRrN_dA_UlnWYQwJ_vbX7U-xORdK>
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Apr 2025 21:19:03 -0400 (EDT)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id B802810D8B7C;
	Wed,  9 Apr 2025 21:19:02 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Nicolas Pitre <npitre@baylibre.com>,
	Dave Mielke <Dave@mielke.cc>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 09/11] vt: update gen_ucs_width.py to produce more space efficient tables
Date: Wed,  9 Apr 2025 21:14:01 -0400
Message-ID: <20250410011839.64418-10-nico@fluxnic.net>
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

Split table ranges into BMP (16-bit) and non-BMP (above 16-bit).
This reduces the corresponding text size by 20-25%.

Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
---
 drivers/tty/vt/gen_ucs_width.py | 154 +++++++++++++++++++++++---------
 1 file changed, 113 insertions(+), 41 deletions(-)

diff --git a/drivers/tty/vt/gen_ucs_width.py b/drivers/tty/vt/gen_ucs_width.py
index 41997fe001..c6cbc93e83 100755
--- a/drivers/tty/vt/gen_ucs_width.py
+++ b/drivers/tty/vt/gen_ucs_width.py
@@ -132,13 +132,49 @@ def generate_ucs_width():
         ranges.append((start, prev))
         return ranges
 
+    # Function to split ranges into BMP (16-bit) and non-BMP (above 16-bit)
+    def split_ranges_by_size(ranges):
+        bmp_ranges = []
+        non_bmp_ranges = []
+
+        for start, end in ranges:
+            if end <= 0xFFFF:
+                bmp_ranges.append((start, end))
+            elif start > 0xFFFF:
+                non_bmp_ranges.append((start, end))
+            else:
+                # Split the range at 0xFFFF
+                bmp_ranges.append((start, 0xFFFF))
+                non_bmp_ranges.append((0x10000, end))
+
+        return bmp_ranges, non_bmp_ranges
+
     # Extract ranges for each width
     zero_width_ranges = ranges_optimize(width_map, 0)
     double_width_ranges = ranges_optimize(width_map, 2)
 
+    # Split ranges into BMP and non-BMP
+    zero_width_bmp, zero_width_non_bmp = split_ranges_by_size(zero_width_ranges)
+    double_width_bmp, double_width_non_bmp = split_ranges_by_size(double_width_ranges)
+
     # Get Unicode version information
     unicode_version = unicodedata.unidata_version
 
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
     # Generate C implementation file
     with open(c_file, 'w') as f:
         f.write(f"""\
@@ -156,62 +192,77 @@ def generate_ucs_width():
 #include <linux/bsearch.h>
 #include <linux/consolemap.h>
 
-struct interval {{
+struct interval16 {{
+	uint16_t first;
+	uint16_t last;
+}};
+
+struct interval32 {{
 	uint32_t first;
 	uint32_t last;
 }};
 
-/* Zero-width character ranges */
-static const struct interval zero_width_ranges[] = {{
+/* Zero-width character ranges (BMP - Basic Multilingual Plane, U+0000 to U+FFFF) */
+static const struct interval16 zero_width_bmp[] = {{
 """)
 
-        for start, end in zero_width_ranges:
-            try:
-                start_char_desc = unicodedata.name(chr(start)) if start < 0x10000 else f"U+{start:05X}"
-                if start == end:
-                    comment = f"/* {start_char_desc} */"
-                else:
-                    end_char_desc = unicodedata.name(chr(end)) if end < 0x10000 else f"U+{end:05X}"
-                    comment = f"/* {start_char_desc} - {end_char_desc} */"
-            except:
-                if start == end:
-                    comment = f"/* U+{start:05X} */"
-                else:
-                    comment = f"/* U+{start:05X} - U+{end:05X} */"
+        for start, end in zero_width_bmp:
+            comment = get_code_point_comment(start, end)
+            f.write(f"\t{{ 0x{start:04X}, 0x{end:04X} }}, {comment}\n")
+
+        f.write("""\
+};
 
+/* Zero-width character ranges (non-BMP, U+10000 and above) */
+static const struct interval32 zero_width_non_bmp[] = {
+""")
+
+        for start, end in zero_width_non_bmp:
+            comment = get_code_point_comment(start, end)
             f.write(f"\t{{ 0x{start:05X}, 0x{end:05X} }}, {comment}\n")
 
         f.write("""\
 };
 
-/* Double-width character ranges */
-static const struct interval double_width_ranges[] = {
+/* Double-width character ranges (BMP - Basic Multilingual Plane, U+0000 to U+FFFF) */
+static const struct interval16 double_width_bmp[] = {
 """)
 
-        for start, end in double_width_ranges:
-            try:
-                start_char_desc = unicodedata.name(chr(start)) if start < 0x10000 else f"U+{start:05X}"
-                if start == end:
-                    comment = f"/* {start_char_desc} */"
-                else:
-                    end_char_desc = unicodedata.name(chr(end)) if end < 0x10000 else f"U+{end:05X}"
-                    comment = f"/* {start_char_desc} - {end_char_desc} */"
-            except:
-                if start == end:
-                    comment = f"/* U+{start:05X} */"
-                else:
-                    comment = f"/* U+{start:05X} - U+{end:05X} */"
+        for start, end in double_width_bmp:
+            comment = get_code_point_comment(start, end)
+            f.write(f"\t{{ 0x{start:04X}, 0x{end:04X} }}, {comment}\n")
+
+        f.write("""\
+};
 
+/* Double-width character ranges (non-BMP, U+10000 and above) */
+static const struct interval32 double_width_non_bmp[] = {
+""")
+
+        for start, end in double_width_non_bmp:
+            comment = get_code_point_comment(start, end)
             f.write(f"\t{{ 0x{start:05X}, 0x{end:05X} }}, {comment}\n")
 
         f.write("""\
 };
 
 
-static int ucs_cmp(const void *key, const void *element)
+static int ucs_cmp16(const void *key, const void *element)
+{
+	uint16_t cp = *(uint16_t *)key;
+	const struct interval16 *e = element;
+
+	if (cp > e->last)
+		return 1;
+	if (cp < e->first)
+		return -1;
+	return 0;
+}
+
+static int ucs_cmp32(const void *key, const void *element)
 {
 	uint32_t cp = *(uint32_t *)key;
-	const struct interval *e = element;
+	const struct interval32 *e = element;
 
 	if (cp > e->last)
 		return 1;
@@ -220,13 +271,22 @@ static int ucs_cmp(const void *key, const void *element)
 	return 0;
 }
 
-static bool is_in_interval(uint32_t cp, const struct interval *intervals, size_t count)
+static bool is_in_interval16(uint16_t cp, const struct interval16 *intervals, size_t count)
 {
 	if (cp < intervals[0].first || cp > intervals[count - 1].last)
 		return false;
 
 	return __inline_bsearch(&cp, intervals, count,
-				sizeof(*intervals), ucs_cmp) != NULL;
+				sizeof(*intervals), ucs_cmp16) != NULL;
+}
+
+static bool is_in_interval32(uint32_t cp, const struct interval32 *intervals, size_t count)
+{
+	if (cp < intervals[0].first || cp > intervals[count - 1].last)
+		return false;
+
+	return __inline_bsearch(&cp, intervals, count,
+				sizeof(*intervals), ucs_cmp32) != NULL;
 }
 
 /**
@@ -237,7 +297,9 @@ static bool is_in_interval(uint32_t cp, const struct interval *intervals, size_t
  */
 bool ucs_is_zero_width(uint32_t cp)
 {
-	return is_in_interval(cp, zero_width_ranges, ARRAY_SIZE(zero_width_ranges));
+	return (cp <= 0xFFFF)
+	       ? is_in_interval16(cp, zero_width_bmp, ARRAY_SIZE(zero_width_bmp))
+	       : is_in_interval32(cp, zero_width_non_bmp, ARRAY_SIZE(zero_width_non_bmp));
 }
 
 /**
@@ -248,17 +310,27 @@ bool ucs_is_zero_width(uint32_t cp)
  */
 bool ucs_is_double_width(uint32_t cp)
 {
-	return is_in_interval(cp, double_width_ranges, ARRAY_SIZE(double_width_ranges));
+	return (cp <= 0xFFFF)
+	       ? is_in_interval16(cp, double_width_bmp, ARRAY_SIZE(double_width_bmp))
+	       : is_in_interval32(cp, double_width_non_bmp, ARRAY_SIZE(double_width_non_bmp));
 }
 """)
 
     # Print summary
-    zero_width_count = sum(end - start + 1 for start, end in zero_width_ranges)
-    double_width_count = sum(end - start + 1 for start, end in double_width_ranges)
+    zero_width_bmp_count = sum(end - start + 1 for start, end in zero_width_bmp)
+    zero_width_non_bmp_count = sum(end - start + 1 for start, end in zero_width_non_bmp)
+    double_width_bmp_count = sum(end - start + 1 for start, end in double_width_bmp)
+    double_width_non_bmp_count = sum(end - start + 1 for start, end in double_width_non_bmp)
+
+    total_zero_width = zero_width_bmp_count + zero_width_non_bmp_count
+    total_double_width = double_width_bmp_count + double_width_non_bmp_count
 
     print(f"Generated {c_file} with:")
-    print(f"- {len(zero_width_ranges)} zero-width ranges covering ~{zero_width_count} code points")
-    print(f"- {len(double_width_ranges)} double-width ranges covering ~{double_width_count} code points")
+    print(f"- {len(zero_width_bmp)} zero-width BMP ranges (16-bit) covering ~{zero_width_bmp_count} code points")
+    print(f"- {len(zero_width_non_bmp)} zero-width non-BMP ranges (32-bit) covering ~{zero_width_non_bmp_count} code points")
+    print(f"- {len(double_width_bmp)} double-width BMP ranges (16-bit) covering ~{double_width_bmp_count} code points")
+    print(f"- {len(double_width_non_bmp)} double-width non-BMP ranges (32-bit) covering ~{double_width_non_bmp_count} code points")
+    print(f"Total: {len(zero_width_bmp) + len(zero_width_non_bmp) + len(double_width_bmp) + len(double_width_non_bmp)} ranges covering ~{total_zero_width + total_double_width} code points")
 
 if __name__ == "__main__":
     generate_ucs_width()
-- 
2.49.0

