Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U26kuNsD"
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51FA5F5
	for <linux-serial@vger.kernel.org>; Mon,  4 Dec 2023 02:01:40 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-3b8b56d51a6so1098644b6e.2
        for <linux-serial@vger.kernel.org>; Mon, 04 Dec 2023 02:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701684099; x=1702288899; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bd61zuTaGvBLC3sGbDHe9BWUJ17pWi39qwJjhflG3lY=;
        b=U26kuNsDVQE6rWtgetWeAYl4V44DRcukkTomR22YFI2kG/1vHa1IYXNxLAfvWQViuo
         +x2sPJB13lKHAyOnRpSySztUeDF75S5LcPLcmFPljnld4Y9VoQUBLS8yW6JumDOfiyzV
         Kd2uHZ24mkPvPb6nVCssQMEPuhFtUkNX/NkSGLLDWcPI+q4XM8/7A438k+psrMcLAJlQ
         3Y1viFQ0jAOSIoqZuMJy6FQiDOCA4++hnfSHLI8cGEsZixKwWBk8p0kyAIKEnszA3HPZ
         yu8LdYtkvJh7LxlKINz5tGiwTxh1AYEqcurX5oXKuschG2VtIQCg3SSVnLQ3Q56UDGCI
         iseA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701684099; x=1702288899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bd61zuTaGvBLC3sGbDHe9BWUJ17pWi39qwJjhflG3lY=;
        b=liB/EX4kSM8rwwVDmscU5m8lBP8Z219MPoV47tK5HDUrPPhXytFIvMyZmsVyAJ+pYn
         3M/kucacUKwC2mVsjYsyB22b5JU4lSnFV46wqCMHE2P5RAI7fhtIG93EY3gpD5sGYWSw
         3koVWmAw2mq+h2QZhNWJjF77eRxreNfm/DMVlHilowOdf58wnsOTlqsIHZ83Ba3K65L8
         rgseT/YO+ONb/HAE/21iLl19ygne/Rj/rQe7bu/J1NmJ5tIIPP/DQzvAItkIs3pntVd4
         7kUkZ6iZceT0ntalMPHxhthnUdYt0deOS0cxMkNxM2Gy0baRg/HwLEnbG+zMnMzltNia
         SHeg==
X-Gm-Message-State: AOJu0YxSRQkV+Th8TszDPMEZv/gT36xRmKTttvjW/aJaT/VeaYTGXGiR
	ckc1c+XmRWn2TYRz0oNGPE8QaD6VeXEu/gDhy62gFg==
X-Google-Smtp-Source: AGHT+IF7r0Ew0FWzUYhYODnnkZcYZ8yWrhC1tVSYd1MacR7tHoeJD8aD9lTa8JZZzrosDW7LN+dpVK+r3E10uu7dWcQ=
X-Received: by 2002:aca:1a0d:0:b0:3b8:9674:ff7e with SMTP id
 a13-20020aca1a0d000000b003b89674ff7emr2941595oia.37.1701684099001; Mon, 04
 Dec 2023 02:01:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231130-mbly-uart-v5-0-6566703a04b5@bootlin.com> <20231130-mbly-uart-v5-9-6566703a04b5@bootlin.com>
In-Reply-To: <20231130-mbly-uart-v5-9-6566703a04b5@bootlin.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 4 Dec 2023 11:01:28 +0100
Message-ID: <CACRpkdZBLP86A2r=WLiD3eoXiXK2EKW2H=QAeN5ZqYx-bgM72g@mail.gmail.com>
Subject: Re: [PATCH v5 9/9] tty: serial: amba-pl011: factor QDF2400 SoC
 erratum 44 out of probe
To: =?UTF-8?B?VGjDqW8gTGVicnVu?= <theo.lebrun@bootlin.com>
Cc: Russell King <linux@armlinux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, 
	=?UTF-8?Q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
	Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 30, 2023 at 3:07=E2=80=AFPM Th=C3=A9o Lebrun <theo.lebrun@bootl=
in.com> wrote:

> On this platform, different vendor data is used. That requires a
> compile-time check as we access (1) a global boolean & (2) our local
> vendor data. Both symbols are accessible only when
> CONFIG_ACPI_SPCR_TABLE is enabled.
>
> Factor the vendor data overriding to a separate function that is empty
> when CONFIG_ACPI_SPCR_TABLE is not defined.
>
> Suggested-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>

Neat.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
