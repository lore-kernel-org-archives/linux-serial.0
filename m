Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7B92459C4;
	Tue, 15 Apr 2025 19:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744744942; cv=none; b=fr9OpY1PAeZDLkQ4mtAAyBJ9t9gfY6bamzlx8ez6qBr/J+KTnlvTIbTn3e35yb6l7FDtA7yGFJV6NLF059OROat27wcPhbbVtiRPouIIik4rh+avCbh1QUOZAo8CFlCYRsAKHLrRoMYp+V/qweNN+s4HkyCJA6L5oPaRhW/nses=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744744942; c=relaxed/simple;
	bh=z3OF0ozjujGh9DyQxCFTiBpRq4pogUfdjrLbd5r7z6I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J89Kdhrhsrma11zKLjN+42nWAMg9CXVed5qW/D5mA+lyTOlYTBl1NF6S2aClB2/274cp22UKzNuIUpx3lnRqMij7X54QAVirqFLQ8DirtVgZhzm774kjTJiddnDzPNHCEiRPJTtI16ruCjZAGhOx20MA8HBiRAb1pc1TOLW7uvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=rMfPOjBD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WFG/zywo; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="rMfPOjBD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WFG/zywo"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EA34C1140187;
	Tue, 15 Apr 2025 15:22:18 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Tue, 15 Apr 2025 15:22:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1744744938; x=1744831338; bh=NYcd+fO1NxEUNFY7q3ZE4
	+NHZMdYBl2HpORWjobKRto=; b=rMfPOjBDrOWQ8KQJlr0Fp/gX9AqQn+4lH/XQI
	5WW7sFZxFM3oMdkGgg+TwCGGsXGvotMloQe8m6dgF10THLovbQdIgpR+UAYbdt8X
	jlvOuXK22nXk4S0BnUMLEsHPyhQs6pjA5hb/D4t3E5YAsDtdTyZxUjlqkR+uU5+K
	8zfKKBrl3KpjPHSsK3+WdK7w5Y0SYaVHOiH2/XJiAbKnuKJt1AFgm4dY6Bd/fJz2
	o+w0kaCE6R0NOS+Phce9aIhjpu5r84SKZS1rzTm+3gtAxQG7tpajy4qf+SeUVxOQ
	zsRpm/dwUVE8fBtbMaaXgcvytJqBgQARz8VJ0JOoJLkxgeyqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744744938; x=1744831338; bh=NYcd+fO1NxEUNFY7q3ZE4+NHZMdYBl2HpOR
	WjobKRto=; b=WFG/zywonm7wgb5I+Klv5hto0YWRlD/RukDk1oKYYFLO2vG+Pkx
	qblu8c7BerraE2KCWLb9olyfsYqgeywaV4wYF5mSgEGfefABG3F8NLwbpkND7l1p
	UFQc3YtfTB2Z59P3WXhBeopRxgz6XyQ7URKYRHF9VmdJ7ICfT2GdcPGJ9PYvpcb+
	eywrXejYy8UKzdreE+1C5vJ6bDgZH5EfL2NKJ2CawResDDNgaO5xHE4QoO+zYL/n
	ChtrA7nyDYn+dL637tZzFXaa9FBXVCIhaGCHbbEtWQyYlAHwQiyaVxLTjvIs2U6U
	fMVY1F87O2TidE3r23ULG6IqXuyhe7gwY6g==
X-ME-Sender: <xms:6rH-Z1ustK_Buu-TIkduOuKWx8qo3taYvVJ3Xasfp-V9WncBONXHEw>
    <xme:6rH-Z-dAoTg1qPsNgK8lg1toD93-qmr1BrjPOFx-Jgqajxz5paAPFUgAsloGP5lCP
    xJlHGjkXxpqKHeSTYY>
X-ME-Received: <xmr:6rH-Z4yETBueM5v44ojk649GaNNqxRu0PKw0CQ8qie3vUZaP8zIK1Ekj2_605m9-nw4gBcsoAo5PPaRhnfW-i8UsApjKb5qKjwykcrPnK-iUYfb-6A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdegfeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgggfestdekredtredttden
    ucfhrhhomheppfhitgholhgrshcurfhithhrvgcuoehnihgtohesfhhluhignhhitgdrnh
    gvtheqnecuggftrfgrthhtvghrnhephfevledutdfgvdeutdeugeevgfdtkeefteevvefh
    keeuiedtkeegteehleevleejnecuffhomhgrihhnpehlkhhmlhdrohhrghenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnihgtohesfhhluhig
    nhhitgdrnhgvthdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtohepnhhpihhtrhgvsegsrgihlhhisghrvgdrtghomhdprhgtphhtthhopehjihhr
    ihhslhgrsgihsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehgrhgvghhkhheslhhinh
    hugihfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgv
    lhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhsvghrih
    grlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:6rH-Z8OjnTzSKn-LsxnDscXXcVDXdjJJbDtuhnp32krz6yzofYlCIg>
    <xmx:6rH-Z1-wR75dwrztUE7bAx4syrV-Yo333eE6_Pb8de18-OCXo1-KPQ>
    <xmx:6rH-Z8UOducG8p6cH0EAT39HUYSi2aVz7vXoAmkKoa209LuWYu_PxA>
    <xmx:6rH-Z2fZwoRD1iq-Yif4UMgaemcZHCCTGslR3Sp0E5rcxG0EqHus_A>
    <xmx:6rH-Z4-ZSujY-mcHJqYU7Ou5rS4mZdRn-z8hSlGqjnD2lfeAKHbTm2ya>
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Apr 2025 15:22:18 -0400 (EDT)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id BEF281116606;
	Tue, 15 Apr 2025 15:22:17 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Nicolas Pitre <npitre@baylibre.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 00/13] vt: implement proper Unicode handling
Date: Tue, 15 Apr 2025 15:17:49 -0400
Message-ID: <20250415192212.33949-1-nico@fluxnic.net>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Linux VT console has many problems with regards to proper Unicode
handling:

- All new double-width Unicode code points which have been introduced since
  Unicode 5.0 are not recognized as such (we're at Unicode 16.0 now).

- Zero-width code points are not recognized at all. If you try to edit files
  containing a lot of emojis, you will see the rendering issues. When there
  are a lot of zero-width characters (like "variation selectors"), long
  lines get wrapped, but any Unicode-aware editor thinks that the content
  was rendered properly and its rendering logic starts to work in very bad
  ways. Combine this with tmux or screen, and there is a huge mess going on
  in the terminal.

- Also, text which uses combining diacritics has the same effect as text
  with zero-width characters as programs expect the characters to take fewer
  columns than what they actually do.

Some may argue that the Linux VT console is unmaintained and/or not used
much any longer and that one should consider a user space terminal
alternative instead. But every such alternative that is not less maintained
than the Linux VT console does require a full heavy graphical environment
and that is the exact antithesis of what the Linux console is meant to be.

Furthermore, there is a significant Linux console user base represented by
blind users (which I'm a member of) for whom the alternatives are way more
cumbersome to use reducing our productivity. So it has to stay and
be maintained to the best of our abilities.

That being said...

This patch series is about fixing all the above issues. This is accomplished
with some Python scripts leveraging Python's unicodedata module to generate
C code with lookup tables that is suitable for the kernel. In summary:

- The double-width code point table is updated to the latest Unicode version
  and the table itself is optimized to reduce its size.

- A zero-width code point table is created and the console code is modified
  to properly use it.

- A table with base character + combining mark pairs is created to convert
  them into their precomposed equivalents when they're encountered.
  By default the generated table contains most commonly used Latin, Greek,
  and Cyrillic recomposition pairs only, but one can execute the provided
  script with the --full argument to create a table that covers all
  possibilities. Combining marks that are not listed in the table are simply
  treated like zero-width code points and properly ignored.

- All those tables plus related lookup code require about 3500 additional
  bytes of text which is not very significant these days. Yet, one
  can still set CONFIG_CONSOLE_TRANSLATIONS=n to configure this all out
  if need be.

Note: The generated C code makes scripts/checkpatch.pl complain about
      "... exceeds 100 columns" because the inserted comments with code
      point names, well, make some inlines exceed 100 columns. Please make
      an exception for those files and disregard those warnings. When
      checkpatch.pl is used on those files directly with -f then it doesn't
      complain.

This series was tested on top of v6.15-rc2.

Changes from v1 (https://lkml.org/lkml/2025/4/9/1952):

- Moved much of the C functions out of the Python generator, leaving only
  lookup tables to C code generation

- Cleaned up the Python code

- Unicode processing in vt.c moved to a function of its own

- Folded bug fixes into the series, fixed style, typos, etc.

Thanks to Jiri Slaby for the review.

diffstat:
 drivers/tty/vt/Makefile                   |   3 +-
 drivers/tty/vt/consolemap.c               |   2 -
 drivers/tty/vt/gen_ucs_recompose_table.py | 255 +++++++++++++
 drivers/tty/vt/gen_ucs_width_table.py     | 299 ++++++++++++++++
 drivers/tty/vt/ucs.c                      | 156 ++++++++
 drivers/tty/vt/ucs_recompose_table.h      | 102 ++++++
 drivers/tty/vt/ucs_width_table.h          | 453 ++++++++++++++++++++++++
 drivers/tty/vt/vt.c                       | 138 +++++---
 include/linux/consolemap.h                |  18 +
 9 files changed, 1376 insertions(+), 50 deletions(-)
