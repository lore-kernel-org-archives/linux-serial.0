Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793872241;
	b=vjKLQQ9Kbp1p1P+1GP5u0aCleVLcuseQZbsDzO3GcxLzkNip9hTh3CJcvPxqZ/T1781D
	 +F8/izEJNguNQl+5ThCaV6NEesO6eBtU80F0uQLqIdC8PGAZUJbO0XydjSgZKuFr/bM4q
	 UGCg0KSBniKUiaksFs7tDHLINqwTLeqSkQjN7GfUUXcjEsm5Ed4bw+lU6iCFnufIguO34
	 1g4paOW9y6sBWsXqT7X6itGrqBjtbMcJnVzRtGKJHzdRsAaqfVjl3Fy0uMEFquwfEHY8C
	 gD+oJu38ATZIPHbzDhUBKPvdLVod+Hv9x8lAjyCVWPPZkForXxnooNjqAZKKXRNDqqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793872241;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=SqrTjgENN7Dfs+HehxbKPgACeb32UvvfMAFijNHd6N4=;
	b=yTd1oT4ofJYu4VcVXU0bCLMSJZdw9rLbQJPhWKiHYk3wQcq1XvFy3MSqEplHkUh8zd+w
	 TnmCs5ktZ7JhXZ/Km4iCIbGhXdRLLFPxVv1luJmGVXZPepnLJbTfPOS228NpaY9kPV7jl
	 qCyzn8lQxJmxorNOvfKdjPirJBnxQTlOxVDtZO5bGRiGkUUYKlAe6qxHbFahMZjwUeNOB
	 JIs2hGJZvTQfFfSBcZi5YfqUI68l4jfRciIXm9sxA84hK7We9f57anDRxNPz3xLhetYSn
	 8ae5bB34WD8EmhM85Ljv3XGxa+0ub98qcxXtvCGUrDjw564k6ogtJO6qYBKhm6YpEzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.222.169
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398E6606D81D
	for <linux-serial@vger.kernel.org>; Thu,  5 Nov 2026 09:50:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 398E6606D81D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-93e635220b4so158956485a.1
        for <linux-serial@vger.kernel.org>; Thu, 05 Nov 2026 01:50:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793872240; x=1794477040;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=SqrTjgENN7Dfs+HehxbKPgACeb32UvvfMAFijNHd6N4=;
        b=yVawhAfn6ehAqPmEmRpb+FT84ZlumCJ8wEZ3yiSsKqVcNl7N8eaiw2mJHYBZWpESdi
         89Y5YOasBt+QRtGF78F5eLFwyNoqY0c5hziTESDxR1XUCsPANjloW2pdD1LufVxn+6t4
         x9QjbCSYbpKenUKEcwoZTS7AKaEqEDm5LJCZ4GeRSda1fVK00bh3LzjGtt7EIDDubRVI
         YfBFSTlwgyQ7F81/yG/KN2OBJlsoMax7+1P0n8O/SIyDg+kWQkARSuiyzBQVjTEcHDs6
         eB6xZm2KQ3P7U8EVHuoR8sh3d8SRXCbozjNmlogxAKaZmwBLlA9cr7HxcyB3t8d4hRHD
         +w5A==
X-Forwarded-Encrypted: i=1; AKwUvBy4uyQfvpXZ1EUaIsDyDF/epHuZoGHP05udg66rAxwHOcZcZetOrWljdAXiwey0ahBsB1ig2rri6rBVntw=@vger.kernel.org
X-Gm-Message-State: APuU4Z+WJDn6+wEo7Fw4d2NLQdN0lipck4TGr2Aoh0PEFNOX3WiBbUgG
	aTa8/jg/jwZMFqkpch6xmy4amhL7AUc+K4rlOml7aTr/5HchtzQKDKOMNlnaguJiI7U=
X-Gm-Gg: AYBFou1TueqOXAu6Kz8qCkUtFXiBVb5EvEdGEat48fGf68HU2BZ8mMq0GawYV0jkXi2
	kXLYFz2nFRheiklL5VnnayNA1UdJPlMcd4KnGvi708oLX5jejrEDJymMx+3VDxXWqNrGjoaV1zg
	AiEWJwwxzHxyjYebm2XRFVZfLTvI3hArB8aNmeAYCiiy9m6aYF7Jzh0mnfSdDFrQFUAp5Jcyq4U
	8ZhlGE/D1E0O2kqp6m0Z1csVC9sPLsr7jOdazCBakIOy7sua3PAbyWAV8E44H/mgYOymYyYrBn5
	FE+MmbP/bAZPyCZt0SQFUnQ4RZlzmCpHFC2ReAHZMM7Jj2CkD0rReHgn7sY/vhu33e0/0D7SUFO
	OSHMsn91J45VBuhzX2hfUNDK5LlZPP8w7HbxkmerYs4HRrMYbr0U4DSLwr5QlHUOIyNMXvvxSMY
	/9Oow316en5RLsSdDm0tR6AoWQmagWz99DP3NqQFKWK1/HgNNxGwSIPXJnvtBQgrmFIrxfqK5pO
	Gb83GGY8uxMUju6UVb/Cxn1R8FhA+nk/6GR94WGPVc6cv4gk8Fqn3jlaeo+fensFXAflq1J/mjQ
	C3OFxjR1FEDJ6mZyf7+nPVrhwbzfJqG/3cPCdbnhLk4QNzTIQv4wG8R3F5zIUZxpxYauP/Cavov
	RPHNOZvqNTCzL9WU=
X-Received: by 2002:a05:620a:4413:b0:943:faab:a149 with SMTP id af79cd13be357-94421700a82mr3193184985a.63.1793872240162;
        Thu, 05 Nov 2026 01:50:40 -0800 (PST)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com. [209.85.160.175])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-945d455bddasm425296785a.0.2026.11.05.01.50.39
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 01:50:39 -0800 (PST)
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-533778ab0bdso18431191cf.3
        for <linux-serial@vger.kernel.org>; Thu, 05 Nov 2026 01:50:39 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvByY+HflZ99DV0mYdeUQ/4+kZ0oSgCSllm2E2DIFcA3xMb2KUzQYlaDYpBNqOiU0k4S0yGq9yDdmCvVlChI=@vger.kernel.org
X-Received: by 2002:a05:6102:3ec5:b0:7cc:2bb7:131d with SMTP id
 ada2fe7eead31-7d072baa484mr7324212137.9.1793871885062; Thu, 05 Nov 2026
 01:44:45 -0800 (PST)
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104-work-procfs-bugfixes-v2-0-021c84d852e0@kernel.org> <20261104-work-procfs-bugfixes-v2-10-021c84d852e0@kernel.org>
In-Reply-To: <20261104-work-procfs-bugfixes-v2-10-021c84d852e0@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 5 Nov 2026 10:44:33 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUy1RYKG0g8OWss3AD-jyYx3DXL0K7ABYkFUdxTxZ9VdQ@mail.gmail.com>
X-Gm-Features: AclHuK9D-nB8icBns0zdoQH8fV1cfUPJ6LOey8o_VlUZpDIGqKC4cFf8-j5-HdE
Message-ID: <CAMuHMdUy1RYKG0g8OWss3AD-jyYx3DXL0K7ABYkFUdxTxZ9VdQ@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 10/51] zorro: size the proc files like what they serve
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Jann Horn <jannh@google.com>, 
	Josef Bacik <josef@toxicpanda.com>, Chris Mason <mason@kernel.org>, 
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, Eric Dumazet <edumazet@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Jonathan Corbet <corbet@lwn.net>, Christoph Hellwig <hch@lst.de>, Greg Kroah-Hartman <gregkh@suse.de>, 
	Joel Granados <joel.granados@kernel.org>, Kees Cook <kees@kernel.org>, Jan Kara <jack@suse.cz>, 
	Jan Kara <jack@suse.com>, linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-wireless@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org, ntfs3@lists.linux.dev, 
	platform-driver-x86@vger.kernel.org, coreteam@netfilter.org, 
	kexec@lists.infradead.org, linux-pci@vger.kernel.org, 
	linux-sound@vger.kernel.org, netfilter-devel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, ibm-acpi-devel@lists.sourceforge.net, 
	jfs-discussion@lists.sourceforge.net, linux-alpha@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-cifs@vger.kernel.org, 
	linux-fbdev@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-mm@kvack.org, 
	linux-sh@vger.kernel.org, linux-usb@vger.kernel.org, 
	samba-technical@lists.samba.org, sparclinux@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-doc@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-atm-general@lists.sourceforge.net, 
	Takashi Iwai <tiwai@suse.de>, linux-input@vger.kernel.org, linux-raid@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-modules@vger.kernel.org, 
	linux-debuggers@vger.kernel.org, Chuck Lever <cel@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 4 Nov 2026 at 20:18, Christian Brauner <brauner@kernel.org> wrote:
> The files under /proc/bus/zorro hand out a struct ConfigDev and seek
> within that, but their size says sizeof(struct zorro_dev). Say
> sizeof(struct ConfigDev).
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
