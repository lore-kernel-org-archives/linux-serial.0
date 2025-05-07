Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1DDA28A70A;
	Wed,  7 May 2025 14:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746627345; cv=none; b=Icj8v48r5R6s5TJNScBTjCcAyLtP5NIEpC6rqvTgknrJNz6bbJtuy8rTxknE4CkvZqfDjxBsfXsRXOrS+d+WjkovYrcEFLDr1cB3XvZ1K9QE2Ng79OqdWrvg7unVETz3gGjF39y7kEbOCSDGJwW1r8C49hWtmC6SiV1t1h5RlAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746627345; c=relaxed/simple;
	bh=dnVTYsHx3gvdP588TllXc+CcR+HFs+VFDKgLH53X6GA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S6NhEtv/SSrbDgmJAlodHvm4GLRGPq1In09/+WqVhK+zg5WKyjHalZuez12sXnlrxxQW/Ey0JRcXBiTD+uajzO++QcNfJz7PRBpBwVg1fOi/D4Ux0G52m6YHQQG+iRMyy7fUOa9mBfILGxHHKuUJQ8BMFnm3a9/NZQDJQWwKBZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=eHqsESZJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gJ3eo3Id; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="eHqsESZJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gJ3eo3Id"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D10F1114016A;
	Wed,  7 May 2025 10:15:42 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Wed, 07 May 2025 10:15:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1746627342;
	 x=1746713742; bh=fxS+ZxlBjlM53GaIeR1whKGUmAcFB3bmi3SClHXNvq0=; b=
	eHqsESZJnWRyDUrfgMftKpBv3eYqcSnJIlaPa28TETQ7flDls72MA8KPtue1IN/e
	0x1EX4aywmyZIVsHRAuOoDgQLeVzlEkDs5gy0Ds7xXN5AFMa5vDIlYZMJOFInbYI
	ANOMm8WCsUbfZahvV3yz6sW3wMiEwAMhAqPth9sz3GsaiOor2rfyBhsw+DlQkkCI
	Xg9B5ppyN5x7w/LUM+axrcqXkQ14ECy/Hw5Rjiyi4K6gga4qj+EmNorKAHSF18z8
	8khVHb52kRB1a0yC3i3QN1YgrySZwhAdr9xX/upqZKol1qfXd3QanyCo7oJ6dDB5
	0KCauRpGsHT/02yX2+vswQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746627342; x=
	1746713742; bh=fxS+ZxlBjlM53GaIeR1whKGUmAcFB3bmi3SClHXNvq0=; b=g
	J3eo3IdU/e3BT+gzVpfDBNkR6QqaN3f75TN+/8y6ArtF2nJ4cti8rBnYghTxBjax
	9/+15mbs5EImEFA4JKR3QnVahxKztvaYMP3sd14pbkELMHHkXTIArFZZgLg7Q4bu
	aDJ/MLyUxtLbSdDnjD8GYWZv8xlzYhyUI8sZQAhFwet0Wp52GbrFt/P2mwwo9iL1
	A6UDlcfgJ9qQFrrN8c3yaqsMByQpS11SKWskjFBCMdKlZApm/877AEnRpH7hJR05
	lc5WPc4+3DSdQMwV4THUQngRkO3tnM2u3XcTlha4khmKiPkU/oXzShBXRe81BBH/
	IapJs5NnKTL1kmsKT6u8A==
X-ME-Sender: <xms:DmsbaGxznBK3UuCgnRmOEfAMZYI8_KXTOQHfOm6krvTf5x6Jqf012Q>
    <xme:DmsbaCRJ1tMVhi-wPS9hRdibihBZAauEU3Jt_2VxdRPWvOfbQjfYx36ToC7W-XeCE
    mJ_VpuPnhs_sWz_tkk>
X-ME-Received: <xmr:DmsbaIXUg1Ssreu1m7MblUfa18DUlnafvr3aPGPBrYX1pJoBqNMT5zf6d_JI0SoO9mP7LBrOncSSZLV8EQpek1jJqxCcR2ftfqi7pOyxCSbT-gu-Og>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeejtdejucetufdoteggodetrf
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
X-ME-Proxy: <xmx:DmsbaMhmkPItxhXIYLdd8BRL3ts1aRh03pIi-0HyrH8TtpyBYBFHYg>
    <xmx:DmsbaIA3d3AvGOUrk8FIaMK1QKYTcEJKOn8XrO-YbzqOjEiF3SryqA>
    <xmx:DmsbaNI9hqlCmtsOP39LKMS0sDXRy54ouBIImNxA-s2tO_ZfFhF3FA>
    <xmx:DmsbaPCP6FVDbMO82dx39Nmoj_N-ozbeMGW2a3baOsN91ZqO5ziD-g>
    <xmx:DmsbaBwoqSfNdL1Ztu5tWDn5wKH1vy9Xuwgagyzvklig_IHhg2ViQCOt>
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 May 2025 10:15:42 -0400 (EDT)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id EBC401189EA4;
	Wed, 07 May 2025 10:15:41 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Nicolas Pitre <npitre@baylibre.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/8] vt: introduce gen_ucs_fallback_table.py to create ucs_fallback_table.h
Date: Wed,  7 May 2025 10:13:19 -0400
Message-ID: <20250507141535.40655-5-nico@fluxnic.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250507141535.40655-1-nico@fluxnic.net>
References: <20250507141535.40655-1-nico@fluxnic.net>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Nicolas Pitre <npitre@baylibre.com>

The generated table maps complex characters to their simpler fallback
forms for a terminal display when corresponding glyphs are unavailable.
This includes diacritics, symbols as well as many drawing characters.
Fallback characters aren't perfect replacements, obviously. But they are
still far more useful than a bunch of squared question marks.

Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
---
 drivers/tty/vt/gen_ucs_fallback_table.py | 352 +++++++++++++++++++++++
 1 file changed, 352 insertions(+)
 create mode 100755 drivers/tty/vt/gen_ucs_fallback_table.py

diff --git a/drivers/tty/vt/gen_ucs_fallback_table.py b/drivers/tty/vt/gen_ucs_fallback_table.py
new file mode 100755
index 000000000000..80257c6df440
--- /dev/null
+++ b/drivers/tty/vt/gen_ucs_fallback_table.py
@@ -0,0 +1,352 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+#
+# Leverage Python's unidecode module to generate ucs_fallback_table.h
+#
+# The generated table maps complex characters to their simpler fallback forms
+# for a terminal display when corresponding glyphs are unavailable.
+#
+# Usage:
+#   python3 gen_ucs_fallback_table.py         # Generate fallback tables
+#   python3 gen_ucs_fallback_table.py -o FILE # Specify output file
+
+import unicodedata
+from unidecode import unidecode
+import sys
+import argparse
+from collections import defaultdict
+
+# Try to get unidecode version
+try:
+    from importlib.metadata import version
+    unidecode_version = version('unidecode')
+except:
+    unidecode_version = 'unknown'
+
+# This script's file name
+from pathlib import Path
+this_file = Path(__file__).name
+
+# Default output file name
+DEFAULT_OUT_FILE = "ucs_fallback_table.h"
+
+# Define the range marker value
+RANGE_MARKER = 0x00
+
+def generate_fallback_map():
+    """Generate a fallback map using unidecode for all relevant Unicode points."""
+    fallback_map = {}
+
+    # Process BMP characters (0x0000 - 0xFFFF) to keep table size manageable
+    for cp in range(0x0080, 0x10000):  # Skip ASCII range (0x00-0x7F)
+        char = chr(cp)
+
+        # Skip unassigned/control characters
+        try:
+            if not unicodedata.name(char, ''):
+                continue
+        except ValueError:
+            continue
+
+        # Get the unidecode transliteration
+        ascii_version = unidecode(char)
+
+        # Only store if it results in a single character mapping
+        if len(ascii_version) == 1:
+            fallback_map[cp] = ord(ascii_version)
+
+    # Apply manual overrides for special cases
+    fallback_map.update(get_special_overrides())
+
+    return fallback_map
+
+def get_special_overrides():
+    """Get special case overrides that need different handling than unidecode
+    provides... or doesn't provide at all."""
+
+    overrides = {}
+
+    # Multi-character unidecode output
+    # These map to single chars instead of unidecode's multiple-char mappings
+    # In a terminal fallback context, we need a single character rather than multiple
+    overrides[0x00C6] = ord('E')  # Æ LATIN CAPITAL LETTER AE -> E (unidecode: "AE")
+    overrides[0x00E6] = ord('e')  # æ LATIN SMALL LETTER AE -> e (unidecode: "ae")
+    overrides[0x0152] = ord('E')  # Œ LATIN CAPITAL LIGATURE OE -> E (unidecode: "OE")
+    overrides[0x0153] = ord('e')  # œ LATIN SMALL LETTER LIGATURE OE -> e (unidecode: "oe")
+    overrides[0x00DF] = ord('s')  # ß LATIN SMALL LETTER SHARP S -> s (unidecode: "ss")
+
+    # Comparison operators that unidecode renders as multiple characters
+    overrides[0x2264] = ord('<')  # ≤ LESS-THAN OR EQUAL TO -> < (unidecode: "<=")
+    overrides[0x2265] = ord('>')  # ≥ GREATER-THAN OR EQUAL TO -> > (unidecode: ">=")
+
+    # Unidecode returns an empty string for these
+    overrides[0x2260] = ord('#')  # ≠ NOT EQUAL TO -> # (unidecode: empty string)
+
+    # Quadrant block characters that unidecode doesn't map
+    for cp in range(0x2596, 0x259F+1):
+        overrides[cp] = ord('#')  # ▖ ▗ ▘ ▙ etc. - map to # (unidecode: empty string)
+
+    # Directional arrows
+    # These provide better semantic meaning than unidecode's mappings
+    overrides[0x2192] = ord('>')  # → RIGHTWARDS ARROW -> > (unidecode: "-")
+    overrides[0x2190] = ord('<')  # ← LEFTWARDS ARROW -> < (unidecode: "-")
+    overrides[0x2191] = ord('^')  # ↑ UPWARDS ARROW -> ^ (unidecode: "|")
+    overrides[0x2193] = ord('v')  # ↓ DOWNWARDS ARROW -> v (unidecode: "|")
+
+    # Double arrows with their directional semantic mappings
+    overrides[0x21D0] = ord('<')  # ⇐ LEFTWARDS DOUBLE ARROW -> <
+    overrides[0x21D1] = ord('^')  # ⇑ UPWARDS DOUBLE ARROW -> ^
+    overrides[0x21D2] = ord('>')  # ⇒ RIGHTWARDS DOUBLE ARROW -> >
+    overrides[0x21D3] = ord('v')  # ⇓ DOWNWARDS DOUBLE ARROW -> v
+
+    # Halfwidth arrows
+    # These need the same treatment as their normal-width counterparts
+    overrides[0xFFE9] = ord('<')  # ￩ HALFWIDTH LEFTWARDS ARROW -> < (unidecode: "-")
+    overrides[0xFFEA] = ord('^')  # ￪ HALFWIDTH UPWARDS ARROW -> ^ (unidecode: "|")
+    overrides[0xFFEB] = ord('>')  # ￫ HALFWIDTH RIGHTWARDS ARROW -> > (unidecode: "-")
+    overrides[0xFFEC] = ord('v')  # ￬ HALFWIDTH DOWNWARDS ARROW -> v (unidecode: "|")
+
+    # Currency symbols - each mapped to a representative letter
+    overrides[0x00A2] = ord('c')  # ¢ CENT SIGN -> c
+    overrides[0x00A3] = ord('L')  # £ POUND SIGN -> L
+    overrides[0x00A5] = ord('Y')  # ¥ YEN SIGN -> Y
+    overrides[0x20AC] = ord('E')  # € EURO SIGN -> E
+
+    # Symbols mapped to letters
+    overrides[0x00A7] = ord('S')  # § SECTION SIGN -> S
+    overrides[0x00A9] = ord('C')  # © COPYRIGHT SIGN -> C
+    overrides[0x00AE] = ord('R')  # ® REGISTERED SIGN -> R
+    overrides[0x2122] = ord('T')  # ™ TRADE MARK SIGN -> T
+
+    # Degree-related symbols
+    overrides[0x00B0] = ord('o')  # ° DEGREE SIGN -> o
+    overrides[0x2103] = ord('C')  # ℃ DEGREE CELSIUS -> C
+    overrides[0x2109] = ord('F')  # ℉ DEGREE FAHRENHEIT -> F
+
+    # Angle quotation marks
+    overrides[0x00AB] = ord('<')  # « LEFT-POINTING DOUBLE ANGLE QUOTATION MARK -> <
+    overrides[0x00BB] = ord('>')  # » RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK -> >
+
+    # Operators with circular shape
+    overrides[0x2218] = ord('o')  # ∘ RING OPERATOR -> o
+    overrides[0x2219] = ord('.')  # ∙ BULLET OPERATOR -> .
+
+    # Negated mathematical symbols (preserving the negation semantics)
+    # Negated symbols mapped to exclamation mark (semantically "not")
+    for cp in (0x2204, 0x2209, 0x220C, 0x2224, 0x2226, 0x226E, 0x226F, 0x2280, 0x2281, 0x2284, 0x2285):
+        overrides[cp] = ord('!')  # Negated math symbols -> ! (not)
+
+    # Negated symbols mapped to hash sign (semantically "not equal")
+    for cp in (0x2241, 0x2244, 0x2249, 0x2262, 0x2268, 0x2269, 0x226D, 0x228A, 0x228B):
+        overrides[cp] = ord('#')  # Negated equality symbols -> # (not equal)
+
+    # Negated arrows - all mapped to exclamation mark
+    for cp in (0x219A, 0x219B, 0x21AE, 0x21CD, 0x21CE, 0x21CF):
+        overrides[cp] = ord('!')  # Negated arrows -> ! (not)
+
+    # Dashes and hyphens
+    for cp in (0x2010, 0x2011, 0x2012, 0x2013, 0x2014, 0x2015, 0x2043, 0x2052):
+        overrides[cp] = ord('-')  # Dashes and hyphens -> -
+
+    # Question mark punctuation
+    for cp in (0x203D, 0x2047, 0x2048):
+        overrides[cp] = ord('?')  # Question marks -> ?
+
+    # Exclamation mark punctuation
+    for cp in (0x203C, 0x2049):
+        overrides[cp] = ord('!')  # Exclamation marks -> !
+
+    # Asterisk-like symbols
+    for cp in (0x2042, 0x2051, 0x2055):
+        overrides[cp] = ord('*')
+
+    # Other specific punctuation with unique mappings
+    overrides[0x201E] = ord('"')  # „ DOUBLE LOW-9 QUOTATION MARK
+    overrides[0x2023] = ord('>')  # ‣ TRIANGULAR BULLET
+    overrides[0x2026] = ord('.')  # … HORIZONTAL ELLIPSIS
+    overrides[0x2033] = ord('"')  # ″ DOUBLE PRIME
+    overrides[0x204B] = ord('P')  # ⁋ REVERSED PILCROW SIGN
+    overrides[0x204C] = ord('<')  # ⁌ BLACK LEFTWARDS BULLET
+    overrides[0x204D] = ord('>')  # ⁍ BLACK RIGHTWARDS BULLET
+    overrides[0x204F] = ord(';')  # ⁏ REVERSED SEMICOLON
+    overrides[0x205B] = ord(':')  # ⁛ FOUR DOT MARK
+
+    # Check marks
+    overrides[0x2713] = ord('v')  # ✓ CHECK MARK
+    overrides[0x2714] = ord('V')  # ✔ HEAVY CHECK MARK
+
+    # X marks - lowercase for regular, uppercase for heavy
+    for cp in (0x2715, 0x2717):
+        overrides[cp] = ord('x')  # Regular X marks -> x
+    for cp in (0x2716, 0x2718):
+        overrides[cp] = ord('X')  # Heavy X marks -> X
+
+    # Stars and asterisk-like symbols mapped to '*'
+    for cp in (0x2605, 0x2606, 0x262A, 0x269D, 0x2698):
+        overrides[cp] = ord('*')  # All star and asterisk symbols -> *
+    for cp in range(0x2721, 0x2746+1):
+        overrides[cp] = ord('*')  # All star and asterisk symbols -> *
+    for cp in range(0x2749, 0x274B+1):
+        overrides[cp] = ord('*')  # Last set of asterisk symbols -> *
+    for cp in (0x229B, 0x22C6, 0x235F, 0x2363):
+        overrides[cp] = ord('*')  # Star operators -> *
+
+    # Special exclusions with fallback value of 0
+    # These will be filtered out in organize_by_pages()
+
+    # Exclude U+2028 (LINE SEPARATOR)
+    overrides[0x2028] = 0  # LINE SEPARATOR (unidecode: '\n')
+
+    return overrides
+
+def organize_by_pages(fallback_map):
+    """Organize the fallback mappings by their high byte (page)."""
+    # Group by high byte (page)
+    page_groups = defaultdict(list)
+    for code, fallback in fallback_map.items():
+        # Skip characters with fallback value of 0 (excluded characters)
+        if fallback == 0:
+            continue
+
+        page = code >> 8  # Get the high byte (page)
+        offset = code & 0xFF  # Get the low byte (offset within page)
+        page_groups[page].append((offset, fallback))
+
+    # Sort each page's entries by offset
+    for page in page_groups:
+        page_groups[page].sort()
+
+    return page_groups
+
+def compress_ranges(page_groups):
+    """Compress consecutive entries with the same fallback character into ranges.
+    A range is only compressed if it contains 3 or more consecutive entries."""
+
+    compressed_pages = {}
+
+    for page, entries in page_groups.items():
+        compressed_entries = []
+        i = 0
+        while i < len(entries):
+            start_offset, fallback = entries[i]
+
+            # Look ahead to find consecutive entries with the same fallback
+            j = i + 1
+            while (j < len(entries) and
+                   entries[j][0] == entries[j-1][0] + 1 and  # consecutive offsets
+                   entries[j][1] == fallback):               # same fallback
+                j += 1
+
+            # Calculate the range end
+            end_offset = entries[j-1][0]
+
+            # If we found a range with 3 or more entries (worth compressing)
+            if j - i >= 3:
+                # Add a range entry
+                compressed_entries.append((start_offset, RANGE_MARKER))
+                compressed_entries.append((end_offset, fallback))
+            else:
+                # Add the individual entries as is
+                for k in range(i, j):
+                    compressed_entries.append(entries[k])
+
+            i = j
+
+        compressed_pages[page] = compressed_entries
+
+    return compressed_pages
+
+def cp_name(cp):
+    """Get the Unicode character name for a code point."""
+    try:
+        return unicodedata.name(chr(cp))
+    except:
+        return f"U+{cp:04X}"
+
+def generate_fallback_tables(out_file=DEFAULT_OUT_FILE):
+    """Generate the fallback character tables."""
+    # Generate fallback map using unidecode
+    fallback_map = generate_fallback_map()
+    print(f"Generated {len(fallback_map)} total fallback mappings")
+
+    # Organize by pages
+    page_groups = organize_by_pages(fallback_map)
+    print(f"Organized into {len(page_groups)} pages")
+
+    # Compress ranges
+    compressed_pages = compress_ranges(page_groups)
+    total_compressed_entries = sum(len(entries) for entries in compressed_pages.values())
+    print(f"Total compressed entries: {total_compressed_entries}")
+
+    # Create output file
+    with open(out_file, 'w') as f:
+        f.write(f"""\
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * {out_file} - Unicode character fallback table
+ *
+ * Auto-generated by {this_file}
+ *
+ * Unicode Version: {unicodedata.unidata_version}
+ * Unidecode Version: {unidecode_version}
+ *
+ * This file contains optimized tables that map complex Unicode characters
+ * to simpler fallback characters for terminal display when corresponding
+ * glyphs are unavailable.
+ */
+
+static const struct ucs_page_desc ucs_fallback_pages[] = {{
+""")
+
+        # Convert compressed_pages to a sorted list of (page, entries) tuples
+        sorted_pages = sorted(compressed_pages.items())
+
+        # Track the start index for each page
+        start_index = 0
+
+        # Write page descriptors
+        for page, entries in sorted_pages:
+            count = len(entries)
+            f.write(f"\t{{ 0x{page:02X}, {count}, {start_index} }},\n")
+            start_index += count
+
+        # Write entries array
+        f.write("""\
+};
+
+/* Page entries array (referenced by page descriptors) */
+static const struct ucs_page_entry ucs_fallback_entries[] = {
+""")
+
+        # Write all entries
+        for page, entries in sorted_pages:
+            page_hex = f"0x{page:02X}"
+            f.write(f"\t/* Entries for page {page_hex} */\n")
+
+            for i, (offset, fallback) in enumerate(entries):
+                # Convert to hex for better readability
+                offset_hex = f"0x{offset:02X}"
+                fallback_hex = f"0x{fallback:02X}"
+
+                # Handle comments
+                codepoint = (page << 8) | offset
+
+                if fallback == RANGE_MARKER:
+                    comment = f"{cp_name(codepoint)} -> ..."
+                else:
+                    comment = f"{cp_name(codepoint)} -> '{chr(fallback)}'"
+                f.write(f"\t{{ 0x{offset:02X}, 0x{fallback:02X} }}, /* {comment} */\n")
+
+        f.write(f"""\
+}};
+
+#define UCS_PAGE_ENTRY_RANGE_MARKER {RANGE_MARKER}
+""")
+
+if __name__ == "__main__":
+    parser = argparse.ArgumentParser(description="Generate Unicode fallback character tables")
+    parser.add_argument("-o", "--output", dest="output_file", default=DEFAULT_OUT_FILE,
+                       help=f"Output file name (default: {DEFAULT_OUT_FILE})")
+    args = parser.parse_args()
+
+    generate_fallback_tables(out_file=args.output_file)
-- 
2.49.0

