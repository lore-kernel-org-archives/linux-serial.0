Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793798081;
	b=cI7nqa7/IyxUAslK9NUkaaVnFOoh0QFNjJBRALbVwnwksBIDd6GeG9Vn1US/KLozSdXT
	 YORQ3kzV47hcIs6GRN6I5KAZywjjFLfP3NzpB9F2QGbNfdN8fBywJiYcozeDo1RHt4H7m
	 3Goh8Nt1iwWSxm/MTVX8F9Me3F2uJYDrc0mrJo+rc7KWDW/F+fk2fYtSRH6eWbHQ5vMrI
	 f40ZHQ75GTFhQTMlKYD4QR9LveJCj9aVFACM7rcaUQMBxKBlqoPDhuzt8LOA2eCyaE5Is
	 gHWhWITGXZUjijP07flz2gTqw+xh0NmkgfIe69OTXBpi3tF0PCjfM73cQ78a1uWdj5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793798081;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=/p5+Pyk6coILlORdcQBpVHNHSFgdC438Pn8Lrp7EWZ4=;
	b=FHFt6sjvrkN3i/jj12kVH27zZoOM9TJm4dHJC/NJOD5eE6sr2GxJlp/O6T22bkWiQ+5B
	 9KlQVkeqfTG6+GvcD8EzatjIZsvuKj/eHrGERdiq3Bq5q7Y2x3CKi3L4i8bsY2rgvw0Qq
	 +HVTOTBEer7E0HMb3tK5teRnVF3VW+v8sWYdgTYrfzZpNnMUxIvgTGaOY9l+VNnvtgRs7
	 yXE81VLMzRtjCpF6mIehjHDflqcbNHDf3m6EhqBrHFEDLAG70OjgKHj36Y9pdDWriVNmC
	 iqgDtDJ5qK2ogUB78mD6TOJ8fjxkymq63bV7As/HGtSGHEHZ0k0+9WEm2HaYokvqfoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PSwVh+0e;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079BC606A33C
	for <linux-serial@vger.kernel.org>; Wed,  4 Nov 2026 13:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PSwVh+0e
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A04441F0093A
	for <linux-serial@vger.kernel.org>; Wed,  4 Nov 2026 13:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793798080;
	bh=/p5+Pyk6coILlORdcQBpVHNHSFgdC438Pn8Lrp7EWZ4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=PSwVh+0eCTT+b5fCxey1CsR0b6m5BP0NC9rEWv/qGoVAp7z7b/X1baMHbpDnRhHw0
	 1IlSHrcLAlVsg55IpOJF5Nkvf2vaGC/fHZEyKH+Don9up9zSqgKV37V5nainUewRr1
	 tAyK+1WI3fZ/i42mU5cbzo+HvC/82f7rkN3yxsVGBPX5SeP8DXJpSKARcrEvAMNSv1
	 RLgoTtiG3rPcDWuwk0+yNZkdNee1OkZ9GCZo58XY+OQNfYVWhHMw4oNuRfTNNgiFs7
	 4AkeoxFWz8uacgEWDIjPHFeVRqn52p+Yr5AhY/9vo5pidgnseQ+ftRBNMagtn2p8xU
	 Pbq1Di/rgQkDA==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5bcb440d1cbso428130e87.1
        for <linux-serial@vger.kernel.org>; Wed, 04 Nov 2026 05:14:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvByRjMeWNYlKdVUAimQAKtZ0CSOTAw3mb99YylvmwPGH6N3gnDKc8M2+oQtp+d0gk5MEvZZQ3leXRBMc7To=@vger.kernel.org
X-Gm-Message-State: APuU4Z8BLpqtG3gkwjdIl5dlTwotPKRCdtxV/qGVmdQUH82TDwCyd5zH
	wGVAqEJUBIXtSXBv04hZQQfomWcjr3uI868W8cPgx807hBJRy0Q3p1GM5sExdz3blzl5R4eEanS
	fLtQeK3uy173fTI8WA6AEJVLAUQfeR8Q=
X-Received: by 2002:a05:6512:3d93:b0:5bf:ac46:c5d6 with SMTP id
 2adb3069b0e04-5bfd956d81cmr4929046e87.12.1793798079384; Wed, 04 Nov 2026
 05:14:39 -0800 (PST)
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103-a210-scmi-v3-0-ee6b31580808@iscas.ac.cn> <20261103-a210-scmi-v3-6-ee6b31580808@iscas.ac.cn>
In-Reply-To: <20261103-a210-scmi-v3-6-ee6b31580808@iscas.ac.cn>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 4 Nov 2026 14:14:27 +0100
X-Gmail-Original-Message-ID: <CAD++jL=5SypKyjwb71hT2pzTZ3s9qi62JG_EevyjTjGgTZiE8w@mail.gmail.com>
X-Gm-Features: AclHuK-6MXT5O-NfPKrU9YAGzhqKyzaaZr6RTIvrirwYp92eUVqCIspXmcEerPc
Message-ID: <CAD++jL=5SypKyjwb71hT2pzTZ3s9qi62JG_EevyjTjGgTZiE8w@mail.gmail.com>
Subject: Re: [PATCH RFC v3 06/17] dt-bindings: pinctrl: add Zhihe A210 pin controller
To: gaohan@iscas.ac.cn
Cc: Sudeep Holla <sudeep.holla@kernel.org>, Cristian Marussi <cristian.marussi@arm.com>, 
	Michal Simek <michal.simek@amd.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Zhiguo Zhu <zhiguo.zhu@linux.alibaba.com>, 
	Jassi Brar <jassisinghbrar@gmail.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	Bartosz Golaszewski <brgl@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>, 
	Samuel Holland <samuel.holland@sifive.com>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Anup Patel <anup@brainfault.org>, Stephen Boyd <sboyd@kernel.org>, 
	Brian Masney <bmasney+clk@redhat.com>, Jerome Brunet <jbrunet+clk@baylibre.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Drew Fustini <fustini@kernel.org>, Icenowy Zheng <uwu@icenowy.me>, Inochi Amaoto <inochiama@gmail.com>, 
	Vivian Wang <wangruikang@iscas.ac.cn>, Yao Zi <me@ziyao.cc>, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>, arm-scmi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-gpio@vger.kernel.org, Paul Walmsley <paul.walmsley@sifive.com>, 
	linux-clk@vger.kernel.org, linux-serial@vger.kernel.org, 
	Han Gao <rabenda.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 2, 2026 at 8:45=E2=80=AFPM Han Gao via B4 Relay
<devnull+gaohan.iscas.ac.cn@kernel.org> wrote:

> From: Zhiguo Zhu <zhiguo.zhu@linux.alibaba.com>
>
> Add a binding for the AON, PERI1 and PERI2 pad controllers of the Zhihe
> A210. Every pad is muxed and configured on its own. Functions of the same
> kind share one name unless a pad can select more than one instance of
> them, as with the UARTs.
>
> Signed-off-by: Zhiguo Zhu <zhiguo.zhu@linux.alibaba.com>
> Signed-off-by: Han Gao <gaohan@iscas.ac.cn>

This LGTM, just waiting for a non-RFC version and DT bindings review.

Yours,
Linus Walleij
