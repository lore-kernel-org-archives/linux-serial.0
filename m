Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794956092;
	b=bDL8CBa9I2tMoKzbLR0iNJCosKh6OAPnrMfRmok74jQG8vujoPXVZh5Vakso/gfrXdor
	 WGbEFa3wKLoxZPUcm+ATgYpMG0bN4Z2RFEP16I4PsXkkJxNEJBW4Uijm2P4Gzi/gVpIt3
	 RdJ957+YvqdiGaRb+LjrT9rdWH0jZ4/5gX3fPmvYhp4FluN5c76SGBIasQTFcx/U9ZdQX
	 ZDk5jXWpDiMqhEmdfEu/sX6pb7udJHE3XmGiz5JWNdxEzjD9K8+Vw6H6ZwREwgNOkNXMY
	 IwoAiu4lXCi3wzpcDrM+TQJVcOo87XX9+6KiuiUvYnklKFcGTCJYriZUdcZ8MVd8DKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794956092;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=KVDypOQL0Ly4W8lmJ0F0GZTz7fcCsMYtNxpyUlOpXfI=;
	b=vVl1hwoi+9CeU6h4qwvGVRo/wfsD78JqVPgzvpPdPSFWy+uPa6LfqyxadcOGs0O4dbiq
	 MRGh7oJKL+0Kor00VAVko7AmubSqAhhju9IrPAMuWvRLWyG4DjESnBEHqowAUwg+SbOMp
	 WgftonquKP8sfK+26nciA0xVlnRkCaQ13QuQ3gheCBC9jhFIxLVq9uhmY88jFwJfq+N1w
	 lrmJwUaAdaWkkXQvWUIzmYXtRUtljAjo43FZcUHOXpXXOB48CgIOmmrptelzn9IAh62QY
	 BKaSR4HWcTrK6uhYM3YJc11c1SHMrNLuo22SsERTXeurhw8kOaVEF7N/gI7XIowDkQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hvm5vgP+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4604606A32A
	for <linux-serial@vger.kernel.org>; Tue, 17 Nov 2026 22:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hvm5vgP+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AC481F000D2;
	Tue, 17 Nov 2026 22:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794956092;
	bh=KVDypOQL0Ly4W8lmJ0F0GZTz7fcCsMYtNxpyUlOpXfI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Hvm5vgP+YWCoxpVohRWgrSQDSx0ZduiLgUF/9EkZXE+uFSPToV6crIUcfnNz3NqFC
	 JCvU9dYnOwfIzpLrr+Me4l/EH+F9BEtqe2anCXdvvdvmJZgWulS25ymWzQiebb66rm
	 pZMdGKkM0CLSeYJosYnEBfBzA1dgcxSIKS2Q2X0ZYP51cc9uekDVngUYNLwXQk0obI
	 TWDWbyBm2mz6qKov3OyjhXoiNL4cMUAYw45QFvRBy9qvqfX2cwAED4Ax61yFRetAE0
	 CFemSekXZTLK7/YQoRq/MLNYgR4JuXAgLPgYnncr68BQyIcJQ9LRf83b/tREUzua8+
	 /zaTjBZn7XbYA==
Message-ID: <sashiko-outbox-219768@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 4/6] dmaengine: dw: extract hardware-LLP residue
 calculation
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261117-submit-dw-dma-synchronize-v1-v9-4-7dc066ed0bcf@gmail.com>
References: <20261117-submit-dw-dma-synchronize-v1-v9-0-7dc066ed0bcf@gmail.com>
 <20261117-submit-dw-dma-synchronize-v1-v9-4-7dc066ed0bcf@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 22:54:51 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Serge Semin <fancer.lancer@gmail.com>
>=20
> Move the hardware-LLP residue calculation into
> dwc_get_hard_llp_desc_residue() so it can be reused independently of
> completion handling.
>=20
> Keep the scanner's LLP snapshot, descriptor updates and early returns
> unchanged. Only one transaction is active, so the helper updates its
> cached residue directly without reporting a completion indication.
>=20
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> [james: extract the calculation for the single active virt-dma transactio=
n]
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117-submit-dw-=
dma-synchronize-v1-v9-0-7dc066ed0bcf@gmail.com?part=3D4

