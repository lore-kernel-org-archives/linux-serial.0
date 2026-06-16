Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE9A3C3C16
	for <linux-serial@vger.kernel.org>; Tue, 16 Jun 2026 04:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781583741; cv=pass; b=ii2GzBO7PWVdqac9+AQP7Q10F9/lGnaNuHvaj+G21Pu9zY3tMHJL9tTlCkauAr039WN/4IYsphlQLZK+MEEBlH+xNBz+ZDs4y39R8Dyg/YKDFIdeblkPbGMv2D1UP1ruy3dJQeT0HrD7B/UJEU2a3KSIIxqTl5toG1RmHwCm46E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781583741; c=relaxed/simple;
	bh=dra/zZ5km3G29j+KitrrAM8pW8NVH10i4w0w0qc8jaI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cf0GleyThPE/3eB0q841FBnzKCxP11KGb0lCsNPhOVIc267QI7hUuCko4nl9G1blEv30GUcA9q6Rlq46f28i2AcJt8lwhFAUuATyhzzvxFHK1BFgDtymu+kQ/QC3LgbOuB+oRpMEoNzQIJZRAH4KqvU6JVDTbXHQrnMTyTKlAyw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N07oIaQn; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N07oIaQn"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-5177d1ff061so90071cf.1
        for <linux-serial@vger.kernel.org>; Mon, 15 Jun 2026 21:22:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781583739; cv=none;
        d=google.com; s=arc-20240605;
        b=aHT7Ho3dK4H1xDLejpnN2mwNI8IWSFFYBZLILzzpJdM9NAPOPY1n06S1153eqc+JLg
         kxXAoi29lv4JU4kBTr9lemOuGfxfqiBNeQSjkWBtYoG3yWguX7RlGOe7VdGbkCkYAy5y
         bMj+E0wwibC+7H5NPSTO+CqZt9UCCvuoPvpxNqVnRoBEDqoAssDeHBx4XAvVDAweJL/P
         If+2i6mfiYGeT6LMLRlDpLHfbNax6FXcDo9bkymLpVnH6uNXWA0WUhyM9GkA24/nnDN1
         +nSVOEo0RWi2FSbAt1ncH3ua8dc1G3jBdg0Av9e3wWN8psvVkPwoinuTV77Mq9/dWJUd
         qH7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lA0yH24+Cezyn773tJy1ut9HT5Wj3zCnOg1wQgKUTog=;
        fh=2L31D09Ge08e5Avh6ssw2pzXgh+/1VYC13M9wyCp9q8=;
        b=RoBOwfaAK0mjMrekeu4BYOJ48goXHmI7O1/Yekaj3o8TW/zQdRXjcyxCkVsFpd8dh5
         5QRb23ud15GosAIZyu3XODRyajqupzapQmo/eZ/bfKOB0E5nKF4rOQxd4u7lu7lBlNQY
         GDUeXW7vcgzES+KQ/vxlqoGPRtYTGj8/dSaV1sPx9v2ResUVtKd9RfxwSnOJUfoHnRHQ
         l/X00NZDuvgXdo2A6hw+NcFK1kmsH0vm5fo3UHSb9SzVqs47m6pMvgQPHcxuT+uX82Bd
         tjyH51DZZbc+JDhKaNSZbVZ/2FqLFZ274fl6MrPNJ1IB5XGGR8t6/vMPxn/tLSDZextK
         dsjw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781583739; x=1782188539; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lA0yH24+Cezyn773tJy1ut9HT5Wj3zCnOg1wQgKUTog=;
        b=N07oIaQneR6d5DIukOgVdpj6UkVcE8hRwNnB3Uv0JsRQ9HaMrIEwc3NysLikPTm9TJ
         PXh39AX1YzDp8fDSOZ96gbgx2q53lDzvUk59BHc/g280H09RqFshUdSDGOoHZKQ8jMKb
         KsUML/39Wpk2OqJ8AYRNR/onysTlIqXoDXlOIz2MIUmp6AKPzmcdI70WjrAnPgzID0Ud
         k8Mrek2FJ+sZLj64nZRP886LsmOFxFl/NFxz9PX8fzOdTLo/ufuG7kXkbxX/rKAwXzi2
         QrMprHgtYvahLHRKKp+26zzmEcvJQCWFLBv5yZRf+po65FOmL8KYiDLR4r29+DFeoEx3
         EvsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781583739; x=1782188539;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lA0yH24+Cezyn773tJy1ut9HT5Wj3zCnOg1wQgKUTog=;
        b=OgYWg35fw4JmhR8tx/BeOhHnCWh/Pf+jatOZhhAkVuqd26+GD7aDAAIPqDpAvg5cP4
         qyN6TJV33AX8Owe0bjd9wokQ0HFqbSuV5wDy0bdkGfbAvM3d94OPp337VXIvMbYNnZS1
         o0IrLRSNxV21P5IIXT/wO/KlzFQZdGn89+HfW3B3dwGLUbRqspepfZ0Hrj6HPvpD5Eqp
         j40o+kSs412ceRuDuHfSaRlTAD5+gQrIFUe845j4RNIanugObGMewf1hCHAGlgBsqtGE
         Z2TbtQCjRR35FjFbzlEX6AfsfZOLOw604Aa6L0pxy7yY0Qec5N1WEfTX8h8utEVudyoo
         hLsw==
X-Forwarded-Encrypted: i=1; AFNElJ9tdVJLhf99ElvMUr1tXv8n3n/Gj7vmMruREiiwvGDXoSjJxBJrdK49Eem/MMpKi4IohjOfKijLE+W4Eh4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/cgaFWvze7ghpWL2GolNeebbhkKOikOi4cW/my37xdLYdM2hI
	4H+lOTiKft1lqdqy8VD5MMFCZu6N/ETUF4KtbbFQoO4JD9sWzVMktPsP/3AsAUVUARM/KwmkG9z
	/mJmiY7azf0YLsBEey3BnjxZpUohLy7pm2yvGjD6J
X-Gm-Gg: Acq92OEkye62KcWk+zDw+PBzzI8sJ4ZJNsXPxS26jZ/npAXArSTCJU0agZZ9e2a9x46
	Ba4AfNhU/AS3Gjq3yX9F0eu+uLDDD7tGDLuTQ2EeiPCPgWjQ+8Fa869dMBG6Blh/nmlsRxHmRL8
	BIfE1jYDLAwov59eRqdzNnznKsh3LBadr0MyFw3IMdb3sDzGxcFL+IAYPyVBzMgii68ZG7qDRw8
	JFLc01v1zgjDBisqEUFb4ajybSIxKp6EKE3F5LRza7z4NVnAii0IqJ2ek/q6GGok/PAZEWDZF+V
	QxaoFqGzQG0UirxnGqaesGDcOq4l26o9OG8VAQ==
X-Received: by 2002:ac8:7f83:0:b0:510:f9b:fb5f with SMTP id
 d75a77b69052e-519904708a9mr5607221cf.16.1781583738356; Mon, 15 Jun 2026
 21:22:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260615142605.2795757-1-himanshubatra@google.com>
In-Reply-To: <20260615142605.2795757-1-himanshubatra@google.com>
From: VAMSHI GAJJELA <vamshigajjela@google.com>
Date: Tue, 16 Jun 2026 09:52:06 +0530
X-Gm-Features: AVVi8CfudAAoXZ1vjq5ljvzCudhnb0iul2FENa9nlP6SO9vtHlrgOdFbKFQbIOo
Message-ID: <CAMTSyjpR455jn8pMFe43ozp1b0Jj9Vy9dKuD8LrcbMCY-cT+zA@mail.gmail.com>
Subject: Re: [PATCH] ufs: Add HS_GEAR6 string in power_info/gear sysfs output
To: himanshubatra <himanshubatra@google.com>
Cc: Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>, 
	Bart Van Assche <bvanassche@acm.org>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, linux-scsi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	manugautam@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

scsi: ufs: sysfs: Add ....

On Mon, Jun 15, 2026 at 7:56=E2=80=AFPM himanshubatra <himanshubatra@google=
.com> wrote:
>
> In power_info/gear sysfs, currently it supports output only till gear 5.
> If operating mode is gear 6, it is giving output as "UNKNOWN".
it outputs "UNKNOWN"
> Add support for HS_GEAR6 string in sysfs output when operating mode
> is gear 6.
>
> Signed-off-by: himanshubatra <himanshubatra@google.com>
> ---
>  drivers/ufs/core/ufs-sysfs.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/ufs/core/ufs-sysfs.c b/drivers/ufs/core/ufs-sysfs.c
> index 99af3c73f1af..d1f5041fc3c8 100644
> --- a/drivers/ufs/core/ufs-sysfs.c
> +++ b/drivers/ufs/core/ufs-sysfs.c
> @@ -54,6 +54,7 @@ static const char *ufs_hs_gear_to_string(enum ufs_hs_ge=
ar_tag gear)
>         case UFS_HS_G3: return "HS_GEAR3";
>         case UFS_HS_G4: return "HS_GEAR4";
>         case UFS_HS_G5: return "HS_GEAR5";
> +       case UFS_HS_G6: return "HS_GEAR6";
>         default:        return "UNKNOWN";
>         }
>  }
> --
> 2.54.0.1189.g8c84645362-goog
>
