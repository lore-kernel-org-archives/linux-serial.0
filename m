Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792796517;
	b=pTOA4uG6NDf2aYLOP4uIuydCRH12UGDsoO9LpHc4SXZPg13UYILX5VWyQLzjOxqkKe3n
	 xfPmZQ85rKQNeNNA4eXvaVYroF0WOpC7ht30tGSE+6Eh1oxOMe8dnhiAM36MuLTMGc4bn
	 k4O42E6DOZmKxk2Q9oFwU1yjVRMiOEtGqRYgGdEzJGppnbri8FkejpPf+F7xFnjV4ET5W
	 i54pM55oBc9h3EKzrs4ld6i8n2ThxI+5LVKDSqG6fUtSQX/Z+J1cCiCsfDeogPcGEFGtL
	 y1Dwf5JkL4ntHoQmR2EineoaKgeon8W2VIsru8xdTBrslWBTktE1a5mDA2wqikJtY6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792796517;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=jt0ZzVNzsIW8kGZtIGkKcvMUVASsq3rqpWjP7Z9T0Jc=;
	b=ZZa0E4DTNjr45J3h3oFOaRDhtHbUY/2t8sbh3feRGZM0KrPIYqrEMaVGk1PchrxWyAe6
	 nRHbOfroNs6RV2mrSXmT0L6X/tw+EyXOZ+iCNVaPsc6AyX5efAOPnu+MDryQ1ZwrIgHYJ
	 1TpyiSsDfAHWnB5cbF6GdEJ5mu6doTR98adh1tq3N0FkEl467/WSbsj0pPFrVNfV+pQ0L
	 ewkXJuhY1nEXxuaG4QLIIzKv+BnZTfRlPgePEJTy0HaxKypbN35dZ29Fh1Exks/MWESbf
	 diV4R2QFKLim9t4bqMh/ncImWQ5U/JTXP98t731oqQXlKD/i/Mguk2hg2vN58z2Bwtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O+d3yHuf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF84D606A31A
	for <linux-serial@vger.kernel.org>; Fri, 23 Oct 2026 23:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O+d3yHuf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 586D91F01825;
	Fri, 23 Oct 2026 23:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792796516;
	bh=jt0ZzVNzsIW8kGZtIGkKcvMUVASsq3rqpWjP7Z9T0Jc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=O+d3yHufUI9N6IfOQuPyYesefczayxowjqXrv6qB1xf9ThXLAYusqrrNl22TEredv
	 bAWSG7o7DA7T9nIQvBgJPG2PgAlJ2N6E45tEr5iADRZ0/ljgodDkyJPEYZ5i8clLeG
	 Zd+Ew0i0SpIM1VNV6r++wQ9id/VsVaxLt/1PMS6GCzsySKXp0bT90m/EUwpLFtnzS5
	 iYUpqAt4U/fmN59VKwQXYq9skvYDvYojs41iLWnDFTmd2EGHo/V2ZHB9KcwpDjgKIF
	 Y0zWDTAG+7wbmAx49/s92QNWscA4rWormL2sSvMGRoXICq+2aSooxVm7mWDtyz0mss
	 MYeCEOTDXh36Q==
Message-ID: <sashiko-outbox-183347@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/4] serial: 8250: retire canceled RX DMA before
 reusing the receive buffer
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261023-submit-serial-8250-dma-cancel-v1-v4-4-e759de1839de@gmail.com>
References: <20261023-submit-serial-8250-dma-cancel-v1-v4-0-e759de1839de@gmail.com>
 <20261023-submit-serial-8250-dma-cancel-v1-v4-4-e759de1839de@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 23:01:55 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> The RX timeout path pauses a transfer, copies its data and terminates it
> asynchronously. Clearing rx_running at that point lets another receive
> reuse the buffer and cookie while the old callback is still waiting for
> the port lock. Inspecting the new cookie cannot distinguish that callback
> from the completion of a new transfer.
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
> provider still cannot terminate the channel in process context, retain
> its buffer and leave receive interrupts masked.
>=20
> Fixes: 9ee4b83e51f7 ("serial: 8250: Add support for dmaengine")
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023-submit-ser=
ial-8250-dma-cancel-v1-v4-0-e759de1839de@gmail.com?part=3D4

