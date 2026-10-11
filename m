Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC57645C6ED
	for <linux-serial@vger.kernel.org>; Sun, 11 Oct 2026 19:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791748671; cv=none; b=i+LN0aoXc2XfoAMzylSZimqwrrGm1PnvgRVjVvva02CpdFSBLNAZ+HN6Ds1OBPT2cUml56QSkySbSyK57wIRScAIsRg5Xo5aqVwRraS17bzZkqIpGlUWX16eeM+gx9rh6/UiK9rSqsrk8blkektGUqkjg6M0CUlMsmGZMtYH2A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791748671; c=relaxed/simple;
	bh=Le1SYPb2jPNj5MhF8OuGIlzFKKsBR2rEDTHPqcMQNeM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dx5Q531ChHYpPYxhFPlEFHewlZkX2B7qgKlfYhgCULWZtQqu8730jkaOUHX7UwVSoGb+Rw0vbxzeDBCnOyXokOMWiYBLb+Oi1gI+5tZ2C89LUalMCAfV3r/E8O/nofUytkg2VXFLttcpM91yF36fAZ+Oxr8yDlGGcMz7Zp6CS/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q1DXwjwZ; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q1DXwjwZ"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c2e5e090746so108808466b.0
        for <linux-serial@vger.kernel.org>; Sun, 11 Oct 2026 12:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791748668; x=1792353468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZtyEZmwj0f19Lpw83gnqEqbS3r4hbHydMWKTWR/TdRU=;
        b=Q1DXwjwZx0ewCGYTzlldBhwAvBE5AFrZmnFiUCBx4qQIm27xdFd9CxirUs56NxYjun
         Ur4oHEYAn7SBy3slGVOLiEU1iGdv5fAE9yo2QbNaAkaGYMQIYpz8VA4+5jBObOTkpIbQ
         g1gf07nXLAGnZEFljdbRhALTcYoJB0TQQoFM/pwlVtJ2O4UW27SyQOjwy/Frb3+TMrpo
         oJVh2DRQkq4zP6IVGarJBh+/4Ij35cn2xEoJ1cJ3r2Fu2lo1+fh6h/Ci2+lF0iCa1sRG
         jwoE4rpvY+suqOtbQhOAx/jGZTIGKLOmg8PRDB+ZKrs+58Lrby/s4bixVTkt1OBUtfJV
         +bzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791748668; x=1792353468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZtyEZmwj0f19Lpw83gnqEqbS3r4hbHydMWKTWR/TdRU=;
        b=RLlqYLxiPwxxHCJTzfI0tigt7EirH8jwCMe5731HysnI88Zg6O9Njih2uv7X824WOI
         wD4ZMDBLTUhAx31YXVPEsgDlBts0/hyBUJdd2/ktn3ixqE8CrtTe73D53EehLeIgpoIl
         HWzjQQuXMvKLKhwz/fOqRDaaym4dbAp12Bag7VigHPlx6Aa984AORzR4ahaFt1DkZQ1q
         riIQI6n2R+TgJcJiMK8yLK6cVTMcKnAvv4nniV+85ybk0jGNGdiAEOW/5j5tdroLGe0N
         2LZHso8AFoLbAPYJBz3HODFctB0D6Mxo594tJEVjFo17bilou+mqacgjV/BbTEBkC1dv
         HjMA==
X-Forwarded-Encrypted: i=1; AKwUvByoFymFKW5iKP8aqZQl1CHHvFGxu/i5DKIHyWBCtXhmeDov5BwcrKMkB9Ez1Oi4KNAtnfUYPMg1RL1BkQM=@vger.kernel.org
X-Gm-Message-State: AFq9FYJud4iR7iRkPyGsspJQIpckueOxfXRjDFXEkJytdP4vkjxAtz3g
	/2oEN6D5ksdoZUWKxk90raZc25IKvSqli8fRKvS3DGvmrpHCZ1HKcHxY
X-Gm-Gg: AYBFou1MXnHFXmwYGITIcg6rU3Ka+oMnexo/tAqwTvbItwvr/9pF4gsWK8OYrPVM+LG
	aUX3MSIyiOdPZd4wQyj74eChQmfNlli0q6NEO/dr96epsPL1L5W4MR0IvrMgBxEtG9LaX2sqaC8
	4HIJsu1bMxe5lOlqxQhwOeKzGTvc01HwQ6Yp9W/G/tjD20jQLRyiWqpATIiSuesZsua8PC+wnEw
	VawRDH5ZHqT45DGUN5G37sDwq627wKFOy7Kc/z+H3wJj9EhVGBRdYLvbjGPl+Isrc31/CS5T5Eq
	7lFO2EfIsgiRzcwLGmImrTKzEoANWrKOU07ufQ9StbawVdYVCQ4CFzq04AU6f6LTWIUPQTLv1h5
	itHtOpumtlpDnd03XBR31VaeqdnjlZ0K79/5W/vftWmYtfsNhSRMB4D7i4YeHzlKVJyU9OPiT/H
	lZuFywxEKexxER+4640h4s3+fKK6F0uUOzuMI2l2zlNmfqCgDeeZ++yERKZ/TqQeyOntSdL8v8J
	UK5xhrwZ3nipYNcqRH72wjUVjdURVnVKq6EF0eEYORMIxfNQso=
X-Received: by 2002:a17:906:dc8c:b0:c31:8984:7fad with SMTP id a640c23a62f3a-c31a9feb114mr762553566b.15.1791748668114;
        Sun, 11 Oct 2026 12:57:48 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c31a9a3ae9fsm381315566b.26.2026.10.11.12.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 12:57:47 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: davem@davemloft.net,
	andreas@gaisler.com,
	sparclinux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	linux-serial@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	krzk@kernel.org,
	oleg@redhat.com,
	linmag7@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH v2 1/6] sparc64: return from the generic clear_page implementation
Date: Sun, 11 Oct 2026 21:55:53 +0200
Message-ID: <20261011195729.981243-2-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261011195729.981243-1-linmag7@gmail.com>
References: <20261011195729.981243-1-linmag7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

GENclear_page falls through into generic_patch_pageops after clearing
its page. The patcher then rewrites kernel text on each invocation.
Return to the caller once the clear loop completes, as GENcopy_page does.
This affects processors using the generic page-operation fallback.

Fixes: 6c70b6fc7b6f ("[SPARC64]: Do not assume sun4v chips have load-twin/store-init support.")
Cc: stable@vger.kernel.org

Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/sparc/lib/GENpage.S | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/sparc/lib/GENpage.S b/arch/sparc/lib/GENpage.S
index c143c4d1de3f..6ce11108e143 100644
--- a/arch/sparc/lib/GENpage.S
+++ b/arch/sparc/lib/GENpage.S
@@ -48,6 +48,9 @@ GENclear_user_page:
 	bne,pt	%xcc, 1b
 	 add	%o0, 64, %o0
 
+	retl
+	 nop
+
 #define BRANCH_ALWAYS	0x10680000
 #define NOP		0x01000000
 #define GEN_DO_PATCH(OLD, NEW)	\
-- 
2.43.0

