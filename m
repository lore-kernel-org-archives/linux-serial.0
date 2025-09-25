Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5275D1D6194
	for <linux-serial@vger.kernel.org>; Thu, 25 Sep 2025 03:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758772167; cv=none; b=uArBSMnlvga6gxn+s8iX/MomS4CoyJIdjpGNlM/JsXJBOYUmjMzCFeonl8X74dqj/sUzK9/I5u3advs0mpb8OHDSM3XXEybp2QQ4ErBLDGHKbit+vjLKtU5zS6ArtnI7n6hZb7ypDaKgDqaTBg8yl4i+ZYuabDdhHq0oG13Fdp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758772167; c=relaxed/simple;
	bh=9+n9gCRnBkEBRqPerfKa2SKbf3c/Tr4Krnd5g4dgtYM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rbuJdUtKmMoQmA+e3Zc2Nx3TcPZUfNiF3DcPIw5oU9lVP/uBgYJ6YGO64E5bGnJEZSv76b5VVZ0XpsxhDPhLvt+tXMR7m1ikM2PZmacxRIPkB3mo9348oXA++BeIARin4cCXva37RKG45M3WSxfjwQTJSfqVP4AzPq5YSgVQ0qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jsfDDnuO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jsfDDnuO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 052F3C2BC9E
	for <linux-serial@vger.kernel.org>; Thu, 25 Sep 2025 03:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758772167;
	bh=9+n9gCRnBkEBRqPerfKa2SKbf3c/Tr4Krnd5g4dgtYM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jsfDDnuOoRTsAotEjwXnx+o5O9rjzVS+ikzXCcTo1xe4ArfrtQ0WatU7OlcT1cqjg
	 wgmMC901YzDaSEFgCtXOJBub9uLJqCaAYOQ/lnak1VKR7qJiGeaIlMhCv3jfefis5L
	 8+lzaF/dQyhoIMV+9E8lp9Mmn+wNQsPlDntaTYkG3+9ewvxOj+QW8anqV3+ykwyWEV
	 zIh5IEieOYd1cYom+Yce09h7YjMh5uauYCZu1SMzOCiWMOGEMLnbJuKBzP/p3k89/y
	 9KRGuMQhDfhoC/afyOudzpV9hPx9LukRUf3W0TucboOyChwRVn0m0+Myfx0aiAtBXX
	 OVAHpwRQpQQSg==
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b5579235200so392935a12.3
        for <linux-serial@vger.kernel.org>; Wed, 24 Sep 2025 20:49:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXN9dtbspOiZbXqIg5Dhdwk4oWU6TXRbTXiFjc9V633cp+9Fz1WnegqbGGyE0bzhFka8lp8vJxA07BXSGo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/9tB5ILPxjrkC4GnD0m0OMi+DBA+f43IpisklSbA6xi65uH+F
	slMtVvW/d+15KbufFsSqC6KmdXtXYxh2bNt6P/UrNrhEsqzcgEvJsqoQVvGgHdp9u2PM9ZyUPRb
	W+34ejJbMHJq9Us6+ghWJkCY6U2Te2Lc=
X-Google-Smtp-Source: AGHT+IFjawzqKRaaD12Xd3YEwO0IomHNLlG/wP3oUxi1zLoggLLIyHubGHDHQmQ7+xzs0tgBDptLaifCEXhrF1ALb7E=
X-Received: by 2002:a17:902:e74b:b0:24c:caab:dfd2 with SMTP id
 d9443c01a7336-27ed4a7aef4mr22154155ad.61.1758772166433; Wed, 24 Sep 2025
 20:49:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250922-dr1v90-basic-dt-v2-0-64d28500cb37@pigmoral.tech> <20250925030650.35694-1-fushan.zeng@anlogic.com>
In-Reply-To: <20250925030650.35694-1-fushan.zeng@anlogic.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Thu, 25 Sep 2025 12:49:13 +0900
X-Gmail-Original-Message-ID: <CAJKOXPfPxPf8BcXggBYUiA26zi-5bwP4Q9ksRzLEVGtu=3wwVw@mail.gmail.com>
X-Gm-Features: AS18NWDltM8WwcdqU7yGgLoPfQzb0VbbepqXzn4dgQz2wQcK24WQMpY9ZPu2LM0
Message-ID: <CAJKOXPfPxPf8BcXggBYUiA26zi-5bwP4Q9ksRzLEVGtu=3wwVw@mail.gmail.com>
Subject: Re: [PATCH v2 00/11] riscv: Add initial support for Anlogic DR1V90
To: "fushan.zeng" <fushan.zeng@anlogic.com>
Cc: junhui.liu@pigmoral.tech, alex@ghiti.fr, anup@brainfault.org, 
	aou@eecs.berkeley.edu, conor+dt@kernel.org, conor@kernel.org, 
	daniel.lezcano@linaro.org, devicetree@vger.kernel.org, 
	gregkh@linuxfoundation.org, jirislaby@kernel.org, krzk+dt@kernel.org, 
	krzysztof.kozlowski@linaro.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-serial@vger.kernel.org, 
	palmer@dabbelt.com, palmer@sifive.com, paul.walmsley@sifive.com, 
	robh@kernel.org, samuel.holland@sifive.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 25 Sept 2025 at 12:22, fushan.zeng <fushan.zeng@anlogic.com> wrote:
>
> On Mon, 22 Sep 2025 20:46:30 +0800, Junhui Liu wrote:
> > This patch series introduces initial support for the Anlogic DR1V90 SoC
> > [1] and the Milianke MLKPAI-FS01 [2] board.
> >
> > The DR1V90 is a RISC-V based FPSoC from Anlogic, featuring a Nuclei
> > UX900 [3] core as its processing system (PS) and 94,464 LUTs in the
> > programmable logic (PL) part. The Milianke MLKPAI-FS01 board is one of
> > the first platforms based on this SoC, with UART1 routed to a Type-C
> > interface for console access.
> >
> > Tested on the Milianke MLKPAI-FS01 board with both the vendor's OpenSBI
> > and the not-yet-upstreamed mainline OpenSBI [4], as well as the vendor=
=E2=80=99s
> > U-Boot. Because the vendor=E2=80=99s OpenSBI is loaded at 0x1f300000, w=
e have
> > to additionally reserve the DRAM region 0x1fe00000=E2=80=930x1fffffff t=
o prevent
> > overlap if using vendor's OpenSBI.
> >
> > Notice: A "no4lvl" bootarg or dependency patch [5] is currently require=
d
> > for successful boot on the DR1V90 platform, since the SoC hangs if the
> > kernel attempts to use unsupported 4-level or 5-level paging modes.
>
> Thanks first.
> Anloigc already has the open source SDK at https://gitee.com/anlogic/sdk,
> and will submit it to mainline at suitable time.
> It is better that anlogic SOCs are long term maintained and supported
> by Anlogic officially in mainline and for customers.
> The code should be a full feature version after lots of tests, not the
> modified and simplified version from Anlogic open source.
> And we hope that there won't be two different versions code of anlogic SO=
Cs,
> it may confuse customers.


Sorry, but you don't get to control how open source and upstream
works. Community will not wait for your "suitable time". There will be
only one upstream support, so please start helping here by reviewing,
instead of creating obstacles and trying to stop community from
working on this.

There was recently a company trying to "control" upstreaming process
of their laptops and it ended with big public mess. Please learn from
their mistakes.

BR,
K
