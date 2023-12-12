Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NNmGExVO"
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 340FBA6
	for <linux-serial@vger.kernel.org>; Tue, 12 Dec 2023 11:44:04 -0800 (PST)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-2030c48c44bso404105fac.0
        for <linux-serial@vger.kernel.org>; Tue, 12 Dec 2023 11:44:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702410243; x=1703015043; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5BQMFtAFEVshsml7NDivd/paYwikSCal1XjNLmVRnaY=;
        b=NNmGExVOdims0tb2N191Wefeh6WM4JRumc+DNPptKdUk6+4kc2hl0rY16wKqn32kIo
         tZuYzJ/qDiBq0OqE8/gCl2a0gloVYNxI0drImQPzpziPqA0miCLzuOO0S5P8MhvN15iO
         oQ48AtiEi7yOoECja7eeJ7fhfOmvhy4vwGT+Oz7TEgnz6i8EK9i451W/TNodza/FsXr1
         UrF0ET/wLPVPCmcyGiSFJoxjnUYsf8NkjBsHXVDbbJ5eJ7kk6WKRxkz/UtHesfWpvzjU
         lsay4KTc7uYVwb59TyeR4vmgNAG+CgWEJQheQAZX1DxRI9jmPpm3FzXy0vEfYw5nBJZ4
         rg6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702410243; x=1703015043;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5BQMFtAFEVshsml7NDivd/paYwikSCal1XjNLmVRnaY=;
        b=thHk8RCpUueMhV2kVQGYpmx50DiVFTELZdogtMG6dWyAaAaTbFW6yc85L3bETgGOcZ
         Pv/DA48Af8Cx7bDEciokrZQO9p55K4TAPG4MDL05EDe4wKDA4wOKaOFByh1Z4fr3ZfhC
         9RVomorLIgggKZpwy5bnYCjMGK4WQq/93vt01pTHOCz9jdZAcOEHcz73fKzv7T8rjHDt
         5IgP1FW/FWQbQqkmR1ATztXl03UwuB+k9/bCYNr0skoQsWTQE6VeGZ8ohMCXbdLRUu/s
         jPYrnmsCO0r+HC+EIIwimBrGVePfPxWI5+ESy2UsSL+G55E1YGu7sCCoUaBqlgCUqH7U
         /5RA==
X-Gm-Message-State: AOJu0YxqB1WY+n5/3s1GOo7VrINjO9YlgLB2EtGY65uyqeI/WI/r36y6
	1cym5Pf9d8SdprBx4/xcI7RVQyHr2HroIPrV4R5gMA==
X-Google-Smtp-Source: AGHT+IEpRUag5rB1tDDpj1KnSRL4BnsZpmVdNbHOzdHEtq0m5gt0oCTzHiRTdbC5zgVahAhKY6c+9bAJrFEY8lC9oNc=
X-Received: by 2002:a05:6870:7817:b0:1fb:75a:6d15 with SMTP id
 hb23-20020a056870781700b001fb075a6d15mr8510488oab.60.1702410243522; Tue, 12
 Dec 2023 11:44:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231211162331.435900-1-peter.griffin@linaro.org>
 <20231211162331.435900-9-peter.griffin@linaro.org> <CAL_JsqJ_NUajmQs8ZYiE2GpvNxBwtkLRE2jvWDU3hKtztt92Ug@mail.gmail.com>
 <CADrjBPrkso2cM8zKq-WU8WC3P3A9YoS6nqX-f6XvSNS-EofK9g@mail.gmail.com> <d23cc32c-8a5b-48aa-be4d-608fbbb9ac3a@linaro.org>
In-Reply-To: <d23cc32c-8a5b-48aa-be4d-608fbbb9ac3a@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Tue, 12 Dec 2023 19:43:51 +0000
Message-ID: <CADrjBPoireQMauac4D4d0Ry+PBBUUF=s0Lozp50KLz2y6ZLHKw@mail.gmail.com>
Subject: Re: [PATCH v7 08/16] clk: samsung: clk-gs101: Add cmu_top, cmu_misc
 and cmu_apm support
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, krzysztof.kozlowski+dt@linaro.org, 
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

On Tue, 12 Dec 2023 at 19:38, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 11/12/2023 20:46, Peter Griffin wrote:
> >>> +#include <linux/platform_device.h>
> >
> > You are correct, this header isn't required. If a new series is
> > required I will remove it.
>
> I dropped it while applying.

Thanks Krzysztof :)
