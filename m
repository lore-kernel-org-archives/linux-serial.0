Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CABC2571C4;
	Thu, 17 Apr 2025 18:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744915753; cv=none; b=N4xBEa6+py/zrIfZo5AmTSEgPfDp9fRnQwM3jTSoKibyvPYy+qhMLlcWsGqes7UkdFktcj5zgxK5yb4RekN00yiJ5lY/aMXNClbT14Ukk/O6nTg9FtWVrwIwZiCe5ouxT+zN/TUzxIBDrPH3MisOcciCnupz/zyESTmK+p/Z3A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744915753; c=relaxed/simple;
	bh=Z9PSCSDOhSboXawTl/XaHB3xvDikfyVQPCnos/5YTFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LbhCPUNAmSrvT4PWNsL0Krqm8j1ec8+/0GytaqVjrazEEgR/5g+A6rduy3AGIDMIF/R/sBIWq19MrP4WYVdn2gGeicBcJ5tWzj+tSeGM97VFgouqKXVzHgZXShUquTMNfl+vAvNPkVxqCTwQ7F11iDvJMgHMeVavGONdKyLSr8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=XkYRjebd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mwjKAj5m; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="XkYRjebd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mwjKAj5m"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 74DE5114011C;
	Thu, 17 Apr 2025 14:49:09 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Thu, 17 Apr 2025 14:49:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1744915749; x=
	1745002149; bh=4lKdPBwhtL8GBmmzd2oORR2sO3eJQrQmsD2jhAJOypQ=; b=X
	kYRjebd558+bupJqqLP997QRJ1rlu3lP5H0AwQ9CIxcadLFqmuooxh8yVbx/couU
	8cIiuu8CWuuTeRfqOmV3JWk5gNayClr3zk3gTSBZCBHDEK7XkgfUZnhz7IpBySFG
	F18tDgtJWHuj2SnhpQXCRVx9Lvznl2VBC1s/G7rj5a+i6fQsywI2LJoLS6otnpee
	2064SeV5DeGzNonVXuhNTye3a1hCcmoQ5zPQZvW5OOv6fguXUiIvF5FqImgRFj63
	ngzaweSna8lF3fqT3NR1qBv0O+Fv66DxMShsqOhOBP/h+DVdN5xOALSfrlfW2TIc
	kFzZAo6bay0B5qBSwBnOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1744915749; x=1745002149; bh=4
	lKdPBwhtL8GBmmzd2oORR2sO3eJQrQmsD2jhAJOypQ=; b=mwjKAj5m9pw0yTymV
	a7z7wAgSgullHdV7fZBGuSYPrfu22TJT2ii6++yY0KC1D/nHuisRIJQNRh2VzOm1
	+tKv3/Nd/1mla47wf6v+elspQhARlcxDS05jfN9z8W3cjNO9K90WCmuAITGM4xvG
	M3l+F5RYg09KwOaeqibrGSZsFbcm8dXd4v9/avJRt6+eb1iDpju+YHjgLdZ3Ejbb
	PptKd7LwzoM+8aKKxjylnLG+b5NoAFytd8/q3ogGtUtYVowacGiJ7xj4KhsWlgJo
	a+Pc2ecf7lVEyskjUbYIRF1ul2s/nD/RmqkbLrKZWfAQBwQS88I61v8QaVyhHZXs
	D+Oew==
X-ME-Sender: <xms:JU0BaDzV0tVYVtKIaLj2XOKmQ6kRcNdDTJcQXzk0cn-zIB0Etdj9Pg>
    <xme:JU0BaLTOnlnf5T1UDG7qsi9oaBsG0sOUrWT4yr-RH3AvnohlfdBqVAsrNXafuaEdf
    lwdoQA2ClLHIeBaZRY>
X-ME-Received: <xmr:JU0BaNUSpHMlVI1sxXzjqNbw7tkYGudhKHzVE8hzpsIsoP0GImiLsf9FI0xiyyZLztJa2p-CMZJx-88uDRnRf03lh19HhDXnX8hPKN1DFjrZ7mWmSg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvfedttdefucetufdoteggodetrf
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
X-ME-Proxy: <xmx:JU0BaNjOBv3mmWYsJCqanR5WBZK2H10Fgk4tVbkkGGek4GY1TzPn_w>
    <xmx:JU0BaFDmHxUE5xhljkyiDjyKsiwOxYvH6ftctR7upeF0hbwhMTyMsA>
    <xmx:JU0BaGKMJ9pOUFRNViJmD_vHWitI0GxMChk6ENBcdQhz272DYW-Bsw>
    <xmx:JU0BaEBj7EP6WAhcHVMnc9eR-uT5pgfHYWguVpQz7y0OqnbrBNxEYw>
    <xmx:JU0BaKwORgQHbxWJSnmF1r3A6e56TbjyaMa1AtPOnkbK46hp_wcAx7PK>
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Apr 2025 14:49:09 -0400 (EDT)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 6522E11443DC;
	Thu, 17 Apr 2025 14:49:08 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Nicolas Pitre <npitre@baylibre.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 14/14] vt: move UCS tables to the "shipped" form
Date: Thu, 17 Apr 2025 14:45:16 -0400
Message-ID: <20250417184849.475581-15-nico@fluxnic.net>
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

Use the "shipped" mechanism to copy pre-generated tables to the build
tree by default. If GENERATE_UCS_TABLES=1 then they are generated at
build time instead. If GENERATE_UCS_TABLES=2 then
gen_ucs_recompose_table.py is invoked with --full.

Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
Suggested-by: Jiri Slaby <jirislaby@kernel.org>
---
 drivers/tty/vt/Makefile                       | 27 ++++++++++++++++++-
 drivers/tty/vt/gen_ucs_recompose_table.py     | 10 ++++---
 drivers/tty/vt/gen_ucs_width_table.py         | 18 +++++++++----
 ..._table.h => ucs_recompose_table.h_shipped} |  0
 ...idth_table.h => ucs_width_table.h_shipped} |  0
 5 files changed, 45 insertions(+), 10 deletions(-)
 rename drivers/tty/vt/{ucs_recompose_table.h => ucs_recompose_table.h_shipped} (100%)
 rename drivers/tty/vt/{ucs_width_table.h => ucs_width_table.h_shipped} (100%)

diff --git a/drivers/tty/vt/Makefile b/drivers/tty/vt/Makefile
index e24c8546ac..8ba33cc942 100644
--- a/drivers/tty/vt/Makefile
+++ b/drivers/tty/vt/Makefile
@@ -11,7 +11,8 @@ obj-$(CONFIG_CONSOLE_TRANSLATIONS)	+= consolemap.o consolemap_deftbl.o \
 					   ucs.o
 
 # Files generated that shall be removed upon make clean
-clean-files := consolemap_deftbl.c defkeymap.c
+clean-files :=	consolemap_deftbl.c defkeymap.c \
+		ucs_width_table.h ucs_recompose_table.h
 
 hostprogs += conmakehash
 
@@ -34,3 +35,27 @@ $(obj)/defkeymap.c: $(obj)/%.c: $(src)/%.map
 	loadkeys --mktable --unicode $< > $@
 
 endif
+
+$(obj)/ucs.o: $(src)/ucs.c $(obj)/ucs_width_table.h $(obj)/ucs_recompose_table.h
+
+# You may uncomment one of those to have the UCS tables be regenerated
+# during the build process. By default the _shipped versions are used.
+#
+#GENERATE_UCS_TABLES := 1
+#GENERATE_UCS_TABLES := 2  # invokes gen_ucs_recompose_table.py with --full
+
+ifdef GENERATE_UCS_TABLES
+
+$(obj)/ucs_width_table.h: $(src)/gen_ucs_width_table.py
+	$(PYTHON3) $< -o $@
+
+ifeq ($(GENERATE_UCS_TABLES),2)
+gen_recomp_arg := --full
+else
+gen_recomp_arg :=
+endif
+
+$(obj)/ucs_recompose_table.h: $(src)/gen_ucs_recompose_table.py
+	$(PYTHON3) $< -o $@ $(gen_recomp_arg)
+
+endif
diff --git a/drivers/tty/vt/gen_ucs_recompose_table.py b/drivers/tty/vt/gen_ucs_recompose_table.py
index d30f8f5242..4434a436ac 100755
--- a/drivers/tty/vt/gen_ucs_recompose_table.py
+++ b/drivers/tty/vt/gen_ucs_recompose_table.py
@@ -19,8 +19,8 @@ import textwrap
 from pathlib import Path
 this_file = Path(__file__).name
 
-# Output file name
-out_file = "ucs_recompose_table.h"
+# Default output file name
+DEFAULT_OUT_FILE = "ucs_recompose_table.h"
 
 common_recompose_description = "most commonly used Latin, Greek, and Cyrillic recomposition pairs only"
 COMMON_RECOMPOSITION_PAIRS = [
@@ -165,7 +165,7 @@ def validate_common_pairs(full_list):
             print(error_msg)
             raise ValueError(error_msg)
 
-def generate_recomposition_table(use_full_list=False):
+def generate_recomposition_table(use_full_list=False, out_file=DEFAULT_OUT_FILE):
     """Generate the recomposition C table."""
 
     # Collect all recomposition pairs for validation
@@ -250,6 +250,8 @@ if __name__ == "__main__":
     parser = argparse.ArgumentParser(description="Generate Unicode recomposition table")
     parser.add_argument("--full", action="store_true",
                         help="Generate a full recomposition table (default: common pairs only)")
+    parser.add_argument("-o", "--output", dest="output_file", default=DEFAULT_OUT_FILE,
+                        help=f"Output file name (default: {DEFAULT_OUT_FILE})")
     args = parser.parse_args()
 
-    generate_recomposition_table(use_full_list=args.full)
+    generate_recomposition_table(use_full_list=args.full, out_file=args.output_file)
diff --git a/drivers/tty/vt/gen_ucs_width_table.py b/drivers/tty/vt/gen_ucs_width_table.py
index 059ed9a8ba..76e80ebeff 100755
--- a/drivers/tty/vt/gen_ucs_width_table.py
+++ b/drivers/tty/vt/gen_ucs_width_table.py
@@ -5,13 +5,14 @@
 
 import unicodedata
 import sys
+import argparse
 
 # This script's file name
 from pathlib import Path
 this_file = Path(__file__).name
 
-# Output file name
-out_file = "ucs_width_table.h"
+# Default output file name
+DEFAULT_OUT_FILE = "ucs_width_table.h"
 
 # --- Global Constants for Width Assignments ---
 
@@ -185,13 +186,14 @@ def create_width_tables():
 
     return zero_width_ranges, double_width_ranges
 
-def write_tables(zero_width_ranges, double_width_ranges):
+def write_tables(zero_width_ranges, double_width_ranges, out_file=DEFAULT_OUT_FILE):
     """
     Write the generated tables to C header file.
 
     Args:
         zero_width_ranges: List of (start, end) ranges for zero-width characters
         double_width_ranges: List of (start, end) ranges for double-width characters
+        out_file: Output file name (default: DEFAULT_OUT_FILE)
     """
 
     # Function to split ranges into BMP (16-bit) and non-BMP (above 16-bit)
@@ -286,14 +288,20 @@ static const struct ucs_interval32 ucs_double_width_non_bmp_ranges[] = {
         f.write("};\n")
 
 if __name__ == "__main__":
+    # Parse command line arguments
+    parser = argparse.ArgumentParser(description="Generate Unicode width tables")
+    parser.add_argument("-o", "--output", dest="output_file", default=DEFAULT_OUT_FILE,
+                        help=f"Output file name (default: {DEFAULT_OUT_FILE})")
+    args = parser.parse_args()
+
     # Write tables to header file
     zero_width_ranges, double_width_ranges = create_width_tables()
-    write_tables(zero_width_ranges, double_width_ranges)
+    write_tables(zero_width_ranges, double_width_ranges, out_file=args.output_file)
 
     # Print summary
     zero_width_count = sum(end - start + 1 for start, end in zero_width_ranges)
     double_width_count = sum(end - start + 1 for start, end in double_width_ranges)
-    print(f"Generated {out_file} with:")
+    print(f"Generated {args.output_file} with:")
     print(f"- {len(zero_width_ranges)} zero-width ranges covering ~{zero_width_count} code points")
     print(f"- {len(double_width_ranges)} double-width ranges covering ~{double_width_count} code points")
     print(f"- Unicode Version: {unicodedata.unidata_version}")
diff --git a/drivers/tty/vt/ucs_recompose_table.h b/drivers/tty/vt/ucs_recompose_table.h_shipped
similarity index 100%
rename from drivers/tty/vt/ucs_recompose_table.h
rename to drivers/tty/vt/ucs_recompose_table.h_shipped
diff --git a/drivers/tty/vt/ucs_width_table.h b/drivers/tty/vt/ucs_width_table.h_shipped
similarity index 100%
rename from drivers/tty/vt/ucs_width_table.h
rename to drivers/tty/vt/ucs_width_table.h_shipped
-- 
2.49.0

