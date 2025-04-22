Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EAD42857EF
	for <linux-serial@vger.kernel.org>; Tue, 22 Apr 2025 14:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745332015; cv=none; b=HfKwWe/LOtMCQaOTcOrjJXWpwDmjKR8+EJ3jxMnenc5bKlR1dpgxgOrxB30hnxpgaDXRe3T3uiA4fIYedwCAqC9QIHCVnmYeB33Mk3S+ihfqQgBK2W4wVdD3ZuJHOb9956kNdQcBJOlGEiQjdIJBL5KUKoTmH00JJePU36sFVAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745332015; c=relaxed/simple;
	bh=2nuL24sxykMJ7Rms6bRBYY6C+lB4kirIqrm1dYwAlII=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dkUPzylhtDB8osmzFqACVK3AtUjjSRtJh0pdQYxqPpoR+tHESkUNjUHqxgGGQi7+dYHCV+7EeksPxZNsE8/cqiZ57n2ZB2STuATI4AJoz7U9zc5SG2FAA1cyJbsi9xGOCqTkXp2KhMsa4Z3Ho/O+tvW/Uronrs6O2CLmT1hqWG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vClEnKbT; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vClEnKbT"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-39ee651e419so2995551f8f.3
        for <linux-serial@vger.kernel.org>; Tue, 22 Apr 2025 07:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745332010; x=1745936810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6/8FBWOKis/5gAhZl+kumNEFhsuTOTp0Tn1yNZmhUVg=;
        b=vClEnKbTuUX/Tn/89pK2/LS9DFgehutKCQZ0xekC+37DFEKSWAP+bzxp/c5GAm0adb
         6RkIBd8ksYkgFcR69ttGRQ6b+W+QyTRhdXi9nmFX54fCPcrsS1qOI79YriwPuhad3UR2
         WQ3Wnd3geyPJUbt6++CcE9Zuax9mSBurXLPlq2ITHR84kzbcH7AHVzizepSNjjmu05UW
         vnQgpYZsMZKtNLsbDybDIdUe/msQZVowaXqru1tOXWcQoz2ugKF9P1xNtzc8zGn7Tt8f
         nmRPFh4k6qZ1m9Mz2rL134DMDXsMZ0aQFMHFB2fMVcebMLUbIM6OlQmHoVucaOFKNiTm
         52aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745332010; x=1745936810;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6/8FBWOKis/5gAhZl+kumNEFhsuTOTp0Tn1yNZmhUVg=;
        b=Q7cnnT+REhcQAT8ArgkXwizwbHwk37T2wS3zbmtyde8XFwPlDWtafEPXgSwWpLfAAq
         H6SrJsga3JF7oUHzijlYPDpYScKKBWhFhCrzn2VXDh65klObPVznCbR+33XdR/op0wNM
         eS+nrR4I0ofVXvaAYTKACFNdgB+wYLfPMHGthENbfA2i09yHNQdsik7yLuaIw2hlAdH7
         N3k4Ej/u2+XXF9JtpmOy9NGRnRVQ7iOzZ6VYBwaLoTdjPEA9odb9LtJwi9T8klgSpggT
         flaF0B5Vo9ropgfSNIuhYUzj8e1GOZ9tykC8DntTJS4z3tLkmhmuZtj1x8OBOs5d59NN
         IiXA==
X-Forwarded-Encrypted: i=1; AJvYcCXrdirPjDJ8FvJ0iauGlEOYetpsnG5CeQjNq4VjL6oe5nrajUdHNOeQxtHGS5QOlO2lHIekzE5/uozCRtg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLV5ovJq5SUQqq5yeR29GtXF+3tZ1o0jM2CePcWFsrtbskxi/2
	kc0B+lJxHDrxeGe1Spo0fQX04SjsUO8Q4HmuMWngZ1XRAr1qHx+cWF1VOfTNetc=
X-Gm-Gg: ASbGncvp+TD9HdI1Be3J+lcTUfLAdy9gBpPvu7OJfVfkpFTvVn68TCIGgr9UeJ6kyJt
	sympBVMD+sPDw+c9x876xLfW8zXOs5UFZWssAfPOqaZLc3yNlLCz9/qmgNTuWPt463E4VIK9W8C
	ZNx6dxssksP8wy0mcm5ZxDxVZdpltlhID9mr5pALke73ecEhLUl4OOk289+1MJSOXjvJMz0enLy
	Tz05xEP+2EgFB9xQyEnH5Iyfsara833lLoYdz9LezlzJDAjcDxKS8yrhOdwsexymjBRJIsP2pEU
	8SchnwGXbjbCUvlTZdHanxwZ+wEUW2zcrC/wSk+Nbbv82tEkIctFwhrWiQl6aQ==
X-Google-Smtp-Source: AGHT+IErweWrqcRE3OUYv1Tr/uF6zeqr9g8jYjpvjE6dgePIWhMhbjuHUYd714wO1Cy0fgJwbMEbXQ==
X-Received: by 2002:a05:6000:4308:b0:39f:f5f:5373 with SMTP id ffacd0b85a97d-39f0f5f53c0mr3774129f8f.57.1745332010416;
        Tue, 22 Apr 2025 07:26:50 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39efa4207dbsm15318011f8f.4.2025.04.22.07.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 07:26:50 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Xianwei Zhao <xianwei.zhao@amlogic.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org
In-Reply-To: <20250317-s6-s7-basic-v1-0-d653384e41f3@amlogic.com>
References: <20250317-s6-s7-basic-v1-0-d653384e41f3@amlogic.com>
Subject: Re: (subset) [PATCH 0/7] Baisc devicetree support for Amlogic S6
 S7 and S7D
Message-Id: <174533200972.67056.15609256008080950446.b4-ty@linaro.org>
Date: Tue, 22 Apr 2025 16:26:49 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

Hi,

On Mon, 17 Mar 2025 15:16:51 +0800, Xianwei Zhao wrote:
> Amlogic S6 S7 and S7D are application processors designed for
> hybrid OTT/IP Set Top Box and high-end media box applications.
> 
> Add the new S6 SoC/board device tree bindings.
> Add the new S7 SoC/board device tree bindings.
> Add the new S7D SoC/board device tree bindings.
> 
> [...]

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.16/arm64-dt)

[1/7] dt-bindings: arm: amlogic: add S6 support
      https://git.kernel.org/amlogic/c/93d968adbba3d30c625149d7aa12369a42b89d3e
[2/7] dt-bindings: arm: amlogic: add S7 support
      https://git.kernel.org/amlogic/c/5c9871f98b187747a873dad2773493f2117b5203
[3/7] dt-bindings: arm: amlogic: add S7D support
      https://git.kernel.org/amlogic/c/c0c89503f6b722d9eb450ce1cfe52f785be07cfd
[5/7] arm64: dts: add support for S6 based Amlogic BL209
      https://git.kernel.org/amlogic/c/5fdecaafa2377731b84c9f3af5994d990224015e
[6/7] arm64: dts: add support for S7 based Amlogic BP201
      https://git.kernel.org/amlogic/c/1b753fcfcff8ad1a63512b5be01cc6f3968a859b
[7/7] arm64: dts: add support for S7D based Amlogic BM202
      https://git.kernel.org/amlogic/c/1a30661c20dee51675a1ddee1b81b6a0e8580412

These changes has been applied on the intermediate git tree [1].

The v6.16/arm64-dt branch will then be sent via a formal Pull Request to the Linux SoC maintainers
for inclusion in their intermediate git branches in order to be sent to Linus during
the next merge window, or sooner if it's a set of fixes.

In the cases of fixes, those will be merged in the current release candidate
kernel and as soon they appear on the Linux master branch they will be
backported to the previous Stable and Long-Stable kernels [2].

The intermediate git branches are merged daily in the linux-next tree [3],
people are encouraged testing these pre-release kernels and report issues on the
relevant mailing-lists.

If problems are discovered on those changes, please submit a signed-off-by revert
patch followed by a corrective changeset.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git
[2] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
[3] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git

-- 
Neil

