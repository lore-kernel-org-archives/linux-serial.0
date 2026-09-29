Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2D643713C;
	Tue, 29 Sep 2026 06:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790664234; cv=none; b=qcdIilk7pKBwZ01QRlKQoXVK/CraBLfUJuZufl9luDiUxnR6r73NZryUC4/Br9Nh48X0N/y391dfSF0mOifY41Y+30sMXPX6TJ1uxndpDu1CtF+fAbPtMyCyYho4x3MXweb+/dL9QgsXKPyDjiuI3v+ZP/8gLi/Gqvp5S1lrGW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790664234; c=relaxed/simple;
	bh=6PbmBTGfz8Mig5AQk5WhCjdQCPWzxHeythlwV9JGZcE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZgLH67tRM85Aq0E4BU2gKxy5UgZtxsoQwLVQXY3qd9eViRdVRJjX15TtUCLnHFvFaFJqDatUteyEbznaFrx3Y8MQeIjWzq9EiYdpbLoltV1sPlTPs54EVhlH8RrW1YtfwjaqCg6uWeGJFwj9z4zj6au7/8D3KGAP/C5a+ShKVYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H4qBTO9C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H4qBTO9C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0242B1F000FF;
	Tue, 29 Sep 2026 06:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790664233;
	bh=6PbmBTGfz8Mig5AQk5WhCjdQCPWzxHeythlwV9JGZcE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=H4qBTO9CvCGv14KR5qUUCQkCb6RXIPcF9ddRXO90vFoxonXwagKGJ8yQslPt+8hga
	 3Jf5yy2qnBoEiZImHyQUcp7a6QkC+/+N8R8iZIxGVdtWQClmxISIyXOc+PFVv6oHoE
	 z9L6GSm3dIOvuOehKcqPAlkwIavLGNsA6YSJnhTTXIZJcU452IhHU/BUPtSZeNYDMy
	 r04xYxmiUGYlRr9Q1ziYMv+wh5VjPdD/fiJ9pJrPLCifXi0+R3chJPVV9gcstjc2Xa
	 dbivy3K+t+3kLHTeVGYOyDG/PXGOePIOXeG6CZIWB43IvcPG0Kta/ekRqJe4onz5m8
	 +U5YXHIOUXzdA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/20] dt-bindings: i3c: dw: support up to two reset
 lines
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jisheng Zhang" <jszhang@kernel.org>
Cc: devicetree@vger.kernel.org, linux-i3c@lists.infradead.org, linux-clk@vger.kernel.org, linux-serial@vger.kernel.org, mfd@lists.linux.dev, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, robh@kernel.org, lee@kernel.org, Frank.Li@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260929061417.20733-5-jszhang@kernel.org>
References: <20260929061417.20733-1-jszhang@kernel.org>
 <20260929061417.20733-5-jszhang@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 06:43:52 +0000
Message-Id: <20260929064353.0242B1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> The Synopsys DesignWare I3C master controller can have multiple reset
> lines, such as core reset, apb reset, and dma reset.
>=20
> Update the DT binding documentation to increase maxItems for the resets
> property to 2.
>=20
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929061417.2073=
3-1-jszhang@kernel.org?part=3D4

