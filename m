Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793800838;
	b=Ja3KL6lO1ehPgxYNQoLoxfEYyjVEeluIQ6xrDatF6/KLF+4Ad9v44z3IUzjoflS01/DX
	 gK5GUUGWGC2hGaPBE+j+T/xOw2vOFiKqaDKuo1iqv1t8JzqaChJmGOpbeCaouvg0tnnxZ
	 yE4w+VpYUkDad7JXXsSOV1WTWmTpcgDRkaH0qJsD1xuzW5AbmhSa+IQymKxIi1ae197Q1
	 +g+etzKUaQvg0Il7RBOpsvEsKSiMs1WLLUN0g7Oe3aIPBbdYoK/cqDzljYxS2x2eqjnQ3
	 OWgeipLe7tecbTr7GY6sh5l/31n2bFbNWuC0m9Vx7E7HnouN5c/ozg8eIftrZpLXYug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793800838;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=EK0JUgp8OCD/gxw0LjPEg0NrLddUOwjtQqQrgH4Zeuo=;
	b=cvgT0gGsapGErvkFE6eKhSr8GJU/suBqbkFc6JEujIdtyO9DaaEDmGVlaoLNLq2r9d1Q
	 prEHkmaVfiggglqKk0qRLr63JoIGXPulLFf9+XOAM0cB34t4HcbCsVvH9dWuwrxqicTbY
	 A4Fr1uWRHgHLLQZLxKa9Q2vNSgqVMknVS2UII661CTcQYfJcLn65LBTytuvVEcDk9+Nco
	 qd1g4nbtZ4hAzKP2oKPs3EjbXwca0rpJz+JdT4Z7OQ0PcRAoXzaqehPcMplMNz1P4ftNv
	 HiKKLCcoCm2sfij/nSfAhcIvFdUYnVuyENo1Fdu5bZJ2esE12hbQqIusnJgW5guaDeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lVAYG9Bm;
	arc=none smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900F2606A339
	for <linux-serial@vger.kernel.org>; Wed,  4 Nov 2026 14:00:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 900F2606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lVAYG9Bm
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1ae18eb9ad0so721210c88.1
        for <linux-serial@vger.kernel.org>; Wed, 04 Nov 2026 06:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793800838; x=1794405638; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EK0JUgp8OCD/gxw0LjPEg0NrLddUOwjtQqQrgH4Zeuo=;
        b=lVAYG9Bmc2hoKTJuJzSrH6J+IhryAyiDTSMdo0aYG9mfqjPS/ga8+3YK2Ad//sbXE2
         HHofzfmuuJ/nJx0kE/6IytFncp6WqXb39RvQM+YnlJNPVlx4UDFXx8nAXhQykpg/r9dU
         TTw9D3mrL7B/AtTF/tGzwS4DWBrit2U6UIDoeAg8Au1ygMhfLw7GRk8WtuLYUaZkwSTF
         aYRfMnD7tWD2+C7sh5TWr6OTrCzca5srbXzkmLr+/5fdNnNFJYIheqB8xKYVa8MXmxFB
         4bAPEVWyyZRmC6vgyn2/OYmqQ8nZ9BmRTU8WOS8FvaydjpnVOWQKGf91yFtKwUSqhNCh
         RSlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793800838; x=1794405638;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EK0JUgp8OCD/gxw0LjPEg0NrLddUOwjtQqQrgH4Zeuo=;
        b=Kb2EWC+VyqY94H2MFqJW/yuKmCJRf/3AdpBh1DNT6AHwC9aaErQemPUv+2+vyfiGsV
         dJbO6NJUMW1rLObEEsQw5A+mq0k2RaBD9lO/sI0YOyLK/XzabX5n3rWwM0+3+5vbp6uB
         Uw9DGuEKU/SWTtALbmYdTcvP9It4+tiuyZ9oF3/VvSkg1+kofY0tsIpoubDt4qKq6pzH
         vt8HgzWUezmqUsf07VPF1Frw1zwb8kcTI1Jm6q89dxKmPBtGrjs4WDhZemu9qJms/c4z
         tyZ9+gXO+Q0CH/QZcWRTHvHUsWZe12MVEb0tEb9CVjRDN+t9zLxtxBcaSJPf048t6i/0
         qPeQ==
X-Forwarded-Encrypted: i=1; AKwUvBymcMoI9gr2QV0lzjfqk+9ue+ZylaHn/Hj3QOlFeO1Cb1aAVUV1ESebRl1YAvJkbDhjokP+YpaeillZAog=@vger.kernel.org
X-Gm-Message-State: APuU4Z/5NwywtxxBChZUKZXVir7pLwo9NoZ22ot9wI005s0HdoqlAIW9
	UhT76SV7Gss3m/oF/PfsQCdbXxFsBmyZntQu78i8DHK6hasN87twpCb7
X-Gm-Gg: AYBFou0xxVtbd8C23agL76g6Rw/A+ySuMUThpOHC+6MhpNFFJj65Iu+1HxvZrR+p8nl
	2FRs1dWijtQkPyhv8XBzzd9irZG22EN7WdutXhQDfMyIVjHO8WtqF9URPmIpnKWKg5F4O/Y+mdx
	3c97oLs6RlZKc4Z5ykZonb3t91Xsn1HmUlbGY9kYF2H4dHQh9k4QZZizzcQkhk1AumXBxNir+Ig
	EqnWMxYSjbsFdx227soHcZHFJUgfWWbrPB6T/5PKPieGtlnUVmR6KP6GjvuLbS6H42yfzUL+LPr
	ytx0K+cM3ScIEs3thiWttBXf8JbJcwMXzuzJ+1mjQQz7cYtj43PvbSwDLL+kEtiHzOqzssZHnWj
	ZYTYKcIul9r59WpbegKMMieEzb8eurEhNaxyokWXioZhLzw4csUfzpT6kyzSnokG6gwoHwaCh/v
	KzWsZp3T4C2utIbZivwDwOldz6y3DlGV+wSFp0kaKAw+z3w1mMiZH1CWH/54rUMTEZq80Tgjqxl
	wfDgdvZ3G8F/AHWt2UqwNCwACmxUP5z1mszoiHjhd0H3nYdbjQz4I2S9QMqdoQ9+zzLaG8g1wxP
	VHEK3o34S7a2rZTDuCqjiOvWTUPvQTH6rlKSRzbBpTlCyeZD7VgBX/a75kjcuNjlfvm+0I7NdPo
	Yz7c=
X-Received: by 2002:a05:7023:a89:b0:1a8:9857:2102 with SMTP id a92af1059eb24-1ac5f183841mr25563977c88.30.1793800837135;
        Wed, 04 Nov 2026 06:00:37 -0800 (PST)
Received: from localhost ([2.27.148.106])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c30521sm8553620c88.13.2026.11.04.06.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 06:00:36 -0800 (PST)
From: Han Gao <rabenda.cn@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Han Gao <rabenda.cn@gmail.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Michal Simek <michal.simek@amd.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Zhiguo Zhu <zhiguo.zhu@linux.alibaba.com>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Linus Walleij <linusw@kernel.org>,
	=?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Thomas Gleixner <tglx@kernel.org>,
	Radu Rendec <radu@rendec.net>,
	Samuel Holland <samuel.holland@sifive.com>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Anup Patel <anup@brainfault.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Drew Fustini <fustini@kernel.org>,
	Icenowy Zheng <uwu@icenowy.me>,
	Inochi Amaoto <inochiama@gmail.com>,
	Vivian Wang <wangruikang@iscas.ac.cn>,
	Yao Zi <me@ziyao.cc>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-gpio@vger.kernel.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	linux-clk@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH RFC v3 00/17] riscv: add initial Zhihe A210 support using SCMI clocks and resets
Date: Wed,  4 Nov 2026 22:00:30 +0800
Message-ID: <20261104140031.1172491-1-rabenda.cn@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <9b99c531-1977-4bc1-8105-bd9c3e129951@kernel.org>
References: 
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi, Krzysztof

On Wed, 4 Nov 2026 09:24:15 +0100 Krzysztof Kozlowski <krzk@kernel.org> wrote:

> On 02/11/2026 20:45, Han Gao wrote:
> > This adds initial support for the Zhihe A210 SoC and the Melon Pi V1
> > and V2 boards.
> > 
> > The A210 has four C908V and four C920V2 cores, plus an E902 management
> > core. The E902 firmware handles clocks, resets, power, the PMIC and
> > CPU DVFS, so Linux uses SCMI for clocks and resets. The only new SCMI
> > piece is the mailbox to the E902. [2] explains why I picked SCMI over
> > RPMI.
> > 
> Considering how vulab@iscas.ac.cn is ignoring reviews/comments and spams
> with a lot of unthreaded emails, completely disregarding any tries of
> contact over last 1.5 months, shall we ignore all contributions from
> @iscas.ac.cn?
> 
> Maybe this will be the only way to actually be heard?

Apologies, I am unable to communicate directly with the team at vulab,
but I have passed the relevant information on to them;
I trust they will handle the matter appropriately.

Thanks,
Han

> 
> Best regards,
> Krzysztof
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

Sent using hkml (https://github.com/sjp38/hackermail)
