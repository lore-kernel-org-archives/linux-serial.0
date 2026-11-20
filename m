Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795160746;
	b=reCj5SbJ1T9JSohquvw8+ziWIGEwL+Wjgb6uOGZlW3mim9ebPxGI2lWeOJkZpWSRNXEl
	 cHgZLh3+x5cxSd2IUsxwvwhNB5oxb9NVuME8ck3XSDZH/ygqKWkKBKByGcIdiqUitwAyc
	 pW7l/R11E5gKgJ/KZLyx/vp1PTh/6f5fLUxAaAPbcxJ1x0FJjHwwVOlyKUGONHLpHB6Ox
	 7YIZS4spVy6TlGFMvAh0ELU3tiIXDvA3uUcMonsmc/k8+qo1/zXOZsBqK0VW2T+uYRBHl
	 d9IKlka4Q3uQrSLbBze7mdk4syfjKbp10n54fkyjPwcQAcOPKQKJ22NK47j8qfsM5sw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795160746;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=yD9IkIxOOiPicvekkh/EANFXaL12GDMFUphxkFRG0GI=;
	b=3PhL2eAoQfr3XnOW/W3g6lJ6MdManTkMGcULzzJ8BRZnAh0jpkWf+TQ1ePaEFCmKLO0x
	 jBQ554mmTUNln46NkUlY4Yn3xUxmEKylGUIs8pBjPo2GGIdgDblTZ1SAOGUc9NBnKjEmQ
	 srP8Yv6Kx10/eEmvYcjkB0A/KFgJlBaPO+CHh18SgD0dFzgPsJnOqiDauXWWD6itm6lLU
	 Z80jRoEomEwX8AROL0ZVrUXku053wYBpsnzjlRApFVLIW1asVcRkKPJSXJUpuePgTkRzy
	 f2y0aQQ3WtUGbqnmMZd85Er6V3WBbmUAN4PdmQOap5oD2rFHE/g/OGQMFjpMnQ4rSJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HLXOuHe2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7CEB606A32A
	for <linux-serial@vger.kernel.org>; Fri, 20 Nov 2026 07:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HLXOuHe2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31B911F000CA;
	Fri, 20 Nov 2026 07:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795160746;
	bh=yD9IkIxOOiPicvekkh/EANFXaL12GDMFUphxkFRG0GI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HLXOuHe29m37pPzm2Pwv+zptLtbNtH/g2QeIoYmf/D1pv8pBcEA67yvQcMXwEqkWO
	 ZNS6HcKEf8Srw1Nsl0zKumhb5Q/cJ/Q3yYycWkhxMLV+QNdgCxnbXMlkrV1yCTiR4v
	 Z5Z3d0CSwudioNRClLUOuw72Rbe5rIeCa05ZaEXX+HwuFNlGabB9iKlSpIMqnpidbJ
	 FBITCPnNB+bSU2DDGpOx2ZzPzpiRk6NiNxEkWemY+O7xMdDa5cQSBMtQl+PTcG2DD1
	 uaCwSP4WZYMSxqOoSSwdMSlo7eovHYWJn0/ScY62SqziM4/vC4mUfHmrLfB+oUGTu3
	 8qUyqxGAz+slA==
Message-ID: <sashiko-outbox-224655@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] serial: max310x: fix use-after-free on remove
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tapio Reijonen" <tapio.reijonen@vaisala.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261120-max310x-teardown-fixes-v1-1-eb52c8b612df@vaisala.com>
References: <20261120-max310x-teardown-fixes-v1-0-eb52c8b612df@vaisala.com>
 <20261120-max310x-teardown-fixes-v1-1-eb52c8b612df@vaisala.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 07:45:45 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> max310x_remove() cancels a port's timer and work items first and
> unregisters the port afterwards. Until uart_remove_one_port() has shut
> the port down, an open port keeps queuing its tx_work from the
> interrupt handler and from start_tx(), and the RS485 code re-arms the
> delay timer and rts_work from those, so a work item or the timer can
> still run after the cancels, on a port that is being torn down, and
> fire after the port memory has been freed.
>=20
> The unregister itself queues work too: the hangup it triggers clears
> DTR and RTS through set_mctrl(), which schedules md_work, so a cancel
> done before uart_remove_one_port() cannot cover it. Tested with the
> port memory zeroed on free, md_work ran after the unbind on the freed
> port and oopsed in max310x_md_proc().
>=20
> The interrupt handler is a source of its own. The IRQ enable bits
> [ ... ]
> them too, with no IRQ handling since the request is probe's last step.
>=20
> Fixes: 10d8b34a4217 ("serial: max310x: Driver rework")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120-max310x-te=
ardown-fixes-v1-0-eb52c8b612df@vaisala.com?part=3D1

