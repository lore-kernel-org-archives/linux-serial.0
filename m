Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B11C19E7E3;
	Tue,  9 Jul 2024 16:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720542866; cv=none; b=nu/+3FUzpiNe1gemeKvg0qaHgP186SZM5lUZRG8DrjG9Uor2CoVBw0Ohk6BpxkceOxiTEGluyV0ZkchGWLCD4F9YuLR8hmjgr0PywXU7jbygL78U1icBqb101A6xF7bBmGJYXbZC7xMkOpYfrZ6HnmOWmHzatTZeI4kf74WsReM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720542866; c=relaxed/simple;
	bh=E2za/mh8ktg1bgavQy5omJcI/K13Hs0AayEZ5BBlLwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c4lNhufg9Pij6Hjd/KcJ88HB91ba+MOdSMI99JiMA5NRFf19cVUhHpF1wTVK/D/CBafUxDgEqHGrhTylJwdj97sS2o/PKGJz+mSgC/FML4HxuE8RMGGQblMTdn7Q/snW5gDcFlSl8TKoWEh6pauWiR0GOyHYv353eqZWiBx6Ju0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bE3mYPur; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bE3mYPur"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EE01C3277B;
	Tue,  9 Jul 2024 16:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720542865;
	bh=E2za/mh8ktg1bgavQy5omJcI/K13Hs0AayEZ5BBlLwk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bE3mYPurLZlXi269n7C4A8hA023tud0MrA3v63hXbQ3NFw2GC5hWWTa4aKb59TToz
	 1xtJP/DTbBaanRoJVTOKJcytnOJS7ny2COOZ3x6VOzt9tSy9WZi9F2j14Lgyt6Sni6
	 SX37n6gPcs9XC6DF8/FxfiJgibtz5X8XUqmIj83Cpqj5zFrKk7oMIqSpAG42IWYJ70
	 xs5oQOjYW6ZBPyNLpIKAFxCgpdv8/HwMM7j22bUiSn5/j0zwmR2Ug46/3g+UnL0Y+e
	 zOj1u7o0/KqQa6aClSyeqKM7HJzRKyaTMwzIzudP565hjVEsayf3nn3FNLGCwVA9y7
	 sgtCwzSR0lMqA==
Date: Tue, 9 Jul 2024 10:34:22 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Yixun Lan <dlan@gentoo.org>
Cc: devicetree@vger.kernel.org, Jisheng Zhang <jszhang@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Anup Patel <anup@brainfault.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	linux-serial@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
	Jesse Taube <jesse@rivosinc.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Samuel Holland <samuel.holland@sifive.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Yangyu Chen <cyy@cyyself.name>,
	Matthias Brugger <matthias.bgg@kernel.org>,
	Inochi Amaoto <inochiama@outlook.com>,
	Conor Dooley <conor@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>,
	Jiri Slaby <jirislaby@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Meng Zhang <zhangmeng.kevin@spacemit.com>,
	linux-riscv@lists.infradead.org, Icenowy Zheng <uwu@icenowy.me>,
	Meng Zhang <kevin.z.m@hotmail.com>
Subject: Re: [PATCH v4 03/10] dt-bindings: riscv: add SpacemiT K1 bindings
Message-ID: <172054286210.3798572.13513101197976115030.robh@kernel.org>
References: <20240709-k1-01-basic-dt-v4-0-ae5bb5e56aaf@gentoo.org>
 <20240709-k1-01-basic-dt-v4-3-ae5bb5e56aaf@gentoo.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240709-k1-01-basic-dt-v4-3-ae5bb5e56aaf@gentoo.org>


On Tue, 09 Jul 2024 03:18:46 +0000, Yixun Lan wrote:
> From: Yangyu Chen <cyy@cyyself.name>
> 
> Add DT binding documentation for the SpacemiT K1 SoC[1] and the Banana
> Pi BPi-F3 board[2] which used it.
> 
> Link: https://www.spacemit.com/en/spacemit-key-stone-2/ [1]
> Link: https://docs.banana-pi.org/en/BPI-F3/BananaPi_BPI-F3 [2]
> Signed-off-by: Yangyu Chen <cyy@cyyself.name>
> Reviewed-by: Matthias Brugger <matthias.bgg@kernel.org>
> Signed-off-by: Yixun Lan <dlan@gentoo.org>
> ---
>  .../devicetree/bindings/riscv/spacemit.yaml        | 28 ++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

