Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4891BF58
	for <linux-serial@vger.kernel.org>; Fri,  6 Jun 2025 19:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749238636; cv=none; b=UPULTICkTI/7KliHlLOexYpZIZMHeoiEGtGAHrCFOzRiVIJ1laSAxpbz76x9581ALlmzzmoxSLPruIaNG+zDdu5EnJa3H9nBMRtoNDJgGpogd2uA5rs8e3C+h/L8M7UhWuMUIkG0YIl+xIQMyhMfyGRSC6NtO+M7h5iXQlAGLV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749238636; c=relaxed/simple;
	bh=DP7B/KnXqE/5Fx+2b6vnlriV7vATtl0GEcFlV7hZQBQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=anAPB2AnxXyE4RJ368fcAYfNSl3nlEQMzNHi7GeED5afSVjPOZnYect8EDJ5X5XIHL85tj6MjhVNj0qjxjPBfbS8shsBPH5/tuCJvNZ2a4AujboEzpFPFdK/jDQyka/5oxA0XdEpItK3bFXeQoVb2w6vmLUePGlAK1AJTaITUM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=dbBxvmOF; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="dbBxvmOF"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ad69e4f2100so415600766b.2
        for <linux-serial@vger.kernel.org>; Fri, 06 Jun 2025 12:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1749238631; x=1749843431; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jgatZKIZeCG/8Okk2kimmj0LPUfz/8b8SqKivoXRX6U=;
        b=dbBxvmOFkdkQfopXBpg7uhRU55vh1JlHlFmw3px59iOZMHKybr80EZUqVcxIMaFaVK
         V3Rb5KxmmdjvlLjqVDpPh9Phmbo9HRt0+xwwwZX6NFibW+uD710QEv9io8AhPiEB2C18
         kgcshvkXfhStv8lBtFRNoSx4Z15W0lQ0DTHUs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749238631; x=1749843431;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jgatZKIZeCG/8Okk2kimmj0LPUfz/8b8SqKivoXRX6U=;
        b=j1C+fBB5/cv0DmFbzwSxx3HCJSDDekIwBcwONX9VVYopQsO51Y88n+XV8wDuX3W3ew
         xkI4nuUnxqFEAYSyRuauaeC5tAJo2t1hNG8EY2Biw79bPaZhuRJ9Xm4f+9/ikonFEbvA
         HNy0wyiXmIWx3Aw+pEPT+/uWHLLp9kIV7Qp8e70rZzi7FlTEbccmd7w40bwpyUjlwHAB
         jS57glZcylV+obQSAgulrM6heZzl2+spHQNltajW/Y8N1jFAHBDu5IExA9MRWLWlM0wr
         cyqMzNFrFPNQkQWdTaY+G3XB6Rvnr24snI7Aa6OP5BRZB1dhd+tZB4rCid5SJJbRLh8D
         e6Ow==
X-Forwarded-Encrypted: i=1; AJvYcCVtx4lzLSM0Hxo9mCg+ZIVIz/9RoHc8xwRuoJBc1Kv1M5nh2HyeA1XrsuvQ2JgaWuIiek6b/0AWjZ89YIk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoBo9FGcmSL9Rdb+YiDm0CrJRRSJ0WMJOhloBfhsVe+FQPsXwc
	jBc235QmwfsAlzfxDPijucG6TfAMBByUQ4VhIljtwfA0mWYFdrPJscewEP+kI5ARswXNeODtKVQ
	Paunbt6I=
X-Gm-Gg: ASbGncsa+A/JNzwgw44gZnc7HbBrWF2DiwgU50yKkM47Ntxzy1ImFTn8wyjszxQ0v1q
	DknLY7EOVumsnSFcVhajuwGFxFiqTiYK06njK9nsUory6VJkKyrmwbli0oJaTLX0PD9vfNR+AOa
	YNxSWPW6Hazch1GE5QXWqepuXKOmJuuV5ja8rV4EM+hKvjRCCFxu4AgR1g/GnNwhmlydHt0HC/+
	Vwtg1/4bDwI+ce1avNGSKp+4OAG3zsh9msvEEAtG+tD05jWNyXiyjUF2Rm1LLQDiBzfxjiI6Lt4
	VehwVKvW+S723i/z53aXPPSiNkMr2MsxOfe9F5znWc7j0o/J+nGIFtZ1EfhDu1Hp9f7hISrrYFn
	FGxuFnFjEveRWn0EQRfiVx57kSzVLh0CTGN8h
X-Google-Smtp-Source: AGHT+IF2LnffiUVRQEDM0J5X0cvrRmWcpcjQMY6pEVukGBqvNueePAPv4XY+qSDtvA4wfi/jK+Oi0g==
X-Received: by 2002:a17:907:3f0e:b0:ad2:2d60:24a1 with SMTP id a640c23a62f3a-ade1aa5d453mr363788466b.11.1749238631132;
        Fri, 06 Jun 2025 12:37:11 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ade1dc7c765sm164186866b.178.2025.06.06.12.37.09
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Jun 2025 12:37:09 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6077d0b9bbeso1556711a12.3
        for <linux-serial@vger.kernel.org>; Fri, 06 Jun 2025 12:37:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWZLMOhVIQPUOlVwz3qDH5RlN9iBei+CWvt1juAxhkXfTCVyD3RYwrXpCQqrr58CQsZs9UjFdwbToOzQI8=@vger.kernel.org
X-Received: by 2002:a05:6402:1ed5:b0:604:e82b:e255 with SMTP id
 4fb4d7f45d1cf-6077285cb5fmr3963530a12.0.1749238629421; Fri, 06 Jun 2025
 12:37:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aEKpKk71YuLPPMZC@kroah.com>
In-Reply-To: <aEKpKk71YuLPPMZC@kroah.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 6 Jun 2025 12:36:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh3sbe9ZU_-q4Et=OWtedfFoB2tsZy_+ssMRZnsjApYhw@mail.gmail.com>
X-Gm-Features: AX0GCFtGZ3fLGhUMu4DFWfeNgP1rwthkpBUB0ueA9yTfoNZEIvW9N3jor1L4vq4
Message-ID: <CAHk-=wh3sbe9ZU_-q4Et=OWtedfFoB2tsZy_+ssMRZnsjApYhw@mail.gmail.com>
Subject: Re: [GIT PULL] TTY / Serial driver changes for 6.16-rc1
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, Stephen Rothwell <sfr@canb.auug.org.au>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 6 Jun 2025 at 01:39, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> Here is the big set of tty and serial driver changes for 6.16-rc1.
> A little more churn than normal in this portion of the kernel for this
> development cycle, Jiri and Nicholas were busy with cleanups and reviews
> and fixes for the vt unicode handling logic which composed most of the
> overall work in here.

That series of "revert one series to re-apply the other" looks
absolutely disgusting.

I was close to deciding to not pull this at all, because some of it is
just inexcusably stupid. Lookie here:

  git diff d066989a3d41..d066989a3d41^^
  git log -2 --oneline d066989a3d41

and just stare in wonder at the pure unadulterated garbage.

Yes, the second series then improves on the first one the rest of the
way, but this should have been done better. And I don't mean just that
one truly pointless revert and reapply, but just "people should have
communicated that the patch series wasn't done"

I've pulled this, but I want to protest this kind of development
practice. The complete mindlessness of that "revert only to reapply"
really almost made me throw this out.

               Linus
