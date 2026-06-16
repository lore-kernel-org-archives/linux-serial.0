Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5122E413D8C
	for <linux-serial@vger.kernel.org>; Tue, 16 Jun 2026 08:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781598468; cv=pass; b=BEpb2J2IvOzK2W1CXHnx7c4jEJn3w05EMKQnq3g8OHo1bdNACIeC2W/S1EzNUqVn2r2Ne18EElDctWYkxA10GxJ3SYs8Kg05uAPTDThn00HDpVTFhURtLGZAN3Epy+Q/eTAFNd7WSw2LbH76Q6ieLPd+xMjEAmopb5FItZJriL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781598468; c=relaxed/simple;
	bh=8JifQUbXrrAMq1t9n4ZDQyXptIlhkJd5r1PPBLZL1Co=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SGn7cRL2HlM5VfmiU4o1YLEgwj4IJ9UeryEMEYv8HNksapfasI4q2v/fwuq1OKBxsrlPRdZ9XQ+YOwka2uO1CbVOpSobfRT9bDGjwMpTArkTTvwLkhPNDeak7ABixogCYl+Ci0NfQomM6qDZEeoyadVa7l0dbKHc8PPpEjWGA48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iqDvHQsz; arc=pass smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iqDvHQsz"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5aa67ddcf56so3754e87.1
        for <linux-serial@vger.kernel.org>; Tue, 16 Jun 2026 01:27:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781598463; cv=none;
        d=google.com; s=arc-20240605;
        b=A8kMS44b2EcCSchPvHlujgRnbkoztJLycam0laT/3Pap5NpcxBtSR9t/skT4GooKew
         kKtAM360nM6EYx3xvU1MzumcF+k4k5fDlrpSWZwAFt7PbPvWSoHk0802DGAg04hStOAm
         fRR8CvRdsfxcDWdSOqlPsW9ZXic8+oemF+1weYm4lQbFcucTolhTWqKeSBMtjrdNccaC
         tV2mGYoXNoubXxoeXnhtsbbG5ShyQLPpPeKoyjoQI2k6gRBtr5HvDwsZeZJKNU+qihrU
         ielvOauMJiewqlfGQ/Kt2UbGIbp7By5QzDlxq7TkH00KtZQqcV5qY4nZD2WIh+wQODZt
         kq3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GKRTLd9j4cB5XswwDjP9t/j/lbwbXU+z4hJ9WHGCvcI=;
        fh=3+KvP5lgred0/g4ZJteKymyYA3ISrdd1l/sJebQ7+co=;
        b=KPrjttXCImrZfiRQxLigMykGBOVIDmpkh7f/8Mb29GSffBfSjZZBMr/2UUxeZc4KQm
         uLmWOy7UYASuCCpnYuWsmiWhqC4Hjommkxo7lANGaROWQwo2ZbPYBXym6t64ufaoW22G
         NLndV7kf9hFeFcGjXKTA5YmPByiSYFHI3cpwnt3G9JX14PVyLIX+9fC9bzptl0LAzsWp
         xhJ0DfBA2xEQHj2TBe84I6m/6Y4MA8wopyCrVlpNkJP+RQKEh9S9DbqOoHUIQCEgDn2v
         MaI+GJXDmf9xcclMvFmUI/2cwfa9Tn5/+D3Nqm8aYU4NxM+jvyT1EkidtbUdS4POBIEZ
         5ZbQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781598463; x=1782203263; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GKRTLd9j4cB5XswwDjP9t/j/lbwbXU+z4hJ9WHGCvcI=;
        b=iqDvHQsz+KRcEdn9ukLBkIG6q71ZCAX+2Ed0IeZyTczVjMWrYT33H2DTKwjaMeRZeZ
         v30rXnYCppeJaCofrKtYnk3qgq4x4T9/Rbo8ifijkQTJPicwDeFXa+u+rt/wJ2S/ZRk1
         u7bVP+ZWgtMy8yHTF7BNo1ZbEeu0aWe6Kc6kzz9k/3qPIgwl+52qo2RAUZ8BrtGjZsW2
         CCFw7C0OHpclcHWNve2SLE8iFVURz/5NCgBBlXlZ/QLqvauEntvd4HucaED2YXrF5hKm
         mZNk75yV/SvO65gqjEPXmXaxlGmFIjaKTZ/3qGk0d3rjQpFY5MyQfLiNJAZ7LT9jF/K6
         CnlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781598463; x=1782203263;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GKRTLd9j4cB5XswwDjP9t/j/lbwbXU+z4hJ9WHGCvcI=;
        b=hMQESU/N/VuX1EsnlfwuhU4K51GHVoqKMo9po4QZBG5rgr/xB0tX1qKBGiJvoL8ViH
         w7CP/PhVkNF/XM5TZzhxhYiji4HRZM/PQNvVHNodGT8pt0gf4Z//wgLbVmTBZz06mPR/
         YzjP1gM2mmLcoSfE3ENcx0hXra+ojCplBIp9B4QGPMLbb8wajZmjthsh5XKxJWXq9hF4
         Zj5ISh5VoSedMbsEHOBfKP5snz2VqPBrWDvvO4L2a/L2xK7SJm3gmiUVAICbhkNJ/NmA
         AAKWfmOv6WIY4NBUZ7UE5rA5iyeSZ0dGdP+fFwZVzaihtqiWdtu5AQ1mrR7Pb4crl6pf
         HAmA==
X-Forwarded-Encrypted: i=1; AFNElJ+tarqonHpmV15OgS8WBXpeXWgKOiZfJCI98m1XBBQL+RI2Vr3/4VHm2BM2j6WzHynQpfAsu2x2xRXziLo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/9osLhxj70glRdYiMeR8F+yU/xsfzS+YtSuVo+oYZz/jpHS4o
	5LMdV0Qrf4sxwMzXWhZAGcjS6Bk+HwJOBIpjew1N9Fz5p2zycig3iYpW3CmhIZYUEOQyzYAiBmM
	BdhzjQkKGpoRyOMQkVgrGiv1I+f8CxQ4UtoLzr43B
X-Gm-Gg: Acq92OHI2Ve8Dg2WAYc43IZCEuMVMg20XnXCrsUE+GMFhFpzmLhcBfJm0yIQ12Ivjb4
	lvISgng/K+WOWu9nOFKaa6BxkugVAc14S2ejAJniimfgG6nSzSPjLmme29OiNoGxScBk7bW3PkP
	m2HP+A0u2XlmaagC2TGY24T8SGLvIjpLgDalQWtGq8h5dc1cm0SpYlHT7xQUJFlzI17aWnz+j0E
	6JVbF6kJoJtftcuD7rfykdrFUlaowRO+vslvdN+d5yC9lTrvaeOwOvz661sYnYDxtgyuNkLxPYq
	8LF0C7rELia9IcVYlbeCRKGKjgEy1pMTzkk+e7UAuBzjWOmA
X-Received: by 2002:a05:6512:8048:10b0:5a2:9b28:d64a with SMTP id
 2adb3069b0e04-5ad43782cc6mr101111e87.8.1781598463014; Tue, 16 Jun 2026
 01:27:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260615142605.2795757-1-himanshubatra@google.com> <CAMTSyjpR455jn8pMFe43ozp1b0Jj9Vy9dKuD8LrcbMCY-cT+zA@mail.gmail.com>
In-Reply-To: <CAMTSyjpR455jn8pMFe43ozp1b0Jj9Vy9dKuD8LrcbMCY-cT+zA@mail.gmail.com>
From: Himanshu Batra <himanshubatra@google.com>
Date: Tue, 16 Jun 2026 13:57:30 +0530
X-Gm-Features: AVVi8CdhPQ_5i34nIM5msjTqKwtTvRRuxkAH8xClyhd-SFYz2UvOydZuSNPql-4
Message-ID: <CAEif7DR3KUdhPww-q_Fn6gR6L=V5nrD3EyLn3vi+hWLmS3eU6g@mail.gmail.com>
Subject: Re: [PATCH] ufs: Add HS_GEAR6 string in power_info/gear sysfs output
To: VAMSHI GAJJELA <vamshigajjela@google.com>
Cc: Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>, 
	Bart Van Assche <bvanassche@acm.org>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, linux-scsi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	manugautam@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 16, 2026 at 9:52=E2=80=AFAM VAMSHI GAJJELA <vamshigajjela@googl=
e.com> wrote:
>
> scsi: ufs: sysfs: Add ....
>

Done in v2

> On Mon, Jun 15, 2026 at 7:56=E2=80=AFPM himanshubatra <himanshubatra@goog=
le.com> wrote:
> >
> > In power_info/gear sysfs, currently it supports output only till gear 5=
.
> > If operating mode is gear 6, it is giving output as "UNKNOWN".
> it outputs "UNKNOWN"

Done in v2

> > Add support for HS_GEAR6 string in sysfs output when operating mode
> > is gear 6.
> >
> > Signed-off-by: himanshubatra <himanshubatra@google.com>
> > ---
> >  drivers/ufs/core/ufs-sysfs.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/ufs/core/ufs-sysfs.c b/drivers/ufs/core/ufs-sysfs.=
c
> > index 99af3c73f1af..d1f5041fc3c8 100644
> > --- a/drivers/ufs/core/ufs-sysfs.c
> > +++ b/drivers/ufs/core/ufs-sysfs.c
> > @@ -54,6 +54,7 @@ static const char *ufs_hs_gear_to_string(enum ufs_hs_=
gear_tag gear)
> >         case UFS_HS_G3: return "HS_GEAR3";
> >         case UFS_HS_G4: return "HS_GEAR4";
> >         case UFS_HS_G5: return "HS_GEAR5";
> > +       case UFS_HS_G6: return "HS_GEAR6";
> >         default:        return "UNKNOWN";
> >         }
> >  }
> > --
> > 2.54.0.1189.g8c84645362-goog
> >
