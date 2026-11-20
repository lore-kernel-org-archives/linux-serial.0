Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795202351;
	b=I0NbLB5Z8XwX6mifu41S8OR1yzCyDwRMTOVby0xmtPH1czTQYMCP/LUCKbrEbn5ONJwG
	 0453wKzaJzVuenJlgEomDrtO8y3ua8NgdysEXL66ASt+Rr4UoaUo7Ty3SAAXcaq4yYV4h
	 w07g8OXMtvTIDIIIEj/mumTEViHizxNKnTHnZtK55ytvlt2iKrc+EV5fuGXP2P+KGyELR
	 9DJhPCdKCTxGNCIAD+vHndM3NKXQwHgsfb6iY2st2XomBESMuaJ9UFJAEoGj0zpTwoBa6
	 +sjvfF3ElETlAgA+VYDOi5aFzvhqhTeBo1RvnP+ms8ps2KAvuD8Jd8BPr7+57Qio6Qw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795202351;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=vfGgosWKbBcSrv590LiqoskJkIPssmdJXeQDfxkJAtk=;
	b=1gw9un7Fch/gag6kofE5aCvB3g4gpnKGe3e4FPP7p4VX8pxXIrrb4xqXX4ZL30JfW4ap
	 mL1XhfnPfU/u6KVDJnQteZ6NwnYzIo55hGHqr7/98QW8klT5hmdqdK8klkhrSdyxFIHwR
	 r1v+ie/jgLAJoKssbI4iQVpHOvbTHd1ffbZTUW0bUbPpP4RqkS9MuGVUHf65wZe0ZmQmn
	 UkeygSFqXOlV8+F5DaLIwXtBsWS9ctRgZwXvXoCMV77Y09EiVogsfsAXtMXRhZsS72ipH
	 yqBSEx9tgFUrxpoB/rcirbLlzqJNC2zCCWS0Ia/OsKkxUz4j77h9IC8yQSbKA0y/WIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PuwOCKnU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085E6606A335
	for <linux-serial@vger.kernel.org>; Fri, 20 Nov 2026 19:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PuwOCKnU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0302B1F000C0;
	Fri, 20 Nov 2026 19:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795202350;
	bh=vfGgosWKbBcSrv590LiqoskJkIPssmdJXeQDfxkJAtk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PuwOCKnUdS68RXz+OxfY+ijKXvWMG8wCVhIChOV581Hm0IVa+Pg2mo9NtvSVd3pxh
	 Mn6JoMAukKqBT6CS4QIbvoYKOXmco/fOks9X8qAHbyJJMRSp4+vySCujsidigvjdzS
	 eOUT2kOHoNy34vjbrvL81CMILjvlf2uvxNFedXcG9OVsVZbs5fCIR3JIWPIN0w8jHg
	 ss+T0+lwTxXCyBg38e1EZ5+AeT2l02Ebitrh5uGRC7a0SREjNWvBfk1lFWXkYAypD8
	 nokjyZc7KFjxOZyAS0CgajMyr4Y8zYRTxMCfJjhMfyS16toKOp94FYvnq85wbcmfX7
	 DI32+080E7QJQ==
Message-ID: <sashiko-outbox-225908@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 02/13] dt-bindings: mailbox: add Zhihe A210 AP to
 E902 mailbox
Reply-To: sashiko-reviews@lists.linux.dev
To: "Han Gao" <gaohan@iscas.ac.cn>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261121-a210-scmi-v4-2-4a795a0a9fc9@iscas.ac.cn>
References: <20261121-a210-scmi-v4-0-4a795a0a9fc9@iscas.ac.cn>
 <20261121-a210-scmi-v4-2-4a795a0a9fc9@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 19:19:09 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Han Gao <gaohan@iscas.ac.cn>
>=20
> The Zhihe A210 has an E902 management core next to its application
> processors. Each side owns a mailbox block and rings the other side by
> writing to its slice of the other side's mailbox.
>=20
> The application processors ring E902 through their slice of the E902
> mailbox. E902 rings back through the application processor mailbox and
> writes INFO0 or INFO1 there to say which of its two doorbells it rang.
> The doorbells carry no data, and clients such as SCMI keep their
> messages in shared memory.
>=20
> Signed-off-by: Han Gao <gaohan@iscas.ac.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261121-a210-scmi-=
v4-0-4a795a0a9fc9@iscas.ac.cn?part=3D2

