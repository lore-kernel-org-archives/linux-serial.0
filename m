Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8008F257449;
	Thu, 17 Apr 2025 18:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744915754; cv=none; b=F/RCOCPMieL5gWPfbh15EdgPkm6JUdWktYzcqejNgjcXnx0Eb8NTuH4xNEGWu0r8wouvfPTMlyRxzub8LoSrfGBfEppIEmOvDeuxwvDBAFMwLRlBSndzZ+7PXYJHAdHo+4HZOwtp4of6bbD7tWYuOrA9c6DeEzLNvN7pKnHBr2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744915754; c=relaxed/simple;
	bh=KFMvkj61UsgzOT+/THAdX4dpcixoST3uT5J6ksm48HA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pw6fqmiAfd9TKzC4Se5eiakeMWvTsRbsvfFkxpmeGBg7RJer3hb0DfyNgmWXmLoQDmxc749dEKvlHMhIKDznALIKaHN5AQEKw4FnEZJL1oX4uy/V0Y9U4RvaI2Sfw1jJW2A4Lm+PZbPH0KIKxYMcMWuGmKh7OpLVvk/SVMFJhhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=kSZY+OQ1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vgrBnXDm; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="kSZY+OQ1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vgrBnXDm"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2A8D0254015C;
	Thu, 17 Apr 2025 14:49:09 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Thu, 17 Apr 2025 14:49:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1744915749; x=
	1745002149; bh=/D46HuyxAMriUAr8SS9DKG5cJKlZiMImdwjE0WjHI4E=; b=k
	SZY+OQ1WjvQidsUBaoQJlqK36rIhB6cDuE4K9LieFg3GP7IFtR23+iLKdw9UCXMi
	Rg3YLiOv2zk+rV0l0awV+YAfY9/jGaeiRd8vC9e11lWHyDv1YsKQCzM7CfI7D89C
	ilt2UpAX583ln0POV/Hg/W7G+mxVdFzEOjp8u7lvO1sndsbekp98b995Mc+YVSnp
	9t2aZRwwGtr+mf6PEVg6Ow809g1P5sIXC0Ke3ESrBpcYxnR4tj668GfNXguHQssa
	GMpUE4Drprp879LMGKeHt02qlGcKbZ9wqzbArOA4fav1a+t6ulRFddM8rW3QgyaR
	icm3rsSMVqAVeel0MBa/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1744915749; x=1745002149; bh=/
	D46HuyxAMriUAr8SS9DKG5cJKlZiMImdwjE0WjHI4E=; b=vgrBnXDma5v0pTxPU
	nJLT2QDODJNvL+XKwUMEbU5Qutx7Reaa2DTZ0F1YdkmGLo7i1ox6RDjsxMSB42oQ
	Xb0nvyVuHSIKyxiUu3kltxAqDympa8SQwGfUpkT9wRR2/PR8U8Y9xx8oJeuAy32z
	dUfOaez/X9EtE+Hac4oKJDQtbxTUU3bcAsbQq0UEairRz4Ga1uqEfFfXOPbaN3LK
	49GtST4JUB+XaOOrX8A2sbM/0S2uGOHoOCGTszmPCu4ty+BvImpZH+dIywhSCXUk
	tRFNs3BmpUcwSg9cAKAOZjxP4BdjQijez0cSWl3qjxiIH9SN/zQ9ARnEBd9iBLNg
	T5ywQ==
X-ME-Sender: <xms:JE0BaOTlrW0Kj9UntR42zvQ-WGJMvDS4nOoEp0MMvldLbtaEDG4WYw>
    <xme:JE0BaDzWu93mRtxCKSHbkL6zFh5yxWvvE831ReA8dJTkQ3xYrPRQ78tCieRa8pt8j
    WBoD1nWiwY1i8zgzcM>
X-ME-Received: <xmr:JE0BaL13JKrK41OdfhconWtMGSNmPsfbofjYFmffQrA1LjJBkaHQQikBReeK97lHuXgi5gJmkM7_kU-qvejFT4atmT4hxZEsyTESVZC3Wk4_3vZn4w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvfedttddvucetufdoteggodetrf
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
X-ME-Proxy: <xmx:JE0BaKA1OsKJt8VMjuhQVN7kmWrQvO31sjcHEZpUGFfzd7Eou-6HEw>
    <xmx:JE0BaHhZumrQHngft9fNRPPRNAp4pm3ZLovGTQ_E2A0tkc9NhcKD8A>
    <xmx:JE0BaGqEQOnJfcexJqL0UMYCEkA78QFN9xoi3J9PzTGBjwKq7pqEhQ>
    <xmx:JE0BaKguxbfnktRysXRPpBFCo0u4kfS4ZzwNUL2nMkQ0dzopI4bkFw>
    <xmx:JU0BaLTykhNgUsP9mb4sxezn2tiDiDDShNdp9tvSXQeBGIUf9MbeaMAU>
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Apr 2025 14:49:08 -0400 (EDT)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 3549711443D8;
	Thu, 17 Apr 2025 14:49:08 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Nicolas Pitre <npitre@baylibre.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 12/14] vt: update gen_ucs_width_table.py to make tables more space efficient
Date: Thu, 17 Apr 2025 14:45:14 -0400
Message-ID: <20250417184849.475581-13-nico@fluxnic.net>
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

Split table ranges into BMP (16-bit) and non-BMP (above 16-bit).
This reduces the corresponding text size by 20-25%.

Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
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

