Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC2430BF67
	for <linux-serial@vger.kernel.org>; Tue, 26 Aug 2025 09:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756201040; cv=none; b=rEYnym4NC5DYzgdfIkTURZauV00MPdiMeqCNzz5mnBSRiZ2++l65gb/lQEzPMMJIabjMB4QE/1rDRj9H2fqMLaQrFxN5ZyCTKRmAEpkT2ht5uokmv283tQJSiPDvvHcAOqfzgYBG7m2r/CLxhXKdvLz31a+Zr7z2uJ9EiGcHT+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756201040; c=relaxed/simple;
	bh=hL0Hr6jYqYEbDXRMZ0OdI59nC7QIyOL8hWqNW+Mahq4=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=QSIk6t6zum75wenEh1UEpmlAvfjsV2W4AwF7XNon4Vr7/ZnrVn133CB33vCAEgLi1TmpFu6Wji1BKIauo08oNvxT2S/xfktiKjfCA7yiWTGpRXZRR/sm5iUG14ztsSBvCAL0pQrQZiYU/8F9xTIVVd7YtgZ4s6PSmhPzIRG0++0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bIYOhQPi; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bIYOhQPi"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3c7ba0f6983so1270884f8f.0
        for <linux-serial@vger.kernel.org>; Tue, 26 Aug 2025 02:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756201037; x=1756805837; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hL0Hr6jYqYEbDXRMZ0OdI59nC7QIyOL8hWqNW+Mahq4=;
        b=bIYOhQPifDe4lZ6bNSOChpS8vN9lXRcdVu/rZiMZHCPuj0MrQCnUNjkdRkTN7gjc8v
         /ssbfpiRPi1MENMVfbfoRa/QbH83Q2gkvDvPmY9DMFfw5L9ToPyi8ucXcOvGkLkK48iD
         NR6Ol4KRWo0RgsYpbdt45+gjxcx0ZEpzVkCsiXyP2Z76ry+H0+Qdw1JQSWvtfbeLRaVU
         QVZSK7h4evDIo5kuB1v/JOtzKXv8kQ7XM+QWlGZ4vSUQ1ivtdOzQ8u6ccfL8rnvbatrE
         8NlcsiNk0yDM+UHUZbTgyN+tLVyDzTWk/PPHWmZCcgOicJiDbiRSH07S6wEjiIabquaV
         KNMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756201037; x=1756805837;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hL0Hr6jYqYEbDXRMZ0OdI59nC7QIyOL8hWqNW+Mahq4=;
        b=o5eqH0wP/hcLz5Htd1Od77iC4V/gjIDNyClsJ8QZDvyA92xl3L6/Kiirxier8dGc1/
         m4LCmih1SRKUg/UIbaFxlh2/2BBQ8DlU5kfldkYSEDHubZVoVcxUORI9WoDjops8bTTP
         jeeDGlgmTdVL9hZmghjR0VNInum+94CIElDmhHV6dO18JqpkeqTo5L+uxus08MQOPoSt
         KNhExeg9ijxs3lTrUbNDCeQlZ0DH74i1X1NWdp6ykemtYbcrSFhyxRnNWlNLbHEVkNpq
         jtZGXl5vRBU3UYiot+qAnqr6mNR+K9gJt3yyRNRGALW98Vg4Nw5kkOnCW+c3cyOFvGDo
         SoCA==
X-Forwarded-Encrypted: i=1; AJvYcCWgA6dhb67wdPPLa/h/UgHh3ZZuGEkxeNWjv18B2UUd1xRwEUmuHxjGSvG/QJA7rvbRWfLcvpacuIqmgvM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ96Ck5HYig/OnMkOFp4COO+cZK989wuZTiVq1MzHDz8TzPguy
	vIabVxj6Y095e0mAJtjDG/uiOIUwvWKfC+Kkeb+HOz/4S2d+xzdcM5/kvpmUv/6XlNc=
X-Gm-Gg: ASbGnctpQkZS2HKOqerVyh+9GdoXiBL1FKWCxNqGTLinBSP83vviDmquCQjaV25b4P6
	InTYBrT0U6GRyDpzCdOVT/qqOr2dKEt9lVpLX/AHzVVjxHffWKoRs5qu0069t/eTKp+r3RAtJvv
	cM6VixkXJGQcBvhbKDH8J5YHKrVjvHhWJIXgv6HZmNoODg6TQZ9bI8a34bnmWVlyjMRnu8NdKhC
	eT9aq5yOlgDzeurwMRlPhw3qmP/oG+5FoyDIJoHacZI9IObRWm7rqeKA8TZ/xmVBLlk4X2eZk8T
	G/Eafctd6KOVAy5CqHAuQh6zchoP0ucvH/Lplhf/leIJR6OQIyshjLkPOnGgmaJ49Dwmn5KnXwv
	RsqVBRll6IxS7vgPZ1DGNjjg5fpo=
X-Google-Smtp-Source: AGHT+IGrDK+quNOm+R+59A34XZn3umLuzfZj+sWAvq95GJr+cP+OmXy85+fBFYFu/LRVhA4av2Y1tA==
X-Received: by 2002:a05:6000:4006:b0:3ca:2116:c38c with SMTP id ffacd0b85a97d-3cbb15ca336mr851001f8f.2.1756201036785;
        Tue, 26 Aug 2025 02:37:16 -0700 (PDT)
Received: from localhost ([2a02:c7c:7259:a00:e633:2c7e:2d3c:f5ec])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c711f89a11sm15275246f8f.64.2025.08.26.02.37.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 02:37:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 26 Aug 2025 10:37:14 +0100
Message-Id: <DCC9B5C7SSU2.GRI1UY0VUDHF@linaro.org>
From: "Alexey Klimov" <alexey.klimov@linaro.org>
To: "Krzysztof Kozlowski" <krzk@kernel.org>
Cc: "Praveen Talari" <quic_ptalari@quicinc.com>, "Bjorn Andersson"
 <andersson@kernel.org>, "Konrad Dybcio" <konradybcio@kernel.org>,
 <linux-arm-msm@vger.kernel.org>, <linux-serial@vger.kernel.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>,
 <linux-kernel@vger.kernel.org>, <dmitry.baryshkov@oss.qualcomm.com>,
 <psodagud@quicinc.com>, <djaggi@quicinc.com>, <quic_msavaliy@quicinc.com>,
 <quic_vtanuku@quicinc.com>, <quic_arandive@quicinc.com>,
 <quic_cchiluve@quicinc.com>, <quic_shazhuss@quicinc.com>, "Jiri Slaby"
 <jirislaby@kernel.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 <devicetree@vger.kernel.org>, <bryan.odonoghue@linaro.org>,
 <neil.armstrong@linaro.org>, <srini@kernel.org>
Subject: Re: [PATCH v7 7/8] serial: qcom-geni: Enable PM runtime for serial
 driver
X-Mailer: aerc 0.20.0
References: <20250721174532.14022-1-quic_ptalari@quicinc.com>
 <20250721174532.14022-8-quic_ptalari@quicinc.com>
 <DC0D53ZTNOBU.E8LSD5E5Z8TX@linaro.org>
 <577d05d4-789b-4556-a2d2-d0ad15b2c213@quicinc.com>
 <dcad137d-8ac9-4a0b-9b64-de799536fd32@kernel.org>
 <DCC8WLEKNS8W.9GAJHQGYPZIY@linaro.org>
 <8689a8b4-75cb-4f01-ad6c-0a8367851257@kernel.org>
In-Reply-To: <8689a8b4-75cb-4f01-ad6c-0a8367851257@kernel.org>

On Tue Aug 26, 2025 at 10:21 AM BST, Krzysztof Kozlowski wrote:
> On 26/08/2025 11:18, Alexey Klimov wrote:
>>>> May i know what is testcase which you are running on target?
>>>
>>> Boot the board?
>>>
>>>> what is target?
>>>
>>> It is written in original report. Did you even read it?
>>>
>>>> Which usecase is this issue occurring in?
>>>
>>> Boot?
>>=20
>> FWIW, what said above by Krzysztof is correct, there is no usecase, just=
 booting the board.
>>=20
> 12 days and nothing improved, right? if this was not dropped now,
> Alexey, can you send a revert? Author clearly approches stability with a
> very relaxed way and is just happy that patch was thrown over the wall
> and job is done.
>
>
> If you do not want to send revert, let me know, I will do it.

I am okay with sending revert, just trying to see if there is any interest
in fixing this.

Thanks,
Alexey

