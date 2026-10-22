Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792685596;
	b=HF0kmKuYNUHXogtDWN2LdRrv8R0emqMpgo1H3jG1AEXDNr94jmjSofco+yF5nG1bo7sB
	 MpL3iTot622XNShQynF3LeK7UkviDzHXAphLrDZN9BLcuMYmN7hX3D2s038tKd1XdoSwm
	 d8oIqXUyZCijO4k3mUYeFhP/0GJhJkmvJTYTGdBvL50oo89uLgwwVdKpJGnkiwaYLdyrX
	 W5UYo22iWGb8k2IWfpPJW6hRyyCBUjwnB5j8QKD9571+OqfTTmSXMdXNTyTvk9ceQAjWy
	 NW3y8gDiEeKCTaLDPYl4vO7FzxuQx6JUQecH5Zxcr0S/JOcwlo6mMMKjd6vUuNR2hrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792685596;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=bPHzUDom7oPR0pr4mvhfUVgrVhtV9OSuHc/K66Qkv70=;
	b=vZt2O3SNfYvRlwj3vC5Uq7lx234qk6yCd5P0dgQHzXsCuKyplJ8epwWowPAQqS8k343f
	 lN3PD/hQWlJJbFJ9krCYJHItAqE6ljVy1NBqEV1RyJ2hwszFab59IjKrE+kvHSnyRxmjX
	 kf3TgtnevHg0EiJxsMTsSdJSO1gMFLURwcCp/dUCeatm7/7/ADAx4ZyJ6ttzdcXUyvLu5
	 7sjRTgMHgbArx7riIa5+L1FBWz3mo3yUSvmawAOVqJhXOOW83tYpE+mMRJR6vp/P0uddz
	 irk2skSdH3TpOVX6JKRdi0deNifwwSJzptDVC1QK310uxupHYzWraq560UayYRJU68Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A5ipb27Z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B615F606A332;
	Thu, 22 Oct 2026 16:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A5ipb27Z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 473F41F01825;
	Thu, 22 Oct 2026 16:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792685590;
	bh=bPHzUDom7oPR0pr4mvhfUVgrVhtV9OSuHc/K66Qkv70=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=A5ipb27ZSHyFD54WbuFn+Wed95hEp7aIL+PbI4YyLGPhIZt2NuRcZJG8SyMJNJmm+
	 0QDCyZGEohzgSY6QDyVGzQKjcSFItHnrRSoyKrMEPUC2sBhlHRJxgLaY57Hr8h7irD
	 cXGle8pb5fdbRAXuaR2IztkQbmD2hyS3BnWDkv2t6M01wKjYB1ZZlMM686na5JyuXo
	 L3f5nAPKgCuLY9W2ZYN7rNz11x7EzqhffAKznq1+lKAVGiJWR9EKvFyNnIY0DTszGb
	 t+qKw9oeZWPMg8nBSeE6loaU5D+HMi6LdGvEoLwbzAXBXkt/SFmXBNwU89houelcyz
	 V4FHdAPnY8PYw==
Message-ID: <sashiko-outbox-181776@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 12/27] dt-bindings: serial: snps-dw-apb-uart: Add RK3572
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cunhao Lu" <1579567540@qq.com>
Cc: mfd@lists.linux.dev, linux-serial@vger.kernel.org, linux-usb@vger.kernel.org, lee@kernel.org
In-Reply-To: <20261022-add-board-ok3572-c-v1-12-0b0fd85a31ee@qq.com>
References: <20261022-add-board-ok3572-c-v1-0-0b0fd85a31ee@qq.com>
 <20261022-add-board-ok3572-c-v1-12-0b0fd85a31ee@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 16:13:09 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Cunhao Lu <1579567540@qq.com>
>=20
> Add the RK3572 UART compatible using the Synopsys fallback.
>=20
> Signed-off-by: Cunhao Lu <1579567540@qq.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022-add-board-=
ok3572-c-v1-0-0b0fd85a31ee@qq.com?part=3D12

