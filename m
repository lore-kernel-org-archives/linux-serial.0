Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793117894;
	b=UV3WCiU6w/rWrqqV1KaDswccwcnr5VcUlLDEuyYO7sd8QpGxIbMVOHbMLoRTK0ZQFx0Y
	 QCoyJH6gNeFMtijJu/uACJcw5UKnlM1cPp2/sGardA6538+FRn9T2U2sKEcFKVkiZXCvO
	 XQMgOxwz2M0K6HA1mSLshxJ0Z2sMbmk3jd+R9C2mWmhUxJ+OiW2hFy+M9ZUik/hy38v8b
	 SUPJ33EDIJqMZn6dGry5R/SfInWVJm2v673jo2K78olpWMBmu9IERVXibrTLuAmU3+7vC
	 tRlosYL8f9JlIYdg3NpAyKyu+aOrITervvBpc6yRquDNEzoQIC4hU2E2xHF3S/1BPZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793117894;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=gzqWKjNAt9lqP6pzm2jk44aYuqndLp4yTwvo+4KqEyE=;
	b=MEqwQsWqgTxDW/DP1o7vsFe3KykYE4hkr++BQFtxO10+RcV1Vs14hQ4OZvHc7PzWJTHU
	 xw8NdI0TjWlxbQktoBumXNKAI4bgH+FpeZajmFnn+9foZjHQH06b4VhMnGds2J/w8u2UQ
	 0BbGUxxPOf+5PQ3KeLTmaYsLwwwGw33iLC5hIjiRcFEmFt9c9kZRczzdHl1MGJk06CB6q
	 8pppsUV7vHFu06zx9ND58zNwn5l4Sdxe7qDdeh7LQouQnpfcHc04nrqNYwWvS1VWr1YiL
	 JKyMLM4KTqTVNhWuk8GNq5D4uWkAEdQfjWf5+gmW45fYeL2aTqrl8WIWn8kJ2IlcXXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="eaw/6xZS";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B030D606A31B;
	Tue, 27 Oct 2026 16:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eaw/6xZS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17FA41F01825;
	Tue, 27 Oct 2026 16:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793117893;
	bh=gzqWKjNAt9lqP6pzm2jk44aYuqndLp4yTwvo+4KqEyE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eaw/6xZSvd/iUmSOi8x3BJdGmmK2e2Au+98Gmi/jqPb/fsxjYFyg2asyyhJnch6aW
	 wiiYi0eITIbZDq54HaW38SGswS0qGyltyrmNEvvLUgZrcg3MfWR9qehG4imuCVOpGL
	 JLBJMFg4bFYLFuqGqIHPNPdaHWv4b1hxzIOgmIltqxGKohsv70X69oBDXW+gIkAM9P
	 6ksq060/PG/zOz5Emn8kneLWdVFzz4b9Fry3mL204ZqJhnBuP6P3beekO0yFayQ3hq
	 GdLB0wZ1l9tZcPdFY3Dx++WAI2wf8fFk1D10texSvMGm5UdAm082/dyBMfy0jfVO2w
	 miwbGbIVbN6NA==
Date: Tue, 27 Oct 2026 16:18:04 +0000
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Michal Simek <michal.simek@amd.com>
Cc: gaohan@iscas.ac.cn, Cristian Marussi <cristian.marussi@arm.com>,
	Rob Herring <robh@kernel.org>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Zhiguo Zhu <zhiguo.zhu@linux.alibaba.com>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>,
	Samuel Holland <samuel.holland@sifive.com>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Anup Patel <anup@brainfault.org>, Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Drew Fustini <fustini@kernel.org>, Icenowy Zheng <uwu@icenowy.me>,
	Inochi Amaoto <inochiama@gmail.com>,
	Vivian Wang <wangruikang@iscas.ac.cn>, Yao Zi <me@ziyao.cc>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>, arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-gpio@vger.kernel.org,
	Paul Walmsley <paul.walmsley@sifive.com>, linux-clk@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH RFC 01/18] firmware: arm_scmi: Allow SCMI transports on
 RISC-V
Message-ID: <20261027-quaint-demonic-poodle-6c1e10@sudeepholla>
References: <20261027-a210-scmi-v1-0-74d58ce85bd8@iscas.ac.cn>
 <20261027-a210-scmi-v1-1-74d58ce85bd8@iscas.ac.cn>
 <3d38c4a5-1a12-4af1-ac2e-413a457ce4c5@amd.com>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d38c4a5-1a12-4af1-ac2e-413a457ce4c5@amd.com>

On Tue, Oct 27, 2026 at 04:51:36PM +0100, Michal Simek wrote:
> 
> 
> On 10/27/26 16:36, Han Gao via B4 Relay wrote:
> > From: Han Gao <gaohan@iscas.ac.cn>
> > 
> > Mailbox and shared-memory SCMI transports do not require ARM execution.
> > Allow RISC-V platforms to use the existing SCMI core and protocol drivers;
> > architecture-specific transports retain their own dependencies.
> > 
> > Signed-off-by: Han Gao <gaohan@iscas.ac.cn>
> > ---
> >   drivers/firmware/arm_scmi/Kconfig | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/firmware/arm_scmi/Kconfig b/drivers/firmware/arm_scmi/Kconfig
> > index 783c24a20e29..1cfe2b572d18 100644
> > --- a/drivers/firmware/arm_scmi/Kconfig
> > +++ b/drivers/firmware/arm_scmi/Kconfig
> > @@ -3,7 +3,7 @@ menu "ARM System Control and Management Interface Protocol"
> >   config ARM_SCMI_PROTOCOL
> >   	tristate "ARM System Control and Management Interface (SCMI) Message Protocol"
> > -	depends on ARM || ARM64 || COMPILE_TEST
> > +	depends on ARM || ARM64 || RISCV || COMPILE_TEST
> 
> 
> I would prefer to remove ARM || ARM64 dependencies completely that you don't
> need to add RISCV there.
> 

Agreed. Before merging, we should trigger exploratory builds across multiple
architectures. This will help us catch any hardware-specific dependencies,
such as arch-exclusive IO accessors, that I might be overlooking right now.

-- 
Regards,
Sudeep
