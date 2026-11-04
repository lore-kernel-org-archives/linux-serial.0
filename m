Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793797466;
	b=VwqxAc1yqZNFb6UrPGLCXb70YhPPNNtLuZr1Fi7Cujgm56BUo8KiEcDIDJWMV5X5cQz+
	 yB159RVyS4QfFhEBLshI1aP5QoGI/4wiAJhhwQJAkd43q6VinOk7xr8fuOuPlpZv3erOB
	 EETvB/4Kf3+FTqtG3HwNu+Bsi/DvZK98pfZVkNo4biRmWMyjJcCN7/B21/yw/9r8Exoza
	 w/NcX82BVEKT91Hsx4SubkskkzLYgRFOtaTdMlaCRpRjnM2lD0s0+Zyt/e1X8XraLCoOG
	 xFAU34RRHAKs0cAogZRBwFhpKtcR5IbKM/gRke4w1xgwpfrvpTKmE1YCcEeRBm4D+LA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793797466;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=0gGIxmVj15HwpHlgucVC67kzMBeDjNiHcqiz6hAOrv8=;
	b=Rf7+G63k/aMFcj3xQBFXIhqXrp7Us1amWtk/y8/fAoBIaPwy6qA6+WR3jXZqBBv56VYW
	 e1WoCyOy9jRihQ3s/9YEJDe2bT4ttvX192js/258/hbFIUAdAfcc1v9szrAxlzTxqy1Me
	 ApmqMaIcpmvrYGVaiVRL7dTu4/q4PLgu7Kzs183mT/kLyWnaoh+DO8aZHobQ9le7HECaj
	 dt6H8najQuDy/yRTe6kT9wXvJXy23TFN6Qd5srNECzhwNiWIUL10yGszD5JhKsidebTDo
	 aGxkrYwjpOjjKsrfuCS8K/md7LvluZTaFiE/sR1XrujIp5Zk6ZLsEyJWXUdhVlYee3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C182rFoz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687D6606A329
	for <linux-serial@vger.kernel.org>; Wed,  4 Nov 2026 13:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C182rFoz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3225E1F00A2A
	for <linux-serial@vger.kernel.org>; Wed,  4 Nov 2026 13:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793797466;
	bh=0gGIxmVj15HwpHlgucVC67kzMBeDjNiHcqiz6hAOrv8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=C182rFozjpn+i/0Ts1DVq3b+ldJzLaYXncXGSKU5f4XCAI4+yQi49mycFeAVy/gy7
	 8i034pd2KQtcZ+CDX7gNbb1ARO9RfgRTbhmouZunnvcULJfaG9HPLVwZ3ytUngroM8
	 egwAbMwpz9XNDrjkbvaFb7ks4aeC1jnf/7xgjiQSSRWyIkLiOi9LhuCZ0m05jFhICK
	 nr+140ioY7Z+vWkH+hoTBBLG9p9apDmaJAyXwiVWq7Jj1yLXp7seJxi3P3EtW934rg
	 oWpdYy+4j+63c1HAegqRqhpSl5cl6n6imJzOTlCBDI2RliYbTkTkC1EonSRTyah1Td
	 f1twz4w1M1Eww==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5be42ae8eadso444126e87.3
        for <linux-serial@vger.kernel.org>; Wed, 04 Nov 2026 05:04:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBxdVVL09YqUKbo6AfojegUSWH/mNJx71y7S/1s6dwTGX69lgpPNU5qLON9hDJww1bt8S6MzQdiw4ep/84c=@vger.kernel.org
X-Gm-Message-State: APuU4Z92FKzIbxZkZa6w1+7Pb95jDkN7V+C6Q7lTQXV9mDWOcIZ/00Dq
	Q1f/wH7uyMb/4/Pj+cy5KpqGAMmJ3hGfRFEUoPmqPeynO5FwYtr4V7iJHByccTr/6NqQYGTrpiw
	5UF6WYEZxW26bFvysUtEnE9xeyozLP/A=
X-Received: by 2002:a05:6512:39cd:b0:5bf:b166:f58b with SMTP id
 2adb3069b0e04-5bfd95782a4mr5476115e87.55.1793797464785; Wed, 04 Nov 2026
 05:04:24 -0800 (PST)
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261022-add-board-ok3572-c-v1-0-0b0fd85a31ee@qq.com> <20261022-add-board-ok3572-c-v1-5-0b0fd85a31ee@qq.com>
In-Reply-To: <20261022-add-board-ok3572-c-v1-5-0b0fd85a31ee@qq.com>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 4 Nov 2026 14:04:12 +0100
X-Gmail-Original-Message-ID: <CAD++jL=2Z3hP74dHRyE3Aabp+PvpcHX_90PQy+a_HMQwBdNx6g@mail.gmail.com>
X-Gm-Features: AclHuK9_TlXav34NYeX4rfS2IYWnnq1y5c9wSfeOajfltWQaA7IZMQ4oBhaALpc
Message-ID: <CAD++jL=2Z3hP74dHRyE3Aabp+PvpcHX_90PQy+a_HMQwBdNx6g@mail.gmail.com>
Subject: Re: [PATCH 05/27] dt-bindings: pinctrl: rockchip: Add RK3572
To: 1579567540@qq.com
Cc: Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
	Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Elaine Zhang <zhangqing@rock-chips.com>, Lee Jones <lee@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Richard Cochran <richardcochran@gmail.com>, 
	Ulf Hansson <ulfh@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Jisheng Zhang <jszhang@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Wu <david.wu@rock-chips.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Manivannan Sadhasivam <mani@kernel.org>, 
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
	Shawn Lin <shawn.lin@rock-chips.com>, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
	mfd@lists.linux.dev, linux-gpio@vger.kernel.org, netdev@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-mmc@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-phy@lists.infradead.org, 
	linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 6:12=E2=80=AFPM Cunhao Lu via B4 Relay
<devnull+1579567540.qq.com@kernel.org> wrote:

> From: Cunhao Lu <1579567540@qq.com>
>
> Add the RK3572 pinctrl compatible.
>
> Signed-off-by: Cunhao Lu <1579567540@qq.com>

This patch 5/27 applied to the pinctrl tree.

Yours,
Linus Walleij
