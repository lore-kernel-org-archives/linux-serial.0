Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794467817;
	b=lqHbAYZ46J89f95rrH8mYaMqYW0n9iJJ8mdJOndpxWrV0UYDJeL45LrQ8+5g/qeV75q4
	 VMdhWPUyt9zHCLvlZizUaKkgg9xfEC/hrpnd/CSqJmfuu5iH0gITXLAvAMsUEta2xlfgp
	 MwG9E91jQTc34XDV77SJCXGp9RKsDk3yf9Omoe11yGFPUAbaosgYJeoKT0hp6CSW4RG7B
	 wAcnZJUMQ5/nlhH2/uZZ1JUeVLJr+4YD50II2N89WVJNOnuMJ54oyUDSGlzekuZk2GeCo
	 bigQDVcjfnkW+3jYF1u+XNj1i9mR010/X1gFckgVmITnwO5cSAtLKd779c39eZePnbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794467817;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=JqNPKA3sETYIV/OmRROQYuZ9fY607puUYJjkjB3vKzo=;
	b=LcnizVi1llmY5jC06Cmp2OKVSCyq6FEd48ADZOD3ZP3fxSLUncUh3OIhfp3F8aOhP4lO
	 +USEPA6CW4a1Q1uz9dzEjrICCjAPE7BYkXpQZ20GT6+v/ORKQym1D1IbvZju0N9b4Hoyg
	 aaxEs3Zhhw6cpvANwYI1RuTULvww1xHucbGcRNxyIT3ZXFDaiLP+EHGNJScgFVb83bkWR
	 Omt+qd/r9HRVQmW0iCZuMNSMtesiiyTvC5TpnPuE4Aiuo1L1YIeVOVxmvNimwEp4Rx9bp
	 zVgtRMdOsC8LHpsNghRgbXVBW2NU3all9Fx+NYsoVHppCtrmDLdYG2d4KSY3HVXIaVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lS2bqr6Q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5C3606A8B2
	for <linux-serial@vger.kernel.org>; Thu, 12 Nov 2026 07:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lS2bqr6Q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B61EA1F00A05;
	Thu, 12 Nov 2026 07:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794467816;
	bh=JqNPKA3sETYIV/OmRROQYuZ9fY607puUYJjkjB3vKzo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lS2bqr6QAAWnN6ot3bvsyIsrcYNL/1J6HLAMeaYXc1Yhf+hMXpdu4icWe6+HDQqiI
	 3EuBpI5aiATp/LlQsCC7sUhM1VL4HzzjjmbyIlzX27djAKRrL/ybkfI462yDbmgD8m
	 44eVteeMdhuWJkTLQLaBWSlI5UxMBAdQqXlEO2nmeLsypduIRQMwjON5iqXufSMrO3
	 QH8XLSKErvuTNC3JJo9g1xmu+eF2uMdF59loDy5vcqFugguojVDSPo5mgXGs9JrYFZ
	 QUMTTSVHRm3sT5/lJNpr154DDM6B6pBSrMlNNXt5WCwL5UZnvFmmEJVAvhgMAXOCMv
	 ctCtpvsyqc70Q==
Message-ID: <sashiko-outbox-210581@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] serial: 8250_pci: don't re-enable an enabled device on
 resume
Reply-To: sashiko-reviews@lists.linux.dev
To: "Weidong Wang" <weidongw@illinois.edu>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261112-c3-n108-v1-1-d48f8da5894e@illinois.edu>
References: <20261112-c3-n108-v1-1-d48f8da5894e@illinois.edu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 07:16:55 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Weidong Wang <weidongw@illinois.edu>
>=20
> pciserial_resume_one() calls pci_enable_device() on every resume. Probe
> already enabled the device with pcim_enable_device() and suspend does
> not disable it, so each suspend/resume cycle adds one to enable_cnt
> that nothing drops. After N cycles, unbinding the driver leaves
> enable_cnt at N and the device enabled.
>=20
> Only re-enable the device when it is actually disabled.
>=20
> Found by an AI code review agent (an LLM-based bug-finding tool
> developed by Zijie Zhao and the submitter) and confirmed on an
> unmodified kernel, without error injection, on x86_64 under QEMU with
> the "pci-serial" device (1b36:0002), which 8250_pci drives: after five
> s2idle cycles with pm_test=3Ddevices, /sys/bus/pci/devices/.../enable
> read 6, and 5 after unbinding the driver; without the suspend
> cycles it read 1, and 0 after unbinding.
>=20
> With this patch it stays at 1 across the cycles and drops to 0 on
> unbind.
>=20
> The reproducer, fix and changelog were drafted with AI assistance
> (Claude), then reviewed and tested by the submitter.
>=20
> Cc: Zijie Zhao <zijie4@illinois.edu>
> Signed-off-by: Weidong Wang <weidongw@illinois.edu>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112-c3-n108-v1=
-1-d48f8da5894e@illinois.edu?part=3D1

