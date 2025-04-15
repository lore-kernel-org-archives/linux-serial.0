Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E5A23D2B4;
	Tue, 15 Apr 2025 19:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744744943; cv=none; b=srvp2zKpG1JzPxHl4GMAVEV/wTLkyCIH/26knHCaxtzV0IAzUJn2Ba5D87sIbf6CUlhJiFzIz8izFlmVwpDpedEhCXPzkzRcIzxci2ZyJm/dHMjvhQzq90l/z0QN7iSaKLwfqHqiEyM7bcr8NXBr3rG6RVjqsHLPLDlKag7cAfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744744943; c=relaxed/simple;
	bh=IMopP9qGZnbSLzoykCHwRFQnzkFrus3cxL5DmPnKdko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PTgbqgoon51ee4ZOMGS1TA9KLRfGIZpw6GxHag4OeI55GMslTtLChZSQbFcIsAxO/adOZEAYqhxdVJhouCzzrpld0sBS9M4yqeZQ082gASQzT4rUrVzro+tjJ5OqrhOwKOm0MEcm5xhDv6oOlf3DZGzkLEljzzyE52aVkUbDPiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=OS5Bxld/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F8Oqh2k5; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="OS5Bxld/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F8Oqh2k5"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 23E4D13801DF;
	Tue, 15 Apr 2025 15:22:20 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Tue, 15 Apr 2025 15:22:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1744744940; x=
	1744831340; bh=TOECGAz+1UN5jJO3zU++rVDP+tWki0SmZFEregeb9FQ=; b=O
	S5Bxld/8Ogp1LHGlQ8mki6TPaOAD0Br06Wx1z9tZhLvs9B41e6afRwLU2MHFnY6k
	Q4GfsJWPEsEnW8uq65uc7J90S8ymYRVRvBo9H9wiEwHK+GnkSePIXNwTzhBm4Fj7
	h9jT5E0nmYjjxtliGChq7WsADxKEeu+I+Gp47fEvJyGistmzQVpfQDjROeXwKz/D
	qsfvXEBAvt5FdBx4sbJbREv2VBxU3SnIEur9oRA62DNRLr870sbnHtBYJkmS1znp
	aKbzmIFGY3t/4ncCXrycdE5YeTMwgJH4iN49O69jkK3R5UdtmEdrqEW+Ujv/UHhw
	OkpZsCwQR9n1ESY8qo2CA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1744744940; x=1744831340; bh=T
	OECGAz+1UN5jJO3zU++rVDP+tWki0SmZFEregeb9FQ=; b=F8Oqh2k5Xn7Jd6JZ9
	OYB6CirdD99cpvAsRl1NqEXMDswtSOc0lOKCfBq1TtmFksIicXDWaHYmbV4Y4Eu5
	QheklPHlSsHUtEnbPOyS/HfQVuPLfKMgg5Ym/7BKJ5Is5fTSFH8q4U9GPgc/SWqQ
	7IepNYt9t1NSTUCy4pKo7T3rvHWW5cyeE02TAthFoNXRsDAIN8ujOf2yt/PK3+u8
	4z4SNEXPLyhmMqPU84K8zC5ix28WvJZU+npnrODANrGJorGOmU5sHgj2xWaBQkEH
	ocXtTg56ru21sDcqAHYUrj0xW5xARRAbaSDRNwv4+6Ged2Glh8blRN5UQP6kHHRC
	c58+A==
X-ME-Sender: <xms:67H-ZyMFgw8bhaZO3qEsjRE_GC9PMAt04ZuVoQaEWy7NXduIkRJwqg>
    <xme:67H-Zw--oK_Szuf7x6Z4ycPFDAIjNcaQEviF-OKlbwy6nWcmjyR0hWor2z9q1kh_j
    HKiZZenusU817H543g>
X-ME-Received: <xmr:67H-Z5S-ZmGrB9WWAkdg1gejdzkc5srTWS9CkpEmLnwKtnbApVKHmH1-j90D4QpA1goov7B0JKvgyvOWn7EB4HWaTPZRaKLPq5AK8DTNBixwvmBMpw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdegfedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredt
    tdenucfhrhhomheppfhitgholhgrshcurfhithhrvgcuoehnihgtohesfhhluhignhhitg
    drnhgvtheqnecuggftrfgrthhtvghrnheptdejueeiieehieeuffduvdffleehkeelgeek
    udekfeffhfduffdugedvteeihfetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepnhhitghosehflhhugihnihgtrdhnvghtpdhnsggprhgtphht
    thhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehnphhithhrvgessggrhi
    hlihgsrhgvrdgtohhmpdhrtghpthhtohepjhhirhhishhlrggshieskhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorh
    hgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheplhhinhhugidqshgvrhhirghlsehvghgvrhdrkhgvrhhnvghlrd
    horhhg
X-ME-Proxy: <xmx:67H-ZyuJSxX25v-MjVpeQeuIHrvz0T8DPLBLBJhx5vaPgtWGQM3mEw>
    <xmx:67H-Z6fNTejoA9nlqUeeW4j1XYdf0d30BfzxZkW_J2RAELudKauBew>
    <xmx:67H-Z202v7jImSOC_xPuFmFpxBMrPWdIfk6YlwjiCj8OD0cBf6DQBA>
    <xmx:67H-Z--raZlBwWyy3ghM-EMKmfU7mU3BZKV27Nz0U6aTlE5gPQ63wg>
    <xmx:7LH-Zzed0JGjl2PUyNmJjPSwKz8Y6cZw24AOtkv8lWIMrZSmS2xY8qSi>
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Apr 2025 15:22:19 -0400 (EDT)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 345BF1116618;
	Tue, 15 Apr 2025 15:22:19 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Nicolas Pitre <npitre@baylibre.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 12/13] vt: update gen_ucs_width_table.py to make tables more space efficient
Date: Tue, 15 Apr 2025 15:18:01 -0400
Message-ID: <20250415192212.33949-13-nico@fluxnic.net>
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

Split table ranges into BMP (16-bit) and non-BMP (above 16-bit).
This reduces the corresponding text size by 20-25%.

Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
---
 drivers/tty/vt/gen_ucs_width_table.py | 55 ++++++++++++++++++++++++---
 1 file changed, 49 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/vt/gen_ucs_width_table.py b/drivers/tty/vt/gen_ucs_width_table.py
index 00510444a7..059ed9a8ba 100755
--- a/drivers/tty/vt/gen_ucs_width_table.py
+++ b/drivers/tty/vt/gen_ucs_width_table.py
@@ -194,6 +194,27 @@ def write_tables(zero_width_ranges, double_width_ranges):
         double_width_ranges: List of (start, end) ranges for double-width characters
     """
 
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
+    # Split ranges into BMP and non-BMP
+    zero_width_bmp, zero_width_non_bmp = split_ranges_by_size(zero_width_ranges)
+    double_width_bmp, double_width_non_bmp = split_ranges_by_size(double_width_ranges)
+
     # Function to generate code point description comments
     def get_code_point_comment(start, end):
         try:
@@ -221,22 +242,44 @@ def write_tables(zero_width_ranges, double_width_ranges):
  * Unicode Version: {unicodedata.unidata_version}
  */
 
-/* Zero-width character ranges */
-static const struct ucs_interval ucs_zero_width_ranges[] = {{
+/* Zero-width character ranges (BMP - Basic Multilingual Plane, U+0000 to U+FFFF) */
+static const struct ucs_interval16 ucs_zero_width_bmp_ranges[] = {{
+""")
+
+        for start, end in zero_width_bmp:
+            comment = get_code_point_comment(start, end)
+            f.write(f"\t{{ 0x{start:04X}, 0x{end:04X} }}, {comment}\n")
+
+        f.write("""\
+};
+
+/* Zero-width character ranges (non-BMP, U+10000 and above) */
+static const struct ucs_interval32 ucs_zero_width_non_bmp_ranges[] = {
 """)
 
-        for start, end in zero_width_ranges:
+        for start, end in zero_width_non_bmp:
             comment = get_code_point_comment(start, end)
             f.write(f"\t{{ 0x{start:05X}, 0x{end:05X} }}, {comment}\n")
 
         f.write("""\
 };
 
-/* Double-width character ranges */
-static const struct ucs_interval ucs_double_width_ranges[] = {
+/* Double-width character ranges (BMP - Basic Multilingual Plane, U+0000 to U+FFFF) */
+static const struct ucs_interval16 ucs_double_width_bmp_ranges[] = {
+""")
+
+        for start, end in double_width_bmp:
+            comment = get_code_point_comment(start, end)
+            f.write(f"\t{{ 0x{start:04X}, 0x{end:04X} }}, {comment}\n")
+
+        f.write("""\
+};
+
+/* Double-width character ranges (non-BMP, U+10000 and above) */
+static const struct ucs_interval32 ucs_double_width_non_bmp_ranges[] = {
 """)
 
-        for start, end in double_width_ranges:
+        for start, end in double_width_non_bmp:
             comment = get_code_point_comment(start, end)
             f.write(f"\t{{ 0x{start:05X}, 0x{end:05X} }}, {comment}\n")
 
-- 
2.49.0

