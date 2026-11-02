Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793650118;
	b=L4+C4Ck0KaUy8TBwfuHL2Hp28/mvGsRAVFddf8mc3Gt5swgyuG94oGJcWz5VsXCHqBcD
	 eHUn6aj5Qzrfu4vngOML1SqhK3qudtc7HQCu7X2rDvk9ZhfEAN4xPo+GOK5w3AXdksccg
	 iAIjHlsN+M+1EFy0/WpYB4rCj9MJ+l2FhnI7tLl76axzMbRFNnOOFcEx4ASBjQRHeL1mO
	 3tTSSKy2SHm46D1hhZum4+svaN3PbRK8SUDVOfx52mxSCc0lytjz6lvv9xYKiUCFCNf3A
	 ZIaBraGpfiaPOlpxtM2OYWAND43bS8JxQG9w9nXg5fG1ewqYgYYCdmEToOToVT5SlhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793650118;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=qM4fDJ1q3N2fSPKH6doLRA/AvgKibPwWD3rQIcGl6JQ=;
	b=bzjEye1FiPDIVKuzhW/kSboJOtAff4EGRIzs1j8XspW0OoPLWIwfOrRkfa66sk1WtyER
	 L0y0nNQexzGBMO4Uvswdz8Kj1IYcyBJSn+OwVV/oa9I8SOsVHVkkZOQaowpvXmnN+7IW+
	 xZSJuUzdXs/py2/Lg4a37KfbdVZtqgkx51hxDRhGF169uZ5HmaWTYqLBYBuPJy8BsU9SQ
	 6Yia8EiQ6lrPv9krTfC8XIKh/KxDIl56cd74SLyn62DXoyBqIwqPDnBS7tV2eS3Y6w+U2
	 kpTSHKFaylqi89Ftf3KXXAv6vlci5HCsaP5byvdr4dTqkaVmPx7bkH5mdIMgGMtBJiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FVeaZNSq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1629B606A326
	for <linux-serial@vger.kernel.org>; Mon,  2 Nov 2026 20:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FVeaZNSq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F8361F00A16;
	Mon,  2 Nov 2026 20:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793650117;
	bh=qM4fDJ1q3N2fSPKH6doLRA/AvgKibPwWD3rQIcGl6JQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FVeaZNSqlobrg5t2xRJgoH1BTXohj7p35aIwScuLNm3GyC9szFOG8kz4JfOv+nT9a
	 uL3KJ+iIRZgIliS3L+s0LCDAVlRGMG4Izm/fZ4GRl2rMqozfKpJdlw1WqLirADdaX4
	 5Zltl6e7bwqt/9+KvVuLdmNVhKioHeE2zYg67ml3ZFjiuNcH3FBwAZ3JTYD4/C8OUR
	 9ojKZAT9aZ3ATbEiYNvh4dYunn4U8AdKP8cDNAbXq3xxLLec3kHpz0TtkrQ+mheNXX
	 3gMpSZCrDqlfaD5QnQR9Nd/7fhyp4g8sxmA1X+lRYTdJheE7Y17cpB+WZFloQIAarL
	 qbvg9nK0BkSQw==
Message-ID: <sashiko-outbox-194066@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 15/17] riscv: dts: zhihe: add Melon Pi V1 and V2
Reply-To: sashiko-reviews@lists.linux.dev
To: "Han Gao" <gaohan@iscas.ac.cn>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261103-a210-scmi-v3-15-ee6b31580808@iscas.ac.cn>
References: <20261103-a210-scmi-v3-0-ee6b31580808@iscas.ac.cn>
 <20261103-a210-scmi-v3-15-ee6b31580808@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 20:08:37 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Han Gao <gaohan@iscas.ac.cn>
>=20
> Add Melon Pi V1 and V2 with the UART4 console on GPIO2_0 and GPIO2_1.
> Use serial aliases to preserve physical UART numbering.
>=20
> Signed-off-by: Han Gao <gaohan@iscas.ac.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-a210-scmi-=
v3-0-ee6b31580808@iscas.ac.cn?part=3D15

