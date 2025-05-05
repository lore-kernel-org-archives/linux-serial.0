Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9999E1957FC;
	Mon,  5 May 2025 17:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746464471; cv=none; b=Yd71hHFmUioggeO0wVE0mbcDnPqamF2DIU4sqR5gQeJIIWvv8C+M6Uaad3/2vQdnTJ9nE/dTnbiHUjtNCseAzm474mmS0dacEvRo9c0jYyVAIFWTatI+ubKYy7TnYQPzuoR+D6DLzRPkv2zptmlx2Bl9MEldghoWitBsCh/KkVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746464471; c=relaxed/simple;
	bh=PX5hFaTPDzmMrCD/q58DPW4+GN9DRqsg9Mb15jIpJBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RSPQpuJyRyniKcU5ROWEFNhp4Hel4z1THdnW8EDxlLl1k2nbcP7iAaomwZ5GJdrYJk3BiVGTYC2haFxVTtj+u0pAg1GDvr8nQTmfBFJgk9Avs17CXqZ22haf8rq7fZTHrH3LHY2xwIL3QCg9GUkhWhYVBNXXdXEMFzg88MX1BE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=Hvr1uPIT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HyV0/y7C; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="Hvr1uPIT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HyV0/y7C"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 850C31140250;
	Mon,  5 May 2025 13:01:08 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Mon, 05 May 2025 13:01:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1746464468; x=
	1746550868; bh=9n0M/Qbz0wIk0K+/MBcZ+vu+g0r7fsT7X9v480CFjEg=; b=H
	vr1uPITq6zBr0PIFu3ttaF8SUSBsn4MlaTnMeyavLIsYKq/7Y5OFbaZ+aR43na/n
	Z8ENzY2LMv6PN7Y0nc9V1QCRP+KZ7/EUSOpuuMEGF7WXB35vel+/k7zXS022/kKm
	7yuZtQkMacGmQOXKLGZaNZ/oFrfgRy3ORc7GZz3AKCbkEoKwvpSnnkmSIwS13k1M
	K34+k6Syad6xftdjL0NC+rg6c8yF97kaNJuCLtsGN6bnpvUbAFRVmQqMUNaRIXG6
	M5p/Hfe7KIlboDC7MsN26nOGdjsM8KrdAEd+TcxuiHzT46OV/yA1vziPRom3b2e0
	EUctUc7ydP8lFUBa8BgsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1746464468; x=1746550868; bh=9
	n0M/Qbz0wIk0K+/MBcZ+vu+g0r7fsT7X9v480CFjEg=; b=HyV0/y7CoV6TXffEO
	NzwEL+BQ2C1nCNBQ354/xN5Y/FyPDSiK1rxkbIQHkI3BNKbvzWirCTiQoV1YUnZN
	d5dkxX8Qj7ZHQ9MUtnJcsrnUJNHNFLmyEh6aOGJzPI6QV+K+VJpbBUocCzqCUiT9
	eoopboAtmVRiHX+KkI/r8e150cxDOyStaN4HKRsytVCleasd9lsMA4lmsS0XllhR
	qpfy7jHuI7Pmm+ZogBRXlcci+Q24O8Y8wjVh0XsRDEbJ4Pd3jBtRpLoBBlUKLjj1
	LofI/TR7GrJesLO7ABIWaNqEveU7TJSuaJl0SiS9vbGneRXZXYd/2IcRZL13SUn+
	OSU4g==
X-ME-Sender: <xms:1O4YaIfhf0Ahs4xys8LLJXnNY7iN6JP1hHOaIgLrU0X_YNLXG3skJA>
    <xme:1O4YaKNsfJ0h339Ga7Zb59JrbdYFae9sgJhuUpSgr3LsCe5-L8z3CWxANNgNC3U8A
    fNTjgtxTTi8oh1Q-VY>
X-ME-Received: <xmr:1O4YaJgLOU-32mm4uv8YLUqsNBK7IBSJ8Ch_-ojUK0FwcAdRp35TruIi7WLdqQ0-v8d_4oyIJj-VkfudHXgCD-0rXzyDyPNYfC6aUr1fF6gvesAAsA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeduieegucetufdoteggodetrf
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
X-ME-Proxy: <xmx:1O4YaN_rt8AyLkjG9klyqtYnRqC9zEfrT6R6DuJA_Y7jH-PF2RlpBg>
    <xmx:1O4YaEuMEVyuFLu1GL5tv7iwwv5oZtnpuBbJQ2YlcxgkZF9IHdjIbg>
    <xmx:1O4YaEG6jtdvCkoNeWOiBjQRMWisKyohn8iA7YRU5r2rvSR6wu9oLg>
    <xmx:1O4YaDNFpYfz0NTNNSLpB5OxzTZSdCdAD5SUcSV3Ti9C-soDGx6esA>
    <xmx:1O4YaDApBolFs_yrsUMmcQ5tL60pkkvmShn_anx48-4rSEA_kOfmvZ6c>
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 May 2025 13:01:08 -0400 (EDT)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 8AE6D118545A;
	Mon, 05 May 2025 13:01:07 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Nicolas Pitre <npitre@baylibre.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/8] vt: make sure displayed double-width characters are remembered as such
Date: Mon,  5 May 2025 12:55:25 -0400
Message-ID: <20250505170021.29944-3-nico@fluxnic.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250505170021.29944-1-nico@fluxnic.net>
References: <20250505170021.29944-1-nico@fluxnic.net>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nicolas Pitre <npitre@baylibre.com>

And to do so we ensure the Unicode screen buffer is initialized when
double-width characters are encountered.

Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
---
 drivers/tty/vt/vt.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 24c6cd2eed78..58fa1b285f22 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -2930,8 +2930,15 @@ static int vc_process_ucs(struct vc_data *vc, int *c, int *tc)
 {
 	u32 prev_c, curr_c = *c;
 
-	if (ucs_is_double_width(curr_c))
+	if (ucs_is_double_width(curr_c)) {
+		/*
+		 * The Unicode screen memory is allocated only when
+		 * required. This is one such case as we need to remember
+		 * which displayed characters are double-width.
+		 */
+		vc_uniscr_check(vc);
 		return 2;
+	}
 
 	if (!ucs_is_zero_width(curr_c))
 		return 1;
-- 
2.49.0

