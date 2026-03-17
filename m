Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83EA3C6615
	for <linux-serial@vger.kernel.org>; Tue, 17 Mar 2026 12:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773752338; cv=none; b=qHXE+ze7s5iPfOQikk9Yy7bhfV2D8WiPeRBlNvxTtGV755JMENUWyh9LLfYGyQMbsDk9KQNi3MwFt4wD67EqnPxpvDvAXXypegaL83Ac7d5ixff13BbipyQwqmoO5YAYjpBSOMoQ/pv8lcj0q8rhMSkm/gzs3n58PDMFFDeETsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773752338; c=relaxed/simple;
	bh=c4xAwo5IW0e5wp1m6dG8x6LWc1bZ/a34JAzgjyVUPYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fi5zjKbeZ5RoXLdaJuoTaB3TatqF157IpqJTDEjXLH8FQUtG0Fv60F6VP7sAYzUr0MVL2C5SZN8FU/SjPmqvpbvhkecGL5xhqhMb/zX+Yh22U6Syq2uPePDjn1HMEPxDusZ9iqzZkF31iG1yi1vGUsPcz90eLUqXzgWkwGyNFX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DyPD2IEm; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DyPD2IEm"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8296d553142so2647458b3a.3
        for <linux-serial@vger.kernel.org>; Tue, 17 Mar 2026 05:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773752337; x=1774357137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c4xAwo5IW0e5wp1m6dG8x6LWc1bZ/a34JAzgjyVUPYc=;
        b=DyPD2IEmtnqFm21rbybnqEfAK2xvR5bOzx3FIXj2P53LxyYZPTbGeq159QE1XK9WwQ
         i1pKRVYH97bLq2VchFvC+Azpy4fpSvm9ctcQHjMEMk4PGISVTyAPidaPU1edhL/gEmqr
         6IeKfm2aGAXc8awVL1fzqKFtJhVEggJtsaCUKxSn/L+Iq/pRKTxZX3CH2QmUQ2FKz6A1
         PB+lg5/cnnNubXUTGyt8p5cxctR3I5HJcp/E84YwAzp+JNzYHKH/kI88uPN1L2Bp6pi5
         dLjjYzDVZ6xNrjyKTmQkfCpS7N7AeVZdxPL0KZbBc3GhIEgqG4rlRM3kmFE5VdDF+UMc
         O8Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773752337; x=1774357137;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c4xAwo5IW0e5wp1m6dG8x6LWc1bZ/a34JAzgjyVUPYc=;
        b=mt9zCwDWjl6Cc+xZ6D2KHY8OQgsWI/5m6ZIIvnqm6FoR+/eyzb0YBuDwRIJC5sa2WI
         N6avuYrDzpejKLkhXsdqNyz/mJYTg7VGMtHMoHc+0Yrlm/d/0waKkPxY437QlRyiAo2W
         zU5TeRp5Lq6GCcz5MGveYi8reTmPp12y+H1axiFrK0SpAb534iwd3lKEwqxyR7iTimDT
         yM52wppmShiNNrblyZuT0Ea3jvQfxDWyD1QJUptuhRMHV9GLRoWfEbp5LuQHIgwXp45f
         UbooVYoYRF33RfdGiC3eOC9K6M0Rw7ls+7nZyvrRNu9x2DvWYxXt3ryg9YGarRFZTdXp
         K9Ng==
X-Forwarded-Encrypted: i=1; AJvYcCVsZuARUSJ2wOZM6YWDwzB1C0buo3f++3+wtxMKtE9MEarrcPJ4P5CmbXiA8iBmwRYO1TZLdQtKieelk18=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3WgVXrxD6rp++U+2pKsK1rysvp5q8g/+8MgGpb/1xL6+MU/Md
	z13GrnOhRZeuFk3eBJy7TgMwBkwdcps0uvO2Esy6d1+jfhzvVUCy0/Mg
X-Gm-Gg: ATEYQzylqfO4+3eEUMltH4VzaQni+vMjj5SJCj0ZmCnA6z4btLZUPs7PR56zVWgg3f+
	8vJBccLy2IbD5xdgcGA9ZZ2vK8d4+50FnryWcpOjtsINN0NDxtNYPIm86Q676xB7IrnLI8zF0n4
	2Ymt/NHKpvVuxGwt6oCj23Zj525A63zQw2hsi4/E3XZOmbVsU/d3adxe2LnK/k/H2lbo4oH29JA
	VfU4kDXshvRD+BFqxlPT+myWSyYkFC4m5+WNx8k6pyPBQz+2ERqR2pzDO6K7MNDgiprr5axyvl9
	tAgSte5QwjVcX9JG88+NoV6YDv2b4ui8U9F9AZSGsGn68UoICND9jOlb52yGjJcq3zIPh6weHzp
	/qs+gA0dNc89YTOG3GB/i9zshJNr8enVzHqqPDJ3yeqUeHM/ijgUWL2IUrEr+Z40UesRxpY4KbP
	A+sJ0vtGnUnFtTccdoYazG79igJx57FJxc18AyKkz+A4xndCrORLTHT7UOkg==
X-Received: by 2002:aa7:88d3:0:b0:82a:fc5:fb81 with SMTP id d2e1a72fcca58-82a19702d5emr14986999b3a.5.1773752337122;
        Tue, 17 Mar 2026 05:58:57 -0700 (PDT)
Received: from localhost.localdomain ([2402:a00:163:2ce9:7027:b0d7:e473:38fd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a072418e9sm17574984b3a.3.2026.03.17.05.58.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 17 Mar 2026 05:58:56 -0700 (PDT)
From: Ajit Singh <blfizzyy@gmail.com>
To: quic_vdadhani@quicinc.com
Cc: linux-arm-msm@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ajit Singh <blfizzyy@gmail.com>
Subject: Re: [PATCH v4 6/6] serial: qcom-geni: Load UART qup Firmware from linux side
Date: Tue, 17 Mar 2026 18:28:49 +0530
Message-ID: <20260317125849.5825-1-blfizzyy@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250503111029.3583807-6-quic_vdadhani@quicinc.com>
References: <20250503111029.3583807-6-quic_vdadhani@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,
If Linux (HLOS) owns the SE, allowing it to change the protocol when needed seems like a better usability model than the current design.
