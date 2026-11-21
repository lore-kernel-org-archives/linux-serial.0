Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795295456;
	b=NGkT8ZYdhWTrHpOWIa96IWliTPkVrtN1Qzg3rDwmJ4GNoAal24XjgiisuR+KtZrajtOB
	 icFgALwgqbr2B6YAdqiZ7TO4Sa/x42nUp40P1gTZNhDGRcVG5JEt3CWVuJAT7w7okeH02
	 H8KuzQFRVPgZht7vdxiOHzaBKufWFpOyjUyelI8rTuvfMqYlDW7YU8h2GMxX8Z305xtuc
	 dkA/4jsvocF+j4i+UuuBTFPVNaHgLwkdjIS+gwiyFDlzGycGiJW9GP2DTWuShrTPfiKO8
	 HEVrEQhb3ZCP4vqhRsl/LkuJ4ZU/JmQptYNzAvCqdlEALN0I8dDrgVNQjAWg5bUI9iw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795295456;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=RgpJ6UrU76dAlvREVo36xERV+FZ9oeCWKh+13t89gFo=;
	b=c3dGTGj0nvo1A80ndKOsZuiNihbE/Ukp7DOHIsXLmNjRmAjL3TNf9syobM3aFB6wPClj
	 tQmYIqGO7DbBOQHJgB1ZkV3lmcQzX8rwkTdovoF3HuPMzmqUauWVQLy26/Z7HRLZSCUdX
	 VkVlIY2vQQ8FqKg4xVfjJIS6BgOgrHYtNVYTkSX7HzHpeVbWebMjbQU2Z1Gucw8/7onk6
	 dHduR+0sOLdksc5bBrQZjzMfEPA8nG3SXq8AKlQi4d0FUs+VQW97QReWB/1ySLPzlpxZS
	 wdcwKOR6kzIpyaPK2HBIv1z6+CmqkqHMZe7RFd2LGbGNnSX3U6yE9Kh4bP/fKs2mPpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iwNr7jtq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4115F606A331
	for <linux-serial@vger.kernel.org>; Sat, 21 Nov 2026 21:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iwNr7jtq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8DDF1F000D0;
	Sat, 21 Nov 2026 21:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795295456;
	bh=RgpJ6UrU76dAlvREVo36xERV+FZ9oeCWKh+13t89gFo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iwNr7jtqkhfLBG1y98uzjhoh31WLdx+DNJqU9BaYZnUiQkxKYgxTbIJJMWQdYjdKb
	 mE8eUp+1aW6ctyleqgq+xEVGcJcMsLEpYDJ+hPsdZsoZD53fUkW5ZHF2qZtrwDwpRM
	 QuJs/Rmv5W/l6vFabyidbG2BLvkNHTytVj3UqXkpv0KyA5p1H3F24C/2hUfwSmbNWw
	 IRKl6rnZN86mRTQmS68JQJpejAFQ+rUXljke8ASBHJpukl1xnJMyqwkPbGCaPr+yLn
	 1Qxw0yyvIJOoOm/N0su86hza5tBS8NbTJIDNN6sknPOtcWDKwEd21i+3dfhR1NhdWJ
	 y3yPJxIBOA8RA==
Message-ID: <sashiko-outbox-227385@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 00/10] ARM: Add support for Cortina Systems CS75xx
 and Securifi Almond+
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fil Dunsky" <filipp.dunsky@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261122-b4-cs75xx-v8-0-5f971b0dc69c@gmail.com>
References: <20261122-b4-cs75xx-v8-0-5f971b0dc69c@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 21 Nov 2026 21:10:55 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

Sashiko has finished reviewing this 10-patch series:

- Patches 1-5, 8, and 9: no issues found.
- Patch 6 ("dt-bindings: serial: Add Cortina Systems CS7542 UART"): 1
  potential issue (1 Low)
- Patch 7 ("tty: serial: Add Cortina UART driver"): 1 potential issue (1
  Medium)
- Patch 10: skipped (not reviewed).

Detailed reviews have been sent as separate replies to patches 6 and 7.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261122-b4-cs75xx-=
v8-0-5f971b0dc69c@gmail.com
