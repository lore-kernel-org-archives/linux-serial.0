Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72A43A759D
	for <linux-serial@vger.kernel.org>; Wed, 19 Aug 2026 14:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787149193; cv=pass; b=c0KUBndImUOzAWAdFLtElExDSGFC3vxQVbJkkdxGZYYZrV3QVTtgvDCb3CNLxaKZZ4/yL/d9RKRP9petavAi2t9OSYR+zjmm6XRJqZVWGyMgCp1nD/gNoWQpq3/OzjLK12inFaULyDdgkZZMamF+Ozxu++3vuYhBlpBgwHLDkBY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787149193; c=relaxed/simple;
	bh=flgCWjJ0Vcdob2VFEhwHid/TpVFCevn8cCNPvWAm4QA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G/6pfHeH4dMtkrbJ4o0p8R3su6klCyJQEU4c1gbyD+ZZZYpD8WORcwhYv8n9Nty9/UmY7YiDvroCKwphNKx85NxITTXqnOLzZj+iJTib3OhRn9WKKbX6Gumbxlqedr03Px4vjxJzQeuBg9JKCfBzAxPLSWRVlfBrdS21J6jn+yQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=SRjP+HkG; arc=pass smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="SRjP+HkG"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4998590d392so10178935e9.0
        for <linux-serial@vger.kernel.org>; Wed, 19 Aug 2026 07:19:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787149190; cv=none;
        d=google.com; s=arc-20260327;
        b=J8k51mw2kHSytL6OkaaDcRgHNpvppxaa2zLX8zLhB1j48Cdp40fWgnxcuwuFxrOMP+
         ybZXm6omCroO82otRyMOqPJkHVglvlSKWrl2ZkX767dOaCbiXPt9O3KJTf9e9jVq8huF
         ADYSi1bm4qJU8Z4Y3QCkTls2C1StIEbYtmjl9I0SXGNG4rXVe64R0YRtMYeVa8PBAGO9
         qC29+FpCLHPuarSs5RLFqzZ+0UgFmPoEt8mabqUfBC6buSzSGc527Zv82tj7V2w2LZ3B
         k8Eh14KdFSg2NyPa0hG7gby/Y8TNNRrwpC51c8DIIHwwADYMCCVFgf0S/cX/EY/Pv2M5
         3cBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MeJKUhVwZjDQ5ldC5TBiCaKL9cckQ2oDXCu8SH2HVSc=;
        fh=uI6ijIW/heJE5bgBjiwKfsy4s3kTvuKhQ2cDrszSJnI=;
        b=VRw/EjEmzbnzDlGTSuZwgyg7Yz27RxiTo6z573w0KpBSLVLWwXB3ibN/k0sQAPc8dT
         YpLBVBXZIitVPZTpgkHvwSihkQESiYxQW1VDwum2wfOnrnTAd3TEedXce5Q2T6gX3+Hr
         GWaPquqezkZaZXfLLuU7fZ5U+HVK/yr5DcghCjdhE1dE34goyX1mEoUOqPswV9PVZXEV
         BHBou61Uk4ifcoP21Lw1Zo6I+1W5c6Hq7MausRTXdmFH+G4OyGDDvGsuz1SzQyHj3ubB
         rhsixFzzGy7HBKhm0re8Kn03xKOUIvUTuzcgIxZrzxu3uBLVrSQKcGmxqvtNBYPW5T6N
         A2Mw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1787149190; x=1787753990; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MeJKUhVwZjDQ5ldC5TBiCaKL9cckQ2oDXCu8SH2HVSc=;
        b=SRjP+HkGPsLTrJ98PATaLU8/WYmKptYO7WDrS3vkPjAwGmJUhbvuouoKquAwK5PnXa
         Yel1kYjH14nllNyZ7rNCS+nSgn+KAXmoRQ0Kqst8Ec8NML4o3AKHwSNodNsKtBq01VPd
         W3Ctbphgpbw+Br4NoiMcO7MxlnKPyVcsqhK0Th2DLVux+/jC/GD8vF94ad7OGgnNUFJb
         qAhNZPHspDj1+XdCRKSQl47vo7XkEwGaaD88wd7ODjyn/K4ao5/xBBW0hjwILI5lNtTD
         bj9oPftWoT5DUHbrza6BpOLChC/U6CQgvUpDCG8pn+nkGXzAfr5J8uyFSO3jU0ibXx4R
         pCHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787149190; x=1787753990;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MeJKUhVwZjDQ5ldC5TBiCaKL9cckQ2oDXCu8SH2HVSc=;
        b=b2AAnj468neWVglxjdL42iGK9Tv+2lZcxXLsIqJBUkZfsRfALiZb/s3AFKVL5477zQ
         9koIwp2BdeAxI+55qgpIMbTgzfVxPHod3TGwritnycqQ953JCNetxO8Fo9jzE9Ker23u
         EGiE+Cnn8ZJUBgs5xnGAKoGc0aMky5Mq1aioPc3n3C2jj/mOIxSQnSbYgRFpc57jGeI2
         PVN8kFgtZf4IrjOJmlHYEkTBW0FVfHFhKGhVhisO9c3U/75LVV2Ta7Bw+LwC3N1+0FlU
         50dJC6TnvhC+j+SIBTKNncDEzijlJAcS56gzsejpk1vZQ1bh5NbkFdivXjBSt9E7xj8T
         wthw==
X-Forwarded-Encrypted: i=1; AHgh+RpQdbmlc+kR0k5/g2LlmPnpRKgAso+88Sqi88qGSP9uphlSLLq/nvwKv14akMsAPVz1tvhMVtJTeicZ5sE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZP5FUx3hLHqxneSXUbzEz9DW7dM4bOyhBiSdOZ+GkJskWDRZ9
	kjpJr4Ys6ENN4KyZQLYN03LYpTEPxO106r7nccGYqW7KYw7w/LUI2XXkhk9zUBsnATIVpC3QO2/
	3+OEFgTVA3fZ/8zFVG3AtWlXcRtg8WmZ0yCu0fwm6iA==
X-Gm-Gg: AR+sD12G/sEjkzLxeufPtGVH2PffcWbqn2BPOnz4gLSKDTP28djXanczW6sK51dNHom
	sihhzlQi2I+PYt+w40wQNSD5EXER5Z8eMBty2H6rUztVdGySl0hbNsxrLW4zy674rnIVRrqNTLe
	p3CucItWVhlIFbyPki7kVCHWBomt894PcJXjXrkb6V5VuE7y+2W8687R/j8Sh020CvyQTwRVSiL
	0iSbcPI1X/ed81asz+kpTYYPDGdQ0y7Rao0yvTgq3ZG6+fsU6VK6ZmPhkMaI4vi/ymrS7WBj8G9
	/1J+7a1PJlB2sJcHI13zF31jdwL3Tn8d7f+m0F5iWCpeHLk2kHs/aUD0m7qHiUx/a69ZpwAchhO
	mg9t9OSsYRd4zLkp9oR40XbfckoUpM6hQAV4=
X-Received: by 2002:a05:600c:3485:b0:499:a685:c10 with SMTP id
 5b1f17b1804b1-499aa19a3b8mr105118355e9.4.1787149189928; Wed, 19 Aug 2026
 07:19:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260818-aspeed-driver-v6-v6-0-fd7cc0b338ea@9elements.com>
 <20260818-aspeed-driver-v6-v6-4-fd7cc0b338ea@9elements.com> <178714815308.32179.15619694497271022262.b4-review@b4>
In-Reply-To: <178714815308.32179.15619694497271022262.b4-review@b4>
From: =?UTF-8?Q?Gr=C3=A9goire_Layet?= <gregoire.layet@9elements.com>
Date: Wed, 19 Aug 2026 16:19:37 +0200
X-Gm-Features: AcwNN1WSp5z3ykm5DhYgUXUEaifqr2FKPqOZiTmJSVGHJcNVXhm6Z3n9CL5gr0M
Message-ID: <CAFi2wKbvOX+E=nsWuVJj=_xQZQm=vCA=qPWwzgJF2oio2ov_UQ@mail.gmail.com>
Subject: Re: [PATCH v6 4/6] mfd: aspeed-pci-core: add AST2600 PCIe BMC device driver
To: Tan Siewert <tan.siewert@9elements.com>
Cc: yh_chung@aspeedtech.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Lubomir Rintel <lkundrak@v3.sk>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, Lee Jones <lee@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	mfd@lists.linux.dev, andrew@lunn.ch, jacky_chou@aspeedtech.com, 
	ninad@linux.ibm.com, anirudhsriniv@gmail.com, 
	=?UTF-8?Q?Gr=C3=A9goire_Layet?= <git@gregoirelayet.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Tan,

> > +ASPEED PCI BMC DEVICE DRIVER
> > +M:   Gr=C3=A9goire Layet <git@gregoirelayet.com>
> > +M:   Tan Siewert <tan.siewert@9elements.com>
> > +S:   Maintained
> > +F:   drivers/mfd/aspeed-pci-core.c
>
> I think it'd make sense to add the linux-aspeed list as `L` here.

This is already the case.
The following maintainers and lists are set for all paths containing
the word 'aspeed'.

From the MAINTAINERS file:
```
ARM/ASPEED MACHINE SUPPORT
M: Joel Stanley <joel@jms.id.au>
M: Andrew Jeffery <andrew@codeconstruct.com.au>
L: linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
L: linux-aspeed@lists.ozlabs.org (moderated for non-subscribers)
S: Supported
Q: https://patchwork.ozlabs.org/project/linux-aspeed/list/
T: git git://git.kernel.org/pub/scm/linux/kernel/git/bmc/linux.git
F: Documentation/devicetree/bindings/arm/aspeed/
F: arch/arm/boot/dts/aspeed/
F: arch/arm/mach-aspeed/
F: arch/arm64/boot/dts/aspeed/
N: aspeed
```

From the linux kernel doc [1] :
> N: Files and directories Regex patterns.

[1] https://www.kernel.org/doc/html/latest/process/maintainers.html

Regards,
Gr=C3=A9goire
