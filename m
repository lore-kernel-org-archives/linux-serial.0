Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79B641CB56;
	Tue, 29 Sep 2026 06:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790664312; cv=none; b=ii75jfv0woQN/+Nvycomb2xTWkXCCGb5QuvRDk54TaBeu12LKOQQSpRMq4Jf048gz6esrN2ykysYRGuUax4pRzF0742ePAFk1APX+wsoBmsO27XSmB8qOIT0IIbIyTKe1ClG+51FuANI2XfamXCi9w8HtpncALglrE+xh1lQRyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790664312; c=relaxed/simple;
	bh=G5zFNDaRofYyEO7QPnbdPTFANbG/gza9yvu5YfV+A3U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MXydOoG/Ur+Tfh36yPS/eFEeTRBKyHAX17chKK+Dd4Lx8KrFSBXBpQ//KVqAI1APsTbqYKfZ7HBsYgi4rJKnzzfsxv2B72ouMm16YNwtVuanww17WGWd15wPzgl7+PSnh3kqLpgfkdLmUskNDyeyZoxpVQ824EID3bd6gaIS6CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gy5Ukg4Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gy5Ukg4Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DAB71F000FF;
	Tue, 29 Sep 2026 06:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790664311;
	bh=G5zFNDaRofYyEO7QPnbdPTFANbG/gza9yvu5YfV+A3U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Gy5Ukg4QZDE/ottoyJECO60FQnDIcUc7/FvaGYlG19Av4npkxrTfyKn6Z8jyici47
	 Z57SQfaEs7vYkvNqD6hTEB0say8DDhmTj01movMTSHbzRvhSUHLfAQ3bl7QBAKVVuV
	 9hr/PaDL4n3EwK/d1GXHVXVvshfYodXx8MLtw0PVd43qhBV38N5xVxQk835qOdT7k8
	 sGzKh21T+jZbSR6csgJLT/E5LQafAzHT+qO2B1hRVu7sG78GqInmnauxkbgRNqyfzF
	 rz7PlsnVoKd+QosUwgvOFmh6I/ofCz2vV9w9y5xd6dns+6Ish5rrMSORPfqMUz2GzM
	 KZSL6rw5IwQBw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 05/20] i3c: dw: switch to array-based exclusive reset
 control
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jisheng Zhang" <jszhang@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-i3c@lists.infradead.org, mfd@lists.linux.dev, lee@kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, Frank.Li@kernel.org, devicetree@vger.kernel.org, linux-serial@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org
In-Reply-To: <20260929061417.20733-6-jszhang@kernel.org>
References: <20260929061417.20733-1-jszhang@kernel.org>
 <20260929061417.20733-6-jszhang@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 06:45:10 +0000
Message-Id: <20260929064511.0DAB71F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> The Synopsys DesignWare I3C master controller can have multiple reset
> lines, such as a core reset and APB reset.
>=20
> Refactor the driver to use devm_reset_control_array_get_exclusive()
> instead of a single named reset handle. This automatically manages all
> resets allocated to the device node sequentially.
>=20
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929061417.2073=
3-1-jszhang@kernel.org?part=3D5

