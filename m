Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5291862
	for <linux-serial@vger.kernel.org>; Sun, 11 Jan 2026 18:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768156580; cv=none; b=ZpNo40YYjiBNxP7x4e8iTf+kvLhSjj1HgeOdWBt+P+MnIsfqetW2CAURX+oB+syklNzb2PGjreCjXG3QcOeA1/FuFhvjCBwLGn2YsCklUaS0neBK43M54fq8yVqCDxlUs6FjZi5fbnVrilSwMFOp0LPleT8qLeCixJmbJFaGcyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768156580; c=relaxed/simple;
	bh=26XSF8abaacHWOSeK0Gpp40CHuhyJtv5EuYNp6TvHIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=huQn0leMz8f15UhEXI1DjOKEFtE9SJ2gwZC3y/Q9CI6IrpSFBACSGFTO2B5ASJIUzbE8oEQFryJQoLHwGyGFkp8im2P8bR1V5a8wPbyZNDy/ReHeM+1yE0dGfgdF30VIKvlsZGrMV6Qn1m/KTFD+V/PTDvY8Zk1dH1z3wHoxXLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BRT/Mz9/; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BRT/Mz9/"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8888546d570so74873316d6.2
        for <linux-serial@vger.kernel.org>; Sun, 11 Jan 2026 10:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768156578; x=1768761378; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LxHKoSi46iPA5F9rX5ZhPp9IruXA7MeRTiDagdmtDXE=;
        b=BRT/Mz9/YmVin2ZHMFOt4UwzZlL6SezO/YUN+y+Fk9hfV+F8tcjFAJ48rqUg6MfPz8
         PRqJ9GmeymhSYvsS7KAet/RRfHfSbHvee+qZWpC9l5dZ9/GJIMle9aGQ7AJ6zM5Xecmt
         CFscz0GkDKy+OVU/z6BrcACbwZN+df5xZsptwQsNuWYQogfzsCUn0DrpqFqPrEJt5RQ2
         rCVxQa24i/L/pFkRz3VtUfWwbtXcPeygsdnU5u/nYSUHfzVb6gRegJAOaETF71xTRupk
         HBHBHMABP9KinAl3jpO9Cel1lTqnGWco+r0iyhXDLKq320mD64Ha7FLkEOU5rwbwt1/m
         XVSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768156578; x=1768761378;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LxHKoSi46iPA5F9rX5ZhPp9IruXA7MeRTiDagdmtDXE=;
        b=bUxDBTPOUgdF40GvG/Ctg6GpZ6DkHTLdgS8pLlgRc90Sbnu3M6tCksE1TqxKxcRFgc
         jXMmmnFO1FXhqzc59vhSl7eZA6fMqZF6OUNZ7JeOXbjY79hVmhSiXA6T0AeSQ3x4MMfF
         ttZS+QPJvPF0+owdpVxop+8+ghVYGtaom7YiPdnnAaOfk3vSHOpF0MZlC7BXzNI/RIDI
         Mo0DpP9Kjem1+lNHjtHregFgYSS5BmiaAOx9e7o66uiEyXHxOiUfr0bJ+RlP3v7Xwrvb
         jNwPxGMdeLL2B2nVitnSpa+l1LIRzBjlbxkpA2FiEQ+6g3CApPN495szxJvSPXvbOvFy
         awgg==
X-Forwarded-Encrypted: i=1; AJvYcCWNwaQF/L5nSDlQENy6elYlKrqFGYImlImlXX4uzCq9nzwhlYaTDsehgxLbE5vfhxXZc8sPCoCmXkAFfjk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwETfbVPjQIBqQB4H0vl8gmGXQ/x/FkzLV0y2u6Y/dQ7FihpBs/
	aesjPNuT+ahrL6wc1Upr+VRWV5mbCnA6jl+uqQ/ch/hmo3/BD0UR9EvPGka0vw==
X-Gm-Gg: AY/fxX51U4z+l3c+TFaGn65ra2w0E/pMCeCu4Mo86KLNJNbw1CNPxUwafmQDBAC1InM
	tI/7aGhpoBMQ5Z02ZrPPtxNkgmXNcJDdFJoJl3QwCcFfYG6uBAcN1l+pI5WQvJMs+8ih8H+//0z
	lHvpjXJpuwLoWbEu/y4+jMFsokVW1E5lsrMRiCFSMqA5vi6m4XVAbqU3xlZkiokulgPPveMpiDg
	NXKM8gYZ/0/a8kFJFfBTOgD3UJffrg1QlyI6lfWDJPerjTWHVnuhuYE9c1Qm2buA5ZFM+3Ecgb8
	zbxM1XZyMnmIUc0WRYkCwQpw2wImHoaGSV2CjFYjTV+i0dGa8sUnEaQaKXSQ4MMC09t9avhwzF1
	OsZaOSOHqWLYnZXyLNvCUUMZf10WfJjI6mHLhgY6Uy6keaFkyAeBklu/TLvEyzjxrOn6pdzJyy0
	3BgUoNUBCASuEfFzB+aNVTwWzCtM2xgZIDBQ8DGQtMk6T1MZwFgP2c8MLLhg==
X-Google-Smtp-Source: AGHT+IFr0AfQqdzuLfF2we3Zx/EJP2hZFx2oG+SaK1KaO8OqQ9sYp0F8cg/P9dtkorxfQtRFUlfUMw==
X-Received: by 2002:a17:90b:28cc:b0:33b:8ac4:1ac4 with SMTP id 98e67ed59e1d1-34f68d3b273mr14688746a91.35.1768150214300;
        Sun, 11 Jan 2026 08:50:14 -0800 (PST)
Received: from google.com (61-230-24-179.dynamic-ip.hinet.net. [61.230.24.179])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34f5f7b19ebsm15175971a91.3.2026.01.11.08.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 08:50:13 -0800 (PST)
Date: Mon, 12 Jan 2026 00:50:08 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: airlied@gmail.com, simona@ffwll.ch, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com,
	sre@kernel.org, gregkh@linuxfoundation.org, jirislaby@kernel.org,
	lgirdwood@gmail.com, broonie@kernel.org, jserv@ccns.ncku.edu.tw,
	eleanor15x@gmail.com, dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH v2 3/6] dt-bindings: input:
 google,goldfish-events-keypad: Convert to DT schema
Message-ID: <aWPUwCbFoIItG7n3@google.com>
References: <20260108080836.3777829-1-visitorckw@gmail.com>
 <20260108080836.3777829-4-visitorckw@gmail.com>
 <20260109-remarkable-crane-of-exercise-6bc17f@quoll>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260109-remarkable-crane-of-exercise-6bc17f@quoll>

Hi Krzysztof,

On Fri, Jan 09, 2026 at 09:23:33AM +0100, Krzysztof Kozlowski wrote:
> On Thu, Jan 08, 2026 at 08:08:33AM +0000, Kuan-Wei Chiu wrote:
> > +
> > +examples:
> > +  - |
> > +    keypad@9040000 {
> > +        compatible = "google,goldfish-events-keypad";
> > +        reg = <0x9040000 0x1000>;
> > +        interrupts = <0x5>;
> 
> Same comment as before. It applies everywhere, btw.

Oops, I actually had a local fixup for this but forgot to apply it
before sending. Sorry about that.

On a side note, none of your replies regarding v2 appeared in my inbox
or spam folder. I had to retrieve this message content from the lore
web interface to reply. However, your replies to v1 arrived without any
issues.

The only difference I noticed is the sender address:
v1 came from <krzk@kernel.org>,
while v2 came from <krzysztof.kozlowski@oss.qualcomm.com>.
I suspect gmail might be silently dropping the latter due to some check?

I'm not familiar with the email protocols, but perhaps it really is time
for me to start looking for a gmail alternative... even though I see many
entries in MAINTAINERS still using gmail.com addresses.

Regards,
Kuan-Wei
