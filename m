Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E8C4B1E75;
	Thu, 15 May 2025 15:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747323058; cv=none; b=tuGlyLmDAgbaI34jjJ8/SZOCny0shOOgwDRe0gDY8jwBAg7PbP9zjO/aNhlHqIpw5dSn+DON2aXPhPN5xp/9uiJ7Db24O5hcBDJCdjEnX5Lx8hsfIviaunyMayhdyUA7PedWCue0HHXkgL+GjxOnDITYguwSk8l5qMPRNvdPKR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747323058; c=relaxed/simple;
	bh=+HQsfmCC8H1AyitA5HLSA3fDVa9CU0xpDdRYbxb5HRU=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=XYDGS/W29y5yir/RWvTQulnyysO/k0b4MMn1tYZYRe+QG1XWoGvgo27E+AP2AD5Q4B+PKSZHF2OcIa/wxZmdFNsdMVL8bwIPiTWyFzDoWFP65puFJM8aulKJ6tBLY6FsOzu9EDwJQz8bgLsWGlUczIWl93f9ceqqfSt9CWMSGUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=H7g27Tr7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pQQG2ch1; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="H7g27Tr7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pQQG2ch1"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 8466D1140129;
	Thu, 15 May 2025 11:30:54 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 15 May 2025 11:30:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm3;
	 t=1747323054; x=1747409454; bh=KUxrtcJ3xIsgw7aplTT+IKljavQReIJC
	NRW0zxjuI1A=; b=H7g27Tr7FvSVrffWAoBkUCnwFe09oKB0t9Zhkm+H1IuaDxz/
	zuVJqm/ffkzzCIzHaPDQsJUgwdzgsMZQUIOTnew/Zyr3Ivh24Dryi5BgT+eYGij6
	HbWbkuXXVlvKWbqi5AWH9ykj+CnGVO8F/PV8xZ9y1r7Qug5OVyyAr2nt80jBrQzv
	PbJ+6fmZSYuB7xW4Wvd1k8/e/6puwNBQ1O4ff0W9WxKzpZVpqRfhgkxPL6hR5Tnt
	fv1LOhrG7MWTNhKwU3/3DtgxFQwiwmLMFlZJYwAe5htiO7wZ3Ap0UtewepGxuWKI
	H833o1QSTerkSDVgUycH6JhZCaBllwuDEnqIvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1747323054; x=
	1747409454; bh=KUxrtcJ3xIsgw7aplTT+IKljavQReIJCNRW0zxjuI1A=; b=p
	QQG2ch1mComMFw2nePfpEYDhig4gzp3hahItLkV6585YC0zj3eqqyzpLtQ9wPlaw
	4jsK2wcJH00ciAMcED/w9K4KEcU40QJe2ZyKa6gO5VdhhClQT9JnsrJ2bRBGrnj3
	eT1tEsXf6AmYjGSiIaFHQtwtTrkfYLROwCc4oqaKY2yHE/7e1ZALfGFj7cZaai/O
	ejG2rpyBd4y0LiNUWNbZ/0KGd2l0OixztvrcRgJVg607YRaIWFYRiXyUvWBTq2I/
	WW7H8tYLW2e/TO/jgVV2KVuUTlF+PZd5OiLd0joty26/neEYyAw1M7W8HTsyYAkk
	5P35KSYjV44LcXJL34tmg==
X-ME-Sender: <xms:rQgmaKc60w_85dlvrsLT_rOnhTnOuWU-GLE7PfeQeQg6MmuQZ7O-iw>
    <xme:rQgmaEMfjK-Im0hpXxwOcT_RMXmfLreVHaqaP18CEJ4GwWAE9QxrDXrH-_PDTFFXV
    WPy5ZE6S2RWEc8-7Sw>
X-ME-Received: <xmr:rQgmaLjZ44V_lJx4L2RiqbZiGxLcrMrCcbOTbyrkNp9Z1w8_mfXvduuNKbZ-l2A27T_tECfvSVNwVhTL7IkZO9u54lua3g-aLWh8ndKOKei6VVb1NA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefuddtvdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkgggtsehttdertddttddvnecu
    hfhrohhmpefpihgtohhlrghsucfrihhtrhgvuceonhhitghosehflhhugihnihgtrdhnvg
    htqeenucggtffrrghtthgvrhhnpeeigfeiteevgefgtdehhfegvedvvdfhtedugeettdek
    veegteeifefgveeigeetvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhhitghosehflhhu
    gihnihgtrdhnvghtpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopehnphhithhrvgessggrhihlihgsrhgvrdgtohhmpdhrtghpthhtohepjhhi
    rhhishhlrggshieskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhrvghgkhhhsehlih
    hnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhn
    vghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqshgvrh
    hirghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:rQgmaH9vIkIVLWvE6jQPpj4h6b2xUITFrjycYOub37WHZOj8gegWng>
    <xmx:rggmaGtXLUDJpf7F3bK0eucCKC4fP_SBBGC0kZPt4DkPwG9JJ-I3Tw>
    <xmx:rggmaOH2YvF8J4lwoN7KfrWhrqnhQzCw5LEezTW6gV3RMxp7uzBxFA>
    <xmx:rggmaFPV-tiyJur4Rjlp2Gj6xyPNNhWmu1M7Iz6AsTk5dJGI3vb9WQ>
    <xmx:rggmaKs7Iw2utU5KXpDUaGaZ1ylXGrlpDiSsWEwLFkW11zAqufLUtUNI>
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 May 2025 11:30:53 -0400 (EDT)
Received: from xanadu (xanadu.lan [192.168.1.120])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 2186A11A42D0;
	Thu, 15 May 2025 11:30:53 -0400 (EDT)
Date: Thu, 15 May 2025 11:30:52 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>
cc: npitre@baylibre.com, linux-serial@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: [PATCH] vt: remove VT_RESIZE and VT_RESIZEX from vt_compat_ioctl()
Message-ID: <pr214s15-36r8-6732-2pop-159nq85o48r7@syhkavp.arg>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

From: Nicolas Pitre <npitre@baylibre.com>

They are listed amon those cmd values that "treat 'arg' as an integer"
which is wrong. They should instead fall into the default case. Probably
nobody ever relied on that code since 2009 but still.

Fixes: e92166517e3c ("tty: handle VT specific compat ioctls in vt driver")
Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
---

Reposting as I screwed up my initial post.
Jiri's analysis can be viewed here:
http://lore.kernel.org/all/184449a6-f2db-4307-8351-66b617a3839b@kernel.org

diff --git a/drivers/tty/vt/vt_ioctl.c b/drivers/tty/vt/vt_ioctl.c
index 83a3d49535e5..61342e06970a 100644
--- a/drivers/tty/vt/vt_ioctl.c
+++ b/drivers/tty/vt/vt_ioctl.c
@@ -1119,8 +1119,6 @@ long vt_compat_ioctl(struct tty_struct *tty,
 	case VT_WAITACTIVE:
 	case VT_RELDISP:
 	case VT_DISALLOCATE:
-	case VT_RESIZE:
-	case VT_RESIZEX:
 		return vt_ioctl(tty, cmd, arg);
 
 	/*
