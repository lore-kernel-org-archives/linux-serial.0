Received: from mail-qk1-f193.google.com (mail-qk1-f193.google.com [209.85.222.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB3826B764
	for <linux-serial@vger.kernel.org>; Fri, 30 Jan 2026 04:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.193
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769748411; cv=pass; b=LT6x0kgP+DGbPjJZdQJWB8Qd8ZWrFULmACq8VRVlo+S9o1pfdt/5dsf62zEWOojCWXYt4Cx520Iy6Gz8608WvPvvsx1qLUVEBINu7cZReVK19ery2ZT6+kLaeClzZbug4wpUEIDSjgn6V2OherIF9vlGMjUHcGapCxPu7laF6lE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769748411; c=relaxed/simple;
	bh=1QJyDJE8/RwVdlpn5wHmp1OKZDbqaPptfo9AX+CnuJc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TIpgOQGgey/g1o2m7robFRMkEjeHtFG7fewUdcfh68xOLgP+H9z/hQGGcFFuS3J6EE96QgiX6cat6CvZe45VfcKiCMHPDIL20m0D0OhqFilbBBT1VbjjYaT/VLUmTeoPW+LBVQu4gU97/NubDb2oVIdXl/T34ljTg6cOpJtTQhA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TO0Nge2W; arc=pass smtp.client-ip=209.85.222.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TO0Nge2W"
Received: by mail-qk1-f193.google.com with SMTP id af79cd13be357-8c52c67f64cso164255385a.0
        for <linux-serial@vger.kernel.org>; Thu, 29 Jan 2026 20:46:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769748408; cv=none;
        d=google.com; s=arc-20240605;
        b=C2UAAB+cmtlu3P9o92IvNvGl4r0q7p654jAOZNFYYUMiosO4jBTVnCmByceZ03W8nW
         WYcZwEmZ2ZctszZCgd54UkfyLyasvmwrvbQUj9zrI/8pMuFkdlJrQ9sQna9mc6cxM5KR
         bcH8ldSSYH8nj8AyIGIGHtRWcyKrgarPe893hBq9Sio7BDSZ5XB2nq2BuRBJd7dbgvQh
         bs7au+p/L4oOxLaoqObHOOxUgYKelvZCdXcFEGByBC9ZEHvyTKp1kBSmz4VGmiLpjIDf
         rxlG9Sbuz4iLrDwt9+N4h9yz55Rk1G2S9D0Uu4KSK5Wt3UF7R9OsM5DTjjvhsUwPNBBF
         lv+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=t4LF6SauvoM56B4cbnm2wB20O1YxkaswIBTQd/3l4QQ=;
        fh=VyUVi1MpYfED2f0KG+/nW/vFkcxrYyOsx6+PUUJMzhg=;
        b=V0YtDB9vLdx0bUMVbM2gYuow9pnzJwzf92N7XYz36XkoRoCAotqZveMyE/dqCV6elp
         nEFxp9nSQxMrno/00yUzI0hSVeCf/FlJEM2ENyAvDYXk9/EZrneRByUFY7yLo9YcTCBO
         vgVNqr1vuA+JBpvHxGGPGmbIPnz1ANA8V5BdBTAUwXHtCJUqDFn1ri4EA7NeQjvhITek
         yrs24freFEf46xY5Uh4j9UA6j+36zmSRkWDifNXZSTFGf8s40ofMhbqkyxVI768q+C/S
         ywDs5bHkbuVSvTznloSJpg1sUIdnlwcfSvTJrun240zod21vRqJZyur+nSfvVhDpHqcD
         Cw4Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769748408; x=1770353208; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t4LF6SauvoM56B4cbnm2wB20O1YxkaswIBTQd/3l4QQ=;
        b=TO0Nge2WHvR77HYLdbsOMvsZjLPth4rVAvBzcl5/LE/VfPhF6ZG/sDqBrTSxqDvx0P
         9f4T42NcuJnT2s+Pw8OibXAYtTHxYlK06iETTPO8jGtw3Cb2dO8z4knHTu8v2bdVctTr
         VIWzRL3sHqqo/Riw0tgALM6ztHGmwvoKzzrMd9o2ZvVfhEMhRqM+QW/L+N3bfBVw6s22
         wrNaJ4TAX5P7kcnbVBdXVN+3estYZ6qfhpvndim3eEoilf3f40sd7JTjppVk+D2Tb3JC
         aQ0ZcG4WY+gEQSiM4LfL+vcwCl4PBpq3IV8RizfKLGZIVk9Jq2H0nDajQ3oHLtiK6XX7
         wswg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769748408; x=1770353208;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t4LF6SauvoM56B4cbnm2wB20O1YxkaswIBTQd/3l4QQ=;
        b=rhaA473wJ3fSFOkfp0mec9BWA16JvxhnjNjCxAsyBXJcVSYxr/y8sl/1NgtDEbVEen
         h8aj8h+VsEA/zdM0JOxOhpMUC//c6oQlz53Fju+UuSvk1B3mXy5UWNXKyhgia+h6TklT
         wgYKOJMsGSTdJ63JcqO+ERWLxz6Juu7n2EUVvibfaS8tEKfnV9ARBDsUqjoLYYH8LZey
         MfwY46Hl5v1zterbE54N1Lqb9pDKwH6XhmQpsdiJ0hAKj/9Vjn63KhLqou0Nj77SN+wR
         a62KYJsnbctMjvFUBpsPBvu5hZeobzqVYgvVzkQOnXrKoTH+qhZRg5jTS3/OOS4O7roL
         Sn/w==
X-Gm-Message-State: AOJu0Yz4OEnbz+8iGw1QeaSBGS8P5bCPAdzvclIymZCxMREnn6Tnodzm
	B4/vwMzWUBxPgvpeuE7GZQNqzPFVk9daYSS0HDkvt1BIr8lqsTDXRumbm9oG34M8jwOvzR0Miou
	n7xHXk3D2VjOicdEmGhab8bsJlVlrX0c=
X-Gm-Gg: AZuq6aI7T7UHDkENE8tJ/+1CV2lsaWHzEIcvCeP0wsk0XVGl7lnDLBZpczPDMZTWgj4
	B9OG8OEcmDIdVvachRbFqrdGkot64UJ1dpJpSQrYFZgaKmuKs719q8roT72rygrM02DHT7LvRoH
	FXmWJnbhtfcOv3UDN/pCO5WhgdJDaHWnbP4qHpPz3peUUOXbRun3/0Kco4xUFLOBLG6gpooLs1p
	P81DznyPFqdHk2AjCAI3vC1kQ7Cw0fTSDs8U/Dhw28MLyFp6TAtDZhoXB1psqCKLY5hfNy/f9o3
	QGrHZZuB/VYBt24/ARoMVgBAwJ6Q/MWcL3pbDyfVUotfvfSfeeuHEl2z
X-Received: by 2002:a05:620a:178b:b0:8b1:2853:673f with SMTP id
 af79cd13be357-8c9eb218b95mr231028585a.15.1769748408447; Thu, 29 Jan 2026
 20:46:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260129075200.38060-1-enelsonmoore@gmail.com> <24935907-76b8-4369-a221-f408c9747642@kernel.org>
In-Reply-To: <24935907-76b8-4369-a221-f408c9747642@kernel.org>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Thu, 29 Jan 2026 20:46:37 -0800
X-Gm-Features: AZwV_QjXPANZJhFTUmAD_xs-kXsc12oeZYASoSpgH3VuFAFrYtXsvMe2H33A0d4
Message-ID: <CADkSEUiN=5X8XjmVE-SfF1GGQbfxkHPQB=BvCJdHG7jgDBiTew@mail.gmail.com>
Subject: Re: [PATCH] tty: synclink_gt: remove broken driver
To: Jiri Slaby <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org, linux-doc@vger.kernel.org, 
	netdev@vger.kernel.org, linux-api@vger.kernel.org, 
	Jonathan Corbet <corbet@lwn.net>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Haren Myneni <haren@linux.ibm.com>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, Simon Horman <horms@kernel.org>, 
	Eric Biggers <ebiggers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Jiri,

Thanks for your feedback.

On Thu, Jan 29, 2026 at 3:41=E2=80=AFAM Jiri Slaby <jirislaby@kernel.org> w=
rote:
> Have you checked this is not included in any relevant userspace? How?
> Hints: debian code search, github...
The only references in Debian Code Search outside the kernel are in
libexplain (which has a configure test for the presence of this header
and should be fine), lists of files, and lists of ioctls, e.g. in
strace, which do not include the header itself.
The only reference of note on GitHub (although I can't look past the
5th page of results) is in
https://github.com/sunfishcode/linux-raw-sys, which includes every
Linux header as part of its binding generation process, and has
already had to drop other headers as they were removed:
https://github.com/sunfishcode/linux-raw-sys/commit/a804ac01491f63c8ce879ef=
27254d27dfcf89ff2
The package ships a generated version of the bindings, so the header
is not needed by normal users.
If this commit is merged, I will send a pull request to remove
<linux/synclink.h> from the code.
It was also used in old versions of
https://github.com/jerome-pouiller/ioctl but recent versions
automatically generate the list of ioctls on every build.
Is this okay with you, or should I send a new version of the patch
with <linux/synclink.h> retained?

> I would just drop the line, removing one conflicting entry. The letter
> is not going to be dead.
>
> Or is this Dead note some ioctl-number's policy?
It was used in quite a few other entries, so I just followed their example.

> This paragraph actually talks about long removed synclink.c, removed in:
>    a1f714b44e34 tty: Remove redundant synclink driver
Good to know.

Ethan
