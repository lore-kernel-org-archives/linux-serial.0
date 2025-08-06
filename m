Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A47828C010;
	Wed,  6 Aug 2025 15:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754495620; cv=none; b=Ihk7eIlchgEQC/ofo+vdHWMlL+/94LAe/dnLqGE4syRZTQZr2A/Azo6aEtW+W1bfvM9GjmsG0zX1Ve9rzQ0edIoHudJaA8TYU19yINjBYSvjuM/u7r7offgq2AD6HvDuFp3tVXr3uLigBNYvkY7RRj83PqxXOQWQ5EH/Wfs+VGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754495620; c=relaxed/simple;
	bh=8lntTrIv1EF6S0OVC6oVHi+a8/05DS+HMH/xwWZDzFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VpbCZZI0F3WAcac3KLrf/eYOEccYUB/1k8uMDYS5ombIkTXKmgsTtghAC+HBvuLnJi2QCaI7hax0rcHKbGlS2SvvuXSOFe8xGtqOAFCLn7wQdopw82t0+SwyC96HPZq0eu2/s+K0FJ+HgSVx0T5mRFpMWa1KiNfBOH/1js4FHRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-615d1865b2dso83307a12.0;
        Wed, 06 Aug 2025 08:53:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754495617; x=1755100417;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lSAeQ8xKPoGHZfbgMhDEnJIjE+pmVuNSBbErMj5IbBU=;
        b=YCuhIaKpOnJLdYQ9M+w/P7ARH4iBasaixR4d53DJrh5fXQn3zjex2jdDT4dppnP+b8
         w6vKDVATOJ5spinf3U2QX9IxHj56B/qTf+Gbs/kf5PFn54oSoJAUcW6CotQ1nCa/CVJN
         nUKCoNWq5M4BHXpcUtINLQT9yNkqVjPMCKqClZUQTpiLuujKurF1eCq+KLA469Cjq+GE
         7lDd1dJa8TIFUPMFUFgqu7H7aoFFvj0FqbpY5FbQMEl0hmRMkc7Hlcr2tpmb7iJzr6ex
         VrzO6SB53GjOL4tPyEr94WgwQ+X2ZpOxdcC8kcZJKJ2kftuoyMHm4hqADcp+MoR1CVBZ
         EQyw==
X-Forwarded-Encrypted: i=1; AJvYcCXRm9MZzuGSnyM8V9XeJrlCLBPFlTmh1FejhUQDD8xCPhYU4sEOkKiApITYlvlPFSKKoZJRa3M2V3bONItW@vger.kernel.org, AJvYcCXZBjctuSl90bmQfFFZxjwlTr73kG0vNAHDvb9HLOfr43uSeJqAtb3T+MDrvJqyhNEdtsIj7zMCZapPhjY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNHF7oAWEKtwuYyprf9IZyYH25OFMqr/DIAO3gPhj5GOpaaZrj
	RoUJsJX1YpJu4kJTDjRRABa1F6J9E3D2+Qik55MbSF9F1nzeToqnJFhn
X-Gm-Gg: ASbGnctKtUBsPEg2hFSCB1ZC79safkd9iX6hN3ZuQ68Cf8saqdjKj/5q95174ZPjiZ/
	5dWx5cjhVQz9xsr5YCH65Eg+2jvAjpouaNikptO58H5BrS2Nf18/dN8reTVYTHfF+dbDR1+YxKU
	anwe6cn2B5ZtQDmXd7cGwjKxOi73PpUgp7QQrNorM/6jLu8KGkYqaU32i1olg0XyeSVLB80CxS/
	dcRInhSVm2RlQfVxjFnfkHbP4D12XwAN+3Abf6JfadX8mfHn3mI4syAqL9o2r90ZWJwgUWw8p8+
	En71eHlubwMQLiibcoF1vrr4f0bGC+ENglAVRLdHvBcSWe1YBnXphe8THkMKQFZpFYGznPi3CVq
	dQ/7XTcNExkKv
X-Google-Smtp-Source: AGHT+IHuBBGXbLT6LQjSZys1BSvev5Nwmr6rX2z0GgBOu+Uy6QESOe3NVaVXCJ6mKYT5g9BD1FbwFA==
X-Received: by 2002:a05:6402:1d49:b0:615:78c6:7aed with SMTP id 4fb4d7f45d1cf-617961be368mr2723204a12.32.1754495616673;
        Wed, 06 Aug 2025 08:53:36 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:6::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8ffd72esm10214364a12.55.2025.08.06.08.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 08:53:36 -0700 (PDT)
Date: Wed, 6 Aug 2025 08:53:33 -0700
From: Breno Leitao <leitao@debian.org>
To: Nirmoy Das <nirmoyd@nvidia.com>
Cc: catalin.marinas@arm.com, cov@codeaurora.org, leo.yan@arm.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	mark.rutland@arm.com, paulmck@kernel.org, rmikey@meta.com, rmk+kernel@armlinux.org.uk, 
	usamaarif642@gmail.com
Subject: Re: arm64: csdlock at early boot due to slow serial (?)
Message-ID: <d6frpsfybjhdu6m77icrduuiqu6p7zfx3sbzfz62dvafkpaj56@sa5y7lvbvivu>
References: <aGVn/SnOvwWewkOW@gmail.com>
 <20250806114441.1605047-1-nirmoyd@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250806114441.1605047-1-nirmoyd@nvidia.com>

Hello Nirmoy,

On Wed, Aug 06, 2025 at 04:44:41AM -0700, Nirmoy Das wrote:
> Hi Breno,
> 
> I tried the latest kernel which seems to contain a fix. Bisecting it led me to https://patch.msgid.link/20250604142045.253301-1-pmladek@suse.com and that indeed fixes it for me.
> Could you please give it a try.

That is awesome. I've played a little bit with it, and I see it solving
my problem as well.

The machine is booting very fast now, taking 0.8 seconds to hit init.

	[    0.811320] Run /init as init process

Thanks for the heads-up!
--breno
