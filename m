Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794827531;
	b=OpJywGDzIR1/XOGIzPQ9sWmidVzASivJVMjdKp4dhhhikJvLT+Sjck5No6sXMWRaog3R
	 wUUo3i5WQkYor8iS2f9V9k3SKdAqShkYHe31jejlXHXkYdW0oyXnDDjmG55qa0db8doOr
	 z/vDaOsueMSaJmL3Sm+GGepq+7TBAMu6jE+i8UEEsLeuHRn64NT5o5raTtgG8Vsappvnn
	 Le1lhlOiAEQC0Ry0e6/ioUBGsRFjnNoXqAHvlrOzV8R77obpkamzSwhBz44np84MmdnFU
	 SJnUGb1NDyNwDAlA7tfz0vO9bD4/KNU065OQibHXQaaNWjFHKWjuk3HMG8mMs3I+lVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794827531;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=T4RsKuMY+R4lB3WMCrIbjxJUl1h4usNKFNyhphM4NBE=;
	b=ZCjIcpczPTzNfQtbYENfupRQ7e5pL9T5gep8thagrNMJoE202J6rdzyoQo6Cs2BXks3S
	 SDR/3elHR5MmC95MAnoaP2tQQev+aF/cdmOvDQfyae79f+oc92/sNk/z7qNeR6xsXWTr+
	 x5BAYCL364ObQ0gz44s4FcD8Bq08Ro3yvjcnNw8xb+kNHBppdUx0sjkAD/9wY3v8Jx6Qf
	 HMd8aput7wPloFkiqtQKW2+t5vGXSdqecNH1We/LtG2lNHRZLxl1M03Om1NkMmil6Cm6b
	 yw7blsFoICOcyPV+6vseKcjc7o5f+9H++ggRxq9pA96LJb2rxsyj7x/Z/69pEy8JRnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HTRs63OB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4409606A336
	for <linux-serial@vger.kernel.org>; Mon, 16 Nov 2026 11:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HTRs63OB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 336C91F000C5;
	Mon, 16 Nov 2026 11:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794827531;
	bh=T4RsKuMY+R4lB3WMCrIbjxJUl1h4usNKFNyhphM4NBE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HTRs63OBk5Nj/TZGoxX3QcMCpXeU9OJbVJ/Z9EIfVja7sN8d2yeIpcDmVosG0uY/B
	 raGJELil/yx8T3YKZv/VB27J2Pq6ycH++m5hxmGmu4+TxlLFeBfXxqXDpIQrSSV44U
	 weGYSoo9I+G3opuUc6gvfV9WtQwslb0uc/kJlhk2RkFZBKlwWj9z/HVD6X2bMr1r1o
	 SIhg3XSBJN5/b7t0nSfD0/sKVKuNvKX1hiZnX7c0Kv5/vTUu+bkCyMo9929jhpTUis
	 O6hNgv8ilLfzoOoQvfZzQygJdJ1fmhavZ7gTBI3CzMeW9YmUwmxB3jOD2k6KQ0IjZ4
	 aYS+PViDjHJrg==
Message-ID: <sashiko-outbox-216856@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 5/6] dmaengine: dw: calculate residue in the status
 getter
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261116-submit-dw-dma-synchronize-v1-v8-5-4a82d64fcd1a@gmail.com>
References: <20261116-submit-dw-dma-synchronize-v1-v8-0-4a82d64fcd1a@gmail.com>
 <20261116-submit-dw-dma-synchronize-v1-v8-5-4a82d64fcd1a@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 11:12:10 +0000
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
> Calculate hardware-LLP residue while looking up the requested cookie under
> the channel lock. The descriptor scanner updates cached residue only when
> no transfer-complete event is pending. If a status query completes the
> current transaction and starts the next one, that new transaction's cached
> residue has not been initialized and a query for its cookie reports zero.
>=20
> Have dwc_get_hard_llp_desc_residue() return a local residue value from a
> fresh LLP snapshot. Keep the persistent residue field for software-LLP
> block accounting, subtracting the current block's progress when reporting
> status. The descriptor scanner continues to advance software-LLP blocks
> and complete cookies from RAW.XFER, including for polled transfers.
>=20
> Fixes: 4702d5244ca9 ("dw_dmac: return proper residue value")
> Cc: stable@vger.kernel.org
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> [james: retain polled completion and software-LLP progress]
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-submit-dw-=
dma-synchronize-v1-v8-0-4a82d64fcd1a@gmail.com?part=3D5

