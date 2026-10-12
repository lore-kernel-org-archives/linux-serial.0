Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB32F34EEFD;
	Mon, 12 Oct 2026 07:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791788430; cv=none; b=BtbQGtaFUcvu0h0C2HFZrBIM8oKilpyUPMrSvzWfMQRvbc//VDKuH8G4abHrjtGbeYlhGre1pCaCpca3rATffrkqHDrB8X/uzGEWQlqWYGXKa7xBsa/TMZYkalFq2B8cCa4iPaixT146Q1QPrA3rXetgvruTDqCKgHi3zCHmKaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791788430; c=relaxed/simple;
	bh=ySwr7Gyc+1Ju3DMcog8zcobJoPNjJ6pNz7kAknVA6lo=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=XCML/sHWvFR0M2tX7LVT1qtgryagZymLjw9649lQB38UinNhaH4U9TYQSzNF6hz/4BX8wzwRi3SCNGydsqWUmhz0fF7rDUS2BBv+a7TFl652V9OSPzRofsmK8sj7uvCk+oywIIXGY/mjOdW4QnZdB6EQ7Y6hQskqaxrfvisiQ0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vkp0Vzyj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vkp0Vzyj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59E901F0089B;
	Mon, 12 Oct 2026 07:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791788428;
	bh=ySwr7Gyc+1Ju3DMcog8zcobJoPNjJ6pNz7kAknVA6lo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Vkp0VzyjuLoQqFgyB76WakgMECgBuayiM2Ed+EVp1uAucXt6kMg+nsRaRVpzXaLcd
	 UedElRR0XBK0EBX56SQGFrs85/PUC+TY2788z8RbxT8wWttWSozaES+zdOhyC30V90
	 Z+8zd01Txt2laRTbWlrQuG0iZ2+kG82ADDmDhAKshUHTKRhWDsPD08UMlWXtW8sb+k
	 pOnf2edDxA34cGPaKuF6WU674KjWErQOTGgY9jku85EQQMq4sgPH/FU0C3r2AsZ81p
	 qE42YcxDqqBRGRo7QUJJXGpUjmkP7OcxF1F4QDtI1JgUuI0tCKkofnovqigxO6AUD7
	 NIilZNFlqMaRg==
Message-ID: <sashiko-outbox-167763@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 06/10] dt-bindings: serial: Add Cortina Systems
 CS7542 UART
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fil Dunsky" <filipp.dunsky@gmail.com>
Cc: robh@kernel.org, conor+dt@kernel.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20261012-b4-cs75xx-v3-6-0e0d17a098cf@gmail.com>
References: <20261012-b4-cs75xx-v3-0-0e0d17a098cf@gmail.com>
 <20261012-b4-cs75xx-v3-6-0e0d17a098cf@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 07:00:27 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> From: Fil Dunsky <filipp.dunsky@gmail.com>
>=20
> Add the binding for the UART found in the Cortina Systems CS75xx
> (Goldengate G2) SoCs such as the CS7542.
>=20
> Reviewed-by: Linus Walleij <linusw@kernel.org>
> Signed-off-by: Fil Dunsky <filipp.dunsky@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012-b4-cs75xx-=
v3-0-0e0d17a098cf@gmail.com?part=3D6

