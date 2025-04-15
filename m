Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A052475E3;
	Tue, 15 Apr 2025 19:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744744945; cv=none; b=pMPumU8gXrkN0BBNyYO3Kz/4O0AaOSfMRbSDrexPgqQXXh0ycCkNv9+a+Ijxsw8X/jSJ2bQU+Fj/jfUNoGuFhEilhJFCxFuxZ0PbbljQ8nRUUDmel1j/Q5Ox7WXaNWZIUEPwLCqrGEqUaYB8BcAODzlMgPR515VcRU+So5noppQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744744945; c=relaxed/simple;
	bh=5LqN3hI7ixJh6B2H56mzahrf8EEt2sBfK62S9N94zCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mMp+ZRxA9NZZVjtlWAqWFUlR6Hm0B7bmJ0SICPdILrcCTtgycJX7nPzHnEd0UC2ABh/1H0pm5WFjDvVaXtMj4amNYHKN3Jwdogyn+e5dhXqmm4alwvj1KBiv1rpi5sf8jgfnJ4VYRwER05OdPlDleT4uth4a/VKuUUeN9scz/8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=iGCv2Usi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nM4a1zla; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="iGCv2Usi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nM4a1zla"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C379411400AD;
	Tue, 15 Apr 2025 15:22:19 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Tue, 15 Apr 2025 15:22:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1744744939;
	 x=1744831339; bh=Yb5tKtRtrOZEqKIWpRUqh9mXuGAmxCdbqrB1U8/DmPU=; b=
	iGCv2UsicAkN+3sxggLcrhnCRM5PNXs5FHFuGLcHCbCcLU8P7prCK0/OzYeDa5rX
	dCCR9wuEDr6tciPflSEqD21lPxh8nUP+ETi/zQyblh+cdsV0Pbap6gjPT8bEkUHK
	KyuYmCY54suRIuBlX3SaY0IKvz6BOOPllKWlYgYZMzadkJauADYSSPBAL0/1T+Lm
	R/ZakiAJHJZSUo+Z42XDFuxsJGUlhyCa+nBfhO/6LI3Kno4zrEHhLXdSM7xHSX7q
	Nimh5fQSovGyMtef1NlV2qC7YGr2mo5jpkyBDQdiIbsaOHmQ7O64uFcZuD43OIZC
	uGSf6H5y4Q3ixvZpQVSFSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744744939; x=
	1744831339; bh=Yb5tKtRtrOZEqKIWpRUqh9mXuGAmxCdbqrB1U8/DmPU=; b=n
	M4a1zlaqgHNwN4+Rc4Q8Gy14B8kIyODjZ80gaGBSpMVYG5U6Td5cmYtAVPGgp7i/
	szqk6DO3H4gBgj+MQDB1Tlr1Apv11T4PaYvmE3SmG/W36yiLazFFy9V0IToEeNjD
	23V5JE2uIAgEPVXKFyrncomEHoYMJJOpU3Av9MuYn6019jJjA6RKIEk2YkXc0IVz
	dGAk5AA9Lun5Jx1tQ7UsizIKixocjPwEFwODcZw/JKqyGCl1cNVdi97meXNuHaFx
	AKEurfmuqzeTJmf/Gi/GOJOvaYMHHbMpcOLwafnV+93wYxe2CP8oUGKsevUx6aH3
	AtefV2byajxMCRaQAdl2w==
X-ME-Sender: <xms:67H-ZyVSx-VT3prvClDZ50VbiTky8tGXz0wtC0wbD8W0K29SWIySQg>
    <xme:67H-Z-lTvQEVYdffzsfk0dgwPKRL3AOcNKucFW4Xgb7th1CH7ghdqhdonsMLImT0j
    hZmKhTwJXiKmqvmJSA>
X-ME-Received: <xmr:67H-Z2ZoLDesrLpNJ8P7wxIomOCQTTWqO0ejdlK2xDXkS_Bc93UE0uSXeboXUA7VXWJwHriQn7ffROK-vPgYbPyaihjAl_CV55twqCpP-r5FrFMqhg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdegfedvucetufdoteggodetrf
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
X-ME-Proxy: <xmx:67H-Z5WDn1pKrQQ17QxYCcyca4J0axG5yyeKID8k_vw1To-OUeI34g>
    <xmx:67H-Z8mowqV99ikkL1UiSX_UB3YkK-o9KvAttTv4f3f3xQZFuQlb6g>
    <xmx:67H-Z-cPud-BOHhi_u9KMJBrbmNd0EwcBDsZjPxVOjJHrc9rcLoCdQ>
    <xmx:67H-Z-HgpvPs-Kk9o-4pAMIyn2JtRUdMMYVeDibbAxwzg2T5LPzszA>
    <xmx:67H-Z7HFMt-me8D4dA_lPO4tEl4J2XTpwYw4aLr1_L0yhAp9Uw1LvyFq>
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Apr 2025 15:22:19 -0400 (EDT)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id B3BFA1116610;
	Tue, 15 Apr 2025 15:22:18 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Nicolas Pitre <npitre@baylibre.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 07/13] vt: introduce gen_ucs_recompose_table.py to create ucs_recompose_table.h
Date: Tue, 15 Apr 2025 15:17:56 -0400
Message-ID: <20250415192212.33949-8-nico@fluxnic.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250415192212.33949-1-nico@fluxnic.net>
References: <20250415192212.33949-1-nico@fluxnic.net>
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
---
 drivers/tty/vt/gen_ucs_recompose_table.py | 255 ++++++++++++++++++++++
 1 file changed, 255 insertions(+)
 create mode 100755 drivers/tty/vt/gen_ucs_recompose_table.py

diff --git a/drivers/tty/vt/gen_ucs_recompose_table.py b/drivers/tty/vt/gen_ucs_recompose_table.py
new file mode 100755
index 0000000000..91e81fb1c9
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
+#   python gen_ucs_recompose_table.py         # Generate with common recomposition pairs
+#   python gen_ucs_recompose_table.py --full  # Generate with all recomposition pairs
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
+ *   python {this_file}{alternative_mode}
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

