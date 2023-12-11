Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U2ScmQsl"
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B6DE4
	for <linux-serial@vger.kernel.org>; Mon, 11 Dec 2023 02:26:51 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id 6a1803df08f44-67a8a745c43so34462716d6.0
        for <linux-serial@vger.kernel.org>; Mon, 11 Dec 2023 02:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702290411; x=1702895211; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zBClK4lqtI01tZ9y+a3IQvx46bQqW6gXipVJViDNMLE=;
        b=U2ScmQslrt1u3g+i6gniMNpfQY+5Qts1WcyJ7QriK32oNHKU3zmG5WSXyvNxZDvQL1
         PkubSQ+9gocHlgBCwLeKBXK/qDVgf5p5I/eGmbjfiGKiy7TmqsAfmQTsGYXw5nmmtQFl
         klm1xv5gcLHsCKUp/YtIagxl2mS4kbquUXCd5sT72Fnh5bUb6WFeFihE/gk5rzHY6F67
         kYQYWjMoaYUxqIctsbvN1Jo7yes3f923UIQiieQ+ulQl4rk1O4gsTCbmFrKZg3xO6xIp
         qjBxOZGlEy1X7LQ6y3l6ZGA0RXQoE1EQU6Fb8fVmZmbG5+kp0zutoUCZSL9FxWJzrKMb
         aeug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702290411; x=1702895211;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zBClK4lqtI01tZ9y+a3IQvx46bQqW6gXipVJViDNMLE=;
        b=MAbOqPSN7sgl87KeM191AaD9wbCEDPd63/bd+CbhiAztVJslzU1RNC1vEcKjNmVagi
         D9aKbiFSQDB7aIJjhCMOeZFhJnjgeoEJ4PiflrKTCR1P+wmiGbWApYW775wl+f6hON49
         9vBd0a8YVy2xeOmdLXHp178pvvMg+bVaNIlCm/QPToM5QSapyXA0rOpTifcEGGcuk9yF
         oYfeWK38j2ENwMM7yST0hirV2lneVHB5/9iocyL8lKWYuwy6+i/kdWhO+aX/2uue82fq
         5DKFWkKw7oE142iNqxYr5cvRqAbOsXV/7gBTRihaQkDQESM8UNCHfs9lu6QaeKYAyuPh
         yCCw==
X-Gm-Message-State: AOJu0YxVxsZN5Vs55uSV+v8gcakGn7EWsPND5f52xsbLiuZKB7jH5VuE
	aRb353wvzemTJweDehQjXQmcXvgivALNFQ6dQC+ELA==
X-Google-Smtp-Source: AGHT+IGXuSEmjxGIf3QPro+i3LI5BnTbhCqPp7O7UIiBh/LqSwNTV/bm9Ks6TLe0NeBnUASLNjJvb+hNli7R0WXRvsA=
X-Received: by 2002:a0c:fb04:0:b0:67a:ad44:2126 with SMTP id
 c4-20020a0cfb04000000b0067aad442126mr5413328qvp.60.1702290410972; Mon, 11 Dec
 2023 02:26:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231209233106.147416-1-peter.griffin@linaro.org>
 <20231209233106.147416-17-peter.griffin@linaro.org> <25533a7f-326f-48d1-a8a6-e5798bdca4b4@linaro.org>
In-Reply-To: <25533a7f-326f-48d1-a8a6-e5798bdca4b4@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Mon, 11 Dec 2023 10:26:39 +0000
Message-ID: <CADrjBPrg51Fkkme71yLeFc06ROgAjcchXGoX7Uxrmin-+yBayQ@mail.gmail.com>
Subject: Re: [PATCH v6 16/20] watchdog: s3c2410_wdt: Add support for Google
 gs101 SoC
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
	mturquette@baylibre.com, conor+dt@kernel.org, sboyd@kernel.org, 
	tomasz.figa@gmail.com, s.nawrocki@samsung.com, linus.walleij@linaro.org, 
	wim@linux-watchdog.org, linux@roeck-us.net, catalin.marinas@arm.com, 
	will@kernel.org, arnd@arndb.de, olof@lixom.net, gregkh@linuxfoundation.org, 
	jirislaby@kernel.org, cw00.choi@samsung.com, alim.akhtar@samsung.com, 
	tudor.ambarus@linaro.org, andre.draszik@linaro.org, 
	semen.protsenko@linaro.org, saravanak@google.com, willmcvicker@google.com, 
	soc@kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-watchdog@vger.kernel.org, kernel-team@android.com, 
	linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof,

Thanks for the review.

On Sun, 10 Dec 2023 at 14:26, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 10/12/2023 00:31, Peter Griffin wrote:
> > This patch adds the compatibles and drvdata for the Google
> > gs101 SoC found in Pixel 6, Pixel 6a & Pixel 6 pro phones.
> >
> > Similar to Exynos850 it has two watchdog instances, one for
> > each cluster and has some control bits in PMU registers.
> >
>
>
> > +
> >  static const struct of_device_id s3c2410_wdt_match[] = {
> >       { .compatible = "samsung,s3c2410-wdt",
> >         .data = &drv_data_s3c2410 },
> > @@ -285,6 +318,8 @@ static const struct of_device_id s3c2410_wdt_match[] = {
> >         .data = &drv_data_exynos850_cl0 },
> >       { .compatible = "samsung,exynosautov9-wdt",
> >         .data = &drv_data_exynosautov9_cl0 },
> > +     { .compatible = "google,gs101-wdt",
> > +       .data = &drv_data_gs101_cl0 },
>
> Keep some alphabetical order by compatible, so this should be probably
> the first entry in the table.
>
> Same for s3c2410_wdt_variant structures.

Will fix in v7.

Thanks,

Peter
