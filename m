Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793742353;
	b=KpaVwyGL48z9KMieri5L/6FZaS49ZRteE+IcVendLrmA816XSlBqOCCiPLa2tqDqTapo
	 ENV1Swen8MdlZqyBLb9NnohHBG+YB0tA+B5xRIm/JwLwVOK56jYCuauWxZP/qsr9kUkqQ
	 JD3Huc+05Sx4QEaIbG/X+n3BCwVUpz3koQ3Vz9KwrNZrr0pDVvy9VENnEdLlwQ6eePVxz
	 4UmDWnqAdUxbcVG6uCJz0yNkCbORSy9mLiVvdl3ULnEA96g5vyHxytVWjM4Fkn8d5IbIt
	 ds8RAMdjWndvHQGBpoO66Fzi4KwOaN96RqBhIKxOI3UINn/THsNKxMT+yHS1L8Wp4cg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793742353;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=u7rb7y8StO0swbUDlkGI7K6qvKAHPgb3EFB2n+Ad9Fs=;
	b=pY2fmBFxIdqyAn+nf5cpc96MDEVe+DZ2WHGZvv3PHUWuA4L9nkr9CyB4hj2toeStufyB
	 TaoVhQozwLaBFblcW20IThrprvFQ4tX3LK0OOTfUwcLs6Bf6Sy6Nrwl2WqGlAzPlQp1P2
	 ROUWpFIHNeKexiEoOOdFWbqQ8OSjxP/ArYnVUoXIosXrrDGwgC4dfpkB+GXyLlzYIrma2
	 h3SqXEeoHXyB91tdfwO7GlIhgV8NyY+eFtPjls3cRsdrtwW84kLPaDL5GqS+ABzbYKUlK
	 bx2Wk9V8gkDnI5pUE8N40R9M7bG8KnCuKkkVQ8hO9TdjIVyAnpHIynsIqr5t0N0Xanw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KNg0WlaU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0E9606A324
	for <linux-serial@vger.kernel.org>; Tue,  3 Nov 2026 21:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KNg0WlaU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEFE11F000C1;
	Tue,  3 Nov 2026 21:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793742353;
	bh=u7rb7y8StO0swbUDlkGI7K6qvKAHPgb3EFB2n+Ad9Fs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KNg0WlaUJxmBK21+RIMKwIVV0/wzal5sRO0tK0Nnrqrg2oeVXebBm4BvRvLj/O3gK
	 s40fNKPd/tUx97xvp3DSIlkIXyn8ICHQFTkk93uIPXEVYbJVXMaXflfc8gDorl9llM
	 zjoDbpHCJkjwsUxkKbtGbenUEPilneyn3ROpE/vhh5OjOuu+ZiFgVsvOvZ3BFfrRvm
	 5Q0Jko8VN2VjOQR0kmi7MNoD2izu9noP40xOp2eNgyR+ohKr5gk4FWO9uubPS0ZprB
	 hPae/s4gg/nhMS8PI1kFJdiVOxUqBPsORjocu+86YK+H4rH6EJ1Kjr0QX/bG/Cdq+7
	 /TZ5yJ6LPPmCg==
Message-ID: <sashiko-outbox-196072@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 04/12] serial: 8250: expose RX trigger controls for
 custom callbacks
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261103-submit-h616-uart-fifo-v1-v7-4-c9e248d685c1@gmail.com>
References: <20261103-submit-h616-uart-fifo-v1-v7-0-c9e248d685c1@gmail.com>
 <20261103-submit-h616-uart-fifo-v1-v7-4-c9e248d685c1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 21:45:52 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> The rx_trig_bytes attribute dispatches to a port's get_rxtrig and
> set_rxtrig callbacks when present, but the attribute group is registered
> only when the port type has a static receive-trigger table.
>=20
> Allow a port that supplies both callbacks to expose the attribute without
> a static table. This lets integrations such as Octeon provide their
> FIFO-relative thresholds through callbacks while retaining their existing
> port type. Require both callbacks because the attribute is read/write;
> ports with a static table continue to use the existing fallback handlers.
>=20
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-submit-h61=
6-uart-fifo-v1-v7-0-c9e248d685c1@gmail.com?part=3D4

