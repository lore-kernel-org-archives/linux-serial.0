Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961AF3D5227
	for <linux-serial@vger.kernel.org>; Fri,  7 Aug 2026 08:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786091844; cv=none; b=MfhnVskPjh+Sde6zx3keNoxwuBjrm7oNfAV3TV8+adNB8VMxsMre8ITDxkiuoQYEwgxCtj9b5hWFU1P2NNvg707RqEgkVhLeA3PKPV+GSVq52tuyboZNd8/dBD+Nr/cGT7RfVWLMuHoxtuBTYiiZjY23BR2J7407F05E7fjlU1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786091844; c=relaxed/simple;
	bh=fuFEj1OU+QhcCZyLvfuNnHiX6rf0ZBxSPqBHjTqQNjI=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=QGSRDxQmz/vlLXJ0J0xa7Fa/1eOH2cUyfr7Prd+Fly292r3p/4RKSBF7GoU9bkL2nueUe5JWiAYt3kT4Qgzhs7wVJaP/Dt5bvS5ofPKXlDTUfNwHKIYDIFSosc+itiWB6FB1L9HbPbv8XJtiPu9iBBATsE/6630Vxdx++teUBsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=TptPmv1C; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="TptPmv1C"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-493b966dd74so18843895e9.3
        for <linux-serial@vger.kernel.org>; Fri, 07 Aug 2026 01:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1786091838; x=1786696638; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=eGMUF25P693ePk/L/oUapnM3i3tck6ovRZHhcpx3Kbw=;
        b=TptPmv1C4KkEXtl2QxRW+JJ73QS3sCexm1chhPBYZCamhTXdAPxLxXYHfMni9GBIqK
         LtbrS1q6+Pcdz7tC7BZEvrO/R5Yimz08XaNiw9Lx8T/lcQ4OZcjqHaGl2kd9Le5Qm6qw
         20TfYlBj62zzDiMsu4TKZ9UI1UpJ0ENTF1sbcjMJelo/ObLGT1uSnxxSGpkWmG2TEP7r
         TNlP1Ah+oV7nwwpD9KsXj3zXBprkG/WJQT6Bo4V++57WXUcxZ9HIqD0HPsC1r4x1PyVZ
         oM/0DA1sXApj8MuSiu0Kj3+SSe2oH75lwCvLNFuApyhYpyHUS7RC7sxke81NOk31wbpQ
         5/+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786091838; x=1786696638;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eGMUF25P693ePk/L/oUapnM3i3tck6ovRZHhcpx3Kbw=;
        b=L1aqsCTLncKveWixXhemDJ82suEy19BgMsopzjTtCYfCLOx4MY3C6kq91dlo1x8ZiO
         m1/7M5QN8g1WfGP7RfC9wHsxjOIJnxa7m2CZKc9pcTRsOS/bwCNxCk1lJJ1CIoFWSf53
         oOOKcSMr99WCEjNLTUkacS9mW9pPxJZCzmDGIkzy5Aqu1stabApD4ZkQ88vqE6p3Q1W1
         gf5tRRmTyNVyaGm9JM2ZVyiffMBsa7Rr/olksfNQZ5hMd+yvmpuv+pxUxr/+7S5qkJes
         0j3h6GU5RzK0IaEZEo1D7nDvsrsto4++Tl9vWN1NKHBKaXJSNxMN74cXaTCvCk1ypXXH
         qtmw==
X-Forwarded-Encrypted: i=1; AHgh+RpLfNESjSui0jGz2WdkUuPe+KSacvIk7JlpncoCNxuBZu1fTram+dmK+4b6xRZum2llBUWwdvPNreZlKt8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBIXZsZP3c3jbJFElrkDo7krzhuqPHa+gCwyTySnmMISJ/GMy/
	LSAGZaF5pvW+a7OfgNLT8LWI+hmHnZM+tSYzCPHYvJVPylwjjW5Q5+qyEPXBY0OUla0=
X-Gm-Gg: AR+sD118ppfjXyJ6WBcnIxMg+U42/KWvI3q+s5q+aluFI8oaT4dn577QDdoz48YDlc+
	SJshKd6E0DW4r6nY90kt4w+nWW4QRJilgHu51VU2riWEb+IVRjPfZaSeM34xuC4e/RIUGXLT6ZG
	t8VGPcfjG1tcxdPFFlV33u+i2rFH9wfbTi4m7GeUn3gdd29hgvPUlMJCva9hHMvRRNyCjLJ1nWo
	zCHCO3sS4JQDCcUxQ+JTYBAr/wtH/gosv2RYrLEj984t4wdyOaJrwlvyaZcvpARmAQgxtQiDSNU
	oVkQKhWU8i7DaOJ9h7za4YWWtQrIYDR3zAEvWWT+7mV8Wl2zfi+106PEuIDQjjJp8djUTWskQOk
	tYfF2F47S7wN8484wkmQlhkf9cfxiCxDzzHBDXXZJ2syhwTO63D81nWaeuY6gZxege+L8N+lN4Q
	n13w6nN/tSxscgpCRAs1efyRHStjyQVOK5Qbu4WVHxT4/+zP66xl56fmo2OjR+BUpVmxYojxI=
X-Received: by 2002:a05:600c:3226:b0:490:e5c1:b8bf with SMTP id 5b1f17b1804b1-4994e7ce0dcmr191510415e9.13.1786091838712;
        Fri, 07 Aug 2026 01:37:18 -0700 (PDT)
Received: from [172.20.10.3] ([2a01:599:843:2744:7f5d:3df0:76c1:3705])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995e9e7171sm17795195e9.1.2026.08.07.01.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 01:37:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5 5/6] ARM: dts: aspeed: g6: Change vuart compatible
 string for ast2600
From: Tan Siewert <tan.siewert@9elements.com>
To: =?utf-8?q?Gr=C3=A9goire_Layet?= <gregoire.layet@9elements.com>
Cc: joel@jms.id.au, andrew@codeconstruct.com.au, lkundrak@v3.sk, 
 devicetree@vger.kernel.org, gregkh@linuxfoundation.org, 
 jirislaby@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, lee@kernel.org, andrew@lunn.ch, 
 jacky_chou@aspeedtech.com, yh_chung@aspeedtech.com, ninad@linux.ibm.com, 
 anirudhsriniv@gmail.com, tan.siewert@9elements.com, 
 linux-serial@vger.kernel.org, mfd@lists.linux.dev, 
 linux-aspeed@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <d54bfe689e6a0f318961588ab6b72fc2b09ebb47.1785932211.git.gregoire.layet@9elements.com>
References: <cover.1785932211.git.gregoire.layet@9elements.com>
 <d54bfe689e6a0f318961588ab6b72fc2b09ebb47.1785932211.git.gregoire.layet@9elements.com>
Date: Fri, 07 Aug 2026 10:37:09 +0200
Message-Id: <178609182923.193353.5571242599516025969.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786091831; l=355;
 i=tan.siewert@9elements.com; s=20260527; h=from:subject:message-id;
 bh=fuFEj1OU+QhcCZyLvfuNnHiX6rf0ZBxSPqBHjTqQNjI=;
 b=l/snFEuA6s9C2vYf6o5nTOQ8zlqd9Il9CufwGf1MkTpOA+4+PTdQ2n5jUh9glDVuzfjCNBQVJ
 WDZc+yLTygNBpO/pif+3n/9h9ZDIVzxwiVZwcXHim3sLopjfT4uTkcv
X-Developer-Key: i=tan.siewert@9elements.com; a=ed25519;
 pk=ORQd/zQf+LsAvJGXP1CjQwVO6t6iEOGq/eGUsmRVTG4=

On Wed, 05 Aug 2026 14:19:52 +0200, Grégoire Layet <gregoire.layet@9elements.com> wrote:
> Use the ast2600 compatible string.
> Make it more precise and enable specific ast2600 properties.
> Still use the ast2500 compatible string as a fallback.

Reviewed-by: Tan Siewert <tan.siewert@9elements.com>

-- 
Tan Siewert <tan.siewert@9elements.com>
