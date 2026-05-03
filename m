Received: from mail-qt1-f193.google.com (mail-qt1-f193.google.com [209.85.160.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAAD43A380D
	for <linux-serial@vger.kernel.org>; Sun,  3 May 2026 06:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.193
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777788066; cv=pass; b=LSDXuzFqTvJFUYbEb2lVlgYRS6f41BUIas/WoLUrE9d/85RZOEnK9b0JiUKWwPGqKgkS5wGwj6JTkKfVlQsfu6G/5HbzDcV94KZQSNsv8q/q5B8TxS/DhI0W5RMmt+NkzUnzww3aPFQP2GDnpRfOHzUYAZxJwQv0hk9QsIseilo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777788066; c=relaxed/simple;
	bh=wCfwMR9ECj9hefOAeQDZqg7OdsjiS2RBtQZxyfoYZM8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gd15u7ZeaSZvpySVtUDXCrFeBawU9tLBFRpgRcw873PwyZI0jAu3Q2Bef6z+zEtWEg++09ehayzlJ+4pSTBk+LoNx4uXoA6intcq7djw6VRpT9Tr9wl5+LEt4mvIBofh5YNg0BPByi4c2KZUdFmvuxYw2LHvdPE176zykqBHfjw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k/3DsIfx; arc=pass smtp.client-ip=209.85.160.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k/3DsIfx"
Received: by mail-qt1-f193.google.com with SMTP id d75a77b69052e-50e5c7eb565so32864261cf.3
        for <linux-serial@vger.kernel.org>; Sat, 02 May 2026 23:01:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777788064; cv=none;
        d=google.com; s=arc-20240605;
        b=edVf2DdfiGltKYAxrosbXItyR/IWjHIiF8RFLZ6t4F2ar75Ejt1F5c7lpYsDOA+Cy7
         0KMMfPVogybuZbq1PVYxC9taNsWpAxPjxogjVGMPp7LOiI5BmNKfB0vm4/AeLW/s1OLE
         bPxCsT/G8svV/uXIX7ob0s2DOFAN3kmr16+PEqjPb2tKAlL2fi2LNnaN2ZVarCATeA7b
         EuO82uGIb7bKJ1gyzS1Tjwv7ObRHQET9yi3/L6yrautDMD0QsxIp9LX8NZo+qYNJlR2G
         VXUwEcPZC885PXR0DwUJm5rQQQy8uRP+vDmteZ9NqFgr7MkYfaDW7E9YNErwINxMLKDi
         l0EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=X9ULHTRkNyp7KStodIgdtfu2PjfPsaT5zkV+m42qZQw=;
        fh=PQ0bHL4tYm5B5Q2r2BrftHuBIjUhf+aUVCYAlG51bgs=;
        b=KH9jIFlQF6dyt+N57mEvoJmnuOfDkePKsK2jHM97OddS/78CS5AhI9SPj5p30ns/lb
         12lzipGAi1eeF5yUSXFbYiR56aPuYzNfDiRE3ZufmRdL6KlLkqEeHEYTA1THfHeSOsg8
         up+yxImWWizgXqg0X81hgxDJpvp1UXTkytBLRlqKyhcL1wiilsAcGNuqJxCWiN+Dx+Y1
         IDLAmQqDOIzn/wlOTsnzWk8IIUH1w6Q3Sv3Tdlx6naqW35KV9rwk1qOgRAYEaA2izCnu
         z4ZfZZuJGcH8/nz1KW0baau2tNBnqRVjvflPAOaE5lVuB06/XOXaATHdntN2mA41adBV
         6A1w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777788064; x=1778392864; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X9ULHTRkNyp7KStodIgdtfu2PjfPsaT5zkV+m42qZQw=;
        b=k/3DsIfx0DaTYgMKQaSS/5GQ3AU3dIybvTV0+1T0l0wlv6aTQc5tZ9dx6QdzO9g1cU
         w8SX60PLp28apvhZK06HOEs/H65j73RZ/Z6jG0J0XejDWb4fjK7dJpMkL8UdfdAXHJkn
         +ArLpjxlRsnHdsRDNCnLb2k4TPhZnyerLAmRuMlb/FSeS0/84vki1xmVu93Avz+kaWXD
         ArxMuBw0p0I8SafnqDskAqla3GnlHewVWj+axIr0HL/rgJZTgq4aT1cfRRb1OAgHeEXm
         8izpG1RTNuw7OjBdarP89OUFeBrl7pwd0tyQDgZWgwjuGF5SsewBFxb4L+nvsqsmDDAs
         NqRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777788064; x=1778392864;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X9ULHTRkNyp7KStodIgdtfu2PjfPsaT5zkV+m42qZQw=;
        b=VJF9uo6EBTVxroKTdm+W3bBG/Vj2du2k1k/ESYVLNZFG6gQiR/FxckXqmHFVrAd07N
         lesmSwkbqqLYbkd4SQVTQdtKabcJAkFYZN2GaAhsRsRLMrwYNzDJAQFM0V2a3edtDKgM
         nO3OpnIBc2i5mR31seRRYSBdcY9NSwoXAMcHazO1z1zJ4j60BituhZxrVTcnTA+fNL4H
         sIl5y9CqcyFtJwqIFYKPSFTZguTxor8NyIVIjYY4M76kq74LFECyFkkiAbI1y6WFmgiy
         r6OYscFlR8G3a3fuEYEaAjzONjOMXxbgmHbu4xCbxCsGxkg/1HFa0NQB7LlVLssyzM9L
         uedg==
X-Forwarded-Encrypted: i=1; AFNElJ8VkB7b6MhEb4F3WqziOft1iZ8A5hSoq4m2R9zYGG8uOUeKE/jKau168wF4HIuGI///KSmLkyGiMaKqoCI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVTI4U21KkSKqNv822+f39MNsHCPZqafOJNUnsfa0jHyy/cCjp
	/kQ5aVWKAkNFzJT1xReZkm3yfQKykfH7HDanL6Pr0oRjpVLKAmefXhi4c4YM2y8bbxQim0z5MNz
	YyR3IVQ7vZZfNffVF6a3fCWZmnsrDuf8=
X-Gm-Gg: AeBDiet25p4P+t7iLaXEVgXr39qa4j9U0fg6PRYNb0L1Zi7sqKiBHjO7H2YMSXQmRCc
	7rWPNPgj95C9RD/3aloIX9xEQAPQu/tE5+kHNb9VsfbsB+cJfEEpJKAUGd7WnEJDuEcf/kDn4mY
	ogoX3pPqRivvZU+AsIlAHYZ0OwGZnrUxMdE2G1WRvFyKuXlGAS7wdfExLl1Yzsy3c4kCD2SXJyP
	/rd2VBSLoN0Wj5GFHVDb5oGtVLX82wxRNou3acBo5AghZsKCnrnrF7wsNkG00ybDsjysSmkLiGa
	jbFS1zcdAcgyktPFXrsLh5v872q0ubLBQBcyf9mvgDJC+rvk1GCM2145rt2YVbE8IuR2M6RWbcV
	DvInJ
X-Received: by 2002:a05:622a:587:b0:50d:8b23:4948 with SMTP id
 d75a77b69052e-5104bf71ec5mr80525351cf.46.1777788063794; Sat, 02 May 2026
 23:01:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260503030801.14080-1-enelsonmoore@gmail.com> <2026050340-kilogram-prissy-a833@gregkh>
In-Reply-To: <2026050340-kilogram-prissy-a833@gregkh>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Sat, 2 May 2026 23:00:53 -0700
X-Gm-Features: AVHnY4Lgk75zXObx5AKxwFVNfKeHDu-2UsHM6uymzVhpbBAn4tV8BBUVB7TAHRk
Message-ID: <CADkSEUgPtjkKC684O3qB=koKDPwJoUj-qU_4Z_18NAU_+bBqkw@mail.gmail.com>
Subject: Re: [PATCH v2] tty: synclink_gt: remove broken driver
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-doc@vger.kernel.org, netdev@vger.kernel.org, 
	linux-serial@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jiri Slaby <jirislaby@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Bagas Sanjaya <bagasdotme@gmail.com>, 
	Haren Myneni <haren@linux.ibm.com>, Eric Biggers <ebiggers@kernel.org>, 
	Qingfang Deng <qingfang.deng@linux.dev>, Julian Braha <julianbraha@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Greg,

On Sat, May 2, 2026 at 10:44=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> Then that means someone uses it somewhere.  Don't generate bindings for
> something that will break because it is no longer in the tree :(
That project generates bindings for every UAPI header automatically,
but has a hardcoded lost of them, so its presence there doesn't mean
anyone is using it.

> If no one does use it, then please get that project to fix their code so
> that we don't break their build.
They have had to remove headers from their list that got removed from
the kernel before. I will send them a pull request to remove this
header and then resend this patch with the UAPI header removal
restored. Does that sound good to you?

Ethan
