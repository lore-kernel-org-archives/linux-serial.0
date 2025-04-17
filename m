Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A664253F22;
	Thu, 17 Apr 2025 18:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744915751; cv=none; b=NeMHxqyR635p+NrZo7TK7ak4tMvid96Zi0TYR3VBb7jzlG5rmHXQqHU2yM3LBd72doRQX/OxHyAFk6XNhcOiaNjdTlahsM9OGOOotzKwSDLoU5C82g2A3mdHnVak1DJV2AnhV0xSFzPhJId9SlWWL5L19VWB9hJXU0tcSXCUrWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744915751; c=relaxed/simple;
	bh=qivKA6/evLqYgxE3ZJOwzH5Yviab0qxFyThFKhLYVXE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QPih5brvr/X/ituNCYR9c2Hrk9JInDSiHDLrXQZ/esXSPwNjr45nqr8xkZ2AdvBy864TM0gyQLs4NhGgInFDDcMXwHvIoEqMW5Q2HN2LuBS7AQ/I6i2IGW0/7XET8iU+AUbd9q/5Xx+wjqYUwO3qfx+DVyIepfYnh81m2KcH2PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=q9FBodYm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ew5jB6vX; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="q9FBodYm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ew5jB6vX"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 168D811400D6;
	Thu, 17 Apr 2025 14:49:08 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Thu, 17 Apr 2025 14:49:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1744915747; x=1745002147; bh=VAQ+CGxYUqLjES9fjToEL
	t+hrz9C42tGmTCfZutp5fc=; b=q9FBodYmlP1rQdD0VipHVQ0QKJUJYTFZhOSMn
	hoJt5buUK57C1brjsfUIzCkOk0GgZzI3TdAQnwlcej+UOw4sD9U2vGrze1LVnwVR
	vp2VQjc+qmv+95UPyHjbC+V/gyeOG8HVdGK8bgciR7ummAPHEZisSnMtD5cRuYFc
	dzVClbz3oL3vZw9PJp38nlj928nis9U0oLVD8VyOq1DqyxavDD9+xoPH+LbdofZi
	P6zxDUjITiP2Wv9G0WdQg3on/ZemxqY+imkdFPW3r9iRXi6ZQyks7iC1yzqegTZ2
	t7ifCS68HA/W/1AwZuV5INszFY+kNfS1HocGkoncq9ZQgX05w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744915747; x=1745002147; bh=VAQ+CGxYUqLjES9fjToELt+hrz9C42tGmTC
	fZutp5fc=; b=Ew5jB6vXgEFymsWT8Ldg788+yT89l1D+qr3/5ZWuaa8MKJxo0E9
	ANd44zWARnOFF8Vx+eKxUQzVM59DuBebVudgMxa8nBILN+ciXhrisx9IstjLIvAO
	yMtOiTGIHZ2YbimPKPXli3AlT8KgN9NrGxkiULlTa735ZwJBmHs5omtlD4EpM+/U
	azDxHHr2rRTyVU1xU07Sq6urZV3jK7tFhR1GYF/lQy9NMCd/tJtkqZaQqWio7QUu
	vklDfUFT09NvDQJzgkXXZP9PCDUqJJPmwy+/jE890d6GtZtJU/9+juKz0XsACr6u
	OcQAY4SXUdLir8xHW6i+z/t84DBJlvgbFRw==
X-ME-Sender: <xms:I00BaGYKpSsct4MJUjTRLaaKgbkmnbo4SXdLcs2u4dyVAMu2QAyjIQ>
    <xme:I00BaJYtmy6SKeoMAO2l7fsmhIDhAMyaUh-ThH9yIcGZ8ItHO2VK9W_CrV6CrTmmy
    lPke3JJCAnQHVqR6C8>
X-ME-Received: <xmr:I00BaA-Fr1Q08m71XgVkKIVpzHY9niY3kT47N9cnM3jo3UtTQx7RtW5uVnYiNWpVR4w3W0uSEcWvh2Hq6DnIl1wygtoXGkkeXN0341_S80jzbs4KWg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvfedttddvucetufdoteggodetrf
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
X-ME-Proxy: <xmx:I00BaIqN_rD9DZLcDzs-8a8fI10SCmeSDtHiQkir5QI0GfmMIbTquQ>
    <xmx:I00BaBoECHPTv6IIIe2LNfO1rAFSX-CLFQsIQ-VSKlrI9sO8D7H35w>
    <xmx:I00BaGS39wKfaXOF7NTTlipnqxAc8gSQ5u-a5SuB0G_9GmznwfoxhQ>
    <xmx:I00BaBp_Cg2LDilYzHI3uBtnZR5myFInNkgOnNUjfDE0xnU6LajvvA>
    <xmx:I00BaK60Uhg3HAjAVWgKyPy1cEyOAUetYX8HD-lOHhXhdhxTkRTGhbRH>
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Apr 2025 14:49:07 -0400 (EDT)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id CF03C11443C8;
	Thu, 17 Apr 2025 14:49:06 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Nicolas Pitre <npitre@baylibre.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 00/14] vt: implement proper Unicode handling
Date: Thu, 17 Apr 2025 14:45:02 -0400
Message-ID: <20250417184849.475581-1-nico@fluxnic.net>
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

Changes from v2 (https://lkml.org/lkml/2025/4/15/1705):

- Fixed kernel-doc warnings for real

- Made python version (python3) explicit

- Added Jiri Slaby's Reviewed-by tags

- Implemented the "_shipped" scheme: added Makefile and script options to
  allow for generating the table files during kernel build
  
Changes from v1 (https://lkml.org/lkml/2025/4/9/1952):

- Moved much of the C functions out of the Python generator, leaving only
  lookup tables to C code generation

- Cleaned up the Python code

- Unicode processing in vt.c moved to a function of its own

- Folded bug fixes into the series, fixed style, typos, etc.

diffstat:
 drivers/tty/vt/Makefile                      |  30 +-
 drivers/tty/vt/consolemap.c                  |   2 -
 drivers/tty/vt/gen_ucs_recompose_table.py    | 257 ++++++++++++
 drivers/tty/vt/gen_ucs_width_table.py        | 307 ++++++++++++++
 drivers/tty/vt/ucs.c                         | 159 ++++++++
 drivers/tty/vt/ucs_recompose_table.h_shipped | 102 +++++
 drivers/tty/vt/ucs_width_table.h_shipped     | 453 +++++++++++++++++++++
 drivers/tty/vt/vt.c                          | 138 ++++---
 include/linux/consolemap.h                   |  18 +
 9 files changed, 1415 insertions(+), 51 deletions(-)
