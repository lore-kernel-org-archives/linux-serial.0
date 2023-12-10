Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lJTndi+i"
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B652AF3
	for <linux-serial@vger.kernel.org>; Sun, 10 Dec 2023 15:36:36 -0800 (PST)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-1faecf57bedso2778207fac.3
        for <linux-serial@vger.kernel.org>; Sun, 10 Dec 2023 15:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702251396; x=1702856196; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wwhdaI8XBubSIfRfAPI160DRLkTYdL3p80yUVHWP+lE=;
        b=lJTndi+iTR1mYF+vqJ2971iNv1s0v7W1CsqA33HteKDeGoo1NLcOD/EcI6GMXSMTCe
         DlSqcLTDBCa0DyX6YM7RxgoF7JldUTXElfAZyM5p/kBCxXUBXuw+sgkhcg86rOO1xILm
         VQqkJlBxVWw0GNygw3FFXD7UqZ0NqkzP9Jsz3HbC4WqSGZheCwOa/FvWPu/tJCcTfhaS
         StsNaqRrrMaYC2Vi7e9bvuyGuQT0uw86HB26rSLCcEIbLW93UMuBQfUbVmeobdk5OxCw
         rn2/m+hVUmV9vb3AIB9Xrjrya5gSnRpjq2DQsMdI+o0I5L13mat5hum5V1C+Ik2HPryD
         dUJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702251396; x=1702856196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wwhdaI8XBubSIfRfAPI160DRLkTYdL3p80yUVHWP+lE=;
        b=aLwERovnv/mX6ywSAlnmf6wtifjEyQi9oAbnr2zPsjypeiTMR+8G4p7xyyzoliK2zT
         tGc49u1Pc5+6SfmPki/z+XHiayFPdyd8kypZdOARwiprkcShxZVyACjqrRvBeWJO4dBa
         XOaxDl1zhOMOyBhN6GRZh/Tcayrqo3RJV/hNM9E7vk33jcFdPkReL83dgmBZelxHd52v
         j3aPZeD8UnYUro9+wXH4ZwQBXujGlR8zk1qBC/4koJkD7Cg0maV4w49GqoK6hPvPdx8w
         yFUyNSRJ1qmEO/BWUVLm+GIb3T79EYFyc/YtgKJ7NB+sl9Un576lRQiqZmjoxvRCdD/d
         bkKw==
X-Gm-Message-State: AOJu0YywHtI1OH1wbHti559/U6D3exfZMr/T2aStitpgIEgtPdbTJHaK
	sk1TiPT8xZezYkjx0I+fhivspgd7vkqTr+8SdGItbA==
X-Google-Smtp-Source: AGHT+IGBq7mUtyfHbN3TWy9RKPBEUdVZWqEc908zIBJVoQI53SI1IAvfmzEwWNQNMlm9DsxGtd8LX7ARxtptPsEGI7s=
X-Received: by 2002:a05:6870:4f13:b0:1fb:75a:de7a with SMTP id
 xi19-20020a0568704f1300b001fb075ade7amr4086371oab.104.1702251395847; Sun, 10
 Dec 2023 15:36:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231209233106.147416-1-peter.griffin@linaro.org> <20231209233106.147416-13-peter.griffin@linaro.org>
In-Reply-To: <20231209233106.147416-13-peter.griffin@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Sun, 10 Dec 2023 17:36:24 -0600
Message-ID: <CAPLW+4nuYHbLuLX=HGsDz6WYtZV3P7yBEmhCXbLW2M+dF1asow@mail.gmail.com>
Subject: Re: [PATCH v6 12/20] clk: samsung: clk-gs101: Add cmu_top, cmu_misc
 and cmu_apm support
To: Peter Griffin <peter.griffin@linaro.org>
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
	mturquette@baylibre.com, conor+dt@kernel.org, sboyd@kernel.org, 
	tomasz.figa@gmail.com, s.nawrocki@samsung.com, linus.walleij@linaro.org, 
	wim@linux-watchdog.org, linux@roeck-us.net, catalin.marinas@arm.com, 
	will@kernel.org, arnd@arndb.de, olof@lixom.net, gregkh@linuxfoundation.org, 
	jirislaby@kernel.org, cw00.choi@samsung.com, alim.akhtar@samsung.com, 
	tudor.ambarus@linaro.org, andre.draszik@linaro.org, saravanak@google.com, 
	willmcvicker@google.com, soc@kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-watchdog@vger.kernel.org, kernel-team@android.com, 
	linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 9, 2023 at 5:31=E2=80=AFPM Peter Griffin <peter.griffin@linaro.=
org> wrote:
>
> cmu_top is the top level clock management unit which contains PLLs, muxes=
,
> dividers and gates that feed the other clock management units.
>
> cmu_misc clocks IPs such as Watchdog and cmu_apm clocks ips part of the
> APM module.
>
> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
> Tested-by: Will McVicker <willmcvicker@google.com>
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

[snip]
