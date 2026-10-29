Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793313266;
	b=pcB3H2p+RH0HPUMo7VVM62e+P0cBwTfS50o9zT8EXwyZGRHmtwjCZtNKGsdhgMUPYsGi
	 1z+D5vWIsUkV4+7HMOwqaUWVL+O2mcHKxLUbbK37drH0YqC+A/R/NVXXfWQn2VtI17Y0i
	 PCOp2KiZI9/Sn02AAj13vxLMpTzuYpyZqtS+390EZLOFufzX23BDZhqTMowMLWN6UWFpC
	 s2wID61ZiWmE8PZpTOf8LxUNets5Eijo7QnMdfigGXWhlyqg2ma853/vOmULY/wwuHgQx
	 L0+8zneyEWoZIxDYr++k775Psohta7I/92rZhCzje3zBGyMfEkRyfpqB6o+Y4BR9zmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793313266;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=uJgqzKjnoXUKXrAx0NTybTCCC0W4Gjz5ZKRvg6sLh38=;
	b=NgRHS/icozA/GiW0e7O7gJGlwvhY1BtAqRyuEoIVIqvXVUyagVCNAXmWaRi7L8sNA63u
	 66V8z/oUOyOcqaBqxz2BWGYxflC3G8O6+w3kRI+JSF3JJtH3Ia57fmCChaTXiPfAiPzUR
	 iFwTdfmPkQe+PofD0tdtooxFCPFlJw+S40rHV7i42ZavmeTM1IHiNnGxjewOTlivpsooI
	 rMAJGqxZ4asUd5WAbTOwlPMVtx1mmg88Pqa7bKWD/AgmmRQmH/LQgJYgMloTsc6vok8AB
	 P94vrEZTIShCor3AwvQBFlmQsDXYPcFh9GJN85wg4U92wjpKlmZFSYlvWUp+W/Y22vQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XAt6PWpw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17EC606A31F
	for <linux-serial@vger.kernel.org>; Thu, 29 Oct 2026 22:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XAt6PWpw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68B161F01816;
	Thu, 29 Oct 2026 22:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793313265;
	bh=uJgqzKjnoXUKXrAx0NTybTCCC0W4Gjz5ZKRvg6sLh38=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XAt6PWpwQPFH/Ps0ND6YFWoUoF1QcxYLq8GECk5Z5VL7zfZq5zv7Q3lsd4aaN2wOm
	 ziJgEb/XVy7EGUxyo3gyQ3nemSFiMk/MEjS14D3sM4JFw7OFsXcAADiWuDVrS006ab
	 wgsa0FtUv9kHad94DUeantuHhxYvhfoHRNalINdw5STjHPzNn5DL8eXyAdn83OtyOx
	 rwk4E9afgC2RDWCciyyteDMzHs+w6MNDraUQGL8+CadffiB6Oj6pbY5sI4tV9SYNit
	 Ytr4Pm6X2CmaoRM/3+nZ84gnaRA2J3NJGeXr/c1WYCPh6nt/uzuHZFnI6/TVUj6hnZ
	 dwyvSkvjYtWCg==
Message-ID: <sashiko-outbox-190078@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/7] dmaengine: dw: serialize error recovery with
 channel termination
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261029-submit-dw-dma-synchronize-v1-v4-2-fea447d9f285@gmail.com>
References: <20261029-submit-dw-dma-synchronize-v1-v4-0-fea447d9f285@gmail.com>
 <20261029-submit-dw-dma-synchronize-v1-v4-2-fea447d9f285@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 22:34:24 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> The tasklet samples RAW.ERROR before taking the channel lock. A
> concurrent termination can empty the active list before dwc_handle_error()
> uses that cached error to select a descriptor. The list head is then
> interpreted as a descriptor. Even with an active descriptor, moving
> queue.next unconditionally can put an empty queue's head on the active
> list and pass it to dwc_dostart().
>=20
> Recheck the error status under the channel lock and stop the channel
> before selecting its failed descriptor. Only one transaction is issued
> at a time, so take that descriptor directly instead of scanning for
> completions first. The scan can otherwise complete it and start queued
> work before the error handler has identified the failed transaction.
>=20
> Detach the failed descriptor under the same lock and use the queued-start
> helper, which leaves an empty queue alone. Clear the software-LLP flag
> before restarting so a failed multiblock transfer does not prevent the
> next transaction from starting. Keep the completion callback outside the
> lock, with the detached descriptor owned by the tasklet.
>=20
> Fixes: 3bfb1d20b547 ("dmaengine: Driver for the Synopsys DesignWare DMA c=
ontroller")
> Fixes: f336e42f73d9 ("dw_dmac: Move single descriptor from dwc->queue to =
dwc->active_list in dwc_complete_all")
> Cc: stable@vger.kernel.org
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-submit-dw-=
dma-synchronize-v1-v4-0-fea447d9f285@gmail.com?part=3D2

