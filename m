Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793648318;
	b=NXVSF3CNMTkrzB/dGBbJsRWVf3I3YeurfGu9YrDBf8wiiok7j/8JUNGlHthM4SnGYOAE
	 CD24M0/peC4DCeEe0/85gsVQtresnsmO/RmKOpPF2Y0pH0Zg54V7qreQfr0eaoap2CnHh
	 kswr6Gbi8n8DatpMjYakIgjDbN6r8os8ByyJdJJqXGcEl+HaU9J4ofbkMTaj7UYd9gtf3
	 hQDQ2PSj5B3JWpMm4/EuJ1osCch2zMb6UTFv05tcTFOxOgjTNgXRrjiINbPg3JLfp0N5/
	 mGJv9aNbq4TcsLXj00AcwzRCW1vzWJJy8pze28Wnd07bHA/Syh8hs6eTNeUh8wAHJUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793648318;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=tQAnSNMIadBuf/0SK05zhumRSAyvXajbkasYtGZ6zvc=;
	b=gHsDF8GgxRiiNptWsHkNCAL8UlYEOE5D5J4a0lde+AZ+X8DLsV4XSxOnLa3fFW0OD678
	 5RCvgddmqvF3I1HprIw7zGHu1MpMm8NyJM+RootyJla+h8Qdaa5fmeUw6q0VRzkx1hZzC
	 14ilCBB33JYPTN8q59XLpYoAy/E1n5tK1s4O7esVXr2Noe6boQkjyEhBrjEHJ757EmK2g
	 o1ecACBxmePPhhKMj7c9YVqh5FA6pt4zByEIyVvxJG/yJjOkev6ppzaD5lbwvluSfzK0J
	 hhH6usEDyYKg4E0kXMAPVpuNQ+tkosy/CRceB72U5DcGaTnGMZKotMEQ0LgwyoZUH3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xi2kuLLn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5504D606A327
	for <linux-serial@vger.kernel.org>; Mon,  2 Nov 2026 19:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xi2kuLLn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16D1F1F00A16;
	Mon,  2 Nov 2026 19:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793648318;
	bh=tQAnSNMIadBuf/0SK05zhumRSAyvXajbkasYtGZ6zvc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Xi2kuLLnHCnCMgMbNGzsyOCmNsgN74VyvZXSlxix8sryE/kKTFotaU/3xyt7/8T3y
	 tYqUMUpEiHWhfyhonE5Kvuc/NogR0aVZgLBosDzQKaYFOAiwlJUoFO1K28lYG/QqKP
	 GBiZ95kDrc6Ew+9tFvqMpWZuT/XUgp9OH+j0DflpIrwpKxxcK2yPzXQ4SWveJyZKW4
	 D3q2lALAsOv0fTcpqzPgATFKo/NO2M6V+r5nr9Kv+5lCgSubTFlhPsJ2oQhbHze+9O
	 xzUulDR7hdL1jf2HY6nskMik6J17hhWzYux0ilcdcQBKFTwOjHgf1g1zs8GqCgSvYq
	 VZotaNlQUqJSw==
Message-ID: <sashiko-outbox-194011@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 07/10] dmaengine: dw: report residue for queued
 transfers
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261102-submit-dw-dma-synchronize-v1-v5-7-d3207758fbf9@gmail.com>
References: <20261102-submit-dw-dma-synchronize-v1-v5-0-d3207758fbf9@gmail.com>
 <20261102-submit-dw-dma-synchronize-v1-v5-7-d3207758fbf9@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 19:38:37 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> A submitted transfer may still be queued behind the active transaction.
> dwc_find_desc() only searches the active list, so a status query reports
> zero residue for the queued cookie even though none of its data has been
> transferred.
>=20
> Search the queue as well. The status getter already reports total_len for
> a descriptor that is not the active transaction, giving queued transfers
> their full remaining length.
>=20
> Fixes: 3bfb1d20b547 ("dmaengine: Driver for the Synopsys DesignWare DMA c=
ontroller")
> Cc: stable@vger.kernel.org
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-submit-dw-=
dma-synchronize-v1-v5-0-d3207758fbf9@gmail.com?part=3D7

