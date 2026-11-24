Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795489111;
	b=gJqJG++6Z944Rb+tSN9SumDoC7v2UUqxAJg5nFRVWBF6+JzZ5jTxGqUqSIE26LNPyj4w
	 ht0QkYT1yw55krvb11jfpCk0xPYRqNFNCTe84dNWh96TweQTICmOnuE6GpSBUHfcjLypz
	 qccszYfp6oLGInBIZTWr9O0+AZ8jBwZcaz6xoeqN5AZxtG61GaVjXLhr5PjITQgTlmdAX
	 JwMuzyrbgenoCkNesKeBjN2O10dTBcRRQrH3Wv6lIKwRDHgr5IJQUhTdkRrUeLwtax3Vs
	 Pe8kGCn13/RRFVRwswvZFeYwLR4+Qf9btQLliVFmZpSWqxeaiRMUC2d3uoj0YL3nzeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795489111;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=mCoZDtDGDLbikjTyMXF4nXjvYC+ZA3pXNAR9kXgycLk=;
	b=jSB40gnn9zRYc/BlhOcl0oe/YPxaJzjpH/Ju7ZiahPOxZRqY9Vto4F6KAjATXTIBHsBH
	 xZDssV8NLjUgd4PxT85rfG5O0Awyf4dv06u8RkMDKaayJDJ/Y7BLrzHFRBSKs/6IYBLan
	 kfzdY2kysLQEcDbNOq9WTJCKI7tvQSMWl11QSAryOxCu6h820sJTXw5OdRE9bdPLsHjE6
	 0sGTXneqG1XmfOj6RynUOlAWICVmpOY62FDrl8PukIO2h4F0rtBTNksFaQKhbBaq4cQzk
	 xKf+VA+Uz7Hqt/ev1eQVFhcGCRVvDYvxW2gfsfKvXZ9sgTJC0SbM8m/iE9Dhf8BMgNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XGJJZ1Qi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6938E606A31E
	for <linux-serial@vger.kernel.org>; Tue, 24 Nov 2026 02:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XGJJZ1Qi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B20921F000C0;
	Tue, 24 Nov 2026 02:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795489110;
	bh=mCoZDtDGDLbikjTyMXF4nXjvYC+ZA3pXNAR9kXgycLk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XGJJZ1QijLdjAV/DaPt+r/7Uv8NUJOaKWjZrLoQ8wYCHa+/2JtCoWfqG7P+VC815O
	 cX6FLTgTonOHR0kI9/RD0gQnvf/BkHFoypJMj+rG8DBAsM07XVhwjsU8TZTRC5w1yT
	 F2wGkp4Uxhdfs9h/08q5coKuux3bA8+Uuo2/k9zUYM3SDc7KQTEZL6uEmtuT2Lx9NB
	 bv1F5TNNyf5OwBIMqkQ++Zq7MZWMakZF7U7+gzUYNWHHaOhSPdHUQDgaLhxyMCxOmp
	 PFns38i6NttgiJU9IOMQ+87VBLQJVWdIeO96zGl6YvjQqB2cH/9SI4TrJOvXm+IzVG
	 EtUSD2vINxfEQ==
Message-ID: <sashiko-outbox-230431@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 0/2] vt/vgacon: Skip blanked hardware scroll and fix
 VESA blanking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yu Peng" <pengyu@kylinos.cn>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261124024811.305592-1-pengyu@kylinos.cn>
References: <20261124024811.305592-1-pengyu@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 02:58:30 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

Sashiko has reviewed this 2-patch series and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124024811.3055=
92-1-pengyu@kylinos.cn
