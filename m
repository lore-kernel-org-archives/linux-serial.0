Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793801235;
	b=nIEEShr1T4QBEOZt6KbunPO6W9OPeMDPeY9GAph54nRlGpD7KjCNL0pKl3fgQhVRM4oI
	 jfrslkrdm9vtHm8sq8Ekv24PO7cRmVRuiDdND/3a+g1lGfO+w1b7DRpKV5OPF3fIMjq0Y
	 VQA05fB9LZVdFwzmguxcIhBj9DdU46/zphh27zMVZgMhU89YMnG3e9KFAvIT/1f0Zzoxb
	 rZK1FMmSID0AmpeV9TRUMjvPGUq17x7rF/ZcOWSU7MTs+ClS1HJVBtdkfZWxyp6tDfCTk
	 SZokXarabjpHPdPxUdLJdxl3sEZIG6s57vhcmSdXPGdwacT4nqcSf5f4Y4dEaIe/c2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793801235;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=7KdmzCMxpx265Yf+6eArSomaCxxIsqK3NySacZhOFFc=;
	b=i64PlST9fIrKJEjd1XO/febzgskLpz243uUOBS4felBrrSf/1W1TRbaABPOrl3+enVPE
	 /WWJq00RjilOL4IhiMTpRYiX4QdWjm62Bz4oie1wHRsjW44x2pKfh38MYihE6EV7x5k9i
	 l9zHxPudUu/mox+mAE8udU336wEP8aUVo0LZRYHAA65yuJ/DHeqmKqxbt+FWmpfDvh0Qb
	 oaW0NjuaAL3CCCuNzqc5UcOjAVXBbjFiRbJBQPx0Q/45QfUk3GQO140euBomN1SrSzCGe
	 Q4Ujn/Ri2QiW2jxe+wcGmciUjy7+mrKqi6VhFxXFIKKvKQi/y7+u1VlpNRPzmR5iYEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IfY2Fkvx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BB8606A31B;
	Wed,  4 Nov 2026 14:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IfY2Fkvx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 126CC1F00919;
	Wed,  4 Nov 2026 14:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793801234;
	bh=7KdmzCMxpx265Yf+6eArSomaCxxIsqK3NySacZhOFFc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=IfY2FkvxwU5rQPtG7BriJGEgXPopOKUGIVmTT9jN19hU9c8xvgE4K2l+EV9ePaGdI
	 sk1vQwjzCorGrIMKwOP/KjpW/stC2sdqDVRlabuqKdC0YQgVBd5HoN0K+Qbbh2Keql
	 XHwMh7hBzA5cJ8gQGjKx4mxTMYYoqo2QkNY7sx1Fbb+u3DruvIhARjF30ZhgyofuOn
	 DlXOpuOErlMm12IV9vGrEqQxFpDoN7FPiyvxN4UjuC/3WiCTvtFK7wB6VerreylYP8
	 +rak/5bLdixx9lrMhrdaQkgo6E7jfpWQawvVq0EgypGtxjgwRiQ3P9zth7+X/mtTK7
	 tkIrtRnM3+76Q==
Message-ID: <ef0ce951-109c-4423-9a1a-e84c1d40e3be@kernel.org>
Date: Wed, 4 Nov 2026 15:06:56 +0100
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 00/17] riscv: add initial Zhihe A210 support using
 SCMI clocks and resets
To: Han Gao <rabenda.cn@gmail.com>
Cc: Sudeep Holla <sudeep.holla@kernel.org>,
 Cristian Marussi <cristian.marussi@arm.com>,
 Michal Simek <michal.simek@amd.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Zhiguo Zhu <zhiguo.zhu@linux.alibaba.com>,
 Jassi Brar <jassisinghbrar@gmail.com>, Linus Walleij <linusw@kernel.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Bartosz Golaszewski <brgl@kernel.org>, Philipp Zabel
 <p.zabel@pengutronix.de>, Thomas Gleixner <tglx@kernel.org>,
 Radu Rendec <radu@rendec.net>, Samuel Holland <samuel.holland@sifive.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Anup Patel
 <anup@brainfault.org>, Stephen Boyd <sboyd@kernel.org>,
 Brian Masney <bmasney+clk@redhat.com>,
 Jerome Brunet <jbrunet+clk@baylibre.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Drew Fustini <fustini@kernel.org>,
 Icenowy Zheng <uwu@icenowy.me>, Inochi Amaoto <inochiama@gmail.com>,
 Vivian Wang <wangruikang@iscas.ac.cn>, Yao Zi <me@ziyao.cc>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, arm-scmi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-gpio@vger.kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
 linux-clk@vger.kernel.org, linux-serial@vger.kernel.org,
 Conor Dooley <conor.dooley@microchip.com>
References: <20261104140031.1172491-1-rabenda.cn@gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <20261104140031.1172491-1-rabenda.cn@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/11/2026 15:00, Han Gao wrote:
> Hi, Krzysztof
> 
> On Wed, 4 Nov 2026 09:24:15 +0100 Krzysztof Kozlowski <krzk@kernel.org> wrote:
> 
>> On 02/11/2026 20:45, Han Gao wrote:
>>> This adds initial support for the Zhihe A210 SoC and the Melon Pi V1
>>> and V2 boards.
>>>
>>> The A210 has four C908V and four C920V2 cores, plus an E902 management
>>> core. The E902 firmware handles clocks, resets, power, the PMIC and
>>> CPU DVFS, so Linux uses SCMI for clocks and resets. The only new SCMI
>>> piece is the mailbox to the E902. [2] explains why I picked SCMI over
>>> RPMI.
>>>
>> Considering how vulab@iscas.ac.cn is ignoring reviews/comments and spams
>> with a lot of unthreaded emails, completely disregarding any tries of
>> contact over last 1.5 months, shall we ignore all contributions from
>> @iscas.ac.cn?
>>
>> Maybe this will be the only way to actually be heard?
> 
> Apologies, I am unable to communicate directly with the team at vulab,
> but I have passed the relevant information on to them;
> I trust they will handle the matter appropriately.

Thank you.

Best regards,
Krzysztof
