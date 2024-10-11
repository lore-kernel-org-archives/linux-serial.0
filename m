Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CAE9567D;
	Fri, 11 Oct 2024 01:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728609122; cv=none; b=kBDsm64v5WxfIpSjBRllAYU9GoBApE1y+aW7/7uU8klGZAyfvfBVZHru/OhWcATSvwMTy0YqoVAkf90yduSZny+1kpec0au4iPjIF5Muugf7Lgh06wi2w4JINrxPTY9suPA6lYVPgS477i0bwVYgS0LEuHkQXarULtWXXJE2f0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728609122; c=relaxed/simple;
	bh=kz6Wp9ySt2hzSQjerKMpWk13uiAYKPo+Vl5JeQAuAu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UNOpfUqj1+n24t8/UaggG1YO+p+/mXK2CdnQrd9rG+P82cpf2VDH90tX3uDFh4/K3Z6yjw8FdaNOHWJxPYfc/A2J5F4sGEmDY9KfyZQzQB1IU7O1anhgoB/kQVRAgq+P1rvlL80Pq3idMyEAZLQ4CNoc+Ac4GFfinGYl1Q58iW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cgT9S0GK; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cgT9S0GK"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-71def715ebdso1076974b3a.2;
        Thu, 10 Oct 2024 18:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728609120; x=1729213920; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AAOc/rBakUrniDiHlg2qpejgAj7CPI/jsjOw6Ywi1cw=;
        b=cgT9S0GKpPWQieZlYGSIzXfL0XONcOeBxFi10dxGFBxTrQRHlQq7caWhEqk1iZKW9V
         tj7tDbtlo0Seq7ITqQNoisuDcfTsELykEIideRlbxOUdaqoVX1C6sCtn6GXjGLR4rEX3
         G8uBmbqSHRyc2oSYXpSqQk5QNV+GhfiFWVBAs/Vyxuqn6ptmmFDzyptDkMNb1shnIHVm
         zRwhIe9v2bPs6MvoEuaVtFIJk9B9+ohxMTKmrcD30G/Xh9pA9c+uqjeZ2lI0IDWEssbX
         Q49QW6v5kXrNMFQU92pVthK8f5ATjHsg/M06O3k+U5HT6Hf+1C8vLKt3sHNS0CWV2yux
         gkKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728609120; x=1729213920;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AAOc/rBakUrniDiHlg2qpejgAj7CPI/jsjOw6Ywi1cw=;
        b=iAQdIDktXoFxSLic4VwRnqm7qZmqSTEbiHgAn5hRhy39VJIuT+wVDoxj32YkdpIf5f
         ScoVxv7FC3GbNYwbWevuYuZxurdYl77ypo+Ddjicw3s1EhPdZGsMwIDnH9afV/LLUG8S
         cCr+08r8Y9e3YGO2S0sGjnW5yut4v8QVIGs5rvNE/eo5NndtWsxI0QHLTIuap6omYQRi
         fqMFWa6v2GinCe61H4JvTCPR4tn1zGdpF3fg7ayVkeNx9mD82NF+2PNUKNFcOloV7XwJ
         EfyaSBAFpDR79aBrqX+/xAkN8GWtejyPg90esfwU6Vu0UatpcTxdLB+qaXk7vqRkzvGL
         La6w==
X-Forwarded-Encrypted: i=1; AJvYcCUfa5+l0ZSfd5fkR9mis3bqjNf9hDWpHT/9Gma2+tOcroNgat/MsXfgQyeoMhGpt9A9S0AHasL2wsnYnEO0@vger.kernel.org, AJvYcCV6Gnmh3VOa028f/LhmiqgI/4Y9h7lGF5zmDko9M42bVqaId9a6aDfxrW2vU8y1yMVAQq4ZCjop/FZhvxDj@vger.kernel.org, AJvYcCXEUq5S4TfYmp7fnPhpuK9MYaT7SIUTX1j7vpHz7wAjm2en8DsyV8IJIbs/Jvmkm6mudYQamyhxSbCJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7lo98Ydetuweo7+FKARpgego5GYdfR7Ln1+ZheU/w3GvIGcpR
	uhd7ZHejFoG25tpwqMw0E4+mMhJLsLSFFDuWdGzsBtOtv1G4n5Vu
X-Google-Smtp-Source: AGHT+IHHQvFx/g0NSBQ/2WU5QX9vrmE/ZQ7W5Xx12EJZBah7AEPBBqYXC9VcoE3PO1Vowj3IeW5tRg==
X-Received: by 2002:a05:6a21:e8b:b0:1cf:4da0:d95c with SMTP id adf61e73a8af0-1d8bcf453d9mr1508105637.23.1728609120231;
        Thu, 10 Oct 2024 18:12:00 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ea449596d3sm1599794a12.61.2024.10.10.18.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 18:11:59 -0700 (PDT)
Date: Fri, 11 Oct 2024 09:11:37 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Inochi Amaoto <inochiama@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Chen Wang <unicorn_wang@outlook.com>, 
	Inochi Amaoto <inochiama@outlook.com>, Yixun Lan <dlan@gentoo.org>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: serial: snps-dw-apb-uart: Add Sophgo
 SG2044 uarts
Message-ID: <vinnmu45snxveh6f3emo7nhom6s2z5d7hf5pzeozyowfa3twt7@ykeidfboxfiv>
References: <20241009233908.153188-1-inochiama@gmail.com>
 <20241009233908.153188-2-inochiama@gmail.com>
 <oyvqsywyznanpx5oflnemcsrk7r7nnhvxl6ly7b55oan2boi5d@kobrtldqbj6m>
 <muz6ze7cxho5niz67agoxwnaowumzlcto2vwydmxs2yzdjmisi@symog2asftmv>
 <ZwfquBFOVJEz5lTT@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwfquBFOVJEz5lTT@smile.fi.intel.com>

On Thu, Oct 10, 2024 at 05:54:48PM +0300, Andy Shevchenko wrote:
> On Thu, Oct 10, 2024 at 04:23:05PM +0800, Inochi Amaoto wrote:
> > On Thu, Oct 10, 2024 at 08:12:41AM +0200, Krzysztof Kozlowski wrote:
> > > On Thu, Oct 10, 2024 at 07:39:05AM +0800, Inochi Amaoto wrote:
> > > > Add compatibles string for the Sophgo SG2044 uarts.
> > > 
> > > This we see from the diff, say something about hardware.
> > 
> > The reason for this compatiable (and the hardware) is mainly in the
> > next patch. Will it be better to submit a new verion with improved
> > description? If so, I wonder whether I can reserve your ack.
> > 
> > > I would just add it to starfive enum, but this is fine as well.
> 
> Even after reading the second patch I don't understand why you shouldn't re-use
> the starfive compatible or make a new one that covers this quirk? At least I would
> see that as second patch is basically not needed.
> 

I do not think it is good to re-use the starfive compatible, it is weird
that a sophgo SoC has a peripheral on the statfive SoC. Another suggestion
for adding a new one that covers the quirk is a good idea for me, but I am
not sure whether it may cause some misunderstanding like reuse the starfive
compatible. If the second one is possible, it is OK for me to drop the second
patch.

Regard,
Inochi
