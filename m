Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA17316191B
	for <linux-serial@vger.kernel.org>; Mon, 17 Jun 2024 18:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718650083; cv=none; b=IcEj8VS9YTwDb5tmWus9QN1xEflEDuDI8kYL/3eejszNxuczP5QsUedWSSJG5w8jH6BMLehSVKQ8O0JAOaS0mwBPOAv6PRUEaxLsdRwau3WJtoEuFCwgsXchieb34yc1XgUaTgk/XujTr2fgLEcaUyuUF+Kgc5Ulai9ZHtDEEGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718650083; c=relaxed/simple;
	bh=qeXF72FR93AGBhELVsrcMvphwThBusQ84oeb1Yd3e+Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lhmvF7BfSmqFVb0JvUNAxAQh/CPb+Wl5x2vGobOwqLK3g7Ny//YjBx0+bSZyvr6NN8jFF4nKMn63dJJcGqshhgRoOQMV5+AoVJOAx8W06M/4Y5fT9zvKOqjjMQzLxlpsJX56TmZFgT5qYUdI0TKmGx2GYZMgWERBHTeV/QH+fII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GFXCBaEv; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GFXCBaEv"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ec2f4966a2so11975951fa.0
        for <linux-serial@vger.kernel.org>; Mon, 17 Jun 2024 11:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718650080; x=1719254880; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FYnJ6sKcKYDve5AuIpVcAVHdyyVXD2FX+mVnM7OJR7o=;
        b=GFXCBaEvpWYuexpHYbZHfxU1Y9zIonEfVTjaf9SMdDZ+xXfIQOWOBhyjv3vfyAZKUV
         Ftt+GongLM4rUJknxRAY/UK++DxaRsP45LikX8EUWpHUhgGYJpt3iJWulJai0DhGlGpD
         gWgd0Wc3+QE3yIAs9PUV+pHmrhLViYOuwvioyipCBwyOoyY6LgdweCc+07yU6bUp1hKx
         3+UW9IHKbwMRQcsx86gSY/nWhiGRM6tlxcbJmk2nQ5ing02kIUS+DOUHQNTXnlejyrLc
         iK3f40pUr5VknDsQRj9Q3u12s6DmzZ01J0CN/swDM7I7f5Rw3x5qMOHWPVMXZBlo5H1y
         2RiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718650080; x=1719254880;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FYnJ6sKcKYDve5AuIpVcAVHdyyVXD2FX+mVnM7OJR7o=;
        b=c9Ay38CkDbqLdiaQrp/yQ8ewnHOJAlucBpzgygy406gPdBLEL2jnqGXx23a7in2KVa
         82R67QIrvrrf/XWdT5Yv2Jcop/5FFP8nEiR0AT7Bh4a++1QvAp3w2UPIuLRh4bv6uz4G
         OvQROOL9WeoZZSf0+WtiP3En0DKlmda441twZFwaRzMcckO6PYLj6z17W3tFPex2T0Fy
         8WR1URAC8Rx7NFB6hiNdH8fPFRAiWPNa2Wh7dSMXUM62qFqNCq9CTv9f24h4GGZvgNp0
         8IA0S5Misk6g/ssrOCtXFVcntrcVa/5HOaa/hmzDm88GuNaA3C7zoJyfJ8Eq9HinOdu1
         Ac+g==
X-Forwarded-Encrypted: i=1; AJvYcCXlSep3OdLY/wRIFSgGNCAQZKYnved6IUgc7sR35Wm5C74HP6jk4IGtGPkPjxO1NTGXSY+tJ3kxbTyCNnP3G/65SXQK8Gmv12wQ0CVz
X-Gm-Message-State: AOJu0YxNjzxHgE5TVWjDFrSVVPs38ITZHaOi+5V8Njvrno0Kh/sXkvuo
	E9iePlHal9EbVsyIbpzAcxqubOBHvKi4mMGtbYrfWn82ytN3nSaybchzgkRaBRo=
X-Google-Smtp-Source: AGHT+IGx+atBJRdGHE+dU/qVvXUgXHTjfuz4zdzX/PqP8kUgeQ1LM6w0fr0vL2L6wwQuaZMSeOstFQ==
X-Received: by 2002:a2e:8895:0:b0:2eb:ea4a:9923 with SMTP id 38308e7fff4ca-2ec0e5d1415mr83982231fa.23.1718650078858;
        Mon, 17 Jun 2024 11:47:58 -0700 (PDT)
Received: from ?IPV6:2a00:f41:cb2:a9df:9f88:17b:c7e7:fa59? ([2a00:f41:cb2:a9df:9f88:17b:c7e7:fa59])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ec05c17d72sm14085621fa.68.2024.06.17.11.47.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jun 2024 11:47:58 -0700 (PDT)
Message-ID: <65f248a7-43bb-4f97-ad98-e2ca29e99e51@linaro.org>
Date: Mon, 17 Jun 2024 20:47:56 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/8] serial: qcom-geni: Fix arg types for
 qcom_geni_serial_poll_bit()
To: Douglas Anderson <dianders@chromium.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>
Cc: Yicong Yang <yangyicong@hisilicon.com>, Tony Lindgren <tony@atomide.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Johan Hovold <johan+linaro@kernel.org>,
 John Ogness <john.ogness@linutronix.de>, linux-arm-msm@vger.kernel.org,
 Bjorn Andersson <andersson@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Stephen Boyd <swboyd@chromium.org>, linux-serial@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
References: <20240610222515.3023730-1-dianders@chromium.org>
 <20240610152420.v4.4.I24a0de52dd7336908df180fa6b698e001f3aff82@changeid>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240610152420.v4.4.I24a0de52dd7336908df180fa6b698e001f3aff82@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/11/24 00:24, Douglas Anderson wrote:
> The "offset" passed in should be unsigned since it's always a positive
> offset from our memory mapped IO.
> 
> The "field" should be u32 since we're anding it with a 32-bit value
> read from the device.
> 
> Suggested-by: Stephen Boyd <swboyd@chromium.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
