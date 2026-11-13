Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794597012;
	b=WTf7MjrsIy0m/o5/NsG+vg24gDhaiP7puqzO62R+bjs99Zvi/UrZnexzHq8qIRIiNV1I
	 XCeyUCeL7fOSQyi78sNZ0XrNQ+HDCe3YUQWkUXNNqZu9gdlIUGpuFLoxdzFWqlEjTW1K0
	 yNfx1ouFSnWatnvmRUjrhoN+2JEv50QR5+ET+Iqw5I6TR1KOhvvHBmyjMwYgfp0BxqrXi
	 2MjXh4Mwq4aJBOe9TREPNynb8lstdnA+Ipkma0TReWZHrDKM/0shdFro5guAdsen6dxr7
	 McrolrRQD8AwlGUAwL33qCReE4lTzk0bQkerbr5BxkXIjk2c3BqXLjDAXGaHK1NBp2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794597012;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=9eu7+A6Dq3TnMhJxAYj6AMvVIP+S1JH/4TLh2YjolD0=;
	b=jusLkJjBiNUQcIJDGnNV6ZrPCO+dgOkn0Nce5cEPAAjX/mrJzlpD2JP7+FZI9YQI//vg
	 z3g0Tjw4I659tsVourqgGm/uSmxgydfI4EoNGBdJCP2JmcOpo7uNJyH7tN7v9w1kHNZ7B
	 1KTntavh3BfUmP0US7hyUPJi/Q1Jg/Na7ayw0ep3IIpkdBLSs5P1qVUWAVMdEN2fOtcFz
	 KrLFWmrOwpqsrrB6X2VyjWGjLL6jwWQGrNpPihVwUFq/ww1RR+dvgf5+WwcYAhcens8BW
	 BUwCwRuZa9+G+oFRMhS3OICSX2P45ZhnEjk0NKRPdi4cpGLTxMglqja6M7Hd9CjI1KA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y2oo7qKi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661BA606F30E
	for <linux-serial@vger.kernel.org>; Fri, 13 Nov 2026 19:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y2oo7qKi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B0501F000C4;
	Fri, 13 Nov 2026 19:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794597012;
	bh=9eu7+A6Dq3TnMhJxAYj6AMvVIP+S1JH/4TLh2YjolD0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Y2oo7qKiZ2JEXH1NR+uWwg0OH5JErH86A5x5W9ejT9Fl4qhkPNXjAToqYCim/ZCLa
	 DYVA9h3mX40H0sg9vI+/iT8+2RcL+Hz4dqer0DaEbL+eNst+3dAiPBW5cltmSq/SqC
	 Tf+qrsIXBGAEgojjDBFsfVk2RAgVh/p1jYuoig8tYAA6U7R5XTq7gQP47Lta+6pqT3
	 lnZHr8VA4cf62/o7xiAjtgxHQPU5+8U67qhJ1Nm6Rr1evUaN1ASJooMZVZ/CNMGptf
	 AvM6WG8v945l/jZhq0A2oq7KWzFSK8X0cBFZiM5Zwv61Q1S4WR+f8mMm7l6omhWskB
	 6kLYsZNg1MpFQ==
Message-ID: <sashiko-outbox-213514@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/9] dt-bindings: serial: mediatek,uart: Add
 compatible for MT6895
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexander Letuchiy" <asalde.le1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261113-initial-mt6895-v2-2-4ab0aa9fa391@gmail.com>
References: <20261113-initial-mt6895-v2-0-4ab0aa9fa391@gmail.com>
 <20261113-initial-mt6895-v2-2-4ab0aa9fa391@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 19:10:11 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> Add a compatible string for the UART of the MediaTek MT6895 (Dimensity
> 8000/8100) SoC. It works with the existing driver through the
> mediatek,mt6577-uart fallback.
>=20
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Alexander Letuchiy <asalde.le1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-initial-mt=
6895-v2-0-4ab0aa9fa391@gmail.com?part=3D2

