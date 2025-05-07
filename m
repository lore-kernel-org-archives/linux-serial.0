Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E5128A712;
	Wed,  7 May 2025 14:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746627345; cv=none; b=cC2xqvXlovErMGRbhb0nPlRSPCipqd8yNiF2hDsjHQIpJtsH5zxxY2XPaj87hdCaCsEWgxh8m3S+wNgWE+M6+U3unz9Tgf3ZJfUmGlLF+ZReh5JbP2bYGqcVoSNowr43TJrUxNVe5qWI9pV6H9pElkskm5o4zeBImgBSg2Ecci0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746627345; c=relaxed/simple;
	bh=PX5hFaTPDzmMrCD/q58DPW4+GN9DRqsg9Mb15jIpJBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uhmb+DKWqTatHPaFiSPSZuN6HpP0vtuW6yLl4QkkAk5W4TSeC1jnhHRPozM7d1C0LCE4HBjXwmr3qGIDp/XPsoWeBhMKscNGN9eRaqbNMvBsSJjLzq3gjRnlt55y+XN3F85b0HdrhFuskmdOdN78eqEArAWjzCbWNzp+l94jpCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=LTC+9c2o; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hvKYojAl; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="LTC+9c2o";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hvKYojAl"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 9410713801EC;
	Wed,  7 May 2025 10:15:42 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Wed, 07 May 2025 10:15:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1746627342; x=
	1746713742; bh=9n0M/Qbz0wIk0K+/MBcZ+vu+g0r7fsT7X9v480CFjEg=; b=L
	TC+9c2o950mBLN+tqRfIjZjI0bBwWKAY46Tcri04cQjp85MjhEYmK7AjYwAFSID9
	skMhBxZlSNc5t2L24bLJqv1yxqpFgXEK/s5lO3TAJJONrmUWKkzJtOl61gHT65Wt
	SDCDGPXOiSY/ElLbim7TVn17KgDy7jeSzc4tRpmc7TEkxIRsOw1bhRtsWGccitmG
	wPOHR+5zZq1JdfrOkjuFGKNMCgpoMChhdORBLtcmWsEIUYzlg7P80s4Syy0M4BDv
	zcp2cRYEWmIQLmPspDvuvrE56Cs82bbGu8QpxqWm1OpT48TwwBHmhgjVdwqnYwZr
	JNfYSOYbYHwy9LK8hZ8AQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1746627342; x=1746713742; bh=9
	n0M/Qbz0wIk0K+/MBcZ+vu+g0r7fsT7X9v480CFjEg=; b=hvKYojAlJnBr0eS52
	bVUnLm4duRFblKHhTv5PddX0IVbrxE/WWjn2bncDQQ+wXbCakOBHSSblasJ+zmvN
	d0QwjVYcKWMuLaysonUkkxbGXhg3nbdfTxrGxC8OefLfgpI+2ct4atvEHi41oBWc
	wQkxiyYb7b/XwMQECgn2hlmEQM6AxcvSuTvWwNFyWzMZlXboEVtksN93CTAKUFqv
	Jch+5TD9zWWWW/BsJN5Dh8EgdpfqIOBpUUIUcpmpT/QeEU6hL6hnbG7o+nuJKtFU
	WgHfnD7/FIlqYAFGSPXiDqPYMQ/M05u82b4ORzkIK5QqiE6ZKR0a+7ADuM77sWXV
	igV+Q==
X-ME-Sender: <xms:DmsbaP0b0BfSfGNLl3oPLbhT3ufE6nT4vOOZ8jxv807MoG4tFdfE9A>
    <xme:DmsbaOFU85eq5CHiIoMH0iKL7BUq2DxEWz2P49N-vnMXajfZpJkb-rO_-4TlCu7Dp
    6StZQKMLq1aNIp1KMo>
X-ME-Received: <xmr:DmsbaP6hqaVJWvphJTBwjyV9t3Op_w8JXH0LABKnNHUoeS5UWZZHArSIUezcb5WFR2dQgnir2mKsnOM5brA64hI6FTTEXnJFSyDx_GggSZ8OPey6Ww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeejtdejucetufdoteggodetrf
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
X-ME-Proxy: <xmx:DmsbaE2Zz891sOyWT2K-6MSsedI082LLEYnwhUPd04mS6ojXWMyYlw>
    <xmx:DmsbaCE4X1QxP1iOxnIrocMLRuesBppOiWnycUYv2OlD9TnmgFw0Ww>
    <xmx:DmsbaF8oS1bH1YTyzUUvxZAyNYor-IMqwRfUqClxwhrofcmOdZ4OCg>
    <xmx:DmsbaPkbd1AGxb3ram77KukQ2JLvl8zAfEM37hy7Ga5WhmwyqPFBZA>
    <xmx:DmsbaCmy51PCXGE2vIraSAg0a48lPCMFokB_VHyMZ5fjf592BBF60WiB>
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 May 2025 10:15:42 -0400 (EDT)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id CE3901189EA2;
	Wed, 07 May 2025 10:15:41 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Nicolas Pitre <npitre@baylibre.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/8] vt: make sure displayed double-width characters are remembered as such
Date: Wed,  7 May 2025 10:13:17 -0400
Message-ID: <20250507141535.40655-3-nico@fluxnic.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250507141535.40655-1-nico@fluxnic.net>
References: <20250507141535.40655-1-nico@fluxnic.net>
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

