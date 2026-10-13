Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B574A49A5
	for <linux-serial@vger.kernel.org>; Tue, 13 Oct 2026 06:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791872073; cv=none; b=ViE+scxyQjHz6cYz+5/GTxYHe0WhbT8aM0YFJNzBajtahmtE6EkC5GsNysw+p32d3wvESf+Ybx20SFTADPvH847L2s4cG7kw+KBRLPpP8ywtVU0jX2YaZKpFF5y+Gv2GXeJKXwRZMlrMl0BNT8iyzQmHpsyTi2zmcivt+zeLqFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791872073; c=relaxed/simple;
	bh=wmVT/QkTlmcxVJCdtBlEwbmJaQ2bL8HxSq3m5TzkYsc=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=b083eKBvnVzqZbRqYkjVprC+YQWkFdLKHaNYazi+iaYjO4hnPIw0FknpSwswbbO5va13llUx3bb9Fhf2raSm0n9m2tUmdFz2i3vcA+GG1T1faRFqMX/DpT/b9mczg8/CYU1YA8SjCpGWu80BzlMOn2lT3A/qodLB+PO4o7Y3NU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jE47vYky; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jE47vYky"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBD311F000FF;
	Tue, 13 Oct 2026 06:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791872070;
	bh=wmVT/QkTlmcxVJCdtBlEwbmJaQ2bL8HxSq3m5TzkYsc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jE47vYky3hehDdHE+hpsFgIH/mE4yX5L7K3oqO5Iv2tYKboiwO5T3ibCAhrKGIFDZ
	 kazRzv7J70zcGQH8d4tDpTmqJdTvwEbF6rHHpcc0TiIUtGnlM3/mUkn9uKJWVP4nNp
	 o4/rwLXqtn2qqsBV1gZ53DOloJGX5Cp8yH0sev330m3mqIZvwa83AJVG6S1wpt4zwD
	 dUNGsoBT1+HcWbusLjuWfVDpMRPkMPe2POw3fvEFxs7kzRhyUpIfqwnRilWliBnj0U
	 0/iakvri0J6LVHIn/3KrNTdNQxC4wMViPTyxaeL+MQbcVfcZ/BBM3KIuWvJIoZqR1k
	 RWqFo1Bil36Pw==
Message-ID: <sashiko-outbox-169055@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 03/10] dt-bindings: arm: cpus: Add Cortina Systems
 CS7542 enable method
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fil Dunsky" <filipp.dunsky@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261013-b4-cs75xx-v6-3-37e8f3969b7c@gmail.com>
References: <20261013-b4-cs75xx-v6-0-37e8f3969b7c@gmail.com>
 <20261013-b4-cs75xx-v6-3-37e8f3969b7c@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 06:14:29 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> From: Fil Dunsky <filipp.dunsky@gmail.com>
>=20
> On the CS7542 the bootloader parks the secondary Cortex-A9 core in a loop
> that waits for an event and then jumps to the address found in a global
> software register. Add the "cortina,cs7542-smp" enable method for it and,
> as with the other release-address based methods, require cpu-release-addr
> to point at that register.
>=20
> Reviewed-by: Linus Walleij <linusw@kernel.org>
> Signed-off-by: Fil Dunsky <filipp.dunsky@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013-b4-cs75xx-=
v6-0-37e8f3969b7c@gmail.com?part=3D3

