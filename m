Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C36347532;
	Fri,  4 Sep 2026 06:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788504662; cv=none; b=mQYOxzqS1ElNbAqbDkqUTD+KR9KPmbYe08IZ9FBri5XA5wPSsks4XTzUELrzmcDKqmz3JgfJSGMoZhjZZFchC1R72dPFk5x7WpimMgQZArUd3yshMBwSqX6+W6VpQ4JTkb+6AKweN/h5TjRvytIifNeiANUhktD1/0PZL9J+abs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788504662; c=relaxed/simple;
	bh=cUE/UoW8GKSxPB6x987bVpOits/4DN+rnFcZfpT8Z7g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Wc4TbzYPUynqV2iS9KXlRWzLmUdv+xA3ojN3/dyt4FFwxAJ1GTIzFpjIgjsnmXQ2fWg53sCh92FuOmblxTRRUqealOdeAF7frYJb65JhMNUnV8QvrDvuE8ub35ZZjjByn+KKHp+/CXbzn9bGqkBvMZbX1Xx9YBp1dhGZ91JHx2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FZ/7zX1K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FZ/7zX1K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1E3E1F00A3D;
	Fri,  4 Sep 2026 06:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788504660;
	bh=cUE/UoW8GKSxPB6x987bVpOits/4DN+rnFcZfpT8Z7g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FZ/7zX1KxkJnvdNATntF0ESzx4K7zeQh7y4q++M+BWv52vI34c0/Teu+v2ilpJrpU
	 BE/qZNT06B/yLmWTnHvLAdT1OR+U+j2kdV0PVc2RAYJGwAkYJYEehY1n1gJXmecJID
	 UQI7NDq9twVAQHNALvjcrwLvKKT4p+aPdlxLBsft6rWPCL60RgrosBQFIuk9IyY4Vw
	 6e4FRVT4w5iAhO+x3rWRM0hclTUtpWK6gaMDURdBj1YZmPjtgM9PHRzaHWFYhyncgh
	 +G7oLffKl8NfmXh8FOZGzh/UJuOp9qb8ph0zvFXAE9bZ9P+f8jR8oJrlxvGvqCQoYa
	 IsShF+Jmok+ww==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 10/13] pinctrl: ambarella: add CV75 pin controller
Reply-To: sashiko-reviews@lists.linux.dev
To: "Long Zhao" <longzhao@ambarella.com>
Cc: lee@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, linux-clk@vger.kernel.org, robh@kernel.org, linux-serial@vger.kernel.org, mfd@lists.linux.dev
In-Reply-To: <20260904-cv75-v5-v6-10-e918514cb3b1@ambarella.com>
References: <20260904-cv75-v5-v6-0-e918514cb3b1@ambarella.com>
 <20260904-cv75-v5-v6-10-e918514cb3b1@ambarella.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 06:50:59 +0000
Message-Id: <20260904065059.D1E3E1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> From: Long Zhao <longzhao@ambarella.com>
>=20
> Add an Ambarella pinmux-only pinctrl driver with CV75 function/group
> tables. GPIO is handled by the PL061 driver.
>=20
> Signed-off-by: Long Zhao <longzhao@ambarella.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904-cv75-v5-v6=
-0-e918514cb3b1@ambarella.com?part=3D10

