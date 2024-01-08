Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1111537F0
	for <linux-serial@vger.kernel.org>; Mon,  8 Jan 2024 16:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lEDsrMlU"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-680d4584a81so16710776d6.1
        for <linux-serial@vger.kernel.org>; Mon, 08 Jan 2024 08:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704730554; x=1705335354; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2TgBDkQz+4qqwrUlFCPQLEvy6TMuXVBnRueM2UoZXNw=;
        b=lEDsrMlUqJcjBA0GPsTf4Lsk5MSsaTDnclScpEaapUC+RcMYmc8b22E0rlWZJaZ/NX
         cz9TrqwxmuCAqD4aL7HXamvftE925SxLcW7cMmNlhG58Br1jkH1odpBEqrWNn0u5YMmA
         SZL7YA7Wp4EdV1e5bQlOFMnE+NxTl3akFTxFk23nPTEED4w2y5+jDMnZdatUE1+c9fiy
         R4/n6ptkL4U3mE8XCsMBaEiTZkEFj1RBYYG+U3YNBbQI93FnbJ5P4r8IA0I7kCdb9h4O
         gpg4pTBHquXpbvepKASbHWEGYUxeEyTVAVfSmefMeXSs7qsL8IsmMMgqgDD621IhdBO+
         uJDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704730554; x=1705335354;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2TgBDkQz+4qqwrUlFCPQLEvy6TMuXVBnRueM2UoZXNw=;
        b=wm9pkBK2QX/gRu3pduqInPYvW7hnTKHCAWwHJGb6r6h62EsfyYZ8dmeYjdH/GkhCVB
         e0G5fJxXMGf9cwSv1dbdrVfWiR0iMf+TZo/tHj/A6tVMyFh/NrMo+UjlytnoYXt3fuwY
         HWj2B85Uth5alnAUrdIb0nnjKlBpy4nij8pRwmkbTNRdl7VA5nr64DjbsOEEc9h4XEn3
         m4jkwP02IwUEN75R/vz3DjzlTBW/U6v8ZNlXy005BrjgOAgai8fq6HEiNeXlNshcMkDR
         fnEP0soQg4x79AgdnOOKKSpZeL+IClWmlDiLTWcog1LDKihhRnpyqCAsKW9o4DBCiFk/
         mVKw==
X-Gm-Message-State: AOJu0YyvbzrcDOabqdMCUgQytcfN8yXb3mDB7+Ut05FheM39S2ivLv0e
	Ub0pdmq983fR4LyoTdQ2EZZ6LKykVsyBtitWzfePWD/ttElJRMyd42PwVQe7/ec=
X-Google-Smtp-Source: AGHT+IFxmRb3UlUaz+5aRpILb3jdoFFWR4KwyrDk0NnaBENQjhicBr2IqyEiJ7fJsWqZbqxFwWANocDQ6lrKRKI0Z1A=
X-Received: by 2002:a0c:fdea:0:b0:681:933:c8cb with SMTP id
 m10-20020a0cfdea000000b006810933c8cbmr1443382qvu.63.1704730554613; Mon, 08
 Jan 2024 08:15:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231228125805.661725-1-tudor.ambarus@linaro.org> <20231228125805.661725-13-tudor.ambarus@linaro.org>
In-Reply-To: <20231228125805.661725-13-tudor.ambarus@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Mon, 8 Jan 2024 16:15:43 +0000
Message-ID: <CADrjBPpUvi+f87UrpeEYaQ0zJ3cvp_2MJAvMYiZ5hNaew-N_7A@mail.gmail.com>
Subject: Re: [PATCH v2 12/12] arm64: dts: exynos: gs101: enable eeprom on gs101-oriole
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
	mturquette@baylibre.com, sboyd@kernel.org, conor+dt@kernel.org, 
	andi.shyti@kernel.org, alim.akhtar@samsung.com, gregkh@linuxfoundation.org, 
	jirislaby@kernel.org, s.nawrocki@samsung.com, tomasz.figa@gmail.com, 
	cw00.choi@samsung.com, arnd@arndb.de, semen.protsenko@linaro.org, 
	andre.draszik@linaro.org, saravanak@google.com, willmcvicker@google.com, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-serial@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"

Hi Tudor,

On Thu, 28 Dec 2023 at 12:58, Tudor Ambarus <tudor.ambarus@linaro.org> wrote:
>
> Enable the eeprom found on the battery connector.
>
> The selection of the USI protocol is done in the board dts file because
> the USI CONFIG register comes with a 0x0 reset value, meaning that USI8
> does not have a default protocol (I2C, SPI, UART) at reset.
>
> Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>

Reviewed-by: Peter Griffin <peter.griffin@linaro.org>
