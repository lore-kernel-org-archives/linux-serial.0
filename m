Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794728249;
	b=XdVK0DiSuK76/ZD8aZPuXJvtfs8gwiQKapthV/IRfU/4kdVIDlSqQha5yXkbkocsC/vP
	 BNqSK2vsmezXqEBJ9HB+lYlhqkoHSVXchCqQyWg/GfE2JmKHrIJbTWprbVyJ1RMlFlYAN
	 sNEAQyixZ/X0nxGoaQCxgk2JDuXfIfdIv3xYwFSMk5RXilUWtiEdrhzJEnA/5ZOg02/XR
	 69+l6QYw0m9pirFHTxTH4mDqCryjiKIcrcQKCgmymsw9cJO3itCn28JNSsBww0Lga5WRo
	 3hYw/u7oM/5dLhjmkxyCbbdPuCwJA6W4lFKuDzJSa8E/9lB0SDDuTr2x8QwbY3OR57Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794728249;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=1wZ0e4vkh+ufl/6hocG0+kvzLhb5fc3i5s+Qidawubk=;
	b=Y8tII01ayrPptLE/zLbV+XPRWz2a+1XzageDHN5Sptq32pIBnIOyQRF7qhSvr5/fcex1
	 ncgsvrASzBI3DmsWfV4cpYTa77fjTyZaJHoKy7svC/XDM/tblgn/2IzqSNz71PN4qObui
	 Y0n0/xjbcI52/U0ivG/6DBxI72doqAHh9noNhmTKTC0u/iPHBsfwAlsw461vgy1QhCQ25
	 BHtKvTB5f2Q0ahCLWh8ZqVxejAXjHamKgmu9+n9VzTThdurxZ1uZ/1f6rH4NkmoC4MQwY
	 oUyjXvCXJtiw8Jvk9tJAGypC3spNw9ZldYt9S7MITRPBgg5fhLRPdKiBsUb5OcVsCfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K0McPI5I;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73369606A31A
	for <linux-serial@vger.kernel.org>; Sun, 15 Nov 2026 07:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K0McPI5I
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25AC21F000C4;
	Sun, 15 Nov 2026 07:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794728249;
	bh=1wZ0e4vkh+ufl/6hocG0+kvzLhb5fc3i5s+Qidawubk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K0McPI5IZZYydKCPmHHS6QUd7fFNBDoTOd1TKoA4SdI8WvYklc9kbCep8i3nMkhrj
	 5SctuHVaZT+zqNL1uL1KAHp9eoz9pPJSAXGBDIGscyQ+Jz7V9L6vC4pOjhrftHp9cN
	 bZPJkwz4m7BcbVOI8HIsjCEzux4RhiXOHfuStXyPV9wS25XaSmjwS5bGurufvdYgj9
	 +H/TPQCV13lzMRb5/iMqfnGK9zJypdn2/ixLKnTVIidFqa5kaVYLvrcB4SsE4E+VXM
	 83iP3DrK1L3P6f+a2/XbHZBoLFbA+71cNBjMjN39C/hZM3gJL4xFT3NDcPKoSzV515
	 Ap9dzeF+UdWsw==
Message-ID: <sashiko-outbox-215265@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 08/10] dmaengine: dw: drain the tasklet before
 releasing channel resources
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261115-submit-dw-dma-synchronize-v1-v7-8-8d58f3d49e4d@gmail.com>
References: <20261115-submit-dw-dma-synchronize-v1-v7-0-8d58f3d49e4d@gmail.com>
 <20261115-submit-dw-dma-synchronize-v1-v7-8-8d58f3d49e4d@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 07:37:28 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> The controller tasklet invokes callbacks after dropping the channel lock.
> Releasing a channel can therefore clear its configuration and disable the
> controller while that tasklet run is still using them.
>=20
> Disable the tasklet before clearing channel resources and re-enable it
> after updating the controller's in-use mask. This waits for an executing
> run while preserving pending schedules for the other channels. Have a
> pending run return before accessing registers when the last channel has
> already been released.
>=20
> Fixes: 3bfb1d20b547 ("dmaengine: Driver for the Synopsys DesignWare DMA c=
ontroller")
> Cc: stable@vger.kernel.org
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261115-submit-dw-=
dma-synchronize-v1-v7-0-8d58f3d49e4d@gmail.com?part=3D8

