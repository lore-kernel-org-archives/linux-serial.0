Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF21F35C6AB
	for <linux-serial@vger.kernel.org>; Tue,  8 Sep 2026 19:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788894828; cv=none; b=OXE3ORyVuZqe7uzjrW9+BXvpo+uI9jtGvU5blOFxi9fbAWPm2/EEFRyxNqBT8U8emkJnAJKFAOOEZ7eAmWMmrSJbk/QyXHsOOwnp5BMfafERh7LH+q4f8C6KH0iGMiLx+NTTSn3PbY6yBfGF4NO7Ga4FSjK/T+w48yj4dJz47qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788894828; c=relaxed/simple;
	bh=E3BWdGTz+i8yQFZKuXQJUdicVUP3a+D+th8b38fnJm8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UVf0/LPrZy9SXakBWoKCI5qaEdFFJkZyTiyWFbU3OXf8FCP1nr6l1jmc2IbkYW77jh97rPFm7u5vnH1YtiOshRC4Ujwv37nnmTd91gHJaFN8UwCYP8P87Kgc/Oia0MWIgUtHxldpzC5Tx2hujKkwv0h9CF8L4vjQAYvoGDLIiDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DS2bXzwK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DS2bXzwK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3503B1F00A3A;
	Tue,  8 Sep 2026 19:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788894827;
	bh=E3BWdGTz+i8yQFZKuXQJUdicVUP3a+D+th8b38fnJm8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DS2bXzwKHKKWXLbCNCK3O8whrZC80HOoVPZrTp/ZawOMzIs+CSFaOhudGJrIIPP/x
	 Q6Hv9HxTzyqy4mfJ8Fkn9J5hhgDk5jFPhLWeTa908w7xB3HCEegeEfPF4pg3oYq6FD
	 Xk7pSL47FqXpCHYAmkjRzXYbiyCRGr3ljxarz0oXSqpAQecVRxO4UlvjI/BP1xXc3F
	 118BlQf3E9TbqDwFtB3HOXmOSBzHpwjyLVV+7cFqicVDhU2CkEmMy0Dxf+a7gc/x6G
	 zBepMtPW9zmKwU1MjLdy9ZthmLk7bSizvE58zBmiHXBncqoqMpaZ5tyqjmw4TX8EgD
	 t9Z6EA4cSgjtw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] tty: serial: qcom_geni_serial: Keep console RX
 functional after deep idle
Reply-To: sashiko-reviews@lists.linux.dev
To: "Viken Dadhaniya" <viken.dadhaniya@oss.qualcomm.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260909-correct-icc-bandwidth-vote-constants-v1-2-fbebf6b3c341@oss.qualcomm.com>
References: <20260909-correct-icc-bandwidth-vote-constants-v1-0-fbebf6b3c341@oss.qualcomm.com>
 <20260909-correct-icc-bandwidth-vote-constants-v1-2-fbebf6b3c341@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 19:13:46 +0000
Message-Id: <20260908191347.3503B1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> At baud rates up to 115200, the serial console uses only a 1 kBps keepali=
ve
> vote for the GENI_TO_CORE ("qup-core") ICC path. This vote keeps the path
> active but does not request a QUP Core 2X clock rate.
>=20
> When the CPU enters a deeper idle state, the missing Core clock vote can
> leave the console RX path unresponsive.
>=20
> Use the 19.2 MHz Core 2X vote at low baud rates, while retaining the 50 M=
Hz
> vote at higher baud rates, so that console RX remains functional after de=
ep
> idle transitions.
>=20
> Fixes: 7cf563b2c846 ("tty: serial: qcom_geni_serial: Add interconnect sup=
port")
> Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909-correct-ic=
c-bandwidth-vote-constants-v1-0-fbebf6b3c341@oss.qualcomm.com?part=3D2

