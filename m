Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794565046;
	b=Yi66GfS4+RjeoDE0b+Jr+zfIWhGjp4BBGUiNlCK3fZjaibq2GRGWvH0BCm/EQ3MHDZVc
	 RQ+q8WfIwL1h+xEPAzwr2yWCnOUKR1W2g6SiVg8qEuhwzdFBTFwre5KQtbmcSSiTHjJoN
	 Zb2z140IVLixGjocMG+ZUh/pq5qFfeWTziu2+a+OytE4o0K3G4/BOdpgZMvq7Pq3CyMc3
	 g/28QI6+c4AR42jo8Su3gasUlPaAGM+DpfxQOR1eRw9JGN550RmhuwnuTYbnhTMpEI3Bn
	 2P2ykIoyLc2K61boRp2Rivyh/lREhuNixzRnphDpKfSP5Z41sIAPK4sKE9TSu3Tj+OA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794565046;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=3qyxWwiLMsPlmKBWTLROA6An0RmBJG3J+mLKo+4coCI=;
	b=Tm1Nh/C5zZMtHtMLezYWWqDp/WmU+xq0EgVQcOtGdCqbQO4/jOuMhO56NjYEJbTm6/oJ
	 JUZnYR8PNMYXwwOii1nHIktZFdZwq5B41RETOMz7qAMAyi3pwvun0kkZr9Snj7ABPLvld
	 fiNt3y5xE2OSyu99kq2D0K1nqJyEjX9l/RADUrZ0BNoLsRcDRSfpxf8tZ/oYxWGGwPz7V
	 +iGzSCv4qys7Goio7UUHdIFHhNavdpzm5bIKBIFl8UUr466x/bccio/J/8uWkHjPXDCPV
	 GCMvCwWIjJ7nmEezUQIXPeauSnaX7fN50keOhMISQ1Wehtx6tx7QJERP19cFBNy8iGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="QBmcst//";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234D6606A323
	for <linux-serial@vger.kernel.org>; Fri, 13 Nov 2026 10:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QBmcst//
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88FCE1F000C4;
	Fri, 13 Nov 2026 10:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794565045;
	bh=3qyxWwiLMsPlmKBWTLROA6An0RmBJG3J+mLKo+4coCI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QBmcst//iKt6SFfIXchTVP1FCeboJJoWjrG+Hgz800D4jjduO2FamQatVbqMk0oIQ
	 H/Y/3Fc5dHjrz00EEqYq5Hruwwbkhj+3SC2jWGBI9vd/nKYVxGeAUukIP6fvebTt6i
	 5t3xldyDUOA69MGovhXv0E4FQGNubTX6HuxxikgbbfEYDMFVwIj/RQrulsfKDjKhdH
	 N2QKgn300EqCFoxzZ2eShpHiHPE1YcUp1cLi6GYIzzeFGgEdbAUNnIyIaO1RtEUHuA
	 UpE5qEHceXZSQNAW/NZb1z6zAVkTlRUgGP1+7qcs8/SRYfij0WMUMeAOYyGy8F5vhG
	 j53rVQ6GrATzg==
Message-ID: <sashiko-outbox-212614@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 7/8] serial: 8250: retire canceled RX DMA before
 reusing the receive buffer
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261113-submit-serial-8250-dma-cancel-v1-v13-7-b857f2617ece@gmail.com>
References: <20261113-submit-serial-8250-dma-cancel-v1-v13-0-b857f2617ece@gmail.com>
 <20261113-submit-serial-8250-dma-cancel-v1-v13-7-b857f2617ece@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 10:17:25 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> The generic RX timeout path pauses a transfer, copies its data and
> terminates it asynchronously. Clearing rx_running at that point lets a
> new receive reuse the buffer and cookie while the old callback has not
> yet run. Inspecting the new cookie cannot distinguish that callback from
> the completion of a new transfer.
>=20
> Reserve the receive buffer until a worker has drained the canceled
> callbacks. Keep FIFO access separate from callback retirement: after a
> successful pause and termination, clear rx_running while rx_terminating
> prevents another descriptor from reusing the buffer. Deliver the paused
> data before allowing the interrupt handler to drain the FIFO through PIO.
> Normal retirement only releases ownership and leaves subsequent receive
> handling to the UART interrupt.
>=20
> Preserve the normal completion-path LSR read and gate DMA resubmission on
> [ ... ]
> Fixes: 9ee4b83e51f7 ("serial: 8250: Add support for dmaengine")
> Suggested-by: Raul E Rangel <rrangel@chromium.org>
> Link: https://lore.kernel.org/r/20261109162135.906262-1-rrangel@chromium.=
org/
> Reviewed-by: Raul E Rangel <rrangel@chromium.org>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-submit-ser=
ial-8250-dma-cancel-v1-v13-0-b857f2617ece@gmail.com?part=3D7

