Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793650124;
	b=usKNw9JczgFbN2mtebX6SDDEmAqGbJFYSkaaZTRxK11i+D7nBm4P8FMQaj1l+xJSFhLk
	 Amui6Ru0Y4P5lkJJQZAnnfaOyMRwtH3bkUGNZP7BWycHhevM6mrULvXdX2+c35k7okOwb
	 cUf1clh2J6CxbW12Q/W4C7SRWWvaPQWZ34FJ6pOP8kV3JmQDVXf96wxhNFPk4UCVJ+5DT
	 9a5M7BOwNGlJqWvuEuk88lCy6C6skNOmZVKI8FC1Y6Dpiz5dCYPy9Be/5MFTHpYVV59Zd
	 Lo61XByDzQkRUy0Z0n+nhSQ4MIBwbhWz0BUurMNqfBP6OWwiUa0zFUTPRrSi2hMfTgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793650124;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=m9gBUUUwe/pzvW4IHPDlohulvkGpr2XV+tOODSaOpTM=;
	b=UFqEuqv8HPxkQ/WkW6+Rkg0dfNR3DrM5GpJac0v/J1x7993QPiA9waR1UrLNXFA5okKJ
	 njeS7p+Xm4mM/pxX+d93ayseDH/B8SdlQwr6NlbuiRbcpSRVMcuNv/ALyunr7CXqyAKXW
	 K1zcJwuezJHw2mY7tfc4VcB5H9WJwPjZ1rIN0ZI7S5crUKV8vxwpCt4jcVHAJCAv8w9TV
	 jNgAk5YY/vup3Z5NvnyKbeZ54U20Uvwl8uvGsFjVyDN2zEMmST3FueWIF6jAmSlf6j43q
	 n0KmErdXh5ADgIN5DfLwTDJeghlNFoMjZMxql5q5HQ7Fqz/bKz+AY/FVnVSQAZ0Wl2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jO6YgfiK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6AC7606A324
	for <linux-serial@vger.kernel.org>; Mon,  2 Nov 2026 20:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jO6YgfiK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 373A81F00A17;
	Mon,  2 Nov 2026 20:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793650123;
	bh=m9gBUUUwe/pzvW4IHPDlohulvkGpr2XV+tOODSaOpTM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jO6YgfiKLpz42A6M2onjtxW5Xf2rGKNjNuzeqcB8eGe0FUHyDC/2XB4Tma27t/A/o
	 gesMoU9D+iObkVK4oHOGXwU+ixYWc6QPouz546pspYnaZHp91Tu0SdRc7H+F88LM1V
	 ZQXFF2aemfXnePqOfoUatEv/c5ZPyMiZYOzSNWzwJh7q8jz4xrXcC2BnLr07j/Jzk4
	 HZCzcaw2oa1jOYmzYNBLlFLXXVrs+HM0ScCg7HXva+Aizs3SAmXOVQJUTTGWlLLCFq
	 giNonN37vqzViy4ANW4m5WIqNgiSmdQvGb+UDg8+uQ4HQrLAA+UNLDaii9Vmv2Xv67
	 VNvkkGTg9s5Uw==
Message-ID: <sashiko-outbox-194067@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 3/8] dt-bindings: serial: snps-dw-apb-uart: add
 Allwinner H616
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261102-submit-h616-uart-fifo-v1-v6-3-25afcb346b0c@gmail.com>
References: <20261102-submit-h616-uart-fifo-v1-v6-0-25afcb346b0c@gmail.com>
 <20261102-submit-h616-uart-fifo-v1-v6-3-25afcb346b0c@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 20:08:42 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> The H616 UART has 256-byte transmit and receive FIFOs, but its DesignWare
> component parameter register does not report the FIFO depth. Its optional
> register layout also differs from the generic DesignWare integration.
>=20
> Add a specific compatible to identify this fixed configuration, retaining
> snps,dw-apb-uart as a fallback.
>=20
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-submit-h61=
6-uart-fifo-v1-v6-0-25afcb346b0c@gmail.com?part=3D3

