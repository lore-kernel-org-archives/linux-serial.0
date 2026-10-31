Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793466913;
	b=qdaUwbJKEBV+aFColgGv3Ne6/vLbpwP6Lixv+M0I3ZIhg89NAwwHID3GAzEwA7VjX1K7
	 a68DU52tPmNJv8ZgQu6gTB4iaDQ5lsnhrrRvmKIigsj17XTXFzhhe1imHSXuwtOoqbDPU
	 7xK6eZMMl54QP/KwNc2rAAZ5T5D7hbQ/UGcwiAL+Kb4NLk8+uWjMqUJC6DTqfixNOQUsK
	 /lc+wjq85D3r/ShcDK4snaNUE7YZVNOrUhFU/uYG1Vd1YWHzZZIu+yNxMrHTWygjpnNM3
	 iF4Sj5ZqkyFdhcebsTz4pmfr1pNeZBrf+9lKzbhDhhO28mrdIdTWwZsrRtYSIvZZV6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793466913;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=6soLmSQBJ+wJn1RAfa8GSvNxXMbxKkt10FG7J0h7bOQ=;
	b=3oJy/4axcWFVDMkJo0jLTvG4QyfOiF+5DMcXWg1l3WXORwokO15bWc0VDwcX8Umi7wYm
	 1Gmh9HbhjNBE9sfk8aBncFrUT6Tb2mkWyyLaean/POJ4No694LyhqJ9pHgIbVqPjbyUgB
	 uBhpBYbYIv9PgjvtlcY4dzuFXbF0ZGfTCwPUE8/4lOy9oL+xkqHcIYniSxYUhu6qCpzss
	 6RM3FY+UwHlfLZ+MUwhD4HIRvZ7knF4jQmvQwoDdbbLwP2u7AJ7lvpeUfH3OtNFiyUhTB
	 hd0H+/rM81+KOOXQy8kyxzReEcTc6crcMQjnNlhEkrRmryxZsaS585DX7AOPTLA0SDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H+aH4EoY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B41606A323
	for <linux-serial@vger.kernel.org>; Sat, 31 Oct 2026 17:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H+aH4EoY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 787681F00919;
	Sat, 31 Oct 2026 17:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793466912;
	bh=6soLmSQBJ+wJn1RAfa8GSvNxXMbxKkt10FG7J0h7bOQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=H+aH4EoYLZmZuSgeBvpQhh3C/sW93Et2TVSl9gjuG6CD3voSXPRtaMjKo8dpg4eAz
	 l2eD+92jtk5G1H8tozjPuEXnMfT8XwXcLMCtMrubbLf2nFKxMvw1zeCchpqtR+WMnR
	 S3A7E8vo9o6qhfnPD69rIDzYhF5OoeRdSsR/EGKv+77R5AAytheErbWLB81HB0TddC
	 iK5TqK+ilF7btB6Knpa2EG/euYJuOp6BtKtXALmZ4IqGRNeRgTLw1KeDZ8DUAPaER/
	 zVs8ddHmNKAcjH1vTKLrcz4R4NvveJVM60txmyB+pAtSwz8oud+95PF1JUhguJLiva
	 hrzBA2WCseSDw==
Message-ID: <sashiko-outbox-192057@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/5] serial: port: remove redundant
 pm_runtime_dont_use_autosuspend() calls
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joshua Crofts" <crofts@kernel.org>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261031-tty-dont-use-autosuspend-removal-v1-4-7bdadcadc4dd@kernel.org>
References: <20261031-tty-dont-use-autosuspend-removal-v1-0-7bdadcadc4dd@kernel.org>
 <20261031-tty-dont-use-autosuspend-removal-v1-4-7bdadcadc4dd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 31 Oct 2026 17:15:12 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> Since commit d1706f9da9f4 ("PM: runtime: call pm_runtime_dont_use_autosus=
pend() on reinit()"),
> driver core is now responsible for undoing any
> pm_runtime_use_autosuspend() calls on driver exit.
>=20
> Remove the redundant function call.
>=20
> Signed-off-by: Joshua Crofts <crofts@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261031-tty-dont-u=
se-autosuspend-removal-v1-0-7bdadcadc4dd@kernel.org?part=3D4

