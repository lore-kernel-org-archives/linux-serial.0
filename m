Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF71F213E79;
	Wed, 14 May 2025 20:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747254065; cv=none; b=En6k0+Nqqcz4CLnv6oZvv2+e3DCkmlv5kBW6U2PcTNrD/A/noAGGsLpjkBN4qSUmTtKpLpQH+mUszXkTEJGXA6k1pchqD1JmjBgYyt5Fa1GuCUUwbaO3ouup6ePZiHNWtZ1y7LpZxZf6dXU0pePQnbZsWM1JQpwktxVaF4ghAlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747254065; c=relaxed/simple;
	bh=GVRJCIwVCNnNb3MIAQJ/6WNQV6YxlH6shaCjoTj+vew=;
	h=Date:From:To:cc:Message-ID:MIME-Version:Content-Type; b=tpJqcL4z7+Er1wAsMC5kJrMxwMl9nonp4Kt0sVS2UANE4/wSY/XwN/+cC92r5MhMlQmI4wB/ebNp3t61VTIlERO/cYwdD64X5yejzh7szYZQKvO6sRbEIVsT/TUF1LJdWVADsNUQOxtDwZbhn2+kmnRTlnWwLfSUr9/k+N04S7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=AaKPI1b5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oO4YOD7x; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="AaKPI1b5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oO4YOD7x"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9B7DA25400E0;
	Wed, 14 May 2025 16:21:02 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Wed, 14 May 2025 16:21:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:to:to; s=fm3; t=
	1747254062; x=1747340462; bh=1NZsnymokUXxmWmAKbgR17C63yo+HACqEnh
	Iux2U9ZQ=; b=AaKPI1b5mP19bKzQJKEYleJGD41z3buW9Wt4DSiiMaqjeb0rs93
	UObWAm7OPHIrdhEmvzNC4uknR3B9MHHEyvGwJh52l3ALZ8huME7owUPQIjVKx3fd
	qrFcg+gdldDC1ApTr48jmG6rx0v3AdBvYxUMhwsqPrSoB5GblgYXla/YSLU5DZ8y
	BpBFenqapSSrwHgBJCdmdmK7gUTMfiJyJdjKwFC2Bcb+OW/xbfZeUS3E/pQZwzro
	oYKauafsls7cwhNpUNuUSg+77eRCYHDPLfvh5MbQOK0MObSEai3A05R5w+dTV3PW
	QSS44hFANhTnqZ6Tgbz9yO2VMujeDlPoafA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1747254062; x=1747340462; bh=1
	NZsnymokUXxmWmAKbgR17C63yo+HACqEnhIux2U9ZQ=; b=oO4YOD7xMQF3RJpdV
	eVERzqzE0YTEPN/ZkmwxuF24LJYq1tLifpQGDt0Fvu+Icc/FhlpPHibfJvktCnXq
	zRpzppOx+MNPtWqEm+fHhN2FZ0bDLE0BrBsTMy4/l0FD1z68pW7ZoSF272dNIlFo
	CSh7cXMD/mNwfVopNe2FvOJzs2sJ87Yet0E+2NU0+igN0qXhFMstI5vWQ5iDY+SX
	wQKKGw/tjQ6XanUMehstz/raJ/zafZT0uPc1d0/pqBSa8sGrprBifH9AwcPCirCO
	2RiBQ/i2PDtxk7PPTPukp4w1cU5nY+4s/Q/jAL8LmjoNTn5sDIkfbiSWmuucCbG0
	y5PjA==
X-ME-Sender: <xms:LvskaPdtQtDcpwTyjtIRma5rw-KqLS1JyrWkh-I_E3WO7ZZ6rCZWpw>
    <xme:LvskaFPYvjRFHgn7XoFNtA4N2KybOszxPAMEs8WcXQgdXaD7Z5Ro0OkfhWY0HzxLc
    smbKGE6aheWL-BvnLc>
X-ME-Received: <xmr:LvskaIgFgUnt0ae4Xe352_36CLXZJpCpgTTbxti4cJfhN3M5SFvdChBJ6xfO3sy60gTgCJWgBlcnTpZNeeLCYMF2VtOd--bG0HJA6tssgxH-X--n6Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdejleegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnefgmhhpthihuchsuhgsjhgvtghtucdluddtmdenucfjughr
    peffhffvvefkgggtsehttdertddttddvnecuhfhrohhmpefpihgtohhlrghsucfrihhtrh
    gvuceonhhitghosehflhhugihnihgtrdhnvghtqeenucggtffrrghtthgvrhhnpeetvdeg
    udejhfehvdfhjeegkedvhfejteetveehiefhgffhveevleetheevjefgheenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnihgtohesfhhluhig
    nhhitgdrnhgvthdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtohepnhhpihhtrhgvsegsrgihlhhisghrvgdrtghomhdprhgtphhtthhopehjihhr
    ihhslhgrsgihsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehgrhgvghhkhheslhhinh
    hugihfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgv
    lhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhsvghrih
    grlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:LvskaA_3KoUHAcDL6Bbx7H9MXhHAZlUYugEdvGEgKvibQKkqaSJTYg>
    <xmx:LvskaLtvWk0v-hSXGLcClcjeORLu_MzYYN9NgRpAt3j4bMKocn5u_g>
    <xmx:LvskaPEwLtvR7Tg6-xZopr-O7P4oAr1KStm9LD26PenDvVkKcVKUmg>
    <xmx:LvskaCPubGGg-y60RWyn2GBy7OR_SNFD_4-Sf6Y8uxi11SkJIQrYuA>
    <xmx:LvskaLtNHUB4F_PTmwb5WIzXolrlO0sYcf8I9RT-xLXKvYvH-Vrv8xVZ>
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 May 2025 16:21:01 -0400 (EDT)
Received: from xanadu (xanadu.lan [192.168.1.120])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 7280A11A27A2;
	Wed, 14 May 2025 16:21:01 -0400 (EDT)
Date: Wed, 14 May 2025 16:21:01 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>
cc: npitre@baylibre.com, linux-serial@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Message-ID: <62s32907-1954-862o-5p1r-967n6873sp2n@syhkavp.arg>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

From 28043dec8352fd857c6878c2ee568620a124b855 Mon Sep 17 00:00:00 2001
From: Nicolas Pitre <nico@fluxnic.net>
Date: Wed, 14 May 2025 15:58:22 -0400
Subject: [PATCH] vt: remove VT_RESIZE and VT_RESIZEX from vt_compat_ioctl()
From: Nicolas Pitre <npitre@baylibre.com>

They are listed amon those cmd values that "treat 'arg' as an integer"
which is wrong. They should instead fall into the default case. Probably
nobody ever exercized that code since 2009 but still.

Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
Fixes: e92166517e3c ("tty: handle VT specific compat ioctls in vt driver")

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
