Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25AD13DDAA
	for <linux-serial@vger.kernel.org>; Thu, 18 Jun 2026 03:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781751966; cv=pass; b=cJGn7C3pqE1bUjIBfQ2v8eQKT6EDFQNXpiT5W0qrD1g4U6a8q8P2G7VLuWlOTXMWjC5DHtssTuIylic62/IjrdZhaQwSffh9Oxey6SFhtLcVtzJZ+30nd2d+6GnykGC2BbxuN8K8mG8KMXuZrnoDX9n6xoeb6Sf2En8pO+hokhA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781751966; c=relaxed/simple;
	bh=e127pn6LW6tWjlOu9OkPQSyzPri3W469H9m6nmPZIco=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Crk7rwQcN17vZsC1w12xpqs+Eogs9B7xrdkOrWg9EW3MsQhT3jFCu7n4N1TyHhk6d1nRJZ4Pk4QkQhnqxzJRCGOcc/MiCylbO95/CJjsRIRst6uoSomTJThssNTI375VzVqhI3gTaBNijOzUmXN0uX/WVRV4igcwixoA9CLRzIo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lBCAOgF3; arc=pass smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lBCAOgF3"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5ad4c101545so4416e87.0
        for <linux-serial@vger.kernel.org>; Wed, 17 Jun 2026 20:06:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781751963; cv=none;
        d=google.com; s=arc-20260327;
        b=IKVGcnBqdsox1KDDh/gjolhlKj9PLDSLedvg3GUE1wRkuPu9AEqfxWoeAR/ROO6Jgk
         qbu8gvXivsud0ntcohq8UIEvynFj5cGKmuohThx7dmRczoIhCsizhccrWsj5DRj/GMW/
         APY+LnqtcFvtIrXh6C+eU3DuRXQiSST5lC3bcDuCDxRMfxlz1qbV9BbS5DOlG3E1Jm4X
         YLwk9x2uePlGNw+6SH02PdyqOzbZPiYYXcvEvNS3KlDVedw1hXqI3kKwyIWSt3c8o1he
         b+RTw3RhHT6+EqnCr0MkehJ9Hx39RkdQqbk1XImXcqWTgq4OfD+8/sb6eA4/eFjn/fKU
         I59Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MuDhO499MU+2PPSIhfdkWixg8e0XSYoAizgkD/hJtd4=;
        fh=r6nrCry9SnIQ4XTZNgG4J/RchSCXL626HEP2FTgaZnM=;
        b=Sk0ioVqHxUpRsMmcjjAh8vanmHmFPbb0J0Ygeh+uWaFgl0qndTW8OIJ5MTNpmeFbvL
         KfgGgiKM5QE9iaUAuICO/vQTVWj0Igvvc23XlEKql4kWv6oPztdvEHpZww+bpzyYO81y
         HPL2ReLlH6GGBYw3r9spJpCSu5Ha8+Gba2u52Iv1TIUQPfgiHdzh9TBqKHoThfm9IjI4
         waAnNotbZDTBMzCTglyL6eUi2xuXOjT7FyIA9l+DG4YRdI3WeFr5oSoLKFNn9bXYrRSA
         dO7+1K1akFD8ffNN0jo1psMqyo7ftfexrXu/3VjmY/mZvBjVQzD3oGECcWzuMPKwc9+W
         hf0Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781751963; x=1782356763; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MuDhO499MU+2PPSIhfdkWixg8e0XSYoAizgkD/hJtd4=;
        b=lBCAOgF3aFVwbVCKChLmuZmaIw+VlLan+mgGxjifRFlnv6/LDvk1SbMXZSk4oQu3rt
         TXXO50SKLrHHFRQDlij1hI85Ka0NUdbbnmL1zW9VSu8CthVp1ZrlLoMrmRCW7GqDc+BR
         AGifkAcA1WkyDyMcAzHdPMONuASNIuUhm2DZ40IQQyJiQIysjWIh22/VF67AnBneQhDB
         bjZMJbQJf++PPvGlK1u+svDyOzGtouBR5XNuf1i9jwmBA/OA36GVQQ6tYKEjVmi2k73I
         WXcjkfL2JgICFKrRezKtISUjEb++gqXd9xcdikh6p2IznRQudu6NP4hoeOMuF54R/vBS
         bfTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781751963; x=1782356763;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MuDhO499MU+2PPSIhfdkWixg8e0XSYoAizgkD/hJtd4=;
        b=ZLKYAph5YMR5YL4tbu4Jo/4FCTp/VfcGL04vMT/9Pk+YNA510BL3vsFwWwh5l/p1gF
         u5pbJUI5dd11dB50U9kX/kCHwW6ethd4C1FYKP9VSrSh8q0Vqu36nZerWS+mgC9MaIOE
         zD1a8aTxYx0kM/1NFBH2U/lUN6Er/92iGECDSuMd5L6P7kY5WoSKgFpDwATQMY+Rvmue
         h4r7UXZpN7uj6tpPVYQxHx8AvcDg0tm4riO/LmwtTDyE02Fk8QceSBjYybO6MkableJG
         kd0h4MIwAeaVsywRsAhvG19xUZ6DzjHBbZOupHUwCIGOibm8eDoK43ikT3S5j522LafT
         f4cA==
X-Forwarded-Encrypted: i=1; AFNElJ+lBNWpK2SNuvYA0QG7EFuky8twFU2bTqtJBd4wnhzpJNcLnhIv+eFGAJhuPHFgTPJjZFZnJgMQw6jKlwA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5ZvrMu9T3sFsjc79b98Z7JtTwEeZ+KQv9G3UgPaxqXloUQMTG
	Kdp1e4ZOfhm6YCUaIf6+k4d6wDVyo6zc1c4NWCvhDgLMI3umSgSyJ7c3GxN9vC6LPWmTNLdlL8u
	x5ETJiCp6ZtNewoKvjGx3nCpQpe4FvfOvdSI5pB2H
X-Gm-Gg: AfdE7cliwUnxz+qmTjginCuY1oPMfLu8nfiz9nNuUjyw3ULbrbAvn2ebz5/v30azLGU
	YkrUv/E3uTNA1yT2TCMhcJcy1WeydASjJfOVvhASJAEy4b7N0gExW1/5+oUumIsS87F57jESkSV
	P+xExbawDVLKbTCPB018GXliI1b5Hutu/akSQ1GxXOOnEBG3xxBPo+xqjo6gVPKKeUZ/O2hjvei
	ziRc9VLzg7QAuqfNyveVoJx8CVnVldwSOdnOYPtkqn3R0JpxamflTSJ3Fw47nfBE99UeMjJUOMg
	NdJeBFKPbUlqAp8qBWMFUnNLq7Y=
X-Received: by 2002:a05:6512:acc:b0:5aa:8842:2420 with SMTP id
 2adb3069b0e04-5ad4eea1b8fmr65032e87.13.1781751962820; Wed, 17 Jun 2026
 20:06:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2026061659-enjoyer-boogeyman-25c0@gregkh> <20260616100121.548759-1-himanshubatra@google.com>
 <c040d167-8747-43f7-ac30-2f5c5bcfbc02@acm.org>
In-Reply-To: <c040d167-8747-43f7-ac30-2f5c5bcfbc02@acm.org>
From: Himanshu Batra <himanshubatra@google.com>
Date: Thu, 18 Jun 2026 08:35:51 +0530
X-Gm-Features: AVVi8CcSKL0KXs9JB7ChTXdSYXke5gD27GwHmkdssl-qtb3Vm2jqmaifmUoOFSw
Message-ID: <CAEif7DQFd4e6u0C4GWxFbrMYdFRjm-Tz0Sf0OTP3qB5aWek83w@mail.gmail.com>
Subject: Re: [PATCH v3] scsi: ufs: sysfs: Add HS_GEAR6 string in
 power_info/gear sysfs output
To: Bart Van Assche <bvanassche@acm.org>
Cc: Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, linux-scsi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	vamshigajjela@google.com, manugautam@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 16, 2026 at 7:07=E2=80=AFPM Bart Van Assche <bvanassche@acm.org=
> wrote:
>
> On 6/16/26 3:01 AM, Himanshu Batra wrote:
> > In power_info/gear sysfs, currently it supports output only till gear 5=
.
> > If operating mode is gear 6, it outputs "UNKNOWN".
> > Add support for HS_GEAR6 string in sysfs output when operating mode
> > is gear 6.
>
> Some general advice:
> - New versions of a patch should be posted as a new email thread instead
>    of as a reply to an existing email conversation. Replies to an
>    existing email conversation tend to get overlooked.
> - At least 24 hours should elapse before a new version of a patch is
>    posted. Otherwise reviewers who are in another time zone don't have
>    the chance to reply. For large patch series, more time should elapse
>    between reposts (e.g. one week).
> - The "scsi:" prefix is no longer used for UFS kernel patches.

Acked, I will follow this for future contributions.

>
> Since the code changes look good to me:
>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
>
