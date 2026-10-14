Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B3A471412
	for <linux-serial@vger.kernel.org>; Wed, 14 Oct 2026 06:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791960566; cv=none; b=RSZqKnh0n9htbONiHNIbQqnhNTey3lfziZ6KuGc6xooX7pECoTmeOI9scxkMPjlyNvxTG/G1Hb/EA8bXHBwvhaUgLfslo/+ECVq54SlKWDXENynYbW0WZ8pmmJq94Bt9fo+QkEnVx58rCc9owNcQ6CiwGzyBuXOdyHJhR5iSmDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791960566; c=relaxed/simple;
	bh=NBpU4VrR3JQ41D3xo+D9CJRM28hdqleUo7rCwFxksPA=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=hxuz34D6YeaXP2iJP2iROI9L9/LrhMSmRgMv6or/0g9DudFvCz1Q1lIwR7qVhnz3mPXwF7wvrH2JVTdz4gs1UPt3gCornSjtLkWiuAJ8FDTS3AG5qIhtcThYn6kqIWdOqbPBReJu185rf66cUrf0YgivOVcWWbjRTp0hwdLse28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ShjX5E38; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ShjX5E38"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D74001F00898;
	Wed, 14 Oct 2026 06:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791960564;
	bh=NBpU4VrR3JQ41D3xo+D9CJRM28hdqleUo7rCwFxksPA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ShjX5E38f62cYN9XgTwyGuWn5eOGf9WAmj3LBzJaW4xZqmuw0qdaKhG5LJJGK0PAx
	 lfeYatB2eJ/S/aFz5zcFByUiiUNsnHkS+niLsAl4SPjbydS6T+jdP02p+eGMUYLEqe
	 GMneHBx8kigzaIIF1Ev1I4RECgWwHwjXDosLTdfcXbz1RDEICyYhBe6eBaZddt/DPg
	 k/b40i5BU0ka6ioNwYXGMru8pUEYqw6R5M/DDQ3L/vByRK9OFtTw97Q/3TTpLSe/Ld
	 KAumtvpqpj7Bo5mjrT/qQNvKHM9k0e6eNRha864Dt3CknqAK1noFr5xo3HOc0+7+Lp
	 4/zkR9njgNuqA==
Message-ID: <sashiko-outbox-170896@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/6] serial: 8250_exar: remove useless void * casts
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SmlyaSBTbGFieSAoU1VTRSk=?= <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <c9c3f096b01befa764c3ba75457a76a0afa5800d.1791873876.git.jirislaby@kernel.org>
References: <cover.1791873876.git.jirislaby@kernel.org>
 <c9c3f096b01befa764c3ba75457a76a0afa5800d.1791873876.git.jirislaby@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 06:49:23 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> port->private_data is a void pointer. There is no need to cast it when
> assigning to or from struct exar8250 pointers. So drop the casts.
>=20
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1791873876.gi=
t.jirislaby@kernel.org?part=3D2

