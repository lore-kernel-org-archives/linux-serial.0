Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795433161;
	b=F4dSjosmAfFF6MOIx9ieThM3oEkHXx+e7gyiB05luRFvr/axNVRhR5j1xTthjfl4Nfdf
	 vcFh8a25byzhtlINt8zZzvhCKOie8GrCupog8VjaffRFKPCzAk5qKECOvRUr4wzZyDq2I
	 snH/DsQowdx3MLsccQxzVreA9MHunDZizKWgzDkOmXCWs6v3fLdghazNiBxe1pQGoRkFH
	 qwB7B4TlAaBS9qgQ+6tEhYMU6HmRFem2XjSvBRTYsN4VVWGubaceSyl+mP0dPdCk1P0EW
	 +flkDWg4mg6BsE+BcLjph91tE1Du1pIEG6+2kzHMNSvrzvZxhnhoJgHkc63qa808yuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795433161;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=0efAWWennq/JMLbIaZLw1som6/hhLSin03rtKjI8Udk=;
	b=rxWXtgBab1BbNhkXxzjJwPbopmntjJqkBhKuFXBsoXE9XcIqZXMD1fU81S4MLwxR4PLT
	 0c0QUZhX2vU7221DbpeMnsOOuHnu3kwWN6js4iy6qV41a+XXCfwAVprh+cLKRz76kCnlK
	 Buw0kWUEQ0N8/Lqf5AMHseZeki00i5oYQ4TRXhVncZYaYbJVPryJwQa4ITmLUe8ysup0u
	 Hj+fjbEi2ay4Y9GDs8qY6plzGtwBz9R/V/XXNYQL9oV7b4yXBji7MkUGZ95LbBChWvHrx
	 hKZpDzqq78ypQ5B0L/RdwjvBSsiqGWC1eE8f1RiWRGwq37GRwshpZwsrHstSwiR4r3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Ro6/9jvb";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26690606A31E
	for <linux-serial@vger.kernel.org>; Mon, 23 Nov 2026 11:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ro6/9jvb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58F1E1F000EB;
	Mon, 23 Nov 2026 11:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795433160;
	bh=0efAWWennq/JMLbIaZLw1som6/hhLSin03rtKjI8Udk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ro6/9jvbSck92uYH3Q0IxOMiI9r+7XlDTOZs1mMhT/ufTq6vS4fAWofcIMlq9Vclc
	 J4fUAVCG7QoC7QDEBRsBeqam7ypjb7wQPxbNBKTsYNKUq/D2Fby0prsLzCDaKk/9/e
	 XPF5Zmf14dImJ93TfcTH/Lyj+/8wQzB8u7iNw+Prc0QB88TBzPQ6638wKQKuFapve2
	 tusaFi42TbWHmCjJafTjjATeJm3lo6KLxMQcFURD5XjVoZ1XhLoskOlLzoH2p93e3r
	 Z4duA0r7cEyxYVSswFRmC3jeptel6ukeaeFu/yXQznCUzZeGc7njdmeRa5v8+yiLji
	 cI05plOYUQ34Q==
Message-ID: <sashiko-outbox-229132@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 0/7] arm64: mediatek: Add initial MT6895 and Xiaomi
 Poco X4 GT support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexander Letuchiy" <asalde.le1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261123-initial-mt6895-v3-0-95c46597e63d@gmail.com>
References: <20261123-initial-mt6895-v3-0-95c46597e63d@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 11:25:59 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

Sashiko has finished reviewing this 7-patch series:

- Patches 1-5 and 7: no issues found.
- Patch 6 ("arm64: dts: mediatek: Add MT6895 SoC"): 1 potential issue (1
  Low)

A detailed review has been sent as a separate reply to patch 6.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123-initial-mt=
6895-v3-0-95c46597e63d@gmail.com
