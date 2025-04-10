Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8089A1DA4E;
	Thu, 10 Apr 2025 01:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744247945; cv=none; b=YPNlBDKfl3nZGXpHtgCm68EeZCVceqdGAab8vYpPTL4XWp4cX1Kcrrt93VHHtuzMbwvKKh7wTSCKs9C+00ZB/01/4UYfFpJJUAxT60POZRXLLkEfQTVHViIuyljjfjYpBkDMzGTkDtfTSQKZJC0FuHDf12HL4KkE7NUS8KyaHeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744247945; c=relaxed/simple;
	bh=mnwhLxpOvHXvwrgs3pyGeI3bimuo3E6qCdsQZYTDtho=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uRYUjVwEt/nj0Sxvv2wQ1cN2IuMvpaSA6oYo2nnpKeYpoiDHNli2yaUk/t29lgTsUnNFKEps8GkL7WudjSaIx3iGe8W1mAgjxPz9PgLz25mU+xwV+v9KhuEesje4KtVNC9vI6/WrHREDANa/6rycssNcU/IKxmVPRuxISiE4ZRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=fNdJtiY/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a+vSR9FS; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="fNdJtiY/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a+vSR9FS"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 8834213801DF;
	Wed,  9 Apr 2025 21:19:02 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Wed, 09 Apr 2025 21:19:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1744247942; x=1744334342; bh=TWsek6y38leRX5NWrNotZ
	MTzW5XdgDKrPyKDEkOGR4A=; b=fNdJtiY/nnASFxTGhnSXCB38nudqFtKDQXSt/
	oLXDYnHDHW+wTdsflCIhGEukBPxtNFKzKthRCGeuqYl83M+lfNrUzC/d5t5Kx3zb
	kJRh0weKDzIRqHjnmraqXFF2Ny7TWMTYn99BfAkjAF/gU4qvldWhkXGd7Q9c7d09
	O0VkKI72z6owJkEgeHm+7WYauH/+uygNLOMHMLIKKAQI9sw84J7tZIKzqWb3vKpB
	ZnWHC0U7TJJobN8jGbBdUw9Y/YfHjJvzGT4IHUGLxd9ujMfBrWYOjurcqnougxX1
	UTTnXOseVOIYCDjyBDamWFXAecVx3eaMPPRLvemDtHCYrm53A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744247942; x=1744334342; bh=TWsek6y38leRX5NWrNotZMTzW5XdgDKrPyK
	DEkOGR4A=; b=a+vSR9FSEh3BfZFl2u9wMM1u97bZrbAB2CqScaDbH3geNPalbZX
	H3lIMFoEz69iIdvyI0w76oZ+3qxoizww3PdHoRwMgNu+11zBPolOVRfbttbocfzv
	TdNmDxTSxI+b/NDBAhNdrxRPzy7UPLb/JcGcqhd30fXD0V5KmGCYe4BKTH2mQZfM
	J1G6rYTiMe5UNu/nabwOinWDJys2Wi4YLcAZ4v7P1EvkUENZZeMJIj+a1zElNG3r
	pjTGUvv1BJqAXPf08XmAjVX5w6xKQMxO3B4Ge/Egp+G2dHiIGweDxX1b8gGFhWY0
	kQ5o53RRTGzFVTn8yEkEv8KHwiSA4HkD1Sg==
X-ME-Sender: <xms:hhz3Z6RTS4IkQbZjId5XhFvdBWYtnJQypKV91FoxWkvyz3f0FjYI9w>
    <xme:hhz3Z_wQXsIETqyvT9XGf1URpRJ9LOfzG73OK3aTKpzf3h-m-iIYFdP3PVXnlQhUT
    EzepfW1AuqBYCD74kc>
X-ME-Received: <xmr:hhz3Z337_2y7ANOiWgFHvZYTaPUcx0ZWU9Ck6rBdGozWj-rjNAjt1OwdZ5tRaUWHhdAQ5jPDgWDo0JNVymfS3Ovz3xTEbbdNt9pEliHGceopGmowxQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdejheehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgggfestdekredtredttden
    ucfhrhhomheppfhitgholhgrshcurfhithhrvgcuoehnihgtohesfhhluhignhhitgdrnh
    gvtheqnecuggftrfgrthhtvghrnhephefhfeetueeiteeigfffieelveethfduleegheel
    teehudetuedvjeffffdvhfevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepnhhitghosehflhhugihnihgtrdhnvghtpdhnsggprhgtphhtthho
    peeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehnphhithhrvgessggrhihlih
    gsrhgvrdgtohhmpdhrtghpthhtohepjhhirhhishhlrggshieskhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpd
    hrtghpthhtohepuggrvhgvsehmihgvlhhkvgdrtggtpdhrtghpthhtoheplhhinhhugidq
    khgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugi
    dqshgvrhhirghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:hhz3Z2DOD-cheAvZn-3cj9KP6ZGAyRYcdQqvrnmYUifG4qbLsMa3SA>
    <xmx:hhz3Zzjj6FENQLAF8Alp5dLJT0fNkEpVEvd6ek833VlD7Cy8uh_K1Q>
    <xmx:hhz3Zyqr06RNADx-DljFJONSefT6Q3Vz9-6mj6zZekRw5-6niJWuuw>
    <xmx:hhz3Z2guPQNIwSwszEav_yNuBz1d-d3bQJTdF_1lwUlVO58nK0_-6g>
    <xmx:hhz3Z1jXqReAaql2cv6TWd-0Ae8FZwuKBAJ7rJLr_H4ndFcwhIaEyrQ0>
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Apr 2025 21:19:02 -0400 (EDT)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 5243510D8B6D;
	Wed,  9 Apr 2025 21:19:01 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Nicolas Pitre <npitre@baylibre.com>,
	Dave Mielke <Dave@mielke.cc>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 00/11] vt: implement proper Unicode handling
Date: Wed,  9 Apr 2025 21:13:52 -0400
Message-ID: <20250410011839.64418-1-nico@fluxnic.net>
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

This series was tested on top of v6.15-rc1.

diffstat:

 drivers/tty/vt/Makefile             |   3 +-
 drivers/tty/vt/gen_ucs_recompose.py | 321 ++++++++++++++++++
 drivers/tty/vt/gen_ucs_width.py     | 336 +++++++++++++++++++
 drivers/tty/vt/ucs_recompose.c      | 170 ++++++++++
 drivers/tty/vt/ucs_width.c          | 536 ++++++++++++++++++++++++++++++
 drivers/tty/vt/vt.c                 | 111 ++++---
 include/linux/consolemap.h          |  18 +
 7 files changed, 1448 insertions(+), 47 deletions(-)
