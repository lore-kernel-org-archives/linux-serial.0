Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795056734;
	b=YVCYXJKDQJhQATFtRQ26G4YyfLrpidg6fakVnoxunJhZaimMx1SojvOiPpU14RFoBVeR
	 DJpMg/W8iUVUZi5crXyAceEWFWfT0PmSP+PCQ9Byw1mlNgTnwaNy7a6Zj/sAUTOfqdmKp
	 yxQ4IXNBRPUzNgDrrop+EVq7TWu2ZBbF831kaP6c1tNs/cdAJy7UfB4ADzVeiA/L78rpn
	 yWH4rfg8ViJxCXFpbrEA7py4i6qec/BGrIpHTilHP63VFgvJSpZtTwzA8pf9H8mXls9bZ
	 Rn4wQHRuHTykIVZeAWtzhhak0wXHmDDtptF+31EgfSuvjPnVlj0rnsI3VE99GFu3noQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795056734;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=4ELopAfYZ5LK1+gdlkFVTcTqZ4YKXfNNz3RIuLKw6fY=;
	b=MNV8O/GIgTWccFZXluoywFtog0Jph7b4qePjH4EuXfHoSbSe828dr/9eoQrskKDBrvnS
	 OAu4DH8ZO2CxL1LGWefYaJeKUaozGVBBy3dwPz9Yp9zRstzRZRcejORfnfenFvvNCHnPI
	 CSxbK+HIMhb/f8yAyawBXcv9JSopPX0tE7aQm55XMsTCXENNlj9GWO8bcLJhBdEPdczpF
	 /31YazCRkgALg/MZqiD/HeJ/Dg2zcHJtwBoVkWVInrY3NP/tQqOCLREjm0fDZf1JlalKc
	 V2sUveR+SpucnIGYzKlkLK2gEN87mfcgCDxVnT5FyPbDqTMIMS/cJTLZhY9U9qdV+UA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S1kSdLYp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B37606A325
	for <linux-serial@vger.kernel.org>; Thu, 19 Nov 2026 02:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S1kSdLYp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CA7A1F000C6;
	Thu, 19 Nov 2026 02:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795056734;
	bh=4ELopAfYZ5LK1+gdlkFVTcTqZ4YKXfNNz3RIuLKw6fY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=S1kSdLYpNzAFMLCX6FZMWYYhvySLSoYaU/5urReoHILHaBRtC0ty7Bi6iFYipV0lZ
	 YGIdqliwZ2+hzP1HorHRYdvqv3WfvtTenR7z+P0K2nfaf9h7/A+qctQXIKgk+Lz+QK
	 jYEoP0nZ5bx0Zn7RAgm1I0wKu9eOSTndtU5cQywoqVqpWje6TIpsZ1rePaRact0QU/
	 5/1MNlk+XLO5RZslc2/cC5esxfAirx3YsdF/4omDsqwEzhxPVz4vQAij+rcyiUxZ9c
	 ETB3cEqLtcWMAZ04QpaaEXJsFfu99c6JyiFnp1od4PtWa9UNiHcVtSOlDOmnXAgmbF
	 3+MibyxbcJ4FA==
Message-ID: <sashiko-outbox-222348@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] tty: vt: protect tty lifetime in keyboard path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Haoli Zhang" <26031212468@stu.xidian.edu.cn>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261119024207.4075962-1-26031212468@stu.xidian.edu.cn>
References: <20261119024207.4075962-1-26031212468@stu.xidian.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 02:52:13 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] tty: vt: patch revision commentary and apology in commit message
  body
--

commit 07a0cb83e09876e569aba67b5389fa9413ff391d
Author: Haoli Zhang <26031212468@stu.xidian.edu.cn>

tty: vt: protect tty lifetime in keyboard path

This commit uses the tty_port_tty guard in fn_hold() and tty_port_tty_set()
in con_install() and con_shutdown() to protect the tty lifetime against
concurrent port dissociation.

> I apologize for the v1 patch. It included a NULL check inside the
> conditional tty_port_tty guard, even though the guard skips its body when
> no tty is associated. That check was redundant and made the guard usage
> unclear. I have removed it in this version.

[Severity: Low]
This isn't a bug, but v1-to-v2 revision commentary and notes to reviewers
belong below the "---" tearline so they do not become part of the permanent
git commit log.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119024207.4075=
962-1-26031212468@stu.xidian.edu.cn?part=3D1
