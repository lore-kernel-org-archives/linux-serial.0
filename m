Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D9kXV+tf"
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B81183
	for <linux-serial@vger.kernel.org>; Tue,  5 Dec 2023 12:22:21 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-2867ea3abedso737880a91.1
        for <linux-serial@vger.kernel.org>; Tue, 05 Dec 2023 12:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701807740; x=1702412540; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d1Tz+Zhu6CykN3s0r0dZsVml2EIMKxIKO2MhquO/qGc=;
        b=D9kXV+tfM4L7w8d7CWEntA3piGwlMXMm4HiqXHUYakYXNne0K2w1KtfebwiW0NwHfU
         25u6u2adM+BQGj8CLW76z3R2Oj4fEy4PxscxKs9YgdbPVWAMrCgIDCoag351sX6PKYlR
         wuvXDke2FIoLJWanIzO7wVEEMiEEvlyCs1VQC5VMj7PTz3wTEjQUhTgqEYPLiSxULVM+
         rZZAGFU1DPCjYAzD6umznBImflfh1U5cPolWURWZ5oNjnWGBYw0X90Zuh7UB8S1QXztL
         cetyfrMNVOupY7e0ysgkXNLRc0Ha7tkYERyLBTG9Cpt9m8JqOmSFVViEvEKFVpCuFKs/
         LQLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701807740; x=1702412540;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d1Tz+Zhu6CykN3s0r0dZsVml2EIMKxIKO2MhquO/qGc=;
        b=XAdIgQr4FhBKqUTt8c9CkeVBrlS5Vqiu9btrkCuWS4U1rgjvm43U7lv5/ZddIOZyeo
         9sTr3yMVkN0mFAp8cD1L9+d40C8qowFJ0GWBSw8/lvpawhh6sfGsSFOQ+bJtRsNLHTg8
         Mk8wqD4WQKOqBtbUELGhyYOFRWikkk0H9432O4dgjm8+FDYqLgt1n4iAYgk70fiJJpDg
         aFE21lBgJ9UX9tg1XNdyUHLCaV4g42ZS22M8C26KpsZKn9/C4KN2t8yNIqONNnsM6c70
         LdkzybDi+Ay9B6abU27yyYyfpj7AAnzuyEfbKwGYSaz+jJjzk+vVbeyvg/szROdLHhf4
         8eqg==
X-Gm-Message-State: AOJu0YywZBbBxRvRkZ1bRtRL2yJtv5S6E6sFynUhhpn9D4ccltNMYZHX
	PMBQ2YR+VTHNJ6il8BgfokXNjeZakRDJ/YH0np8=
X-Google-Smtp-Source: AGHT+IEz4JosIjEBEt18VO0mFDLU5iQcK5oLQ97ZQOc85crWavGEDEn7/iazArIQHGfN7m9094T11Rk0wvW9WzxzD/0=
X-Received: by 2002:a17:90a:2f46:b0:286:6ad8:5d15 with SMTP id
 s64-20020a17090a2f4600b002866ad85d15mr10531700pjd.2.1701807740501; Tue, 05
 Dec 2023 12:22:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231205005108.79782-1-marex@denx.de>
In-Reply-To: <20231205005108.79782-1-marex@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 5 Dec 2023 17:22:08 -0300
Message-ID: <CAOMZO5Asw8O_=RCrku65ovGb+MARLRtamn05Bw5LaQHFsT2YpQ@mail.gmail.com>
Subject: Re: [PATCH] serial: imx: Fix clock imbalance
To: Marek Vasut <marex@denx.de>
Cc: linux-serial@vger.kernel.org, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	NXP Linux Team <linux-imx@nxp.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, Rob Herring <robh@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Sergey Organov <sorganov@gmail.com>, 
	Shawn Guo <shawnguo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Tom Rix <trix@redhat.com>, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Marek,

On Mon, Dec 4, 2023 at 9:51=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> Disable and unprepare the clock on every exit from probe function
> after the clock were prepared and enabled to avoid enable/disable
> imbalance.
>
> Signed-off-by: Marek Vasut <marex@denx.de>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
