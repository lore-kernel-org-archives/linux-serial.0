Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A9F255F5A
	for <linux-serial@vger.kernel.org>; Fri,  2 May 2025 14:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746195099; cv=none; b=DCdawJg1aolaOg7TpxPjVfuj9hUukKzbwqcvEPzgBmC5a4ld1G0nJoF8VvOtq4ISNnIhFs7UB1fWQO6R0nlqzVAb/1pGNYafmTjBcxS0obkDNxQBTgyxBLcmO5K4VSBykv0ECRLAx7cbDwlumawKfQ26OJI+RGX8NDXqRJoBwFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746195099; c=relaxed/simple;
	bh=yIxrVkU4SFQ66DwToqGuNlKqd5dY6/8jM/wyRARXfyA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l2RgJ7BxAh0zbA8rV5U7+L4IeqmRlz+eUU3D2lCbradnCKsV0f7VP0MPp7hyzInU2U1c7r1X624ROon7h1ESheuJfhHMZZRNck2WIk6MIbhECIDAqV52nBlGwL8tDGgbEqBQK1V4HA6pWk7kvIc5qp6prqJ/7g8CexziOZrlTSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YD0FCrbz; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YD0FCrbz"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ac339f53df9so439734266b.1
        for <linux-serial@vger.kernel.org>; Fri, 02 May 2025 07:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746195096; x=1746799896; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yIxrVkU4SFQ66DwToqGuNlKqd5dY6/8jM/wyRARXfyA=;
        b=YD0FCrbzKXq2+J2x4Rcme2ozK3eFo4u0VIcHUYKLCvz4iNR79O8ClYduTKwRNcyqaw
         bXfiWU/HISaRQTGl3+5YiTH8Bn+C/UA3AfmXKSAZhQGqC3w2yI7tWHr8Erm2y68sfehE
         spUNbVK2CCXox3mX3/cjje+6fCpKZ+OFr57nh02U9astSB86upmsB9tQ6Ah7WVJ0gnuB
         Zk+UoNj2VfPGePA18Gq9mklX40U3NKRmbWrYI93hWENAlxFN1uFh89syUJA295cyrN36
         Gi7qUZfun+1RCkxTjX0potqKDlk1mwNhLmrdS5btewlFex6spsP2zqpBafPZ2RIKURBm
         HmGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746195096; x=1746799896;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yIxrVkU4SFQ66DwToqGuNlKqd5dY6/8jM/wyRARXfyA=;
        b=JeTb1pzHciSEa9Ku9ET/4nqgY+4C6JIxD/OpWoR5umeodh5H6BYnu0sq72iFR26TnA
         OmPKZCO2z2YyxPeT0sXkKKedDfAXsmCnyB+IGNrTpoVHxU6bNxt32Y/dAOrwKLe5+f+/
         0xyl0PuWWEGnKpa16L87ElDa4O9PpEPLohmXskmCRK9e7b5LVqoXfL/Apj82a0YxIUtF
         0eMvnWaRy8yjryfIb4OsuYDoRw/RzdWY171kAv4+up2N5o1OPb2PdSYWrsTkWR/wnxfW
         OQe50i/bbIKMffpc2CJQwll0xGxWP0+A6Wt/FvMVqO13muziICNq/yrgmW5m1wL5cM/M
         Ygxg==
X-Forwarded-Encrypted: i=1; AJvYcCVxjNWg1u08tKyGsU+0aGWRO4gUJrWOYutvIlCc6zzH6UBwApeftugh5OPY3yM2xpamz1KyjRaQ+P5Bw+s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHzbk+HyRWw5EUD777MYkHwUU6JCZK2i/pdq0gs/m8UvGlprAs
	uQNvB5BCtdzbZ9gDOse273J7q70N7R8lIAhm6fo4dB0LaVoaKCBtdC2jPHh0p+8lNQpdhsIAi9H
	31JicYV54wpM+M8AuJiEgRKheUS6Uh0lsfmJsZQ==
X-Gm-Gg: ASbGnct/MVkiEuyJFiH2geySlnfjjJlBk5mt2pcVMEYuypzzkdTrex37mfV2kg1j67h
	kMUxfc2J8/PaAoN/mRJW5Bdme6lUnc+RA6b6++Chu5MOWhwqRlkyMAm0zohw7+z361BeISEnWSE
	7oaLGv9ZGJuPh3rnrYURjkZrjKlfe4odYt
X-Google-Smtp-Source: AGHT+IEs1bTD91IQNhCNs2cmGXwwVdvucdgeJR3evc2FFZN3RtZBiPjhHMCBSyUR5aj84pE2Qt2l2g6KYv7IB3kEAbQ=
X-Received: by 2002:a17:907:74a:b0:acf:15d:2387 with SMTP id
 a640c23a62f3a-ad17ada7132mr329262566b.19.1746195095856; Fri, 02 May 2025
 07:11:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502031018.1292-1-quic_ptalari@quicinc.com>
 <20250502031018.1292-2-quic_ptalari@quicinc.com> <20250502053758.utawzhq6famwenc2@vireshk-i7>
 <8ba02745-378b-4264-883a-b99764701d0b@quicinc.com> <20250502081402.yjagnnjrfva7u4cb@vireshk-i7>
 <e1b2029b-2461-4cfc-a6b3-acdf5e01c289@quicinc.com>
In-Reply-To: <e1b2029b-2461-4cfc-a6b3-acdf5e01c289@quicinc.com>
From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Fri, 2 May 2025 19:41:24 +0530
X-Gm-Features: ATxdqUFgSe5sdPhV4tcbtGto6wWWIR8JrD77D7tcOXpnzioIpQJVJvx6MOBRrS4
Message-ID: <CAKohpondRqdfqC3CFSJibL2om8_Bbds8k5Dfu8fcZDksNxQUwg@mail.gmail.com>
Subject: Re: [PATCH v3 1/9] opp: add new helper API dev_pm_opp_set_level()
To: Praveen Talari <quic_ptalari@quicinc.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-pm@vger.kernel.org, psodagud@quicinc.com, 
	djaggi@quicinc.com, quic_msavaliy@quicinc.com, quic_vtanuku@quicinc.com, 
	quic_arandive@quicinc.com, quic_mnaresh@quicinc.com, 
	quic_shazhuss@quicinc.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 2 May 2025 at 19:32, Praveen Talari <quic_ptalari@quicinc.com> wrote:
> now i can push V4 right and will not face errors on my series w.r.t this
> API.

Not fully sure what you meant, but you can send a V4 of the series,
without the first patch. Please mention it as an dependency in the
cover letter and that it is applied in the OPP tree's linux-next branch.

The one who applies your series needs to apply the series over the commit
in my branch to avoid breakage (if your series is going in 6.16-rc1).

--
Viresh
