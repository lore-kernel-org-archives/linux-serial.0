Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B1E376BCC;
	Tue, 22 Sep 2026 01:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790040499; cv=none; b=G3v1xxm1wr3UkIXO0ZV2zZNlFW25j1O/32th+gF7eg7ymc7E3oc69IEAXm5XgKpF8wPdaeOgcJ2OvaE9qqYI0uil84dNySjrjDWAYPl3Dml0vOrB45tn5/HW75OcMqpukRpXshl+cDTmiO3EC/9UePv8UnHWHjU6II076lOtxKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790040499; c=relaxed/simple;
	bh=dFylFEPnR97J+B4KdpVrhI6g4QkdGREbdNdNCzaycn0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=d8mIn/BCT/w4edrRbfxhlynuYb304AkbzxhtUUBDc1vMNqLJf+Q8wYbjMf4tFa+W1NiMt71cNum8xT0I9DdkLQm4gqfo+mZ9E7hdZSibUedQu+11O28Kh2qIVNpcWPKqKFL1RD+Q/D5DmMEGF12AGhydL7IpgSBiQdVu1XAe4Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ISHEZ7eg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ISHEZ7eg"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6939BC2BCFB;
	Tue, 22 Sep 2026 01:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790040499;
	bh=dFylFEPnR97J+B4KdpVrhI6g4QkdGREbdNdNCzaycn0=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=ISHEZ7egYfyWGmIfy8yQisaknTuDY1sKRu+tt9i/RSDPgcMar/kVRFoXl66YkDaMa
	 N/MgoL3l9ldTHwDVcvdQGH9Lx81mldqupfjr7OsrBrfGD14SoXb7646hSOYB9YAtJk
	 63MS4Fx4BMYUgCTJo2KLZ1oovmvikAwSbfFCdUoCeRbhgvVAMQT/0UqOsyF29WLuZe
	 EdUf3B+6lQ9b9zLIzcClCJ1fV0NLDIzeDbuVs+chKg+hhxGL8f8egEScxYlxC3ouA+
	 I5++RQzu4UYn+qiF2xe5ER2qAHoR/gJV3qoWKBROgrtPk4441CrkDKb7xC9nQdAl9x
	 iiwO9gmpObaoQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F5C1C98302;
	Tue, 22 Sep 2026 01:28:19 +0000 (UTC)
From: Jaidev Shastri via B4 Relay <devnull+jaidevshastri.vt.edu@kernel.org>
Subject: [PATCH 0/6] vt: keyboard: make the kbd_event_lock ordering
 explicit
Date: Mon, 21 Sep 2026 21:28:13 -0400
Message-Id: <20260921-mb-keyboard-v1-0-d170228b80c0@vt.edu>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAK3ZsWoC/yXMwQ6CMBAE0F8he3YNtGCDv2I8tGWRaixkVwmE8
 O+2eHyTmdlAiAMJXIsNmOYgYYwJ1akAP9j4IAxdMqhSXcpWVfh2+KLVjZY7NH3datXoRhuCtJi
 Y+rAcb7f73/J1T/KffJEbzgqhYxv9kKODszlrZF/Dvv8AYqnfzI8AAAA=
X-Change-ID: 20260921-mb-keyboard-7f493253537e
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 Jaidev Shastri <jaidevshastri@vt.edu>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790040498; l=1714;
 i=jaidevshastri@vt.edu; s=20260921; h=from:subject:message-id;
 bh=dFylFEPnR97J+B4KdpVrhI6g4QkdGREbdNdNCzaycn0=;
 b=mjNWpv7RlorVU+alD+DGlCi/7iOosVd4qx30Y8yI+SYsjabpq2oulHO2Og30/9IXroGiNFyyx
 1N0U3OgvxwfBAzBhmF032rC0IuvIVRzgi7aXHPxWljH7uD2yn/YyAIL
X-Developer-Key: i=jaidevshastri@vt.edu; a=ed25519;
 pk=J7+xYJRlTPds+pv5hbqFFRqGCpDeJDzmZT1ggRwj7/0=
X-Endpoint-Received: by B4 Relay for jaidevshastri@vt.edu/20260921 with
 auth_id=1044
X-Original-From: Jaidev Shastri <jaidevshastri@vt.edu>
Reply-To: jaidevshastri@vt.edu

Six variables in keyboard.c are written under kbd_event_lock and read either
without it or from a different handler, with plain accesses throughout:
shift_state, shift_down[], npadch_value, dead_key_next, accent_table_size,
and the in-place rebuild in do_compute_shiftstate().

vt_get_shift_state() is the one reader that deliberately takes no lock, so
the relation between shift_down[] and the shift_state summary word is
currently unspecified. The remaining pairs are lock-ordered today and those
patches only state the order in the code.

One patch fixes a real mistake rather than documenting an existing order:
vt_do_kdskbdiacr() sets accent_table_size before the loop that converts the
entries, so the size briefly covers entries that have not been written yet.
That store now follows the loop, in both ioctl paths.

Found with MBCheck, a static herd7-based memory consistency checker.
Compile-tested on arm64 with W=1, no new warnings.

---
Jaidev Shastri (6):
      vt: keyboard: publish shift_state with release semantics
      vt: keyboard: publish npadch_value with release semantics
      vt: keyboard: publish dead_key_next with release semantics
      vt: keyboard: publish accent_table_size with release semantics
      vt: keyboard: recompute the shift state into locals before publishing it
      vt: keyboard: publish the shift_down[] counters with release semantics

 drivers/tty/vt/keyboard.c | 72 ++++++++++++++++++++++++++++++++---------------
 1 file changed, 50 insertions(+), 22 deletions(-)
---
base-commit: 93f51579e7df248780214094418f205253383cc5
change-id: 20260921-mb-keyboard-7f493253537e

Best regards,
--  
Jaidev Shastri <jaidevshastri@vt.edu>


