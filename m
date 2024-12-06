Received: from sonic313-14.consmr.mail.bf2.yahoo.com (sonic313-14.consmr.mail.bf2.yahoo.com [74.6.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CDD22068F
	for <linux-serial@vger.kernel.org>; Fri,  6 Dec 2024 17:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733506597; cv=none; b=i1kEYrInWZuF9rMIBGtkcze/0S25q83Sl8U00w51YUCoxhgkD+u8T2ZRzIzzFI6j7jZqv0vXNMgPsi3n9Sns2pmKEpLFzlhKQfLKXNGpXIQM//d2SvVS8SdKfoflNSpw8uVg17j15W+VCZGSU5jstIY1Uk5A14jpX6MEsMSuZac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733506597; c=relaxed/simple;
	bh=/mvRGvb8G6xZ5bKh/acDQjXrAyZNrDqTGhdgjSvjD/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VgZO7JUZiRg/idrAhJEAvMkC4NOkf9Wb/CfMOmu/CjSzAnWnorCW90h/P0LQMth0R5j0Ps1p5ZnPidtDu2RszxgiIbobG+Ql9DyT9yP7RC38PGNgNs5wRdA9ECOP6d7DbEQYBowSpVtwu5cMxjBIq9ImLvOyeTs+urwcY+8PzOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=verizon.net; spf=pass smtp.mailfrom=verizon.net; dkim=pass (2048-bit key) header.d=verizon.net header.i=@verizon.net header.b=IW+nWapV; arc=none smtp.client-ip=74.6.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=verizon.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=verizon.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=verizon.net header.i=@verizon.net header.b="IW+nWapV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verizon.net; s=a2048; t=1733506588; bh=PRmZEtRle3VKbT216MubtI9sERRDGhVhmN8FOunTpLk=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=IW+nWapVr8RwZukhDbGAokhF2ivLfxGt7ZMuKUab94ErgrevQy62DaHetkx9brpykD0EiwkJ45d+RdC1PKTirCaWnLwwnTS2OwOWBaBxRvyxWrbMh+O09HDwauIpzugVrJ3B3JRvK7MS+Tk3lx3NyZR+0LPx6SwOzm0xjwtaE2HbG008xQsHAPwyuZ2s1Nu9olsuM92Vv4K8e29rYscW3IhE45wCC9l8fm0WWBtYCRJST5l3HhA3iCr2Uonhep/JmNsHs8PVpvxHF4mfbliKw8+pU0pxXP39Q/7ht69V+jpZO5OyPlVaYGRSfOlNF5nG/cvurHY6O+Ka2Ffnc5hPUg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1733506588; bh=07xCs4CMQv1OLVLggaApZ5ESZUKrvqaD/HZTIiJS0ne=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=iybAW1EJOYexTzhrbftIXcAK2t6nZsBYRMfWDghW0piz++Kmqdg6sox7EzF+BkOpsqPpGCTuU43ekVUyQrtq4890ebv4v2CcK5Xv+relaQilBjrrtth/WJSdNAr4FA0qwOw7e0ExFzYMe8bjEzoxs9xjl281eFklP5rBU1ga4Yaj/hsI9sDOmETX8QBUkiNNG2FaNqpJoERaDg1pko9IOjxWjb+LoQhZveW23OSHUwhZ1XbY5GE+PBGFU17O0/B5u9bHdJAI6y5zxxe6dN94o0zpBg7D17KRVZ4ROmEnukXQ/kEGLvmmVXdR14Mu2nAumR4HxxWx2SAf3CxHeHqDiQ==
X-YMail-OSG: hxFP6O0VM1mz1bkfm1YC66A9Bije4KniFDecJKk6QZkArML7Kj.Ny2.6FbKfgcB
 NA66P9jZOhrmHwaHhc2G5yelGrbYoKwH70qiIEeCcbwvjgcbqzRI8mZxQtSQPIdTbB3YcQfjO94r
 4ACibzEimSwgzh9SXfvdewio_E.16cb5Rde326OXrurdbIwwkBfx5OeCCkdJ.TxGSSRH.BTQcHpf
 75TjoytXSKo3Ft5coeupC6ACIvq..YEIzIJLEnkoCQl75heW6oQHddyWw3iLzp6pCxO0dkZKjnvk
 Vj6hJvwFjCASTH5gbUKZAAeua7W3QMhPzdLLJml2vWFp9B6n2RXvovQEJpoGUmjaCqRnx7qVATw.
 UDFtykyaB7eVYW9Jqx72_xXvABOTMuebzmZVP0NQPjEb5ZxnECK3KW_KF2JpYvJmJ5rlZu.QhphY
 sGjT_OVQTEfYGGdehN6_tSh8DC.nM0xRxgNIyDZZ2b3cWh51LdMEAOxkXAQ.oEl8Edp7WbAGYeto
 CZDGoNTzx7S8rauyrp3WOTNhaw0aEXVJcXSoKJKNkBxIdMdwaaQgzFPQDJht.HKDI3zJWSkjtrQn
 9rDf2NPx6bWvD3V8QEfnHYagepE7AXhNRWJmI7UKvcf9NVLL0GEtOjxfFGlum3f.wQMG57egLC_o
 I_FITiuRW0yIpGAbM1eckqU7sm_5SQiut.oXR7JkvI3OSCABB96dwY9_Qy_H.FDvuVTakdf3JNwZ
 QXIRtY9hPxT2jnI6iGbNGiKUeTX1ZxoAWsMaXPnqJpoH9f8YZyL2GneOEsQjGnaDmyPIVy_gl44n
 mf5uHfCMa7vLTdDDvxe74O_58PbtDRaJSzDGItHReO3XRaYRG7rl13UTTjQbXnfPlau.cFIXoQFB
 thvN7ukrcvOKHyEC44_pSiHMHi6ap21FQ4dQRXWeQg.NzATcP1KXXFP4Tq7aOYE3kU7nHn6Ag9Gw
 KY_Cg0Qi_dTcnA51q_DgY6gXJlcbvEt7paINPkWsNzb7FNqpqPLhBP6lLMxLsekViS8d6Ri_7Pw9
 g_0L69y_q5jHXOntNSza6vQMvvMu6FRK7iX9GvqkdkrpSggs1UqZKE39_5gYBmVlfC61jkQllVwO
 aysVitoOBjwpvhWtinCpxEk.2feFwZ.4cDqzsbX0sbpfgwdhQ1CdTag9LO2tn7SlKVCSTpWhNVNw
 dFosBzn_3yN84bpMosUERcWbrbmcHWrM._8NzfNScUUq5851cCZJZll3PFnHrekNsdZffjIr6hRR
 O9tZhRgyiPg546ltZhL5qDmXdRpUvHBbvVR9IflAypKVkM0eDL3V7ZJAPhBFtnAfc_PcxhmXOIEE
 DDtWTesqqsmVa_Iv5rGLmBB6QRLz43_FcoCVzDNmKHwrOKRGqPsTfaJTuuJWr1fYuqYHPQY9DjwO
 1X4fVMw.JlEM2k1nJQ.f_fzJPekMP4mGTV1kQiKKUKRYq7hKAEBxkRoRSnx7l3DXGDslHGCU9CKM
 xF3A1De8Y39QI_fiSTuOck1h90eugjzb2rlGjZ1g9ru5lYVOy83aKeEJdGbmTWEcjAb3p8UGSCSP
 fCC4V.ZO99HecwtErEW4mDomnAGi8EWNnMQnrpXXy3n2Uy_7h2k2LmNd1qOVnCh1TmOmFY_UWf3B
 zCQieA3U8p3Drp_cg.ojeyEh40cO_Hu.l2FNdGl08ixf8eic3foNPZYVtcg2SNMN6HcfxYYgxTRu
 0_I1U8oDBDdqn32psDiq0Kx1gTjkoYwXglD4wcZc7MCVhVh6JpXJwL90bxuacV1.b0eBv_4dZiSg
 kGcrpsEkB61IN6v5kogtSljaEWs2eVEo1tVeA0fChpDU7ZCMoeoptd9NyBhTnqIR_8uW8luZKgIY
 4ehhGcm_mBNFXscJ1iGjh.mhUW62TzpMiINMtr_9oyLupIgkCVy4EJrT7cE_Pf47buIuxaG32BEq
 1GRLEnVtnjD1MBc6QpVKje6zKsAJTJb44GLg65To8XRWwHfxTOFajT09D7KdRz0nNUOQ6vLquQQ5
 IJEVSE5lex_ZN6iMG482Ir_U70pc0zRsbLFUB8Z9wFxYxSFX1bHQnNv7G6Fiz3erharlcinQHggm
 6TMdlP61Q9_jtRe.MeeJM6b8a1.vgLs2Z7wwWyZsujk203FVAXj2tBncwGScxAgnyJKSsXHctNSl
 U0xCOcKqnEIDlAHtVR28aJEEcvCDpEZwCSFnMWeAqAl6_Fa3PhVPI.9RjJEI4WwdKGWKX8wLELGY
 GsTti8v9qJG.Ki6pgRQEPv1onJvrGnHWZfSPuJyo9NnQeBLDzwXSfh.qtBA--
X-Sonic-MF: <bluescreen_avenger@verizon.net>
X-Sonic-ID: 479efaa1-4fdb-4406-8593-03a020f2f64a
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.bf2.yahoo.com with HTTP; Fri, 6 Dec 2024 17:36:28 +0000
Received: by hermes--production-bf1-66bb576cbb-h2pjb (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 64cf1929a7458f2c6ec659f4a8414399;
          Fri, 06 Dec 2024 17:36:22 +0000 (UTC)
From: n3rdopolis <bluescreen_avenger@verizon.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH 1/2] ttynull: Add an option to allow ttynull to be used as a
 console device
Date: Fri, 06 Dec 2024 12:36:21 -0500
Message-ID: <3758619.RUnXabflUD@nerdopolis2>
In-Reply-To: <6622246.K2JlShyGXD@nerdopolis2>
References: <20241129041549.778959-1-bluescreen_avenger@verizon.net>
 <2024120408-moneyless-stood-cda2@gregkh> <6622246.K2JlShyGXD@nerdopolis2>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Mailer: WebService/1.1.23040 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol

On Wednesday, December 4, 2024 2:37:55 PM EST n3rdopolis wrote:
> On Wednesday, December 4, 2024 1:06:50 PM EST Greg Kroah-Hartman wrote:
> > On Wed, Dec 04, 2024 at 12:06:56PM -0500, n3rdopolis wrote:
> > > On Wednesday, December 4, 2024 10:41:44 AM EST Greg Kroah-Hartman wrote:
> > > > On Thu, Nov 28, 2024 at 11:15:48PM -0500, n3rdopolis wrote:
> > > > > Add a config option CONFIG_NULL_TTY_CONSOLE that will have ttynull be
> > > > > initialized by console_initcall() and selected as a possible console
> > > > > device.
> > > > > Signed-off-by: n3rdopolis <bluescreen_avenger@verizon.net>
> > > > 
> > > > Meta-comments, we need a blank line before the s-o-b line, AND we need a
> > > > real name here, sorry.  I can't do anything with these (including
> > > > reviewing them), until that happens.
> > > > 
> > > Oh, I thought that I didn't need a real name
> > > 
> > > I found a recent thread that seems like it suggests that I thought
> > > https://lore.kernel.org/all/20241121165806.476008-40-alex.bennee@linaro.org/[1]
> > > https://drewdevault.com/2023/10/31/On-real-names.html[2]
> > > Or do I need to wait for that change to the guideline be merged?
> > 
> > That change has been merged a long time ago, but as far as I can tell,
> > this signed-off-by you used here does not meet this category.
> > 
> Oh, what would it take to meet that category? I've been using this nick to
> contribute to other projects, and it matches my GitHub name, and FreeDesktop
> GitLab name
> 
What if I made the signed-off-by (and committer name) this email address? would
that work?
> Thanks
> > thanks,
> > 
> > greg k-h
> > 
> 
> 




