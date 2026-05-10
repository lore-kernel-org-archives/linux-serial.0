Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC50A19D8AC
	for <linux-serial@vger.kernel.org>; Sun, 10 May 2026 17:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778432488; cv=pass; b=nYzg1/+wU3/3rzaXDSccNjB36fG6nfXiEAyy3zcnkmk3lOjJ48NSfApRz8402qjp0S3ZkcoItUJcxUdXHSMiF0I2+aINw9wMNGDXDhH3CLtFc7UisiM/6nCCOsDMTm47KC4EVGR9omD3VA8CjA9IcnXTIHe78bWGl6LUu0rvRYk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778432488; c=relaxed/simple;
	bh=2PYFNq5+hbLb4cWtD2+d/qyPEucjcKXGCm0hT5Z1tKE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sUWiB/KFcGlDGoEnrdM5rDURm28dSektrWMXXCwShjH4daOfh/HEILhbsX4IRbqNVo1JiuWLOCdYZeH+f1feeErveFNTRRvkP7f0q71XG09XqcDtyhUWJFN/X3scCBi+ISEoCuk3eo3QLJBsMdTP7GQ2g3ni8s0JtH4eqhWm3hU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M4F3DeM6; arc=pass smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M4F3DeM6"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7bf1433b80cso21924197b3.1
        for <linux-serial@vger.kernel.org>; Sun, 10 May 2026 10:01:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778432486; cv=none;
        d=google.com; s=arc-20240605;
        b=IO56cKr03VddwkhJ7/+PzlJ5RMpYRa3O3Yl/rZustDMVjgzmR7INRhhgJacmEMiLbO
         84MjwIz+QPtDt6avAtc5TmfF5bXPyxPYD6XheWhfohswn4zYCBrtdl+eCpGNX23Yne2A
         pyBvRDvU2YcGWcrSrLCjpdhdPUoyBm1NeiVSgksELABwA9Qaacu9MmoA8C6J7qTjHM92
         4UcyrRgyFFA9H1n4urxC77v3K2rRdxBb4OtHeMhpUXkkLFynShKmufZsl6PyeznvuTuy
         X+ies6ppULuiKVhbOzAy/d3NyI6a7ho66NU0eCHk/1qwBgxW8Q2zaXKMlQzml9W0SaH7
         O+Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=noPLUh0YcRTRvJHIPXrK6Y6k2fug3h3WbzaW49mLwoc=;
        fh=FWRCAEq2aokY3+DzKKQFwESDYxS8WL2thTk4CRu/v4Q=;
        b=Amkugr4cMMAiVIcZMejC6f60vXmIzlDwkYuT0kZylBOAukmna5AUj7WrQuoFNAGIe8
         dJ1ni0WoHc3ToKLIMp9nI2IntFOfatW/UcxXPJIUlrWPxUXgQFfIpqj5vI1iSUpiGicn
         sS+VOXBq3K3bo+5nIkQUNvW4LelL6b2ubBrfz2DUTmoVY6BF6IFaYOKniJ00x+8MyuKA
         qx2BbDmGij9/iZer8K+e8N2BRgGyZre6/mSzD+boALTmcQxiop5X2Rhjfp1SjDjOIdUX
         axZxqcb50kzMfnpnRxK9QBwwMNz9O2g9vK1xAAX2AfgvEz8yTnDbUrnrobeJcaqB5H3e
         dJOg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778432486; x=1779037286; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=noPLUh0YcRTRvJHIPXrK6Y6k2fug3h3WbzaW49mLwoc=;
        b=M4F3DeM6hb3rTzLxjDM3UvGHOwoeojZG2n6q04r/33h5bLlbcAzOwiTqKLDmpg/6Ts
         ZaSEkzTua9fMxiI7kx45jeED73u8bvDjeyGnGSMJ+DiuZpVa+D6GTyP0if+0sT21pRv+
         49/cvb/hQ5ddkxL78I9yopfM73RBsXV2GHtsv5+eaaX68HJvYAl1/UxUcDoIHPN8ZdBc
         hQgsznE3WlSqR2Rd3aLRDl8OYRnWKU4ZYvd9QPOVPcRrubq7soQg3QwiGHiYA0DArrgl
         uLvyAgu71/RCZQNfpjgAQTFtOFojOeE2/QjBQ8yaQPnb4djsaKHmqo4+jmEsha2VGEOd
         owmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778432486; x=1779037286;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=noPLUh0YcRTRvJHIPXrK6Y6k2fug3h3WbzaW49mLwoc=;
        b=ijoXHOdK5ox927KkTGqDTTyUOg5bV424Zmt41tEvkpg8Vd/UlJFtXbKXSTlEyGy8a1
         udMaR5eCyjKCJOnog67fmnf8SO6E1YGcM9VLwvXzdW275lp0b5Qh1d7AjiXVK1YgZ4i5
         zc7gcWdQX6m9sQsjqI8mo6k76VH1SLGynLY1lvqvZTBu9C7yZVnKj0PF9Iq2dzDD0Jvk
         jK5w4ift/AA5OPJgmvEZNf/Cm1j+N6eBqyC17aPBOfvprfOJwiFoiy0B4EFRaOc7jua0
         ja/V+a4/ZYCQBoJQEKOzRBcKadiU6q1ibzYYUgoCWRft2vDptfBecUPEGFHfJ2Gruk33
         uUiQ==
X-Forwarded-Encrypted: i=1; AFNElJ9xDmWbrlCDJZxttzlXv71h4uWpdvxbjvkafAjRlTcpjuQ5QbsnoBhuUAkKJ3fSxdeZTTZASLzfujXPN/8=@vger.kernel.org
X-Gm-Message-State: AOJu0YySZaK/DF4mWI3IRKQQ8pxA6ZRxIdKaTRPRPNiXVoezJY77tfEZ
	n2myOdKxBYl/xuH9EmJBBcO+mUcLmxlfYiQERZTsOPgANRYjGYRkH/c+HR/AA8ypcrlScPMRLUM
	QvGAhtoLcchpJAMjRqWKrtl9/GB0R7Dg=
X-Gm-Gg: Acq92OFG/edl+M8IPUQERO+fj5pZm16Ph8FRHifTLZKKgxrEZPt1wSA0j227IROj031
	q4G0LZbCrfbiM5PeuGk52K1P+0lgFnH1/Zl+U9dB7TvGbIAhjouVAVO0FpuR8uzwtf5kP+Kt07s
	ZA/k6Tfo/PH37cQQsDGKWAQHJ74207m3co9C/2ApNLEdgjvmc1MsHlbWm3yLHTV01VZMcwdeI+f
	oaIG4wGiN2Qn9cI9mMVA7rLL+XREZc91Aap9gplcBtep9m08OQ2D4mz0mNoQSV0HUU5+mnDdw19
	JSkjUwp0
X-Received: by 2002:a05:690c:3589:b0:7bd:5cc4:1961 with SMTP id
 00721157ae682-7c10596403amr65084327b3.37.1778432485777; Sun, 10 May 2026
 10:01:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260510031348.1922157-1-zzzccc427@gmail.com> <2026051001-peso-enamel-2e62@gregkh>
 <CAFRLqsUeat=rUj7aCSAku=A9NBNj3Wxd+xi8xzzBtRWqCxp18Q@mail.gmail.com> <2026051039-snitch-attitude-a67d@gregkh>
In-Reply-To: <2026051039-snitch-attitude-a67d@gregkh>
From: Cen Zhang <zzzccc427@gmail.com>
Date: Mon, 11 May 2026 01:01:12 +0800
X-Gm-Features: AVHnY4IHtNdZQSG8UKEed4o4jinP4nMPzFeZr0vGqaNAlXd01mf3LVSy6KHnrM0
Message-ID: <CAFRLqsWDbKsRJuLmUQhLg0AxCwGY6Nhe=Zim3YXk+yWP7x8nEA@mail.gmail.com>
Subject: Re: [PATCH] vt: keyboard: serialize KDGETLED with keyboard_tasklet
To: Greg KH <gregkh@linuxfoundation.org>
Cc: jirislaby@kernel.org, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, baijiaju1990@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hi Greg,

> In the past decades of use, has anyone every noticed or complained about
> this consitency issue?  If not, I would recommend not worrying about it :)
>

Understood, thanks. I will drop this patch.

Thank you for the review and guidance.

Best regards,
Cen
